Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270F25C838
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883536; cv=none; b=Z8v2zs4B4DVA9GpoArP6JUgPiuuwrueNIuH0EN/i8dDyU1mxjGkF/75Y9cC5UmZDSZMIuuaLyu6s+zsKH/hxt+fdwROrWDFGloH5bp2puRrfALgmGyyJJWt1anfJRP+UuPqtbuP/k07iGUSp7RPP/tuiiPMuMmZzctlt9ii4etk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883536; c=relaxed/simple;
	bh=ScTKP+c2rR672BgupG9wm67XF9gVvJQXcIgn+/1V/bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mR9OkklzWjDJQIPdni5JH9tn3k/1NQPJDbs3FFcuL6aVUT3H02PIkVHHJpXt8aUGFHOxr2b4ShqwsV7Fp1xZe9pxRu9OD89lkBaGSPi3AfSyZeov5VrG2f0xHR1utyIwWQy5+lidRSCk5rkaoFcbEaflq1zJ3Wi/sFpLaEKj3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEGkcdDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEGkcdDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767883533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfT1Va6tq1fm9ghByqfjKPhOxaDhZdEa8+dMcUknkTw=;
	b=cEGkcdDUtwCQAciuSSLPqYzZQLxzlTFaGDIdEP0X8UFn5G8Y/D6hxjUZg6yiUflE7EN2k4
	J2U1U795kp1zBtn1Tn6S8CWBMwNd3tkOmU7bmO8HpD+flpM/BpJphL2Hil55M32c8aQq2e
	Amn28rycEmRtPiKgq24J22/GVIogvmI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-q41iMbaPNnacCHfm6-DkpQ-1; Thu, 08 Jan 2026 09:45:31 -0500
X-MC-Unique: q41iMbaPNnacCHfm6-DkpQ-1
X-Mimecast-MFC-AGG-ID: q41iMbaPNnacCHfm6-DkpQ_1767883531
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so492511166b.3
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883530; x=1768488330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfT1Va6tq1fm9ghByqfjKPhOxaDhZdEa8+dMcUknkTw=;
        b=lkE3LOnPK6HO27/60TKWwdV/Tw5bUgPdw1wzqmhEl3mu39IwYjLZhf0qf31ttFTzab
         Zh/nEmZIPe9bjMEbsOhbwN7tmgzj8uEWwK3Pkz6WwRK1sU4XK3zeSplGJ8y7Ja35kDFV
         s4c5U1a4527j+focD2VXz9tKeJurbbLdY3Nb3vVWG8TOmCKtdU/vMoH0yyWswIUFaUUJ
         Zx3fS6oBb10dm7V+LUEmfsUxM4Nj9WpKIGXSV/kzvY+AcWl0Zqr6zApIFWgwVqnxKq9b
         DTEhQi7AT+PxqD/5QiZMG03Ymtj8aWi5bGEPegLveal8owmjIy0MJKFO0x9pi2libXKD
         Cndg==
X-Forwarded-Encrypted: i=1; AJvYcCW+2Cy8dWdVngoFZNEFWcGdhKCYCW9LEufXfSPMf8Jd9AnKnBcsZkVUmsjfT6Rw05xpD6oxCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0Zx59r9i7eCkWHAz9Fvu6SIxFWX5PEY3/FDidx4ysTCq/bScE
	HSCnV0IdW4dqWgZa3bIrY7mQw9iFW+z0i6e1QGqlEX41Gy/5wrKIdv6SO1UHsDtzP0enqwwuKd/
	sOLhROY8ophhc6l5/dQAruC5rb6bDKACJz257C5L/3fO3oqa7Ubac0lLY
X-Gm-Gg: AY/fxX5bHkPrVoGkfUuDflOLjjD4jb5qfYCVOdqltq/wRUeM52taqpd3pbMKi1pG3zB
	w0u5+hzR1QBz23ib0kUoRo5buMYAl1aPVAV//H7aYh5cMe74iVhRbbE4wP2aCa+UKQ4i/oiSfc9
	+PzEz8iBKMQa+t+m7jUQGfBeCuWpeZbyEpQ4luu4qNgXWdSoFxBRYfP4Oj76vJjLqeMuQ+pouRp
	/62VUdmFomCA9n/0bTAmbdr6FxHOmwEN85cdCugdwmHpsNZr+P9YG5ts2KknIN7jlBdwOq/+EFj
	XtPR0wdNTHztliXGHS5igHtSngcnqtgp4XSXJzmHqgqnDKKjbwO0gMDj35xbky0EP3I3wxnSZ4x
	dXsYs0FX5vHTRL3S4
X-Received: by 2002:a17:906:c103:b0:b79:e974:4060 with SMTP id a640c23a62f3a-b8444fd41a2mr660535166b.48.1767883530429;
        Thu, 08 Jan 2026 06:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy4t9xkgOZMs7kPUcCm9yBAey59kExadAcY+9phGlSdjSpATKGUSBjtzXbWCkzKn2HKwCwkQ==
X-Received: by 2002:a17:906:c103:b0:b79:e974:4060 with SMTP id a640c23a62f3a-b8444fd41a2mr660529166b.48.1767883529753;
        Thu, 08 Jan 2026 06:45:29 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564255sm848076466b.63.2026.01.08.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:45:28 -0800 (PST)
Date: Thu, 8 Jan 2026 15:45:20 +0100
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
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aV_Cr_f47qqc2JoP@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
 <20260108091514-mutt-send-email-mst@kernel.org>
 <aV-9F42fMfKGP4Rg@sgarzare-redhat>
 <20260108092931-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260108092931-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UjA7UV0YpCfhuzPiLBSjcgP5qpAC40d8J4RMWXaPi8M_1767883531
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 09:32:23AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 08, 2026 at 03:27:04PM +0100, Stefano Garzarella wrote:
>> On Thu, Jan 08, 2026 at 09:17:49AM -0500, Michael S. Tsirkin wrote:
>> > On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
>> > > On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
>> > > > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>> > > > last. This eliminates the padding from aligning the struct size on
>> > > > ARCH_DMA_MINALIGN.
>> > > >
>> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > > ---
>> > > > net/vmw_vsock/virtio_transport.c | 8 +++++---
>> > > > 1 file changed, 5 insertions(+), 3 deletions(-)
>> > > >
>> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > > > index ef983c36cb66..964d25e11858 100644
>> > > > --- a/net/vmw_vsock/virtio_transport.c
>> > > > +++ b/net/vmw_vsock/virtio_transport.c
>> > > > @@ -60,9 +60,7 @@ struct virtio_vsock {
>> > > > 	 */
>> > > > 	struct mutex event_lock;
>> > > > 	bool event_run;
>> > > > -	__dma_from_device_group_begin();
>> > > > -	struct virtio_vsock_event event_list[8];
>> > > > -	__dma_from_device_group_end();
>> > > > +
>> > > > 	u32 guest_cid;
>> > > > 	bool seqpacket_allow;
>> > > >
>> > > > @@ -76,6 +74,10 @@ struct virtio_vsock {
>> > > > 	 */
>> > > > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>> > > > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>> > > > +
>> > >
>> > > IIUC we would like to have these fields always on the bottom of this struct,
>> > > so would be better to add a comment here to make sure we will not add other
>> > > fields in the future after this?
>> >
>> > not necessarily - you can add fields after, too - it's just that
>> > __dma_from_device_group_begin already adds a bunch of padding, so adding
>> > fields in this padding is cheaper.
>> >
>>
>> Okay, I see.
>>
>> >
>> > do we really need to add comments to teach people about the art of
>> > struct packing?
>>
>> I can do it later if you prefer, I don't want to block this work, but yes,
>> I'd prefer to have a comment because otherwise I'll have to ask every time
>> to avoid, especially for new contributors xD
>
>On the one hand you are right on the other I don't want it
>duplicated each time __dma_from_device_group_begin is invoked.

yeah, I see.

>Pls come up with something you like, and we'll discuss.

sure, I'll check a bit similar cases to have some inspiration.

>
>> >
>> > > Maybe we should also add a comment about the `ev`nt_lock`
>> > > requirement we
>> > > have in the section above.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > hmm which requirement do you mean?
>>
>> That `event_list` must be accessed with `event_lock`.
>>
>> So maybe we can move also `event_lock` and `event_run`, so we can just move
>> that comment. I mean something like this:
>>
>>
>> @@ -74,6 +67,15 @@ struct virtio_vsock {
>>          */
>>         struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>>         struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>> +
>> +       /* The following fields are protected by event_lock.
>> +        * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>> +        */
>> +       struct mutex event_lock;
>> +       bool event_run;
>> +       __dma_from_device_group_begin();
>> +       struct virtio_vsock_event event_list[8];
>> +       __dma_from_device_group_end();
>>  };
>>
>>  static u32 virtio_transport_get_local_cid(void)
>
>Yea this makes sense.

Thanks for that!
Stefano

