Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BA33DEDD
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714854; cv=none; b=bW108xuI07GDsTjWpN7IofhmqN+pHp5aGDy5jZHnZLQDBE7u5qSkudDcGvnmaf+5EharhpSPp840xQTifdRyKRdxv+i4XZOuKmAnXExmDNWZYoBxGMSVHv/QLWMtMVHQp09dB0z3Iq1V2Fkc7geZ/1Nbffr0rdMPA76GKGU1rZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714854; c=relaxed/simple;
	bh=Im/jU7RCioSZNbpD02PdmSL3wnBPuIkU8iFeJeFE1d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2H+JVD2VMUVhEYJQoH2BLCvjnnITI75YVCeLiJjoiKhFAVpQTp5ZL0iFb+aTYv34rmcgLPfa5GjBQhKT0HMXvlIwdZyuzfEIMHEIDCOruzkrRzFDKtMtGrx8pw7nrWscotqpgfEthL0X4fD3gBc/t8RF+gU+biBWzRUvzeRfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hCdQ/F4M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hCdQ/F4M"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480142406b3so41497845e9.1
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770714851; x=1771319651; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1n+Dri69ZtsJrD5f7LTNPULLrK+Vi4bS2T/sVYZliNI=;
        b=hCdQ/F4MkvtS50cLaKMetjmG9oba5eyQ7ndxhuVdOSN2Boz3zEV737dJcl/pZo50Bp
         epCCjXprrzX/zppR4Z3BReI2n7L3LwF5LprBAJ3GoppbyisOonC+OIPW07iiZVTi4He/
         aH9lT+Ml0kKxYOTKPSKLaXa9w0zqIhrZBI9+xyetAGNZ+FsrgtNMtRDPakZbR4DYxUyD
         6HHQCDdnMMX1oPD2IfPlOXKDQFxI1Pny2QroPsYFVGidcXnC2XIevzNrBzIVTkseUw9a
         ZHqFt4+gTd6+ZAsqOQNAqaJuNtl0mBnGMz8E5ob9SLKb4/Uc4DPS+jenrni8dwnSHcBO
         aztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714851; x=1771319651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1n+Dri69ZtsJrD5f7LTNPULLrK+Vi4bS2T/sVYZliNI=;
        b=MELwX4l7uuJF+dbrm7xD5B3j+UvK3ry+b4SfQCb9CQssvrDn17Po7N0OwQzqr7cNQv
         F/cT8D35NuPNra8FdSrx150pZkb4dLLd22cCSX+d6dMHtlurAUwHES48ekbdW+fbffy5
         LH+yk+zYWMyKf3fBpfxDpjAKFgc20Z0uB/tv5drU5QpJLrL6Hp4qTr9iXfHig3yAK+kZ
         2JU0KiNPV4n29o3JvcoNaKGW1a/BRhB5LBm+XlFUWhLRnjgJkK5c49zbHAf02K6KkiRz
         0k1ZieQISkBMX7vJDt2TPgoYWWOyWaPr4TYC2vOJI5GpSjYrLw2gpHKuP15uOzNW+yH2
         05Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWAr6Hivk8uHUT+RbgdveDu/rFyQ2Ljd/boAAoFLhv0MPb/c0BOYR2lfzJ2aA3s8I3A6uzNJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFiHMk8eddyFuGgFrBgHvSlNfnPRLZqPRh9jC+EwSa45fQLK24
	4hfwMrJETqWm0dtFR8MCgprmD+3WvNBRr4oQBZWtXMg+igd0CL9yCMMgp/XJwsJYvio=
X-Gm-Gg: AZuq6aLpw6NDev91ZKzK6py+wf/9FXSFjvN+HskPSmBDAh6EtMFjvTzmd50Q0x2sWpF
	oBcX2RHYmVxws7dt//VolkUBlgkr5NO+108xqY2NnXU1qbP66gYaXlstKaJu45I9As0yU5kO0yo
	Djc77MOipAsxOHXOJ4+NaKuaWc7q4fyCPbDW3iw1AXnSLWLSExFBnx5d8fpPoxiTix3SxOQCBSA
	h+//cBZea4P+g0mPRzMdf849WJlj7IS1tmELF3LH/6vtxVe9sqFK5YB0F9t65TtMDD3ZLLU0oBr
	V75/pWjStMkT6dftr8uI+PY1J8GXmGyIVKxhmVDbeYP6K7IFzBpaymnQMzGWUjbYcw7wQUDU9u8
	tPBXOJFs2OEzLSqgADgDeS2F7beOdTyzBhWemNcCglbg53TVIKUKziZVeFHZiQrGD84t4/yCHPt
	Xcy+Nyp6RsaIRcO4i0Bv9BPzjTu2I64FFmGDs=
X-Received: by 2002:a05:600c:1daa:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483507f08c6mr21095375e9.14.1770714851014;
        Tue, 10 Feb 2026 01:14:11 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7f1e4fsm61726245e9.15.2026.02.10.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:14:10 -0800 (PST)
Date: Tue, 10 Feb 2026 10:14:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <tgvdjszwxggr53digbmddcbxvupzl4xcoprofkgrs2kgf6rknx@44ebljjpghjm>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <20260210002927.GC943673@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210002927.GC943673@ziepe.ca>

Tue, Feb 10, 2026 at 01:29:27AM +0100, jgg@ziepe.ca wrote:
>On Mon, Feb 09, 2026 at 12:08:03PM -0800, John Stultz wrote:
>> On Mon, Feb 9, 2026 at 7:38 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >
>> > From: Jiri Pirko <jiri@nvidia.com>
>> >
>> > Currently the flags, which are unused, are validated for all heaps.
>> > Since the follow-up patch introduces a flag valid for only one of the
>> > heaps, allow to specify the valid flags per-heap.
>> 
>> I'm not really in this space anymore, so take my feedback with a grain of salt.
>> 
>> While the heap allocate flags argument is unused, it was intended to
>> be used for generic allocation flags that would apply to all or at
>> least a wide majority of heaps.
>> 
>> It was definitely not added to allow for per-heap or heap specific
>> flags (as this patch tries to utilize it). That was the mess we had
>> with ION driver that we were trying to avoid.
>
>I don't know alot about DMA heaps..
>
>On a CC VM system the shared/private property is universal and applies
>to every physical address. Not every address can dynamically change
>between shared and private, but every address does have a
>shared/private state.
>
>By default userspace process generally run exclusively in private
>memory and there are very few ways for userspace to even access shared
>memory.
>
>From a heaps perspective the API would be very strange, and perhaps
>even security dangerous, if it is returning shared memory to userspace
>without userspace knowing this is happening.
>
>I'd advocate that the right design is for userspace to positively
>signal via this flag that it wants/accepts shared memory and without
>the flag shared memory should never be returned.

We can have the same behaviour with the separate heap, can't we?
Userpace positively signals it wants/accepts the shared memory by
choosing "system_cc_decrypted" heap name.

[...]
