Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139625D1E9
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503730; cv=none; b=ENBarvrsBYD3IzH3Qc59gjtX4ZYkHjNgKLbIPLwR0cyECrp2kWXQdBLJLRZoG49KeryaagMDcsNUpjHsnHXLcifiyL4BxG9Ish3VGF164FGxdwee7i0uSBp9+RMOiUlB8S6qo6KLJGg2hYnY3LEaewrmB17gVSzh9Jp3Vnqxq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503730; c=relaxed/simple;
	bh=cEYuY2nwSmF3nngV50RNePn1W3opmsLWtx/aK+S8ZpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU4SYbj3B0EKzpP1GHEo53clWY6UF/uHvFrfSCc2RMqG72OgmjEEYp+7rNvd0vyDwifNa4+aPY0ptKyNGyGMmK8l0mBmZr3/IRit7hJtMRD/R0hxhlQnlBA3tdeE4F3QEzRyxitIEtM7l+dLgDneVpIK8vdXDOkQvFEnCH8aRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG0Znqvv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG0Znqvv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014600ad12so9602831cf.2
        for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503728; x=1769108528; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vk2UXOqM9Kcx+mMxkNCtAlr2gfKKKvNS6oqXFgbFlQw=;
        b=fG0ZnqvvJNJ6DX0f6VaAeZvyvYb/I1G8HToK68FKzWdx8dEproMqMbvPp3ND8I0i6v
         KEzqlTtwD+hxuKnQVn92r/2hE1dTdwJVwK552bZ0tqi5feCqZqFAIYaxqzKP7Jv+Y3mR
         2urFEVpcjr/pJ6Vl266Q5339t/I8wdpefoSmElWK5vwcD2ngArg8ZRXmdGETmk7mPQMq
         xR9sGXxxP9Z57mVC21iOSj1m2RtpkZtZQOSfL7nxabVVfYurPVA8wW4VvmRlyRss8eIg
         FkzEd+pNihiALlyJAotLDajmzjUGupLZlTkvV9t4E2bkG7TLtcq3lvwHTB4uY65jh0nc
         0Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503728; x=1769108528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk2UXOqM9Kcx+mMxkNCtAlr2gfKKKvNS6oqXFgbFlQw=;
        b=lHeFz7H3KM2rcjrl89QT/DHBJPMjAbLpccbjKUOy4+ETs+Agf59nQ8adHaj4tn0DEp
         eni9Hu2RNuIs8GUVzl06JK4hjr1BOtCDuYduIuPaYK8577fMABhPbiTRAde0lP1LPE/k
         od6QYcSZ+3khrRaPwi/gzCQxzn0KSj636g2/QW98AayJrtRHuz7/6Ew53lBn+ZtRtAhh
         2H9vvdjCKXTNTF9T2j/dlkvgikUAh8Uib87eQzY6yPBEqEMYozLe2x8lNQlporVR39Ff
         AeOVGFSqHu+LIEzFvAwYCVI3mV0hz6heEW5OVgujs0JSPLRRdvIgzqCiFhhqp+KOAHx0
         LjJw==
X-Forwarded-Encrypted: i=1; AJvYcCXRMXeRS0PMFgy/OIEXe+UIAh1/rgDLUTl8OLIWCzatif/AifiMvMau68KMPBXAQrUOXOHGAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOxI+7z6esAD3Nztsv07B0m0kS2dJDRc6dFiHn2zHgCVfeFMaS
	tgc4DWNqeEEr7Bu3RQu+UHE0JR/CDE6w+KTW+g10QPy/eVIGQwIdjIzv
X-Gm-Gg: AY/fxX6X8osZ+/6AlUkibAMqmz984FZSKbclGgajlE0Hi3EMxKcY9FGBPOu6nWHomwX
	mCczW7lg1tCZsIsVeY8Il61nCeo471Ss0+jvFaz4spTQIgwP2NbEWIA+rbnNoucQFPb79bcgXMB
	+kBVv/4cJgVSPQZRCzaZ/BNp8b0dFkbUmV4VBRJSTiJUkUZkWkQY6przkgVhX03t1uGKyVY81c1
	gKEskzAE5RGSoZoqGCIFPgOfe5w88gF+LqcJz44+MdmrJTLbs2InwMEHVXWZdtMWtbookiw5LzA
	61+dc00ml2bJmZTLuxODkQq+FA++rNJs8VTqnpUIrT8/vD7RFfopBF1a6/zGvFv31GUsgaQs3m/
	cHBdS7IVEnz9FxTcByWJD0lvEHjb83T+m3ArNmQfqSeH+zD35aRodiHWkLCSPbZwsKeUqbqBsoW
	8cVNMuCIW2NyuBmLMTGmOQLI9B
X-Received: by 2002:a05:622a:110e:b0:4f3:5652:6743 with SMTP id d75a77b69052e-502a17565b9mr8274571cf.39.1768503727274;
        Thu, 15 Jan 2026 11:02:07 -0800 (PST)
Received: from ?IPV6:2001:871:22a:693f::1ad1? ([2001:871:22a:693f::1ad1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ed3155sm2097251cf.19.2026.01.15.11.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 11:02:06 -0800 (PST)
Message-ID: <5cab0953-c2a3-4baa-af91-e9519afef092@gmail.com>
Date: Thu, 15 Jan 2026 20:02:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] qcom: iommu: nullpointer dereference on boot on
 apq8064
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
References: <569d7de2-cfcd-4d28-8bbf-14a0179f665e@gmail.com>
 <20260105180213.GG125261@ziepe.ca>
 <9a86120e-c0be-4ed5-a3de-cc7f164da154@arm.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <9a86120e-c0be-4ed5-a3de-cc7f164da154@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Robin,

On 1/6/26 7:50 PM, Robin Murphy wrote:
> On 2026-01-05 6:02 pm, Jason Gunthorpe wrote:
>> Though this looks really weird:
>>
>>          struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
>>          int sid;
>>
>>          if (list_empty(&(*iommu)->ctx_list)) {
>>                  master = kzalloc(sizeof(*master), GFP_ATOMIC);
>>
>> So maybe master is NULL and !list_empty()?
> 
> AFAICS that could happen if of_xlate has run once, and then for whatever
> reason dev->iommu is torn down and the whole process started from
> scratch a second time - although I'm struggling to see any obvious cause
> for that in the absence of any other visible errors or async probe
> races (and assuming that the IOMMUs on this platform ever actually
> worked at all, of course...)
> 
> However it certainly stands out as a bit wrong that of_xlate is touching
> the IOMMU instance itself - that should never have been expected to work
> well. Does the diff below help?
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 819add75a665..e57780fc3287 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -360,14 +360,11 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
>  /* Must be called under msm_iommu_lock */
>  static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
>  {
> +    struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>      struct msm_iommu_dev *iommu, *ret = NULL;
> -    struct msm_iommu_ctx_dev *master;
>  
>      list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> -        master = list_first_entry(&iommu->ctx_list,
> -                      struct msm_iommu_ctx_dev,
> -                      list);
> -        if (master->of_node == dev->of_node) {
> +        if (iommu->dev->fwnode == fwspec->iommu_fwnode) {
>              ret = iommu;
>              break;
>          }
> @@ -378,6 +375,7 @@ static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
>  
>  static struct iommu_device *msm_iommu_probe_device(struct device *dev)
>  {
> +    struct msm_iommu_ctx_dev *master;
>      struct msm_iommu_dev *iommu;
>      unsigned long flags;
>  
> @@ -388,6 +386,8 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
>      if (!iommu)
>          return ERR_PTR(-ENODEV);
>  
> +    master = dev_iommu_priv_get(dev);
> +    list_add(&master->list, &iommu->ctx_list);
>      return &iommu->iommu;
>  }
>  
> @@ -604,14 +604,13 @@ static int insert_iommu_master(struct device *dev,
>      struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
>      int sid;
>  
> -    if (list_empty(&(*iommu)->ctx_list)) {
> +    if (!master) {
>          master = kzalloc(sizeof(*master), GFP_ATOMIC);
>          if (!master) {
>              dev_err(dev, "Failed to allocate iommu_master\n");
>              return -ENOMEM;
>          }
>          master->of_node = dev->of_node;
> -        list_add(&master->list, &(*iommu)->ctx_list);
>          dev_iommu_priv_set(dev, master);
>      }
>  

Sorry for taking so long until I got to trying it out.
The patch fixes the crash!

Cheers,
Christian

