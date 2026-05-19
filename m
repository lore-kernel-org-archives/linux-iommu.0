Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB222F1FD0
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196519; cv=none; b=Hv99RXcz6kRgEgB+BxwADh1C93t0TYVngGJzAKmJi5jXGo27ihsIGKNi6Y7glIB0QXWEoO6CkI1FmYTbj0BUzDXLpY+Y2m035X+vaZPJnIQd15Kafq3eWjr+O+BPppDHIbAQ8d73MEHCSo4P1YmEApkTzLIUYth6ccobrg1oCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196519; c=relaxed/simple;
	bh=JDx2jF0ZO5E36Lw+1qDQU4xmk3oFKLnmUzLtiIUdQIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7+UrxHY6djxnieRMCs8JBLbdifCSSKTnkCUwhMe38tn/HLWmydKQ2rDvoiq4G4iOCAvSCOTEUYdWblOC558X7KGwLMFXrR7KKGCoWcgpbhrbP032kQdEBL4JKFcWVTxpUG+thtndNQyS6aXsn/TpXugf1FPOlGW4dEC/U7ZfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWliMB/w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWliMB/w"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so865ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779196518; x=1779801318; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fBCxwoiS3sf2RQXUwxoqVP717F35PJZZr1FHXrdR8c=;
        b=fWliMB/wxlnchSa8ytv8Q9nSI0RD0I7epB+UzcYtHsEdYGBSXux4YnrI3cCmK05+/D
         F6o9f9SHR2IpYGQSDLOuM0qy44HtlO6CpAU4TIdCoeUAtMvfSmJO1HdEBYUBfBxPZlBN
         /cJJv/IAdeO+r7RYGkpvuXyY0VnzlD6GgwoG1n5HsmqpZZ7O68D+US3kduDujj6z4wB6
         tyvVL3xM/jBEUMqcDBskY1/RAXABQmpBXWPCg9n2QmufOA2IjUPf45NPoT4pOO9/7wEg
         EadnriruxZH5Gnze8uUlPSasMFOaUSOuFXnFl73ymiGgvvTf8bJwFZ6ErMCMdMF5Urup
         Cvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196518; x=1779801318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fBCxwoiS3sf2RQXUwxoqVP717F35PJZZr1FHXrdR8c=;
        b=lBCaNkmfbDE6539L/nZUZi6MYS9/lY6YwkvwcBWufD5aJp3gtb9DoLY37y1DX2vy6A
         NAR35aFnqmYFyGc8UvVfxsJu+N4ZUt7Mkbi8xQurT4X3Jr9znTIcUX1WpyMldZc45ICW
         MPKWfmFPuRs5EDkCctWntQd8053wxuOBcgL3HWAGh4a2Qu1fHZiSlk7p4AA0x6qObj23
         g0Jg+3ostY3axNI5DZJjQc83NZbbMDMOY0uUfji6AOxNCAi+eW5OzLvGPXtCXt4ijWip
         P6kQhDEpmrByb/dDDsHp6KZofRAuO3JGPFX4W82IMve/gI6YIQNrMwvzRFd0QlBqodFQ
         FZRw==
X-Forwarded-Encrypted: i=1; AFNElJ9kataP9fjLlS9GeeaIU6W6Lp78xQ7bjLCv4bNtZ9KCIYmH6qZSs9juXykpVIHyjaOlapWTEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmtJ/Yspmio95zH1qhWS/jTsZoGajz26txx8VAQq3OIdXqcsHF
	4q632Et/HRc8OFURH4/vcflopy98tb/HSjCH1TY0Ds8h6SReBiyhx5cPiEDsqrJjXQ==
X-Gm-Gg: Acq92OHn+paasP19g1Z9Qxgz1mkibsFMjcWw4Y5AncOt1INOKg8msdK6VnAjakUQhvO
	8awwkrQk8Qo3+MrfQWIUb/D21giwPKF8xBrWmcRTeJx//205AzVxB6VBjBPq//5I9Gx01vQXExt
	aly53RYB2xcxfhfCCmpUwXIROJZluOpXJpSrybqB7MoBlvcHWwWk/enlvzdmGUpdthfG1T1yO40
	beZA3YVW1rFZu5rpZzMawVyq81YuwMPW/jKvzj/k9rccFWGaG3NdXJF8/5swudBm9QCs7Z32vAS
	OrqJ/tzVk3qPXw0DtoSf+IQKuAx4S+g7oHo/jk8Y2vty6riPktczVq4jp3Viywn/v+jdWJ2XS1D
	oxOBJRI+24v7DUq5BZs1Sd1OBRLHleiesZNB4nFx0RL5f8YxnllOCgr3MxTPXEW3iAQjFVqNoQA
	ftplTG0rkK8r0uLAkUwh2cEl+y0lafIint9ZiDDk7vJdYSU/e2mlz8qVFg3fQRx3fe31U7
X-Received: by 2002:a17:903:1a2d:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bdb32c212bmr5844565ad.17.1779196516969;
        Tue, 19 May 2026 06:15:16 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm21316591b3a.58.2026.05.19.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:15:16 -0700 (PDT)
Date: Tue, 19 May 2026 13:15:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <agxiXNalisHyNkGt@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-7-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
> Implement the iommu domain ops for presevation, unpresevation and
> restoration of iommu domains for liveupdate. Use the existing page
> walker to preserve the ioptdesc of the top_table and the lower tables.
> 
> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
> the next kernel. On restore the domain has only the preserved features
> enabled and all the other features are zeroed. This is ok since the
> restored domain is made immutable and can only be freed. A kunit test is
> added to verify that the IOMMU domain free can be done with trimmed
> features.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
>  include/linux/generic_pt/iommu.h          |  19 +++-
>  3 files changed, 177 insertions(+), 1 deletion(-)
> 

[...]

> +static const struct pt_iommu_ops NS(ops_immutable);
> +
> +/**
> + * restore() - Restore page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range;
> +
> +	common->max_vasz_lg2 = ser->vasz;
> +
> +	/* Make this domain immutable.*/
> +	iommu_table->ops = &NS(ops_immutable);
> +

Nit: Let's consider adding a comment since we just have .deinit in ops:

/*
 * Restored page tables are strictly transient and only permitted to be
 * destroyed via .deinit. Because we only preserve user-assigned devices
 * utilizing pass-through frameworks (VFIO / IOMMUFD), any concurrent or
 * subsequent map/unmap operations on a restored domain are explicitly
 * blocked at the subsystem boundary (e.g., via IOAS immutability seals).
 */

This makes it explicitly clear that any nullptr dererfs occuring due to
immutable_ops->map_range etc. (in the future) are considered as bugs.

> +	/*
> +	 * It is safe to override this here since this domain is immutable and
> +	 * can only be freed.
> +	 */
> +	common->features = 0;
> +	if (ser->sign_extend)
> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
> +
> +	range = pt_all_range(common);
> +	iommu_restore_page(ser->top_table_phys);
> +
> +	/* Free new table */
> +	iommu_free_pages(range.top_table);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
> +#endif
> +
>  struct pt_unmap_args {
>  	struct iommu_pages_list free_list;
>  	pt_vaddr_t unmapped;
> @@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
>  	.deinit = NS(deinit),
>  };
>  
> +static const struct pt_iommu_ops NS(ops_immutable) = {
> +	.deinit = NS(deinit),
> +};
> +

[...]

Thanks,
Praan
