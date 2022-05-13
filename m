Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B29C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 12:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 568EE83E2C;
	Fri, 13 May 2022 12:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mcfg0AEwB4Tk; Fri, 13 May 2022 12:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 391A982B34;
	Fri, 13 May 2022 12:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12E25C0039;
	Fri, 13 May 2022 12:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFA4C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01274409C1
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40PL7JvvYqXB for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:55:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADF374091E
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:55:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A8B984D2; Fri, 13 May 2022 14:55:03 +0200 (CEST)
Date: Fri, 13 May 2022 14:54:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <Yn5VItUx+dCtkOAM@8bytes.org>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Mon, May 09, 2022 at 01:19:19PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++------------
>  1 file changed, 91 insertions(+), 36 deletions(-)

Applied, thanks. Will back-merge the branch into next now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
