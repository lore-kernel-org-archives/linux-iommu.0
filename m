Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6751FB3
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 09:32:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id r18so1635038wrx.1
        for <iommu@lists.linux.dev>; Fri, 03 Mar 2023 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677835955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hBXC0lEHBdCxJFz/wvuTM5XuH7NecPstxoPUgvWZ2s=;
        b=SSE+X/7c7/EWnLslcWs47ifdnKBucbfsZnJB0hottynmr4Hth/tXZ+ZEjFw3klk3oM
         sjTML44wafkHpumaiksmrBmrkUQLThpTy7Kx9QN+gdamXckb3kQR67CEYlsRdz9BXdld
         i6u/y8DoDAkUbdRvTsPM2FoV3UfMXbYz9KJkj1g2LKVObmJBYOtqDowHPVEg1rI8kdpK
         tPqEy/cFSf2Litt5kQggaJc128Fp0T4QFSP+MGFNlCt2zABPuCRPXhNxdcvhiLHNP1oj
         jBa9q7rLaC2UsSDriM/KvUM25nC3xaQxkLygZIXlCEArVEy0/ShgEXPan+61TyEwHRDi
         p2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677835955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hBXC0lEHBdCxJFz/wvuTM5XuH7NecPstxoPUgvWZ2s=;
        b=EwKsQZev+Ki2KGnqv/PtxWb1XkOPnbpaxsiWB/hZ5aw6Jd0LqnEvbsTw+ci/yYVjMq
         xSdE3dPyEU8QEiuur+uvENca/MrDK7hSpY7QbaDjT1wwdzJ7Q0UUOO/cG3sHXZsD+ibU
         E7ZFRMfIIpwxhQb4IGvOzRgnpeTY+bRufznLryPiI34pt/aXnEalPAl7lsp9XQfv6LqH
         1lpfKlX5ppDvGegSyQ+u7bWCogjyVlyK49kg8d9HAVg3On9qW43i8ms/y3h6xo9alXCy
         hMv3Iafs8soUhM3s7UWwIg8z4TsGajoStuedE/N6nAeHpvQ0e4118fD1C7EmMDS+0CbC
         +SKw==
X-Gm-Message-State: AO0yUKXeFR/7l3uZY855tnB3mIP/jc/shCvYNuz5wb3Bc4tTn53CT5j+
	NmcfM7fOpWBIe/uBQZZQ+YoH9A==
X-Google-Smtp-Source: AK7set/JHlPkIR9MppkbXv5Ijhh5ttzcjun38qIQ2R+eSHmP8pbzOViSvPR3v5zMY1JfvJlm6rBqCw==
X-Received: by 2002:a5d:6512:0:b0:2c6:85ef:4086 with SMTP id x18-20020a5d6512000000b002c685ef4086mr841564wru.32.1677835955377;
        Fri, 03 Mar 2023 01:32:35 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe8c5000000b002c56179d39esm1671455wrn.44.2023.03.03.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 01:32:34 -0800 (PST)
Date: Fri, 3 Mar 2023 09:32:35 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, X86 Kernel <x86@kernel.org>,
	bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
	vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230303093235.GB361458@myrica>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>

On Fri, Mar 03, 2023 at 10:24:42AM +0800, Baolu Lu wrote:
> > > > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > > > max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
> > > > min, ioasid_t max) {
> > > > -	int ret = 0;
> > > > -	ioasid_t pasid;
> > > > +	int ret;
> > > > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > > > +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
> > > >    	    min == 0 || max < min)
> > > 
> > > It's irrelevant to this patch. Just out of curiosity, why do we need to
> > > exclude PASID 0 here? I just had a quick look at PCI spec section 6.20.
> > > The spec does not state that PASID 0 is invalid.
> > > 
> > my understanding is that ARM reserves PASID0, unlike VT-d where RID_PASID
> > is programmable.

It does, but that's specific to the IOMMU driver so we shouldn't check it
here.

> I suppose the common thing is reserving some kind of special PASIDs.

Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could just
communicate min_pasid from the IOMMU driver the same way we do max_pasid.

Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
driver calls to reserve PASID0/RID_PASID.

Thanks,
Jean

