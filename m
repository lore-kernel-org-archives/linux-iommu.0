Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816467;
	b=CKRxZIkNl34AiL3f3qBZmnn68xqcyYqDfelqhvjFg3Q2QYxxh31SwMvfRgKns6VR2075
	 MWEF/AegnSBFaPmhb+ry6ZdRHUQic+JffNcyay0wNo47w365wHHDdq5KiFj93Sih40yR/
	 NPO//hwiSeITmCF4TcJ6XhQ6LnKLdq8i+qkOvZAVym3M7/ChGgMj/D7QmsSz76F4K0sRi
	 HXcH++nlLhiXNLWepOVsm5ZC4/8FCNokVDT1Ue1GNm/J2P5YX5XAJ53ijdFt+JgdBl9sS
	 QEtieN+A+Y6Tbmn+3zV/5ooWf34qmEoeUkhg9ALfq/CX9HlnFuH3oSSkGmRpL+L5+zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816467;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/pT+NCMYXp3UZrYWaHo7YsNynQJsv5oNw7WJS2Lwazc=;
	b=IgnbE8x6sziEzomSKA3pD1Gel3nsC0yOwCMFX0aJMNUYff3uutxoFYOIasKYkdf76tEu
	 kdn5BRqAI4qgdVyM3hS3TJgGYd/kO8UTHTENKLB+MIqglsgmbbMtSVVCnsjMAUt7LEqv5
	 41PF6La/4ebflIrtxfgR/mVyQOuA2tI1Q7kofrQHUUDvk+rSnh0pMel3KLzP7XsC4QS6T
	 lbS1BHUvZLb3AifW/Oso/JypWQeBMNz8U3khJty3MTGO76hhyq0u8NctjASrf1pGrcy/0
	 QrSQOgDpJgoUcOO1g4kujER91rD2nLQ9kz+nwGQ3Ud6H40nKeK6eOl+kTrCfvlmbEsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Cn3HFGvx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D34606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 08:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D34606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Cn3HFGvx
ARC-Seal: i=1; a=rsa-sha256; t=1794816464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jj43fm7k1tIITw2W8VD+agbYuvUNapCblsblV/h7Am9Gsd6TdAyDGxEE3e9nGL5PEzHGU6q8o+qXMRwClukglbCLrNGD1CVmz7dRMMeynA9hZYpnQ1FeXGv5jj5eW28n9HzKWDzW690dpOVRysuZXZ3MV8IY7EaR51K38qqsh8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794816464; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/pT+NCMYXp3UZrYWaHo7YsNynQJsv5oNw7WJS2Lwazc=; 
	b=gUme5JEDeWntqyjPb7psEO+BiMN1ymowtFvQArfuDdS5EIlkw8sGLGCvkA+He5zYq0wDLXJ/wATRFN5YxRS4K/AnlZZcZ02IgIWRxdwgoW2HxFOCeEGZR4LGgFfxUtTIgj1mVjfINWIeANMC63G0RfM3weO6smYtmRfsFQxWUPE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Cn3HFGvx3d4rZY/Y147bKWT0U4XkFuK/8Uodfj274YdpQrzndmt9ui3geO7XDOAw+SjEzIaCUE5Ql+9ATdGBHUSONeQZ1mC9JGCSuMmd6ti91EagAT8TC7PGBa5sdTJ2WBiwUeEnXeEoyH62Kx2FSz8Yk0i55TYCzJiCbN18lb4=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=/pT+NCMYXp3UZrYWaHo7YsNynQJsv5oNw7WJS2Lwazc=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794816461477234.7808984647703;
	Mon, 16 Nov 2026 00:07:41 -0800 (PST)
Message-ID: <07e7d928-754b-422d-a9bc-963acbe98653@collabora.com>
Date: Mon, 16 Nov 2026 09:07:38 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/vsi: Don't use the identity domain as a paging
 domain
To: aiyengar1990@gmail.com, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
 <20261114-iommu-vsi-fixes-v1-1-1fc7728dfd35@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-1-1fc7728dfd35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 14/11/2026 à 01:14, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> vsi_identity_domain is a bare struct iommu_domain, but identity attach
> and resume pass it to to_vsi_domain() and take the lock of that
> vsi_iommu_domain, which is memory past the static domain. Identity
> attach also unlinks the IOMMU from its old domain's list without that
> domain's lock.
>
> Take the old paging domain's lock to unlink the IOMMU, and only the
> IOMMU lock otherwise. Resume touches neither the page tables nor the
> domain's list, so it needs only the IOMMU lock.
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com?part=1
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/iommu/vsi-iommu.c | 45 ++++++++++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 3dec58224953..5156e8a2e7fc 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -497,31 +497,42 @@ static void vsi_iommu_disable(struct vsi_iommu *iommu)
>   	iommu->enable = false;
>   }
>   
> +/* Take the IOMMU off the list of its paging domain, if it has one. */
> +static void vsi_iommu_list_del(struct vsi_iommu *iommu)
> +{
> +	struct vsi_iommu_domain *vsi_domain;
> +	unsigned long flags;
> +
> +	if (!iommu->domain || iommu->domain == &vsi_identity_domain)
> +		return;
> +
> +	vsi_domain = to_vsi_domain(iommu->domain);
> +	spin_lock_irqsave(&vsi_domain->lock, flags);
> +	list_del_init(&iommu->node);
> +	spin_unlock_irqrestore(&vsi_domain->lock, flags);
> +}
> +
>   static int vsi_iommu_identity_attach(struct iommu_domain *domain,
>   				     struct device *dev, struct iommu_domain *old)
>   {
>   	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> -	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>   	unsigned long flags;
>   	int ret;
>   
> +	if (iommu->domain == domain)
> +		return 0;
> +
>   	ret = pm_runtime_resume_and_get(iommu->dev);
>   	if (ret < 0)
>   		return ret;
>   
> -	spin_lock_irqsave(&vsi_domain->lock, flags);
> -	spin_lock(&iommu->lock);
> -	if (iommu->domain == domain)
> -		goto unlock;
> +	vsi_iommu_list_del(iommu);
>   
> +	spin_lock_irqsave(&iommu->lock, flags);
>   	vsi_iommu_disable(iommu);
> -	list_del_init(&iommu->node);
> -
>   	iommu->domain = domain;
> +	spin_unlock_irqrestore(&iommu->lock, flags);
>   
> -unlock:
> -	spin_unlock(&iommu->lock);
> -	spin_unlock_irqrestore(&vsi_domain->lock, flags);
>   	pm_runtime_put_autosuspend(iommu->dev);
>   	return 0;
>   }
> @@ -537,11 +548,12 @@ static struct iommu_domain vsi_identity_domain = {
>   
>   static void vsi_iommu_enable(struct vsi_iommu *iommu, struct iommu_domain *domain)
>   {
> -	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	struct vsi_iommu_domain *vsi_domain;
>   
>   	if (domain == &vsi_identity_domain)
>   		return;
>   
> +	vsi_domain = to_vsi_domain(domain);
>   	writel(vsi_domain->pta_dma, iommu->regs + VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE);
>   	writel(VSI_MMU_OUT_OF_BOUND, iommu->regs + VSI_MMU_CONFIG1_BASE);
>   	writel(VSI_MMU_BIT_ENABLE, iommu->regs + VSI_MMU_AHB_EXCEPTION_BASE);
> @@ -758,15 +770,10 @@ static int __maybe_unused vsi_iommu_resume(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	if (iommu->domain) {
> -		struct vsi_iommu_domain *vsi_domain = to_vsi_domain(iommu->domain);
> -
> -		spin_lock_irqsave(&vsi_domain->lock, flags);
> -		spin_lock(&iommu->lock);
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	if (iommu->domain)
>   		vsi_iommu_enable(iommu, iommu->domain);
> -		spin_unlock(&iommu->lock);
> -		spin_unlock_irqrestore(&vsi_domain->lock, flags);
> -	}
> +	spin_unlock_irqrestore(&iommu->lock, flags);
>   
>   	return 0;
>   }
>
