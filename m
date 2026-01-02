Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69802D878D
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358969; cv=none; b=s3U62okxGgMDALfibFJ00yqKMls2GFXVqvbm7isRbzO4kFGRQSfSLwnmdT1ibXSttm69ZWzXIg5esFMmlJB76veFvLekX2a4z+3clmx1Znb1Nwei4NqxgO2PmfEyRFEmtO52Q7hgu9xiN5MXSWfuQbLBKyMDqW/yGqz3Jp0+/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358969; c=relaxed/simple;
	bh=MzslOykd8x14UYRASjqMHG8WwlyrJUbVhQ0wOUaMEeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JlXXzdlTU0A41azKIxlt+bOgjK6iJO8MI9iU4gFF2TvOwz0BMIanj/9LY2MT3aypQQYJtZf5+XilY97fQua3By5HOpbAyfJSwIptzlCF0izIN3yGyJ11u7Z1PCssvoi3oH5vuoXkueFS50Mib9ugo56UxGeuIUqTGnrEOFlnc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y06vawIW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y06vawIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767358964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WmDmlKfsEAT3FFZsP/TiPm94jNR+IqB/SohCa4X10es=;
	b=Y06vawIWBnbKDzI2gaRETBnHIbrgy6y5/pCIkANcKyzqiSl+5oyDSeQt/2VIuzE22+AP+e
	WWCfB85rSIy2LBTgIDGJTofUcl8H1Iqa4E9cAFfX3LQjKqMvBljvsZV57l9hvnpzbLgtQP
	SR1/eBMt5382jEX2inMjIOa5NxEbMCQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-fijKEpUrMhKz4eydc_qoBw-1; Fri, 02 Jan 2026 08:02:43 -0500
X-MC-Unique: fijKEpUrMhKz4eydc_qoBw-1
X-Mimecast-MFC-AGG-ID: fijKEpUrMhKz4eydc_qoBw_1767358963
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47788165c97so66993005e9.0
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 05:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358962; x=1767963762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDmlKfsEAT3FFZsP/TiPm94jNR+IqB/SohCa4X10es=;
        b=c0ZYMPHvxuxB8g0It4dxLly2CSsJkQzMSawsvYVY1x8VGw4l9iZxARUHT1zGaZdbrn
         JQ8/4LHale/JtFNljO5tBbAhDSNrC4eWkWY8g6mox7Bfk3ol/SuzCC87II+OTs4e53B4
         EX/gh8ZeVbRrD18lGNKSSpxRXGNvsz4bzSjpSbuXLMXK3oMq1DLowhSMmoZLY0ErjcAv
         CT70SyjT374n2FynfKxzs0xke6JMiDUkXwP2RJP8BZP9a7KjHW/si2h6mzq4/j8X43EU
         Fog1SIVic1NllBm/vgPkdyN/oyITkXoc4KuSv/OiOAZyiEV1qKzC5l9+ga7BOsLqbyBC
         m0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXeyxD/0wUWK8kSiktBbCVmBi9SF4mL0UCrcrvAM5Kk59aQP4ymflzEdGdFytiBCRbn6pZUYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTuS0KIdS2IXq5XkmYLRcoh+qKLJV6+bJvP1xPEQGNZlzRtpoI
	hIqtPQvOof4SOrtfv78MApbDusm2/6EIxW7VWaVQFYbsqGrUIbEdMyUgxMwlrdcr+wKkFfoKBF7
	rIflfBIPmF+2p5TBnc4bmdVoLKDF4sKezMhbKTXmfoaWm07F6GkUALhhH
X-Gm-Gg: AY/fxX4Pl86vv6+eYPuaI+J9gHwQTGwZvVN6CKwnrfQHT7++iChwjOqd1lyC8Bh8I3U
	50ybY1Qt1A8tOv0e4QQpAwcYZ4hojII8e+SN5/fS+fS/ItmSF8qwmSZU73DwcpgU8vMYWnVagZH
	M3C/fa2KgJ6OUFXDjyVwbi+GEewgcbgsaooAGKkxRWen330RSf3y/2aSYDD2+V5Tr0FZ3FrpZv/
	hmPFi0FgUk6HrUALjLdVJ7js6vvI2cT/Vf7m4cxX4e+hy6pIxwtvt/iFr7P3oH0N1HxGhoPmkZt
	Wahgnyk+U1aFzQwZYfMVGdWOXErPKQAmVMSfSAjf0xxk8TpfhkLeie0fUFxKHnUlbOVVy6pEaPj
	0iTmZGh0qXydUh3diIUCZBcYFp3K8ln+cxw==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47d19590bbemr512375365e9.30.1767358962204;
        Fri, 02 Jan 2026 05:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBPpH0ihQmD8Y4wAGqUXdjbUDmUwQhrGC4bvR7Khhg9b0D8Nv1fILL/X18iGX7aRdaW+Lc0w==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47d19590bbemr512374585e9.30.1767358961687;
        Fri, 02 Jan 2026 05:02:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm720685835e9.13.2026.01.02.05.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 05:02:40 -0800 (PST)
Date: Fri, 2 Jan 2026 08:02:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bartosz Golaszewski <brgl@kernel.org>
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
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <20260102080135-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
 <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TklufRf38u0bIwUNeyCU4Atyw0ji0VPgQYXgJ7cVXXQ_1767358963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 12:47:04PM +0000, Bartosz Golaszewski wrote:
> On Tue, 30 Dec 2025 17:40:33 +0100, "Michael S. Tsirkin" <mst@redhat.com> said:
> > Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> > last. This eliminates the need for __dma_from_device_aligned_end padding
> > after the DMA buffer, since struct tail padding naturally protects it,
> > making the struct a bit smaller.
> >
> > Size reduction estimation when ARCH_DMA_MINALIGN=128:
> > - request is 8 bytes
> > - response is 2 bytes
> > - removing _end saves up to 128-6=122 bytes padding to align rxlen field
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/gpio/gpio-virtio.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index 32b578b46df8..8b30a94e4625 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -26,12 +26,11 @@ struct virtio_gpio_line {
> >  	struct mutex lock; /* Protects line operation */
> >  	struct completion completion;
> >
> > +	unsigned int rxlen;
> > +
> >  	__dma_from_device_aligned_begin
> >  	struct virtio_gpio_request req;
> >  	struct virtio_gpio_response res;
> > -
> > -	__dma_from_device_aligned_end
> > -	unsigned int rxlen;
> >  };
> >
> >  struct vgpio_irq_line {
> > --
> > MST
> >
> >
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks! There's a new API as suggested by Petr so these patches got changed,
but the same idea. Do you want me to carry your ack or you prefer to
re-review?

-- 
MST

