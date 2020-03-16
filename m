Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E8C0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57D520679
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh5r2acF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B544E220A2;
	Mon, 16 Mar 2020 15:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ED9Q7fqzEvJ; Mon, 16 Mar 2020 15:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 322BF21FAD;
	Mon, 16 Mar 2020 15:47:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20DA2C1D7C;
	Mon, 16 Mar 2020 15:47:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32013C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 210408879D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qCNTjI1LO1Wz for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BF5B38886E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:31 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x3so13612261wmj.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3QMtJyHMdj2d3NlJHtXdRPjzJsxucKLnz+qn2QRFOx0=;
 b=oh5r2acFcKirM1Z60N97UiPELuL4YbxB+3thPoKh00c2cXA7zBnMrcg9MocIgrcoCL
 U05LP/VCBy/GD0AL9aNluQa4QCsCZCtQYprWO7EIyPc9RAWGZvVCsle+UbSRXH9Gkm/0
 KZJWytpT98u58L3kNWY/rNnStqJF3aq2+Ox1CNzi2Q+F03eOgvegXRb9TavYC+TyVBSt
 M/gQ9g1WL/OSC5hfVtxCTgHT3DFmQq6BKeS3Jv0oNCkzSq7i3fPAW/GtZOnFeBw5AIHa
 v49KMqeOlQX7Wl2sfbU7w4LmNqG13XIFmu88aXgH/xPUBruIR9N3LVcA+UxWR9+MtlzO
 N1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3QMtJyHMdj2d3NlJHtXdRPjzJsxucKLnz+qn2QRFOx0=;
 b=Rc3EfKq79Pxk2iCuLQ+y3kA2wJ2YNZeKFiWYmaNqYYFw1sTlmMH13EXHBzE1YcrQ0C
 0idXA5hnMF+meKnwrNFx4rgtek7wi3KNqLKX0Dg33wpYrSt5yxx7SmltqRvskE7eh1+l
 kQmeLKmcLxjaAGFQ3tnTgP09xYn4wZGv3gHTy+hvmOrX5WUENYI3JIOqlFZoyGGBj++K
 Xd/TzOVJkCa1aVUIAJcq8i4JSfVaVj9I+/OdDFoaDTTrm+NL8kppAdErXilKAzLpHmAN
 bvAP1NLisjjCz0lOyKDsap9wb/E0NX9BHgKXfmVnQqSlPFuZGwmP3M7A5mOyi56YHCQs
 XBBw==
X-Gm-Message-State: ANhLgQ0AaC7DJTFT23rSsaXSQIOdUJ6FGgMMSRg7D6Lrj8bk10pA6XWF
 LqwaM5H5etadhjX0zi3IlC4z9A==
X-Google-Smtp-Source: ADFU+vubP0XZlLxNsPBJjbPqoRh9Fj10FSwYOvdazGAIlTLv21y5ghlreopBsVqOhrzi4VW31nde8w==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr28196696wmj.161.1584373650045; 
 Mon, 16 Mar 2020 08:47:30 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z4sm460593wrr.6.2020.03.16.08.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:47:29 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:47:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 07/15] iommu/arm-smmu: Fix uninitilized variable warning
Message-ID: <20200316154722.GH304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-8-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-8-joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 10, 2020 at 10:12:21AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some unrelated changes in the iommu code caused a new warning to
> appear in the arm-smmu driver:
> 
>   CC      drivers/iommu/arm-smmu.o
> drivers/iommu/arm-smmu.c: In function 'arm_smmu_add_device':
> drivers/iommu/arm-smmu.c:1441:2: warning: 'smmu' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   arm_smmu_rpm_put(smmu);
>   ^~~~~~~~~~~~~~~~~~~~~~
> 
> The warning is a false positive, but initialize the variable to NULL
> to get rid of it.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 16c4b87af42b..980aae73b45b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1383,7 +1383,7 @@ struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
>  
>  static int arm_smmu_add_device(struct device *dev)
>  {
> -	struct arm_smmu_device *smmu;
> +	struct arm_smmu_device *smmu = NULL;
>  	struct arm_smmu_master_cfg *cfg;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	int i, ret;
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
