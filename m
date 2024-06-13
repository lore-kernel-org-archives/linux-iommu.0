Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6FDF71
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289143; cv=none; b=NU4ye/u9j6bZyQpHp448T9oHcvULPld5ciaaGgqB3nznjn0Gq7EBYi9mB0ftpkPlf3lDrL0DwnES80tK3ZpivSjgct7m1OARKoj30PceHw1f5kKMJtTSJqB3kjn6wY44PY7iqaDSVa5QmoaFToHM7msN6GEDtI2wlSWcFkhh+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289143; c=relaxed/simple;
	bh=s9pYxu79H0EPoUuevhLvAvQwypMcb317ICFBo+uz0iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS/pFkWefoI6ZWzEfHiVg6+q4fDFgl03Ei1pRruau4E625QRlfdt1mBZP74Zyso5Kj9CWVG/91weMDQBo7kIWhj81ZXhSY0tENC+kZz6seUuWORXfYXQuDzx/hSakFp+AbECIecmzSTIpBxZakKX3p9sE7BOK74Yh8rVNmYOtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZWtwqnyM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZWtwqnyM"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso180202966b.0
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718289139; x=1718893939; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H8hdHd+JfSqX4icctlXjtDZnZCcoDc5cvXDOcUQHCnQ=;
        b=ZWtwqnyMDrlMrc3UrF/ym4hMswscJ3VYrbHrnCd8cl7Rurpta9KFQZ4ioeWTqY+Bqg
         ADHDzGYjDUl+ayLNVy/fbDxu/sMzP7HFrXFikSIyJKRSB2i7tz6SGfMJ7IcBuPMvBtvV
         LHEgySv/rg+t+QgISdXlscYEgI3idcYqztbin/Yue+htvkU4B2PQApX7nSI3FAVYN6sI
         lUrXwRHijXB3FIhIyrW6GFIcMeD85rapnb0VEVEosf2hgJXpsgDW3sTaxrSu7nq8RCTA
         +etzpmA48XpCT3VdrTC9eNpTiale1uLiNw2rcx+JRzKrO0qThJX0clYT7muZ/eR+NmH1
         uP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289139; x=1718893939;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8hdHd+JfSqX4icctlXjtDZnZCcoDc5cvXDOcUQHCnQ=;
        b=M2wkpQEs3IxBVPtp0pFvmrJpmJrh4WlU0lwsh9con+M4lTneFadIcckKmAb1SsEW7Y
         1Z2PwFblb66YApIYnYwUQmL2uH0HtdRamhrRjcogfhLPUNWTkVAVcDWjjpE3Cr+SV0g9
         Kcqd+l9pvqEDbOeXiJgCv/gdLjHRhlYTScu2X9yq1v5Ufu4be4CEin4u9+wxVK6l0iir
         0UpUe1YJsCg7/b53349XvMqjAgfFiL+3++RTn27Mcu2NuSDE9ski9HwCh3i1tKHh8OgO
         7Owy9MEkYDfL9N4e/ToVxoLc41mUKTQPtnZFksM2xSMBpeZzGz/bptxezEusHfSAaOHq
         oBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb90VBzlkttthAOeGva9dA7FffcQNmI2NUIMkzErQaNDCKuNvCFhTGzOYNCBF82LW9l8JJabr188BNaXJYazIuKP8nt04=
X-Gm-Message-State: AOJu0YwGwdIGhufc/pWYdRZmgnetBQmG8H/gOBCE1yn2x2muk4wYKx4T
	u5npxTar9IEVY5iAnAZMsfLbSTP+mYDfAs6zM6CBtPmX3CjXGNLb0RbBo2Oq7A==
X-Google-Smtp-Source: AGHT+IE2qhU5F+JpTGV9aNXNR4R4rO/hYPvUlKujrAOHJT5A7rvJJOddpFyigwaDJHM0jNu9Jjn3pA==
X-Received: by 2002:a17:907:944c:b0:a6f:56d7:2caf with SMTP id a640c23a62f3a-a6f56d72f33mr184680366b.30.1718289139347;
        Thu, 13 Jun 2024 07:32:19 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b98sm77613766b.86.2024.06.13.07.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 07:32:19 -0700 (PDT)
Message-ID: <8b0151a8-2293-409a-8469-d9e73cf561a3@suse.com>
Date: Thu, 13 Jun 2024 16:32:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/xen: Add Xen PV-IOMMU driver
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.06.2024 15:50, Teddy Astie wrote:
> @@ -214,6 +215,38 @@ struct xen_add_to_physmap_range {
>  };
>  DEFINE_GUEST_HANDLE_STRUCT(xen_add_to_physmap_range);
>  
> +/*
> + * With some legacy devices, certain guest-physical addresses cannot safely
> + * be used for other purposes, e.g. to map guest RAM.  This hypercall
> + * enumerates those regions so the toolstack can avoid using them.
> + */
> +#define XENMEM_reserved_device_memory_map   27
> +struct xen_reserved_device_memory {
> +    xen_pfn_t start_pfn;
> +    xen_ulong_t nr_pages;
> +};
> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory);
> +
> +struct xen_reserved_device_memory_map {
> +#define XENMEM_RDM_ALL 1 /* Request all regions (ignore dev union). */
> +    /* IN */
> +    uint32_t flags;
> +    /*
> +     * IN/OUT
> +     *
> +     * Gets set to the required number of entries when too low,
> +     * signaled by error code -ERANGE.
> +     */
> +    unsigned int nr_entries;
> +    /* OUT */
> +    GUEST_HANDLE(xen_reserved_device_memory) buffer;
> +    /* IN */
> +    union {
> +        struct physdev_pci_device pci;
> +    } dev;
> +};
> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory_map);

This is a tools-only (i.e. unstable) sub-function in Xen; even the comment
at the top says "toolstack". It is therefore not suitable for use in a
kernel.

> --- /dev/null
> +++ b/include/xen/interface/pv-iommu.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: MIT */
> +/******************************************************************************
> + * pv-iommu.h
> + *
> + * Paravirtualized IOMMU driver interface.
> + *
> + * Copyright (c) 2024 Teddy Astie <teddy.astie@vates.tech>
> + */
> +
> +#ifndef __XEN_PUBLIC_PV_IOMMU_H__
> +#define __XEN_PUBLIC_PV_IOMMU_H__
> +
> +#include "xen.h"
> +#include "physdev.h"
> +
> +#define IOMMU_DEFAULT_CONTEXT (0)
> +
> +/**
> + * Query PV-IOMMU capabilities for this domain.
> + */
> +#define IOMMUOP_query_capabilities    1
> +
> +/**
> + * Allocate an IOMMU context, the new context handle will be written to ctx_no.
> + */
> +#define IOMMUOP_alloc_context         2
> +
> +/**
> + * Destroy a IOMMU context.
> + * All devices attached to this context are reattached to default context.
> + *
> + * The default context can't be destroyed (0).
> + */
> +#define IOMMUOP_free_context          3
> +
> +/**
> + * Reattach the device to IOMMU context.
> + */
> +#define IOMMUOP_reattach_device       4
> +
> +#define IOMMUOP_map_pages             5
> +#define IOMMUOP_unmap_pages           6
> +
> +/**
> + * Get the GFN associated to a specific DFN.
> + */
> +#define IOMMUOP_lookup_page           7
> +
> +struct pv_iommu_op {
> +    uint16_t subop_id;
> +    uint16_t ctx_no;
> +
> +/**
> + * Create a context that is cloned from default.
> + * The new context will be populated with 1:1 mappings covering the entire guest memory.
> + */
> +#define IOMMU_CREATE_clone (1 << 0)
> +
> +#define IOMMU_OP_readable (1 << 0)
> +#define IOMMU_OP_writeable (1 << 1)
> +    uint32_t flags;
> +
> +    union {
> +        struct {
> +            uint64_t gfn;
> +            uint64_t dfn;
> +            /* Number of pages to map */
> +            uint32_t nr_pages;
> +            /* Number of pages actually mapped after sub-op */
> +            uint32_t mapped;
> +        } map_pages;
> +
> +        struct {
> +            uint64_t dfn;
> +            /* Number of pages to unmap */
> +            uint32_t nr_pages;
> +            /* Number of pages actually unmapped after sub-op */
> +            uint32_t unmapped;
> +        } unmap_pages;
> +
> +        struct {
> +            struct physdev_pci_device dev;
> +        } reattach_device;
> +
> +        struct {
> +            uint64_t gfn;
> +            uint64_t dfn;
> +        } lookup_page;
> +
> +        struct {
> +            /* Maximum number of IOMMU context this domain can use. */
> +            uint16_t max_ctx_no;
> +            /* Maximum number of pages that can be modified in a single map/unmap operation. */
> +            uint32_t max_nr_pages;
> +            /* Maximum device address (iova) that the guest can use for mappings. */
> +            uint64_t max_iova_addr;
> +        } cap;
> +    };
> +};
> +
> +typedef struct pv_iommu_op pv_iommu_op_t;
> +DEFINE_GUEST_HANDLE_STRUCT(pv_iommu_op_t);
> +
> +#endif
> +
> +/*
> + * Local variables:
> + * mode: C
> + * c-file-style: "BSD"
> + * c-basic-offset: 4
> + * tab-width: 4
> + * indent-tabs-mode: nil
> + * End:
> + */
> \ No newline at end of file

Nit: I'm pretty sure you want to avoid this.

Jan
