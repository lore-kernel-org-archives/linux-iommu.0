Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB717C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 12:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7388040407;
	Mon, 28 Feb 2022 12:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qh3uFn2Df0ok; Mon, 28 Feb 2022 12:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 246BB40588;
	Mon, 28 Feb 2022 12:48:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBC4C0033;
	Mon, 28 Feb 2022 12:48:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2388C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81B6E40275
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPCdo8kb7eiA for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 12:48:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CECF9400D9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:48:03 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D97F84B0; Mon, 28 Feb 2022 13:48:01 +0100 (CET)
Date: Mon, 28 Feb 2022 13:48:00 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 0/5] iommu/amd: Cleanup and fixes
Message-ID: <YhzEgGNJukt9IKm2@8bytes.org>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
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

On Mon, Feb 21, 2022 at 10:29:11AM +0530, Vasant Hegde wrote:
> This series contains various cleanup and trivial fixes.
> 
> Suravee Suthikulpanit (2):
>   iommu/amd: Improve error handling for amd_iommu_init_pci
>   iommu/amd: Improve amd_iommu_v2_exit()
> 
> Vasant Hegde (3):
>   iommu/amd: Call memunmap in error path
>   iommu/amd: Clean up function declarations
>   iommu/amd: Remove unused struct fault.devid
> 
>  drivers/iommu/amd/amd_iommu.h |  4 ----
>  drivers/iommu/amd/init.c      | 16 ++++++++++++----
>  drivers/iommu/amd/iommu_v2.c  | 35 +++++++++++++++++------------------
>  3 files changed, 29 insertions(+), 26 deletions(-)

Besides the error messages in the first patch this looks good to me.
Please re-send with the updates and I consider it for v5.18.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
