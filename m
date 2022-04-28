Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD61C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BE0C40441;
	Thu, 28 Apr 2022 08:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzoyV8RBl105; Thu, 28 Apr 2022 08:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F1B52404A1;
	Thu, 28 Apr 2022 08:33:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8C7BC0039;
	Thu, 28 Apr 2022 08:33:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3556DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E18B40441
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OwNJaR22TcK for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:33:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73765404A1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:33:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AF5E02FB; Thu, 28 Apr 2022 10:33:36 +0200 (CEST)
Date: Thu, 28 Apr 2022 10:33:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remve dead iommu code
Message-ID: <YmpRX6ANor/pXloO@8bytes.org>
References: <20220407062608.711392-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220407062608.711392-1-hch@lst.de>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Apr 07, 2022 at 08:26:04AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this removes a bit of dead code and methods from the iommu code and the
> cleans up the arm-smmu-v3 driver a little bit based on that.
> 
> Diffstat:
>  drivers/iommu/amd/iommu.c                   |    1 
>  drivers/iommu/apple-dart.c                  |    1 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   60 +++++++---------------------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |    1 
>  drivers/iommu/intel/iommu.c                 |    1 
>  drivers/iommu/iommu.c                       |   33 ---------------
>  drivers/iommu/mtk_iommu.c                   |    1 
>  drivers/iommu/virtio-iommu.c                |    5 --
>  include/linux/iommu.h                       |   17 -------
>  9 files changed, 19 insertions(+), 101 deletions(-)

This concerns mostly arm-smmu, please also Cc Will Deacon on this one.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
