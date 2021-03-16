Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D80C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 15:00:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B91B65090
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 15:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B91B65090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19B416F635;
	Tue, 16 Mar 2021 15:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybgVlf-1XzDE; Tue, 16 Mar 2021 15:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC6C46F62D;
	Tue, 16 Mar 2021 15:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4215C000B;
	Tue, 16 Mar 2021 15:00:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3610EC000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 15:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 310F56F633
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 15:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YOiEOGm35JqJ for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 15:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0318F6F62D
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 15:00:30 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D5C5AC24;
 Tue, 16 Mar 2021 15:00:28 +0000 (UTC)
Date: Tue, 16 Mar 2021 16:00:26 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix iommu remap panic while amd_iommu is set
 to disable
Message-ID: <YFDICtszzhFzX8cH@suse.de>
References: <20210311142807.705080-1-ray.huang@amd.com>
 <YFCvsort3oZGfDBy@suse.de> <20210316133602.GB2497230@hr-amd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316133602.GB2497230@hr-amd>
Cc: "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Tue, Mar 16, 2021 at 09:36:02PM +0800, Huang Rui wrote:
> Thanks for the comments. Could you please elaborate this?
> 
> Do you mean while amd_iommu=off, we won't prepare the IVRS, and even
> needn't get all ACPI talbes. Because they are never be used and the next
> state will always goes into IOMMU_CMDLINE_DISABLED, am I right?

The first problem was that amd_iommu_irq_remap is never set back to
false when irq-remapping initialization fails in amd_iommu_prepare().

But there are other problems, like that even when the IOMMU is set to
disabled on the command line with amd_iommu=off, the code still sets up
all IOMMUs and registers IRQ domains for them.

Later the code checks wheter the IOMMU should stay disabled and tears
everything down, except for the IRQ domains, which stay in the global
list.

The APIs do not really support tearing down IRQ domains well, so its not
so easy to add this to the tear-down path. Now that the IRQ domains stay
in the list, the ACPI code will come along later and calls the
->select() call-back for every IRQ domain, which gets execution to
irq_remapping_select(), depite IOMMU being disabled and
amd_iommu_rlookup_table already de-allocated. But since
amd_iommu_irq_remap is still true the NULL pointer is dereferenced,
causing the crash.

When the IRQ domains would not be around, this would also not happen. So
my patches also change the initializtion to not do all the setup work
when amd_iommu=off was passed on the command line.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
