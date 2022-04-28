Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F91C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDDC241979;
	Thu, 28 Apr 2022 08:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xwp0g-lp5CF5; Thu, 28 Apr 2022 08:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 676AF4196E;
	Thu, 28 Apr 2022 08:11:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2297FC0032;
	Thu, 28 Apr 2022 08:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 244F4C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 101008194C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7yrURA2UcV1q for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:11:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D6D48191E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:11:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B1AB52FB; Thu, 28 Apr 2022 10:11:05 +0200 (CEST)
Date: Thu, 28 Apr 2022 10:11:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: Re: [PATCH] iommu: fix an incorrect NULL check on list iterator
Message-ID: <YmpMF3ico9tregcJ@8bytes.org>
References: <20220327053558.2821-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220327053558.2821-1-xiam0nd.tong@gmail.com>
Cc: will@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org, sricharan@codeaurora.org
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

On Sun, Mar 27, 2022 at 01:35:58PM +0800, Xiaomeng Tong wrote:
> @@ -617,23 +617,17 @@ static int qcom_iommu_of_xlate(struct device *dev,
>  {
>  	struct msm_iommu_dev *iommu;
>  	unsigned long flags;
> -	int ret = 0;
>  
>  	spin_lock_irqsave(&msm_iommu_lock, flags);
>  	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
> -		if (iommu->dev->of_node == spec->np)
> -			break;
> -
> -	if (!iommu || iommu->dev->of_node != spec->np) {
> -		ret = -ENODEV;
> -		goto fail;
> -	}
> -
> -	insert_iommu_master(dev, &iommu, spec);
> -fail:
> +		if (iommu->dev->of_node == spec->np) {
> +			insert_iommu_master(dev, &iommu, spec);
> +			spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +			return 0;
> +		}
>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>  
> -	return ret;
> +	return -ENODEV;

This looks a bit clumsy, a better fix is below:

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 50f57624610f..98d23c52537b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -610,14 +610,16 @@ static void insert_iommu_master(struct device *dev,
 static int qcom_iommu_of_xlate(struct device *dev,
 			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_dev *iommu;
+	struct msm_iommu_dev *iommu = NULL, *it;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
+	list_for_each_entry(it, &qcom_iommu_devices, dev_node)
+		if (it->dev->of_node == spec->np) {
+			iommu = it;
 			break;
+		}
 
 	if (!iommu || iommu->dev->of_node != spec->np) {
 		ret = -ENODEV;

Can you please verify this and re-submit?

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
