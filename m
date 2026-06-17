Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D12EDD40
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719463; cv=none; b=j9GO/JaMpTulc3HTtahieC/bCyWjw3g5jiAyGywBc2/QCtHXLEC8dOymEmwfPrHlyJz+d1U6aNV7bqDJ3rxlW3kHPIK75zlt5kgtEXloIRudnF509QLjJjqrPzTIo/vdXNZPHmsYE/AeFqIn9Vrme2qjN9G9t3sdkgwoiWBJArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719463; c=relaxed/simple;
	bh=nW/o6mN/VLj0TH3DDkLkpNNnQ7XaRbBINRNcg8MuK0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNpi0iGXfFjrxR1MftfG/OUUhCgtmFeZtbrbnh/i/LakhCOEHR7a/LgKwwm30cR5y/vmkk0XRbIR0nUTkISEk3+Z1p5uzV3cl2XgQV5hbb4cr1SBAI+jAJNC2sXN/+Cx4N5U/58bTL03U4Be1pe8BuUGH6NNjzMnzuyOy9+MQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P/+SZC6C; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P/+SZC6C"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9159477c893so15095385a.0
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781719461; x=1782324261; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43aClsIewUmRyeXaG13jiRHX9eRfmYOa6P/4ggqgHgg=;
        b=P/+SZC6CxwrYOS2K6WBzDa2sl6TxfH4ABrplXqhZIDClasxNmGE6oo+gp76i308ruV
         syzlhEtRI/03D7U5NeijKwXJqRBHFqLnJRJyQhsexHaGuC+E8BsCgPkLkDOLkm4H4yMd
         QwRYsR/vCua10rC/IX2CG4/o7BdLB3W4NdY5ITyA5HIvLmZv+eBV6psHVuBkWNnptq07
         XH/ei+hFzHpktOMUbYPGs6R0dZbZYmJmgrOI2HlvTW4rLhVEz7F9u2wVSRvVblp7mc/B
         CFTDd9qQx2BQ3zE73L4+ZxgdZiWBKRmChHNp6XzV9H+xZDooB9Pl7cVDOmZJIno6VGC5
         bXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719461; x=1782324261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43aClsIewUmRyeXaG13jiRHX9eRfmYOa6P/4ggqgHgg=;
        b=LFZiu8X+Le8w0fBzZubkXCKhKriOY0z44e57kxJfqvzcOLDALSGpRRVWptodIhL5CF
         hy90xJqjHCZ1KWw9fYfVWW48g2TaBqtv/R4JwmvQ3Ry7EdS8p5QqokF4Sn75e1uirKVK
         jYzQF1VJzoWvtqjYpz3QSQIQQdbB93Rueq03w5pmNOegUjKZ08xiXPKgioCjKCPMstxb
         Yzkm5kLoN8u3ZLos939btOMCbZTbPOjHqoCT5LqOQT+eJvxRpDamp53Yc1xrHtlXwj+j
         Ode/ca0IT8nXOt/v9WylaFm+woNJp83BYdDe3bYFgAbt+dfi3UldgbMtrv9XXXn5xBnk
         S3XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rN6jKh0ufGI1ScK3lEaxA4ypmAHi4dzuQNaDXGAan8YNjbQazvCXUiaTB/0Ee1R2S/KmqAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvCzMXugdBzIFFXe6fBIwlZ/NdFVU0XQRbsR4d+i2xuy+DJIta
	sGnS3hzlaplTO9tt2yaQeYbSDgb7VSbS0mHH3ei1R584GefDwPQT0cAdLQfgcaYCWiI=
X-Gm-Gg: Acq92OF9xF7MMGSx9uL+F049NcFjaRhxFXDFpNs6+5I1WhvgQj0fyGeesKrT23zv0Hl
	oYGcs1ZTst8j0qm1OO8GU6awIiKYXBwKTIz4VAyJ28uk3Gy+ktvO0VnT/+528NqU6PU8EtGgpMR
	0W1ii94erTIKhiP557Eax1RQBwlR7MO4NhtzJZ5ShZZFEwKE1wLCkhip2NiGAad/pyUPr5vF/hw
	p7Pe9vzySAqs9F+6MQjs59fxE+ODZDGbO/viGnba9y2FCuxwS/UDzNBh2jrbsk8jdcLn1E3ldvS
	xGyiV0Ab7LGX8+YWtGao9DuYQClrUeSQPBG27b/BVCryJ48K1jwZRBxgMOIN5QJue3qChjkj2EB
	Y0Gh76iloX/9sOEqLkcYlLolQ67T2cjGV+iexv/N4ed/Li51URSjRkFzV4Gp9ddHmyhVzgwVwow
	4qbGnDUJ6QOIrwVCm9x35uHZtSWZf1xpEH+j4cXvwFKMunINN9We/xqHlPX05x95OQpubv/441s
	huaBA==
X-Received: by 2002:a05:620a:2685:b0:915:c365:ffba with SMTP id af79cd13be357-91d8bfad7e6mr871504285a.55.1781719460851;
        Wed, 17 Jun 2026 11:04:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm1837505185a.14.2026.06.17.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:04:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZucd-000000013fl-2f0g;
	Wed, 17 Jun 2026 15:04:19 -0300
Date: Wed, 17 Jun 2026 15:04:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260617180419.GA231643@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>

On Wed, Jun 17, 2026 at 01:45:27PM -0400, Liam R. Howlett wrote:
> On 26/06/15 08:56AM, Jason Gunthorpe wrote:
> > On Fri, Jun 12, 2026 at 02:44:06PM -0400, Liam R. Howlett wrote:
> > > > Currently it never returns a failure to the caller. Look at mas_erase():
> > > > 
> > > > 	entry = mas_state_walk(mas);
> > > > 	if (!entry)
> > > > 		return NULL;
> > > > [..]
> > > > 	if (mas_is_err(mas))
> > > > 		goto out;
> > > > [..]
> > > > out:
> > > > 	mas_destroy(mas);
> > > > 	return entry;
> > > > 
> > > > There is no propogation of ENOMEM, it returns success. No caller
> > > > checks for any error here either.
> > > 
> > > At one point this was considered to be impossible to fail, and it is
> > > documented to return the entry or null.
> > 
> > I think that is the right API design..
> 
> Callers can check mas_is_err() and check for xa_err(mas) == -ENOMEM.
> I'm going to add a note about it to the documentation of the erase
> function.

That's something for mas_erase, but doesn't help mtree_erase() ..

> Why is the retry GFP_ATOMIC on a timer of 10ms?
> 
> Also, why is this patch set using an external spinlock only created to
> manage the tree?  Why isn't it using an internal lock?  Is it just to
> avoid the possibility of the unlock?

IDK, seem like good questions

> > 
> > > I think, in your case, hitting an XA_ZERO_ENTRY would be necessary to
> > > indicate that we cannot reuse this particular location until it is
> > > correctly dealt with?  Or is the maple tree the only reason it is
> > > considered unusable?
> > 
> > Yeah, it would be be a maple tree issue only. Defered rebalancing
> > leave space unavailable.
> > 
> > This is a case where there is no sane way to handle destroy
> > failure. You can't return an error code from dma_unmap() for
> > example. So the only reason for this complexity is because maple tree
> > exposes a failable erase to it's caller..
> 
> I think this is even more complicated by the contexts it is called in -
> that is, we cannot preallocate prior to going into this state either?

Yes, in this case at least the context is GFP_ATOMIC and there is no
way to pre-allocate.. But that seems like another issue since the
mas_erase does not support GFP_ATOMIC anyhow..

> > Eg _iommufd_destroy_mmap() is in trouble too, it cargo culted the
> > no-check mt_erase.
> 
> Are you sure that's not okay?  The mt_mmap tree is allocated with an
> internal spinlock.  In this case, the lock will be dropped, the
> allocation will be satisfied and the erase operation will retry.

Is this what I was asking before? Under some conditions the allocation
can not fail because in the modern kernel we don't allow small
GFP_KERNEL allocations to fail?

Otherwise this:

	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
		mtree_unlock(mas->tree);
		mas_alloc_nodes(mas, gfp);
		mtree_lock(mas->tree);
	} else {
		mas_alloc_nodes(mas, gfp);
	}

Is always called with GFP_KERNEL for erase. It doesn't seem like
external lock has any impact if mas_alloc_nodes can fail or not?

It looks like if you have an external lock then the hard wired
GFP_KERNEL in mtree_erase/mas_erase mean the lock has to be a sleeping
kind to use those functions.

If that's the case it should be documented like this too :)

Jason
