Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54D36C5B3
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043839; cv=none; b=ev6FRuIX6pDetpw+PLKCj/qqDi3lAgKVnW19L7I2TVhAqXmGd0WA8sHUqUgt5B8EWR4oZTc0Hq7hSAzoizyo6ihRb3PyLqDX6MDNLcEYhdrFSFppEyvmy/mIidicvIRGMEpfLcoB/Q7hpyTAmZerVCDTfOKVPihHRmr53Cl306M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043839; c=relaxed/simple;
	bh=6xX94lNKuO8BJj4VJ5mCgOyTaqmlEHPePKXQLfsPth4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs9ZT2Q/1qzi7ENPMilnl6UyaIyd7gw1S6A39pccHLk8MWsW6MlogIFKqqp6mB425v+PxdazBMFAJMcHPY+Ai69301jn0Qoo3l8JGUj8kVsMNPoekDSQ/zW1DEt01qq/3Ebj9fOyRpUKkajRBGTGH7DXaRpRJLtecoHINf81AUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/XiVN+Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/XiVN+Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052ec7176so13875ad.1
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774043838; x=1774648638; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByWF9dCBnyH2oWxXkKU4G3r/BAZXT29KzMbckrH9HdY=;
        b=D/XiVN+QkUnQev3ctMNfmsy5fxVdzT7AqYYwrX2kf7xsKPAYNNQ5N83DH6SlWdxata
         yfKYlNSzQvNlxhuz5Q+3TTFZ9wmIdvIwb72VTtrW7iWm7Dc4XPM+1G5OHq3MbL3+GNYI
         u8IVKmBq1qdd6bYNkAY3217yQ0bbfpZ56jEHrjzn1Q5mof1kiTEVs5txslsfmt3EDoQS
         Op7vImH8yo6VtUyTXgXha6pr5TpddxlESgh33ZLt7jdkomXWbEdg6Uu17YdDafJ2e8zX
         egIBWb+p/P4G+FYvnsdBomGe2AR7f2N5etANVfto9KrZR+84BYkfux3aGb+DyyMcqRPp
         6rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774043838; x=1774648638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByWF9dCBnyH2oWxXkKU4G3r/BAZXT29KzMbckrH9HdY=;
        b=PQCQCeqspUYP62AsLA55R1FCv7Nes+yB1+sn2xWw6T3g9X3fujbPkRQj/K3QCn8xYT
         ObaqpbGUW6LO00JmJYWCM9TxiBwqnfHUrWm/IgIMX9GsUe4sZE1kWJ613kp+HAS34yO+
         zgIMJf+kN9tXH12eQcS/uSwligcev6cM/WJk7M8dMaztQTl0E878GpNnV2SeMP/iNT6M
         vDqfilgNKcK6WIHSf4rGjpc2RYKbi4lqwNnpTZ+6fKGtZPkTKrLdbQhJTO8DIs+rkw5p
         ffhLPXBeiWS6VSznHj9zf3qJgean7TGNlkU+hF0Ufu3mUn3EOdVIxY/7IYdyR/reMVzL
         wrNA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZjgFKRGTJsHIU5OgFm+ZepW3Xx1t3QKbtkvEk0dSezKW7P5OfKNXU0GHVzQUDOadvnz/Lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9Le+bd/Q+//t7azDTncq7YOGa93i+IXjTX8SBVgrXzxBY1200
	peVRvoeLCS+vszoePqEqk2ZU6P9+90NBo8+uXwkh1YutiVeNM7BbSLx4qXu9MAPshg==
X-Gm-Gg: ATEYQzya9V9/WqsSm1/WCh36cRBpTKWt19w/LF1q4gonb/9Zil3X1eNHplilUQ01l+w
	Gy4rrRkJxbxFWDDee96LqA1WeMWBeF2kNnSO6KQHCf0wrfWlklHIzWrMMq1GeiWLbJRiwPNrSSL
	7g8RHDuuhQf9JhfQlfWjrrr33m8eMbuTNFmedUf5GGqZ3MDbVYvwO00Uhey+fpXh6ILPYFmHfmB
	X31NGwoNcRTsrF91NmRya/bdHnQmQc90kToppFK+0Gv6b1ag04LS+cBgcdjqiR0syGI6Ib+ofxS
	7C5ECMMoBcHkIOVDTWioj22do2aA/fCiQQ4f5pezKxAPz3T7HBzCiEK+Z2wTAajDh175K3mXQhm
	0kNQXYZrVfj8RmMsCHIJZUKWSbFFVrVERfC3EytfhK1z3Ie/k3CtabRINzZ3HJNZCdnV6UQj7IQ
	XbeuiNofjltDFrztOKcCSeUlE5MgRtR0zFAZnlKIAXIpQdO5p7lt6tqU+EfA==
X-Received: by 2002:a17:903:290:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b08b408c91mr957925ad.2.1774043837210;
        Fri, 20 Mar 2026 14:57:17 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3458655sm1477816a91.3.2026.03.20.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 14:57:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 21:57:08 +0000
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
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ab3CtC0vN6J975V5@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-6-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:39PM +0000, Samiullah Khawaja wrote:
> Implement the iommu domain ops for presevation, unpresevation and
> restoration of iommu domains for liveupdate. Use the existing page
> walker to preserve the ioptdesc of the top_table and the lower tables.
> Preserve the top_level also so it can be restored during boot.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 96 +++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    | 10 +++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 3327116a441c..0a1adb6312dd 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -921,6 +921,102 @@ int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
>  }
>  EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
>  
> +/**
> + * unpreserve() - Unpreserve page tables and other state of a domain.
> + * @domain: Domain to unpreserve
> + */
> +void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)

I don't see us using the `ser` arg in this function? Shall we remove it?

> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	iommu_unpreserve_pages(&collect.free_list, -1);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
> +
> +/**
> + * preserve() - Preserve page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, on success.

Nit: 0 on success?

> + */
> +int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +	int ret;
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	ret = iommu_preserve_pages(&collect.free_list);
> +	if (ret)
> +		return ret;
> +
> +	ser->top_table = virt_to_phys(range.top_table);
> +	ser->top_level = range.top_level;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
> +
> +static int __restore_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	int ret;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_restore_page(virt_to_phys(pts.table_lower));
> +			ret = pt_descend(&pts, arg, __restore_tables);
> +			if (ret)
> +				return ret;

If pt_descend() returns an error, we immediately return ret. However, we
have already successfully called iommu_restore_page() on pts.table_lower
and potentially many other tables earlier in the loop or higher up in
the tree..

If the domain restore fails halfway through the tree walk, how are these
partially restored pages cleaned up? Should we clean them up / free them
in an err label or does the caller perform a BUG_ON(ret) ?

> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * restore() - Restore page tables and other state of a domain.
> + * @domain: Domain to preserve
> + *
> + * Returns: -ERRNO on failure, on success.

Nit: 0 on success?

> + */
> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +
> +	iommu_restore_page(ser->top_table);
> +
> +	/* Free new table */
> +	iommu_free_pages(range.top_table);
> +
> +	/* Set the restored top table */
> +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> +
> +	/* Restore all pages*/
> +	range = pt_all_range(common);
> +	return pt_walk_range(&range, __restore_tables, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
> +

[ ------ >8 Snip >8------]

Thanks,
Praan
