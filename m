Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2005EC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9624817AB;
	Thu, 28 Apr 2022 08:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BAaSwDIS6pM; Thu, 28 Apr 2022 08:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5E9781757;
	Thu, 28 Apr 2022 08:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A15BC0032;
	Thu, 28 Apr 2022 08:04:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D15BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A69D4071E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JZSur3sfYaLy for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:04:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 361A341975
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:04:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C205F452; Thu, 28 Apr 2022 10:03:59 +0200 (CEST)
Date: Thu, 28 Apr 2022 10:03:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: xkernel.wang@foxmail.com
Subject: Re: [PATCH] iommu/msm: add a check for the return of kzalloc()
Message-ID: <YmpKbu4NOIHLQsvW@8bytes.org>
References: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org, will@kernel.org
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

On Fri, Mar 25, 2022 at 10:08:01AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/iommu/msm_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3a38352..697ad63 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
>  
>  	if (list_empty(&(*iommu)->ctx_list)) {
>  		master = kzalloc(sizeof(*master), GFP_ATOMIC);
> +		if (!master) {
> +			dev_err(dev, "Failed to allocate iommu_master\n");
> +			return;
> +		}

This is not enough, if the error happens it also need to be propagated
to the caller.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
