Return-Path: <SRS0=t+bH=3N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B4C32771
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7419206F0
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7419206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8888C86D84;
	Fri, 24 Jan 2020 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 255WgXkY-NUo; Fri, 24 Jan 2020 14:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 124AF86C2F;
	Fri, 24 Jan 2020 14:39:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8419C18DD;
	Fri, 24 Jan 2020 14:39:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33EB7C0174
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 14:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1BB3A20494
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 14:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qcZpcdplUX9 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jan 2020 14:39:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id B7F8D203EE
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 14:39:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A807DA52; Fri, 24 Jan 2020 15:39:06 +0100 (CET)
Date: Fri, 24 Jan 2020 15:39:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH 1/1] iommu/amd: Remove the unnecessary assignment
Message-ID: <20200124143905.GD27081@8bytes.org>
References: <20200122143629.21161-1-ahuang12@lenovo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200122143629.21161-1-ahuang12@lenovo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

On Wed, Jan 22, 2020 at 10:36:29PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> The assignment of the global variable 'iommu_detected' has been
> moved from amd_iommu_init_dma_ops() to amd_iommu_detect(), so
> this patch removes the assignment in amd_iommu_init_dma_ops().
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/iommu/amd_iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
