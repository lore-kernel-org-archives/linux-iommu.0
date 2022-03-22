Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56637C433FE
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 09:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9EE8404EC;
	Tue, 22 Mar 2022 09:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJUt3VZjOytt; Tue, 22 Mar 2022 09:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9BC5140150;
	Tue, 22 Mar 2022 09:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F468C0012;
	Tue, 22 Mar 2022 09:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE0BC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F018E404EC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sExBACSGJhnL for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 09:14:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 510F440150
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:14:40 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 530BF68AFE; Tue, 22 Mar 2022 10:14:33 +0100 (CET)
Date: Tue, 22 Mar 2022 10:14:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu: Add capability for pre-boot DMA protection
Message-ID: <20220322091432.GA27069@lst.de>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com, hch@lst.de
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

On Fri, Mar 18, 2022 at 05:42:57PM +0000, Robin Murphy wrote:
> VT-d's dmar_platform_optin() actually represents a combination of
> properties fairly well standardised by Microsoft as "Pre-boot DMA
> Protection" and "Kernel DMA Protection"[1]. As such, we can provide
> interested consumers with an abstracted capability rather than
> driver-specific interfaces that won't scale. We name it for the former
> aspect since that's what external callers are most likely to be
> interested in; the latter is for the IOMMU layer to handle itself.
> 
> Also use this as an opportunity to draw a line in the sand and add a
> new interface so as not to introduce any more callers of iommu_capable()
> which I also want to get rid of. For now it's a quick'n'dirty wrapper
> function, but will evolve to subsume the internal interface in future.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I can't really think of a way in which I suggested this, but it does
looks like a good interface:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
