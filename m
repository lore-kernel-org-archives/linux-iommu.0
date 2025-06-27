Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FB21770A
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023977; cv=none; b=LBvZkSE6lhvnHXl9hkv7YKEpWkSGHII4kzvpEtFr5QhV7OLqv6oWOBY8ZSoQKjHeaDJUV8N7UxOVZbOpDvzKw9YiizhjAJW4fpWcIYYiiOsmUIREc8fAYB+1QKjbC2rZInYjqmVDf3VnTu2LxBl6URkBNutBSeI7SA+o4l1YZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023977; c=relaxed/simple;
	bh=k7FSokoRUWjGKmunOIygkPJAEDu5OPFHiE+Rh1EgJ00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljlbKU/+7+veXgvin10GXWxNqVv4E1aM1+vXtZM1fSkNQBHHeeSe0SZ1a/CP8UEXTi1WwwrardxaYZmFJ7XQgXA/hyh1V6iYnKulM7ye/5seL3Xn/eQsQmlG78E/Fbjbo+R8qNOj0+diKCrV9JtXS3plIzl2JtJ6NSWQRw2NYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JVoa5bfO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JVoa5bfO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453079c1e2eso2401855e9.3
        for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751023973; x=1751628773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VA1K+sSxb+ZA7vsDXvA15WJBHT58z1iBmKqHJX5Tp4=;
        b=JVoa5bfOPN3j7i7kHh6E77RpTePKsRRLMw0AYBSc35YYOc8jsYzOteYBl2CVofatyB
         +fEzT69QVA1pRnqITwzUhB/D4+rCqEWaIuuQnGXIkzh2YcbShwW2pMPG6q6Cq2o1+qhX
         j1VCpRmsVFGJnsNGHvhM7pZx8pqM/d0fYP4RmCBzug8d+0f43R7YoMB+ITRCBvRhvCaf
         oky9Xnih4P4i6BQbNh8mt7Av8KL2LV4j/xF7deNvQTT/8VjGeqhIzuQNn0Lp97NBKe5b
         nsp9lXlIm3D8UIN7QBW18gAbaiPYnQVJaOf9AY5ZPbfTerx8vj7fIXvqRXvdoytbMc9+
         4CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023973; x=1751628773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VA1K+sSxb+ZA7vsDXvA15WJBHT58z1iBmKqHJX5Tp4=;
        b=SJ5UlOaqcO2pgjbT8Mo5poI7sIp7DXlbs6bYpL1tsFex7mzZSLMjFhPjBXnbWqsi9l
         d1lv8fvL6lI/nfifs1b3ez5q4e3B/DxCcoqP51bb5diw0tCmZ9igHm7mJGy3QWshIyzg
         DAObtPzZls4vf5d6WgxnCjNX8uAae4Knzh5JsQmSg0rS5VEhB2l49yVKDJPO5GidXexo
         crZRWuslfA0uUEWwc9XjjNchIYwD8Vf8ukb2eALfhuF2NvHuheOh0BZBXGqYn6PK3zNM
         wIm0Bk5E7qUl7QjPPnRbQaIzwEm9UsCPzKwYdZuU2oyReqj/8iIPwxKAdPrBtIrQx20a
         1Idw==
X-Forwarded-Encrypted: i=1; AJvYcCUre1a+q5rsFkE/5+6OS5Hqgp+czbV3a1ziO5daBnKvkrUOXB65p1ucQ4y4fS4HHPGOyyyUmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY1KZ9pnCgOdlVW5EVFDywAzYjHxKvenVTV95PzQcdtbD8nmZn
	AhrpV0qIP6/NSZ1PCRKkfpoFYp06BuWqFyvVhqOo6QrlxQ8K5C6+a4fJLZcuYYd2PUo=
X-Gm-Gg: ASbGnctSXIicK12KLPwi0EjR8uVcr0J75Bb9cBvCc3Vm7+Jys6X5yavdfWbS4xXCZMl
	U7GeOdkkusPv9lZBGHPHYu/GX75oCglyMvGSmOpp//CM+Cl4/divYs6fFrIcTo6XNjabHL5vdBD
	Ko8ri1iWFOly7ocn3YCfcO71ns5gBEm+bH796+DE7pwzbhj2oDZgMLTp4huUpQceefIR+w6nsaP
	GRYapXvEbv/GKUf0fVQml30/p0/PpY40T8WO9731rtlbVHEerGV2FvB/YIy4cqupXE6RC+S6UvK
	pRaBaxrIpf/DZ6GrKXNORhbh48HUdOnjXNn15hfB3x+K3pXqj/+jts9dDo5bmHM4VRR/0hzh9Ux
	HvzZ0HrAc6uD6c3mpRnXdcP0Xk1I7PAtd30nrnUhbpUQEdML99su4N3OpKhN7FAGxMKQ=
X-Google-Smtp-Source: AGHT+IEWZCSuqttypCq2CzG6w+lGWATA0+jX9Li2yrDFrWwmJA+OoSeGnOZU312Xh/zwCq+WJVnCjQ==
X-Received: by 2002:a05:600d:10:b0:451:dee4:cd07 with SMTP id 5b1f17b1804b1-4538edf5becmr9797775e9.0.1751023973312;
        Fri, 27 Jun 2025 04:32:53 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a43325asm47023565e9.16.2025.06.27.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:32:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:32:46 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
 <john.g.garry@oracle.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <20250627133246.1d0a6d46@mordecai.tesarici.cz>
In-Reply-To: <f3164113-a834-4b22-adb4-9da1e7ca2c73@arm.com>
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-8-ptesarik@suse.com>
	<aFynHWAYtKPFT55P@archie.me>
	<20250626070602.3d42b607@mordecai.tesarici.cz>
	<bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
	<20250626154818.46b0cfb1@mordecai.tesarici.cz>
	<0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
	<20250626214038.2d005bb5@mordecai.tesarici.cz>
	<f3164113-a834-4b22-adb4-9da1e7ca2c73@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 12:07:56 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2025-06-26 8:40 pm, Petr Tesarik wrote:
> > On Thu, 26 Jun 2025 17:45:18 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> On 26/06/2025 2:48 pm, Petr Tesarik wrote:  
> >>> On Thu, 26 Jun 2025 10:58:00 +0100
> >>> Robin Murphy <robin.murphy@arm.com> wrote:
>[...]
> >>>> It's not really that simple. SWIOTLB, ZONE_DMA, etc. require platform
> >>>> support, which end users can't just turn on if it's not there to begin with.  
> >>>
> >>> I know this very well. As you may not be aware, my ultimate goal is to
> >>> get rid of ZONE_DMA and instead enhance the buddy allocator to allow
> >>> allocations within an arbitrary physical address range, which will not
> >>> rely on platform support. But that's another story; for now, let's just
> >>> agree on how the DMA API is supposed to work.  
> >>
> >> Indeed that might actually end up pushing things in the opposite
> >> direction, at least in some cases. Right now, a driver with, say, a
> >> 40-bit DMA mask is usually better off not special-casing DMA buffers,
> >> and just making plain GFP_KERNEL allocations for everything (on the
> >> assumption that 64-bit systems with masses of memory *should* have
> >> SWIOTLB to cover things in the worst case), vs. artificially
> >> constraining its DMA buffers to GFP_DMA32 and having to deal with
> >> allocation failure more often. However with a more precise and flexible
> >> allocator, there's then a much stronger incentive for such drivers to
> >> explicitly mark *every* allocation that may be used for DMA, in order to
> >> get the optimal behaviour.  
> > 
> > I have a different opinion. Most buffers that are passed to the
> > streaming DMA API are I/O data (data read from/written to disk, or
> > received from/sent to network). For the write/send case, these pages
> > were previously allocated by user space, and at that point the kernel
> > had no clue that they would be later used for device I/O.
> > 
> > For example, consider this user-space sequence:
> > 
> > 	buffer = malloc(BUFFER_SIZE);
> > 	fill_in_data(buffer);
> > 	res = write(fd, buffer, BUFFER_SIZE);
> > 
> > The write(2) syscall will try to do zero copy, and that's how the
> > buffer address is passed down to a device driver. If the buffer is not
> > directly accessible by the device, its content must be copied to a
> > different physical location. That should be done by SWIOTLB, not the
> > device driver. Last chance to chose a better placement for the buffer
> > was at malloc(3) time, but at that time the device driver was not
> > involved at all. Er, yes, we may want to provide an ioctl to allocate
> > a suitable buffer for a target device. I think DRM even had such an
> > ioctl once and then removed it, because it was not used in any released
> > userspace code...
> > 
> > In short, the device driver has no control of how these buffers were
> > allocated, and it's not fair to expect anything from the driver.  
> 
> Indeed, for true zero-copy to existing userspace memory then there's not 
> much anyone can change, hence "at least in some cases". However, there 
> are an awful lot of drivers/subsystems which use streaming DMA on their 
> own relatively short-lived kmalloc() allocations - the first example 
> which always comes to mind is all the interfaces like SPI, I2C, UART, 
> etc. which are either dmaengine clients or have their own DMA (and 
> indeed some of which were historically trying to do it from temporary 
> buffers on the stack). Heck, even alloc_skb() might end up being 
> commonly used if this "ethernet" thing ever catches on...

I have been looking around a bit already, and I didn't see an _awful_
lot of these short-lived allocations, but yes, I've found some, and
yes, most of them are in the subsystems you mentioned...

Anyway, thank you for your patience with reading my DMA API docs
update!

Petr T
