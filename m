Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC135C194
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476137; cv=none; b=QiD53jhoxENkWMPWjn/myXQ59afQ131UeiCKeMfdcdMdCJ9BHnj+ITZDqCSWE5V17IWGsjYQJLoG/VoUV3cXBbhnYEocSyxkfxGKSB+arW//Mz+wyag+N7mO13cNbWgVg48y0op0Mj9xFqwu/tdxKu6WvnzUnnmknVnC5IMhBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476137; c=relaxed/simple;
	bh=Vw+jMoLrz3CPi3RZadAUQ9OZDIQrFYnK7RrpZ+3jFFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA6zOM3+5EJEy9EtS/KnDVe7RqYRFRS1ltCi7r66xScSD+QSUYVnHbSdKTFQZe8HiwOkN3lG18QkFImbJcE2T7ijqssC3Zvsj9yx+xMlVR4OkrT98LQ6P9cTDFktvgaXepQ/CBDQtiSlGi1S4BkSU+ARR8expkE/PZL52rBir4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UTvl9nJ7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UTvl9nJ7"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-880503ab181so55043086d6.2
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763476131; x=1764080931; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35WpspOv1fAWFINmOzi0AcgEQL1oV2/QEYSJcrH4aSg=;
        b=UTvl9nJ7q7LDhuY34HqRV0ycHp6SCtwJvVhg9vzbg4q8DybHNo9+Iz+unqQg1SVUt/
         42U2OdB4ztViIGlm10huQiMJCrOkNgtPLjIxUcc/6KJywubBrzdIpqR7ZTHrwhjZnCYV
         5FFV2yqkcY0Lojq+Do3BxRww/D+kr9viLElo7JGqfG7KOI42JpWyDcForg1IABQemy7f
         EK3c4W+fRYu28nwKz32cKU5AfX5+CiQR1pSuiL0xMmllcueDMIkQ2u+n2ya0bV/U/af+
         B5SU7LMqMmbnwhm9fOOYHrbv6KzMTFiLKqIwD+lHacnrMKVDEAVFV5UPzgn1kEShRxdW
         qPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476131; x=1764080931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35WpspOv1fAWFINmOzi0AcgEQL1oV2/QEYSJcrH4aSg=;
        b=E6qduAR4ryrfhCBVlCZSwR2QYiivHvzT4jIcHCUvegy18oeXWABGGjaWrToSwVxOkM
         DuvT4u+oKRGBhcG8XwGkaKRm+6d2YXL0+LJ+wMZ3KeMzjEimMERGHJ7FMJnoSigha/c3
         elRWelglYI4z+lI+PVN0+c0ELp9p6D8E+cCqmZwCreMJEqLSgUELv8qSzIPvrmnx/WkG
         DiwawTftEcxVsLKC+WYzXMWVC3P1SbENwIatgKdO87nr51fQMzBAhFNp4UdwFwaAoOWG
         cT6A19ubRCVT2ZlXFHns3AGujI7aEnF/+2axQqZFBbxvPvxvt+dgN5JCaQn5qpeFR0fl
         QdpA==
X-Forwarded-Encrypted: i=1; AJvYcCXRLry+CHigzgPretUasN4lv7qqx3VSk7Mz5qZqeV6Z9FHHWfGrk73JFEERDRltc0FjKTUcZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfksWXEy2CEk3s5wbM3etsG22YEp6hla5OPZEvn72Dg5kQToXn
	NS3z9wHuxrpynNyQitDMqft7GsuOIF7gabFaWK/kg03WMNpUtxKOOQkDcjXKq/FKsx4=
X-Gm-Gg: ASbGnctVGKDoSFltDFyueAhDwhZ5ALNne2HyzXSe4KVt0yJG2yMATw6TLuhKhGxjamR
	MANwh2DoOVecsGVnSt5usO4/yZxLBZmpsF+cJQTJFMcxamdpr8p5bvpBh4hc7aFHnTb/FyLilWe
	moDzmCafAt9A2NxpR6Q9atJAtBFClNDxRKTXudF6NiJZnYQDwdUWkuVqcZFCa0XxwcFgqKYXl6P
	6k1Q6gCQ8M/+C3iLmEdUN7OJxYlmUALGmFgviqmOIEDxVVsekN7jck8D8B8yAt+p+Z1LfxXSQiU
	Wm4jjwSoYQW5YkzHvUdOP2Bus8t+M9SNIvlp3scv2D+yHxAfwuL2NgwyK5Z9OKPBaZ0L4+Y7O//
	9oMaZuCdAtorkbiP33OFQ3AOMTUN8n6C0YJRkmUeboDph8D7ogOw9ynbzGHJLhrWSWp5NYmdmLf
	YphbRR1E5AsxBv9qdAkY374WS50rLcEVZVEJAXRNo50kXpJbkR9HkgQmK/VlMJMF9W7nY=
X-Google-Smtp-Source: AGHT+IF+NrfSbYwvwiNh+CC3YngHFJHpwzxC37jBlKkv0sHaTL3i1cld4gWS47y25QRA75BxBaWSvQ==
X-Received: by 2002:a05:6214:62a:b0:81b:bf92:8df9 with SMTP id 6a1803df08f44-8829269e086mr234228876d6.43.1763476131063;
        Tue, 18 Nov 2025 06:28:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652efa4sm114860276d6.39.2025.11.18.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:28:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLMhN-00000000NEc-3Dxs;
	Tue, 18 Nov 2025 10:28:49 -0400
Date: Tue, 18 Nov 2025 10:28:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v8 10/11] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20251118142849.GG17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-10-fd9aa5df478f@nvidia.com>
 <BN9PR11MB527610F3240E677BE9720C2B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527610F3240E677BE9720C2B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Nov 18, 2025 at 07:33:23AM +0000, Tian, Kevin wrote:
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, November 11, 2025 5:58 PM
> > 
> > -		if (!new_mem)
> > +		if (!new_mem) {
> >  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> > -		else
> > +			vfio_pci_dma_buf_move(vdev, true);
> > +		} else {
> >  			down_write(&vdev->memory_lock);
> > +		}
> 
> shouldn't we notify move before zapping the bars? otherwise there is
> still a small window in between where the exporter already has the
> mapping cleared while the importer still keeps it...

zapping the VMA and moving/revoking the DMABUF are independent
operations that can happen in any order. They effect different kinds
of users. The VMA zap prevents CPU access from userspace, the DMABUF
move prevents DMA access from devices.

The order has to be like the above because vfio_pci_dma_buf_move()
must be called under the memory lock and
vfio_pci_zap_and_down_write_memory_lock() gets the memory lock..

> > +static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> > +{
> > +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> > +
> > +	/*
> > +	 * Either this or vfio_pci_dma_buf_cleanup() will remove from the list.
> > +	 * The refcount prevents both.
> 
> which refcount? I thought it's vdev->memory_lock preventing the race...

Refcount on the dmabuf

> > +int vfio_pci_core_fill_phys_vec(struct dma_buf_phys_vec *phys_vec,
> > +				struct vfio_region_dma_range *dma_ranges,
> > +				size_t nr_ranges, phys_addr_t start,
> > +				phys_addr_t len)
> > +{
> > +	phys_addr_t max_addr;
> > +	unsigned int i;
> > +
> > +	max_addr = start + len;
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		phys_addr_t end;
> > +
> > +		if (!dma_ranges[i].length)
> > +			return -EINVAL;
> 
> Looks redundant as there is already a check in validate_dmabuf_input().

Agree

> > +int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32
> > flags,
> > +				  struct vfio_device_feature_dma_buf __user
> > *arg,
> > +				  size_t argsz)
> > +{
> > +	struct vfio_device_feature_dma_buf get_dma_buf = {};
> > +	struct vfio_region_dma_range *dma_ranges;
> > +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +	struct vfio_pci_dma_buf *priv;
> > +	size_t length;
> > +	int ret;
> > +
> > +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> > +				 sizeof(get_dma_buf));
> > +	if (ret != 1)
> > +		return ret;
> > +
> > +	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
> > +		return -EFAULT;
> > +
> > +	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> > +		return -EINVAL;
> 
> unknown flag bits get -EOPNOTSUPP.

Agree

> > +
> > +void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct vfio_pci_dma_buf *priv;
> > +	struct vfio_pci_dma_buf *tmp;
> > +
> > +	down_write(&vdev->memory_lock);
> > +	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
> > {
> > +		if (!get_file_active(&priv->dmabuf->file))
> > +			continue;
> > +
> > +		dma_resv_lock(priv->dmabuf->resv, NULL);
> > +		list_del_init(&priv->dmabufs_elm);
> > +		priv->vdev = NULL;
> > +		priv->revoked = true;
> > +		dma_buf_move_notify(priv->dmabuf);
> > +		dma_resv_unlock(priv->dmabuf->resv);
> > +		vfio_device_put_registration(&vdev->vdev);
> > +		fput(priv->dmabuf->file);
> 
> dma_buf_put(priv->dmabuf), consistent with other places.

Someone else said this, I don't agree, the above got the get via

get_file_active() instead of a dma_buf version..

So we should pair with get_file_active() vs fput().

Christian rejected the idea of adding a dmabuf wrapper for
get_file_active(), oh well.

> > +struct vfio_device_feature_dma_buf {
> > +	__u32	region_index;
> > +	__u32	open_flags;
> > +	__u32   flags;
> 
> Usually the 'flags' field is put in the start (following argsz if existing).

Yeah, but doesn't really matter.

Thanks,
Jason
