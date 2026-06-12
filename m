Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140221D61B7
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287387; cv=none; b=UWlSjb3UZ9SUesw7H5UGz6A5Zj8n1FU77l2dPZcV60LsC+L4R1c1jiaeHHaBz1eHoUIIoqWirm12ZRoXbfXvckpD+EVEOsdHGcqqmBqk3Ve78yThT6BTZ7L7KfnLeA6kxLllFhjWDg6vjAG1dgLaM8mxphGH++khoq7YYVNb/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287387; c=relaxed/simple;
	bh=mn3yVOv7qKPFWYBvFnk75CZs9rsQ7cExwWlUYRYxI2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHJZQiFRiL5vd+AHwRu844tcqYJ/t+UgZvSdXvD3ZBvIUmfhFiowNCcp2yubGjGSj7HfoiPkW3A+oCyNiWxH1WXsmoZbAam1rsbYhS98YgSf+vQ9Qs+TuaLReKHr8X6aJiYrUym/1IYT+ND53+r9nIp/6dj9zwOfodS1sxhySlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Bkl2qHJk; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bkl2qHJk"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so850567e0c.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781287385; x=1781892185; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTSufejrrgKqac3GQqcQTlYgn8yTYKUBIBFNWIyXYbU=;
        b=Bkl2qHJk5fAmMrYVh8FOwdnTrdDWtYa4lS9797a4cfjB19e+jjsn8AQwCl+L1AoFvF
         opNdWlYU4yQqwdw/XLk3hS/fPVfxORMpdiMX5apD6+q9GKvnu0C2GxIiO5s64B6LM/13
         L/8Pk9+kBgtDcME5xdKvr7EWwaQswV2YS5hjNaQ3iIMgCkzrWM8p1Fju6a8cJ1XX6Sus
         FA/PG3f8h8y4fyONNRzU+asQTIVXMtaO87AEKNX8NVV7iY9eaLw6SmA4rSru3xGJgkcc
         z84x4S9T2eeGuaolhB2cNlugQo8S/v17N4jvwF/uQ6aJbXKn0xQHRRYNmZNajHmqk1jQ
         yGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287385; x=1781892185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTSufejrrgKqac3GQqcQTlYgn8yTYKUBIBFNWIyXYbU=;
        b=G+R4AxPS6WIJEVEox/cX+BEyGP32V0rZ9Py4k8imVLYHsE01PgoxIs3RIVCUiyo76h
         2bzRhdGko4Y+NTYAalo1Wgpo+ts0lPEOHfSJyHzTLeXKrLVgVpfvawX3+dJx/ZgRsSO4
         DbU1Axh24nXjAg4Dow3wTeYwGt88QOXmfssLklw95NwYiko1TjaKz7C+XEa+SPFUHkQY
         pQgB3P6IlC9spDAbMyY6jRp8Vsq+sVPhfTE9W8hUb321sEBip9cb0zz5W/O1L8SmGWqz
         4AMVVjNX3KRTW1VH7lgo/aHejBlVCwuuXS8QuS+QArqRcI/O59/6XPfs2cVBNfjeAnc6
         fNrg==
X-Forwarded-Encrypted: i=1; AFNElJ/hZaaUFNFAZVT1R0BUuUGkzzxC6nUzCaCX2RGdamUA0rInuBv8hoyoq92hu2Ky7Asj+51bgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo1Y/IQTK5NJpuyltqR8yjG25ZunoaLz6+1yO5LPVvBB2XKclL
	FydYa9FVft+wkGdgG6ps1QaPDBjJI1itSqnXe69BuptvBYx3FFE4b50qnnkrqfX7FEY=
X-Gm-Gg: Acq92OE/YlrSpoZBSwxJLJJ1waLebhf1Hpg3TUo4p/60jukgBT7azyhI6Ogb4+vMFKW
	ghTJrCJnQyC+RUOG6dnr908jgWRVnW7ms10z3f0hYNqYGq2E4Ua9gYUVDJpZVDKwLrmpmpUi5KH
	f1v9001nYkSdvGcYBnEOW14VPlST7+iInXjNdrRjgu9XuTc4VTJiQhutRnjlzYNDC48jh7rBTKM
	ut0nouS1iCBkvsp59ysg9YJaM5csjSz69e1X2M4o+6u80w9pHoGrhgd1GBteFEiVNtEHsT38MOY
	OpwJ6RoX2SRa70TjKeoVazQshM/sbkIwnTpAuLPVCr3dDvEKOHjopN3mDui9nVRm3cmvdl4uQkQ
	O9Hgeo8NwsEl8X8RrsVcGVex0ubhkiRpGFf2AwCzgsAOhPKNXF6lSXAWQJfF568lmUMaGcKkEVH
	U5eZgVwyT5r2pj0NU8qrP7kP4UkCSNVeUZIpyZSPvdFPlNl63JhYe8FHKiaBJfx9H2fNl6ugTJB
	TZIXQ==
X-Received: by 2002:a05:6122:3c4c:b0:5a0:9ad4:700e with SMTP id 71dfb90a1353d-5bb6bfaae71mr2720111e0c.3.1781287384899;
        Fri, 12 Jun 2026 11:03:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304b5f833sm28994906d6.38.2026.06.12.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:03:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY6Df-00000008DO2-3Bki;
	Fri, 12 Jun 2026 15:03:03 -0300
Date: Fri, 12 Jun 2026 15:03:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rik van Riel <riel@surriel.com>
Cc: "Liam R. Howlett" <liam@infradead.org>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260612180303.GO1066031@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>

On Fri, Jun 12, 2026 at 01:23:58PM -0400, Rik van Riel wrote:
> On Fri, 2026-06-12 at 13:48 -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 12, 2026 at 12:02:55PM -0400, Rik van Riel wrote:
> > > 
> > > The mas_erase() function calls mas_nomem(mas, GFP_KERNEL),
> > > which is not safe to call while holding a spinlock.
> > 
> > Oh, the kdoc doesn't say that, it doesn't return any error code if it
> > can't allocate memory, and not a single caller checks for erase
> > failures.
> > 
> > I assumed internally it "somehow worked out" even though there are
> > allocations in the callchains..
> > 
> > This is probably a better question for Liam? Can mtree_erase actually
> > fail ENOMEM? Is it safe to call it in an atomic context?
> 
> Yes, it can fail.

Currently it never returns a failure to the caller. Look at mas_erase():

	entry = mas_state_walk(mas);
	if (!entry)
		return NULL;
[..]
	if (mas_is_err(mas))
		goto out;
[..]
out:
	mas_destroy(mas);
	return entry;

There is no propogation of ENOMEM, it returns success. No caller
checks for any error here either.

So I think the intention is that it cannot fail, yet it does have the
memory allocations and busted failure path. Hence asking Liam what it
should be, and what about an atomic context.

Perhaps this might be relying on the modern kernels "small allocations
never fail", meaning mas_erase never fails, but then you can't
call it from an atomic context..

In any case, it does look like you can't use mas_erase from an atomic
context anyhow so your prior option with the mas_store_gfp() and
failure handling seems reasonable.

Jason
