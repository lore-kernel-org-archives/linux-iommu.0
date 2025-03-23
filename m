Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1D35947;
	Sun, 23 Mar 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729762; cv=none; b=sd5o3FeucOK/u/Yx5yndUuMDp/XgPB/PZDF5HRbEWpsOMq3IhO8pCFIq/MyUIw7ZzupocOneYZOB0rvAVmixovA3Tk7SG1sXH2EnNNzeQ979ogyU/b+B4v4ELbQ4QYP7dnuXZUzjTZeQ5Q3VJL+QU/60TKa7LBKUfOlSv9TOFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729762; c=relaxed/simple;
	bh=vxqD9fQ0riCAby3fUhv76PYUNSKXaRoQ4ZVMDVN1oec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=Fz/9E+PGyHddJQnAFSFNbmwJwI5H5Tm+gJewJ5OTXfGDG69VAvz9CEADLSY+rD+C1iReKFx2AHLXLD1LSJXLQh4i7QUv5vetH5W3151JcWx6WZtckQ7V6Klh7Lvi7jl7/cr+B6SfcZCXdTR22nrBop1LKXUEdsZn/zx+nLm6h9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehvs5Yx9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehvs5Yx9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29af3382dso580881766b.2;
        Sun, 23 Mar 2025 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742729758; x=1743334558; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulYi+eY/hFy7Rpw8ZWtw9DJBvuhlwhkseKvZOaTPlmo=;
        b=Ehvs5Yx9hzfJz+RYM+XtHVCF7nxAyr1GNw1ThmNOcs7NxzoYcCGKf2zQawr54HOWjk
         26q2JMgO7p5X4iGllj/s9Hpcn3tYhmD5GHTZ03VNIPGuSKf8NdmrZmWfBf1XlYCPxAo6
         zHFrEF0/CIBp9ycPFfPJ20jpi0WWpZOaVBvMmc24XLxUcBQlsXFCSIFkldXrF9+bJ5dB
         W/BICMYZTeA8MpRSWvzdvjZhnsinEWTyOjd35uBEFJ+TJPu9ZXvWkE1HNNjVQJO/Tov+
         u7ASKClFYLrY6yTZ5outQ3NIJjBX4KKhHN/tlooy8P3QU+lBUOKtzp1WaMBTWNaLzEhm
         ltgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742729758; x=1743334558;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ulYi+eY/hFy7Rpw8ZWtw9DJBvuhlwhkseKvZOaTPlmo=;
        b=PA+N7CcjZkMqMh+LdNxhSWiUvY2hy6QyYjVYLh9KXsu27HXUt9K4P0wIOkYOdz93Cw
         HR7gcljvKb3tgUS7p351fclatfEbkM1CSLpk0bmlHYl7f2AKrZz7C3U/lLSqepxv64c9
         7M+8xPagsfDQhLK02U83pathZ2ZhVFfdrtQya3YCq25NamxgEjXF/oei1KAun0zf7GZ4
         aG76RZSRLqMT4EUcnvLdjPVsOoVlsI+m6slCddCeN0Inu//M6PlAcH5IihQLF8pMK54h
         8eL9mPq8dBD0GRPX1Ll7ush1Tv531fxgUeRzsnftSVANq1BRFjbMYUTZ5guE3/0PLvv7
         B0jg==
X-Forwarded-Encrypted: i=1; AJvYcCVsL8ID7A/BTbzrnKk2ZoadCQxsE84ZWRA/95qv0MfYKk4TC4EQoVlKxMwHtDqlujYtnScLKU1ZrfDRHw==@lists.linux.dev, AJvYcCVtfujagNxCfY8/mrWXMiN80m/iVMiAzHXyLZHX0ss8VWd0Grg4NotJwFGDBWQMyhWrGhR49w==@lists.linux.dev
X-Gm-Message-State: AOJu0YynzO6qHmgZYI0Rl1iOEIYnwbfcQE+mueHKkHYzJ8DPiflpmt95
	5bWkCxHWRU3adHOQWtHWxEorrJFsyE3RUAXenl0VBY7Fqm7VyXRQ
X-Gm-Gg: ASbGncsrTA+9vkWorKHd4Uc9MadgyQL01TLU3daGpVvg0T8zvF2wNP+2uOQOHJLS6mJ
	sRMcRnInhlzoaNVsCYgPDTn5xGVVlIkOZZVTfhQ8xRFgsHOrwIGw0HnPP4ihMh8eqrZqhpzU1wn
	ws7wD3XslkX+YPr5Ksbpbh7shlwLU8blM+UYk5A5PY3rIME0rYFBY1yFARw1rgILG2iKfnqlPrn
	eO27TsDBpdViY9wHNwPvXO3jJEkEsuGPSGBE07tuO3DWa+em91FJdyfd/ZeyNn3eQJ04XpOKHBw
	M+Gc2XrNma8NF1G8K5NDQMXkqBy9IFnxOuR2RsiKiCm5Lu+wkWZFFvc3c3zOuyvou6popU1Ef/3
	s0C8cWru/gj7nxJj0+vfFl/pwrQ==
X-Google-Smtp-Source: AGHT+IEzF59fM+1sXKTJnQXrcFoM0BGGjWdJktjtNJk+BRvhUOw/UEJ7hRrjg6HizFkpkJVBQreUZw==
X-Received: by 2002:a17:907:ec0d:b0:ac3:d9db:14bc with SMTP id a640c23a62f3a-ac3f1dfcc58mr968370866b.0.1742729758185;
        Sun, 23 Mar 2025 04:35:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:400c:7196:fafe:b8ec? ([2001:b07:5d29:f42d:400c:7196:fafe:b8ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4800esm493940666b.164.2025.03.23.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:35:57 -0700 (PDT)
Message-ID: <545cc6485e2c4043d222cb762833fd9bc33feb1a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 09/22] crypto/ccp: Implement SEV TIO firmware
 interface
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Sun, 23 Mar 2025 12:35:55 +0100
In-Reply-To: <20250218111017.491719-10-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-02-18 at 11:09, Alexey Kardashevskiy wrote:
> diff --git a/drivers/crypto/ccp/sev-dev-tio.c
> b/drivers/crypto/ccp/sev-dev-tio.c
> new file mode 100644
> index 000000000000..bd55ad6c5fb3
> --- /dev/null
> +++ b/drivers/crypto/ccp/sev-dev-tio.c
> @@ -0,0 +1,1664 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +// Interface to PSP for CCP/SEV-TIO/SNP-VM
> +
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include <linux/psp.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/sev-common.h>
> +#include <asm/sev.h>
> +#include <asm/page.h>
> +
> +#include "psp-dev.h"
> +#include "sev-dev.h"
> +#include "sev-dev-tio.h"
> +
> +static void *__prep_data_pg(struct tsm_dev_tio *dev_data, size_t
> len)
> +{
> +	void *r =3D dev_data->data_pg;
> +
> +	if (snp_reclaim_pages(virt_to_phys(r), 1, false))
> +		return NULL;
> +
> +	memset(r, 0, len);
> +
> +	if (rmp_make_private(page_to_pfn(virt_to_page(r)), 0,
> PG_LEVEL_4K, 0, true))

We have virt_to_pfn().

> +static struct sla_addr_t sla_alloc(size_t len, bool firmware_state)
> +{
> +	unsigned long i, npages =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
> +	struct sla_addr_t *scatter =3D NULL;
> +	struct sla_addr_t ret =3D SLA_NULL;
> +	struct sla_buffer_hdr *buf;
> +	struct page *pg;
> +
> +	if (npages =3D=3D 0)
> +		return ret;
> +
> +	if (WARN_ON_ONCE(npages > ((PAGE_SIZE / sizeof(struct
> sla_addr_t)) + 1)))

This should be (npages + 1 > (...)), because we need to fit `npages`
SLAs plus the final SLA_EOL.

> +/* Expands a buffer, only firmware owned buffers allowed for now */
> +static int sla_expand(struct sla_addr_t *sla, size_t *len)
> +{
> +	struct sla_buffer_hdr *oldbuf =3D sla_buffer_map(*sla),
> *newbuf;
> +	struct sla_addr_t oldsla =3D *sla, newsla;
> +	size_t oldlen =3D *len, newlen;
> +
> +	if (!oldbuf)
> +		return -EFAULT;
> +
> +	newlen =3D oldbuf->capacity_sz;
> +	if (oldbuf->capacity_sz =3D=3D oldlen) {
> +		/* This buffer does not require expansion, must be
> another buffer */
> +		sla_buffer_unmap(oldsla, oldbuf);
> +		return 1;
> +	}
> +
> +	pr_notice("Expanding BUFFER from %ld to %ld bytes\n",
> oldlen, newlen);
> +
> +	newsla =3D sla_alloc(newlen, true);
> +	if (IS_SLA_NULL(newsla))
> +		return -ENOMEM;
> +
> +	newbuf =3D sla_buffer_map(newsla);
> +	if (!newbuf) {
> +		sla_free(newsla, newlen, true);
> +		return -EFAULT;
> +	}
> +
> +	memcpy(newbuf, oldbuf, oldlen);
> +
> +	sla_buffer_unmap(newsla, newbuf);
> +	sla_free(oldsla, oldlen, true);
> +	*sla =3D newsla;
> +	*len =3D newlen;
> +
> +	return 0;

Return values are inconsistent with how this function is used in
sev_tio_do_cmd(): a zero value should indicate that expansion is not
required.
