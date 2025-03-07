Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F4211474
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342812; cv=none; b=ZJunXAIvFHTeGzOXNbkBtM6x7LrCSoD5C/62DBB+18F7dm0JtKRsTJoNuRRnEHnYe1nvggj9x7gTesIluiYs5RGJXPSgtvv/gAo4Dbr8rW9XNVBwI/fHB9lVhqDE8dX7CnxQZHyUTRqstEISk7yBv/5SG4yIdrpXnkoVVZEcBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342812; c=relaxed/simple;
	bh=79LSSp/0eeR8AeePtwzHkpxVlnVAzHXOhFEG9XSuVcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7VK/HxLH4d4PkW2onjR31I9MKUrAIzOj4e3GL8/ZG1VF8A7K/SJJca0GeizaQu/qgnj76za5mhMPuazB4KZSaXPGgCx83h9G0HxiLm+96YXu60r97lYGwYAbdlRpIoJhiEIb8CIgcaPK6+mxR73BjHfiR5K+RzUAxUCsPzhCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZWM2SfMO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZWM2SfMO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso9380125e9.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741342809; x=1741947609; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZvaNwCaRfuC9eejyQ8YerbsFpOq+0SleVUFJwnjazQ=;
        b=ZWM2SfMOg5HQ2fgznrHwhGjQFkS6W/kPT7o25+WBtcHiE3xhyYAJL422fT0M1zrH7F
         c7xt3UZiHLycwtV14Id+PTJXs9BQrKE0utMoCi51pjsbNFTy7ANqlYa7PhLw1cNbifr7
         hh9MLyH4xAQUBa7HfFndDWrnmYCB/tMW14duY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342809; x=1741947609;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZvaNwCaRfuC9eejyQ8YerbsFpOq+0SleVUFJwnjazQ=;
        b=VsmLJTP4ABXMYU0lQulW+OyS4hCAI5tkUVEIe1lCUNtFIPYUbiePwSi4I5o8Yweulj
         EF9qF3uFBeeRlz9d2Uy0AKfUKsUGjYMV1ltboIZ5i0SlKsebHDbDuS2Nc1yyYdSV3TNi
         PHghaeVcpWB7+zzK7jcikoVokdO2UTskVhn6+F4ficCijAWzLGQymWdRRsr2Gl5ROS/s
         tzAjWxHmR6/W2ADUj1ZZLtaVmfO4ESxV3tSd4uEHs4hMXXg+4sQNFAcyd/PBb99sSgYj
         bzj2KKEz8tSKpIB/0tmJY41ZImwlNa4VZD33bkLPQnbrKWXFY96jw7TVOmTDlHY6JZC9
         hJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVIPeE5ZACKrO3qgVc6erhcSOrL0RhK3uY1JM0P/WIALI2UjweedRYF+7vHZVnFAq2HeJV27A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTY5935H4mOcvl71sUAFpFUnEEK4ycw2rBfCg5bOvVZvZtnq2E
	jN/pgjL9sekv3kxwleyn75etjg67GzeXPONe6OK1GZWvYFIDJ4kGG7H5TwyOUuU=
X-Gm-Gg: ASbGnctYSeqTrsqjGJFXxURotAXmkD/TvsWwUTTPrG5e9LN7lHXeZQvBpBTbshDjwiO
	lPm7ri3NfVMMoKgiB673KOz3oz8+Sqpz/1OzoYPM0oc5f5uBXbV+4kNm5aAfrdyGzammTsLQo97
	3jKayoyFxd0wtOiG/BmczDijVUtxspbmbHfp0Cbdg73C6lReJP4HwI2G3h6EDSwcWPis0UUbVzq
	zCneficyd/ZIFbNbZXbRc5RaOZRmrL9VT1znPj6FxTf6NP6IYxPFK6p1Q4Rh8XDzyQTBqaeDCN+
	rwaHcHyzieotIHpX6pHb7p6bnLpFMvHv2LqLv1qzsjcDYndZsQKP0BZI
X-Google-Smtp-Source: AGHT+IEPRCaRwwby9REx68urow5tcgId19HYNZtfxn60gWBti42p1dhExwqD/ktCzPXjJr3OxDEBmg==
X-Received: by 2002:a05:600c:3b92:b0:43b:c7ad:55c2 with SMTP id 5b1f17b1804b1-43c5a5e9853mr18146135e9.6.1741342808680;
        Fri, 07 Mar 2025 02:20:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da097sm47877475e9.17.2025.03.07.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:20:08 -0800 (PST)
Date: Fri, 7 Mar 2025 11:20:05 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z8rIVQV0GYqGUYbh@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <Z8nFJjb30_Wm3cJJ@cassiopeiae>
 <20250306161818.GG354511@nvidia.com>
 <Z8nOjV5CoUfq6ogU@cassiopeiae>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nOjV5CoUfq6ogU@cassiopeiae>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 05:34:21PM +0100, Danilo Krummrich wrote:
> On Thu, Mar 06, 2025 at 12:18:18PM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 06, 2025 at 04:54:14PM +0100, Danilo Krummrich wrote:
> > > (For some reason, when replying to this mail, mutt removed Sima from To: and
> > > instead switched Cc: to To:, hence resending.)
> > 
> > It is normal, Simona's mail client is setup to do that.
> 
> Huh! Never noticed that in the past.
> 
> > 
> > > > I think for basic driver allocations that you just need to run the device
> > > > stuffing it all into devres is ok.
> > > 
> > > What exactly do you mean with that? DMA memory allocations or "normal" memory
> > > allocations?
> > 
> > Simona means things like a coherent allocation backing something
> > allocated once like a global queue for talking to the device.
> 
> Yeah, that's what I propose then.
> 
> > 
> > Ie DMA API usage that is not on the performance path.
> > 
> > > > But for dma mappings at runtime this will be too slow.
> > > 
> > > What exactly do you mean with "DMA mappings at runtime"? What to you think is
> > > is slow in this aspect?
> > 
> > Things like dma_map_sg(), dma_map_page(), etc, etc.
> > 
> > You cannot propose to add any runtime overhead to those paths and get
> > any support from the kernel community. They are performance paths
> > optimized to be fast.
> 
> Oh, I didn't do that. How could I, since I did not knew what was referred
> to? :-)
> 
> Quite the opposite, I fully agree with that.
> 
> I think for this we need higher level abstraction (which now that I know what
> was meant I know Sima proposed already), or maybe provide an API that can
> consolidate single operations for a single Devres container, etc.

Apologies for creating a confusion here, and thanks for Jason for
explaining what I really meant :-)

> But that's out of scope for this series.

Yeah I think for coherent allocations we can get away for now by making
sure you can only get it in safe rust code wrapped in a DevRes. I think
that's solid enough, everything else is for later.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
