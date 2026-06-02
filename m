Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E325B0B1
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431284; cv=none; b=YnYqq7vuekoxipEqrG0nfA7sd5T6ZxeX7SjaPE/mEjWejqDv4LteZb3Y/fKsb8sTIASy/pZY79qka/Uaz5P2LgD6ky+AeFOjKsbiw2hZ2cvUNeOnP6g18VHuyy5VaXUY01iJ9bEqZEjPnvulmY2es42tZPdENolVuQK+TcZK+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431284; c=relaxed/simple;
	bh=he33nU9JPm0menDe3NJIvjrjiIhsUVKO9W0TKnELQCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/wUz70nMcccCMWqAUagBsiYBd/h6n0JgmkMFqS+GFPpOu3J3SYmLDI/LetvY4Jb3rQkuI1F2Qe4XHiBsuDOK5tURIi9725ujgQWTYyFFnhjFjKLE1C7GSyjvjfRCIUfvQl1Ka+5Udu6sySgCBvGXi6Hx9t5oFA9cxCR+1sP+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlK/T9cJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlK/T9cJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so4815ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780431283; x=1781036083; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXf/DhYEKv4KfJHG3trdQ5N+MNYdsl2DFczEDRjtzB8=;
        b=DlK/T9cJOxidhkTAj1fIBP/p5Xqxb0XrGhQyK0bQM/54XH1aLCxRciBCijeURbw6Oa
         6w+lVKjRh7tYoynz+k2S0FDxguaQAaD73/Fbx0UU8PAD6IpF7OlEZI4gjJAHVEo20t6H
         VXeBUdSUPW0nDsc9hwmQkUUguGPevMO4HbkIMQFRKeXz+sdJvzk4YJ95U+BE8E8sn+Kx
         XKDfMyVpoT/iHPYzcBPvw4Eo7UWPAAk0X6oZTQZJ0nKbYN8wYH2qWjBNr3a9KbvZ/NRE
         ukIaPuim+zUFT24fs7rLNvaEkJ9p7ICpNiPDlaD5dytFfsF54V4su6JXr0AwebiSvq44
         zpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431283; x=1781036083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXf/DhYEKv4KfJHG3trdQ5N+MNYdsl2DFczEDRjtzB8=;
        b=OnUkPgkZFIEwmJ30YyaPdjvZZdfT/9Mtyv2LiPSLg4VA2j6vRrCWDQyWzeddxfa+ys
         pWjeU/5hblPZ98szRLngRj0CQAh2HrdscXh7o+6Updj48mFXQVuNGtv69HapXfsMcydp
         iDFraiWui83Gmz6EJvGdyOXiIcbqU1unr5MKPSEhlYe6BiO4M0mTpGeScfSkzBj3kdTs
         KePKlcTkD3WF1JvvGnilerOBalgBRN4kRgO1WvLLfA037TOwGfMviqx76zmx0rxu5+QS
         NCG40FlzsSFTCJa8QBcqWngiQu9d2HHdTgQ32S7XD4yCdq96ljy234aThN8OpEacxMiX
         cJFw==
X-Forwarded-Encrypted: i=1; AFNElJ9OENOxIkF5M7ZT3695/eobGPyZs72MGok+BIo+QeCidDwQOvSpFpcyV/nIR9e2BhqpmKjtdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb1Bbu7IDHjLmWj29W1nXcXplJNlIvj3w9aCOnIwF57Yw192WM
	lV1WQbLCpChqkPQSen2BukHpLIWca8T/A8T0Em9PmKdeKZ8HGa4ODLCzXFyZFexicQ==
X-Gm-Gg: Acq92OHWXa/mN82bo4atW86V19Z12mMkzw6WjuX1L3PxRHuF96WxUTnunNh2OCXyPOE
	UVQofnzzxrJOr0VDWYpTHPok8s/CZZWpNOenA7fe5rODnEpeGMxbEPx9hdDr1pzvURJxP8jjre9
	FTetldgrhAAvbIHsW6lltnGUorNwrP8i4oYxSfbjwmowr4QMTin7c6OkG0PnHqLYMpKuWp7nyOO
	S1zD/iAvbQ0UxmVF79mGcPSh7H1fWUddUYeENnwtDWJV4tLku7Rm0UpH0Exh8s39USrzYFLlWjT
	YmQtN9Mlkg5rz69S9/xaIWec/28lCIg5Z+LcRT0COzMOOVt7cA8aebwIb1dCfJ8y02xD0nTmmY1
	pUuWMWrFMms+v+HjMk0HhJSYEBZJsBqhHnJMLLBVXiYIclWbWvFCpY6SRLRHcS8Ol3c0piYNlZN
	UiDHFkq9+uK0WV4T0V+Y0MeQGuJAo7KtxsfdaMLCvDwH0G1ZQOh7QPdCj4CmV2jw+GTPHzv4qSR
	mpmb69DWynkEg+Y8pYHoNNhxq+OIA==
X-Received: by 2002:a17:902:f70c:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2c10e8606b5mr4060495ad.10.1780431282360;
        Tue, 02 Jun 2026 13:14:42 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a63b3sm90737a12.21.2026.06.02.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:14:41 -0700 (PDT)
Date: Tue, 2 Jun 2026 20:14:37 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ah8srv7dvO4OIii8@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
 <ah18hDhjSLxIvb-Y@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ah18hDhjSLxIvb-Y@willie-the-truck>

On Mon, Jun 01, 2026 at 01:35:16PM +0100, Will Deacon wrote:
>On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index ec887f443741..c2b98f91900a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -6,6 +6,8 @@
>>   */
>>  #include <linux/memblock.h> /* for max_pfn */
>>  #include <linux/export.h>
>> +#include <linux/kexec_handover.h>
>> +#include <linux/kho/abi/dma_alloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/scatterlist.h>
>> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	return NULL;
>>  }
>>
>> +#ifdef CONFIG_DMA_LIVEUPDATE
>> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
>> +				   size_t size, dma_addr_t dma_handle,
>> +				   unsigned long attrs, u64 *state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +	int ret;
>> +
>> +	if (!kho_is_enabled())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_CMA))
>> +		return -EOPNOTSUPP;
>
>Hmm, it seems a bit overkill to do this just because CMA is compiled
>in, especially as it's user-selectable in kconfig.
>
>Maybe you need to iterate over the CMA areas using cma_for_each_area(),
>similarly to how you do with the pools?

Agreed. So basically return error if the range belongs to one of the
CMAs. I will update this.
>
>Will
