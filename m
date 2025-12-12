Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604C2D63E5
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564659; cv=none; b=rlu9lfiY3y/s48Bmi38lo3+x13gIzvQ7FygJkVlZqF4ASCX46V/Mv0iupLD0QJDWLORm2E3P97D5HLNEHsNWiUy/Hhc197zWD+tGEu6j8szxyl0WMEZeN6T2wWXnlT/dpb36aA0uTbnKOg2vF820MNhYOMgKldhThnVcVlfzCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564659; c=relaxed/simple;
	bh=r2NGHV/deV/Fuwr/+VkjLSQ7t9QFbqVnzpA7KFlk3vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmHHZZ6wqizn+LTAl+79kcKahkq+fJLhVCJlcQ0suyziCE1amLqU16oewys+bFiUsusu9HwmY4d5Jn1yxV8LseffOjxiTEqRo6mHpPHsn7oqqpLeolCPr6JKI7cKJTXhgbB5ADduxTMzA2AVgqF0a4p9SrGOp73aFVOsWbQbEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVWJLOhz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVWJLOhz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so180655e9.1
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765564656; x=1766169456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSEL5ePgx5RjiFkm4T13sS/CnpCa9se0VHC4VBAtFtg=;
        b=bVWJLOhzIJnCSWq8/zkhooRdcf7eVcnbvGgm7DRps4g04bEGxXTbw3CX0w8NoPL7bq
         geXdCXaEN7UWXyysAeMHJYjEBCwOpus/27+jB+j9mbaXas2YZ4wzin470nVe0ZkWoFb8
         YfsbPafMIb0iZCO8KFsw3fET1KOThyHMH7GRcjmKT0TrLZJSCL7gPxdjtAdyw4h5KyRm
         1ZRV/vvdPq+YX4u7LhWoBZqERqqGxM3hGaffzM8S5xrXTS9oJldcpTA1V+OHlnc9T6RL
         I/HKC7l7lp1OtNPXxrAQAB5WLNGA9+h1lVGKARzdEgIsiq+z7AzfREamLwSl9g3ALeDa
         +ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564656; x=1766169456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSEL5ePgx5RjiFkm4T13sS/CnpCa9se0VHC4VBAtFtg=;
        b=Xf9/O31WQbVbZsSSNM9ZxGXFJTRtCzUuLDnAqH1JOdr2FVPqh7GPKe3eM6leEJ3Fax
         sBUTYZ2lHaiCs+fMb47bhPJuAFbv3oVidZVb9NORgz3X9ZdJ3iK16V4S+7c7HpvlHgdV
         6KV2cu2HMepagCV4rRpKcTWEmqnmMJvX1dfPACGGIQDliNibClsezy+wp4akbrM+2tJF
         k0uXCDfdLwlugLeH7geBezH7v0wuJoZ6hQTOR+29B29x2VhQVc/1WTgqmS1yV2FAwdR0
         iaGTzsPmFeKFAGR5AfsKiNtU8Cl2cI50Qz+aHNUOFLr9cIc0aHyQN1eYQvG9p4KuyD7W
         heZw==
X-Forwarded-Encrypted: i=1; AJvYcCWezKqM4MsYZgVgOZmTjRFwufb11Kj5Hukr1zU3gH2C5K0pjroDGHyd1XOhjcdpn+9rF8+Cqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7XG2yc7nT1zQ/C+H6dJMi7CHcyS6sgCIlyLy8lObzMseknQHV
	OY7LPj3p9nhe9YwNtCbQ5cPv9Cp5rthfWA6DMzj8Q5fXhMOvdK8N/hVACI2iMNKl+w==
X-Gm-Gg: AY/fxX4QVLeTQ6yp1cs66eOezz2iWvyxz8kaq+T2vEd+fqiEjPlH4/zWcHiq5uGLvnT
	dOD7JctRh7NlMixJXFVgCCA2QBBWVFw1xcKUS6b8D8VWCWz89qB/Xdw05ZND9WAMMxK5G5nLBw7
	9uywmW2X8dRjV3N04j2tUoot2xOgjgNbjBUh6KLQuFxFrcH/rDLW/d/hKvGLETMb0CfI4Rt2zH5
	Qnu0cL41eEQzegFBkNK9+B3t/DKXOsQLGzE7IlAXlQoJ5dZtWebDNQfQeH/1BZsw52F3tOhLNEY
	LXBbOSc9tWsn9tlGuhTofuYhmDKr6nitnRvX+MBtv9lSw3PbI8pGaQgsc2rGTIvDMOB9QEJE2Bh
	fxm2c/in1FT+AVzShs4aLoqH8Tg9lqoYiWfBw+DMmtNQ9jMIXACGQ+w0Dhq1+exEtaJwJQ33/fW
	lGiMQ+dWshr11K/OjyiLoZI2z0Bh0nXivJ6NETbdJYkDxKkwcPpw==
X-Google-Smtp-Source: AGHT+IHzdWN4hpt7McD7KCWGDX7vpqcZJcLk3uQhWd353UqV22b/mGz1ioCMGsLdTgWVBmvLQWc0hw==
X-Received: by 2002:a05:600c:83c4:b0:477:86fd:fb18 with SMTP id 5b1f17b1804b1-47a94869ebbmr37675e9.8.1765564655960;
        Fri, 12 Dec 2025 10:37:35 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f2238sm16173315e9.13.2025.12.12.10.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:37:35 -0800 (PST)
Date: Fri, 12 Dec 2025 18:37:31 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v4 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aTxg6yHWdFrW41ZC@google.com>
References: <20251211125928.3258905-1-smostafa@google.com>
 <20251211125928.3258905-2-smostafa@google.com>
 <341bbfd9-e6bb-4d1e-b9c0-9077dc3eaba3@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341bbfd9-e6bb-4d1e-b9c0-9077dc3eaba3@linux.intel.com>

On Fri, Dec 12, 2025 at 10:17:11AM +0800, Baolu Lu wrote:
> On 12/11/25 20:59, Mostafa Saleh wrote:
> > Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> > page_ext.
> > 
> > This config will be used by the IOMMU API to track pages mapped in
> > the IOMMU to catch drivers trying to free kernel memory that they
> > still map in their domains, causing all types of memory corruption.
> > 
> > This behaviour is disabled by default and can be enabled using
> > kernel cmdline iommu.debug_pagealloc.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  9 ++++++
> >   drivers/iommu/Kconfig                         | 19 +++++++++++
> >   drivers/iommu/Makefile                        |  1 +
> >   drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
> >   include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> >   mm/page_ext.c                                 |  4 +++
> >   6 files changed, 82 insertions(+)
> >   create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >   create mode 100644 include/linux/iommu-debug-pagealloc.h
> 
> Do you need to update the MAINTAINERS file, since a new file (iommu-
> debug-pagealloc.h) is being added?
> 
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index a8d0afde7f85..d484d9d8d0a4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2675,6 +2675,15 @@ Kernel parameters
> >   			1 - Bypass the IOMMU for DMA.
> >   			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> > +	iommu.debug_pagealloc=
> > +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> > +			parameter enables the feature at boot time. By default, it
> > +			is disabled and the system behaves the same way as a kernel
> > +			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> > +			Format: { "0" | "1" }
> > +			0 - Sanitizer disabled.
> > +			1 - Sanitizer enabled, expect runtime overhead.
> 
> "iommu.debug_pagealloc=0" has the same meaning as "unset". Would
> "iommu=debug_pagealloc" look more appropriate?

"iommu=" seems to be x86 specific. I was following the pattern for
"iommu.passthrough=", "iommu.strict=" and also as "debug_pagealloc="
has it's own command line, it made sense to design this way.

Thanks,
Mostafa

> 
> > +
> >   	io7=		[HW] IO7 for Marvel-based Alpha systems
> >   			See comment before marvel_specify_io7 in
> >   			arch/alpha/kernel/core_marvel.c.
> 
> [ ... ]
> 
> Other changes look good to me.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
