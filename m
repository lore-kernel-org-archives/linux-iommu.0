Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60402C46470
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:03:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E001216E3
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E001216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2CA15E5C;
	Tue, 14 May 2019 14:03:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C45AEACC
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D5F8883A
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:02:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2019 07:02:56 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:55 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [RFC PATCH v3 00/21] Implement an HPET-based hardlockup detector
Date: Tue, 14 May 2019 07:01:53 -0700
Message-Id: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
	Andi Kleen <andi.kleen@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

This is the third attempt to demonstrate the implementation of a
hardlockup detector driven by the High-Precision Event Timer. The two
initial implementations can be found here [1] and here [2].

== Introduction ==

In CPU architectures that do not have an NMI watchdog, one can be
constructed using a counter of the Performance Monitoring Unit (PMU).
Counters in the PMU have high granularity and high visibility of the CPU.
These capabilities and their limited number make these counters precious
resources. Unfortunately, the perf-based hardlockup detector permanently
consumes one of these counters per CPU.

These counters could be freed for profiling purposes if the hardlockup
detector were driven by another timer.

The hardlockup detector runs relatively infrequently and does not require
visibility of the CPU activity (in addition to detect locked-up CPUs). A
timer that is external to the CPU (e.g., in the chipset) can be used to
drive the detector.

A key requirement is that the timer needs to be capable of issuing a
non-maskable interrupt to the CPU. In most cases, this can be achieved
by tweaking the delivery mode of the interrupt. It is especially
straightforward for MSI interrupts.

== Details of this implementation

This implementation uses an HPET timer to deliver an NMI interrupt via
an MSI message.

Unlike the the perf-based hardlockup detector, this implementation is
driven by a single timer. The timer targets one CPU at a time in a round-
robin manner. This means that if a CPU must be monitored every watch_thresh
seconds, in a system with N monitored CPUs the timer must expire every
watch_thresh/N. A timer expiration per CPU attribute is maintained.

The timer expiration time per CPU is updated every time CPUs are put
online or offline (a CPU hotplug thread enables and disables the watchdog
in these events) or the user changes the file /proc/sys/kernel/
watchdog_cpumask.

Also, given that a single timer drives the detector, a cpumask is needed
to keep track of which online CPUs are allowed to be monitored. This mask
is also updated every time a CPU is put online or offline or when the user
modifies the mask in /proc/sys/kernel/watchdog_cpumask. This mask
is needed to keep the current behavior of the lockup detector.

In order to avoid reading HPET registers in every NMI, the time-stamp
counter is used to determine whether the HPET caused the interrupt. At
every timer expiration, we compute the value the time-stamp counter is
expected to have the next time the timer expires. I have found
experimentally that expected TSC value consistently has an error of less
than 1.5%

Furthermore, only one write to HPET registers is done every
watchdog_thresh seconds. This write can be eliminated if the HPET timer
is periodic.

== Parts of this series ==

For clarity, patches are grouped as follows:

 1) New irq definition. Patch 1 adds a definition for NMI delivery mode
    in MSI interrupts. No other changes are done to generic irq code.

 2) HPET updates. Patches 2-7 prepare the HPET code to accommodate the
    new detector: rework periodic programming, reserve and configure a
    timer for the detector and expose a few existing functions.

 3) NMI watchdog. Patches 8-11 updates the existing hardlockup detector
    to uncouple it from perf, switch back to the perf implementation if
    TSC becomes unstable, and introduce a new NMI handler category
    intended to run after the NMI_LOCAL handlers.

 4) New HPET-based hardlockup detector. Patches 12-17 includes changes to
    probe the hardware resources, configure the interrupt and rotate the
    destination of the interrupts among all monitored CPUs. Also, it
    includes an x86-specific shim hardlockup detector that selects
    between HPET and perf implementations.
	
 5) Interrupt remapping. Patches 18-22 add support to operate this new
    detector with interrupt remapping enabled.

Thanks and BR,
Ricardo

Changes since v2:
 * Added functionality to switch to the perf-based hardlockup
   detector if the TSC becomes unstable (Thomas Gleixner).
 * Brought back the round-robin mechanism proposed in v1 (this time not
   using the interrupt subsystem). This also requires to compute
   expiration times as in v1 (Andi Kleen, Stephane Eranian).
 * Fixed a bug in which using a periodic timer was not working(thanks
   to Suravee Suthikulpanit!).
 * In this version, I incorporate support for interrupt remapping in the
   last 4 patches so that they can be reviewed separately if needed.
 * Removed redundant documentation of functions (Thomas Gleixner).
 * Added a new category of NMI handler, NMI_WATCHDOG, which executes after
   NMI_LOCAL handlers (Andi Kleen).
 * Updated handling of "nmi_watchdog" to support comma-separated
   arguments.
 * Undid split of the generic hardlockup detector into a separate file
   (Thomas Gleixner).
 * Added a new intermediate symbol CONFIG_HARDLOCKUP_DETECTOR_CORE to
   select generic parts of the detector (Paul E. McKenney,
   Thomas Gleixner).
 * Removed use of struct cpumask in favor of a variable length array in
   conjunction with kzalloc (Peter Zijlstra).
 * Added CPU as argument hardlockup_detector_hpet_enable()/disable()
   (Thomas Gleixner).
 * Remove unnecessary export of function declarations, flags and bit
   fields (Thomas Gleixner).
 * Removed  unnecessary check for FSB support when reserving timer for the
   detector (Thomas Gleixner).
 * Separated TSC code from HPET code in kick_timer() (Thomas Gleixner).
 * Reworked condition to check if the expected TSC value is within the
   error margin to avoid conditional (Peter Zijlstra).
 * Removed TSC error margin from struct hld_data; use global variable
   instead (Peter Zijlstra).
 * Removed previously introduced watchdog_get_allowed_cpumask*() and
   reworked hardlockup_detector_hpet_enable()/disable() to not need
   access to watchdog_allowed_mask (Thomas Gleixner).

Changes since v1:

 * Removed reads to HPET registers at every NMI. Instead use the time-stamp
   counter to infer the interrupt source (Thomas Gleixner, Andi Kleen).
 * Do not target CPUs in a round-robin manner. Instead, the HPET timer
   always targets the same CPU; other CPUs are monitored via an
   interprocessor interrupt.
 * Removed use of generic irq code to set interrupt affinity and NMI
   delivery. Instead, configure the interrupt directly in HPET registers
   (Thomas Gleixner).
 * Removed the proposed ops structure for NMI watchdogs. Instead, split
   the existing implementation into a generic library and perf-specific
   infrastructure (Thomas Gleixner, Nicholas Piggin).
 * Added an x86-specific shim hardlockup detector that selects between
   HPET and perf infrastructures as needed (Nicholas Piggin).
 * Removed locks taken in NMI and !NMI context. This was wrong and is no
   longer needed (Thomas Gleixner).
 * Fixed unconditonal return NMI_HANDLED when the HPET timer is programmed
   for FSB/MSI delivery (Peter Zijlstra).

References:

[1]. https://lkml.org/lkml/2018/6/12/1027
[2]. https://lkml.org/lkml/2019/2/27/402


Ricardo Neri (21):
  x86/msi: Add definition for NMI delivery mode
  x86/hpet: Expose hpet_writel() in header
  x86/hpet: Calculate ticks-per-second in a separate function
  x86/hpet: Add hpet_set_comparator() for periodic and one-shot modes
  x86/hpet: Reserve timer for the HPET hardlockup detector
  x86/hpet: Configure the timer used by the hardlockup detector
  watchdog/hardlockup: Define a generic function to detect hardlockups
  watchdog/hardlockup: Decouple the hardlockup detector from perf
  x86/nmi: Add a NMI_WATCHDOG NMI handler category
  watchdog/hardlockup: Add function to enable NMI watchdog on all
    allowed CPUs at once
  x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
  watchdog/hardlockup/hpet: Adjust timer expiration on the number of
    monitored CPUs
  x86/watchdog/hardlockup/hpet: Determine if HPET timer caused NMI
  watchdog/hardlockup: Use parse_option_str() to handle "nmi_watchdog"
  watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot
    parameter
  x86/watchdog: Add a shim hardlockup detector
  x86/tsc: Switch to perf-based hardlockup detector if TSC become
    unstable
  x86/apic: Add a parameter for the APIC delivery mode
  iommu/vt-d: Rework prepare_irte() to support per-irq delivery mode
  iommu/vt-d: hpet: Reserve an interrupt remampping table entry for
    watchdog
  x86/watchdog/hardlockup/hpet: Support interrupt remapping

 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/x86/Kconfig.debug                        |  15 +
 arch/x86/include/asm/hpet.h                   |  47 ++
 arch/x86/include/asm/hw_irq.h                 |   5 +-
 arch/x86/include/asm/msidef.h                 |   4 +
 arch/x86/include/asm/nmi.h                    |   1 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/apic/vector.c                 |  10 +
 arch/x86/kernel/hpet.c                        | 105 +++-
 arch/x86/kernel/nmi.c                         |  10 +
 arch/x86/kernel/tsc.c                         |   2 +
 arch/x86/kernel/watchdog_hld.c                |  85 ++++
 arch/x86/kernel/watchdog_hld_hpet.c           | 452 ++++++++++++++++++
 drivers/char/hpet.c                           |  31 +-
 drivers/iommu/intel_irq_remapping.c           |  59 ++-
 include/linux/hpet.h                          |   1 +
 include/linux/nmi.h                           |   8 +-
 kernel/Makefile                               |   2 +-
 kernel/watchdog.c                             |  23 +-
 kernel/watchdog_hld.c                         |  50 +-
 lib/Kconfig.debug                             |   4 +
 21 files changed, 867 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/kernel/watchdog_hld.c
 create mode 100644 arch/x86/kernel/watchdog_hld_hpet.c

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
