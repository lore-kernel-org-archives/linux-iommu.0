From: Brian Rak <brak-4QcKpDfc+ZsswetKESUqMA@public.gmane.org>
Subject: Crash/hang in iommu_flush_dev_iotlb
Date: Fri, 28 Oct 2016 11:29:45 -0400
Message-ID: <4aaeb6a2-2b39-c5fc-126f-df3ce9a7a65d@gameservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We've been seeing a pretty frequent crash/hang that seems to be pointing 
at the Intel IOMMU code.

This manifests in one of two ways:

1) Kernel reports a BUG, then the system hangs
2) Kernel reports a BUG, then the kernel notices something else terrible 
has occurred, and triggers a reboot.

Examples of "other" terrible things we've seen:

Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast 
exception handler
Kernel panic - not syncing: Hard LOCKUP
Kernel panic - not syncing: Attempted to kill the idle task!
Kernel panic - not syncing: Fatal exception in interrupt

This is an example of a stack trace we're seeing:

2016-10-28 11:04:15     BUG: unable to handle kernel 2016-10-28 
11:04:15        NULL pointer dereference2016-10-28 11:04:15      at 
0000000000000304
2016-10-28 11:04:15     IP:2016-10-28 11:04:15 [<ffffffff81476d51>] 
iommu_flush_dev_iotlb+0x21/0xc0
2016-10-28 11:04:15     PGD 0 2016-10-28 11:04:15
2016-10-28 11:04:15     Oops: 0000 [#1] SMP
2016-10-28 11:04:15     Modules linked in:2016-10-28 11:04:15 
vxlan2016-10-28 11:04:15        udp_tunnel2016-10-28 11:04:15 
ip6_udp_tunnel2016-10-28 11:04:15       ip6t_rpfilter2016-10-28 
11:04:15        ipt_rpfilter2016-10-28 11:04:15 ts_bm2016-10-28 
11:04:15        xt_string2016-10-28 11:04:15 ip6table_mangle2016-10-28 
11:04:15      ebt_arp2016-10-28 11:04:15      ebtable_nat2016-10-28 
11:04:15  ebtables2016-10-28 11:04:15     netconsole2016-10-28 
11:04:15   configfs2016-10-28 11:04:15     sch_fq_codel2016-10-28 
11:04:15 vhost_net2016-10-28 11:04:15    macvtap2016-10-28 11:04:15 
macvlan2016-10-28 11:04:15      vhost2016-10-28 11:04:15 tun2016-10-28 
11:04:15  kvm_intel2016-10-28 11:04:15 kvm2016-10-28 11:04:15  
irqbypass2016-10-28 11:04:15 8021q2016-10-28 11:04:15        
garp2016-10-28 11:04:15 dummy2016-10-28 11:04:15
         xt_CHECKSUM2016-10-28 11:04:15  iptable_mangle2016-10-28 
11:04:15       ipt_REJECT2016-10-28 11:04:15 nf_reject_ipv42016-10-28 
11:04:15       iptable_filter2016-10-28 11:04:15       
ip_tables2016-10-28 11:04:15    xt_comment2016-10-28 11:04:15   
ip6t_REJECT2016-10-28 11:04:15  nf_reject_ipv62016-10-28 11:04:15       
ip6table_filter2016-10-28 11:04:15 ip6_tables2016-10-28 11:04:15   
joydev2016-10-28 11:04:15 input_leds2016-10-28 11:04:15   
mlx4_ib2016-10-28 11:04:15 ib_core2016-10-28 11:04:15      
mlx4_en2016-10-28 11:04:15 mlx4_core2016-10-28 11:04:15    
ip_set2016-10-28 11:04:15 nfnetlink2016-10-28 11:04:15    
bcache2016-10-28 11:04:15 iTCO_wdt2016-10-28 11:04:15     
iTCO_vendor_support2016-10-28 11:04:15  pcspkr2016-10-28 11:04:15       
ixgbe2016-10-28 11:04:15        mdio2016-10-28 11:04:15         
sg2016-10-28 11:04:15   i2c_i8012016-10-28 11:04:15     
lpc_ich2016-10-28 11:04:15      shpchp2016-10-28 11:04:15       
xhci_pci2016-10-28 11:04:15     xhci_hcd2016-10-28 11:04:15     
ioatdma2016-10-28 11:04:15      igb2016-10-28 11:04:15  dca2016-10-28 
11:04:15 ptp2016-10-28 11:04:15  pps_core2016-10-28 11:04:15 
fjes2016-10-28 11:04:15         ipmi_devintf2016-10-28 11:04:15         
ipmi_si2016-10-28 11:04:15 ipmi_msghandler2016-10-28 11:04:15      
acpi_power_meter2016-10-28 11:04:15     hwmon2016-10-28 11:04:15        
ext42016-10-28 11:04:15         mbcache2016-10-28 11:04:15      
jbd22016-10-28 11:04:15         raid12016-10-28 11:04:15        
sd_mod2016-10-28 11:04:15       ahci2016-10-28 11:04:15         
libahci2016-10-28 11:04:15      wmi2016-10-28 11:04:15  ast2016-10-28 
11:04:15 ttm2016-10-28 11:04:15  dm_mirror2016-10-28 11:04:15 
dm_region_hash2016-10-28 11:04:15       dm_log2016-10-28 11:04:15       
dm_mod2016-10-28 11:04:15
2016-10-28 11:04:15     CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.7.2-1.el6.elrepo.x86_64 #1
2016-10-28 11:04:15     Hardware name: Supermicro 
SYS-2U4NODES-03-CL011/X10DRT-P, BIOS 2.0 12/18/2015
2016-10-28 11:04:15     task: ffffffff81c0d540 ti: ffffffff81c00000 
task.ti: ffffffff81c00000
2016-10-28 11:04:15     RIP: 0010:[<ffffffff81476d51>] 2016-10-28 
11:04:15       [<ffffffff81476d51>] iommu_flush_dev_iotlb+0x21/0xc0
2016-10-28 11:04:15     RSP: 0018:ffff881fff803cb8  EFLAGS: 00010086
2016-10-28 11:04:15     RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
ffff883ff2a05400
2016-10-28 11:04:15     RDX: 000000000000003f RSI: 0000000000001000 RDI: 
0000000000000000
2016-10-28 11:04:15     RBP: ffff881fff803ce8 R08: 0000000000000010 R09: 
0000000000000040
2016-10-28 11:04:15     R10: 0000000000000000 R11: 0000000200000025 R12: 
ffff881fef301f48
2016-10-28 11:04:15     R13: 00000000000ff83a R14: 0000000000000000 R15: 
ffff883feb4db500
2016-10-28 11:04:15     FS:  0000000000000000(0000) 
GS:ffff881fff800000(0000) knlGS:0000000000000000
2016-10-28 11:04:15     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2016-10-28 11:04:15     CR2: 0000000000000304 CR3: 0000003efbaff000 CR4: 
00000000003426f0
2016-10-28 11:04:15     Stack:
2016-10-28 11:04:15      ffff883feb4db5002016-10-28 11:04:15 
00000000000000002016-10-28 11:04:15     ffff881fef301f482016-10-28 
11:04:15     00000000000ff83a2016-10-28 11:04:15
2016-10-28 11:04:15      00000000000000002016-10-28 11:04:15 
ffff883feb4db5002016-10-28 11:04:15     ffff881fff803d482016-10-28 
11:04:15     ffffffff8147702c2016-10-28 11:04:15
2016-10-28 11:04:15      00000000000000012016-10-28 11:04:15 
ffff881fff813b002016-10-28 11:04:15     00000001ff803d082016-10-28 
11:04:15     ffff883ff2a054002016-10-28 11:04:15
2016-10-28 11:04:15     Call Trace:
2016-10-28 11:04:15      <IRQ> 2016-10-28 11:04:15
2016-10-28 11:04:15      [<ffffffff8147702c>] flush_unmaps+0xac/0x190
2016-10-28 11:04:15      [<ffffffff81477148>] flush_unmaps_timeout+0x38/0x50
2016-10-28 11:04:15      [<ffffffff81477110>] ? flush_unmaps+0x190/0x190
2016-10-28 11:04:15      [<ffffffff810ee56a>] call_timer_fn+0x4a/0x160
2016-10-28 11:04:15      [<ffffffff8133d839>] ? timerqueue_add+0x59/0xb0
2016-10-28 11:04:15      [<ffffffff810ef67e>] run_timer_softirq+0x26e/0x300
2016-10-28 11:04:15      [<ffffffff81477110>] ? flush_unmaps+0x190/0x190
2016-10-28 11:04:15      [<ffffffff810edfec>] ? 
get_next_timer_interrupt+0xcc/0x210
2016-10-28 11:04:15      [<ffffffff810dc69d>] ? 
handle_irq_event_percpu+0xbd/0x200
2016-10-28 11:04:15      [<ffffffff810f799c>] ? ktime_get+0x4c/0xc0
2016-10-28 11:04:15      [<ffffffff81778b41>] __do_softirq+0xf1/0x2e4
2016-10-28 11:04:15      [<ffffffff810f10d8>] ? hrtimer_interrupt+0xb8/0x170
2016-10-28 11:04:15      [<ffffffff81085fb6>] irq_exit+0xa6/0xb0
2016-10-28 11:04:15      [<ffffffff81778936>] 
smp_apic_timer_interrupt+0x46/0x60
2016-10-28 11:04:15      [<ffffffff81776c32>] apic_timer_interrupt+0x82/0x90
2016-10-28 11:04:15      <EOI> 2016-10-28 11:04:15
2016-10-28 11:04:15      [<ffffffff810623b6>] ? native_safe_halt+0x6/0x10
2016-10-28 11:04:15      [<ffffffff8103921a>] default_idle+0x2a/0xf0
2016-10-28 11:04:15      [<ffffffff81037379>] ? sched_clock+0x9/0x10
2016-10-28 11:04:15      [<ffffffff810b1dd5>] ? sched_clock_cpu+0xb5/0xc0
2016-10-28 11:04:15      [<ffffffff81038adf>] arch_cpu_idle+0xf/0x20
2016-10-28 11:04:15      [<ffffffff810c4cde>] default_idle_call+0x2e/0x40
2016-10-28 11:04:15      [<ffffffff810c4e35>] cpuidle_idle_call+0xa5/0x120
2016-10-28 11:04:15      [<ffffffff810c5008>] cpu_idle_loop+0x158/0x240
2016-10-28 11:04:15      [<ffffffff81d7c117>] ? 
early_idt_handler_array+0x117/0x120
2016-10-28 11:04:15      [<ffffffff810c510e>] ? cpu_startup_entry+0x1e/0x70
2016-10-28 11:04:15      [<ffffffff8145388b>] ? get_random_bytes+0x4b/0xb0
2016-10-28 11:04:15      [<ffffffff81d7c117>] ? 
early_idt_handler_array+0x117/0x120
2016-10-28 11:04:15      [<ffffffff810c5157>] cpu_startup_entry+0x67/0x70
2016-10-28 11:04:15      [<ffffffff81769ad7>] rest_init+0x77/0x80
2016-10-28 11:04:15      [<ffffffff81d7d440>] start_kernel+0x3f3/0x3f5
2016-10-28 11:04:15      [<ffffffff81d7ce6f>] ? set_init_arg+0x5e/0x5e
2016-10-28 11:04:15      [<ffffffff81d7c398>] 
x86_64_start_reservations+0x2f/0x31
2016-10-28 11:04:15      [<ffffffff81d7c6ef>] 
x86_64_start_kernel+0x14d/0x15c
2016-10-28 11:04:15     Code: 2016-10-28 11:04:15       66 2016-10-28 
11:04:15  2e 2016-10-28 11:04:15  0f 2016-10-28 11:04:15 1f 2016-10-28 
11:04:15  84 2016-10-28 11:04:15  00 2016-10-28 11:04:15  00 2016-10-28 
11:04:15  00 2016-10-28 11:04:15  00 2016-10-28 11:04:15  00 2016-10-28 
11:04:15  55 2016-10-28 11:04:15 48 2016-10-28 11:04:15  89 2016-10-28 
11:04:15  e5 2016-10-28 11:04:15  48 2016-10-28 11:04:15  83 2016-10-28 
11:04:15  ec 2016-10-28 11:04:15  30 2016-10-28 11:04:15  48 2016-10-28 
11:04:15 89 2016-10-28 11:04:15  5d 2016-10-28 11:04:15  d8 2016-10-28 
11:04:15  4c 2016-10-28 11:04:15  89 2016-10-28 11:04:15  65 2016-10-28 
11:04:15  e0 2016-10-28 11:04:15  4c 2016-10-28 11:04:15 89 2016-10-28 
11:04:15  6d


I should note that the '0000000000000304' address is fairly consistent, 
it's so far always been one of 304 or 8f8, across ~100 crashes.

Unfortunately, we haven't been able to come up with good reproduction 
steps.  So far, we're mainly seeing the issue on machines with Intel 
E5-2640 v4 CPUs (though it has occasionally happened on E5-2630 v3 CPUs).

We're seeing this on around 50 different machines.  We've tried swapping 
out the memory on a few of them, and the issue has persisted.

Any suggestions here?
