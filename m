Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99992EDD62
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944085; cv=none; b=EX81iu+INk7ymCwNPQ66kDgVG/jU3Y2XB/RaMRemVqMboBAlrArbOgo6Mqqaazm+KbdAmdZb/G6PrQw3Sg2vZwGT8Qwi7v0OzRDSQ9V+3RjBeqFBs11MKm9+Yqncp7ujNW0EnINp3xcq2DD3sVNrNcgbiM5EbMGtgwBlAw/T0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944085; c=relaxed/simple;
	bh=mQNQDvbKwm8YPQMvUQmrODeUWbj93d6ac4BYkM5iRJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmM7vaIO2H1wP9Sa9+HGv1ELlzygjjqtHVtngezmI5NH3Si72veh3jINTUo49DASbRq8Uv09ZKUuMp3zsiP+r+YaN/e7/LjN0n1dEpBwihTLAOVdfSG+9ArpKjIFXKB5KNgME4vb5zJN/efE1i6H5BBOzurNs5pdnnNRzqnSAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=te/q2g1G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="te/q2g1G"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f02651fccso49975ad.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 23:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767944082; x=1768548882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXFThduoh/FW3X3hmcDPgZVUcXZLVLfg8hOMDEL1+OI=;
        b=te/q2g1GVRBVdXp2eIMQM/u4R00/p3PMj2UD1+76rTFW27TqbkAhvrleiFdczCf7oC
         QZ6SUzrhqFkHN0vppFbVkEsOFAoF6uhw3VEso9P1yfLM34mLxAAsEf+Jg0UBEXQAvjtA
         v1ZWiUkKJcS1NK1oSEvT9/6U8t1Q/D8gRDpIWSTNRS2rfeLKDQOJs1n8JCof7SityU0x
         SgVGFRbwXzVzH229gEJ+C6j/h5wgTi+9pNGM1AFF2o6rXzpjGs7I7WbUAzinPQJCSe+1
         6Faj6AtzZF/65QhinLMOC55+/T0royQ/ybxLkPaKKBzZnQl/E/p5zz3hNh3w6rjf+QcP
         /blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767944082; x=1768548882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXFThduoh/FW3X3hmcDPgZVUcXZLVLfg8hOMDEL1+OI=;
        b=gID/E9FDbqAzfUhBhrorYtagHhWP4DwYEM7TFH/P8/8V91ob3rrMbSC68fF8PjC30e
         y468jqUVGvcl5TrjfUmMmX0HRzf3cdLH9YsrLYcGbMJdrZAFdY305aQUBRn2VZXsEamU
         CU75qRI9MjUfXrLpaQItFZ83fwWpZkGsB6g2t3CZhxqhw85V1w72gioigZzbZYqwHLUY
         T4fVhAyuPhKsyKgdcR5PqwiV+D5uvgb8+XECp9gZO4SAgwSvD+45oEZuUGGDBdqvpuB4
         1gdh0y5e/JexT0soZ3JjyYDXwY6BduF3VeNOPZK4jnOziIRac0cImbq3u3mhrrrIb7Sn
         8oxw==
X-Forwarded-Encrypted: i=1; AJvYcCXU/h0ubekdIF+fFHrmWCs/fZVIp6UGA4VLloD9msgVoS7ARck+VUTsWTDfuRnv+sNZlvVRYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLg1jSavuxT+SvUFS8RXjDFaQyV7eiZM91xv09IUEh1nHV1Pa7
	ZzQqq+MqRsdCheYGpj4KufLS5JCYc/ukjjYAHsPhP6yL/Pl2wcYWXyYJKV46xlMviw==
X-Gm-Gg: AY/fxX6c2y+JmjzOWH0HmsUv/CzBdwIxTsGtY0w6vk2iyrbVTVe6bLVSOJNuPxaqjoh
	TY36AZFcjxg8zb9GpKYE03aODctSwBMfeJEpzjstDQ6n94JmSQEk5NGgmu5PYnWr7wFB9tgAFGC
	+Z+h12/43JabgXL2+sVsAB7B7j3H3Bj7IkYZE7QrjpajCuryNq5MBS4V28KwLE5tQRFRG8memB+
	dHTrB52X4xB6vfExyBtImRkBlmd1u7AQHK/yCP+HUXq1B69qw+sPNmBo0cpcWHmO6J/StXF9Yzi
	apTyxeppzm/adqQWfLseBCII2ezz6rkgNpXZ8fTxjURVkwpYKZY2chnw50BmV61oIfz8FVxgyzX
	yAaRakn1W+Dp5oOdkvMcqVQCvKRpazpL/AjV9/5ZLZRzTTf2TL7EdS9403s7F4N53GXLYV13gbS
	d+MFzGonw+muRZyJKEy2vwyjtCKoaKq3DDu6HzCvvqC4AglNj6
X-Received: by 2002:a17:903:228b:b0:2a1:3cda:8e98 with SMTP id d9443c01a7336-2a409adbb36mr2245665ad.20.1767944081624;
        Thu, 08 Jan 2026 23:34:41 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a560sm96327345ad.21.2026.01.08.23.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:34:40 -0800 (PST)
Date: Fri, 9 Jan 2026 07:34:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <aWCviSCK7IBddLTn@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-4-smostafa@google.com>
 <aV56BWisUQTMK2Gk@google.com>
 <aV-PvBqQ0Ktiha8e@google.com>
 <CAFgf54o4Ja7jQwxo6XyW+JaT+aUuj3O2dvLqOTb+YSVCKTdvyQ@mail.gmail.com>
 <d6236413-7385-45c5-94ad-8b0f2007f1ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6236413-7385-45c5-94ad-8b0f2007f1ac@linux.intel.com>

On Fri, Jan 09, 2026 at 11:28:32AM +0800, Baolu Lu wrote:
> On 1/8/26 19:33, Mostafa Saleh wrote:
> > I have this, it should have the same effect + a WARN, I will include
> > it in the new version
> > 
> > diff --git a/drivers/iommu/iommu-debug-pagealloc.c
> > b/drivers/iommu/iommu-debug-pagealloc.c
> > index 5353417e64f9..64ec0795fe4c 100644
> > --- a/drivers/iommu/iommu-debug-pagealloc.c
> > +++ b/drivers/iommu/iommu-debug-pagealloc.c
> > @@ -146,16 +146,12 @@ void __iommu_debug_unmap_end(struct iommu_domain *domain,
> >          if (unmapped == size)
> >                  return;
> > 
> > -       /*
> > -        * If unmap failed, re-increment the refcount, but if it unmapped
> > -        * larger size, decrement the extra part.
> > -        */
> > +       /* If unmap failed, re-increment the refcount. */
> >          if (unmapped < size)
> >                  __iommu_debug_update_iova(domain, iova + unmapped,
> >                                            size - unmapped, true);
> >          else
> > -               __iommu_debug_update_iova(domain, iova + size,
> > -                                         unmapped - size, false);
> > +               WARN_ONCE(1, "iommu: unmap larger than requested is
> > not supported in debug_pagealloc\n");
> >   }
> > 
> >   void iommu_debug_init(void)
> 
> How aobut
> 
> 	if ((unmapped == size) || WARN_ON_ONCE(unmapped > size))
> 		return;
> 
> 	/* If unmap failed, re-increment the refcount. */
> 	__iommu_debug_update_iova(domain, iova + unmapped, size - unmapped, true);
> 
> ?
> 

That's nice, We could also print the message as Mostafa mentioned, like:

	if ((unmapped == size) || WARN_ON_ONCE(unmapped > size, 
	"iommu:	unmap larger than requested is not supported in
	debug_pagealloc\n"))

An explicit "This is unsupported" warning makes it clear IMHO.
If a driver triggers this, at least we know the sanitizer state isn't
supported.

Thanks,
Praan
