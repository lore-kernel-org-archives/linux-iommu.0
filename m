Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315A3370E4
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606489; cv=none; b=rel6fiHFP/VeX/vcg0OGksLJq/0U/IBcgyQuq2h7NHKB9CSXv9D8RutmO/gOl5xOkrkDVfa9Et08aD3C+MjR2eBn8kWJmFNfUp4SrS2ID5qXMTybfGs6auvHPILys+l+/DzYEz3X+AQb2ydXl7GPbzVfDZY/jn7By54qN9+XeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606489; c=relaxed/simple;
	bh=GqAwY0OHbZKQzzJb3VatReAfBA97RCbOF3bWO0/Z1Js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBvV56VZtQjrasHm4tBa/Gmw79JMdfUjRUZt+n/Z35g3z+HxfDqMVDwnf8pQCFqWTiM5ok9Pv5nriFNZQjYBjTBJSGNtRb+7lhTwer3htOaY2QWT2d9TUqGa/VBEPqr7TXk0kgfyMiOVU7dR7dsJAEoplZaummCKvczloQNGD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIyyXwcj; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIyyXwcj"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4308d87782dso983694f8f.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606485; x=1768211285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YNJPmUNbnGNTCEfFfuOCZFqj9o9elJ+A8mEb2IK5hU=;
        b=PIyyXwcjn8WhNqSYF4TN8LHGqVx/YTH808wLXMMBTMBF0rh4aUxIuy+4vsPpCjT2VP
         x2UW/s1uI+NO8A04X9ddcwjJpn0Ei0yzQSs8hrsbCRcTYmR59X5YWgzSbr87gjYOD2sL
         aWGq6gW2xy5qQI77xBf+s8CEx0UtpZx1qWxgS7MYvfV6e6HNW+Y3yYPRTSq6spFgQVZw
         c8hXufW8Y9wZeYvTlpqmCsL5A5SR06R5Tgq0Xtqh7oRlu/Rn9Qq6phE/O6x8sO2ungaR
         lcRQgvfANzYReQSMavbd0eyzRMPKbykpB+quQ5yHnMnQaCNNCefS16ViwHY8u+IVVxrh
         K/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606485; x=1768211285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YNJPmUNbnGNTCEfFfuOCZFqj9o9elJ+A8mEb2IK5hU=;
        b=TqDR4t1XVw3emBx1E1orKHkJlEB38br2ELic0/MFeIHs6M8QowarLJXNLkGXKccR42
         XkyXXXqK64ya2iyF7FDYA7g4DvJ31BViMOIMz8zUiQblkC9kGFu8HmFqP7Jf3J6uS6AG
         oLUlqXVoCFKnCL4m7MIknCH8iv3unTbbxA5XnK88gE9ddBJD9lDfxs58V7n7H4/DATCK
         5YRdArvkNtXSoFkXMSW+6efHbCKcsOQezsNVXwFCQNo/3/IAvf8vW0jvofyYcYVzG8Vg
         GaP4Ofr0h8h1ekbJL9185rZk2TspaYO1Y0N0pxR3BkTAy1HTtva/N7Lgs4/sq+ZCEBoK
         Axqw==
X-Forwarded-Encrypted: i=1; AJvYcCXTC0DfwWekPZ68dEBptv88L79qt9T/3r1y1eVW6GBPrU3hnnqMm6Yoj58HOe8oaw1iWmpAZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUNsheDRo1Vqyqvt9G0Ccwn3N7815tg48zyrjUORWJiuAIh2vU
	qLjaH0P0VWvaUYPG+3T67aEl1bNRwFEs7SgYga7cBKw0SzRJlAsjB1ZHv/iaG22SWJk=
X-Gm-Gg: AY/fxX6B9M5s5IELXiLY8JqlY/RgRTgnbpzv9PeMy0iLrqtSjU+LY0uY8mRGIiCXuTF
	cbope/keWzFmaMgnSuui5In+eeNbMsW4D8690mPi+TBIZebjl5G6HphV+y+XvSsCzyrl1/i2BuM
	1v5/1pg6OOE9CEBZxCWtD7uA6ZXDXjfT8VzebaQJLeQRbqb0PPKCu8FiYTOzbnuFYbuoHbw6Ztn
	yRJWXiMlutB3O3jt5bozl+03IFbB+8cwLcCgEAvWJpdmHyLRWPUBSfY5LFJXglGw6lXY+j34J5H
	cDhAJO0qipP5bhUwieljE0tD+Ym4tacsvdZz5rRGr4AjYrO3Re22Cdk4/mWFCrrCqg4kRcgKSNv
	n1B4pIRKnlwcNwxJXJfft4I4fPnCFdYdSTRSg1IGVv6wTX/3meAbd2Wm14wLLOFEMHrMHC37oC2
	g8kTWRanG15aWUUy1lQWFR+ThVXJo1f10bHUdYtYZeMSGZdVVeY/FnvtGe0/hCp458HSuKFe7zp
	Roj
X-Google-Smtp-Source: AGHT+IHPziOrpKV7Kr9yyjS7tcuC3KfVS3vu6/0u8YX5ecS7isO2cmN7o1CvFXRGO2JgzmojB4/s8Q==
X-Received: by 2002:a5d:548c:0:b0:432:5b81:493 with SMTP id ffacd0b85a97d-4325b810aa7mr24854531f8f.5.1767606485367;
        Mon, 05 Jan 2026 01:48:05 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm99699009f8f.1.2026.01.05.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:48:04 -0800 (PST)
Date: Mon, 5 Jan 2026 10:48:02 +0100
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
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 02/15] docs: dma-api: document
 __dma_from_device_group_begin()/end()
Message-ID: <20260105104802.42bd8fe5@mordecai>
In-Reply-To: <01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:22:57 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document the __dma_from_device_group_begin()/end() annotations.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I really like your wording ("CPU does not write"), which rightly refers
to what happens on the bus rather then what may or may not make a
specific CPU architecture initiate a bus write.

I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  Documentation/core-api/dma-api-howto.rst | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
> index 96fce2a9aa90..e97743ab0f26 100644
> --- a/Documentation/core-api/dma-api-howto.rst
> +++ b/Documentation/core-api/dma-api-howto.rst
> @@ -146,6 +146,58 @@ What about block I/O and networking buffers?  The block I/O and
>  networking subsystems make sure that the buffers they use are valid
>  for you to DMA from/to.
>  
> +__dma_from_device_group_begin/end annotations
> +=============================================
> +
> +As explained previously, when a structure contains a DMA_FROM_DEVICE /
> +DMA_BIDIRECTIONAL buffer (device writes to memory) alongside fields that the
> +CPU writes to, cache line sharing between the DMA buffer and CPU-written fields
> +can cause data corruption on CPUs with DMA-incoherent caches.
> +
> +The ``__dma_from_device_group_begin(GROUP)/__dma_from_device_group_end(GROUP)``
> +macros ensure proper alignment to prevent this::
> +
> +	struct my_device {
> +		spinlock_t lock1;
> +		__dma_from_device_group_begin();
> +		char dma_buffer1[16];
> +		char dma_buffer2[16];
> +		__dma_from_device_group_end();
> +		spinlock_t lock2;
> +	};
> +
> +To isolate a DMA buffer from adjacent fields, use
> +``__dma_from_device_group_begin(GROUP)`` before the first DMA buffer
> +field and ``__dma_from_device_group_end(GROUP)`` after the last DMA
> +buffer field (with the same GROUP name). This protects both the head
> +and tail of the buffer from cache line sharing.
> +
> +The GROUP parameter is an optional identifier that names the DMA buffer group
> +(in case you have several in the same structure)::
> +
> +	struct my_device {
> +		spinlock_t lock1;
> +		__dma_from_device_group_begin(buffer1);
> +		char dma_buffer1[16];
> +		__dma_from_device_group_end(buffer1);
> +		spinlock_t lock2;
> +		__dma_from_device_group_begin(buffer2);
> +		char dma_buffer2[16];
> +		__dma_from_device_group_end(buffer2);
> +	};
> +
> +On cache-coherent platforms these macros expand to zero-length array markers.
> +On non-coherent platforms, they also ensure the minimal DMA alignment, which
> +can be as large as 128 bytes.
> +
> +.. note::
> +
> +        It is allowed (though somewhat fragile) to include extra fields, not
> +        intended for DMA from the device, within the group (in order to pack the
> +        structure tightly) - but only as long as the CPU does not write these
> +        fields while any fields in the group are mapped for DMA_FROM_DEVICE or
> +        DMA_BIDIRECTIONAL.
> +
>  DMA addressing capabilities
>  ===========================
>  

