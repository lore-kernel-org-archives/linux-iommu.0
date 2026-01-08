Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350DB3EC54A
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882756; cv=none; b=oaX1UkWWubuCyBVfM/R7+i2d9XFXFzuRarBWrHYrgWCzLjZM2zRbWjhLxMXi1xFcFZ3UbqVEKVOZAs9hRWdCn64mm2pLk14TeaqxMMB/9WQs1d6S8dVp0L1rPJof3c1Bst42Qt9l3yGBUJ2NaQHFqMB6eMN0/FJ+pJZRXbhdjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882756; c=relaxed/simple;
	bh=/ul1MI70WNuWUatNq9QXmWY0n1CnY3rQPVMj9RML37Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lCIwpS1sKBLJHVPGEYvA3XaNx8Zsj31Jie3nXbQeNWXfaAfeQ4zJLiq6UShcJBJ1uV22z/nnq5rO0DXT5WK5LOjpt1zN1FuEyd6yhANFV+k5mU7iuckrfRHi98AgILL1Ad2eYImllOVl7QL3FArAWVo6qB9qi4g1JuxIDu/2Kak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eq7XdGqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq7XdGqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767882753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ5KldlPLZnW3hZQd/TnLSW7zs03bZTdFv6fpQxf5uk=;
	b=Eq7XdGqCr4zYM53hsEli3Eya9S5UNCffgUmMAEpabaFAjhmQNszB8KfNdjU+ttN/bJnFy0
	qdhfcKGVFPahHV5nZl6pCu4N4tbX1fXizMXFdpXQ6gVOkj73bN8QUtNSXkHmu5oVPcdSNh
	IIaLp8vpYTGW45jM73qmhliaMwfAD8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-xs-1WmhwMaG7YnrFSM-0FA-1; Thu, 08 Jan 2026 09:32:29 -0500
X-MC-Unique: xs-1WmhwMaG7YnrFSM-0FA-1
X-Mimecast-MFC-AGG-ID: xs-1WmhwMaG7YnrFSM-0FA_1767882749
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so17235255e9.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882748; x=1768487548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ5KldlPLZnW3hZQd/TnLSW7zs03bZTdFv6fpQxf5uk=;
        b=N0aFgPoApx/OrISzVhIR19QERRv7MyWJ6Q1VIyEBtJ1N0UI2HtiW1VBzquLn2g1gQO
         0koUBwQuN9ddHeEt8293MdvULtMUK0DhYdQRH6aPP7jTMtPQviQs7X3PsU12u9VHH6FU
         BvwAIukIhBsUdYf0hknvxX6wfjvNjijYh1etVFUCvTOlCxwVUtb7vng9wu7qaDns4v9Q
         N8XkDTKwf4R5CTsK9DY7XLL1ebG700mR572gerG3Niu/w+qFRFtG+oHUo4Szsms75PQ/
         CHoX4JENNELzehrEFukx+Mvb/M20BPnrq312IkPZkIa1hcVZ85RnqzUVDztKQtRJb70c
         ERUA==
X-Forwarded-Encrypted: i=1; AJvYcCVpir0lZzMvQulHClVxy6+jLyrPOK3rl24RECQNOFsmtBVV7ORWlc5QLNHOdNFLE6tZHdFdIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0B5Cgh2WNILPz+lys3aAcBbIOgnpgckNkzJeE785v7a4Z8hxv
	K3wG/hIBiSqjN77keSf1RAJ3vBsIVKnnOlgXp/4u/OT5aF5pi1hFMPYsLeJZONIjoP8N/LzmHKC
	zlyCKvbCD3GNhS4EJss2zQL5wfNezwLvqltsZ2gO5YCjoymNapPvvtq6h
X-Gm-Gg: AY/fxX4dt4/IDMo0sYH4Qm3c/ta9mt1mwjlomZ1lRiGQqxVLsJ3BML/p3uWl+m4IgF/
	C44AzgYsqLBVlSnL0I+deJV0KhglB6RnC4/gspji2ouk9DA8qTbZc74IO0yFVmxYaYB0EVcetBR
	TNvJB04en0DC2zQmmgChX3t5YGsAA2lSdBXUtyvxcO1rJg1qS+/blB8S5bc12RUECNkOmXkj4zc
	NEHNDmnjAvSSZA7WwZPyfrvnwWcT9IBCSp5CsbicGu+gY4QzK6ooR/5luK6YRpr7tbNjfDDayoq
	kO41R0/x8bfP3INWym15yKKDRsuQbg6x0KL1iWlAeD/QEG9mrS/GrKaJAqvRZZDQG+MUzooUlQT
	Jkw/pRYYUEj7RtAinVh7X1Cr7EGyZo4BuSw==
X-Received: by 2002:a05:600c:6c95:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-47d7f63722dmr100357865e9.17.1767882748595;
        Thu, 08 Jan 2026 06:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7Gl8OtqeQkvPJx1M3QhvEhlvzebP4MIt/f4g31duD4E6Ii6eayAMa8grqHGKZjLNtnJFSpw==
X-Received: by 2002:a05:600c:6c95:b0:47a:8383:f2b2 with SMTP id 5b1f17b1804b1-47d7f63722dmr100357545e9.17.1767882748121;
        Thu, 08 Jan 2026 06:32:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d78fsm38131185e9.9.2026.01.08.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:32:27 -0800 (PST)
Date: Thu, 8 Jan 2026 09:32:23 -0500
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
Subject: Re: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <20260108092931-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
 <20260108091514-mutt-send-email-mst@kernel.org>
 <aV-9F42fMfKGP4Rg@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-9F42fMfKGP4Rg@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pQw81NszWv6Fq2wvdd8HHvWkzFbD4tPA7wAwPbA2PrI_1767882749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:27:04PM +0100, Stefano Garzarella wrote:
> On Thu, Jan 08, 2026 at 09:17:49AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
> > > > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
> > > > last. This eliminates the padding from aligning the struct size on
> > > > ARCH_DMA_MINALIGN.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > net/vmw_vsock/virtio_transport.c | 8 +++++---
> > > > 1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > > index ef983c36cb66..964d25e11858 100644
> > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > @@ -60,9 +60,7 @@ struct virtio_vsock {
> > > > 	 */
> > > > 	struct mutex event_lock;
> > > > 	bool event_run;
> > > > -	__dma_from_device_group_begin();
> > > > -	struct virtio_vsock_event event_list[8];
> > > > -	__dma_from_device_group_end();
> > > > +
> > > > 	u32 guest_cid;
> > > > 	bool seqpacket_allow;
> > > >
> > > > @@ -76,6 +74,10 @@ struct virtio_vsock {
> > > > 	 */
> > > > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> > > > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> > > > +
> > > 
> > > IIUC we would like to have these fields always on the bottom of this struct,
> > > so would be better to add a comment here to make sure we will not add other
> > > fields in the future after this?
> > 
> > not necessarily - you can add fields after, too - it's just that
> > __dma_from_device_group_begin already adds a bunch of padding, so adding
> > fields in this padding is cheaper.
> > 
> 
> Okay, I see.
> 
> > 
> > do we really need to add comments to teach people about the art of
> > struct packing?
> 
> I can do it later if you prefer, I don't want to block this work, but yes,
> I'd prefer to have a comment because otherwise I'll have to ask every time
> to avoid, especially for new contributors xD

On the one hand you are right on the other I don't want it
duplicated each time __dma_from_device_group_begin is invoked.
Pls come up with something you like, and we'll discuss.

> > 
> > > Maybe we should also add a comment about the `ev`nt_lock`
> > > requirement we
> > > have in the section above.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > hmm which requirement do you mean?
> 
> That `event_list` must be accessed with `event_lock`.
> 
> So maybe we can move also `event_lock` and `event_run`, so we can just move
> that comment. I mean something like this:
> 
> 
> @@ -74,6 +67,15 @@ struct virtio_vsock {
>          */
>         struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
>         struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> +
> +       /* The following fields are protected by event_lock.
> +        * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
> +        */
> +       struct mutex event_lock;
> +       bool event_run;
> +       __dma_from_device_group_begin();
> +       struct virtio_vsock_event event_list[8];
> +       __dma_from_device_group_end();
>  };
> 
>  static u32 virtio_transport_get_local_cid(void)

Yea this makes sense.

> 
> Thanks,
> Stefano

