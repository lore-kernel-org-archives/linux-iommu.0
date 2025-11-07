Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A5299944
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475746; cv=none; b=C+ZZJYdmW+DmXLm2pBFRF1xrDyHDznpsDH6LfAKl87TfFh7zUCPN1HAL/Zav71BF5jTpN+mCh0xu75jlrIJ8FwWkzlXNwmyFnpGBPTFyqJ6N1lDn6RVEAVcv9SN8v76tR/ulwI5oWKNFkKeVKzy+1XBoxtyfxoZKXtmjmu7cEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475746; c=relaxed/simple;
	bh=26mhvWfpyqxVsoR6ouyViiXyO86XybPyAuTZV75c/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8F8N1Cyd+SaniXkJQkLUuPD00nVnzlmbWDGEEqR/vrCZNuBzgivTOcWE+OPdEHIZpi1f3kB0Fn2/jaOq2aaUnRBNma+FgObnnwnO6X8RbDqunAcAAOaBjxeYDmo1TGUZEiLXZPi7ekTe6BOyw+HSiiHtF4JLxnlYfeZ02PmrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H+18rkfI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H+18rkfI"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88056cab4eeso1227156d6.2
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762475743; x=1763080543; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vFuvWNdBF6vFEowrW3WFaNnkoxz6xkvGAkNcwr5uLg=;
        b=H+18rkfIwdM1+YMFteBlSC1Jn6JRxFpqBdcyT1Wzvv81rO94PIQboC89ykEFXkwT7B
         Rj/XournlZwhnJ5YEvpA38u7WketTBUun40ThnwGms32HsnYICSROsXmMQ6tbWF5FFzu
         QFpgW7Mb591Xg7TzPyrccOaw3QQ86tevbv2BYvEiuhypID/DffU2BVSZwbj8aM3DCkEa
         aaiqQxiSbMFilSSnrEOmwmcnJdEWRq6wq8K1rs2x65NRUmZ3+0sny9V1jhajn9F5xQqJ
         Nm0x2M2PmBtF/wwJNC3RieVmbn8M3u2BJ9TMT0v+dbUx5mTYSUKeOywTECxP1joEIoRQ
         Aekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475743; x=1763080543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vFuvWNdBF6vFEowrW3WFaNnkoxz6xkvGAkNcwr5uLg=;
        b=bUwHJ5yAA46whSGH4+PNaEj6Mj3MJhNq5Rfx7E93+W9fQLGSoRKupkPHqhYBkrsK/d
         htx62z1eHxEzPX2+4icCFSHAxGxONhRGonPw3uiM+ps9GX9a+dcEqkU/A+MptrMTN86u
         s/5gPFfGx7DHpKSy0HK33uaYxFI6sxFjg47l+cnGDtLqXJ5XPS9eW+aGScqTmd3hA4s0
         3tfTGcoOyyWlbVEngIexoBmCNV5PHIhHbsPmPiK43kY6h+WYClwQLGtMPLYy7Ij4U884
         sQPJr5b12K+5QZFpEhsW8nzIOUlwqxrmMzRwIvZ9y7ip4Lurwrzc+bEbD/tWxWjmGWzF
         a+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUxLycR0X2qIXGWim15LREaAHhDqLw3n0dK6PlATiQmkUrZUSxC76v1DtWTtkm2AK+tsUnfWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2T9ONwW78HMQkzZFhYn1xgaGhpbAJaFEcXpLjYLYH7NE1hHji
	k9a2KQIoVXnwzHG/naO0snCiS2gey9AXfwtoUwSK3LYTr5A5AhbIPTOxEho3E1FwPMY=
X-Gm-Gg: ASbGnctCqkfotb46s2ovlKzJdyc1yPN0182g93gzEENdqaAF1aqrLbDS6lvL5t97kGk
	jLI1lca5zliuWk8QR0e9rDVwSeGXvDTVwB2sU/jCPlt4e61exP75OvdvHYlnH2YlPTt0U8YidKN
	GgstuMu/8cMFnjRafKft0zuy9Rg9VtrNXenjyJxRvxzUobD1jadbAnSfJgHu4itJahIyZY4Uige
	NRS3bGF2Cr7qy6p3jplViYx7/GXp63phfc3I5TO4wt7EYk9Vfx93CWZBtZjhGdBZEzLejbh5Jku
	TmsZpXOQZmpM0O+mwll+y6zoFXDbIpQ4hpVYDDsm06yS/6//YhrcOvvevaNxOgw/hMP6Ray0Iwg
	TUDwux1fPAdY7hk3clcYjYejEHOyvifmAj91FhaB+k9ULdHfvvsF9/qHJVq0EhTAM4TQou/l+LK
	7xJPu9YJHCju8/xRy5bvCWPX+ciATNZBB11dvtUFcWhElGyg==
X-Google-Smtp-Source: AGHT+IFi5H/5K1qU/qTfa8zVHoasmFdiSIPqdCmrIYTpSC/tr3U2fbrwxyPtE8hN3rVdSnFiBHg67w==
X-Received: by 2002:a05:6214:2627:b0:880:5edf:d135 with SMTP id 6a1803df08f44-88176760434mr19773456d6.53.1762475742503;
        Thu, 06 Nov 2025 16:35:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828f5b1csm29528776d6.21.2025.11.06.16.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:35:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHAS5-00000007WOg-0nM1;
	Thu, 06 Nov 2025 20:35:41 -0400
Date: Thu, 6 Nov 2025 20:35:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 2/2] iommupt: Describe @bitnr parameter
Message-ID: <20251107003541.GA1792527@ziepe.ca>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-3-bagasdotme@gmail.com>
 <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>

On Thu, Nov 06, 2025 at 03:48:10PM -0800, Randy Dunlap wrote:
> > diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> > index b5628f47e0db40..54c16355be2842 100644
> > --- a/drivers/iommu/generic_pt/pt_common.h
> > +++ b/drivers/iommu/generic_pt/pt_common.h
> > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
> >  /**
> >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> >   * @pts: Entry to set
> > + * @bitnr: Bit to set
> 
> Shouldn't both of these (above) to "to read" instead of "to set"?

Yes, that's right, Bagas could you fold that into a v2?

Jason
