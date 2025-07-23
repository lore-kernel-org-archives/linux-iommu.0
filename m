Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32A1662E7;
	Wed, 23 Jul 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259082; cv=none; b=Ec48DPTBybEc8I/VQ1W2RQPinYmVEZari2iqk9aUEgmQRM0kRcJMZw7oQ3vKVs9WEopJajOg0aKQn4Jrt84POQCEDZA3jTuTOX09JR+QYc+r3lMrSt9NZgK2mxQ7xjIIqjonO4s5Mn6bGy7XF5UMJPa9i9d+URaUTi2qZJk1VtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259082; c=relaxed/simple;
	bh=Mr0qHL9KpQwF09w9ztSBy+NLBFb2ElbAskGKav9TAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0fXkJZvhBfj+h8hBimrmViMvPttEQBMMOApOS3Q8GhSFuVCTInb8uLR3Vym8u080NFcT9azggze5FFbnCunY23FNc/EJC/ls31u7CvLttmSYkcpxLPLWSvoGmrWXF+d6ZnqYRt/TPDR6k/8eO+1liIbTkvyf4kHtUJZm7gNBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7SJzy9y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7SJzy9y"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fafb6899c2so8325976d6.0;
        Wed, 23 Jul 2025 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753259080; x=1753863880; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89/h4s3KwNEdLTnh5DbgusESMCzq1wEubarwC8onohY=;
        b=Y7SJzy9yzh2B4oQi2ZNq7bptieTT5GBoO18npxbOBaCPuh41G+lmja7PFKvTDCDUum
         7j5t7V0MGytmpML498IYig5J2kZY1GiU8plnUhRFO2ZCvq8kVdv9gKs/TEB/ZcT6FMXH
         sOHE58R1hnQ+lFsEhsm2Zvwx/SeJnk3buzCE9oahovanV3Sb6ZFvpolpy9H/E2cUQ1zN
         AKrjWf50KHNyOjhP5wEQnG2TZJWr8ke/ek3IXTnLONj2Qokws4qhF/dX+vrQoGlKwH+n
         ytsp7VCTEBSpcIuJJjU/7tkCz4afusZ5tfnq+cCAiDAHzwU3R7i6mwQcvsmGNk8L3iaf
         rccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259080; x=1753863880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89/h4s3KwNEdLTnh5DbgusESMCzq1wEubarwC8onohY=;
        b=wX58T2qJn0Y4Mt+04iy/iIG7BIBHYRsmfIV95VJ9nffZv0BOIU02UV3My2IcaDqcb8
         jgg+YV6kY1VMW/O+LqM1IMXLIUwN73DNm5pJUxmZjuwE2RjDiAD+x/mkdGVcPeHljE29
         3DyiWnHQeLHB9r1QR9V9ei0mHJf1otULqO0AGF0pZC00va7ltwfUgXEFqK9GxPjLagfi
         fwNxppNIKT90BHWFn/rGfJvMXu0VAcUE4zheNPie/G7pKVEJociRfMAXjaguld5zClXq
         eJk5uo5QBMX5v5TgaSn0ea8KGLU3bSDWdjXLIDbuIbblmPFKKsFp59Z6CNfzqHsnqzWf
         qGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaFAos/nocsFxspEZ76QuwNz/6kz81PHhtT9e+6WHb+Phun2rOa5j1LYh8X+PAZL5iBCjS2A==@lists.linux.dev, AJvYcCX0FPRvICLjkOkdNmNpSJ0218PxbYvt2xnpzQ81PYDCA4WPmRwWb2Zati5Xq33CwWkwaFQx/CWOY5UG/RGymOANGIKA39g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu9eyuswYqTdNNEgppbLvLNZzqHA3cnqHKD2dXsrjRpPMLYBvd
	MbnpWOitrH2s7brpUYvHZUe9dcj7YR+u0OgeCjNd/EIcMm6v9KHyuFKs
X-Gm-Gg: ASbGncumcJFCDzGTf18S1/MQYlFCNxOTLnu3CnYWVDt/MLCF1JvlbwYs/7H3RUWFB8Z
	UlHHGjHl5BZN2YcHzdcAxY3123nMC/Ohr96N8AAmb3U5/z6DLzx3Z0nPmGIjgG4fVUOEqkpzcC7
	dHpt+IxqdhYtV2EsHspTZP08Ig2MvDYgT1GbQBHJ142BCB26x1yeCmluhsvzLAyBpxEwSyf7azZ
	myUSsqWlxr0OScBl18IL6G+VV4+PDUVjINxAREf8glEyzqhW1N1nkXOFVJ0CRdH5sqMSRY+YKqn
	U446SgSJBRCEXhx+SjXc84Aq1UHzxud99sFzbdOj1H9LyNhVzbPUsdtA8Z26S0CklGr2+QL7BpE
	omP9x1rRlgekyrrkX+Dht1XLnAt+0
X-Google-Smtp-Source: AGHT+IEjvslnuRIBwqLZ2HqQamNAjCpDe5qjUokTuj+aDnpNGUI4s1/MFxsZ9p9Ovo3Ar38t9vY07Q==
X-Received: by 2002:a05:6214:e6d:b0:6fa:9ca1:c520 with SMTP id 6a1803df08f44-70701135fd2mr25368546d6.16.1753259080033;
        Wed, 23 Jul 2025 01:24:40 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70707ed62e8sm1744456d6.109.2025.07.23.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:24:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 04:28:54 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	robin.murphy@arm.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
 <aH_RWQ_YqlydOkKH@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH_RWQ_YqlydOkKH@willie-the-truck>

On 25/07/22 06:58PM, Will Deacon wrote:
> On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> > snprintf returns the number of bytes that would have been written,
> > not the number actually written to the buffer. When accumulating
> > the byte count with the return value of snprintf, this can cause
> > the offset to exceed the actual buffer size if truncation occurs.
> > 
> > The byte count is passed to seq_puts() in latency_show_one() with-
> > out checking for truncation.
> > 
> > Replace snprintf with scnprintf, ensuring the buffer offset stays
> > within bound.
> > 
> > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > ---
> >  drivers/iommu/intel/perf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> > index adc4de6bb..cee4821f4 100644
> > --- a/drivers/iommu/intel/perf.c
> > +++ b/drivers/iommu/intel/perf.c
> > @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  	memset(str, 0, size);
> >  
> >  	for (i = 0; i < COUNTS_NUM; i++)
> > -		bytes += snprintf(str + bytes, size - bytes,
> > +		bytes += scnprintf(str + bytes, size - bytes,
> >  				  "%s", latency_counter_names[i]);
> >  
> >  	spin_lock_irqsave(&latency_lock, flags);
> > @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  		if (!dmar_latency_enabled(iommu, i))
> >  			continue;
> >  
> > -		bytes += snprintf(str + bytes, size - bytes,
> > +		bytes += scnprintf(str + bytes, size - bytes,
> >  				  "\n%s", latency_type_names[i]);
> >  
> >  		for (j = 0; j < COUNTS_NUM; j++) {
> > @@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  				break;
> >  			}
> >  
> > -			bytes += snprintf(str + bytes, size - bytes,
> > +			bytes += scnprintf(str + bytes, size - bytes,
> >  					  "%12lld", val);
> 
> Should the check of the return value in latency_show_one() also be
> adjusted so that 'ret <= 0' is an error? I couldn't convince myself
> that the string in 'debug_buf' is always null-terminated if ret == 0.
> 
> Will

IMO, that's not necessary. 'bytes' can't be less than zero that's
for sure (AFAIK, scnprintf() doesn't have any case where it returns
a negative number).
As for being zero, in every scnprintf() call, 'size - bytes' would
have to be == 0. (or size > INT_MAX, but still you get zero, not a
negative number as an error)

In latency_show_one(), the 'size' is DEBUG_BUFFER_SIZE, and
'bytes' in the first run is 0. So, 'size - bytes' == DEBUG_BUFFER_SIZE.
Since 'latency_counter_names' and 'latency_type_names' are arrays of
string literals, 'bytes' is guaranteed to be increased in the first
iteration, even if the rest become zero (which won't happen, since
they are smaller than DEBUG_BUFFER_SIZE).

So, the case of zero is impossible, unless you want a bulletproof
check for future implementations where the function might be rewritten.

Seyediman
