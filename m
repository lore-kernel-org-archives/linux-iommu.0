Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587F266EE9
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110906; cv=none; b=Q8rFrNTsW7ga2iFb8CTZmd2dMNcVcxkIlGyI8LnuxkRhtyE0xTp69E9C7sW+jpHbOvdVBle1MJRMA69KKs4+0HFVJxtAipZaToxeCo32IST/Qc1K+ZcEBQKYUg8XrWRfRQIempjrrUBFEsDykR0nC25rEtVMI9JlmxpNy8uCkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110906; c=relaxed/simple;
	bh=EkjsDigGbxlvbkct7iwP8iTt9HoAKBhjfQMayARljI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOQSSnniIHsE1x2TciVBrizVfH9Nipri4X4NIb3UbYUhnyDU1ri6GTggN3qMHVr6zKDBvL02EvgVLFvE59cy23/bBPCQEpvYYbtZNmgSrJVTdvOkxXTYxr4iHWcvBMaXllxsqS1fALwI/NGVAsImi3vdKX+xAKDjZ3hGrhjlcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KHPmi2B2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KHPmi2B2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efb708b1a0so8027266d6.3
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783110904; x=1783715704; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEqrn50FtdxGVsX9vWULW1SFinyIlJ9nzqYUDztwtgI=;
        b=KHPmi2B2HILTE72KAQwTHU+PmgqbPu9a4OReu7RucYoooQyeroPG5PNVXR3JtSZBbP
         hZs1tvBzMoHNl+HcZOlu3MHkMDuXmskky4DpLeBMtqWJtAm03eXmKYHCzfLxTQpKTwRp
         aXTzY4MVA+HTU5jCakVn3MEJUYxeNsx58jyKq6exqOeZl+ykVlvtfib1hjDgvCS8zWEV
         1utIuJKN/GkVXhjYdHc6pBu5VuvELtQimJ5Ac6HQNYWv/BDDJeKJiXf/6yBhgbQFjWbC
         +6A1fuwcNauDjOH5KvtbM4svS0hA7OapFsCf5GbhWwdgiQ3TmohxwAeHrH9PO/rxrUTp
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110904; x=1783715704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEqrn50FtdxGVsX9vWULW1SFinyIlJ9nzqYUDztwtgI=;
        b=ZzzgWfQAqm4tJgqzt/WbuYJOUE2zmeLRrs/PgEVd+VAy4p13ySAoAA8bPLURX56qyo
         1juhkxQsSonOb9aP8Z28QmlFqnhAQ2vsLZ8oA8BU6tyhndss1bevp+uGfXGGRm1SPB/o
         sgeFmasN3SUbPYeX2KAO4KN4mfYUFthCaNNrZ8f+OrT/kW4MajkhlTwB2BB8LXZN99YU
         iVevvXN1Y0E8qsbndwlQdePjDv9v3HvoSx3BZM+SDa7rEheZyd9n+WwqnO+FyfQCEG/a
         WqVC8NKNNJuSTD+ksCtlPqB27hA3HrjtflA+QTsAnaq4pmyG83J3VZzQhkrfnUQ1WKi+
         G90g==
X-Forwarded-Encrypted: i=1; AHgh+RpFtV5/okSEeSId8f5nNirTZdPO2WSPQySZ8+qxy7wqdFY7OlE2UzcQ+LQRjj4trCLLscma3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfYWPsE7HswQeMwQ4RcbbIV+nHejznobw7N9P2qjBCsOQb9Dp2
	1tsN0FtlGdNw+BHegMZOK455oIz537gg0XA2qdm1TBWMJaGLFGhcK0iRtsDJw1YXoSg=
X-Gm-Gg: AfdE7cnfi0nrdwKQpB0fcKi8Nu/vOqf13zVI+Xt8ojJJbyUa6Fs6iRovgnOjLIKQhC+
	xyoRkGTeS69LGmx4YrVMiKy1DVJQnUCWAEa6RUfE731Iyk60WnvzWCf8H9w/9TtrJtUFfsbS+6e
	3GGng5YSdH4Mr6cCmLXk7j9loKZphpFp6kWFbpurb0NMS1nfTrnbW1UfWJ9BYANoOpVDrihoi4S
	GtnhJXTme3AntVMalw26b8uSeLz9i8lGmxKui7WDpQT0PiGhAsaf3BtjZld+gw/UW8SywMl3boD
	C5ehbAaBtmtM6WPULzXFaToB40Gq1BIHc/px0xJDZnSVpDjQsHtaVP59E9gXZzhUATyaxboLgPO
	JB6tItobmlUWbj+MaWvUQO7khpY1kL0ZHOczSm7RMeCPrmZMvIUnOb/iaS7tIbggEydQgCr8TzL
	MqmboQUcA8gzYWvRD8jKZv9UKGpDC85PwFYi/wboBqTIxc8/YJzVD7P4FrPAXc7hdjxVfsSdDUk
	pXAfA==
X-Received: by 2002:a05:6214:e69:b0:8ef:3407:3dd1 with SMTP id 6a1803df08f44-8f74997c1f5mr12182176d6.6.1783110904066;
        Fri, 03 Jul 2026 13:35:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm62882746d6.18.2026.07.03.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:35:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfkbG-00000008b0h-35vJ;
	Fri, 03 Jul 2026 17:35:02 -0300
Date: Fri, 3 Jul 2026 17:35:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260703203502.GC1978949@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>

On Fri, Jul 03, 2026 at 07:58:32PM +0100, Robin Murphy wrote:
> On 03/07/2026 5:22 pm, Jason Gunthorpe wrote:
> > On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
> > > It is possible, when a very large mapping uses a single
> > > scatterlist, that padding overflows scatterlist's length field.
> > > This results in:
> > >   1) silently wrapping the value
> > >   2) smaller than desired mappings produced by iommu_map_sg
> > >   3) leaving mapped bytes in memory (no iommu_unmap)
> > > 
> > > Address this issue by adding overflow detection for previous
> > > scatterlist length field.
> > 
> > Urk, this is unfortunate, it means we cannot map certain kinds of
> > scatterlists? Meaning there is a condition that makes a scatterlist
> > ill formed?
> > 
> > This seems like something that needs to be more clearly documented and
> > we need to ensure at least the common scatterlist builders don't hit
> > it..
> 
> Well, it's taken 10 years to be caught by a test which seemingly expects the
> mapping of a single absurdly giant scatterlist to fail anyway,

If your server has 0.5TB of ram a 4G IO isn't actually that large.
Randomly getting a few contiguous 1G hugetlbfs pages is not even that
unlikely. Something like FSDAX has a very high chance of getting high
contiguity pages in files.

So I wouldn't be quite so dismissive that this is not something a real
user can hit.

> here, but I suspect this is likely just regular iova_granule rounding
> overflowing when the segment boundary is the maximum 4GB, since the largest
> representable segment length is 4GB - 1. 

It looks like the iommu_dma_map_sg() algorithm only works reliably if
the scatterlist entry size is less than UINT_MAX/2, otherwise it can
risk overflowing when it pads.

API wise I expect any arbitary input to sg_alloc_table_from_pages() to
result in a scatterlist that iommu_dma_map_sg() will map. This
patch highlights there are cornere cases where that isn't true, it
should be fixed..

I agree we shouldn't overcomplicate iommu_dma_map_sg(), so the
simplest fix is to introduce a SG_MAX_LENGTH set to UINT_MAX/2,
justified by the logic in iommu_dma_map_sg(). Fixup the core sg_alloc
code to respect that. WARN_ON in iommu_dma_map_sg() if a malformed
scatterlist entry is presented. Add a WARN_ON under DMA debugging
kconfig as well for the physical path.

DRM would then have to generate scatterlists with a max segment size.

Jason
