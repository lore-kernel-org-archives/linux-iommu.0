Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46725C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 16:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C680980D62;
	Tue, 23 Nov 2021 16:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZ_PCoQgw8GI; Tue, 23 Nov 2021 16:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F3F180D35;
	Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77BF7C001E;
	Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C23C1C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A308180D35
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tdmvh46aUIH for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 16:10:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0544B80CFC
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637683849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FbxeuNxQjB5QvjUW3b2rknZ2oE0ll1NcLAESvVNT8zU=;
 b=APYS+mT8lRSzyl//+hCQg1IPO8mJJneVElYnYQMxlanBy7NvfJ1/555uhzOPZC9oePlG1w
 T2qGp9gNRxNGKldcbywp6bB5weL5x2TroEHSM/x1bAMb+CHgfsTgYwoKqtmjc6B1wA6q4i
 t8ZAeNTQPQ38xR1P1EVUM/JD42yfewc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-gCOwqdwfMr-Sai7Omlkv_g-1; Tue, 23 Nov 2021 11:10:45 -0500
X-MC-Unique: gCOwqdwfMr-Sai7Omlkv_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A98801B26;
 Tue, 23 Nov 2021 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC76260843;
 Tue, 23 Nov 2021 16:10:39 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Date: Tue, 23 Nov 2021 18:10:33 +0200
Message-Id: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 "open list:AMD IOMMU AMD-VI" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

As I sadly found out, a s3 cycle makes the AMD's iommu stop sending interrupts
until the system is rebooted.

I only noticed it now because otherwise the IOMMU works, and these interrupts
are only used for errors and for GA log which I tend not to use by
making my VMs do mwait/pause/etc in guest (cpu-pm=on).

There are two issues here that prevent interrupts from being generated after
s3 cycle:

1. GA log base address was not restored after resume, and was all zeroed
after resume (by BIOS or such).

In theory if BIOS writes some junk to it, that can even cause a memory corruption.
Patch 2 fixes that.

2. INTX (aka x2apic mode) settings were not restored after resume.
That mode is used regardless if the host uses/supports x2apic, but rather when
the IOMMU supports it, and mine does.
Patches 3-4 fix that.

Note that there is still one slight (userspace) bug remaining:
During suspend all but the boot CPU are offlined and then after resume
are onlined again.

The offlining moves all non-affinity managed interrupts to CPU0, and
later when all other CPUs are onlined, there is nothing in the kernel
to spread back the interrupts over the cores.

The userspace 'irqbalance' daemon does fix this but it seems to ignore
the IOMMU interrupts in INTX mode since they are not attached to any
PCI device, and thus they remain on CPU0 after a s3 cycle,
which is suboptimal when the system has multiple IOMMUs
(mine has 4 of them).

Setting the IRQ affinity manually via /proc/irq/ does work.

This was tested on my 3970X with both INTX and regular MSI mode (later was enabled
by patching out INTX detection), by running a guest with AVIC enabled and with
a PCI assigned device (network card), and observing interrupts from
IOMMU while guest is mostly idle.

This was also tested on my AMD laptop with 4650U (which has the same issue)
(I tested only INTX mode)

Patch 1 is a small refactoring to remove an unused struct field.

Best regards,
   Maxim Levitsky

Maxim Levitsky (5):
  iommu/amd: restore GA log/tail pointer on host resume
  iommu/amd: x2apic mode: re-enable after resume
  iommu/amd: x2apic mode: setup the INTX registers on mask/unmask
  iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume
  iommu/amd: remove useless irq affinity notifier

 drivers/iommu/amd/amd_iommu_types.h |   2 -
 drivers/iommu/amd/init.c            | 107 +++++++++++++++-------------
 2 files changed, 58 insertions(+), 51 deletions(-)

-- 
2.26.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
