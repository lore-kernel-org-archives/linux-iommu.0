Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F270C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 13:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9122840331;
	Wed,  4 May 2022 13:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwugHmtJ-X4o; Wed,  4 May 2022 13:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 536C240332;
	Wed,  4 May 2022 13:18:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F25FC0039;
	Wed,  4 May 2022 13:18:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE66C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EB1583EE3
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spcRLeZCDnEl for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:18:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EEBB83E9D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:18:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C8EA13FA; Wed,  4 May 2022 15:18:38 +0200 (CEST)
Date: Wed, 4 May 2022 15:18:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Make sysfs robust for non-API groups
Message-ID: <YnJ9LaBlARYSE4Y/@8bytes.org>
References: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, will@kernel.org,
 Jan Stancek <jstancek@redhat.com>
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

On Wed, May 04, 2022 at 01:39:58PM +0100, Robin Murphy wrote:
> Groups created by VFIO backends outside the core IOMMU API should never
> be passed directly into the API itself, however they still expose their
> standard sysfs attributes, so we can still stumble across them that way.
> Take care to consider those cases before jumping into our normal
> assumptions of a fully-initialised core API group.
> 
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Tested-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> /me has a vested interest in not going backwards on dev_iommu_ops() :)
> 
>  drivers/iommu/iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
