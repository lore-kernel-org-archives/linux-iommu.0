Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101C7C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 09:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA75408E4;
	Wed,  6 Jul 2022 09:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EA75408E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONMelRotsiZE; Wed,  6 Jul 2022 09:14:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35D54408C8;
	Wed,  6 Jul 2022 09:14:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35D54408C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5101C0035;
	Wed,  6 Jul 2022 09:14:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5616AC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3119A812C6
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:14:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3119A812C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJyEauNqPhXk for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:14:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7725B8128D
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7725B8128D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:14:28 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BE80A564; Wed,  6 Jul 2022 11:14:24 +0200 (CEST)
Date: Wed, 6 Jul 2022 11:14:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1 0/7] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YsVSb2LssZINNsOm@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <YrQhGYBVhsaNOgCH@8bytes.org>
 <5ad3770b-16a5-9148-54dc-5dcb93efcc81@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ad3770b-16a5-9148-54dc-5dcb93efcc81@amd.com>
Cc: iommu@lists.linux-foundation.org
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

On Tue, Jun 28, 2022 at 02:35:51PM +0530, Vasant Hegde wrote:
> Sorry. I didn't get last statement ("device identity maps DMA requests without PASID").
> Can you please elaborate?

When using v1 page-tables, each device supporting ATS/PRI/PASID needs to
be direct-mapped, because the v1 page-tables basically act as a stage-2
page table for the PASID ones.

But when the non-pasid case moves to the pasid==0 page-table, then there
is not stage-2 anymore and a device can be used with ATS/PRI/PASID while
non-PASID requests are translated too, no?

I didn't get how this is handled in the current patch-set.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
