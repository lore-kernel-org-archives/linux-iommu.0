Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E5AC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 09:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB904813B0;
	Fri,  4 Mar 2022 09:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6SYQ8700NUB; Fri,  4 Mar 2022 09:39:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABB95813BA;
	Fri,  4 Mar 2022 09:39:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 898BAC001D;
	Fri,  4 Mar 2022 09:39:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F11C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E422B402E1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pv5ZNTi3cLM4 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 09:39:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F09240257
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:39:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id EE7399BF; Fri,  4 Mar 2022 10:39:45 +0100 (CET)
Date: Fri, 4 Mar 2022 10:39:44 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 0/5] iommu/amd: Cleanup and fixes
Message-ID: <YiHeYH3zWAQ86jmo@8bytes.org>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
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

On Tue, Mar 01, 2022 at 02:26:21PM +0530, Vasant Hegde wrote:
> This series contains various cleanup and trivial fixes.
> 
> Changes in v2:
>   - Fixed error log message in patch 1 as suggested by Joerg.
> 
> 
> Suravee Suthikulpanit (2):
>   iommu/amd: Improve error handling for amd_iommu_init_pci
>   iommu/amd: Improve amd_iommu_v2_exit()
> 
> Vasant Hegde (3):
>   iommu/amd: Call memunmap in error path
>   iommu/amd: Clean up function declarations
>   iommu/amd: Remove unused struct fault.devid

Applied, thanks Vasant and Suravee.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
