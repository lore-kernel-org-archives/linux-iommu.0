Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DC2D877D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291923; cv=none; b=c5bnxIXHgNx2TUupDSAehlMEUQg1fh9KcGFH8H/CQNcqSBpIzTnn1n/pnE+bnqNgKDdDHONLpjtp7b5fNJSJHo2cwfrSbEFeBVFdbxPddvntez/sYpYkwoP2m6ek7cNtFsyMDP1EM6iLqCr0Yx/OgQXkEBARsVzgbz96uvvmnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291923; c=relaxed/simple;
	bh=6QaR2oqSKNEPRho9RH+KkOaiYFeaDuoiPM8PClvNLCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kilHLLUjnAOyzPE0XdzW6VCsBTfpiWt9QaSJU9WJ8yODlJGhWhIr08mfMBE3lAPg2aFLttPlN0E/fg+vyYt78xYiQ84nLHIOA2weMfMWwie5HU0HqdyM3WHMJAOZh3fIKKq3Glg3pPL/zzyYxKd8HBAFyl9aX45f+isgCicP64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJIC8AUc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJIC8AUc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b052562254so19175ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291920; x=1774896720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g99lbUMVIyYkGv//TAIg6GhZ5xFInnNUBZAXzDDYysU=;
        b=sJIC8AUcVnJhsLzAcSL4koAvqsvWXVzWQMmfwmXT0m41DIfWio9Oglz8xTVnXZAcOr
         8UBn2otufe8mU4Pwl9DWk5gG0Ix6fNNNhppOV9X9GLg8FpBYrMJWVTD1ldrf+5WaWC3s
         myRuAb2+AyBbIrKebEUIw1cUBokO1PNWGHR4OGSavP7mxBzpHQ0MJ+BWOgs8eItu5g6G
         7Bv0KQvJNUwtwuPzu2jVOYH+qjn/iY0dfjzgM7yRXAwT7zLl4t+c/SRvee4hGoqHgQiL
         dcsuLn4Fjd8Wz3vkp4g2JNj6EfHRXdaPl+7k5fhn2xcg1UiCtFihn88Rjg2g5jOyLttQ
         qD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291920; x=1774896720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g99lbUMVIyYkGv//TAIg6GhZ5xFInnNUBZAXzDDYysU=;
        b=LQMz6KKy3fHNHPHjfMdXsr6jziU7WcEZSOkQE1TQ3p4GpkWJcGM4x5sxO0a5xB9y9w
         bGBXtZxGyh81BvzKOmeTpulzvSTAIHZ5ro5hF9g56gdhe4ben2etTbJGISi/44rwOGQq
         RwRGbzmBkUTtCFE2MdD6Los1rNG6OcNMUa3N38uL0et8d7qFjjVqsT08/71+vuPkdKVJ
         dvCiJG089UI8Vl5nq0xSoK55bFJ9Jg1cKRFdRZOSBCBG0k8kF5EJl2GpXz+jRcz1XvEU
         T394FbsysLb8yyFUjANgoDptPw79+DOV6TiB0o4trHkaG7zcQldFRxn2o7jVKdualciv
         mVyg==
X-Forwarded-Encrypted: i=1; AJvYcCW4gliIx1YxJxI8UTUtUBDSGYO89cQE1Y4TL7S0y/lJ0J9xMOnxkP8dkWUFDgZYIPnnru4aMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZJIcJBhiYGpW2d9NB/lzWKZ4S/shDiApqP/mJfVdULxvBmlu7
	sQNYxI5pYM+XuWAdSeOBGkIbDq0Iiw59uTVWVAVt7tbe/ucJXoRC8Ws9SoQtTMkDcg==
X-Gm-Gg: ATEYQzweZL4uZTqLKA3Dy/cUjzkzBvGNjPnpZIOW2sGiSw/PYQwCj+dZr/reFTmHEhR
	wunYWAeAEAb264JypVf0dwl6eFbm1dDmx6KJZW3XmqydRpGkqp//IG5l5c01BzCW10pBQj21gVb
	go4Cez/m+ZIv54fieDsfSdfBSVi+2Y2O8mxuezPG423nG4jrUX2SZlLdrTG85j86c59mRYy49K9
	j1f4RrAqN/Eszq8HigirgP17uR3LV1TuiykR3/Iu4rm7/3tJpV62pWddeovXVe9ngcy6tpm/tyV
	vVYhbuhoRAvaEh7C1rqf2KDQuB+PGuFKqXIrpQqmh0llHY+EL6/kO1ArwpbYeey3R7alAuwhC3T
	IGRZvhPmtweQclv69CY3JaiHM+7lZK8MEKi0gSgHtuqHFxnDMvh8iPhBWTVorI1deWN2+SUb3eb
	3MMcp8CMgboZ2fHOj77wO9JkfNunpVRkTBqiyIZDlKil3pVYGphRIsTlfyRpBmSA==
X-Received: by 2002:a17:902:f94d:b0:2b0:9a61:9d9 with SMTP id d9443c01a7336-2b0a5573ecfmr326635ad.9.1774291919398;
        Mon, 23 Mar 2026 11:51:59 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b15fbsm153483935ad.81.2026.03.23.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:51:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:51:55 +0000
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
Subject: Re: [PATCH 09/14] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <acGLfrpMz4JbxaqS@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-10-skhawaja@google.com>
 <acGEJhAQKKknC3n8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acGEJhAQKKknC3n8@google.com>

On Mon, Mar 23, 2026 at 06:19:18PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:43PM +0000, Samiullah Khawaja wrote:
>> In scalable mode the PASID table is used to fetch the io page tables.
>> Preserve and restore the PASID table of the preserved devices.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      |   4 +-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 130 +++++++++++++++++++++++++++++++
>>  drivers/iommu/intel/pasid.c      |   7 +-
>>  drivers/iommu/intel/pasid.h      |   9 +++
>>  include/linux/kho/abi/iommu.h    |   8 ++
>>  6 files changed, 160 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 83faad53f247..2d0dae57f5a2 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2944,8 +2944,10 @@ static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
>>  		if (info->iommu != iommu)
>>  			continue;
>>
>> -		if (dev_iommu_preserved_state(&pdev->dev))
>> +		if (dev_iommu_preserved_state(&pdev->dev)) {
>> +			pasid_cleanup_preserved_table(&pdev->dev);
>>  			continue;
>> +		}
>>
>>  		domain_context_clear(info);
>>  	}
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 057bd6035d85..d24d6aeaacc0 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1286,6 +1286,7 @@ int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser
>>  void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  					       struct iommu_ser *iommu_ser);
>> +void pasid_cleanup_preserved_table(struct device *dev);
>>  #else
>>  static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>>  {
>> @@ -1309,6 +1310,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>>  							     struct iommu_ser *iommu_ser)
>>  {
>>  }
>> +
>> +static inline void pasid_cleanup_preserved_table(struct device *dev)
>> +{
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>> index 6dcb5783d1db..53bb5fe3a764 100644
>> --- a/drivers/iommu/intel/liveupdate.c
>> +++ b/drivers/iommu/intel/liveupdate.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pci.h>
>>
>>  #include "iommu.h"
>> +#include "pasid.h"
>>  #include "../iommu-pages.h"
>>
>>  static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
>> @@ -113,9 +114,89 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  		iommu->reg_phys, iommu_ser->intel.root_table);
>>  }
>>
>> +enum pasid_lu_op {
>> +	PASID_LU_OP_PRESERVE = 1,
>> +	PASID_LU_OP_UNPRESERVE,
>> +	PASID_LU_OP_RESTORE,
>> +	PASID_LU_OP_FREE,
>> +};
>> +
>> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (op) {
>> +	case PASID_LU_OP_PRESERVE:
>> +		ret = iommu_preserve_page(table);
>> +		break;
>> +	case PASID_LU_OP_UNPRESERVE:
>> +		iommu_unpreserve_page(table);
>> +		break;
>> +	case PASID_LU_OP_RESTORE:
>> +		iommu_restore_page(virt_to_phys(table));
>> +		break;
>> +	case PASID_LU_OP_FREE:
>> +		iommu_free_pages(table);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int pasid_lu_handle_pd(struct pasid_dir_entry *dir, enum pasid_lu_op op)
>> +{
>> +	struct pasid_entry *table;
>> +	int ret;
>> +
>> +	/* Only preserve first table for NO_PASID. */
>> +	table = get_pasid_table_from_pde(&dir[0]);
>> +	if (!table)
>> +		return -EINVAL;
>> +
>> +	ret = pasid_lu_do_op(table, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pasid_lu_do_op(dir, op);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
>> +	if (op == PASID_LU_OP_PRESERVE)
>> +		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
>> +
>> +	return ret;
>> +}
>> +
>> +void pasid_cleanup_preserved_table(struct device *dev)
>> +{
>> +	struct pasid_table *pasid_table;
>> +	struct pasid_dir_entry *dir;
>> +	struct pasid_entry *table;
>> +
>> +	pasid_table = intel_pasid_get_table(dev);
>> +	if (!pasid_table)
>> +		return;
>> +
>> +	dir = pasid_table->table;
>> +	table = get_pasid_table_from_pde(&dir[0]);
>> +	if (!table)
>> +		return;
>> +
>> +	/* Cleanup everything except the first entry. */
>> +	memset(&table[1], 0, SZ_4K - sizeof(*table));
>> +	memset(&dir[1], 0, SZ_4K - sizeof(struct pasid_dir_entry));
>
>(Not too familiar with Intel IOMMU / VT-d)
>We seem to hardcode SZ_4K when clearing the directory entries. But in
>intel_pasid_alloc_table(), the allocation size seems to depend on
>max_pasid which could be larger than one page (order > 0)?
>
>If the directory is multi-page, won't we leave the trailing pages
>and full of stale PDE pointers that the HW could still walk?

Agreed. It should cleanup based on max_pasid. Will update.
>
>> +
>> +	clflush_cache_range(&table[0], SZ_4K);
>> +	clflush_cache_range(&dir[0], SZ_4K);
>> +}
>> +
>
>[ ------ >8 ------ ]
>
>Thanks,
>Praan
