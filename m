Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14835BDA6
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581286; cv=none; b=IwmlThw7W5spCFCtbWosDy1aqjKHFl1G+hAFQx/NUeCDOD/4JK/QKzr82Thtd4prQVoTVgwVJFlUUsF7wu1I1d84gCi+JTD5FdWjuhnuvCC4OwQQ5AgWANY1PGfBITyjLx/v6ZOtwq8kyZFQMhyuWz2yQSdpiO+m4rwQy0zRqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581286; c=relaxed/simple;
	bh=McLj5MkyXM/EMQB5rQ6xp2qJjBV3WgZDPtIMlF++SQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPJvDXFnL/Oqb/YlqmXbr9nPPafcHKdT5gSBOwdaUMJ0b64wMLxQcJ1dUBIbkUeFDyd1qazVMiL/+sBGukPK748Yt+SM9hmCZNfjSsLRjYue65z30EzIfr+7vr82wltYJjL2EFnGVjWnOUw6JzvT3YO1t9syFjkU4yxOZ13+C+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ArhKTPmd; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ArhKTPmd"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88249766055so1403086d6.1
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763581282; x=1764186082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xvMcuBzJSIcfclCVWQ2hNnnKt+oezBHS+z89ygHsa4=;
        b=ArhKTPmde9H2zMX15rVzzbw2aRaqNRlyEnCyHfy4nzPMurPTVfCguOZ4vhtCSf5uNP
         gR3wmmZgB1/OODGQlHjFp/qVBE58y4FCqet+orB3TK+6tjjQ0nwDIi8owC30TxeDh9MT
         VJ0J0THImcti0pLNeK9dYCyul4fxYGlNwdT7bwTARKBgLNmKjuRb1wabu0DtCAWJPF+W
         gBXAFKWqQTewxSulWJBlQBuDEOs8l4cQ/Te4qLzgqkoupphrvcuqkGKgWk3u65o57IEE
         uO1HK6S6ILwFhghLUd49jLWWglCYkXPSGuSow4LDX1lbkKnIPODmKs+GZKJBHFyDsnj6
         I7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581282; x=1764186082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xvMcuBzJSIcfclCVWQ2hNnnKt+oezBHS+z89ygHsa4=;
        b=lmwwmUuaim6JUTzgDzCw8w9Z+gb1ofLc54Pm0Al2bIIHwfKI7gfBe39zywHCA2s+qU
         kPKNnOd/qnJ/ICKwgJik1nfxK5VcXcEpbqpFeeKWKiAD77fiunNBhyKmDihJcbWd3rXF
         6msk6alF8ckoApAdTg6gt8d+eXuWNTefx83zvGoBt3nFOXs4Z7x/PTOUS29hsesVIYku
         iHQGijGygR5Og1x5d7NOGhyEfiIzo2Br5KbLH14QQ1kNuB8R8TVRnSCMSlYukS5p95jr
         ji8BebcgHu/etEYGtIhYGrfsUThmXt0ggdG3YurhmXsBmU80I7whbqtsHkxpTkMS40uN
         qLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK7jTJ6l1Z96CDIznv7IoRh8OQpMBNZAE4Ra3bzN4Tw1tm4g0NTurlIF0lL21pazkbGtE+bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDa+zuDg5qjMJdvxVLAnxcmpiCQmEwcQLuXA/RVPMdPndATc2l
	XaM79qHxQDQO9J96Gem5qP4JAkCpxQNbfWWyeomtcFDHpwuefb5bZSKJFOsWA69IXPE=
X-Gm-Gg: ASbGnct69XBaXhfRIeRfEghgt2cOEf/ht6M9ofqnzx5MDQz7wi+yYkizmTTut9Svmz8
	hvGClKmx/JRxBc8wCmrHNj5sDJZYbUOE6ulWg7TQeQRzAk1J5xm1bdlzCB7KrKy64JnudJypYxy
	f57lFQUvY3Rz075Ru+Rl1VmBkx7daGVxMRsMM1UL2tsRqUET91fXMyYmM9wA9Kbnq44upRWCb3l
	XY07koCsKGA5cmJCTnkjzY2YH/vR0wg0P5FF9BPyfH3B8c19vKGqLr+x45bNXhmEB5qg2mJwG8M
	GZcKpJgISPCDQT8yMntg6HJ1M4a/CGDJoDNei/BUaFu5kIT2WgwACMSn84c91GDC6mdlqKnjIbV
	aKroL5eCEnHlXYNFet3EzbIMfC66vBVN9Wg1p+YvnKGzMTK+7itWDlVIp22wWmEqT/yqZwD1iBA
	3MTrGuhLYRtc8ose+hahALx8DTpiir5rQgRTJ4t4oLvRmwPm/Ufru/aVrT
X-Google-Smtp-Source: AGHT+IEkkwKLlD7bgArhzanqcgyJXrNkTCLmX/zPs7UZp1FVMILPKD98FXvYwEVi1NAfBqdDip+8Dg==
X-Received: by 2002:a05:6214:4a84:b0:7d2:f787:1978 with SMTP id 6a1803df08f44-8846ed7f961mr1725046d6.3.1763581281958;
        Wed, 19 Nov 2025 11:41:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e47115bsm1948696d6.21.2025.11.19.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:41:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLo3M-00000000bbB-3imG;
	Wed, 19 Nov 2025 15:41:20 -0400
Date: Wed, 19 Nov 2025 15:41:20 -0400
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
Message-ID: <20251119194120.GR17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-10-fd9aa5df478f@nvidia.com>
 <BN9PR11MB527610F3240E677BE9720C2B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251118142849.GG17968@ziepe.ca>
 <BN9PR11MB5276EF47D26AB55B2CD456EE8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EF47D26AB55B2CD456EE8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Nov 18, 2025 at 11:56:14PM +0000, Tian, Kevin wrote:
> > > > +	down_write(&vdev->memory_lock);
> > > > +	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm)
> > > > {
> > > > +		if (!get_file_active(&priv->dmabuf->file))
> > > > +			continue;
> > > > +
> > > > +		dma_resv_lock(priv->dmabuf->resv, NULL);
> > > > +		list_del_init(&priv->dmabufs_elm);
> > > > +		priv->vdev = NULL;
> > > > +		priv->revoked = true;
> > > > +		dma_buf_move_notify(priv->dmabuf);
> > > > +		dma_resv_unlock(priv->dmabuf->resv);
> > > > +		vfio_device_put_registration(&vdev->vdev);
> > > > +		fput(priv->dmabuf->file);
> > >
> > > dma_buf_put(priv->dmabuf), consistent with other places.
> > 
> > Someone else said this, I don't agree, the above got the get via
> > 
> > get_file_active() instead of a dma_buf version..
> > 
> > So we should pair with get_file_active() vs fput().
> > 
> > Christian rejected the idea of adding a dmabuf wrapper for
> > get_file_active(), oh well.
> 
> Okay then vfio_pci_dma_buf_move() should be changed. It uses
> get_file_active() to pair dma_buf_put().

Makes sense, Leon can you fix it?

Thanks,
Jason 
