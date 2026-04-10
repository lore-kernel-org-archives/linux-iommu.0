Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A92741B6
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862180; cv=none; b=X8jBanqXdQJj6Hosfh3iv5a5IqTR2XQJ9uA+C3QUpCEQAsXWN8JVcT+XDQtmQwCj+NF0knl8MQ4+FVpEHwxZRhO7lQiEIAX35fdKwPPrRWw9NbHdp7awbAL4zWGiLeVTc5gGfn/PdpNLKcdjOKeY64s8QX+mGiAxQ2yZPPuJVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862180; c=relaxed/simple;
	bh=DYTNLb98hZeGxyI5R92ohATyRHWcsN36bzgF2YeqRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty7MxRhlVG9Ui0pbBKLX8BVmMLz1mT+At5kJyB1AeSso01hCKiYY2rpTn8BDu2g8pbj+3ndeidX0ZF78yZ29uLSAmLy1eFAq8xNRCjhT/IeujW5MLrHB/LGmQFHq7qDvcF8nHjL2V5Jf92NdtL/UFOII7NflFEPy8QWotnaMBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGPyGGld; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGPyGGld"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9697so25898c88.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775862178; x=1776466978; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sDo9cCb4JlomwDlOw2QqnoywLS/P6wn4vikeZZXB08=;
        b=iGPyGGldx8Eb+IMjhRs6E0QzDVx1NoAmq6F1PmXLfsTn0dmfTJVNr+Yw6JCxjG/ynT
         aFy/YyMUa95N6l8LezV14SwsbHt6RFBzxGZ/dilrhFMz1LggO26K+ycvuyW6lGiUl8yD
         wklqbpelPchlc/8qNF6JQKUOKMkNRcmiURJtl6IEmtMxrrNjmtd/ZhPIhLpspUHYZnlD
         +c76c+DtcBKwreT/ISr3/7vx9Kc2AC8ZzvV6UJbwAtCsUFwyKcbjfFoFWA0KvUheFN5/
         cNMc0Jrv+JIfNWdF89FFMzRxM1ZK1G/h8TUAMGe83JFmrJIQfsdJS4rC3O4bE1dt5qlC
         gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775862178; x=1776466978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sDo9cCb4JlomwDlOw2QqnoywLS/P6wn4vikeZZXB08=;
        b=nJghW2NDFD/8OMwTb8F4/9s4N7+eAC7zOVAl2XfBSMEn4j1FdCv/gJG5LpO5LjRnAm
         OkdmTGaOVuPaGZFHJYXUu+GJonNAf9L05Hr1hYhOQeW8Xa6/RrguiGWfTyrdi6rwXI5T
         2Q3HZu+o6Ft3SoyZFNB7WMUo2Gtvz9Hp5f84iAa1sgHMchTDtIABXuglcNDa2RW+aCAj
         DjWXJoqopVV7aOlBWKk4iVG/b9OOIvQqU0kxFu+lBIZSv8IxCflEakKtwOYA9TWA7bCK
         Vk+31ahtpY8CkJORE71PEi4dtj07/ZIQZ7swbH6AkgQaIFsGRRj9oak7uV6e+PaSHADt
         KCUg==
X-Forwarded-Encrypted: i=1; AJvYcCU+dzKwh1lBaNd88ffA82YNJPn8t3bpZE1ZgJ5altAxVgerVjlDZc6d0svFO617eLhIs7BX9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4JZnzu1cu/3tpqjsAYutkUyum9C5Ai6xSnvAVDt5ZtykN61Y3
	reqATEJUwaCpKjV2rp9S5KSbnY/jciPxZla3ulFoEr7fB+K8y6xeEhHPU8WR7gQGxA==
X-Gm-Gg: AeBDietlPX4UkwteIEG8RqRSGnO2lejIxggGv0ebpPg6vv4/J0RgsvVU0NExIhSsXdT
	8Ol2OeF2cVZuf06FButPzc+ettFmJMSU46Qj4Nqz8rpnQ16TRZ5FOSr3YbB52vCQatOayZUzWwf
	53d7LcJ0H+ujV/mr+UUemLnktZ3WQItBuF2LHc72jg4+QY/iAedLZZelEakG105J03+2CweAHq0
	QzvwlYN4y4b8/lCEaz1OUDGWpryrl+3jFF5F43zXdJWeLVRQC9nEIx5Nyc3ODmfk/Lk/tQaic/V
	O95itEhHOPbYhrs6EmtEkH/RZ+r1SOoAZAnINbUihh19aVh9gaLOvR6mIbP9W2nDtFu0USvHLRS
	yU/qRbCUoV/eSRpgc7PpxoIZEFpAoK/JrkeG4ZZNHnheau1zCzjdVz40fR9T+lCFGTKu/czgH/6
	puYxHW6uIAok5KUmzNfQGfWNwBPnTSDeWIuvsHiFltKpp2dO4Fj7Qo+QnQseI7NCBL9x2dlZ2Z
X-Received: by 2002:a05:7022:48e:b0:128:ba6e:f809 with SMTP id a92af1059eb24-12c28ea0f68mr430372c88.6.1775862177534;
        Fri, 10 Apr 2026 16:02:57 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm7935702eec.18.2026.04.10.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:02:57 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:02:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <adl2QX6gra99bkOV@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260410141652.GV2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 11:16:52AM -0300, Jason Gunthorpe wrote:
>On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
>> > +static int __restore_tables(struct pt_range *range, void *arg,
>> > +			    unsigned int level, struct pt_table_p *table)
>> > +{
>> > +	struct pt_state pts = pt_init(range, level, table);
>> > +	int ret;
>> > +
>> > +	for_each_pt_level_entry(&pts) {
>> > +		if (pts.type == PT_ENTRY_TABLE) {
>> > +			iommu_restore_page(virt_to_phys(pts.table_lower));
>> > +			ret = pt_descend(&pts, arg, __restore_tables);
>> > +			if (ret)
>> > +				return ret;
>>
>> If pt_descend() returns an error, we immediately return ret. However, we
>> have already successfully called iommu_restore_page() on pts.table_lower
>> and potentially many other tables earlier in the loop or higher up in
>> the tree..
>
>It doesn't return an error, it just propogates errors from the
>callbacks which this one never errors. So this is just dead code.
>
>> > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
>> > +{
>> > +	struct pt_iommu *iommu_table =
>> > +		container_of(domain, struct pt_iommu, domain);
>> > +	struct pt_common *common = common_from_iommu(iommu_table);
>> > +	struct pt_range range = pt_all_range(common);
>> > +
>> > +	iommu_restore_page(ser->top_table);
>> > +
>> > +	/* Free new table */
>> > +	iommu_free_pages(range.top_table);
>> > +
>> > +	/* Set the restored top table */
>> > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
>> > +
>> > +	/* Restore all pages*/
>> > +	range = pt_all_range(common);
>> > +	return pt_walk_range(&range, __restore_tables, NULL);
>
>This should probably be doing something with the FEAT flags and
>ias/oas too or do you imagine the calling driver has to deal with
>that?

During boot the iommu_domain is recreated in driver and it sets up the
FEAT flags and ias/oas properly. Then this generic callback is used to
restore the page tables.

Currently the FEAT flags of a domain are not explicitly preserved, I
will preserve them and error out here if there is a mismatch.
>
>Jason
