Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B9DC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 14:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79FE88336D;
	Wed,  6 Apr 2022 14:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1llpcMNzrvwV; Wed,  6 Apr 2022 14:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0804F832C2;
	Wed,  6 Apr 2022 14:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B03F8C0083;
	Wed,  6 Apr 2022 14:03:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 097D0C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB7E240384
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEJTVEiCzpGH for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:42:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFEEF4035A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 08:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.codelabs.ch (Postfix) with ESMTP id E096F220002;
 Wed,  6 Apr 2022 10:37:03 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wm3KiR0YfLUt; Wed,  6 Apr 2022 10:37:02 +0200 (CEST)
Received: from skyhawk.codelabs.local (unknown
 [IPv6:2a02:169:803:0:f7fb:8040:b3e4:bffe])
 by mail.codelabs.ch (Postfix) with ESMTPSA id A7A93220001;
 Wed,  6 Apr 2022 10:37:02 +0200 (CEST)
From: Reto Buerki <reet@codelabs.ch>
To: dwmw2@infradead.org
Subject: Re: [PATCH v3 12/35] x86/msi: Provide msi message shadow structs
Date: Wed,  6 Apr 2022 10:36:23 +0200
Message-Id: <20220406083624.38739-1-reet@codelabs.ch>
In-Reply-To: 20201024213535.443185-13-dwmw2@infradead.org
References: <20201024213535.443185-13-dwmw2@infradead.org>
MIME-Version: 1.0
GIT: Lines beginning in "GIT:" will be removed.
GIT: Consider including an overall diffstat or table of contents
GIT: for the patch you are writing.
GIT: Clear the body content if you don't wish to send a summary.
X-Mailman-Approved-At: Wed, 06 Apr 2022 14:03:25 +0000
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@misterjones.org, pbonzini@redhat.com,
 tglx@linutronix.de
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

While working on some out-of-tree patches, we noticed that assignment to
dmar_subhandle of struct x86_msi_data lead to a QEMU warning about
reserved bits in MSI data being set:

qemu-system-x86_64: vtd_interrupt_remap_msi: invalid IR MSI (sid=256, address=0xfee003d8, data=0x10000)

This message originates from hw/i386/intel_iommu.c in QEMU:

#define VTD_IR_MSI_DATA_RESERVED (0xffff0000)
if (origin->data & VTD_IR_MSI_DATA_RESERVED) { ... }

Looking at struct x86_msi_data, it appears that it is actually 48-bits in size
since the bitfield containing the vector, delivery_mode etc is 2 bytes wide
followed by dmar_subhandle which is 32 bits. Thus assignment to dmar_subhandle
leads to bits > 16 being set.

If I am not mistaken, the MSI data field should be 32-bits wide for all
platforms (struct msi_msg, include/linux/msi.h). Is this analysis
correct or did I miss something wrt. handling of dmar_subhandle?

The attached patch fixes the issue for us.

Regards,
- reto
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
