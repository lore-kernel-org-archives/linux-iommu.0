Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8B31F998
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282936; cv=none; b=nyOg+BUHh7eaVM8Uqsyz/vBdsBHnqsTssvtpNNVxo7PL818qKmLuh+P5+/ojvY4bUR5vgbR1nFqPDcaZFJWOSFqQos6gR+JJcSI8QU+G15VbMk6WsideVuUEQfQJTWjwZr7nP1OY0R5sDWEgLVeNepuDuawTM+stN2GZmWKQ8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282936; c=relaxed/simple;
	bh=TkX9O7T8Njp2RpaI6bqoiyhikVlYYnGrUzfuC4IXf24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgrSdzYCj3evBiM+LRdE3jEshD2O4iOdRgplw5l/+UpzcgqlEsHZNr6pbajXTXYNoMpeo0QZC6YhIWLVSC3BXqpl49vfDiYcG1R14gE0Xhign9TSY0ltXVP9dtX8GyGzPHAt4OeXwNm3Exck7rOW4hOEecfH042D31HRvotbIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AfNCHrMJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AfNCHrMJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177b9a02bdso13971561cf.1
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781282933; x=1781887733; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0KUzhoWSaFOIOwUG9N9tUwmS+pqPKv19ah9sw+5s5Y=;
        b=AfNCHrMJTkXb0psqIzxRNnT4GslWud1YIJkxYLUnpKlffaHDN6/ADDvLuD9g8AMXbj
         2la+hKWMJeq/j2y/ZjVnUOIxdvnfnRH1D14e2Kr9j2xYTrGgq8Wwpcj2wTrPBcYAPhbG
         Qx97CI275zLZEk44+F9Sxwh1/nQo6hiAuvlVVxgcZOEhIZB4bWIiqlR4Jx4xr4HaWWxu
         pazuQKVSWv2157IVN2BG7cniyOZCNEjBGSYriVs+wpSmYT5oTP7BjYOcJYn9M9rV17x8
         L2wIQQ5HR/DMyLxnKdcOTwGeDercE7JNsAzQjlHp33/lZMiVDzo6GH/CJ8Fk+v0YoUYh
         0Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781282933; x=1781887733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0KUzhoWSaFOIOwUG9N9tUwmS+pqPKv19ah9sw+5s5Y=;
        b=V1W81/VcHxJtMlNYHABpfNzZNU/qogrsP5mWNAKX+1ezt5xuIruEUx9xuqK54zsSXP
         hSEE3Bl/A7bpjygc7/XyPzhvx/4vKBaRW7zp5x5YioGKu1Qaqs6OEwNLiX2FEF0M6ESg
         4vyKeyjQ8Nry73GHhyy6OKp3cvijmoc3CWMvXmmuFbAvx7WOwdAQSBnuMAUu0BkQnHnQ
         Xj5LHxVnLimpSoHVUSFDOMVw+pFDK/I8Q3Mfp/lt0Qx5x7WmY1NLfJOOzvwFxIcm6GBb
         lEosGtNvmE2xiJTgzAzJriCgparJfapWiZgOYErlfIR2kQGcpDvGfcWN2IwIrnzqPTjh
         sT6A==
X-Forwarded-Encrypted: i=1; AFNElJ/R39t5RDepXxwRkWqWKr+Do3XVvAz/R3CMPaF7wxmpkW8aU37sYR+0o97pgNM9e17o3rCcPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkvAMTLPgodK8s3PqHdL96M7G7zx3mCBPP+8DR16zceW6SN99R
	dtZc/QkwLGxezrNj0LvLAj0L5r8t7sMbU2fQwbGhli5A9yw9iHALSfkWrmraZbFVOVI=
X-Gm-Gg: Acq92OFYXPC6riwQt0J6Jp1warY9zIqeOkZ5pJ43S+gTUogGzRrMMB63dwfU6W49miq
	nUmrbNJwYXyQAvIcWjthv8iVIVeed2H2qoH1pfrw4IZZT0AfzCrAqB2sScIVqsuuxzoSWcmsB+9
	SZJJFoFxdRjulFXTTpoOgr2cGlygTSvhHzrrKDg7pUq5t7kVDccTWvlWqoAaNwGkhXSKY0zO43+
	yXuLd8glfaI5yAljyGPDdv6+IYK3qyanZ8fZIeLht7LldJ8mOVq8WoUAY1JuIFXPI6IYvZdaAQw
	Ml1sr4ubakN5x89ULUK0CSCFpIWz2laTAKsRDAXeON/Shba1NNUfCkTJrl5ne66cyBbnoe27RQp
	LeASKh9VEpdjL6iGylxlqZooGiVCqw4uGSqMDaC7TvHUK+JSdc7uTql7Z/+SuuA9F52RiLFiSlS
	sHuFDXqixKHC+upO/oqUmk/3hINdigZoi77DNFiZ9fT5fy8Do2ndl0FmmPUz5v4A4uBIpruUv0B
	wh/Dw==
X-Received: by 2002:a05:622a:118f:b0:50f:b13e:b746 with SMTP id d75a77b69052e-519535e7c54mr5807451cf.44.1781282933376;
        Fri, 12 Jun 2026 09:48:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm26616601cf.20.2026.06.12.09.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:48:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY53s-000000086Ac-03f2;
	Fri, 12 Jun 2026 13:48:52 -0300
Date: Fri, 12 Jun 2026 13:48:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260612164852.GL1066031@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>

On Fri, Jun 12, 2026 at 12:02:55PM -0400, Rik van Riel wrote:
> On Tue, 2026-06-09 at 10:04 -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 02, 2026 at 11:35:48PM -0400, Rik van Riel wrote:
> > > +/*
> > > + * Remove an IOVA entry from the maple tree. Returns true on
> > > success.
> > > + * On failure (maple tree node allocation under GFP_ATOMIC
> > > failed),
> > > + * returns false — the entry remains in the tree and the caller
> > > must
> > > + * not free the struct iova.
> > > + */
> > > +static bool remove_iova(struct iova_domain *iovad, struct iova
> > > *iova)
> > >  {
> > >  	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
> > >  
> > > @@ -165,7 +175,36 @@ static void remove_iova(struct iova_domain
> > > *iovad, struct iova *iova)
> > >  	if (iova->pfn_lo < iovad->dma_32bit_pfn)
> > >  		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> > >  
> > > -	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
> > > +	if (mas_store_gfp(&mas, NULL, GFP_ATOMIC))
> > > +		return false;
> > 
> > But why does it use mas_store(NULL) instead of mas_erase()? I thought
> > the iova alloc/free has to be pair wise, we don't split allocations?
> > 
> I just looked into this some more, and I was
> confused earlier this week.
> 
> The mas_erase() function calls mas_nomem(mas, GFP_KERNEL),
> which is not safe to call while holding a spinlock.

Oh, the kdoc doesn't say that, it doesn't return any error code if it
can't allocate memory, and not a single caller checks for erase
failures.

I assumed internally it "somehow worked out" even though there are
allocations in the callchains..

This is probably a better question for Liam? Can mtree_erase actually
fail ENOMEM? Is it safe to call it in an atomic context?

Jason
