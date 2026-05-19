Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71348BD3A
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210906; cv=none; b=UT3Ne7J6QNg8NrzcQljXyeGhe3mSLiIPlQo8q8hk/E5PDV9NL9aDhtEmXjcCgfOQwy0qMh0Pg+92GNPp6Ik9KYaiPtU+ao8OUDrgFFMWjcXfnrp+EvT/OH7WNMxEfeSZ/plw+3KGBZLNoCipImqhIBTpfviyoHkgc2Wkizty8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210906; c=relaxed/simple;
	bh=N0olbpp4+tbbF00EjqkPnSM7waYwBC1YIklDoPh4SKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnc5+vSLwSoeVGxgJNamzrUzxFvafWI1JmUVZ4itHA9yr6sjbfyWcry16vfcf5jUR/hbT+HhzybmpiD4l5SaWoX1u4xVwldwCjV5eKePxhVbQsyMz1Oe5cERaRneyi5zdDW2+UEsUg2tztJlD5YKwjFM69uYTTUAge7yKEw6XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIFfX+wc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIFfX+wc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so445ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779210903; x=1779815703; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvUscp3TmdBdYJXRIEvO1MdmjothbiB8jYKdWN5DkYE=;
        b=FIFfX+wcckHgWLa1v2dYKRaE9ybqZFYb77MX9cpqZOOM4TJcHo197y/RcB7Z35dyD4
         38hMsOPOy+kBUhGjdNhYkbWdQIKLIscELRXp7YmZPMHdl/6XSYX61ARFHJJf3GgHWjDJ
         9G/r+qlO6PRIprqBzGCWJ3JxcQobCkRA6fQf2SyTfBqVedXiShk4+IfoWnmJKAiN89dk
         YTZDsuXViJiqZRsG2ZJW/kLXEmWbOpLCqYlOYmuVL5U569K4LeQf3F4iUAqJkoPZxjPJ
         0PVE394NqNNLeWuydrmTRU/1S+WamOrI1oX2GcGYtWLFR1zPNaMCrKc031dx9rAAjoQD
         uKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210903; x=1779815703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvUscp3TmdBdYJXRIEvO1MdmjothbiB8jYKdWN5DkYE=;
        b=UFXMb26bCPAQ06ONK/xcwQ3FCPNYrPCUjCeC+zTr2L/z1wbaUetjVDWDpnlcK1bVxk
         0pVDkk+7/d/yviCKph5MvboteU5NmXIeV8vh+64PMPGBRDqFcHZ0/AKWL+1btmdaKxL0
         rTpeDQ8n85eJQqBFPk1184t1R21CiklK6upUMOJ8Ngy8uVRM7rasWCEMsCpjHVRWhuUn
         heAaxuEMHJzm2tzbYbiPYtr6FfQokg1kn+K65oGBvLe5MI5c1OuWUCG/7iC2lamNuoFi
         berOyDkkLk9rURXNmjxxwNdaWX8ZpCAK5kPRRVBGDzqLvPWUvFTTFffQ37PdlZboYEV2
         5mFw==
X-Forwarded-Encrypted: i=1; AFNElJ+P59Ku8WBd18oNgpLPBO6a8QivJZDVQHfC8zvqlIafDJS7CyxhbOA93Gj4ub6UROukh4NsJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEALzviV+kuKcIglmDuH4vnUoOjwicTAh381TCpkdeItdbcE9b
	edAjjlXNPNqyRj+mXatDfgoRhiqFcT5qIVQTdt/iDfPXY8XYcmOhMwS2REvVT1b9hQ==
X-Gm-Gg: Acq92OGiI7m7yYFd7UkhKs4ekaCJ4nSzJ9CECchsaY9tBM/naqNGdOuE4tHo8V+pg3g
	D+z4dBcKglnE7GfPQCiYyYae0NurpabeO8/S5Ec3vyrFqi0nOp41r2Vyz5XXD7pYtC/Rpyxmttv
	2o4fv27PBCyoaVpKekJnVXDSDQIrOECe4KWAPLfrJ+uVK8+vpjMcQEEKrAGN+SSzFI2+aJflDd/
	pCP6SOHIe1IDFJ7I16+vdckSS4oYWd1NhqqIbYceuOuIz54jK8B8nFVUbe3HlMW2HY+S6rq/TZ1
	3sw5EVeQUTLojgVYMiXZRzAzh0+so2UyvKlv3N0z2Z01fr0ZX8BAUVfRRFul8Se6RpOJ58HfLsc
	4sjZTOiw7VNDwZCHJx9ttxo2FrafuGQ8iSyfqlPPlNoCnQFRdXy56q/qhKH57OEW6ZSheRjMG/b
	+ngGYLf8QN34ieC6qsdpokRHfvNh5+yZNEz/BoXsl1a8rexcYYy0KjtdWxILObWC4fEe32oQ==
X-Received: by 2002:a17:903:1b67:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bdb03a2d5dmr6496795ad.2.1779210902187;
        Tue, 19 May 2026 10:15:02 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm18103728a12.23.2026.05.19.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:15:01 -0700 (PDT)
Date: Tue, 19 May 2026 17:14:58 +0000
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
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <agyaeRExaL6Tm47V@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <agxiXNalisHyNkGt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agxiXNalisHyNkGt@google.com>

On Tue, May 19, 2026 at 01:15:08PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
>> Implement the iommu domain ops for presevation, unpresevation and
>> restoration of iommu domains for liveupdate. Use the existing page
>> walker to preserve the ioptdesc of the top_table and the lower tables.
>>
>> Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>> the next kernel. On restore the domain has only the preserved features
>> enabled and all the other features are zeroed. This is ok since the
>> restored domain is made immutable and can only be freed. A kunit test is
>> added to verify that the IOMMU domain free can be done with trimmed
>> features.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/generic_pt/iommu_pt.h       | 131 ++++++++++++++++++++++
>>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  28 +++++
>>  include/linux/generic_pt/iommu.h          |  19 +++-
>>  3 files changed, 177 insertions(+), 1 deletion(-)
>>
>
>[...]
>
>> +static const struct pt_iommu_ops NS(ops_immutable);
>> +
>> +/**
>> + * restore() - Restore page tables and other state of a domain.
>> + * @domain: Domain to preserve
>> + *
>> + * Returns: -ERRNO on failure, 0 on success.
>> + */
>> +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> +{
>> +	struct pt_iommu *iommu_table =
>> +		container_of(domain, struct pt_iommu, domain);
>> +	struct pt_common *common = common_from_iommu(iommu_table);
>> +	struct pt_range range;
>> +
>> +	common->max_vasz_lg2 = ser->vasz;
>> +
>> +	/* Make this domain immutable.*/
>> +	iommu_table->ops = &NS(ops_immutable);
>> +
>
>Nit: Let's consider adding a comment since we just have .deinit in ops:
>
>/*
> * Restored page tables are strictly transient and only permitted to be
> * destroyed via .deinit. Because we only preserve user-assigned devices
> * utilizing pass-through frameworks (VFIO / IOMMUFD), any concurrent or
> * subsequent map/unmap operations on a restored domain are explicitly
> * blocked at the subsystem boundary (e.g., via IOAS immutability seals).
> */
>
>This makes it explicitly clear that any nullptr dererfs occuring due to
>immutable_ops->map_range etc. (in the future) are considered as bugs.

Sounds great, will add a comment here.
>
>> +	/*
>> +	 * It is safe to override this here since this domain is immutable and
>> +	 * can only be freed.
>> +	 */
>> +	common->features = 0;
>> +	if (ser->sign_extend)
>> +		common->features |= BIT(PT_FEAT_SIGN_EXTEND);
>> +
>> +	range = pt_all_range(common);
>> +	iommu_restore_page(ser->top_table_phys);
>> +
>> +	/* Free new table */
>> +	iommu_free_pages(range.top_table);
>> +
>> +	/* Set the restored top table */
>> +	pt_top_set(common, phys_to_virt(ser->top_table_phys), ser->top_level);
>> +
>> +	/* Restore all pages*/
>> +	range = pt_all_range(common);
>> +	return pt_walk_range(&range, __restore_tables, NULL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
>> +#endif
>> +
>>  struct pt_unmap_args {
>>  	struct iommu_pages_list free_list;
>>  	pt_vaddr_t unmapped;
>> @@ -1138,6 +1265,10 @@ static const struct pt_iommu_ops NS(ops) = {
>>  	.deinit = NS(deinit),
>>  };
>>
>> +static const struct pt_iommu_ops NS(ops_immutable) = {
>> +	.deinit = NS(deinit),
>> +};
>> +
>
>[...]
>
>Thanks,
>Praan

Sami
