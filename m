Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652422D5A19
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767341707; cv=none; b=auO0+5Y+QUtZAWaxpURus5GyoUYYgS6H3LhYwFfJcbnnGCPw5kn0UnrGZcaI/9XiDb6N0FciqVIwbNZsDCpfpMrhIUxZR/HSUPL5F8DxtLY4NmeF1vxsy9paxvEx/3gWjdJzIfdF0mUST092Gm/HcffMXC7yzfLIKJFWKhlb+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767341707; c=relaxed/simple;
	bh=pR9J2JcpyuSslYDA7lsLX4ZhILZRZva1Jx7LQCRL2xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bo9VcTY6+fiQVK43tNWQVbJp54c6p/3D6i8gQ16FcTQP4pcOy4J/qkuNbJGYAJl5Q7TM1j/B8YKTB2PPeXpo7Np/Z6HR2Ml8G/LEKb77pDsg1VID6Q5HkOlUzS2Nzf9kTtBBIXvggrFPIQk83FWGRqRGKBXfXtYD3eJZjpcDNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0uwNX9I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0uwNX9I"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso9989715e9.1
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767341702; x=1767946502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B5OROvqw/DgiaRfLYZJf4GjF/wj6CLJOtpsQ8Z+Uq0=;
        b=Q0uwNX9IlV/kORm8jgAs+Q1ETb6NYhTb9wSaDWfef4NJ/nWrAnH1julBwuPqwmv5ip
         yDBbRdl5cmjrAMa1hRvahM2hqQFUcQQQzSpYb0DxP6nnGw05MBvQV887ZJrO/oqU4vC5
         L7CE6nx4GWFlkcwe+TxTIeQfnW8TuCle2yAbi2Mzk9Mu46b+LYD4VgaGLW8Yd7RyNLSD
         k7DCUyHhaOck1DZR62qWUmqkx3cVGVUw4HJaWEBf8LW1WBgxvOoRPAJMzYk5PLieftuh
         Gvpxiv4Cx0obZV+JYoAYZkv1EL8PQ8A+EMaq6z+UaEaDSFLW96P0TGIv1dykmTg9CIXZ
         kcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767341702; x=1767946502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7B5OROvqw/DgiaRfLYZJf4GjF/wj6CLJOtpsQ8Z+Uq0=;
        b=nDHY+IPKjRjg98uiRuiV7BY3R5Obx99DJIvH03KPkOCv7cLTg+mXMQax4WwjU38DdT
         6B+AGrdn94NLasJTAVR+UT+G+767m18sG6VwF942O+tZIVkQ2JRQoavCURprnOogp9Wx
         64Fd9Y7DD5Y91uy03BqLS3DEhNNf/5qdfUlbWqPZ+MVbqZL0UybEoQ0fJuKE9HW6m7pl
         JzxbY1ERMXbOr3+nqHFfYS5dRzyz6ljn4jlcZjXAAMxR8fAZW3dQ/+hDzBh2Gfd5U67l
         fpP6W9Y1CYbbGkuBv8/HvVUOYZJZPUG6WhgeulbYhjHOgQLvh378iNKEJatFDl89gzc1
         0EQA==
X-Forwarded-Encrypted: i=1; AJvYcCUfOMvrG04pjxihBBV4tYHSQU3Xl/YmdnM6v2/sJ9rqRvBuvqhtt9g8NJeW0qv0DdfuB2hYhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdsA6H519HbLG5FaAGFu6ncl0fu7n/eBX6lXNEYZmxF7TDYnq0
	W18KAQ0yscQ/S+igeGTkvyPYkqc8gmsp2Une7cGmP6JFyGo3F+flRHbFEsF8JZt6ZiA=
X-Gm-Gg: AY/fxX6shNuSocdjXyoN0NuDZXDXh8TbQS408b8o7Gzui1YWSeyigCAJSebDcs8WR0k
	Yu/SVQFGhWQetYNf5Ja+MbDZrzqgUuDRWywzosUAZvlwUVO5LYn3uKrgqSJrGh3Eqiy/e+NY52Y
	cBcvY3ayg8d2qZwjyRJr6QovoWmjtYBHD2iQwcjSjlzzK3eQxbiffzqBp+S7AUdwYhnykbMrkIw
	m+q1b3wvpsntYDKR23jVo0eD06XFS675X3jChJU6LZLCQ5L+C6KHRZ9LjrcPG0eK9r+lpbtQNUP
	JWVHsxP5TDBKOH//u4jbe2IKgm4GrNAhbMRNDq67LEp/yDvb0JIu4pgb2VT8eQ4jz6aIe1+YdPb
	f3rcL8RnZKNYnG0InprYYj/SJOqOrMfTW+DlT7xJqZa2/lYsU4crkKHpxhnDPL8O8T834KO9D9C
	Tb0rfXRW/VJqvO/LVgodO/VY6bWL9wlfkFT3Xzmra/lV4hH67Ycgb5GdpIIQz0DNibEXBEIsqxQ
	wqw
X-Google-Smtp-Source: AGHT+IEG7/UqWg/6ELIcyq0mVb3xfMQn4RI8cpiRrR5W4zXnA35xM+TJgjTRoe1XllkShxIti5fDKg==
X-Received: by 2002:a05:600c:3151:b0:477:a203:66dd with SMTP id 5b1f17b1804b1-47d197f69demr322547935e9.2.1767341702410;
        Fri, 02 Jan 2026 00:15:02 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm792930555e9.13.2026.01.02.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 00:15:01 -0800 (PST)
Date: Fri, 2 Jan 2026 09:14:59 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20260102091459.6bec60c2@mordecai>
In-Reply-To: <20251231154722-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
	<ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
	<20251231150159.1779b585@mordecai>
	<20251231154722-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 15:48:26 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Dec 31, 2025 at 03:01:59PM +0100, Petr Tesarik wrote:
> > On Tue, 30 Dec 2025 05:15:46 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > When a structure contains a buffer that DMA writes to alongside fields
> > > that the CPU writes to, cache line sharing between the DMA buffer and
> > > CPU-written fields can cause data corruption on non-cache-coherent
> > > platforms.
> > > 
> > > Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> > > annotations to ensure proper alignment to prevent this:
> > > 
> > > struct my_device {
> > > 	spinlock_t lock1;
> > > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > > 	char dma_buffer2[16];
> > > 	__dma_from_device_aligned_end spinlock_t lock2;
> > > };
> > > 
> > > When the DMA buffer is the last field in the structure, just
> > > __dma_from_device_aligned_begin is enough - the compiler's struct
> > > padding protects the tail:
> > > 
> > > struct my_device {
> > > 	spinlock_t lock;
> > > 	struct mutex mlock;
> > > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > > 	char dma_buffer2[16];
> > > };  
> > 
> > This works, but it's a bit hard to read. Can we reuse the
> > __cacheline_group_{begin, end}() macros from <linux/cache.h>?
> > Something like this:
> > 
> > #define __dma_from_device_group_begin(GROUP)			\
> > 	__cacheline_group_begin(GROUP)				\
> > 	____dma_from_device_aligned
> > #define __dma_from_device_group_end(GROUP)			\
> > 	__cacheline_group_end(GROUP)				\
> > 	____dma_from_device_aligned
> > 
> > And used like this (the "rxbuf" group id was chosen arbitrarily):
> > 
> > struct my_device {
> > 	spinlock_t lock1;
> > 	__dma_from_device_group_begin(rxbuf);
> > 	char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > 	__dma_from_device_group_end(rxbuf);
> > 	spinlock_t lock2;
> > };
> > 
> > Petr T  
> 
> Made this change, and pushed out to my tree.
> 
> I'll post the new version in a couple of days, if no other issues
> surface.

FTR except my (non-critical) suggestions for PATCH 5/13, the updated
series looks good to me.

Thank you!

Petr T
