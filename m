Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EC1F5423
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749064051; cv=none; b=ls7sZj6xg35Dmvq1CG4vLEV4C5EJXOWqTL2bydhNz1m2XOssmn7M3RHfsC71N17X7ZiNVJp3V6D1I1FcqoNc/ytepOSQak1l9qQeep9F0qYvT5Rr68KDY7+WeZt0PUD0V0tRGWOzwN1ht3FjNwEIYTaBn1ztKAATTeZxjlcLk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749064051; c=relaxed/simple;
	bh=xuR+iSiEc9fgmg6eICgOrNs8j588oMDceBJUZM6KnSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UiPaudI8SR2whC5wBPwzTKmyt3I3hzCEsWUp6GvNXFXxbxn0TqDe1FTvF6cEzaut53k3c0rW/4m9FEdVScaGl9LqYsJ/qE67zcDoOaXWpUhlVjesM5JLjqOrKgBFn2ttnkoTy0jNXRzy3dBlI5K7dNlyL1iqQWjtK2iPhR94VIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIjpyX5o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIjpyX5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749064048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDcwOgJcnxKoI9Ga21N4ZTVJAG6d9pqMLjrmq7B0SZQ=;
	b=GIjpyX5ofLOUwjxqp4AZ8iNmJg3xO/xCiXFqtNTKblmmXNwBSMzE8BBKHQn5zeRyyz9ZFn
	PirDJMqPT2kEmkAaSzn7gcEdIKUFhUpMidWZiC8XU0MpVIp8rr1sU8sEzL+Er18zEyjUqc
	JBuoKT/McsbRdXJHRtic+bL4IH5e2Dc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-jxCWJ6ouMwaH1smP2K-_7w-1; Wed, 04 Jun 2025 15:07:25 -0400
X-MC-Unique: jxCWJ6ouMwaH1smP2K-_7w-1
X-Mimecast-MFC-AGG-ID: jxCWJ6ouMwaH1smP2K-_7w_1749064045
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2872e57so38493685a.0
        for <iommu@lists.linux.dev>; Wed, 04 Jun 2025 12:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749064045; x=1749668845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDcwOgJcnxKoI9Ga21N4ZTVJAG6d9pqMLjrmq7B0SZQ=;
        b=hoJV2odhSa7xfEyhDDRxZmf3lFP7d0dlKtGfFuEjQ9RJ6UFJPmr6sDlihxM2C5pKec
         vwMWu2lhKJdoHPxLdf3o+k5+B5WlEzRQu3iLGj8BNOBW13izYnkwiACZEQGj6lnfrXIz
         hMTqElrIFMKLbRaeHZEBNcI3D5e4CHlE1rJyY1phjSwyrVdXr1uBT2bVpAg4MoQOjFn7
         U2jRQEOjUppCCIlSpFvRAQAHEOpwDlI0XEeTpXafwug5KR/u4Pid7avVI1NaZLfawEqZ
         CpPbZ6NZ4r0mP6PyKmgF5rC3CM4R8Z8d6Hjkl1it03csJqvHhjD23YSZWlZQeUTXsj/z
         gIuQ==
X-Gm-Message-State: AOJu0YyQHiKVi7IXEZxzHR2I7k5wu78SjepuP+MN4JszDoLrXAHPBUxh
	XNgBKPD/of7+hv3In9mxFbdZizSH8nHCfsr1DNOB3dFH/3i/RhX/S4IR3iz9X8Xd0RDtsni5GsD
	CnDsQ3CdADenjXKpXn4KcNABaZ2Q1pKj2aQ7iny+xS86VxbZeALZ6E7Cl
X-Gm-Gg: ASbGncveScnPNGA10873LopPQkwv+AcFWfF8Lc0CM7HzM0VyeWSnY6kT0/SxDbkXXW3
	zpqaWdP5xSGVaRNfLP9fhzGMWprmfzDp6KfPYiwi9HceHmYxKfm9neAwdIdjXY0lCuJd7gYzBQs
	CHv465RUzV9yvB+g9is2A7MAmp1AydqazUiRTPIq/GhgpXcr6AIKOOYZEPCh2XG87THII4AJyQb
	PRHiO4LRzICLl1cPze7QvQbUBsuSiTZGdgrtJWOZWp+wFNgYLnqn0M/al2Lk3w1lv6GZNXvLsR1
	h75Q2AG7fPD54ZtTv/UxAgJtDPlw1QSj/mLkU180
X-Received: by 2002:a05:620a:318c:b0:7d0:a511:3fab with SMTP id af79cd13be357-7d21988b7ebmr626683585a.21.1749064044746;
        Wed, 04 Jun 2025 12:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq/1wCy12sAvReQmIFAcfWv0YoxgYU7pWp9MBMGwc4L5cCHAlpE29zQqh42VKwrN6fkfeIpQ==
X-Received: by 2002:a05:620a:318c:b0:7d0:a511:3fab with SMTP id af79cd13be357-7d21988b7ebmr626677985a.21.1749064044133;
        Wed, 04 Jun 2025 12:07:24 -0700 (PDT)
Received: from localhost (ip70-163-223-251.ph.ph.cox.net. [70.163.223.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a1a76cdsm1079620985a.97.2025.06.04.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:07:23 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:07:22 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Joerg Roedel <jroedel@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH rc] iommu/terga: Fix incorrect size calculation
Message-ID: <iwix6xmwcg3bcenfdu7t3vp5dc4c6nu5orzytb5tu5abkorsro@5hoo7b5p6zwv>
References: <0-v1-da7b8b3d57eb+ce-iommu_terga_sizeof_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v1-da7b8b3d57eb+ce-iommu_terga_sizeof_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1qoao5EbLZGbzpgOHQsMFrirvakwv7yaeM7TN6OG2fU_1749064045
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2025 at 04:14:45PM -0300, Jason Gunthorpe wrote:
> This driver uses a mixture of ways to get the size of a PTE,
> tegra_smmu_set_pde() did it as sizeof(*pd) which became wrong when pd
> switched to a struct tegra_pd.
> 
> Switch pd back to a u32* in tegra_smmu_set_pde() so the sizeof(*pd)
> returns 4.
> 
> Fixes: 50568f87d1e2 ("iommu/terga: Do not use struct page as the handle for as->pd memory")
> Reported-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> Closes: https://lore.kernel.org/all/62e7f7fe-6200-4e4f-ad42-d58ad272baa6@tecnico.ulisboa.pt/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 61897d50162dd7..e58fe9d8b9e77e 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -559,11 +559,11 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
>  {
>  	unsigned int pd_index = iova_pd_index(iova);
>  	struct tegra_smmu *smmu = as->smmu;
> -	struct tegra_pd *pd = as->pd;
> +	u32 *pd = &as->pd->val[pd_index];
>  	unsigned long offset = pd_index * sizeof(*pd);
>  
>  	/* Set the page directory entry first */
> -	pd->val[pd_index] = value;
> +	*pd = value;
>  
>  	/* The flush the page directory entry from caches */
>  	dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
> 
> base-commit: 7d4dfa6140f75b67f8eff3ae6ebc9937be94c4d3
> -- 
> 2.43.0
> 

The tiniest of nits with the typo in the summary of terga vs tegra,
but other than that.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

