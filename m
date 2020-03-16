Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C3C0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703BA2051A
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl6bstE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703BA2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 57BF420529;
	Mon, 16 Mar 2020 15:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8BfVTyBdAiW; Mon, 16 Mar 2020 15:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 00C3820499;
	Mon, 16 Mar 2020 15:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF8ACC1D7C;
	Mon, 16 Mar 2020 15:52:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD98BC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C41E87141
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNjNkOQDnh7Y for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C04F08712C
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:52:32 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id f3so14890876wrw.7
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CQWUEVlXfznSczAKyGpDi3T2t4zubClSxzSzuBgyOmY=;
 b=yl6bstE+aSegQ4PSIZwfpkI4xv5zEpFCHJTeJOmkwQSJ+I34mLp8AxYTWZ9rJT3sc2
 lfVn74R8N/A5/RlriKIwFzgnhIdRpYphZB/RGS2V7TiOu9jBnvyS/vVHkhpcG/UCkclI
 /Xe8pirR3stVSJMCZatixqgD5qeqsOrizxVPTp5NmPJGHiiNFTlr2SrOO2kgOC4/0W9m
 TaePqXQ0F0j8GjfwG6eC/pF625lANh0WVdHPpEVzOMwvBPZshj8wKu9LXxVj1/SPB9LL
 CEn13SHypRSkWd4ThtiGgPM4UZhcVfHP1IHQBtjQSqNt8bUgTV5XgO5/lnNRElqlP+4y
 Bdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CQWUEVlXfznSczAKyGpDi3T2t4zubClSxzSzuBgyOmY=;
 b=jVudOtojghvmaEH1Q5SlMUbKnt3FC/MWJCQJJtKzatvthmY5nnBdfKlKbJK36uhwiy
 DBWqTCFAR4swCTVGuPReAfL49c5JQVpoMc1aXiHxOXv0Z7qAGGv4p4FzfIQIhR0owKU1
 Qdwflt5fMiV1AnmGXZs9ORfSdb62BOAhkFU7FcvuHTj4jfPnOICLpxtDMq8QXhGcUTUD
 cPeM3DLFxMs7nEkvisO6nNQfc3yWV/64ozJnmrhNMKs/BvaGVQvMwiOTtGCzsxnzAJ8F
 mAe5kZwgobwFdv4d/y8ujRqYIdwqe2qVPqaImK1KhE5iSC5+3msx+r+l9aYkN9tq9LXW
 VGug==
X-Gm-Message-State: ANhLgQ2lIgzo7l1qTB5iE0tr33OplWVf9eHYpTCmEcAF+AB23sUyZviZ
 gXzNk0LhdznuCDkalfufDULZnA==
X-Google-Smtp-Source: ADFU+vttr8+4jXiTPQnlMs6N4KDj9oq3qIoO+BGp44KMN8sfSjRCTINbImPpFYK6LbM8TzaWqB/nSA==
X-Received: by 2002:adf:f289:: with SMTP id k9mr37838wro.220.1584373951194;
 Mon, 16 Mar 2020 08:52:31 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t1sm509263wrq.36.2020.03.16.08.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:52:30 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:52:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 13/15] iommu/qcom: Use accessor functions for iommu
 private data
Message-ID: <20200316155223.GM304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-14-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-14-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:27AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/qcom_iommu.c | 61 ++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0a9f..80147f82d427 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -74,16 +74,19 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>  
>  static const struct iommu_ops qcom_iommu_ops;
>  
> -static struct qcom_iommu_dev * to_iommu(struct iommu_fwspec *fwspec)
> +static struct qcom_iommu_dev * to_iommu(struct device *dev)
>  {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
>  	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
>  		return NULL;

Following other drivers, I think this test could move to add_device() (and
remove_device()?), but this is probably good enough for now.

> -	return fwspec->iommu_priv;
> +
> +	return dev_iommu_priv_get(dev);
>  }
[...]
>  static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct qcom_iommu_dev *qcom_iommu;
>  	struct platform_device *iommu_pdev;
>  	unsigned asid = args->args[0];
> @@ -583,14 +594,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	    WARN_ON(asid > qcom_iommu->num_ctxs))
>  		return -EINVAL;
>  
> -	if (!fwspec->iommu_priv) {
> -		fwspec->iommu_priv = qcom_iommu;
> +	if (dev_iommu_priv_get(dev)) {

Should be:

	if (!dev_iommu_priv_set(dev))

Thanks,
Jean

> +		dev_iommu_priv_set(dev, qcom_iommu);
>  	} else {
>  		/* make sure devices iommus dt node isn't referring to
>  		 * multiple different iommu devices.  Multiple context
>  		 * banks are ok, but multiple devices are not:
>  		 */
> -		if (WARN_ON(qcom_iommu != fwspec->iommu_priv))
> +		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev)))
>  			return -EINVAL;
>  	}
>  
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
