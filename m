Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DD32F77B
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749360; cv=none; b=FhczSZDeo0n7qej36FoDr8gb3JWHsDYeG12hsVkSlNN5d96Tjed+v7L9h8QSNyqqTLUCootQko+hKREdb8dYSc12huFZFmdnCjqmGvF16WjiZIgQkrF7KmgLSojP3oj0LfOzIrivwFe1aC9CKWom0rNZztsjcMl21EDx5o3jFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749360; c=relaxed/simple;
	bh=LVDOSOST8u4Nfu2BG/Iq7jmE5BNR05dhwuHtLdykbwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE6U7jM8wsA47t3YUNp+aHFk/ez5uruYjYevuRxIg+hzvj9z/76DOe/CQnfsjv9ZKvoVo1Q/KzNrzn7qf2X20FPYFuzgEfagjnl2dxGOE/+RQXhwMR4EJYveDGx9YjcQ1n5FCZdkvTAoOw+mvcr1LGU/V6ltfKNolz8xOgfd2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iE/DsAIF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iE/DsAIF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eba67d4b1bso52990261cf.1
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761749358; x=1762354158; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iISKP7x3UPKOETShrQK/0bkxS6KgyI1/wrp9P7Ly+SE=;
        b=iE/DsAIFSnGa7PdG9rZaCkpxp6lHSdJsZsjJRnr+IliClwkoGbSprVzF5HNG8K9QCA
         IiOzS33RPUl2O7rlN/JpfrBM9uR4DaVOSk9Qo0xi3N6hy6PF9ZJsG9GXa5MmPkBVIVMO
         S3/XI60UB9OFPU1/3oOj1SZ8tApp7NQT51UxHk6JihHr0CRjdkVIGIolNzaBckYOhpCO
         8jNmB8hkc8ntIcUCNIADm1MF2++wFLaXC4tn0j+yAsOhjV2Bvy+QHmL2ZNBjbQz8P/2U
         rxK6EBULIHTgFu6XuJFh8wSZQbYP6Tavn9OQeoyK/VPJByr3UCKj8qUof+O0ZnhiEyRn
         eTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749358; x=1762354158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iISKP7x3UPKOETShrQK/0bkxS6KgyI1/wrp9P7Ly+SE=;
        b=BTMYYjQDDx3ej1zoYtvSq7LNx4yHh9S62luMw+RJdmU8fcMwmPrwPOicaobwDgaieT
         h/g5TjlnoG24O+jXxftEA5ipICrR+Pu0QZ8ccaSC4VkgC4GXOCr/YwXLBAmIi2qJjxn2
         Dy5AN32l9EqFG+t7NsiJ47l+nRcOJEu1pQdHTnlEkvfeF7lLq3gOlKaEQqQaBes5MPDi
         lwqFby866aEllk/3MzxFh0+o5R/N+PN1ujcvxZ0NkDqGqQW3T6SlhRskz8SijLtp2PZG
         PXZ+j+v0Dt/d5pgOueJu6/KPMP0kA/m9+CRFZp/ElG5aICnkXyp5dG1w33mZmFwRWuTm
         m9JA==
X-Gm-Message-State: AOJu0YyIuPRGsN2fDkbOYZFlgjUX/fRPu6zhGSYJHxJlprIAYOlL5+6s
	xztGCqEHAyQ11yIG35eSdXaedcFMLFsTpohQwbiysGdHUaU7/ZB2+tAWLu+0SwS+1Gsa2wTeZ1w
	D5fJi
X-Gm-Gg: ASbGncvDqL3Gaedl9cm/RrPY6+npQ6DhsE9aU83PdWgjJVGeg5brhDrVcAJdf/mneE5
	JqrAwrB/p8r+zavpHw7FLQJ4hJl3gnRUYsVlMMIdTnN0/Y+OWOCQrvxEBh0MYA/6cR6VbUjalmF
	lJb4Oemyx6OQtd2+CRjNTardg4caV+nwCiX1arTyKvW6WzRsdRMNRcGzOpMg0IlUhSmBym0Rar4
	BSQTzByIQ1sYpVXjoJyfu9MxgYjfQPsKt5aMoVgcKr01p6A9PhZUwakpOY0ECrUXlWC8qitgzdb
	KRU1deW2oxqFj7kKo1m8a53c9MSlXUPyMhRxc+pp/d2+CqtKKTl21DSqM5sYB9m9K6+b8flzVCI
	1qqp2zYEgZMKb3PA8TeiK8So6d0BH+d+q2vpxbyCOn4d9gePZcFmNofDOs1KFFaLTaXTlxVkv3p
	8EvutKxvru4R0o7GsiEv4+LgpVm0dYmt9Jc9EMdpUwiWCx9w==
X-Google-Smtp-Source: AGHT+IGAAbKXStPcrBPkR96V/nrI2ZGs71F29pgPwstoIUUELR36JYOQngJk/QufJryI6FDa/XMxXQ==
X-Received: by 2002:ac8:7fd3:0:b0:4eb:a0aa:28e with SMTP id d75a77b69052e-4ed15c98020mr39171771cf.64.1761749357598;
        Wed, 29 Oct 2025 07:49:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3830f16sm94694131cf.22.2025.10.29.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:49:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE7UC-00000004fDD-1zy2;
	Wed, 29 Oct 2025 11:49:16 -0300
Date: Wed, 29 Oct 2025 11:49:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in
 iommufd_ioas_map
Message-ID: <20251029144916.GO760669@ziepe.ca>
References: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
 <20251029133434.GL760669@ziepe.ca>
 <a63db6a8-e9d8-4f79-8212-8710ce2e60f4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63db6a8-e9d8-4f79-8212-8710ce2e60f4@linux.alibaba.com>

On Wed, Oct 29, 2025 at 10:44:31PM +0800, Shuai Xue wrote:

> We run different VMMs (QEMU, Kata Containers) to meet diverse business
> requirements, while our production environment deploys various evolving
> kernel versions. Additionally, we are migrating from VFIO Type 1 to
> IOMMUFD. Although IOMMUFD claims to provide compatible
> iommufd_vfio_ioctl APIs, these APIs are not fully compatible in
> practice. 

Well, it aims to, but we are not there yet. Hopefully in the coming
months the MMIO to VFIO will be supported in type 1 emulation as well.

But broadly the EFAULT return here always means the underlying VMA is
incompatible with IOMMUFD, I'm not sure there is that much value in
further determining why exactly it is incompatible.

> Aha, I see. Thank you for pointing out this issue. The check indeed
> needs to be more comprehensive. Do you mind use pin_user_pages() as a
> precheck?

I mean we already call pin_user_pages deep inside the mapping code and
propogate whatever error code it gives back up to userspace. If it
gives a more specific code then it will be returned naturally, no need
to change iommufd at all.

Jason
