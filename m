Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB552139CFF;
	Tue,  4 Jun 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489177; cv=none; b=UuCF/vrNs9DQ6CIwJOmIG44L5+r+jf9zycv7ESeAFGEkq3EClFpHmalSMio2A8tiT9i/8M1leFC5enzvDgUvb5X50MGP73qWhJxROzmC+lwuGfOC4zRt4CCvhWbFsop/9bRKomA/M4lOXMM8tYFAukE+n3rY3yZjUwJRsY3sFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489177; c=relaxed/simple;
	bh=Cl26qCxo2UX/Hr4fxo+oX7S1ymUZ9Z3ZTZcmorokdoI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UQ/0DafuqNn+xjglayDjsI0KVb00h1q1gj1n+UYut2h3TM+uEVy22uewy1w3g1I1fsG0praQ2C3tWQBgp0LvOAxirrWeZYilz/no2TuIsYEKXVUbsMnqYB42ypcmZxZrwXFRQ/e5h1zjqGqoTE5E2Oedf/OASrLHbotMlLf7Vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwSFn6Te; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwSFn6Te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922FFC4AF0A;
	Tue,  4 Jun 2024 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717489177;
	bh=Cl26qCxo2UX/Hr4fxo+oX7S1ymUZ9Z3ZTZcmorokdoI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gwSFn6Tebpx2FbyOPMGfXWm/Mu5F0chYv9oPxGYovid46Ggp4OhKt4lT+8wmWVGwZ
	 bcSDSm3H+mOWpVCDwB+geWnkEcpvwZ12PaV9T7Kd/iceMQtXOQC+U1G1jzlBFszzgZ
	 G2/yEUs619rFYWz0RU3p3kwmh7rmFm9UBxZ1RMfR9To7jTcp4dW4iaK77fhWhPwGBu
	 Uh8ckP5yo3H6bMK8EXyKN6QsSAfNDn7Ue5UJkeH2pNe5M3VpFHRlt08g6N6AgIjupy
	 A14Ws1BJ3YArVaqOrjOCwf85nHtxgxueN1dRTSS8LOwU/h2kSBXuI60MLEwcV2eW2Y
	 K+lqvi8NWzRIg==
From: Kalle Valo <kvalo@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,  Will Deacon <will@kernel.org>,  Robin
 Murphy <robin.murphy@arm.com>,  Jason Gunthorpe <jgg@ziepe.ca>,  Kevin
 Tian <kevin.tian@intel.com>,  Yi Liu <yi.l.liu@intel.com>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Bjorn Andersson
 <andersson@kernel.org>,  Mathieu Poirier <mathieu.poirier@linaro.org>,
  Alex Williamson <alex.williamson@redhat.com>,  mst@redhat.com,  Jason
 Wang <jasowang@redhat.com>,  Thierry Reding <thierry.reding@gmail.com>,
  Jonathan Hunter <jonathanh@nvidia.com>,  Mikko Perttunen
 <mperttunen@nvidia.com>,  iommu@lists.linux.dev,
  dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
    Jeff Johnson <quic_jjohnson@quicinc.com>, ath11k@lists.infradead.org
Subject: Re: [PATCH v2 12/22] wifi: ath11k: Use iommu_paging_domain_alloc()
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
	<20240604015134.164206-13-baolu.lu@linux.intel.com>
Date: Tue, 04 Jun 2024 11:19:30 +0300
In-Reply-To: <20240604015134.164206-13-baolu.lu@linux.intel.com> (Lu Baolu's
	message of "Tue, 4 Jun 2024 09:51:24 +0800")
Message-ID: <874ja9t90t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Lu Baolu <baolu.lu@linux.intel.com> writes:

> An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
> attached to ab_ahb->fw.dev in the same function.
>
> Use iommu_paging_domain_alloc() to make it explicit.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index ca0f17ddebba..a469647719f9 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -1001,10 +1001,10 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
>  
>  	ab_ahb->fw.dev = &pdev->dev;
>  
> -	iommu_dom = iommu_domain_alloc(&platform_bus_type);
> -	if (!iommu_dom) {
> +	iommu_dom = iommu_paging_domain_alloc(ab_ahb->fw.dev);
> +	if (IS_ERR(iommu_dom)) {
>  		ath11k_err(ab, "failed to allocate iommu domain\n");
> -		ret = -ENOMEM;
> +		ret = PTR_ERR(iommu_dom);
>  		goto err_unregister;
>  	}

Adding Jeff and ath11k list so that they can review this as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
