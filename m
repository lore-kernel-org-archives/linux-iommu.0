Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC0357D0F
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870940; cv=none; b=MQOf8BSfeKe5CAW4oUipmI/QnrAdRxsS0et0JZKKGs0iQVjaKi0rSb7cL37GzJhpfe78MqH0NGVXKAqoi8Kbo9UKttb82x6QuS0R9r/B6X3zlLx/lv88yimdI0vcas9oShII5AOH8XkB4QO1L9ixkehYQi9IYROxnnOgCXi1XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870940; c=relaxed/simple;
	bh=o8Jc2QAwPN2BwVS4+5xwf4PwyLzosFfb+u23wfEpPgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD4yt3p6WaUIQYcvS3KLG37I54fPLy4YYoJG6QqpcV3enEATnZHZ/MFGBqcpNTChrrIVX6IW4H6lEC15GFqefLukcnvgAT8pGtrrspC6XZYDnCJTPk/jQ9V4zPwEjdVcflN9Wx9/w20LA4Md81YCiBmJjfF997taf5ObKY+nK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fwwTxVIL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fwwTxVIL"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519eedc30a3so5984851cf.1
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781870937; x=1782475737; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxIMevCtBRecK6uApaEbNoa3x3JR7ePePxN3sqqjDu8=;
        b=fwwTxVILAjlWXjS4qtF4728uROtcmMem6fTVz225LfJMAl0RcqT1C/c+CQtNrSEnhh
         /dAxEGhQg1MTKIERcUVl4pK4AeDyJQVaK6amlzS6v3R9cfQEB656b97VdV+dtFJAxutU
         bCPWEs0Oxv8+jxhkuFBU/UjiaBL+WxxmOvuSXwbi9WY4G/9HKajDjsb/X2xe6XZAHtY3
         9rSK8yFQJWme1YtJiyjQdwBD3brvagKEajysqNFAKFuEbRlj0VXKr16qXDdYXHhsEtZ3
         xwhR04cTvlViMgYuUCMLK4wVm3w4/mOmv8ZNP5F44BhegfXELnOE75dKmpAqcy8UEpLx
         qBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870937; x=1782475737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxIMevCtBRecK6uApaEbNoa3x3JR7ePePxN3sqqjDu8=;
        b=pCQJRsZhBeho7Je/soDMqLsmUdERzWRdCfOMDM9PnmH9jKyRoOjbPfkj4cEmjybTyC
         isV1JzDNENGrsauSn3g0m7YkNXUxfD6XehQGd/eK3mkMxTcUAKSUPJTvCUjsRQr5AsQe
         ElqZr3TbPwaSORRyzuBdCCGGU3pygGyCvh5+nq7nDLD6S72z0RrGwsraC5tO6FoZ0VAJ
         aKOEaydmkHELYakdoaLj0+6yFhlQUyOHUumPUIwd4wOEhQ2E2k6xXxpI8tEBXDp4hkXL
         oqmkYo98pgu3X2Lb1DtMPV1qDFDHrir3savNwVERtE+MwZ7M4XoWA1vP8c0cLW3OC0Lg
         w6Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8ITGgkq5oFGkA5HUZFcLag9K5DNKN8viQnp64JaRxp+pMKUAuDeQspvJ7RadFs/zIMfS+EPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9oIAy6qepaL0shsLPx5SAVqRPG0B6AJ2nfn24eQ4YOi9mOcO8
	PEPgqZ3mYv8Kxmyysfngts14tFI5TBiDkq3ui4IcTilHNa9mW+4bJoOY5CRbPMFGuOQ=
X-Gm-Gg: AfdE7ckUPkjWuQ56iHrzd6uvxdtqM1HJ42flyBTp05wydZJX6TN1wVpzNdN/utG4wTe
	WyJ6WhGKBfeulRsrUBaaCnb2jJ6Rzn5lqG3V4dUzglPm/qbKC5BdP0D4T0olCrfbFkcAqiUdlZP
	U5rqElzVh43e6OA3JSfMJt7SJqcCyJHOa4aH6dyj6D6uoFrVmZ8wbem2skDvpqofEyFIhT6g5mz
	DAq44Fsju9oZ8oouMahdtdGNLXRc6KMVy2eI798gzBjrJm7BN2rgj+0ePfUQzfw347ALkwFeN85
	JYg8fMd8oZB+vQFwIzFyrqva5dsXnW6OnTPc479B2g8BO/e7Srn052tRRPqOgFkqYQK+ogqU37f
	NUzk007It/zg2WFouF2WDNl9l1kKd0a7VfgjJqU371tR0icHD6iLdq42Ewa7DitEm3vRPSAfCxa
	/Hd7FnRznaBo+lYFcZ+vbocb7UPS5CDhV/QWpNX1dMiTKmOe+qIra+KabcBaxh9KKnQ4s=
X-Received: by 2002:a05:622a:4a89:b0:516:e236:1d3e with SMTP id d75a77b69052e-519e4913049mr45445671cf.6.1781870935325;
        Fri, 19 Jun 2026 05:08:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a142f50asm221056385a.12.2026.06.19.05.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:08:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waY1m-00000004SxI-0yoe;
	Fri, 19 Jun 2026 09:08:54 -0300
Date: Fri, 19 Jun 2026 09:08:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260619120854.GJ231643@ziepe.ca>
References: <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
 <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>

On Thu, Jun 18, 2026 at 01:27:02PM -0400, Liam R. Howlett wrote:
> On 26/06/18 12:24PM, Jason Gunthorpe wrote:
> > On Thu, Jun 18, 2026 at 10:50:56AM -0400, Liam R. Howlett wrote:
> > 
> > > > If that's the case it should be documented like this too :)
> > > 
> > > Yeah, very much should add some notes here... but also maybe stop them
> > > from doing it by adding this to mas_erase():
> > > 
> > > if (mt_external_lock(mas->tree))
> > >         might_alloc(GFP_KERNEL);
> > 
> > Yeah, and then I'd add a might_alloc() to mtree_erase() as well, it
> > can always sleep..
> 
> mtree_erase() calls mas_erase(), so I think the one should be enough.

I was thinking an unconditional one before locking:

@@ -5919,6 +5919,8 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
        MA_STATE(mas, mt, index, index);
        trace_ma_op(TP_FCT, &mas);
 
+       might_alloc(GFP_KERNEL);
+
        mtree_lock(mt);

Since with internal locking this can still sleep, and it has to be
called in a sleepable context.

The one in mas_erase() is conditional on external locking and is
basically asserting the external lock is non-atomic.

> > Okay, so to summarize:
> > 
> > - mas_erase, mtree_erase cannot fail with ENOMEM. The check for ENOMEM
> >   inside should be changed to a WARN_ON to document this.
> >   Rational: in a GFP_KERNEL context it will sleep forever until it
> >   gets memory "too small to fail"
> 
> The ENOMEM check inside mas_nomem() is still possible because we try
> NOWAIT first, so it is possible that we hit a retry.
> 
> The return from mas_nomem() without allocations should be impossible.
> So if (!mas->sheaf && !mas->alloc) should be a WARN_ON_ONCE().
> 
> I believe this is what you meant anyways?

Yeah, probably, or maybe this:

	if (mas_is_err(mas))
		goto out;

Can it ever be anything but -ENOMEM within mas_erase()?
 
> So cleaning them up should be handled sooner rather than later.  I'm
> trying to figure out the best place to do this as I do not like the
> retry with the timer idea.

I would clean them up when gap searching to allocate a new thing. That
is a safe place to fail and ensures the gaps are correct before
checking them.

Jason
