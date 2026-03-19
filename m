Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184D3E63A6
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937690; cv=none; b=j7JN6xVCfRU5SEhwfrh3XePmOCrT7urB7yQJ5ZFJR63W+DNCl2fXD/hwAjx55knZ7JiXjiE0ZETNFPjnw4sNXnyuo4U50oqdKlzL3wy7hj+GKzFotnmDq3GF7tHh3Vsu6MkClQD8XMh5wb3QIZVjnthfiCtgpf47KtyeZ4+AOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937690; c=relaxed/simple;
	bh=Ci8R0RcgT3R07Pso4NtY3exaPjxumuK/t2Ur7NUnLVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is8HZovtpDVe/Y6TLvLLUiRnX4LJE0LQUoAyYRg+7lL7KXv3SXNX9V5b6hiV3JYT6HGIMx46uvR7o+81EYgI50oTY5GF+z1wR89uybdmavq79Y6Qp3TFumsK1j/Cz6FFZuNpL5pbQ73t2FJqzvoN/Q+6YqrwSICs9oSVcdB7/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7JuCO0f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7JuCO0f"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so95155ad.0
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773937681; x=1774542481; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8zoqnsuMjvOgf8bCpxiEMnB3Rfs/RX4TqY+c0PAvBo=;
        b=d7JuCO0f3nJb2kwRMAf0SvXQLf0h46XvQYnOS6egGrpTjc/APgJ8eytL5UZjw3macy
         w/wOzs0+mAS3gNeeIwKGIyfFqSRee0txQTMR3p3Mmz6Rh9OW/Dx2Cwh7D5lN9upGQjEk
         y/A+9XmV8a89uTvxJEx5MzTz5MuKkExKUNmbaTRBNMKI79knQDIfXB7LpEQU/lAvVOKs
         F58nGkfmZPk/Upb6wSnqNcSQZ3nIOnfcy1QJ/bEgqesWi2DGsELpcxQItEcwmeOveOhx
         qefLWfAR5KFg+EzcRRn2GqddnkxCrXSIxHAkX7bxnq+PKa8joG4jtAkHv+wedIpUAekG
         e3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937681; x=1774542481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8zoqnsuMjvOgf8bCpxiEMnB3Rfs/RX4TqY+c0PAvBo=;
        b=reFSck+cEN1zgFGQM2pBRd1qwR80jOuUgxavYV/NztxPVRLvdNaQXZNeGVkyEHcg4x
         eEK6NJ9Fvzh6DZkSnNHZd/IBTRa+Fspm+Okj3hm7YKR+DePLZvlzJZhVI4zl+9VmOCdY
         n6XK3rKZoiyMmiwaQMczgBXd9rM7dd3xJaIlcimCciptcJu5bEsL87+62sxzblxJkGv1
         VyLiSsuYPqnsVODi4VMPuhPecZCvWjX3eiSfS5jE8qyJJVh/0zkSZ30oO0/4IlGrDC8x
         VQcNRNQVNreygjUpajmJxQX45AhyJco3/dEuo+4A2ItQfs+xjYQappj2qJsFWDXa7wmv
         pscw==
X-Forwarded-Encrypted: i=1; AJvYcCXXIgMWP6AmSXiVPv5VJxgPAg5FFj6vd/YasUrBU81P49t59ODEsJ7bh78bK4KlvRvBwUnuRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvK/2BDa47kMqaeUG2DCIBhr0Ol1Oqdo1jL8hEYcNZu8hrWzwl
	j8tE9SB9M1SQHb+wz5SoBFFKSt3tV56emNqdvNwRer3dba7JVzsNxGzclvh9y7gzdA==
X-Gm-Gg: ATEYQzz7TNrSyZM+ZPEQWkBOojKMfBl46pR47EkgqbmgQp0BhU1pKV//wsvfA6qRjs0
	7ncrVVRfNJPNHQioayQQ8YB/onOKtwUT42pkORkkL5o2CR3yp2ZTOT9sXqLXoSVfwnPkX0PMH7I
	fZvClozSF+JVsLuvdro35LtwVEeNGHu0k9443MEuBbkGd0gMRNkuCPpnBS4f9zlvB0Kzl51UxMO
	rsI6PF3PtEBo24ITOKVouZEQFpJlslEfl0YFAtgCqxKdNHav7xEZ6h5h2YRTC2kUnB8d6IZ4g3R
	UsN8KgM/cYB2epypc3HXC0wdLme/vMCTIfEC3oeqxHyrUUIIdFPgVUwGIENgSWoXcINjc3rcV+N
	Rc9MfmwivMwk+8RVb2zz2ITlXff5PK+hlqG0LkJncRNuFP6Pesd2oe0AwUvsd1EtR7yc708ARkk
	BD0U8cOnQlinZ5xxZxYQJyRCcLctOkTDkAHKqtuml5mP60h/AjfC32Dk3yAEMHdA==
X-Received: by 2002:a17:902:ccc4:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2b079fbb39emr2323775ad.17.1773937680332;
        Thu, 19 Mar 2026 09:28:00 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5691b8sm5635536a12.25.2026.03.19.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:27:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:27:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <abwg_tuERUKIsdfH@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
 <20260317221907.GD2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260317221907.GD2582517.vipinsh@google.com>

On Thu, Mar 19, 2026 at 09:04:31AM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
>>  /*
>>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>>   * if marked present.
>> @@ -2378,8 +2379,10 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>
>> -		/* Make sure the IOMMUs are switched off */
>> -		iommu_disable_translation(iommu);
>> +		if (!__maybe_clean_unpreserved_context_entries(iommu)) {
>> +			/* Make sure the IOMMUs are switched off */
>> +			iommu_disable_translation(iommu);
>> +		}
>
>I think instead of having a "maybe" function where it might or might not
>clear the context entry, it will be simpler to just make if-else
>explicit here.
>
>@@ -2375,8 +2375,11 @@ void intel_iommu_shutdown(void)
>                /* Disable PMRs explicitly here. */
>                iommu_disable_protect_mem_regions(iommu);
>
>-               /* Make sure the IOMMUs are switched off */
>-               iommu_disable_translation(iommu);
>+               if (iommu->iommu.outgoing_preserved_state)

This is only defined when CONFIG_LIVEUPDATE is enabled and would need
the #ifdefs :(.

But I can add a function, iommu_outgoing_preserved_state() or
iommu_is_outgoing_preserved() that would return NULL or false
respectively when liveupdate is disabled, in the skeleton patch to check
this.

I will update this in the next revision.
>+                       clear_unpreserved_context_entries();
>+               else
>+                       /* Make sure the IOMMUs are switched off */
>+                       iommu_disable_translation(iommu);
>        }
> }
>
>clear_unpreserved_context_entries() will explicitly do what
>__maybe_clean_unpreserved_context_entries() is doing.
>
>>  	}
>>  }
>>
>> @@ -2902,6 +2905,38 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>>  };
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
>
>Nit: s/clean/clear, this matches domain_context_clear().

Agreed.
>
>> +{
>> +	struct device_domain_info *info;
>> +	struct pci_dev *pdev = NULL;
>> +
>> +	if (!iommu->iommu.outgoing_preserved_state)
>> +		return false;
>> +
>> +	for_each_pci_dev(pdev) {
>> +		info = dev_iommu_priv_get(&pdev->dev);
>> +		if (!info)
>> +			continue;
>> +
>> +		if (info->iommu != iommu)
>> +			continue;
>> +
>> +		if (dev_iommu_preserved_state(&pdev->dev))
>> +			continue;
>> +
>> +		domain_context_clear(info);
>> +	}
>> +
>> +	return true;
>> +}
>> +++ b/drivers/iommu/intel/liveupdate.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2025, Google LLC
>> + * Author: Samiullah Khawaja <skhawaja@google.com>
>> + */
>> +
>> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt

>Should this be 'DMAR: liveupdate' to be consistent with other files in
>intel iommu?

Agreed. Will change.
>
>> +
>> +#include <linux/kexec_handover.h>
>> +#include <linux/liveupdate.h>
>> +#include <linux/iommu-lu.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +
>> +#include "iommu.h"
>> +#include "../iommu-pages.h"
>> +
>> +static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
>
>Nit: Can this be unpreserve_iommu_context_table(), similar to existing
>free_context_table()? Same for corresponding preserve function

Agreed. I will change this.
>
>> +{
>> +	struct context_entry *context;
>> +	int i;
>> +
>> +	if (end < 0)
>> +		end = ROOT_ENTRY_NR;
>
>Can't we just pass ROOT_ENTRY_NR as end value instead of -1?

Yes, we can do that. Will update.
>

Thanks,
Sami
