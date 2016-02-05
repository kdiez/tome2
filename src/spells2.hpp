#pragma once

#include "h-basic.h"
#include "identify_mode.hpp"
#include "object_filter.hpp"
#include "object_type_fwd.hpp"

extern void curse_artifact(object_type * o_ptr);
extern void grow_things(s16b type, int rad);
extern void grow_grass(int rad);
extern void grow_trees(int rad);
extern bool_ hp_player(int num);
extern bool_ heal_insanity(int val);
extern void warding_glyph(void);
extern void explosive_rune(void);
extern bool_ do_dec_stat(int stat, int mode);
extern bool_ do_res_stat(int stat, bool_ full);
extern bool_ do_inc_stat(int stat);
extern void identify_hooks(int i, object_type *o_ptr, identify_mode type);
extern bool_ identify_pack(void);
extern void identify_pack_fully(void);
extern bool_ remove_curse(void);
extern bool_ remove_all_curse(void);
extern bool_ restore_level(void);
extern void self_knowledge(FILE *fff);
extern bool_ lose_all_info(void);
extern bool_ detect_traps(int rad);
extern bool_ detect_doors(int rad);
extern bool_ detect_stairs(int rad);
extern bool_ detect_treasure(int rad);
extern bool detect_objects_gold(int rad);
extern bool detect_objects_normal(int rad);
extern bool_ detect_monsters_normal(int rad);
extern bool_ detect_monsters_invis(int rad);
extern bool_ detect_monsters_xxx(u32b match_flag, int rad);
extern bool_ detect_all(int rad);
extern void stair_creation(void);
extern bool_ wall_stone(int y, int x);
extern bool_ enchant(object_type *o_ptr, int n, int eflag);
extern bool_ enchant_spell(int num_hit, int num_dam, int num_ac, int num_pval);
extern bool_ ident_spell(void);
extern bool_ ident_all(void);
extern bool_ identify_fully(void);
extern bool_ recharge(int num);
extern void aggravate_monsters(int who);
extern bool_ genocide_aux(bool_ player_cast, char typ);
extern bool_ genocide(bool_ player_cast);
extern bool_ mass_genocide(bool_ player_cast);
extern void do_probe(int m_idx);
extern bool_ probing(void);
extern void change_wild_mode(void);
extern bool_ banish_evil(int dist);
extern bool_ dispel_evil(int dam);
extern bool_ dispel_good(int dam);
extern bool_ dispel_undead(int dam);
extern bool_ dispel_monsters(int dam);
extern void destroy_area(int y1, int x1, int r);
extern void earthquake(int cy, int cx, int r);
extern void lite_room(int y1, int x1);
extern void unlite_room(int y1, int x1);
extern bool_ lite_area(int dam, int rad);
extern bool_ unlite_area(int dam, int rad);
extern bool_ fire_cloud(int typ, int dir, int dam, int rad, int time);
extern bool_ fire_wave(int typ, int dir, int dam, int rad, int time, s32b eff);
extern bool_ fire_wall(int typ, int dir, int dam, int time);
extern bool_ fire_ball(int typ, int dir, int dam, int rad);
extern bool_ fire_bolt(int typ, int dir, int dam);
extern bool_ fire_beam(int typ, int dir, int dam);
extern void call_chaos(void);
extern bool_ fire_bolt_or_beam(int prob, int typ, int dir, int dam);
extern bool_ lite_line(int dir);
extern bool_ drain_life(int dir, int dam);
extern bool_ wall_to_mud(int dir);
extern bool_ disarm_trap(int dir);
extern bool_ wizard_lock(int dir);
extern bool_ slow_monster(int dir);
extern bool_ sleep_monster(int dir);
extern bool_ confuse_monster(int dir, int plev);
extern bool_ fear_monster(int dir, int plev);
extern bool_ poly_monster(int dir);
extern bool_ teleport_monster(int dir);
extern bool_ trap_creation(void);
extern bool_ destroy_doors_touch(void);
extern bool_ destroy_traps_touch(void);
extern bool_ sleep_monsters_touch(void);
extern bool_ alchemy(void);
extern void activate_ty_curse(void);
extern void activate_dg_curse(void);
extern void summon_cyber(void);
extern bool_ confuse_monsters(int dam);
extern bool_ charm_monsters(int dam);
extern bool_ charm_animals(int dam);
extern bool_ stun_monsters(int dam);
extern bool_ banish_monsters(int dist);
extern bool_ turn_monsters(int dam);
extern bool_ charm_monster(int dir, int plev);
extern bool_ control_one_undead(int dir, int plev);
extern bool_ charm_animal(int dir, int plev);
extern bool_ mindblast_monsters(int dam);
extern void alter_reality(void);
extern void report_magics(void);
extern void teleport_swap(int dir);
extern void swap_position(int lty, int ltx);
extern object_filter_t const &item_tester_hook_recharge();
extern bool_ project_hack(int typ, int dam);
extern void project_meteor(int radius, int typ, int dam, u32b flg);
extern object_filter_t const &item_tester_hook_artifactable();
extern bool_ passwall(int dir, bool_ safe);
extern bool_ project_hook(int typ, int dir, int dam, int flg);
extern bool_ reset_recall(bool_ no_trepas_max_depth);
extern void geomancy_random_wall(int y, int x);
extern void geomancy_random_floor(int y, int x, bool_ kill_wall);
extern void geomancy_dig(int oy, int ox, int dir, int length);
extern void channel_the_elements(int y, int x, int level);
extern void random_resistance (object_type * o_ptr, bool_ is_scroll, int specific);