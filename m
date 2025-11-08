Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432AC1F8691
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561696; cv=none; b=OyNAwEYhY14Vc27P1/ASAOl3cHOV6bR2OdjQqdrCJQLcKlV4ZVLm7CujhV0TzJ/VbUiixeQEOn7DvvyY1fcutDQ0nAtxmQQ0XNEKpiSF82hxM5ILOIXVyRl4BaJ3aT9033JHlAOKrfgS9kpzpWQlm/nlh2sHgM+KBc4dXNHi5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561696; c=relaxed/simple;
	bh=xAjaHvMSmn7zlTOcpY7YxpGaPXDu9AQfS98dU4FaJHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCOqYW7TX4vkz48J3whkvUNZW65P9YMK/A1urNuwLaNae7VQhPOReffvqYowyQFUjztoPqGgieaZt1oScGlA5kFkVSHEYlfs5ZQ1n/DQexw7zZJXSiOFIf/YK/kM7OOgkhSSlZ8iI/VO6TywD5eIDt+WMjW1Qy0Sxkl2sU8LWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NecZlZyK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NecZlZyK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so1584596b3a.1
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762561690; x=1763166490; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfGsS2MH5xd9qjAA7YCJrfBqaEDAdeU1QGJHQOuJbsg=;
        b=NecZlZyK6GPk1mJOfDTvI515XwPvskpLLXTh7I5rdEh40SMppu8Avqb/H3c51nS211
         mb2erGZRaiqgAGpkLbyBYyduz+yDiNnfOl3TEKAYhukcv/YCkcfDu1zsThQ8HOXIuMZ4
         9w6N2SSBsC70t3MFl7vUdht8YYHl6nBMK7jnyGSD3dQRsSW+IuaXZNj3RaPS9u0y8Bli
         10sinT2C/SGPw1A/QKEbDMBC5gXnaJMuszd+OsJY4hZaR3Sh3q+2O+/NcRFkluoNKywX
         Q7tIUbkXLHKnoRQISRtUHmLafXu8O74a+y/2z6Lmlbwk+My8HoALL1OWOaI5b0Jq1ayr
         nEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762561690; x=1763166490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfGsS2MH5xd9qjAA7YCJrfBqaEDAdeU1QGJHQOuJbsg=;
        b=Cln3mtcignu0qEf3GcJ7n4K/qmnd1FHcuqgM7PneLah4wAtIG1GHg3PgpRsuzvVS8+
         FaxZsZ1hw1VeU3zNXYl0fQAiHRHPMutSD7t85CmRqpNsF8kA4EY8BYAffKMbnB27OyE0
         NHtjA3ij6EVg1RXV+KiHf4ggkcLzhHwUbexPUCqTS6HFTUDzBYuAqUgcFi0OKxihVCsK
         LScSni7qHX010v+i8G0bIDBeQCo1+ye40DLJ78WHiqgJ6PpkMRGr9zun3FNe906DpU1i
         tl4Y3PJqeX9Lw5ArZ6oyn76b1Rz5SuU2KNd4VaKxGmm4HTa++WstYWQrYhGBCAt80Fqo
         VXGA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsCYOhZ7IgROjrIOIvOckxri+TydLs/jHhcw6pQpTYXIkDje+8fd13reHEXMBBubI2ox7Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7fOinfSMy7Zs8n+l5Wbd3j/zwp9grkQMFUVBDbIJYg9mOkWXE
	QQmTSUb4YCYt+PlmTiZJXu1cHzQqNb7vIzCHXlmI5iJ28imZDxBGfwvbhx77RaHkZw==
X-Gm-Gg: ASbGncu6pA2iSY+9ksFqUDdUWpagjNHqSaRqdy/jPe7ejKjzd2NNiQrDTgaZsLR0JiA
	zjlvlYmR0lOAfsG1aJJ6KrBGuCsDhvZJYw+NnyqCqFV3+tAAmFgUZy2NJfDNpXPKrPIFBjOugiw
	KimJhJizVUGSQ27Qgx5MrI8El+GcrgnEUsQjz7wKJ79+zvRMzoDL2o6K1KY++s5QZkS8kEqzKIG
	yFgL3JRycyexfnHl9u1L3Hk6pPQyBBvFHAwE1KTu0eBs51KtD528yZ00DEQWk+t/RLDgn92NNaq
	nrCEeMYG4oi7O0LutedSFOgHDNU/IkNnDHXk782TZeDVnuVLmSYSZQizHOF4DNwPE1JLUDKE9CN
	uOvKtTV+8VTqj2tfhPxiDo4sxYGMwDxcZwi+pUiOl7GweOaE5VdoG57s7kin5VBACdMoMmueupa
	s9C1DVtgq5+vbiNqR9wSWq6EBcPyIousDqoyFbN/DfyH3We3wS+5Qs
X-Google-Smtp-Source: AGHT+IFUSovrDS+0WRVHBlbfPfLVHwv6BMRG+QTXHnDZ4UgWakNZf0zOP9bb4qcXnqDQvHke8MZjEg==
X-Received: by 2002:a05:6a00:2e08:b0:7ac:1444:6777 with SMTP id d2e1a72fcca58-7b225b8db54mr1368536b3a.12.1762561690242;
        Fri, 07 Nov 2025 16:28:10 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d103sm4148113b3a.5.2025.11.07.16.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 16:28:09 -0800 (PST)
Date: Sat, 8 Nov 2025 00:28:04 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, patches@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3 00/10] Convert Intel VT-d to use the generic iommu
 page table
Message-ID: <aQ6OlHhq4TBM6sF8@google.com>
References: <0-v3-634ccd3efce0+16d38-iommu_pt_vtd_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-634ccd3efce0+16d38-iommu_pt_vtd_jgg@nvidia.com>

On 2025-10-23 03:22 PM, Jason Gunthorpe wrote:
> Replace the VT-d iommu_domain implementation of the VT-d second stage and
> first stage page tables with the iommupt VTDSS and x86_64
> pagetables. x86_64 is shared with the AMD driver.
> 
> VT-d has HW that requires an incoherent page table walker, the majority of
> the patches are adding generic support for the required cache flushing to
> iommupt. This is modeled after the existing ARM64 version and is intended
> to be re-used there.
> 
> Applies on top of the AMD conversion:
>   https://patch.msgid.link/r/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd

I ran VFIO selftests against this series and did not detect any
regressions.

Notably, vfio_dma_mapping_test confirmed that this series did not
regress VFIO's or IOMMUFD's ability to map 2MB and 1GB HugeTLB pages
as 2MB and 1GB entries in the I/O page tables as expected.  And
vfio_pci_driver_test validates that a device (Intel DSA in this case)
can do DMA, and exercises I/O faulting handling.

Tested-by: David Matlack <dmatlack@google.com>
