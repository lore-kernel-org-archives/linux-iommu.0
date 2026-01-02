Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072493101DE
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358028; cv=none; b=K2QtEpsyj3jVaAEqnqSL4WLl9WhhP4N+ga9XTmqbmfPd3188dylNmySRDQZBIDK4+Obwt/Rv0BJECz1wgvtciIM08zXbN0m9x8dWu91Lh2Q+UZuVwFoF/YjqGhICobSKKGTnGbsfpGD3JK5d1lp+ct9LRe0cyfLCwvtNwdiPq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358028; c=relaxed/simple;
	bh=K/uUN45KovytrEcK5XXKQe+3KCJ6rchbtyjd81iRPMQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOdcpOJjvg6qnCsH1Qq26vZIS22kH+aTkaNKtFmBrgiQLH358cMbhaJkbeXLu10C3pDnTgYtuhfjgCH/fK1XHVMTZa0JejTC2C9K6t5JyhjIpiZVsrcWZAroPU9ZA8GBi237K5H3OUtVC4CCjkYyISXOIFjtadqQpuJfjoFiZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VenMMNLF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VenMMNLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92265C2BCB8
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767358027;
	bh=K/uUN45KovytrEcK5XXKQe+3KCJ6rchbtyjd81iRPMQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=VenMMNLFNwcBtcK7ftwDzE3IV7P6ybH2RCM4VrK95yfBYK5I1pRumFqpo4DSbuFU2
	 jLkkv4g4ptuwyyt9Ovge44DRun7tUCtcoOBgjFjCNfPrNa6rwtkUyqQI4/eKEakFL1
	 +akg14Jb3zUvWUFTMrNTWxO53qtCKwYSLtOjQEAxBlmxwJxyjnOs3vTy+WuWZPv3QH
	 bq3OJOthvMqS5PcKe/zzVQ7yNz2SWmD/MJnEQtI7N1ONZqc5WR4MTfQUTNrqEI8v2x
	 ZjPnAaXTaHPn1c+PITVq7uHJuHR5/ID+Q2a0jeW/YBi57LAcwQensObSaUigTGn5Ig
	 g2e5JJNeg54fQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so109569991fa.3
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 04:47:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXF7gp1l90BVkqeIvpRJGUg0HiArkJ1FTkwpRq8oBdkm0POaJcq6bvKRbHUhSgwV2UbvQH1sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjyjeYZZBSC+nSUGKLCrIE62Kr30K7F7j1FOAVuJoj15hQFcpx
	F+c3Myi0tt7c/CHf+3bO3jkesDnUr4OqQAuhHDtJvN1D5jHG9dRH4IBgoMtY4tEXyD06ybVm4yW
	dbwt+LqmHhDEFh7pQJfgBAVYDnOLhCLxufaRurP8eIg==
X-Google-Smtp-Source: AGHT+IHfsI2nHK62CXKe6k+4gm9v0iiCb8pQczcHrLSOhbK8w1zxtfm3eIxi6cJFI/rL863lq6n90W/8u9JL3Z9z7Zw=
X-Received: by 2002:a05:651c:1506:b0:378:e055:3150 with SMTP id
 38308e7fff4ca-38121566b66mr131608251fa.5.1767358026081; Fri, 02 Jan 2026
 04:47:06 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 12:47:04 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 12:47:04 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1767089672.git.mst@redhat.com> <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
Date: Fri, 2 Jan 2026 12:47:04 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
X-Gm-Features: AQt7F2r5IUZ5jxGehTcQa0bMR0oseoJRNQV7b8TSnlTTmncoMCo9ttA0Tvqdi5k
Message-ID: <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct padding
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 17:40:33 +0100, "Michael S. Tsirkin" <mst@redhat.com> said:
> Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> last. This eliminates the need for __dma_from_device_aligned_end padding
> after the DMA buffer, since struct tail padding naturally protects it,
> making the struct a bit smaller.
>
> Size reduction estimation when ARCH_DMA_MINALIGN=128:
> - request is 8 bytes
> - response is 2 bytes
> - removing _end saves up to 128-6=122 bytes padding to align rxlen field
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 32b578b46df8..8b30a94e4625 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -26,12 +26,11 @@ struct virtio_gpio_line {
>  	struct mutex lock; /* Protects line operation */
>  	struct completion completion;
>
> +	unsigned int rxlen;
> +
>  	__dma_from_device_aligned_begin
>  	struct virtio_gpio_request req;
>  	struct virtio_gpio_response res;
> -
> -	__dma_from_device_aligned_end
> -	unsigned int rxlen;
>  };
>
>  struct vgpio_irq_line {
> --
> MST
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
