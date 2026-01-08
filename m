Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E83AEF29
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881284; cv=none; b=BJ1bzYxo+Uw5eKsGDvouHvQPSBCS4R9fimMtgj0yOM/BMHJLTI9kZqlzrDKUc/cbnZiIFwwToKfSQeUGSlDnRA7C1SK26Ca5cua/Q4rAqt2WaXMCiuB4Hqo3792XwHR+kL6FhaMLvN9V1UtTJLMUG0AJKIPuqDnQb/lkCnyfll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881284; c=relaxed/simple;
	bh=KaqiKIrSwJ+ZnBNZThkRID6OHOTJLOwB/Uij0QQJV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mY32xuH2tRLyvDL0fw27326/oo57mnUkVbBqFgY9kaOv1TxUuhmn5JtD0djZOq2xxudoIAXcXI9FUkn+l1N/KE5qAAjF/uTzIo33wOS168ANr3HZ+rJ+9z4PIsUsAqSQEUts8mAMXSlK2f8QVJEwWbrPks1APBxVeT+1NuGy3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdDjtSIg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdDjtSIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
	b=DdDjtSIgbs4iUsjcR6fzV6Z+CPsYUGmi2g6oWFgJLKeehvCRVyvWeMj471SmLbqnKBVWjG
	9NmvKiFIltnGW+pADsNcGDfQv0GjzZrLYn/8fW0eH7P/3mKLC2cdV/6bYf8o1+b2KHCp/U
	OpAdm99NX2B0yoIGZDu+FtoIIXKG77A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-S0b-08F_P-mF_Mgx6ycfKg-1; Thu, 08 Jan 2026 09:07:59 -0500
X-MC-Unique: S0b-08F_P-mF_Mgx6ycfKg-1
X-Mimecast-MFC-AGG-ID: S0b-08F_P-mF_Mgx6ycfKg_1767881278
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47788165c97so19538345e9.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881278; x=1768486078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
        b=IN7gZVoQiq2MXEAO5KqmPz1lgUVF72g05MbYKFibaEKpmffKV1ZTz3VOKYx0VjlFcN
         kAuEOSlA7rlDQGnPHusI8rG9VhMe1hLuzJcRg5uaaopzqtHg/BmALKQVJZPzMM2KPmas
         V2/aQGPBIG4xE/2gq0w/DPmVjSg3yX7c1ccJ4nNLUozn3jzTakZk1z4B4fBLaRNszxu4
         vfJEyiuhfFUsMaR08y89tC4NcEyIAsDXigksfBLdkVhPuBpAyBKIuD3ecZHGz55GrPtl
         yVUW7U2cyXbE0lMgfi9CNBDUhmf93iy1VcoEyQLvwgefHifYr2ZTXx3rPURRj2t5BB2M
         mAkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8h6aAFLVRyPKaeykhk6wgaYXK4lD/JxaZqXoG6l4lplkKBRKlQvuHImCMEY30Djskij9SbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAt7tYqPpWGvb7bLNFnxKWLFlev6S+mpXPrmNQo3di8IrdUNqp
	q/bvXvyy4zLUN8aytFHaOMWEjHBfzZdhV/nIFppj1CEQ/P47qPW/XIKDIx1cFulnSGfgchJjpW4
	LPXRFTJCysB2W7drnjux7FtiXO4FcFSbCxvnrPnCOLDBh9wWrI3cQfcYl
X-Gm-Gg: AY/fxX4BF41yV+rQQzaFtZKG2YNE84/BhgYY2vB2gdOpcpu6r7YgGh4yQ25fIaJE7QX
	vN+we/O+vcAb9VrLQzUA3V37tmiPcy+phlnIKKKILKrIWRnMi7yhvAocyAiQ3jHlwm+VAF6NZzr
	F431k+VXv2/O+y5jSnsxSe0N8dyznM97H6zUfPgnwcxnFl1TOfcn7x9V2MlbVVa/dkPgUD125vA
	fo5/P6ALOuvLFkfJScl6Gj+T6Hzah4RKL7gYXBC7wQhr5j1uWyu8Tl7dcofGtXDLcbY6wBPExz+
	X/h1AmKNdvv5YPSE+fcOrebqkOIyMwjsGoSGyJiyngn47Pz0qw6GwjJd35uyDj7d0e3Twh5765v
	1mF8P6fkeWADJ8zCyc7dm4VLE2FlLb0MSfw==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72552865e9.12.1767881277879;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRCfp6entO3V/BR31Far6TJcGMp3EAPQ3dAY6QbDFNrKF2+2e3Jhs1Nmifuq8757Npv4Rh0Q==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72552445e9.12.1767881277386;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm160806445e9.2.2026.01.08.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:07:56 -0800 (PST)
Date: Thu, 8 Jan 2026 09:07:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <20260108090639-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
 <aV-4mPQYn3MUW10A@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-4mPQYn3MUW10A@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -61nAnVJaBKuUAMtdFf1WKIoHClJOBt0P0P4cuQ_-gg_1767881278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:04:07PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
> > On non-cache-coherent platforms, when a structure contains a buffer
> > used for DMA alongside fields that the CPU writes to, cacheline sharing
> > can cause data corruption.
> > 
> > The event_list array is used for DMA_FROM_DEVICE operations via
> > virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
> > written by the CPU while the buffer is available, so mapped for the
> > device. If these share cachelines with event_list, CPU writes can
> > corrupt DMA data.
> > 
> > Add __dma_from_device_group_begin()/end() annotations to ensure event_list
> > is isolated in its own cachelines.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 8c867023a2e5..bb94baadfd8b 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -17,6 +17,7 @@
> > #include <linux/virtio_ids.h>
> > #include <linux/virtio_config.h>
> > #include <linux/virtio_vsock.h>
> > +#include <linux/dma-mapping.h>
> > #include <net/sock.h>
> > #include <linux/mutex.h>
> > #include <net/af_vsock.h>
> > @@ -59,8 +60,9 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > +	__dma_from_device_group_begin();
> > 	struct virtio_vsock_event event_list[8];
> > -
> > +	__dma_from_device_group_end();
> 
> Can we keep the blank line before `guest_cid` so that the comment before
> this section makes sense? (regarding the lock required to access these
> fields)
> 
> Thanks,
> Stefano

A follow up patch re-introduces it, so I don't think it matters?

> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > -- 
> > MST
> > 

