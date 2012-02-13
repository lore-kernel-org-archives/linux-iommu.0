From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bug 42767] New: System unsuable with intel_iommu=on
Date: Mon, 13 Feb 2012 12:51:08 -0800
Message-ID: <20120213125108.6325bb07.akpm@linux-foundation.org>
References: <bug-42767-27@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bug-42767-27-3bo0kxnWaOQUvHkbgXJLS5sdmw4N0Rt+2LY78lusg7I@public.gmane.org/>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ConiKost-Mmb7MZpHnFY@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 13 Feb 2012 20:45:21 GMT
bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=42767
> 
>            Summary: System unsuable with intel_iommu=on
>            Product: Memory Management
>            Version: 2.5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
>         ReportedBy: ConiKost-Mmb7MZpHnFY@public.gmane.org
>         Regression: No
> 
> 
> Hi,
> i've some very strange problems since kernel 3.2.0.
> When I enable the CONFIG_INTEL_IOMMU_DEFAULT_ON, the problems starts.
> 
> OS: Gentoo Linux
> Kernel: Gentoo Sources 3.2.5 (tried also with vanilla 3.2.5)
> Hardware: Thinkpad X200 Tablet
> Bios: 3.20
> 
> The problems are, that my video card fails with 3d rendering (e.g. GNOME3
> crashes) and my network card stops working after using some network i/o. When I
> choose intel_iommu=off, all problems disapear and everything works fine.
> 
> Feb 13 21:24:11 [kernel] [drm:i915_hangcheck_elapsed] *ERROR* Hangcheck timer
> elapsed... GPU hung
> Feb 13 21:24:11 [kernel] render error detected, EIR: 0x00000010
> Feb 13 21:24:11 [kernel]   IPEIR: 0x00000000
> Feb 13 21:24:11 [kernel]   IPEHR: 0x18800180
> Feb 13 21:24:11 [kernel]   INSTDONE: 0xffffffff
> Feb 13 21:24:11 [kernel]   INSTPS: 0x4001e020
> Feb 13 21:24:11 [kernel]   INSTDONE1: 0xbfffffff
> Feb 13 21:24:11 [kernel]   ACTHD: 0x013f0000
> Feb 13 21:24:11 [kernel] page table error
> Feb 13 21:24:11 [kernel]   PGTBL_ER: 0x00100000
> 
> Feb 13 21:25:44 [kernel] DRHD: handling fault status reg 2
> Feb 13 21:25:44 [kernel] DMAR:[DMA Read] Request device [00:19.0] fault addr
> fff84000
> Feb 13 21:25:44 [kernel] DMAR:[fault reason 06] PTE Read access is not set
> Feb 13 21:25:47 [kernel] e1000e 0000:00:19.0: eth0: Detected Hardware Unit
> Hang:
> Feb 13 21:25:47 [kernel]   TDH                  <57>
> Feb 13 21:25:47 [kernel]   TDT                  <68>
> Feb 13 21:25:47 [kernel]   next_to_use          <68>
> Feb 13 21:25:47 [kernel]   next_to_clean        <56>
> Feb 13 21:25:47 [kernel] buffer_info[next_to_clean]:
> Feb 13 21:25:47 [kernel]   time_stamp           <fffd86c5>
> Feb 13 21:25:47 [kernel]   next_to_watch        <57>
> Feb 13 21:25:47 [kernel]   jiffies              <fffd91c0>
> Feb 13 21:25:47 [kernel]   next_to_watch.status <0>
> Feb 13 21:25:47 [kernel] MAC Status             <80383>
> Feb 13 21:25:47 [kernel] PHY Status             <796d>
> Feb 13 21:25:47 [kernel] PHY 1000BASE-T Status  <3c00>
> Feb 13 21:25:47 [kernel] PHY Extended Status    <3000>
> Feb 13 21:25:47 [kernel] PCI Status             <10>
> Feb 13 21:25:48 [kernel] fbcondecor: switched decor state to 'off' on console 0
> Feb 13 21:25:48 [kernel] fbcondecor: console 0 using theme
> 'battlestar-galactica'
> Feb 13 21:25:48 [kernel] fbcondecor: switched decor state to 'on' on console 0
> Feb 13 21:25:49 [kernel] e1000e 0000:00:19.0: eth0: Detected Hardware Unit
> Hang:
> Feb 13 21:25:49 [kernel]   TDH                  <57>
> Feb 13 21:25:49 [kernel]   TDT                  <68>
> Feb 13 21:25:49 [kernel]   next_to_use          <68>
> Feb 13 21:25:49 [kernel]   next_to_clean        <56>
> Feb 13 21:25:49 [kernel] buffer_info[next_to_clean]:
> Feb 13 21:25:49 [kernel]   time_stamp           <fffd86c5>
> Feb 13 21:25:49 [kernel]   next_to_watch        <57>
> Feb 13 21:25:49 [kernel]   jiffies              <fffd9990>
> Feb 13 21:25:49 [kernel]   next_to_watch.status <0>
> Feb 13 21:25:49 [kernel] MAC Status             <80383>
> Feb 13 21:25:49 [kernel] PHY Status             <796d>
> Feb 13 21:25:49 [kernel] PHY 1000BASE-T Status  <3c00>
> Feb 13 21:25:49 [kernel] PHY Extended Status    <3000>
> Feb 13 21:25:49 [kernel] PCI Status             <10>
> Feb 13 21:25:51 [kernel] ------------[ cut here ]------------
> Feb 13 21:25:51 [kernel] WARNING: at net/sched/sch_generic.c:255
> dev_watchdog+0x249/0x260()
> Feb 13 21:25:51 [kernel] Hardware name: 7450EQG
> Feb 13 21:25:51 [kernel] NETDEV WATCHDOG: eth0 (e1000e): transmit queue 0 timed
> out
> Feb 13 21:25:51 [kernel] Modules linked in:
> Feb 13 21:25:51 [kernel] Pid: 0, comm: swapper/1 Not tainted 3.2.1-gentoo #1
> Feb 13 21:25:51 [kernel] Call Trace:
> Feb 13 21:25:51 [kernel]  <IRQ>  [<ffffffff810433bb>] ?
> warn_slowpath_common+0x7b/0xc0
> Feb 13 21:25:51 [kernel]  [<ffffffff810434b5>] ? warn_slowpath_fmt+0x45/0x50
> Feb 13 21:25:51 [kernel]  [<ffffffff8104f9dd>] ? mod_timer+0x13d/0x240
> Feb 13 21:25:51 [kernel]  [<ffffffff8156eb99>] ? dev_watchdog+0x249/0x260
> Feb 13 21:25:51 [kernel]  [<ffffffff8104ef7b>] ? cascade+0x7b/0xa0
> Feb 13 21:25:51 [kernel]  [<ffffffff8156e950>] ? qdisc_reset+0x40/0x40
> Feb 13 21:25:51 [kernel]  [<ffffffff8104f0b6>] ? run_timer_softirq+0x116/0x270
> Feb 13 21:25:51 [kernel]  [<ffffffff81049298>] ? __do_softirq+0x98/0x120
> Feb 13 21:25:51 [kernel]  [<ffffffff816c84ac>] ? call_softirq+0x1c/0x30
> Feb 13 21:25:51 [kernel]  [<ffffffff8100469d>] ? do_softirq+0x4d/0x80
> Feb 13 21:25:51 [kernel]  [<ffffffff8104964e>] ? irq_exit+0x8e/0xd0
> Feb 13 21:25:51 [kernel]  [<ffffffff8101be08>] ?
> smp_apic_timer_interrupt+0x68/0xa0
> Feb 13 21:25:51 [kernel]  [<ffffffff816c7c0b>] ? apic_timer_interrupt+0x6b/0x70
> Feb 13 21:25:51 [kernel]  <EOI>  [<ffffffff8134225d>] ?
> acpi_idle_enter_bm+0x214/0x252
> Feb 13 21:25:51 [kernel]  [<ffffffff81342258>] ? acpi_idle_enter_bm+0x20f/0x252
> Feb 13 21:25:51 [kernel]  [<ffffffff814c2c4a>] ? cpuidle_idle_call+0x8a/0xf0
> Feb 13 21:25:51 [kernel]  [<ffffffff810011df>] ? cpu_idle+0xbf/0x110
> Feb 13 21:25:51 [kernel]  [<ffffffff816b7cc9>] ? start_secondary+0x1f5/0x1fb
> Feb 13 21:25:51 [kernel] ---[ end trace 71e047540e69b903 ]---
> Feb 13 21:25:51 [kernel] e1000e 0000:00:19.0: eth0: Reset adapter
> 
