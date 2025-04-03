Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB13188A3A
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722783; cv=none; b=bcEMrYIJJsBTANEC4Jg4XXqc4z04+dlY0ZxZnfxvTp5f93+uo/9YuLIxS5v3h1iINVjG20ORi8ZQnIKiku3wlEH6RRKTotvIskWnfrsKby0SVo6SI1xf/Zv25/3ZZG68aa3eN8ZqTIuVWMEHSn0lADO/XYFxsOqw1s+bPscXZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722783; c=relaxed/simple;
	bh=4UzC/VLVd7ky4BarzKv5YEItSxNeADmRgcM+DEoOJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmq6iYArynu/MeTi61UFkbLqNZN9OeV7QWliEYUtF8C358SacFAB8Vpf89UUXcuo8ctVNJjIlRWWLfVLfwbiNnu658danoe4VXyqhqfziNxx/9j+FJ8GItZif/CYOSTcqG8zgLYQMr2stwL5NBSrPQ9UCEcagxiNiGJtUTJ7ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dBhNZfhf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dBhNZfhf"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so14465136d6.2
        for <iommu@lists.linux.dev>; Thu, 03 Apr 2025 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743722780; x=1744327580; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dnmrlpBGeFmqcu0Pq2phWVQb3k+1PXSaVmeXw2bjGQ=;
        b=dBhNZfhfoBhLusUVCBjCatLaMjhVpZV2gwEhpWvjnKgzogs/SkNUieYntOD0Inkm13
         cKD1tfsAg6OKzQa5I4Fil2J0woKNkT21zOyKsXq6Puv7eHJcthk+lC6XWbSYaxkeCKWm
         f2HhAfPM7Nevku9vA/7NzIl+vtuXxMW0fgCBRweuZ2zyeG3Yb4/zgoCSHpslGMT5qvIH
         GRAE9LOTN+bdsyCUrKYXRwm1OEwcI+WWbdHDTiPyzMJK1/uHCx8WJROf9lsiDmUd/CN7
         hfcwHbRP8r4oEbJZArLei5hJSRXQzxUHGbDDD1+WTnnUy4pSZmEwIZ6OOqZ6aNvE0nGA
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743722780; x=1744327580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dnmrlpBGeFmqcu0Pq2phWVQb3k+1PXSaVmeXw2bjGQ=;
        b=F4T5qhF1pfx+D95cGJkkYffpT5pUYchfRbKo0hW8bulFlhNm5f2Gr/qMk2DDRJVnrI
         DeXPSYkS8mfB04evRiE3FuOQK/kypTsOptBYSGMotmqGaEhns7nyV29IeCvbUPJUjL87
         7m1BnRo6u2uCH/tWZiupffCMi5FNxyCih+Hhj5Eya1zx03RraHetQ+qtCvrOoI6ChUbx
         xh9/zfaPVbUVoZo8uHN2Zmjvg5yZ2q1cdHYDT9cMqfVhI1cUSxsXbyGfbwGhBVYPF2jY
         oqyoFyQ8fJFlIzCTZEjdp99MmyH6h7XnmagJPHeMwbIWUb1ScVoeP6odZCvpvFaweCL0
         SLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9jonLs22v5wFqOHIYwGfUtri+WpUW+2ZjJXe8nlQmVtA1H6a4AhkOSrYPGN/Dhs36cCuR6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtXFx9/VBWpwrjHqY/qsKfcWFcpa9V32NI+r96vRmc4T2hw2CA
	B+qm05QiEYEUeWVBtDBHbJ2nuf9VjmG/uIX6Ieo63LOnIH14OsIwstxJjieIBgQ=
X-Gm-Gg: ASbGnctEkJGpupcf1xbvzUs88odKUVF/qbCuRYcSmzt/1pkmnPNAXbOPShUnswWtg23
	oTnh66B+y3GIw+MNrjpMY+eKfwQqZajZ9jT6KPC53024snk1culAsPeiF+eLRLfs08CHVyNt667
	oGcAviDEvfCAHssT9wQUiw+WdSj4WjBde3EXoMnhv52rgoNfU1d+HuAFSp4ImVRUDY7J3FdHhjq
	dKBvirCPekGhhxhgqIncqVAeY1aJxtS6QV+W5n563zd/B8O3XEz9YE/zY7zzFmZuNaL3bBHq4hm
	+QHC0iG9NjKvpg3jGm18dNKeYSyTXiU1WdEDtmzxPl0ByEUxMXOWiwzB97HJLN7h5jY5dgStoqy
	2NXjoprU8PF6vtDAbwpZyJMs=
X-Google-Smtp-Source: AGHT+IFibU2LV4UUp0WQxSSCxFeutQYAvG/Wra81FTOp1ufuIAX96AWEwxKC9ZZdCWczg5MiXC+AeA==
X-Received: by 2002:ad4:5e87:0:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f01e76f04fmr21453616d6.25.1743722780451;
        Thu, 03 Apr 2025 16:26:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f1652a3sm13173396d6.119.2025.04.03.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 16:26:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u0Twx-00000005TkW-0sfD;
	Thu, 03 Apr 2025 20:26:19 -0300
Date: Thu, 3 Apr 2025 20:26:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: code@tyhicks.com, devicetree@vger.kernel.org,
	eahariha@linux.microsoft.com, eric.auger@redhat.com,
	iommu@lists.linux.dev, jacob.pan@linux.microsoft.com,
	linux-arm-kernel@lists.infradead.org, vijayb@linux.microsoft.com,
	virtualization@lists.linux.dev, will@kernel.org
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250403232619.GA681099@ziepe.ca>
References: <20250131003618.GB2296753@ziepe.ca>
 <20250403193458.158085-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403193458.158085-1-shyamsaini@linux.microsoft.com>

On Thu, Apr 03, 2025 at 12:34:58PM -0700, Shyam Saini wrote:
> Hi Jason,
> 
> > On Thu, Jan 30, 2025 at 03:21:37PM -0800, Shyam Saini wrote:
> > 
> > > Unfortunately, it is an HW issue.
> > 
> > Well, that's pretty bad to have built HW that can't DMA to low
> > addresses at all.. But OK.
> >  
> > > Are you okay with this passing custom MSI_IOVA via DTS approach ?
> > 
> > It isn't up to me, but I've understood the DT maintainers would reject
> > this as it isn't is describing HW but just a random Linux software
> > knob.
> > 
> 
> If i understood correctly MSI window IOVA is hw property, if yes
> then it should be accepted by DTS folks, did i misundertstand that?

It is not a HW property. The MSI window in the SMMU is entirely up to
software.

Yuor HW proprerty is the regions of IOVA that do not function in the
SMMU.

> > I think you should make selecting the sw_msi dynamic in Linux.
> 
> My understanding is that if we have to make it dynamic, we have to
> use iova allocator that would need iova_domain as a member of struct
> arm_smmu_domain, and allocate iova for MSI window dynamically using
> alloc_iova() in arm_smmu_get_resv_regions() is that what you meant
> when you mentioned selecting the sw_msi dynamically?

I would not structure it like that..

The simplest thing would be to have the SMMU driver have a list of
potential addresses and select the first one that does not intersect
with the non-working IOVA ranges.

Jason
