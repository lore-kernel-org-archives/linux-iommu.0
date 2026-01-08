Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B640F8F1
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881909; cv=none; b=Zyacp6/RBfUV4i2H1vTtHbzmuseaahuXX1+AnqQvy0Y0OffkqV9Nb/eot0t0MXMLJVJjyz3DfiCFlobIInKMbzTfG4hH4LDwMRq0aVuCghDTml6Z7M9NbjQtqChv2kOe2aHcWMeW6YcMWkLN+YTeoMzhxIV5CZP4OSYDMdpFi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881909; c=relaxed/simple;
	bh=SJZE4KTbW/+usatKP1Sr4PPUbIQlx0UuUvCG+8I8T1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gAlb5HNlA0ZC+XrU6nfRRrKVZ2n/RzEVm9Rc/turXaWeUwTJ1l+gGzjsIPAFyEC93ls85MXO27eT2WSsZyqSt6f+Mj0nI727MUuihgxFEevWU7vPmamZyjuFYnyRDgnZwQSl0ZoDerNPodGMnr/W33dHSKd/DiHxMJrebsg4R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3wFfw2A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3wFfw2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqZiGHlphsIXyTZBYYB1RUSRDC4SlQ7PgnKFPfthJ9A=;
	b=R3wFfw2ApP7SxgdllfSlk6Xr+mhi7oYYZcbmMIjmw1iabWKHleyN1zTXPTfqz5F+1B71u+
	trFMeqMvQD5sOnW6N8WIqkuB9xsjXW5myFh4/Z8gnQU4aFc6LmZ3gGj1//PVyqIQdO874e
	NdQSWOClviM6Qrt68NZf050vLdies4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90--kXlEcbPN5yQbV_evNaIkQ-1; Thu, 08 Jan 2026 09:18:25 -0500
X-MC-Unique: -kXlEcbPN5yQbV_evNaIkQ-1
X-Mimecast-MFC-AGG-ID: -kXlEcbPN5yQbV_evNaIkQ_1767881904
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b844098869cso250178366b.2
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881904; x=1768486704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqZiGHlphsIXyTZBYYB1RUSRDC4SlQ7PgnKFPfthJ9A=;
        b=CADmmHbrjm70a0wq22Uuc0OfORq7HFdm2ERn1Y4LOgsenPZeSv/CwH+7Z2ImD/b4gi
         T/D4bQTTM34SmmhpfFO7d/Mb2JqYcj6HTqFK92t3jtXUyqdOeMt9ucT0QGud+F2GNXkE
         94m8GMjZ17Lbkclu3qw7jChLmOnTkz50rxJSoVOx96GguQy51KVLYQk5Mx8yQ8PDuC6j
         vztdgjYOHu150PrPqRg4Kw+zcyv8pn/PgaSQR5NOppV/ir4PVIdcrocKiSo312ohOQj6
         tBdFvN6rMaUWh71ZPoJnwyHAJ+AzrcoGn6Ecg+P4SgbL0UYjCkbIZgmm9b4EDBqTQXE2
         FfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhds9OX3015O9krTARBnwPxMJ8uEUN4YwFSolJ9Pi7DcbmW4gEo3n5NMm3+ZfDu5zkaFQ6ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlCxcs76kTFsuap0W0LeHAo7SPmYHhF1SFLc2/nhJV2uvQRvjc
	ROl9cQXam51GmjEGV+kgjY/qz87svqqgtZNS7tJYLQifU13bGPPfY3xIPYUPqxklmvMyZefPE5B
	dzdQ+g0EbneRCthcpJSg6R2ZdOdP8Ir56TlCBENDSFtz02UWtEbswuk90
X-Gm-Gg: AY/fxX7IkbxFSzLGyyec4qf4lx/esn+25Dc2cz+nCRJgCE/6RoQ+qCHfzII8VRt2KAi
	C439Oesnn/jKXYMe07vXZCQgNiWFyNKpSoyC1WTUXUzqzpiPmb1alWRugS/r7EmKDDixN6x8Cld
	3ze2wzgKj87VUDQrboZMwE+ywR8A3wV2k39psBpmJnQwIiKTAUmS8VK38QdQ/dQJhGkoPv5SCpE
	mN4CW3sEZWPskKGFmU8N2bb0Eo4thBujf6NIZA946O9YslAxXqKnIY1XrQl7I4Q+xUd9bOtbsE6
	w/ZS91jaz2j/L1aVWcrECgrviESjZBX9HXKPonIRNcX+EPHYpApuatQGbfYqAwYe6QLWFvhKL1u
	UPLshVksE9KswrU7R
X-Received: by 2002:a17:907:2d07:b0:b84:1fc7:944b with SMTP id a640c23a62f3a-b8445066498mr627908966b.58.1767881903694;
        Thu, 08 Jan 2026 06:18:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3Dxa4w6bRkF+MtZ8LKCNuWLpqie07t2Imxvb7EeEx+3jZGwolIwvKYG0CWJg5J8bgXET92Q==
X-Received: by 2002:a17:907:2d07:b0:b84:1fc7:944b with SMTP id a640c23a62f3a-b8445066498mr627904166b.58.1767881902999;
        Thu, 08 Jan 2026 06:18:22 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a22ff58sm817309166b.6.2026.01.08.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:18:22 -0800 (PST)
Date: Thu, 8 Jan 2026 15:18:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <aV-7QoTi5AfMcfQa@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
 <aV-4mPQYn3MUW10A@sgarzare-redhat>
 <20260108090639-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260108090639-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0CDNyAbZj5W-IM4rNgNQ77ufX_tCtbqYx0RdIfUyZHw_1767881904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 09:07:53AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 08, 2026 at 03:04:07PM +0100, Stefano Garzarella wrote:
>> On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
>> > On non-cache-coherent platforms, when a structure contains a buffer
>> > used for DMA alongside fields that the CPU writes to, cacheline sharing
>> > can cause data corruption.
>> >
>> > The event_list array is used for DMA_FROM_DEVICE operations via
>> > virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
>> > written by the CPU while the buffer is available, so mapped for the
>> > device. If these share cachelines with event_list, CPU writes can
>> > corrupt DMA data.
>> >
>> > Add __dma_from_device_group_begin()/end() annotations to ensure event_list
>> > is isolated in its own cachelines.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> > net/vmw_vsock/virtio_transport.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > index 8c867023a2e5..bb94baadfd8b 100644
>> > --- a/net/vmw_vsock/virtio_transport.c
>> > +++ b/net/vmw_vsock/virtio_transport.c
>> > @@ -17,6 +17,7 @@
>> > #include <linux/virtio_ids.h>
>> > #include <linux/virtio_config.h>
>> > #include <linux/virtio_vsock.h>
>> > +#include <linux/dma-mapping.h>
>> > #include <net/sock.h>
>> > #include <linux/mutex.h>
>> > #include <net/af_vsock.h>
>> > @@ -59,8 +60,9 @@ struct virtio_vsock {
>> > 	 */
>> > 	struct mutex event_lock;
>> > 	bool event_run;
>> > +	__dma_from_device_group_begin();
>> > 	struct virtio_vsock_event event_list[8];
>> > -
>> > +	__dma_from_device_group_end();
>>
>> Can we keep the blank line before `guest_cid` so that the comment before
>> this section makes sense? (regarding the lock required to access these
>> fields)
>>
>> Thanks,
>> Stefano
>
>A follow up patch re-introduces it, so I don't think it matters?

Yes, I saw it later. Of course I don't want you to resend the whole 
series just for this. So if you have to resend the series for other 
reasons, I would avoid removing the line here because I don't see any 
value on removing it and add back later.

In both cases:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>> > 	u32 guest_cid;
>> > 	bool seqpacket_allow;
>> >
>> > --
>> > MST
>> >
>

