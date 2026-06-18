Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F63D4119
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796295; cv=none; b=UzEO0NvuB7ByM3EIELvdFuqzvpnkPMtKWjvQ592fN0g7QEwhy5VCrxK7LS5PaoRmksfN+MxCH8j36Qr2OQZCCrw/Z3ykmzZIPdgKr1jV8sNoprIKOmwt/i43Z4TsMgJPjaerOgDAMRyXsW9cCdwZszwFmahUhasb1GEokdS8uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796295; c=relaxed/simple;
	bh=ZovzLQyiPv6W5F/MNpY/mwsM0rnVIgyZZuCYNFrli6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czccxLbzg0BcUe/P+e6R8wMlyShD/bdaGMr8fi+qC+JqRu5s2KcULWauG9n4L65iwTUzvnOsvjsNelkgLVbFgsGmLco7UEQZlh8uRE3ZrRPevC+oVo9iOFulLYB81Pjpqrtc3+1MlqfsCkQN6rr2/5Qvc6jZ28JaCWLFkizUywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ieXV6CGK; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ieXV6CGK"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-966d4748ad5so536891241.3
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781796293; x=1782401093; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Koroo30upNuvUdLSvEsP2T9t46cltHI5siJNKWCJyMg=;
        b=ieXV6CGK7csKVXU5cJ4bSuojhh3S4e+SvJHqqbJgTYxbO0oWPh7+ugxPjvmHznmRVB
         kdt/tWwC+n1oyTuY1Pwfc76sFFG6Eiy0hIp/hZ6H/oI5NgruatL3ERttPq4lqVYhcIVg
         pbf2PGxjobIzl2WCXtu/L7k8KoYt0uMlBTQKTLt+T+Fbi+vOLiAUJlTUVSjw3gC2zcvw
         DbXqGb9IoRroz5DsNpGLuNrcAVRXfd1BC+w0K7j6TAh7v3Qk6C5hjlbUMtk84MKAXNMo
         W/5ebripaKCgEnJty9EnfRbNyI+BxvlCBTQj7r3frLI4GEqlBsR8YkzftM43/YYpFL2E
         K1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796293; x=1782401093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Koroo30upNuvUdLSvEsP2T9t46cltHI5siJNKWCJyMg=;
        b=mrMIGAjxRGtjhE7qMXHM+zDGtG8omjR6+5BBdzHj2S0uiLtCX1V5Qfx1co63h0XMAv
         ZguKfv1hUgcp367vDwrHT3EUK9z+4SmhcZdx84ZZIF0vU927erlEIwF/8TIWJrqUIW3a
         g3AnkVniTnrXA6thFHsYvDR9Dzs8AP8/bEw58Y4l1VjhtY9vghZLNgI4PrslH1LZgZYA
         FEw2otQrbQC6mPvP2WMATqhMV2mdVLfnsIO2J4IN7GUhzjcZjpwcyFkOwiogCrKExDYY
         cW2F67/QjHaEaDZDr/ByHrRQByUBjj1enakGbXFurnJRU3Lt1H4g9pvLRRYve7XAxNDo
         Tm2w==
X-Forwarded-Encrypted: i=1; AFNElJ8PFWl6BlyyOkBR6u3YIFaHKto3Tu+nWewOqDOnMQR5K10CUt6iEtxk9F+G4136hP/Yi9sVnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw90btgKOsqad5oetN4y+jN07l4ELvEcoC44svdcTZfNJkq+TNN
	ud+9FlX+QrH3nBs5RLUbX2VZz2pRnuUqwNV/NAlAANuaVxMrrQA++FTHxuOI/aSLe80=
X-Gm-Gg: AfdE7cmO32ZRy62r7W8BlCbI1As5ho1i/U3rWX0g0rb6DriTY7M8ovKwsorentBJp7t
	WiPWgu9bLbGCCB2e5/QJmCnR3iMUqqXFllA+tnylaWHHXC9yCo+P+qHIZAABEb0QpgsJZ+ggj+Q
	GNpmJrlx5zKsors6D3h6KCHBStUpCdOOl2KU6xv5aDvg4GdPIXADMDRptyU6mVp9VsMmzsaFQCk
	0gIAE+cp9ex4kU8v6jo1yQwWdKsnou4ynjraOB2pg+/av/06GNxijUQeDq7V4YqQhDq/K/xvJDU
	xjwwmth2p5ioLYUZbjwgR1vuXotZuSDwZ+c+udXg68t7DV10RAZQSjj6rl0wW9+7BQwG7wS184J
	8HgERiEyymE94j/vuCTS3rt+A6sZ9T072CStDoLZSCl95QuSVyDUKviozZMTXJtydLdZRxqnzyy
	sHOlGP3TtZdkS0fl2creWtH+tz9sWim95K8N0rEvXYJ4ul5qmNKgDOPHI7Uqwecd+inxU=
X-Received: by 2002:a05:6102:c46:b0:726:8813:2085 with SMTP id ada2fe7eead31-72a03a6bfa5mr52389137.13.1781796292971;
        Thu, 18 Jun 2026 08:24:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006e35sm2126884185a.28.2026.06.18.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:24:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEbr-00000002sU2-3SmP;
	Thu, 18 Jun 2026 12:24:51 -0300
Date: Thu, 18 Jun 2026 12:24:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260618152451.GE231643@ziepe.ca>
References: <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>

On Thu, Jun 18, 2026 at 10:50:56AM -0400, Liam R. Howlett wrote:

> > If that's the case it should be documented like this too :)
> 
> Yeah, very much should add some notes here... but also maybe stop them
> from doing it by adding this to mas_erase():
> 
> if (mt_external_lock(mas->tree))
>         might_alloc(GFP_KERNEL);

Yeah, and then I'd add a might_alloc() to mtree_erase() as well, it
can always sleep..

> Otherwise, I'll just be telling people they didn't read the docs.

Okay, so to summarize:

- mas_erase, mtree_erase cannot fail with ENOMEM. The check for ENOMEM
  inside should be changed to a WARN_ON to document this.
  Rational: in a GFP_KERNEL context it will sleep forever until it
  gets memory "too small to fail"

- External locks must be sleepable, add a might_alloc() to check for
  that and document. mtree_erase must be sleepable

- I like your idea for Rik to try to store NULL to erase, on failure
  store ZERO_ENTRY, and then set a note on the next alloc to clean the
  ZERO_ENTRYs?

Jason
