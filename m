Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867230E82E
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214117; cv=none; b=Ie5I8Rj/Mt3C4dnVmm3myeuPWJ40V7YXnzS2Sdn+K6E3cEmNMl6fVV392+uHyoTrEebMIjtRQ4XeTAlhUJ1D8mlK5NMtw8dQ7Wa7Rb5TvwEeO4SUFwPG7TOqMPySjLZC51KdCvQHRmFAOnIQRw8Q7Uc82RIMJJFLuCv2upV623g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214117; c=relaxed/simple;
	bh=BpH6W25VRu697Yn7DFwf7krulZ0ceVuuDV1JpnQSClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jtx5aFD+mnDKVJvifwCFNeTM2Aoo785CLDLEZYSWgyE0aNBIFcfvZaPKDX2wkcaejdYfonyKu6ucrN7ShE4siX+WwIEsAMc5f3kvXBfL59YbwMbTNsMbsUcPNUPKDtvA9jvppzmzGksZm6bRfgUvfTmZlIghKXkj+75BHPCgEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO2pst7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO2pst7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767214114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
	b=KO2pst7a6knSWN6rwQQ5+yUFBz7s4wLh4IGyTsMIGnvbkyIE/0qxnBMpRegE4yi2MmXl2s
	vff0dvjNVp0zDxOfz/B46oqVHAM7wvR2Azxy9iXq3hp3M6oed6ampl9o9l0xauspk84wAk
	cjzW7jrv5VoxMU+rxuxsP+aLjHY/wmc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-la3jXkOaPdygu2F1skcaYw-1; Wed, 31 Dec 2025 15:48:33 -0500
X-MC-Unique: la3jXkOaPdygu2F1skcaYw-1
X-Mimecast-MFC-AGG-ID: la3jXkOaPdygu2F1skcaYw_1767214112
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso16992665e9.2
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 12:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767214112; x=1767818912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2sN+P6W4rMfz5k+VlkZX24a7rMpvbJroFZ4fnRS1gs=;
        b=u0wZPOQ/hMdar6Spqo9YmtoAlbzittJnu51eBY0TMr9eMoORbcj8FIQi+8nWFB2ly0
         95OmBsPKb5y97aIEIEqF4hbdhbZWQU/v9VcTEb9JfmKabHcUaYqCMQCFR6qChRDXKs+1
         WCWdEFJaToZDsSPKTJTOUc7HkNf2WkL4hmx+DETJhoB4tDdgzzQ2z6YDl3eKCMdvLbuV
         +Qr/1z+MHrYO58SDyaGswSYyDvOi+tzZdRRJgYyPknQGIGmhJXIinefLBY6i6L/zJwIb
         UJ7L4yFALHsVIeojFyuJ99WSQu1x9lQSQyE/kNEDoPru9cZ5DDU5Drf+09bTdhalDkWP
         qp9A==
X-Forwarded-Encrypted: i=1; AJvYcCXYmjHs+6bijNBlUO1OWXKHKK+vlYlVcxCAkNr50C9E3HqcvS2UsYFNJCI9lNCdUtFzz+XaoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO3CHlR5Aop1Q/qbH+AYYAF+T3wL3VnFKtc4IHhivZzc0QKYvw
	oONH7+ZINfPgsXIDuOELJvqUDjlq1V7E1NWQdRroWDI8m5kpHtMCvT0T+WRx/jEZ7LSXd+AQUjK
	d43jKdTa4T2j55GSR1tnXjqvvQ3Mdz51Z6G2EQV/9UCD2N9NBMUJ1XWLr
X-Gm-Gg: AY/fxX4cKZjjuZUTAwvLdZk3zPEQKSIKYRl7crALh8IfQkI4hkB6KAP04pCg45C9K+t
	g797yBLlkPEvJWB8hgGcos+Mv6t9E2Ynxsxn4wVui2k4/l5vs2nURrCDKNo7gdusUH1clWMa5cp
	twTRcbhkC+D1MUnIx2wMXV5/kRWD6Nesrv0ICFZQ+kRQZstNz8MJaId0BdnbR1UhpW4HzjAQpYa
	HvQX0QL1Sb3PepLmMBlvnZdr/K+6/7NcaM680oh/JXS+rcYofNZHS1QjUYIlAiWVEWOp5cFlCLa
	PWsZqbWOCTuOmfQ/yshA30WolVPDO0ibX0rk4ezIzUhnv4up90J0mzqfi7JYszg56leGkXiP+uY
	rbdB8Sgkv2/IWr+bFdajNZGqJgtXrSi23Sw==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890975e9.5.1767214111823;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUX2S3Ts6MrXbJAEZ1+1hODDbGMnh81w30kfQclg714E6BWRq3zDXGinSJodthec3i9GHMDw==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr390890515e9.5.1767214111286;
        Wed, 31 Dec 2025 12:48:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm662070775e9.6.2025.12.31.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:48:30 -0800 (PST)
Date: Wed, 31 Dec 2025 15:48:26 -0500
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
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231154722-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
 <20251231150159.1779b585@mordecai>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251231150159.1779b585@mordecai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1utnSrexPEsk9XEi6eHEtQb6nnih0cTF5wbLdJAR0L8_1767214112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2025 at 03:01:59PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:46 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > When a structure contains a buffer that DMA writes to alongside fields
> > that the CPU writes to, cache line sharing between the DMA buffer and
> > CPU-written fields can cause data corruption on non-cache-coherent
> > platforms.
> > 
> > Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> > annotations to ensure proper alignment to prevent this:
> > 
> > struct my_device {
> > 	spinlock_t lock1;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > 	__dma_from_device_aligned_end spinlock_t lock2;
> > };
> > 
> > When the DMA buffer is the last field in the structure, just
> > __dma_from_device_aligned_begin is enough - the compiler's struct
> > padding protects the tail:
> > 
> > struct my_device {
> > 	spinlock_t lock;
> > 	struct mutex mlock;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > };
> 
> This works, but it's a bit hard to read. Can we reuse the
> __cacheline_group_{begin, end}() macros from <linux/cache.h>?
> Something like this:
> 
> #define __dma_from_device_group_begin(GROUP)			\
> 	__cacheline_group_begin(GROUP)				\
> 	____dma_from_device_aligned
> #define __dma_from_device_group_end(GROUP)			\
> 	__cacheline_group_end(GROUP)				\
> 	____dma_from_device_aligned
> 
> And used like this (the "rxbuf" group id was chosen arbitrarily):
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin(rxbuf);
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end(rxbuf);
> 	spinlock_t lock2;
> };
> 
> Petr T

Made this change, and pushed out to my tree.

I'll post the new version in a couple of days, if no other issues
surface.




> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/dma-mapping.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index aa36a0d1d9df..47b7de3786a1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
> >  }
> >  #endif
> >  
> > +#ifdef ARCH_HAS_DMA_MINALIGN
> > +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> > +#else
> > +#define ____dma_from_device_aligned
> > +#endif
> > +/* Apply to the 1st field of the DMA buffer */
> > +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> > +/* Apply to the 1st field beyond the DMA buffer */
> > +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> > +
> >  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp)
> >  {

