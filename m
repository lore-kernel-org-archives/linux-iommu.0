Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1327A130
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982285; cv=none; b=FnJy2fNhEp1kgfuCIIdwwT03bDiAFXstL2PD2ULs6Pe7dx2xdACZfkxxkzKPUYK6mWFuh7W5GVSPBdTHdnP5zWTm51yXmk/4rn340AFheTW/d+HAWOoASiGWpUaHiXFqQdvqecLLb1XxSep0TzgYufEFb3qmNAIgRXycnLG6kSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982285; c=relaxed/simple;
	bh=yGGtQ01i6ULcnlphEJ3YP5AEFLU+uu4BCrDMhyrpMes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkvxJS0H6wyLxlRcYYN7JyymZ+7Dz/W1cE9qdTGL2AukpFS+XJ4Zz3XCQOBdhrM7CS+tbuozwjNx6TT29icTOqxu08JLODFl+HkXuWVE+2qZCD7D/CR3JXOwcIm53DOvlWSY2XvtWpwPoK74bhd41IFQDrmb2AIQ5hQfH2UFZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shLHuXwT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shLHuXwT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so93815e9.1
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763982281; x=1764587081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxY0zFsSsb4UvWV8JkswEu93uViR5DhGzNdHTRi5eEs=;
        b=shLHuXwTvkKlS9Iwd3ENIQvzPAO6BgY8NHKkWTAEiNNCHB0+zs1qEtiNgWzzw4uqXM
         gbvjXapxrKn+RzeQClIKXr4ztpPCNrWjcXTwKxvCSY3fUrfqjhOHfAVXg0yFlzGOGD+z
         SPFhM5HrIG0cUAKxdj57YG65Q9SdIv8AO6TuzTKRZxRdd7ZRe/Tzn/JfrUrGokIJZj6E
         z2oo0PgVmkTrKOfUxPwj68+Z08yavPDtwKHu51IMsUUjH/atY0jGToRtxCLK1CPP6idE
         8OtvifLPbnDwAaCGXoFYDcV6chmKqqtkpvgR441cHIHiQUbXs5YVSuF2wE37Ouq8M2wk
         mrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982281; x=1764587081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxY0zFsSsb4UvWV8JkswEu93uViR5DhGzNdHTRi5eEs=;
        b=B6CdTw3Ij2zZP1qjNYm//643LuZ5RYOnb9evOUKjoOzWtxTgM4LTvszJQYhBujoaLg
         smpZu7HeR27iWtreggoyKhZ4J7dlcNY9Weh3QYcAgFoHbe4HUwI30wgmgGWWu+sLTuaM
         TscWQiY1wHtXpmhcnOHF/xmS8SGzb2Wff83xjgtr6TLQqEIMmv9CRep2eLjsCWplJL16
         1dYRmVvay8pRSGVP9OMRU84aciZpeOdqOG7TnxHyd6DM3loa0M4PMv12uXrcYb9MHx5N
         8ioo64d40sqdT/2LbaMKmSkTMhWdIiMbdsTGEWH6hQfmDPAn0CLKMPBvIxR0ZvOnoCe1
         rCAw==
X-Forwarded-Encrypted: i=1; AJvYcCXv4DkcyDWb84Ysnf9s5N0XS3dfzLRpw+SRNFJOfgPYC4DuOnTWTS3CewkLa1Xwy8lWHR9iJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOgFEiAiddHwzQuU9feY0vtda9GTdnCfak/XRUnxhxwZm0o7Z2
	oEugGdH6kuMII4Ssny+/NMa63FFWg9XuX0s2rXdgsGss/wZSb03PYGKX3B7hXofQNA==
X-Gm-Gg: ASbGncuWmn2TglBp54joVnSbqJCYstlBFUqUz1z2xtVBkqXzOdcxKxf1/VLn8eA7jOZ
	5dn43WIJuLSmGOGTbOdBNnDRrX2L+gxxwj1L2ios0kiOccO+arhcXX8co8wRRkm1uTKykGT6dRs
	MeIOoYXpi8lEy/wqqTjVc3mm/B/x3RRNi9x5IUn6cLKZ8gZ4+NrtfS9ihomMkKDgDvu9wTLUZbE
	kY6TDTzCa03SDYgj0/BgTL+JoZzwPUBpJHYnkdWCBLqls/ggarZDsqT8MhLL7bq8TXI/V3cnjj+
	9Rd5uWp1+14hwnbQPf3Fs6pTj/5lkaPQz261q7CnLoaly2nEXQ5KnsFNPH1ab0OhrToAgQNCO8A
	3QPxrK0pOPKgm+eUz6n8uLKzyktX/T09PQ7JTAElN25ztUpDvAYXKLXKvNdCkzmc7DR0sA4vfjI
	6CxkgiZoRPpYxAdqdgVrdn/yiqY8DbGSVvR7gqVjpItHlYvyTB5g==
X-Google-Smtp-Source: AGHT+IHfC/zx3CtUqS+QNQEXWjnlvj8ok2cj2JsEBQqJZIsdvVIDhcfsaBV55OT3BOjTGNisyGw1Aw==
X-Received: by 2002:a05:600c:a402:b0:477:2f6f:44db with SMTP id 5b1f17b1804b1-477c5ea4a1fmr1591355e9.5.1763982281333;
        Mon, 24 Nov 2025 03:04:41 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226c2asm188677715e9.10.2025.11.24.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:04:40 -0800 (PST)
Date: Mon, 24 Nov 2025 11:04:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org,
	Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSQ7xfQjkeAMHiLC@google.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-2-smostafa@google.com>
 <55391dad-339b-47f8-8996-afe337b238e0@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55391dad-339b-47f8-8996-afe337b238e0@infradead.org>

On Thu, Nov 06, 2025 at 11:50:11AM -0800, Randy Dunlap wrote:
> 
> 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 70d29b14d851..6b5e9a2d936a 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -383,4 +383,19 @@ config SPRD_IOMMU
> >  
> >  	  Say Y here if you want to use the multimedia devices listed above.
> >  
> > +config IOMMU_DEBUG_PAGEALLOC
> > +	bool "Debug page memory allocations against IOMMU"
> > +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> > +	help
> > +	  This config checks that a page is freed(unmapped) or mapped by the
> > +	  kernel is not mapped in any IOMMU domain. It can help with debugging
> > +	  use-after-free or out-of-bound maps from drivers doing DMA through
> > +	  the IOMMU API.
> > +	  This santaizer can have false-negative cases where some problems
> 
> 	       sanitizer

I will fix it.

Thanks,
Mostafa

> 
> > +	  won't be detected.
> > +	  Expect overhead when enabling this and enabling the kernel command
> > +	  line iommu.debug_pagealloc.
> > +
> > +	  If unsure, say N here.
> > +
> >  endif # IOMMU_SUPPORT
> 
> 
> -- 
> ~Randy
> 
