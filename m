Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D117238159
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449214; cv=none; b=DNTdLVyloza5acppLfbv/oW++qqf063en8n+sZ970o5fpVQ/ItdGtMhc99uh0wjSp15nLew5A3ltBq52/K7UjNHag+TFIz9MD3qiHt1iquY7nWdFmcVUyLhNxi0cafTmnv5qUIEHmT8BMisw+ooQ1D+Y/OxuyujxIAYDckHg4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449214; c=relaxed/simple;
	bh=fDpc5Rrx+kA7LyjzAvSZaX9/CYeYwurvx1OcubUNZ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9WfMWvG5Cm77/IVJdbxIWsBoAFK1SS+TNkP/WWwI5IpBQU8opEtrCQ3Q9/ZoAzVGii6G0pF1J8oUsd/0rGdzfDziDTZncKkVx30Tau6tE6ckEvuDSQr0CPqRDQpogsE5UoxjLBVzoBAuCXwwZoer1fDfIllB/THGVcKdml3F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ntJJh0n6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ntJJh0n6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176fc0cc72so11481481cf.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449212; x=1781054012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
        b=ntJJh0n63V4YwFdBXpgbNZod0mqR4VPIwMHtgiQZmR2+5+0LcVr3BJgy6hr1/ru0LH
         BMQmVksH8BJ/s8g9X2LpBJI1tpK3OactH85N68J/grKQGT9J5gTRgYamI9mi5Ia1T+SN
         BXV3YLR+xJr+sHylQIcuRtviRNsxXKoPLZYaUL4KkoRRt9JpzG14A+vYeen20I8iF9El
         7xGW46a1ucX8jPUJmawP4KOmoZ6UBAYnLDyn0Cb/4H/dBcLrUI84VI0bbbHbqMYn4ade
         mXO94PEXiMrZhMaE+mcXIEehE6kbQDzv5t3NpYBV4yzl4IjJLE96Y36MzadZI5zsRj8Z
         1YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449212; x=1781054012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
        b=mcEmdKxXKexbcl+x/BreMSAavfxf49Ext9PtfPQLiZ/gFnhs2pVJS8CTZuJ9/VUAIn
         aV7Ps7bpiluxmnY+Ajhd6506JwSrzdRDvAmemCL1Non9EJCC3FSLItSHoEClWDLGCvA6
         5iYH+bFG7Xkmy2rMaXY0g/M0JZsNwMHgVU1lmB8oZI3Ftqn39w/TEqUAzPEcDj7bsZc4
         hzuGsx+OudccAbVxCTywI+0x96TkunWU3AW7Sgs1fI8YJ+eVRZjh6oykpePznfvDgQVZ
         d9dsfb2E2ySwS6CRGkKkpgdfOKf0n0Xi7+s/hf8OXkcZMy1mcej8IY9T8ln5HFi/DYCF
         9Iag==
X-Forwarded-Encrypted: i=1; AFNElJ/kN05+Lmj4IAffKqVUNmIIg2BJTEkm1SvfMmNMBuxqMw5aU+GFnWFyiXAN+rHwGblMUwZ73Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm+bIdzgcZAgpi/DSo/OW2bBrbJ7zR1BKvtjxu8yVHsAUZ4TrN
	G8mGfF6orLMdZm4gr7lH9BbrCjOToE8500QKiwGUKejczHrqJOyAMCrjRgTbHhI9zFY=
X-Gm-Gg: Acq92OFpL+fbacqohY6XIElx50xAMZbhS1zxg2SR6sHqVg2+bMwBQwMUgeivkGgM2Ad
	GKW8Kt8VgEbadhgTgMi1aqh7iJyiLStH2F1Uvx2uM9jXZ9SGHoV8F/92s+RHneAX7/iuUQyfVlv
	BqKuP8vo1bM94zrPplFSd1/vudRF7FdJBC6Uj+Yc2hDzDlKhMVWjB1wFVuJZPimDuKT2IFBShx8
	ALZ2SrLFGAJHd//GCDe+1Iaik0AipEPVoMw+xQRbLbK6qt0gvNwYO4UzHd84saP3VfTeOIk/qKR
	pQe4ySZqbWnefvFSBQYDkAsVxs0C7mEz//LxLtBflJKnjfHspQREoi0TcgU2QG2i2VkXR8KvhFR
	2fIsoJ1UtZShGypKdpsy34MEUJyH479QhET/EPRZhXlOhFmt87q7K2q+Bvggx9yfGJi6iC3+8iy
	LvcztR5jjvCPhBGSz2sTF0tGjNStM1uusFl0k2R39yA4iGLyNov3suXLAR7NVO/uTJOM/DHxh4I
	7CopOd6qham1CAh
X-Received: by 2002:a05:622a:5b90:b0:517:7590:228e with SMTP id d75a77b69052e-517784827b9mr21839501cf.0.1780449212162;
        Tue, 02 Jun 2026 18:13:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c54177sm13497781cf.12.2026.06.02.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:13:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUaAk-00000004yZP-2Ic0;
	Tue, 02 Jun 2026 22:13:30 -0300
Date: Tue, 2 Jun 2026 22:13:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 10/30] iommu/ipmmu-vmsa: implement iova_to_phys_length
Message-ID: <20260603011330.GS2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:17PM +0800, Guanghui Feng wrote:
> Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
> mapped_length from io-pgtable.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9386b752dea2..a1b659ddbdb5 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
>  	ipmmu_flush_iotlb_all(io_domain);
>  }
>  
> -static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
> -				      dma_addr_t iova)
> +static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
> +				      dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  
> +	if (mapped_length)
> +		*mapped_length = 0;

Why?

Jason
