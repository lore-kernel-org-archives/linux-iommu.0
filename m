Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C131ED86
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767186755; cv=none; b=LgE6IWNm6wvTOHlIMMtRIbE1XoypLU+C9cuCOqtW5ia3Hg8ef/feVwCR8LACAHKwAF8s7gFPT1OvW5D98IXRCaDAxUgnirCPg3Fs9JnSJi2kkXTPrkfFCDHcs1ZM3sAFElgxSYVMiqJoFLBHz4v2J6ZUkzhN8AcWA+g4JZ2d9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767186755; c=relaxed/simple;
	bh=+Rj9uS/xKO+b+rZgqDTkOPQ7AM9H+O0zY3sW6JnGIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpJ0f5FeTWJXATvNIDLQC/7XAQQItgJmzrvNunUFR8QDZY/1ca+WQmg1pQvNVDe9WA5ZeE42Ub/J3lC7we7+h4p2NHO32EjuJo6dNaFIAvMEk05so67zw1oB7man2omC6xU9qvhT4IqwmNepdUadZ/Qmo3BtIimTiNbvygJLuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FKUB60X/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FKUB60X/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cd413b4so7098945e9.2
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 05:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767186751; x=1767791551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fke3G5rSH2WPZ2DuQdyfqEfEpoI6l76uJNtI0EpEhAo=;
        b=FKUB60X/lQ5q7IscW8L1AEnZefkgf8Gsb63cXXL31AQxTtQW07QhM1RGYGjvkjgSed
         rSyaWdAK7hvRz6UP1qS6bTF3ZNRfP3sCMg3r7Ayzn3seJXeOVizX6B/OscJDCRvIT14x
         R+Tto78m8s62dFybv/8ohhqWmqgDarj8P98Ex9HfGwAJoHprMeRHwBJfsfVOzHUcYUx7
         +wyEXkoG6xf0wfL/NGXXOa2CI0QZH4Zbt4SDOd5Ds/0XQG/zRtH/mgjqLWIt/j3WPl+r
         dY/SZF8Us4M102oJggU3qVzLVNG1qpm11RDb7BlPJpUU9gkAvu+8YJAUKSfaOtz3/Yne
         LiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767186751; x=1767791551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fke3G5rSH2WPZ2DuQdyfqEfEpoI6l76uJNtI0EpEhAo=;
        b=dRrLpRRQvN0sElu41FbVqyD0Eu9CLTWpAMiQoW7Y8erLvIzmmEGdI7hseU2pUL5FVR
         fU7S1sAvE1ZNvDb2wu4OCzDaFCnzEH0KZXR9BiNSXDzvOxSXwDtVdkbEfytDrzizxhBE
         ZZ/pxPdnnUOOAKbHskysP7dIVQ+pXxwBmb+D9NUFtFoB/VSM6U21OjsDwMaL5KvNg/1K
         +WiK69R1K05NVLkyTjbdg4f3PT3UebOS/Fjqq32zzDi/hyJtvfMPHJYZdONKYNsM9ygH
         7BKDuGMcnuon47pRH8qeBU9yDxnHUaLgY1mYKZ5qCvFN34GjvoFQGuIaCl3WynTHXRjQ
         kXEA==
X-Forwarded-Encrypted: i=1; AJvYcCXwU2HREw82wcaE15xJ7vLu8zw912EDFQcClFXQsl22zDSWWOKR3+o0CUe14A5zJqsIuEB4Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY1DKJe7oCJRdlPGAIQ6meAfR98/9/UfwLMCNGLXmtaVLJu77X
	asqflmQ7gp5EIq++jleknCpx5Upe4+YugG7zWJQskgPvSJRSa53Zj0tlvlhtidChfb0=
X-Gm-Gg: AY/fxX7Jp+8up6wzBVqpoZnpnV3xRhlreNPtOhAwT/pF/cblSIw5j6/XqQ/k/bv9eWl
	I4E9S3WesRVyun0Pnko8PGMaWYcHr31JO8w7EkySCt+j8meo5L/0380BRBoHt43Jj3LvQg2sMlO
	sCLvzYsrHGQCQQobgh+0I/Fe7YtcFxnppOrIIQZO+8yZfGZUlr3rm8jrzTEL6Y2hVmS96YDfqJA
	nIIJ5DUmsQlvOFz8fAW4aXSigMNq7GAVPYjpzqZBhxvy2NfYXldozFjVMW4zQYIVQIX0KG7m7zX
	WuZWz5lXGeXlSdcRGA5JOP3kISEd7caAP3MGX2iPAGBV4pr1e7EXDFXnOVzUB/Wie0RukQ8za49
	eaWCOAITOKBc1toOs6fgWWVFh/l426VFiwEkidi8BlCTgNw3b4amUpl4klzbI+5SJh6eOgyOQoZ
	J7IXAe37dTxr4ksJNQMasw2TpALqXCFXeBqxUNRFre55MNENjabqkZisfjr3wtwOxPsYtbhvUXS
	otr
X-Google-Smtp-Source: AGHT+IF4mp6GOV5G6x95wPZOhGbqasawR+ZO3M57T/TzQMfUeMdF8kArZ+ePMOUwA5I3JuKmTuDssg==
X-Received: by 2002:a05:600c:3e0b:b0:477:9c73:268a with SMTP id 5b1f17b1804b1-47d195b3d55mr287631655e9.6.1767186751342;
        Wed, 31 Dec 2025 05:12:31 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a20af0sm269524875e9.4.2025.12.31.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 05:12:30 -0800 (PST)
Date: Wed, 31 Dec 2025 14:12:24 +0100
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
Subject: Re: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <20251231141224.56d4ce56@mordecai>
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:15:42 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Cong Wang reported dma debug warnings with virtio-vsock
> and proposed a patch, see:
> 
> https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/
> 
> however, the issue is more widespread.
> This is an attempt to fix it systematically.
> Note: i2c and gio might also be affected, I am still looking
> into it. Help from maintainers welcome.
> 
> Early RFC, compile tested only. Sending for early feedback/flames.
> Cursor/claude used liberally mostly for refactoring, and english.
> 
> DMA maintainers, could you please confirm the DMA core changes
> are ok with you?

Before anyone else runs into the same issue as I did: This patch series
does not apply cleanly unless you first apply commit b148e85c918a
("virtio_ring: switch to use vring_virtqueue for virtqueue_add
variants") from the mst/vhost/vhost branch.

But if you go to the trouble of adding the mst/vhost remote, then the
above-mentioned branch also contains this patch series, and it's
probably the best place to find the patched code...

Now, let me set out for review.

Petr T

> Thanks!
> 
> 
> Michael S. Tsirkin (13):
>   dma-mapping: add __dma_from_device_align_begin/end
>   docs: dma-api: document __dma_align_begin/end
>   dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
>   docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
>   dma-debug: track cache clean flag in entries
>   virtio: add virtqueue_add_inbuf_cache_clean API
>   vsock/virtio: fix DMA alignment for event_list
>   vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
>   virtio_input: fix DMA alignment for evts
>   virtio_scsi: fix DMA cacheline issues for events
>   virtio-rng: fix DMA alignment for data buffer
>   virtio_input: use virtqueue_add_inbuf_cache_clean for events
>   vsock/virtio: reorder fields to reduce struct padding
> 
>  Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
>  Documentation/core-api/dma-attributes.rst |  9 +++
>  drivers/char/hw_random/virtio-rng.c       |  2 +
>  drivers/scsi/virtio_scsi.c                | 18 ++++--
>  drivers/virtio/virtio_input.c             |  5 +-
>  drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
>  include/linux/dma-mapping.h               | 17 ++++++
>  include/linux/virtio.h                    |  5 ++
>  kernel/dma/debug.c                        | 26 ++++++--
>  net/vmw_vsock/virtio_transport.c          |  8 ++-
>  10 files changed, 172 insertions(+), 32 deletions(-)
> 

