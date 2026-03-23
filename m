Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455A3C279D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284098; cv=none; b=lWSc+YuQmZQ4PWHCMTxYZYT/uBHrg7/0bXzwZ5/CVGey+CdrTre+ouM/bjgTMGGAjWeb7ZdaCtptmEklWd8RN2dPw5Nk+zoJFZ7ZdVI6sST9dMsirOca5xWNEqzV+iH/5PFi+QRbCAWpk4mRUJ4wjaxblaZcANtzWDCh5px6IxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284098; c=relaxed/simple;
	bh=UeP0Jc9ScLlNXFHH6xFzjkEqbuLq7EKTaQ0Viww18/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh8SYGXwDxrl67sjJcDogHd1MXSu94vit9JugmPcShNpH/B2oRwkYp6wbRp8+h19U7pcWOeyo8BYwBGe+AYRUlpf9a86YZ+krc2FflHT600AXF9zPecrLA5wXztFbYTQuuiy7O2simwVt/yN/E6rhxz6bPzHFwtNSGNYXGh8HP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs4vnPnj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs4vnPnj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aeab6ff148so105ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774284096; x=1774888896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58Y5zB7xDhthTmxBXC2s4CGQm6/MPS5c4NtdfV6RXIc=;
        b=fs4vnPnjQJTcyTBNwOwmgCZmgV5gX2e5yzf+DT6KcPgAZxsX8NdxJGKbZ3y034hm2j
         p/PO6iaXiBhpTXvGzKo0M4ELOW2onzwhC7Y4Dg4Cox9NFCOMOmqlkX7JXT6DPdCJLprW
         FBuh5Pz7iSGm+RrHPOo27xirYsfjBwWjkPUtChW1lg9LZVr7APlSf37PW44TxQ8kdtu6
         bw/WOSYiaoSXey/49aVBN9Oi5B2TQUSmO0cGhMZhAu5dQPnjvaWFgMRYkP76ySwxxCT0
         8yR0ItEBQA8f/T8O6xHBvFk1MubeVrB5gJJ/dV/hXe7/S6A8Z2sUZ9r3Odjs0wAFP6sd
         wb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284096; x=1774888896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58Y5zB7xDhthTmxBXC2s4CGQm6/MPS5c4NtdfV6RXIc=;
        b=g1W7i/faA+WKDZMkdXNkJFbo7MQO4moQj93SbZOVAQRW3beEO6SadDdeeg2yuSBhLg
         zLqo4YR6wFBxo2B8IJ8C0n5sFWQVs6gjqYk9gTqVUV8FgrpVChZA9HbtACA7Qth9Gshd
         EmgAU94H5JPVPQiZrC7CQA8i9NzXnPJcQP5LXYxeNeJgZPKzNUwIH74rBLcsfmyQWVUp
         74M1gXH4UIAdTrIUuz4PusqdYPEpiyO75ah4u8hp3l8YqmpMzR82JlqVed4jZpQuD8xg
         wjfXRpK14IuUvZffBVF2M2TE3VCAj45fYJdfnv3hfS+B2WUIKJnDbjJ/RdcMGd1kOcr8
         2LmA==
X-Forwarded-Encrypted: i=1; AJvYcCUucBDm/Y7cvdNsREV0oheP6pSc8yXTfIED+4cbfEQ9puG7Nzsm1aW5kUXuX8e7bjQOB9PNvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9Z5bMcO8ygtjMeCtW3Zpe7HZlXtgU5eWP8jVWOI7qjfNpUmJg
	EtmPBqmStJoZor9oQykyehiDdo6xzodRpO7GS/+GycA+HVPjlaLPg9V9/WpMYMyr0w==
X-Gm-Gg: ATEYQzzE9NiAPEKwDA0ZtpFy3ZdGsRk656+v0+qamy/IQhkY6rtTSxM/pJ46nE+0zJF
	rdjJR6ADALsbMSiGfE3UQLMWHdM8OThrs68u9fQoYU/W1F86A833vQEOEP3WZjHK6nvPRpDgLE1
	FKewclVtk+aWoiAdJAcV9vVJl2zjC4bXjy7kIu5uU0L6Ckk+PYE1CzITLECMVSpolOmnGEdJJda
	J1lYV5kBpYV5qu1gN1lU5oYmP7go/gW1NqRCUDRH1BZARgxKITNxDb/YQa/ECwINxlfwFW+NXKr
	QGazLi4rBetDC6laCJow7/iIVpxex3x3SgPu37muCu7qCp0r5PA1SZEB7ekSYvyEhFybHaFPdyx
	NlVDOyZEu/s1wqTbXkdymg/XWK2jDDPYOOIxN79xoz3LJKKoJLsvmCu+EI+CSliY/vFszCu/I4T
	NESNDvlRRNkfqnjiPbcxHqhvHBB5cbH5Z8QV4tT7fNuz1gB6DWbaUGoqqo5tHKyg==
X-Received: by 2002:a17:902:f60e:b0:2b0:5683:1cf with SMTP id d9443c01a7336-2b08c4a1360mr4458125ad.13.1774284095381;
        Mon, 23 Mar 2026 09:41:35 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd271c507sm3728683a91.5.2026.03.23.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:41:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:41:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <acFpV4qYfCzp8D6b@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab3CtC0vN6J975V5@google.com>

On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:39PM +0000, Samiullah Khawaja wrote:
>> Implement the iommu domain ops for presevation, unpresevation and
>> restoration of iommu domains for liveupdate. Use the existing page
>> walker to preserve the ioptdesc of the top_table and the lower tables.
>> Preserve the top_level also so it can be restored during boot.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/generic_pt/iommu_pt.h | 96 +++++++++++++++++++++++++++++
>>  include/linux/generic_pt/iommu.h    | 10 +++
>>  2 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>> index 3327116a441c..0a1adb6312dd 100644
>> --- a/drivers/iommu/generic_pt/iommu_pt.h
>> +++ b/drivers/iommu/generic_pt/iommu_pt.h
>> @@ -921,6 +921,102 @@ int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
>>
>> +/**
>> + * unpreserve() - Unpreserve page tables and other state of a domain.
>> + * @domain: Domain to unpreserve
>> + */
>> +void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>
>I don't see us using the `ser` arg in this function? Shall we remove it?

Hmm.. this is tricky. Its not needed for GPT, but to keep the
unpreserve() callback complete, "ser" should be there as some IOMMU that
preserves/unpreserves more state with each domain might need this. I am
ok either way, WDYT?
>
>> +{
>> +	struct pt_iommu *iommu_table =
>> +		container_of(domain, struct pt_iommu, domain);
>> +	struct pt_common *common = common_from_iommu(iommu_table);
>> +	struct pt_range range = pt_all_range(common);
>> +	struct pt_iommu_collect_args collect = {
>> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
>> +	};
>> +
>> +	iommu_pages_list_add(&collect.free_list, range.top_table);
>> +	pt_walk_range(&range, __collect_tables, &collect);
>> +
>> +	iommu_unpreserve_pages(&collect.free_list, -1);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
>> +
>> +/**
>> + * preserve() - Preserve page tables and other state of a domain.
>> + * @domain: Domain to preserve
>> + *
>> + * Returns: -ERRNO on failure, on success.
>
>Nit: 0 on success?

Agreed. Will update.
>
>> + */
>> +int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> +{
>> +	struct pt_iommu *iommu_table =
>> +		container_of(domain, struct pt_iommu, domain);
>> +	struct pt_common *common = common_from_iommu(iommu_table);
>> +	struct pt_range range = pt_all_range(common);
>> +	struct pt_iommu_collect_args collect = {
>> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
>> +	};
>> +	int ret;
>> +
>> +	iommu_pages_list_add(&collect.free_list, range.top_table);
>> +	pt_walk_range(&range, __collect_tables, &collect);
>> +
>> +	ret = iommu_preserve_pages(&collect.free_list);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ser->top_table = virt_to_phys(range.top_table);
>> +	ser->top_level = range.top_level;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
>> +
>> +static int __restore_tables(struct pt_range *range, void *arg,
>> +			    unsigned int level, struct pt_table_p *table)
>> +{
>> +	struct pt_state pts = pt_init(range, level, table);
>> +	int ret;
>> +
>> +	for_each_pt_level_entry(&pts) {
>> +		if (pts.type == PT_ENTRY_TABLE) {
>> +			iommu_restore_page(virt_to_phys(pts.table_lower));
>> +			ret = pt_descend(&pts, arg, __restore_tables);
>> +			if (ret)
>> +				return ret;
>
>If pt_descend() returns an error, we immediately return ret. However, we
>have already successfully called iommu_restore_page() on pts.table_lower
>and potentially many other tables earlier in the loop or higher up in
>the tree..
>
>If the domain restore fails halfway through the tree walk, how are these
>partially restored pages cleaned up? Should we clean them up / free them
>in an err label or does the caller perform a BUG_ON(ret) ?

Yes, a failed restore here should be fatal. Looking at pt_descend
source, it should not fail here anyways as table_lower is init. I will
add a BUG_ON here.
>
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * restore() - Restore page tables and other state of a domain.
>> + * @domain: Domain to preserve
>> + *
>> + * Returns: -ERRNO on failure, on success.
>
>Nit: 0 on success?

Agreed.
>
>> + */
>> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> +{
>> +	struct pt_iommu *iommu_table =
>> +		container_of(domain, struct pt_iommu, domain);
>> +	struct pt_common *common = common_from_iommu(iommu_table);
>> +	struct pt_range range = pt_all_range(common);
>> +
>> +	iommu_restore_page(ser->top_table);
>> +
>> +	/* Free new table */
>> +	iommu_free_pages(range.top_table);
>> +
>> +	/* Set the restored top table */
>> +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
>> +
>> +	/* Restore all pages*/
>> +	range = pt_all_range(common);
>> +	return pt_walk_range(&range, __restore_tables, NULL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
>> +
>
>[ ------ >8 Snip >8------]
>
>Thanks,
>Praan
