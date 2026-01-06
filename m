Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A93314DE
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711013; cv=none; b=g2O8+66adhMUB3eC+KEL6kqtB6nGpdUhwaHKUx2ijVfIZj3o/SpILPu1UoxqIi+KxDEHXFdjeQ6GZLXwLhSOHCiswCQ4whKWxvuIkuK8jqWVNqsTUU8tKZs0/L0R3h+bLKP7m6WWvJdfJlHEZkjrnvuKbhV66yhc/3q+D90zKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711013; c=relaxed/simple;
	bh=RqfJjI32FdZ7MpeaFMqvXp4bO7LyOB4RofYVb7BWxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cFhd9kTqAQGYi77pT+zlcy3CFFzsj63T4n6QuYyRFdVHk3vRuf5e//yEOSxNRcavzplCEBW95H1QpvJTueerhJytPqviBWTUAsEGiCK3MPlMd75Ovd7Z1gdeZA18gk78FhK/jmI6A8dJH7NnvVmzHq+frEcCl4qGDgCTgH1QwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5kY30iE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5kY30iE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767711009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
	b=G5kY30iEj9FNHYjeFeHkTK9hyI5TKUZKKKgvFTaTokxtmi+gWAl9xT53ACjrhDdwbH6Vkr
	C2UhGqjtutBu8DOhbFJyWgo5zI1j6YbDsHlBz5tu7e6S7+ItpygL3YWJMOhs7GE717X/3Y
	8SBosm74S1G8oBG/nVqp5alYYvenLbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-wdsb9m3zOXqyh057Wt7bYQ-1; Tue, 06 Jan 2026 09:50:08 -0500
X-MC-Unique: wdsb9m3zOXqyh057Wt7bYQ-1
X-Mimecast-MFC-AGG-ID: wdsb9m3zOXqyh057Wt7bYQ_1767711007
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477c49f273fso10753035e9.3
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 06:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711007; x=1768315807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
        b=Ch+8h3jarFd4SGqAzlHmOninL+sNaJFhNrUSvNYogriJWbWU5wjbCNZ/trz6q0jRnm
         61A0LWt3d5VTaMev4y4om4XGCxOc23LZNnDjb5O5Jyn3hLgaoWADcM+Q7CywtCGkziDK
         +q4GJxxJIUTgjVOdjo65eLByOKvUUFQFZKbLUM+C+fDa3bIFSMKQfPqb+8Rh93aQu98J
         XTLUgechXTW8ifWglOKhFmFPf+4dL68MuPupL1UeGFv3bpOAdh9BHDUgSmQ+e1fYmL8W
         JyMNkhVpVS2Yr23DqDsLyAbk5T5YgXREsaqBd8hmxdy8Ho8+zuQrQlZfdw6pKBA4wdim
         pLKA==
X-Forwarded-Encrypted: i=1; AJvYcCXb+UKjcZa1kzJy4DG4C9Z7ZwfE3kkXsebV+MvvOMge1GaNntugpYR2ZXUEL/2PRwtBTOYNrA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd8nNP5m6xbbL8an8tcoQW6agw/+v0yikIKkzPMk5zOcyukLET
	7Rg7vs9Yj1OOEpVlWY91nP7UmjjRbsdc3SXYBT0nqIQbMCwGtdNWUrMHDbFa1yt2gN7TEQ4+nGQ
	j0X/jUA+sGcNO6b44d7SbTBNXk1JEFMYcaJR8aY4+mb/FX1f2bFlvtDw3
X-Gm-Gg: AY/fxX5cJmWlKjNnRk9I9vABw8h4A4qPOzuNIaLcJ/n+r2OHCLayjSLZzZEjodRIY65
	Wk5wpBfvKz482aRjvk/RBKO2ox7p6PtYmUosfD//pjJrAa/aGdlx9Ku0j7br4BgP2sMtT/ViGMA
	3ldOcvGLOzU70qUi0zqE6Q1Tu5oVKSGBawsFr1t9Sr3uhhAPFtYr4I7pomGWHktJ1DKEgh+Nf70
	Ql1qEu55D/nlNm6ZD/05Hl8MkqFUoJvcbPyJubXDrzxMAdhEZzBYsyKWdqCFo+JpQwPFyUGti1C
	S2nImtFaKhu9pJ4WPD8/DP1VpmcXcxCAbpvcXNLP4reHCyjy+zhc/o4cOSyE+HK+OtYbkBbPwzD
	YdNHCLQPb5Da1HTexhiGfTpIMv3LxdQJIZw==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820625e9.23.1767711005510;
        Tue, 06 Jan 2026 06:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXHeGoEH1PxicAu3pvp2IKmLzneQBM5bSFfOKMFfLat4mQRdOWLJ6nIuVR4bStC0oG3LJdHw==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820345e9.23.1767711004990;
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm48129575e9.6.2026.01.06.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Date: Tue, 6 Jan 2026 09:50:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <20260106094824-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
 <20260105181939.GA59391@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260105181939.GA59391@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FX5h5jcM1sc676z31xBCLQqglMIzJvcNkMcQA5mqzLY_1767711007
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2026 at 01:19:39PM -0500, Stefan Hajnoczi wrote:
> On Mon, Jan 05, 2026 at 03:23:29AM -0500, Michael S. Tsirkin wrote:
> > @@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
> >  
> >  struct virtio_scsi_event_node {
> >  	struct virtio_scsi *vscsi;
> > -	struct virtio_scsi_event event;
> > +	struct virtio_scsi_event *event;
> >  	struct work_struct work;
> >  };
> >  
> > @@ -89,6 +90,11 @@ struct virtio_scsi {
> >  
> >  	struct virtio_scsi_vq ctrl_vq;
> >  	struct virtio_scsi_vq event_vq;
> > +
> > +	__dma_from_device_group_begin();
> > +	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
> > +	__dma_from_device_group_end();
> 
> If the device emits two events in rapid succession, could the CPU see
> stale data for the second event because it already holds the cache line
> for reading the first event?

No because virtio does unmap and syncs the cache line.

In other words, CPU reads cause no issues.

The issues are exclusively around CPU writes dirtying the
cache and writeback overwriting DMA data.

> In other words, it's not obvious to me that the DMA warnings are indeed
> spurious and should be silenced here.
> 
> It seems safer and simpler to align and pad the struct virtio_scsi_event
> field in struct virtio_scsi_event_node rather than packing these structs
> into a single array here they might share cache lines.
> 
> Stefan


