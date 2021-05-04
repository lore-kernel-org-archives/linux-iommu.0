Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C117C433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A452613D8
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 19:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A452613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D542541825;
	Tue,  4 May 2021 19:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qo01isdGFdrT; Tue,  4 May 2021 19:11:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D4D8414FD;
	Tue,  4 May 2021 19:11:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F89BC000D;
	Tue,  4 May 2021 19:11:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869FCC0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 697A7414FF
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFgb4JHakxKe for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 19:11:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A08F414EB
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 19:11:41 +0000 (UTC)
IronPort-SDR: qjVqfI78U2Gg6s4Up31hjl2FVH8sjTHq6Do1+osz8JybcZEwLKVjJcH6TiNBzdyL9qJesctIvI
 4/1mFR0hXySQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="197675479"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="197675479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 12:11:40 -0700
IronPort-SDR: pqfyhjcoUwP+RhjIgOOdDX0iTRL7b0YM4al68SNO5jQQDwvzBL3zQ/QbxYutFTINWforPd5KBO
 T/vWTRF7dwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="396245275"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 12:11:40 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [RFC PATCH v5 0/7] x86: watchdog/hardlockup/hpet: Add support for
 interrupt remapping
Date: Tue,  4 May 2021 12:10:42 -0700
Message-Id: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
 woodhouse@osuosl.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Ricardo Neri <ricardo.neri@intel.com>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
 Ingo Molnar <mingo@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi IOMMU experts,

I proposed a hardlockup detector driven by the HPET timer [1]. Such
detector is driven by a single timer. The hardlockup detector brings the
extra complexity of having to update the affinity of the interrupt
periodically and initiated from NMI context. The proposed design only
requires updating the affinity every watchdog_thresh (the interval is
between [1, 60] seconds). Also, the affinity update is offloaded to
an irq_work. Handling the HPET interrupt affinity is trivial with
!intremap since the detector composes the MSI message and writes it
directly to the HPET registers.

However, for intremap we must use the existing IOMMU drivers as well as
the kernel's irq plumbing. Thomas Gleixner has imposed two restrictions:
  1) Do not implement an IRQF_NMI flag for x86 as it is not possible to
     determine the source of an NMI [2].
  2) Use the irq subsystem to update the affinity of the HPET
     interrupt [3].

1) implies that the interrupt remapping drivers need to implement a quirk
to identify the HPET interrupt and update its delivery mode to NMI. 2)
means that the hardlockup detector must use request_irq() to allocate the
HPET interrupt.

This patch series attempts to meet the requirements above by
  a) Decoupling the delivery mode of an APIC interrupt from the delivery
     mode of the APIC driver (patch 1)
  b) Implement quirks in the Intel and AMD IOMMU drivers to identify the
     HPET timer and update the delivery mode accordingly (patches 2-5).
  c) Add support for interrupt remapping in the HPET hardlockup detector
     in [1]. This includes the unavoidable eyesore of using request_irq()
     and having a useless regular interrupt handler (patch 6).

I would like to get your feedback on whether the HPET NMI quirk looks
sane to you and whether offloading the affinity setup to an irq_work
could pose issues.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com/T/#mf77988cc98f9ca6988831e17f68394577388959d
[2]. https://lore.kernel.org/lkml/alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de/
[3]. https://lore.kernel.org/lkml/alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de/

Changes since v4:
 * With !CONFIG_IRQ_REMAP [1] now disables the HPET channel before changing
   the MSI Destination ID field. This should avoid races between a pending
   interrupt and updating the detector's interrupt affinity. (Ashok)
 * Rebased to use new enumeration apic_delivery_modes.
 * Removed custom functions to allocate an interrupt for the detector
   and instead added support to identify the detector's interrupt and
   change the delivery mode.
 * With interrupt remapping enabled, use request_irq().
 * Added support for AMD IOMMU.

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Introduced support for interrupt remapping

Ricardo Neri (7):
  x86/apic: Add irq_cfg::delivery_mode
  x86/hpet: Introduce function to identify HPET hardlockup detector irq
  iommu/vt-d: Rework prepare_irte() to support per-irq delivery mode
  iommu/amd: Set the IRTE delivery mode from irq_cfg
  iommu/vt-d: Fixup delivery mode of the HPET hardlockup interrupt
  iommu/amd: Fixup delivery mode of the HPET hardlockup interrupt
  x86/watchdog/hardlockup/hpet: Support interrupt remapping

 arch/x86/include/asm/hpet.h         |  5 +++
 arch/x86/include/asm/hw_irq.h       |  1 +
 arch/x86/kernel/apic/vector.c       | 10 ++++++
 arch/x86/kernel/hpet.c              | 36 ++++++++++++++++++++++
 arch/x86/kernel/watchdog_hld_hpet.c | 48 +++++++++++++++++++++++++----
 drivers/iommu/amd/iommu.c           | 11 ++++++-
 drivers/iommu/intel/irq_remapping.c | 20 ++++++++----
 7 files changed, 118 insertions(+), 13 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
