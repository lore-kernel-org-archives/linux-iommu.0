Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CBC07E96
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:52:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7B161C3F
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7B161C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4362E605C5;
	Tue,  6 Jul 2021 16:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dahbqDEM4l93; Tue,  6 Jul 2021 16:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C8B0605A7;
	Tue,  6 Jul 2021 16:52:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05585C001A;
	Tue,  6 Jul 2021 16:52:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92D5AC000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 705C64013B
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-W1XY-_GEbG for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 16:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 877F840136
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:52:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9105F61C2F;
 Tue,  6 Jul 2021 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625590359;
 bh=rHrA7JR1kuHRO2ObXygxNOXB6QH+LMH9XbYpS8HdJ9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=spoMXdtXvQawjGCgd1UmNPafDZ5jez0CvDeD3r8po/jkAIVhUdq7TptLXjdqWjlG6
 HLiMw3suvYCjfmlI+lwvjwDL+vID0oebjv+QzU+7k7sj+Ltlm4FUaMMBRee6Ty8opY
 gHNUHaBaLfuE3VnyrQMArpz+heloBAPlvq+rmH83zOtDuuImbpqQ8TuOwvEgfEhrXX
 xfv6nWk/s2df/LoIlJA93I0c3M8rggXgoZs4U6xH565bvMtHNMaQRMfrJshINRQTvI
 MNlvO3ARjb8gsYwjHQlKkgOMFX6A9tEs/LYUTBj0Bi3PvkVw+r+p3vORTvxPgKRKr7
 4hXPec9l829fQ==
Date: Tue, 6 Jul 2021 17:52:34 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu: qcom: Revert "iommu/arm: Cleanup resources in
 case of probe error path"
Message-ID: <20210706165233.GB20750@willie-the-truck>
References: <CGME20210705065703eucas1p2e89258a2fc286896b755047e06f514cb@eucas1p2.samsung.com>
 <20210705065657.30356-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705065657.30356-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Amey Narkhede <ameynarkhede03@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 05, 2021 at 08:56:57AM +0200, Marek Szyprowski wrote:
> QCOM IOMMU driver calls bus_set_iommu() for every IOMMU device controller,
> what fails for the second and latter IOMMU devices. This is intended and
> must be not fatal to the driver registration process. Also the cleanup
> path should take care of the runtime PM state, what is missing in the
> current patch. Revert relevant changes to the QCOM IOMMU driver until
> a proper fix is prepared.
> 
> This partially reverts commit 249c9dc6aa0db74a0f7908efd04acf774e19b155.
> 
> Fixes: 249c9dc6aa0d ("iommu/arm: Cleanup resources in case of probe error path")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

Thanks, Marek:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick this up as a fix?

Cheers,

Will

> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 25ed444ff94d..021cf8f65ffc 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -849,12 +849,10 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register iommu\n");
> -		goto err_sysfs_remove;
> +		return ret;
>  	}
>  
> -	ret = bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
> -	if (ret)
> -		goto err_unregister_device;
> +	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
>  
>  	if (qcom_iommu->local_base) {
>  		pm_runtime_get_sync(dev);
> @@ -863,13 +861,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> -
> -err_unregister_device:
> -	iommu_device_unregister(&qcom_iommu->iommu);
> -
> -err_sysfs_remove:
> -	iommu_device_sysfs_remove(&qcom_iommu->iommu);
> -	return ret;
>  }
>  
>  static int qcom_iommu_device_remove(struct platform_device *pdev)
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
