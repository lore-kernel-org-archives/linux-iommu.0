Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F43A451F
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281904; cv=none; b=Mp9xZ9iTaBnNsJiuVsV4OFnRbYbqv3ZAOWwZ7n2h0aGVqQG9I2ZYcD/OFPcJV6nD+tYFCjHGlGwt24Au4WlS2a3vtoBdWf9H5AG9j5E9NvC32WjsioMqppGk4O2EmS5ARrzjpQT66mDHXu01blUNV7pasBZ5vW9/sckhyPrfH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281904; c=relaxed/simple;
	bh=Q8BYt/zH8QAs9f/G4XlmE2TMZ1EhwSUQirokAPY+Vvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFbs7jqyWqNqhZ+hwel/i6BIOsutx+41JQM2qfvPjKBRMn2MrSbRwuGbkjOYU9GUqy66fpoRtF4+rb8h8XJeipkO1xOZbMh/6Wk5T1nLsIE+MK5/2Qsh2GEFEK7o2zTRl8uX+sXNZmuOs8bbR00zu7lPVVpnKXbw3/F34YGwwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FIeSzLfK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FIeSzLfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779281900;
	bh=Q8BYt/zH8QAs9f/G4XlmE2TMZ1EhwSUQirokAPY+Vvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FIeSzLfKHyd9p1aoxRbumXfs6BMFc8aGadjo5/CTqF+xckgFNhQid5b8OBeKHQR+C
	 VQUG+EP4pljLhjMl4mfpsgcHaJK3tlpgLO7BXp7WEupzAAWpodkaBrbFsDlTdw3EN3
	 KElZmxoS6s8/qtdkNo3LTEt7931DFlN71z1P2RJm8Ain+Cso68xa58ZbqcfDxtUUyZ
	 M5OBtaD/tZsqXdUGfkn03el2A9i5oGMQuEwqCmUEVwMyG6C9f2NV/jAwJuGcDjdsw2
	 N0rnwHdpg72gUoUqa1CEb2fuTWX1wsJ+OXq/o1d4OdTXry0fuzVBEhgEznXXZn04ih
	 z06oSa36gPVzg==
Received: from [100.64.1.43] (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A962B17E0940;
	Wed, 20 May 2026 14:58:20 +0200 (CEST)
Message-ID: <9b5fe6af-0c06-4f51-bb33-9e0b47af7ea3@collabora.com>
Date: Wed, 20 May 2026 14:58:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vsi: Use list_for_each_entry()
To: Dan Carpenter <error27@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ag1N99H-xnmSh-hc@stanley.mountain>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <ag1N99H-xnmSh-hc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 20/05/2026 à 08:00, Dan Carpenter a écrit :
> Smatch complains about the NULL check on "iommu" because list_entry()
> can't be NULL.  Clean up this code by using list_for_each_entry().
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
> Untested, but it compiled on the first try (no typos!)
>
>   drivers/iommu/vsi-iommu.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 5d0721bd2c7a..9954ed414526 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -366,15 +366,9 @@ static int vsi_iommu_map_iova(struct vsi_iommu_domain *vsi_domain, u32 *pte_addr
>   static void vsi_iommu_flush_tlb(struct iommu_domain *domain)
>   {
>   	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> -	struct list_head *pos;
> -
> -	list_for_each(pos, &vsi_domain->iommus) {
> -		struct vsi_iommu *iommu;
> -
> -		iommu = list_entry(pos, struct vsi_iommu, node);
> -		if (!iommu)
> -			continue;
> +	struct vsi_iommu *iommu;
>   
> +	list_for_each_entry(iommu, &vsi_domain->iommus, node) {
>   		if (pm_runtime_get(iommu->dev) < 0)
>   			continue;
>   
