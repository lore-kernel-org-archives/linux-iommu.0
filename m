Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC913A3F7
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881887; cv=none; b=e+TeGgHmpYi3tBsZFOg0EhU0ZXOMRgacL1zaELB1Gz68ZPkXcnrs93hS8SOOMDB43H0MiGbyW/7CffT2H/WQMJNSUmVTBRR3PZvoE7wOkcntGG3TJxY7L4ml+80LsA4GvxG9q+5jmmT4ecsa6Icy2doTt+OmuSUVN69DfrMnJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881887; c=relaxed/simple;
	bh=OyIQ4x46NnhuAF46QiC0P1xvTdYkXW0VaN1yOEbVEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LVmjqTkCqWBpXPX4d++zdLjPNJ9Z5f54H5Y53v+NZS27LYxVUJ9K277ggtyAHfw62BlkjhIAU+Y8mfADMdU7dL9zpUAlvefF8ySi1AV/X7CZ/aKo55q00MVvra34Q6G32yjN5evsT/KrWLTcwKXOkYEZBqjKa2Daz53yeLrpxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR/nXuzw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR/nXuzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
	b=LR/nXuzwop/FXzYCptdu4OOiq9sC3521JW2+LXEkxN/lUr5IwaNlZD/6UimSJt1m6gxeBD
	lB7QbyX2z8bVdRHRJv6oOFIszLGwLh6VqbO40t9znAg9vBzizZv6dWGSifYoud15A6ovfH
	ZAqlftreaEAyOM95ouDMq2ilQkrIhak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-qJaOY6iEMJC-9_J4YBV1MA-1; Thu, 08 Jan 2026 09:17:55 -0500
X-MC-Unique: qJaOY6iEMJC-9_J4YBV1MA-1
X-Mimecast-MFC-AGG-ID: qJaOY6iEMJC-9_J4YBV1MA_1767881875
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fd46385c0so1854259f8f.0
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881874; x=1768486674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ1lT1EolLhB5JifwSURg3jL1WOY3ilSvQ0LTyMqODM=;
        b=MHn3/AD9OYiHQOWpR8kWwNjJOsXNfMtxc2ZR6T0iwwAiaISkZ8UFFoJ0o9imiz6e04
         +YTyjYIY/U/iUFCRI4A6AVJdEKGW5CcYMer1RY9wevHP65sylbT5HdAdIJxO9tLA3DFH
         UIVVIFkEnsNapkDuG8ZRh6ClNCLRqt1+IosaCaf+ozhGVZmzde+qeypeovX88nTeMoTl
         T4IL0/DW5sJrcNRNMIpyNcUVAHNzrVxqamg2F5VsMz04FGp7j2Nzz1tgtKWviLE7t298
         DxzWmVtY2gpNMtYLE/xFmrVpLOzd1oLxqqZWJ9luM74xZu+LQEe/NuqSy/pzcQ9II7Xt
         Pezg==
X-Forwarded-Encrypted: i=1; AJvYcCVTe19i3BFCXairURgdo6h64wkEtkPXOe2BAxyId04aPCK3K7NvH87z1Z9QEJWKfRyucjs5Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcqZt2pU3xZgyG0WcFEtXu6t2TxmJ2KKxZDRV6jnhFLgCuiByd
	KdNUba/p/GqNdF0tD5TThuwI+4cjfCri+B8fGh0RLfrWSstupGJiILcaafyJWVCCeKMQqZoCO7C
	ZRE98jgtw1wAjqAIXTvPQk64OB2eGIucixkKGqBUpJXYRgAQQ6PIoQhL9
X-Gm-Gg: AY/fxX6270FsmRnUL2Q+aHKlCkJCgGZYDvpXPInuI1zR1vYI747W8mgfmGkTm3wU7TU
	mJDt1Ba9QwDP67RPNUyUruNyudg4Kj0Tj7PRb3x18ocKFSwjTujinHlYbDnkk8jOQvFTxmvEruG
	NYlPqstB5+73Jxx8SMyUlokHct24gCBWuIErcdlcizi0bO18VJ11EslKMtiegUY5BZ2k/zVerQQ
	ymy0hulIle20uo3SvlRk0LC91bfs7Qj1RLu6wwzX+KHZL6R7wzKKDm6EhOME+V7q9uesM0jQSqf
	CZoG1GKDLn6iVEuFDCOmBqi8no4RTxeJoaVoextTYlP3j1zl3X1rczItGo3Sl1V7gzMn8b/9Vb8
	75+zWcRVeSPmsyld7wvW1EolU5LhNVQb2vg==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468060f8f.1.1767881874409;
        Thu, 08 Jan 2026 06:17:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlUVHuOj7/HPTlOMU0+NpCVpFuCnGhMJ1KC00yBihfngclSciPQ4cpm1QXhZzj17NQ1UZXYA==
X-Received: by 2002:a05:6000:2483:b0:42f:b0ab:7b48 with SMTP id ffacd0b85a97d-432c3627fbamr7468022f8f.1.1767881873896;
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm16735262f8f.34.2026.01.08.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:17:53 -0800 (PST)
Date: Thu, 8 Jan 2026 09:17:49 -0500
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
Message-ID: <20260108091514-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
 <aV-6gniRnZlNvkwc@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-6gniRnZlNvkwc@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ULA7N8bwM8T3RXpiJlQrJBkueQdFE_mAGI4lS6ID7w_1767881875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:11:36PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:41AM -0500, Michael S. Tsirkin wrote:
> > Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
> > last. This eliminates the padding from aligning the struct size on
> > ARCH_DMA_MINALIGN.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index ef983c36cb66..964d25e11858 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -60,9 +60,7 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > -	__dma_from_device_group_begin();
> > -	struct virtio_vsock_event event_list[8];
> > -	__dma_from_device_group_end();
> > +
> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > @@ -76,6 +74,10 @@ struct virtio_vsock {
> > 	 */
> > 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> > 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
> > +
> 
> IIUC we would like to have these fields always on the bottom of this struct,
> so would be better to add a comment here to make sure we will not add other
> fields in the future after this?

not necessarily - you can add fields after, too - it's just that
__dma_from_device_group_begin already adds a bunch of padding, so adding
fields in this padding is cheaper.


do we really need to add comments to teach people about the art of
struct packing?

> Maybe we should also add a comment about the `event_lock` requirement we
> have in the section above.
> 
> Thanks,
> Stefano

hmm which requirement do you mean?

> 
> > +	__dma_from_device_group_begin();
> > +	struct virtio_vsock_event event_list[8];
> > +	__dma_from_device_group_end();
> > };
> > 
> > static u32 virtio_transport_get_local_cid(void)
> > -- 
> > MST
> > 

