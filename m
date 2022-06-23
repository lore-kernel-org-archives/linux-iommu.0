Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BC4C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0975846BE;
	Thu, 23 Jun 2022 08:15:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0975846BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCxoFeh2BaeL; Thu, 23 Jun 2022 08:15:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CBA8845BC;
	Thu, 23 Jun 2022 08:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CBA8845BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 114FEC0032;
	Thu, 23 Jun 2022 08:15:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48A06C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E69E845CB
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E69E845CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UMrqqqCKo3US for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:15:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3059845BC
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3059845BC
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:15:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 313C9447; Thu, 23 Jun 2022 10:15:22 +0200 (CEST)
Date: Thu, 23 Jun 2022 10:15:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1 0/7] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YrQhGYBVhsaNOgCH@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
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

On Fri, Jun 03, 2022 at 04:51:00PM +0530, Vasant Hegde wrote:
> - Part 1 (patch 1-4 and 6)
>   Refactor the current IOMMU page table code to adopt the generic IO page
>   table framework, and add AMD IOMMU Guest (v2) page table management code.
> 
> - Part 2 (patch 5)
>   Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
>   where requests from the I/O device without a PASID are treated as
>   if they have PASID of 0.
> 
> - Part 3 (patch 7)
>   Introduce new "amd_iommu_pgtable" command-line to allow users
>   to select the mode of operation (v1 or v2).

Something I didn't get entirely from the review is support level of the
amd_iommu_v2 driver. I think it will continue to work and the
requirement that the device identity maps DMA requests without PASID is
removed, right?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
