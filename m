Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878400;
	b=mgiFt2Ep3DVdB2/BNBQbQls/xekWUhKkSdDXH6c5LBuY5gcERMKbz3Ntl2ytL8rnIb5e
	 B1EjYMAxwa6oNkEtWaQM3TuWgwq8gtFXnmySpUNJBShXJw8Lhfj5a3viKy4VBy9Z98wLq
	 IT7LV1V7zjRP5LMdL9K94UEq0Vl5jzvY3x6lfSLNycFQD9w50PMMYyQjtVfzsYaozFQ6P
	 rfv3mnXcGW7U2V5MAfj0aRv/NxtOJmIlRxSWRZsdx1RNn5nD+7atBVxqQhxMlVjbpXJN1
	 oFKQx5zesMEGCL6Ov7tvuR0hRy0qorCeFfYKuDh38bnpzgtl9juTnpY/l3JVG7ihwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NVBsEmD16FpESz0NWKiu98OgFV5Vu9Lx16xH0y2alVM=;
	b=ZdPPADmpWrt1Hv4moESJ6Rev7agV9imBHGFePFYEEOI/cZ0fZjmwvmtfoWzb16oWfGng
	 SIHquxgVN45O90ZPzt/OsiAq805xguT0JYg41/4TIW3ckgPl8X4ePQGWE2c2u0ynvzWZm
	 Y3zBHcMzTMnuW+htkenONV7g213DPnfUO9aY2TSS4XBxI4OD89jDtsQ1GRXC4K3LVeGlZ
	 8Vwb0Oc+k7as4FsWntf/xGaplTpHP0E2O8nW9zavx9HwBYdavHC79xNjWg+6P6rF5+WpK
	 +t3iUxwsTPUUuYYmyH1BbCjAEVze0cQ/dAxLD6QVGLtc7BLwOpVsodh01+OGdsz+COA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aSmzgZ2O;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F86606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F86606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aSmzgZ2O
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365f9a04c5so68263451cf.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794878399; x=1795483199; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVBsEmD16FpESz0NWKiu98OgFV5Vu9Lx16xH0y2alVM=;
        b=aSmzgZ2O7CMl6aONk2OmMxfKOlAihshFqbL9XTxEdGJ8vom3n1/oX07TWoiFDeC8w1
         NT2kc0ZICpRhXFxrsHH4GySFEQOKCeTC1nYT95yJY0j2qwX1njXFN1fV9NlB/nPSzb7S
         MATnWIZkCqTQAo6Fk7n0q4TF5FaMLYceIHz8lpWM/rNcKbzHlk/HofJYbx/cyWVDn9Be
         xlR+dPfj5HN0382YWiM5viFNF7w9lqpHSr8sTqLAFiVLGoLZSndEiMQcV0pWKyQQ5n0F
         DJC5XAACWRv9EzUKNjZ66KceYTSTohlF3AfQIYkzsbhxP3N6UQtvkDx+K/L8PzyxmpC/
         THvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794878399; x=1795483199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVBsEmD16FpESz0NWKiu98OgFV5Vu9Lx16xH0y2alVM=;
        b=MbmabRHETIIxfp0bawWFrbSTm7nl1cf67qYbVGgqeDtlJUD9sAjAjYb/MlZN8IxlDR
         tsq6tWm0g6FMVM2B21bJtnlP58NVewOBsDnMRQ/jIAG26QUabezF48q6nnCaC92ADtJ7
         Clc4wXF8TUEPlaaiR31W+xEQGBx2B9aq3gFJGw8iyiburaEClCzyx7X6X8A6bmuDmCQt
         ZJQ6SqYO4kDH1Nn1/+B6++8eEw791WqCr0J95F2uJDxIts68ck9lhf3nlpTl+6bsO2qS
         ie4+1N1xtbbwTJPUUevby2rI07loeOudbf5ddP4Py8RFQsh55azGXNbBEu2ruwGFKmAi
         8Ppg==
X-Forwarded-Encrypted: i=1; AL+hErE6oWTPFiXwHszmqZVB3w8y85DWeSbnilncPfVTifTYxefoNHwg9vNLCXIY+2aW2Abs6Ju1Tg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/zVuK/nLcwm9KYjTliHqYQ6ACbUqW1k78W5F7oH0KjcRm3Ngnx
	V2/Ejtn4X1sWYdE/kZIlKiOGQ7oz4NFpszX3ol7RZDa10ygUmVZLtP9uI2x55e1Rtdc=
X-Gm-Gg: AYBFou1xIuB2i7NpenBpn28jY1uGcCAZIgS/jSU27TxFoTjFD77ty2SdsxadUzS5hNX
	peBqUTHKzA92DHYaGPwNyiGL3FC8OWyWuDdzc/I/P+TE6etL1Pjs85J0NJAv4PhhjMq7RagEba9
	SX3e5wcnnvilD9QrR+JiFsf/fGKZ51gaHiFnkgKWFpw+H0ANPkOq6NGu/XYS4BKcMQ9FXhFBQWK
	L9c3/p7o5ZwQecShUevew/HS5Wj/7YoYIMXZSBB3Ct+kDbxhQQSXalmDNGIb/I/qD4C+HhvCDMu
	JRbuADrzpSDR3Mts1CdX2jf/x8lwkdBHfpcqI2QqEKaWvW7CfTzI0EwcaWgnSR/1QIHraO2ME1s
	ylWYohst0Ns7BdEqhmjAzV9fAhSsSdBUDOel2PJN/TJ1vdkO3SazTIA0rQ4Yk/C8YPhLwhbN0zP
	QBfLYMl10MCoiHzTyP+kXE+0JsWEnvxtuj245iczh+dkYebUjW6lGoudv0Mmq4icOpK/6lkm7pK
	3SPsrT19zJSQ0y4oZm/wT2cIyY4nd7cSjLWbLv0ZG+aySMVH5ZWTEKBcxZ9Ok4vuN3qhjo533cE
	xnbUoJcpMR4EB2h+xtoI/FYAj0k=
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id d75a77b69052e-55cc7ab469bmr135845571cf.29.1794878399070;
        Mon, 16 Nov 2026 17:19:59 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ace25973dsm94741791cf.2.2026.11.16.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 17:19:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT7rW-0000000B1jo-16pQ;
	Mon, 16 Nov 2026 21:19:54 -0400
Date: Mon, 16 Nov 2026 21:19:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Message-ID: <20261117011954.GB2606445@ziepe.ca>
References: <20261114004101.GE2532299@ziepe.ca>
 <20261116113808.560717-1-xujiahao@cmss.chinamobile.com>
 <20261116134920.GK2532299@ziepe.ca>
 <20261117091333.399547-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117091333.399547-1-xujiahao@cmss.chinamobile.com>

On Tue, Nov 17, 2026 at 09:13:33AM +0800, Jiahao Xu wrote:
> > And how do you let dmabuf go through?
> 
> It does not reach the check, dma-bufs are taken by the branch above it.
> dma_buf_get() only succeeds for a dma-buf fd:
> 
> 	file = fget(fd);
> 	if (!file)
> 		return ERR_PTR(-EBADF);
> 	if (!is_dma_buf_file(file)) {
> 		fput(file);
> 		return ERR_PTR(-EINVAL);
> 	}
> 
> so with a dma-buf fd iopt_map_file_pages() goes through
> iopt_alloc_dmabuf_pages() and the else branch with fget() is not entered
> at all.  iopt_pages keeps pages->dmabuf there, with type
> IOPT_ADDRESS_DMABUF, and never a struct file, so dma-buf mappings are
> unchanged.
> 
> The shmem/hugetlb test is not a new restriction either.  The file branch
> already ends in memfd_pin_folios() when the pages get pinned
> 
> 	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> 				   nfolios, &offset);
> 
> and memfd_pin_folios() rejects anything that is not shmem or file-hugetlb
> with -EINVAL.  The check only moves that rejection to before
> iopt_alloc_file_pages() takes the reference, which is the one thing the
> leak needs.  A v2 doing exactly that compiles and passes checkpatch, I
> have it ready to send if you are happy with the shape.

OK

Jason
