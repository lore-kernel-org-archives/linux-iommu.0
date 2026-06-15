Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D883E3179
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524599; cv=none; b=XIBq01d2wPgVh4WQYqPvSwaiCI1orxGq+CFsANee4dnV/4b8LeOrBs+NWsrInR+gSWw44rrcoQ3P3QZU2kyb+wblSauu+aN40U9a5wrJ54Fsyd9UIh0dU4WR4YPMKcHgmGYIZgeWd3dRpx1XlrQtOF0e8y3/l841wdlhXUdrso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524599; c=relaxed/simple;
	bh=yH/SeGpcFCGHDV1706BiW8+nnaI5iZ/9LbVzaKn0iQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMHJ49uwvy/6XOjtE+phruNg8nwyhSZaWtZ5eK9pEem3Y23scIXbuvD4wzDE3UroV5Tl3hrJCC+H124ueTDnw0ObUf3BGsMCMei++IGqWlToVOsrQcxHjCVEqaJYO0JHuI66LzltEZ3c5RQ7JJMfkFa4KF4qU++6b/8M93Koc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kUDU7Jr+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kUDU7Jr+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176d4c14f5so25910651cf.0
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781524596; x=1782129396; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvdiJGH6VduHx66JQFq45JNy4dIs0P8Ux+SLclbZRcY=;
        b=kUDU7Jr+GImYX2CO5f/bR3PZlRR8u6AF22wQoeHfJEZDWXIscu2WBUGqYEwMYChHOs
         zRPAcwGa0l97GsgsvKI+aTDg4svCQxlN7PXnG4i66frr+E14lpr3Gerioc6+tm0PdqFp
         I24rgwTFT5FfkyeTN0SrPb+wLKyc4cjo3BLnh2+U3huJKlNY0GCmgx1O+gQoV4n6uKFX
         cicADAqjL6zwbySdtdoBOC1mlit4q4MNsMcqonaObBiwE4eTJNKXaIx/8cbHb4mjDNgX
         iZehEtc76qXg5MRTrD9D4OuMrqQ2+WH/PaSBcO19Mr/O721ojF/oR+BmJQATpPnjKEMp
         Ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524596; x=1782129396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvdiJGH6VduHx66JQFq45JNy4dIs0P8Ux+SLclbZRcY=;
        b=jS/plA6C7UvHNOa/T6/2e2dbGesWTmThavSsjGSVbJpdNFh7Qu+imgJJopqn9k/33u
         xUM0OgYXYJWgl0Z8cC9JZ2HfLmRCVfT+CKYJKLoUsLC3+OxMHFslr9TcwQIB7EZrY0PV
         LZU1AFBjy5c9KtdBotOx6XMfDJi6kTHHKxgcJ7j30spqut2QlyABAw00yHP9mlb0zg6d
         6Wen0amYqR6qUFQoeKU0AoCkEBHK9xsZolA5aaYvYcoPgeW0i/tlxjB72FSHFTBhiPcq
         M4NhsBSsqFQT8GAj6fRDYv3dPJfQcYzlP8jvjWwfqgoX1hYAlMOq2M+bvG4xjR9STj0V
         HoCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9llvFcRbIDGqsFbXA3rw4DtYQKiv8GxRI9lqiZ7ngVhnewDEvMqSRbWkfFM1E/Hz8rkqQx0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzljzzsQDnHXPrJeQjG5IGV9kuHQL592hLdxHSnQ5FwmcWvl8S4
	wAckLBJPk/0Th5+7A3j98OuQNkWWlLT39RGkaNzcWoHLmb2FCvK06pbOOg4V55OKBdI=
X-Gm-Gg: Acq92OEnRT3g4x0cFP1t8dZZkT046hk4s7PRVOKSNXoVo0+2P0JmyhfjUsFORdZOyEs
	uFPVibjxebtuD5wL/nZSQv2KStXGav+NbTQyWanrt4yJpXf//FU6N19VfiaX7b4603rprR/jFC9
	GMgN6ZDNIt7+ag05K5iG/OvRqHuffFPfLjdorcyaSc/4IM1YabupUvWEQRy5/zBiUCSLKis685k
	OTglfAEV2zp/uPks1DZx/6uzreFVSQ00b98RCbH9k83OlAQnNyMODXs/0xRVX3v789ZLF+sYztx
	RVQs2iOLqkXs1X5/SWWtb7IC9PWTK+x0jX1pnLF2Gn6m4Yj8+K01O2mZAxaMTAQZ669tZprzoqp
	liZmxgFMoTJMWkIhLPSY3fY0DZvtbuEiMSrg8JgKZIGoblG5XV3nLFkUDAa3rEDaRC+9ulxbhP3
	7CHcofxsvH3+TFoheUFnOX1io+ro+1HVWoODwaDXB70MmRUpY6BxC2nmPAMCMWDEZB3FaJnPyf/
	groWA==
X-Received: by 2002:a05:622a:7d10:b0:50b:526c:541c with SMTP id d75a77b69052e-517fe57de6amr152450211cf.50.1781524596452;
        Mon, 15 Jun 2026 04:56:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb6428a6sm123465161cf.12.2026.06.15.04.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:56:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZ5vd-0000000DJeM-0SSJ;
	Mon, 15 Jun 2026 08:56:33 -0300
Date: Mon, 15 Jun 2026 08:56:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260615115633.GQ1066031@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>

On Fri, Jun 12, 2026 at 02:44:06PM -0400, Liam R. Howlett wrote:
> > Currently it never returns a failure to the caller. Look at mas_erase():
> > 
> > 	entry = mas_state_walk(mas);
> > 	if (!entry)
> > 		return NULL;
> > [..]
> > 	if (mas_is_err(mas))
> > 		goto out;
> > [..]
> > out:
> > 	mas_destroy(mas);
> > 	return entry;
> > 
> > There is no propogation of ENOMEM, it returns success. No caller
> > checks for any error here either.
> 
> At one point this was considered to be impossible to fail, and it is
> documented to return the entry or null.

I think that is the right API design..

> I think I should probably change this to return -ENOMEM, fix the docs on
> it, and probably audit the callers (most use external locks or are
> early-boot-so-don't-worry-about-it).  Any issue here should also be
> caught by lockdep pretty quickly.

Locking aside, I don't think most of the callers can handle an -ENOMEM
return at all..

> mas_store_gfp() works if you know the range of your entry.  You could
> also write the XA_ZERO_ENTRY over the entry so that there is no internal
> node changes - just a value swap.  If you do this, you have to be
> careful when reading things back when using the mas_ interface.

That's probably a good option. Try to store NULL, if that ENOMEM's
then drop a ZERO_ENTRY and set a bit someplace so that the next
allocation has to sweep the tree and clean the ZERO's. At least that
shifts the ENOMEM to an alloc side operation where it can be handled.

> I think, in your case, hitting an XA_ZERO_ENTRY would be necessary to
> indicate that we cannot reuse this particular location until it is
> correctly dealt with?  Or is the maple tree the only reason it is
> considered unusable?

Yeah, it would be be a maple tree issue only. Defered rebalancing
leave space unavailable.

This is a case where there is no sane way to handle destroy
failure. You can't return an error code from dma_unmap() for
example. So the only reason for this complexity is because maple tree
exposes a failable erase to it's caller..

IDK, could it handle it internally somehow? Or at least document a
reasonable pattern with some helpers?

Eg _iommufd_destroy_mmap() is in trouble too, it cargo culted the
no-check mt_erase.

Jason
