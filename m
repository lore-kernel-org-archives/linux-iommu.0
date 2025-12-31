Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7C27465C
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192171; cv=none; b=BOdTIBuqgyl+JzTInb8W9MMvCzL5lyGmzqh5ceDWT3ATuizBVPOUdP2vZr9+h3aGaefBVR+o22etM5iy2wBepTVjr8c6+1ZM/UcC7bhOAxOxwzEbnDNJcNPaWG1KMqSX5SSVpMdxwMhhJ/CKk8RvEiE0FB85Hd6vp5mKl+jmlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192171; c=relaxed/simple;
	bh=7yEDDnq5O6nyMipRBT3oeW2l7NFO4JF7mnRHmsBSRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ozwohS9PKkudLjr/w1Cqm5K8pmoc8zUpvZbm4XNFHLKQ/9lP/8n3A1keFon8wXMDLXgGmGsBVYBainE5Ll1AYHMjx6YR1UEbGhJHhkurGKmS6QOhY6Q58erFhSr3Wj/aiCQHgWnZK3lIzTWDVNvrmd9SEOVfMdQgvcBDLPfGlww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hiy1nehM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hiy1nehM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767192169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4mmJIWspy2eeK4ehzqbWNIMKVXq0BnPvs75MDLcYu0=;
	b=Hiy1nehMQyFAupyVX6y6SeHjDgF2jPBYOR+Mr5lsqPmuTygZsNEOaLVb67PxafU/5pEH22
	VIK/8ZI38TZv6QGSPunjQgXZo4eZUl3nuUxHdHxsGOtXiUgrblz2WCo20Rux1COLLn5Ql7
	985ieuaI+3DyFaQAfyTaaK3lszml+Nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-W6JNJnByNl2I0v2U4oCihA-1; Wed, 31 Dec 2025 09:42:48 -0500
X-MC-Unique: W6JNJnByNl2I0v2U4oCihA-1
X-Mimecast-MFC-AGG-ID: W6JNJnByNl2I0v2U4oCihA_1767192166
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432586f2c82so5596281f8f.0
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 06:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192166; x=1767796966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4mmJIWspy2eeK4ehzqbWNIMKVXq0BnPvs75MDLcYu0=;
        b=riHemC9ApvQO4cD3Hi8V6JDglbo7m07E720nikOAWoGwsD0vit0DdCbCrlFo0qL++B
         VOQQ1QW0+SlSuX4BsDSyMRuwI/SauOxsz6jFlyuJeduNCkcGgoEQH7pabv037U+n+A3G
         LLf2wP7yc9D4Zh/CRL/ATkM5J6j52g7JsCd+HuXI9/ZFA3eupz1PO6/XgehowqwOdk9B
         JgyV8/1G3EC0moqfrDM/6+49290wW9Zxcbt472N7BAb8nUa91yjgEQkdnRojDNHLlgKe
         GLomzTdcxVNq6+8OMa+YDrvCzw9jBUKRpJZI+J4PsJjfKqKY2pDlR/63LfFFasidXMa6
         MxRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOBQ9T4UUlqY7ZwB3Eq5SNCze/EuOExpXCkeVzmjrXS5It3ssSV0CbTcLZuUiZMFuCCKTEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsSwqedBBrxZ/MTYjl7dZb0Cv4ivx/T1Gbe7ujmrdBrYhblyO3
	+7HmlcocjBhHndS7Q0zCMqoH//TOIfRcVKFFa5LHfoW2f9FgShIbg6jY2WGXdf2+jYlJWAijzWU
	4pFaA8M3vPcUDbJfEBO6jkzojIJoXO3enzu6HxboWTGj2hGbngz2Hyent
X-Gm-Gg: AY/fxX5NszJQ6UkW8IAGjn9BfSAdFc0LK+d/ZDVPvhMhtBP9CfHtK6nbR4sMhIE0WuS
	zXe24avs2xS+0OSz6NM0z/+yaNv0mB19o2unV31daZkgeYiGey88+qZsP84Kp5KH7VHn5Wj6R0L
	e+Oki/a31QxM/bqnNhp7liaf7+A6pmztG33+12jSFl9TiA2OdpAFCZ3nDof1zikqvZOf4nP4oqj
	CV2mHNKe3mGLUZwxoMkkEUBCFWIUIe78oCx6J6oUqgXBsS23R05vsk6e6wgbEkeYTZPh6EcH0Vm
	gO7/BxwUMp4UBUPREcL6FUfMo0/QT9m1L2d/GUWbfKAHa5xRDiMf+OzgQoowOfuV9SmWqQ0aIbf
	LLymmm5vcA2OT4gabVhD1ettGbAhZva316Q==
X-Received: by 2002:a05:6000:2005:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4324e42eb06mr50147700f8f.24.1767192166365;
        Wed, 31 Dec 2025 06:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF5p3yqPt+kPdPb7TGA5JeM+zegz4+9TsD6bOekShro6ixOnDhxT1ci9gV1aizVZntyxUQBg==
X-Received: by 2002:a05:6000:2005:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4324e42eb06mr50147651f8f.24.1767192165832;
        Wed, 31 Dec 2025 06:42:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm74610221f8f.35.2025.12.31.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:42:45 -0800 (PST)
Date: Wed, 31 Dec 2025 09:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
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
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <20251231094052-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <20251231141224.56d4ce56@mordecai>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251231141224.56d4ce56@mordecai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5FHGufQWWKKfcbbs1HKoBr7Pf4LOEA7Z6Y7raygvENc_1767192166
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2025 at 02:12:24PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:42 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Cong Wang reported dma debug warnings with virtio-vsock
> > and proposed a patch, see:
> > 
> > https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/
> > 
> > however, the issue is more widespread.
> > This is an attempt to fix it systematically.
> > Note: i2c and gio might also be affected, I am still looking
> > into it. Help from maintainers welcome.
> > 
> > Early RFC, compile tested only. Sending for early feedback/flames.
> > Cursor/claude used liberally mostly for refactoring, and english.
> > 
> > DMA maintainers, could you please confirm the DMA core changes
> > are ok with you?
> 
> Before anyone else runs into the same issue as I did: This patch series
> does not apply cleanly unless you first apply commit b148e85c918a
> ("virtio_ring: switch to use vring_virtqueue for virtqueue_add
> variants") from the mst/vhost/vhost branch.

Oh right sorry I forgot to mention it.  It's this one:

https://lore.kernel.org/all/20251230064649.55597-8-jasowang@redhat.com/

one can just do

b4 shazam 20251230064649.55597-8-jasowang@redhat.com


> But if you go to the trouble of adding the mst/vhost remote, then the
> above-mentioned branch also contains this patch series, and it's
> probably the best place to find the patched code...
> 
> Now, let me set out for review.
> 
> Petr T
> 
> > Thanks!
> > 
> > 
> > Michael S. Tsirkin (13):
> >   dma-mapping: add __dma_from_device_align_begin/end
> >   docs: dma-api: document __dma_align_begin/end
> >   dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
> >   docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
> >   dma-debug: track cache clean flag in entries
> >   virtio: add virtqueue_add_inbuf_cache_clean API
> >   vsock/virtio: fix DMA alignment for event_list
> >   vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
> >   virtio_input: fix DMA alignment for evts
> >   virtio_scsi: fix DMA cacheline issues for events
> >   virtio-rng: fix DMA alignment for data buffer
> >   virtio_input: use virtqueue_add_inbuf_cache_clean for events
> >   vsock/virtio: reorder fields to reduce struct padding
> > 
> >  Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
> >  Documentation/core-api/dma-attributes.rst |  9 +++
> >  drivers/char/hw_random/virtio-rng.c       |  2 +
> >  drivers/scsi/virtio_scsi.c                | 18 ++++--
> >  drivers/virtio/virtio_input.c             |  5 +-
> >  drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
> >  include/linux/dma-mapping.h               | 17 ++++++
> >  include/linux/virtio.h                    |  5 ++
> >  kernel/dma/debug.c                        | 26 ++++++--
> >  net/vmw_vsock/virtio_transport.c          |  8 ++-
> >  10 files changed, 172 insertions(+), 32 deletions(-)
> > 

