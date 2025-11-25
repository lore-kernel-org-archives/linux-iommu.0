Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601C2E265A
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063771; cv=none; b=kNZ+IdpZ41oXnv+zGOX0v7NSKbXw/qEuDUyz7GyNO00WxIQvcQvpFR823tdQpnFzvBERcj84ptn9rrQM6jVRr3nTX70FY+dvezjblXyqTRXcEGqGpo7JN2guRAKlWF+mTgs5CsxJxaZQW8YdxlQkWLHbV8gdgXAPReg8LSDu19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063771; c=relaxed/simple;
	bh=pYU70KDOQGpxoP29DuTiODNRi+qhfpeRaagOh+suD7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s25aloL8wt3op+8NmrMOAGPITZqQwOo7Ckp7OuXRCS4R+8gWi97MQ8SDYAqUupV6Kv9irRbIvvutTFWIK5kpuo26AQE+OOCabHpB1XoIoUaatI9NzzTUTdQLp1feEtIX9xcEZlzn23evJ1m774Mjber48UoATBk37guVgJeYPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djSOpOsD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djSOpOsD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso47665e9.0
        for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764063768; x=1764668568; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCXHGSoCQLbBnbJkgfyqXAP9QKSn53WdyAoVSewwZH8=;
        b=djSOpOsDdlYkJIIQX/bDQZAFMV4V0ShQ0D0/mYFAZqodhi3dA6sGE68PMz4GfRqN+w
         RjXOk0BoP1hLscBJi+sRH4UGn5mhvX9bv8FHGFUFRtMSy1xITlRK1RGNbDsf2C6sqs3N
         oQ0Vnby2GOJBI/HxEvHd6g1aBtpcWu3jEycB0SZL9ZpZOM2j4d6NyP66nnYPTCUEKyJC
         s/hu1SxQNQBsQKUBAesAuLpfC9TiG3QWhkePYuG29mHN+QrOI7gNj2Pnc7o6tU7TVe/5
         bEtrxdOd+CZbfjJGmwvuZe2SbPIPlhN0B2fHZOfza4Evytd6b9fBTkLzU5h4OoTPqpWU
         jwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764063768; x=1764668568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCXHGSoCQLbBnbJkgfyqXAP9QKSn53WdyAoVSewwZH8=;
        b=nx9mZBlGeEWOJPhzwKfF+tJQF/CR9G5VWCxvJzptzCCg+q+8hHBH+PZwBJZ+OrSX9H
         0SWfPbzBdIYBLZMz98NynnmliiqTCdbq9BFc+9m6HpTFZkmYHdZ/SETXLxfiorez0G7s
         dLg2aBTz79udGRPveRBw5PM0dJdBnDUQyq4JEmt/CTyge7Ok1qx0SGrJoF5hxoqGzHON
         ATZRqxTEhaYiumSfAKIZGSRsOavHxnSUWz38KBGfoM4q6Xi3zTpm478Y8wOgNDPPQ2Vq
         cHZYf2UMHsK+lzClRZ8kpWfs3XrEzabzjbMczzoS0/OHyZzwMMPcaY+5jLhfE9Vekp5p
         Ejog==
X-Forwarded-Encrypted: i=1; AJvYcCXIEHo11Gf98jO0VkwRJMccQt7+iJLDAOkK3wildUmSGBy5yKCCAcYYnfzPI864BPwONgfCrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAjKUWwALBtHrXMjaLBv/D9VhNvHvHt+ZO5m//w6Mc/I6dzOUJ
	2FMIJzmeYAMl7kHhSXPgTO++IXYB6PVjlxDPuBYGOhtmrs7ewPGg7tSSNvghBHbMUw==
X-Gm-Gg: ASbGncs1vmFQWvS6fnU7Yh6hc0uPpzw+d4lPPmJpW2fau7fDX3NcrCoK+70kPiJQFa9
	MPsHTjJ63eNnBtMPtTmtk5Hoi+PK/X9AiL4RoLuamKGmmkVZ6S9MBH3w3JlShohmIe/kWc2yT/N
	mnva1Wu4+eHXHAjB0bPVjkDzqNegv7L/5/72LJZEKNM+bTDhNtC/xVjjYG/Tv2pkGg46uaIxO5U
	gfdNvyK3AfL4HHqr4dHJAYf/N8L+9g6PEQ4x/+E/STSaj1B1QMdZXQe7xpPJ0BPCzkIpYB6OsLC
	NOx/nfromPBmet8Wnv9yh9QqHuhgqF1qsT8PfSgyTv5ZsWmm3svQie3tpz0tvyZGXvf3kkwiLqW
	HjaZfZ3AIjaZyJRzbxy+b/p8SKitc5UsxkMzJRTMaytuWdpCkbtHSBRBW0sY47TuMQdOLLslnvx
	vmp6bvnsFcyR+6DY6izOc6W//jkeSWl7j89PAIJHCKfWeL3wZ9hBy4lh6/aWHP
X-Google-Smtp-Source: AGHT+IEnhOrLJGeXT6QUokA3QYFoyH54rP3priqnpDd397EAHhk3ibEBNXSKphd8QyA5DX/xXbjC9w==
X-Received: by 2002:a05:600c:3582:b0:477:95a8:2562 with SMTP id 5b1f17b1804b1-479068fa210mr331535e9.13.1764063767841;
        Tue, 25 Nov 2025 01:42:47 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052d95absm11951115e9.5.2025.11.25.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 01:42:46 -0800 (PST)
Date: Tue, 25 Nov 2025 09:42:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com
Subject: Re: [PATCH v3 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aSV6E1a4tL_Vt8cz@google.com>
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-2-smostafa@google.com>
 <7854489b-bc9e-4bb9-a19d-cff96badc180@infradead.org>
 <5d7a305e-d6b6-49dc-ab1d-bddd1339d4a7@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d7a305e-d6b6-49dc-ab1d-bddd1339d4a7@infradead.org>

On Mon, Nov 24, 2025 at 05:31:12PM -0800, Randy Dunlap wrote:
> I missed one other thing:
> 
> On 11/24/25 3:13 PM, Randy Dunlap wrote:
> > 
> > 
> > On 11/24/25 12:08 PM, Mostafa Saleh wrote:
> >> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> >> page_ext.
> >>
> >> This config will be used by the IOMMU API to track pages mapped in
> >> the IOMMU to catch drivers trying to free kernel memory that they
> >> still map in their domains, causing all types of memory corruption.
> >>
> >> This behaviour is disabled by default and can be enabled using
> >> kernel cmdline iommu.debug_pagealloc.
> >>
> >> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         |  6 ++++
> >>  drivers/iommu/Kconfig                         | 19 +++++++++++
> >>  drivers/iommu/Makefile                        |  1 +
> >>  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
> >>  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
> >>  mm/page_ext.c                                 |  4 +++
> >>  6 files changed, 79 insertions(+)
> >>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >>  create mode 100644 include/linux/iommu-debug-pagealloc.h
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 6c42061ca20e..dddf435a1c11 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -2557,6 +2557,12 @@
> >>  			1 - Bypass the IOMMU for DMA.
> >>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> >>  
> >> +	iommu.debug_pagealloc=
> 
> Please note what format the option parameter value takes and possible values,
> like iommu.passthrough above here in the kernel-parameters.txt file.

I see, I was following the kernel's “debug_pagealloc”. Although, the
implementation understands “={0,1}”, I can add something as:
	Format: { "0" | "1" }
	0 - Sanitizer disabled.
	1 - Sanitizer enabled, expect run-time overhead.

To make it more clear.

Thanks,
Mostafa

> 
> >> +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> >> +			parameter enables the feature at boot time. By default, it
> >> +			is disabled and the system behave the same way as a kernel
> > 
> > 			                           behaves
> > 
> >> +			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
> >> +
> >>  	io7=		[HW] IO7 for Marvel-based Alpha systems
> >>  			See comment before marvel_specify_io7 in
> >>  			arch/alpha/kernel/core_marvel.c.
> > 
> > 
> 
> -- 
> ~Randy
> 
