Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EA2D8DD0
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460849; cv=none; b=ndhgKH+P1Hnnll2vruhrnH39kEoFGICUOyTMh35Acsxn1p9tgoYTS6wu03ihm6z2VTz0kkHvgpS0xuXRJVQe4jIkLiyleeMRUWcxnD4wkZK9aJhvck0ijbPyiz0lgCreaG57xzAlBjnd6KrmGm5+XO+Br647T2PZ5D6VN+qM3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460849; c=relaxed/simple;
	bh=RchACan6pmnNROmj5Nm+BsCnm9+nHETTFHN4ErlJ6d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkXpUwzInTLZxWb86+iGWsLdiK+uCpIZCJ5a2+3NK6r6OKgYHQ6yXt6XSgRd+QM1V2pJe8qF1Xq1j6KFxRGGOeqT+T6lytae1go8TtPRVBdXGCB19UOl2PD8GTxLZBcC4eEi/uZy3xWZTmPLE3KchmsUUEVl5UPQTv7V5PTCU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtPBTP7K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtPBTP7K"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a1462573caso3955ad.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769460846; x=1770065646; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzbl67LvVO3G9O2kTwPWCnjF6/j6A2BV5AiFShhPhBU=;
        b=rtPBTP7KMWu79WPySlVzjNuTfZKm1CWzkiIQQEHGMr6SYjzjOnJsQUJtSY/+8X07Am
         /sViirum9BP7QlDjwyjx9KeMXwsr2gLirmGqphHhkISNwxzHz9M3bjuyGtxmy5V2ee74
         actvdH9jVqLC3INpu162xvF7aRG4V/T3ih4SPnZ/dYB+OVxPY+u3/c9t6/WRbylO6V4E
         3iSUELCrQNwpN2ZAqhXBhO0qiOPsZwFgu49EmQRlRlk/54bT532bH+zL2ok+7evejgaI
         l0v3kG+/0cYGijnhcVx7qmlkz4itFBG98RNg6mi+p8iGIkcbBPPEZeIPsxjUIG+1sor7
         bIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460846; x=1770065646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hzbl67LvVO3G9O2kTwPWCnjF6/j6A2BV5AiFShhPhBU=;
        b=GUlnpmujW+Ez3iaEZHvZHLO3nPd0GQIz9xG59ixraLDrobeUxk6yQM+xolyT3898JZ
         qNoB8icbLp74K90Cm+BT0FObXPGUgu8rld409ONWEJ6tFkUVktNspB8cjpBfRXOrXi4o
         YQvJBx3SSwg8HO5UHX3SCtNYC1n3yqi34yl3RhzjWcKpRf0CAdLvuorV0SKD2L+hF28m
         4aFnnmacxGbd9TjEjLrNIH89KJLt6b37UoPvaMAEb7Fe65iIecoE0XMejmdBxVzjHa4+
         hnO3a7Q2npmrSeJvaAttPGIENBIYbrdaxf3BLfhxT1eEcLLiXVuCN3XdzXxDO5dwEl0w
         8eyg==
X-Forwarded-Encrypted: i=1; AJvYcCXDX1C5VXpI1vLmjWgnoQKglVvjWmeG64TD1/xkvqqoozzERHMw+bBzyAomeNGMY3Xo8pGiMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSsFl2iwzO0uunfQ10/PQ0OKSig4x0rp4GO2+d96I/MOkTmzyM
	TzA9DPFCNllQIDO19Jt1I9POtR99EVIKBufJhjHHNBxUf6X+21WaklPZurzgB5htiQ==
X-Gm-Gg: AZuq6aK+vWg5heLIO8d1MZtxCxczlbNk/UFn/GqaGioMSPfEXP2/4sTqVupWcqAqj4u
	FJ1zakW7fQYIbAPMncpfu64YyRj1HCm0oFvP3n9Svk+21QVUzWRxD2S+Vsr/+ifgZx5yOe/FmKt
	moMRokSivanh4Bs7fAq1+C3GVdffFN0DRBnYoPAqwifoEIRLJuLKLv2P2yXmPtKxB4tx5yL7PQi
	GgsgNG3Dcvh4bw0CLbBn7zGNo+HKuhzuGyQ2aQMlYT4xpJSFHouS6agwF8GqRvppgInVhmd5nzO
	rKd2P8plCMa7iVyLo+Ob/So0acMhf7OETnHzvISPHMExHOV7luHld3Z/e1fpGV9FmdUsidnQ9dX
	MmBqi4iy9KkzHikvRjP3SXMDAbIgV7M1KRveCyGxvqfg0b67kbAoyKB63BtF/UBWhqaAmMsbqAV
	ixDn2UyimW9/+fjQssb0RB8AuCsiAs2iuvpaN5mB2hRFiCEHkp
X-Received: by 2002:a17:903:1cc:b0:295:5405:46be with SMTP id d9443c01a7336-2a8447fe3b6mr3809735ad.1.1769460846094;
        Mon, 26 Jan 2026 12:54:06 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fda160sm94991165ad.88.2026.01.26.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:54:05 -0800 (PST)
Date: Mon, 26 Jan 2026 20:53:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <aXfUZcSEr9N18o6w@google.com>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>

On Sat, Jan 24, 2026 at 09:14:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> dma-buf invalidation is handled asynchronously by the hardware, so VFIO
> must wait until all affected objects have been fully invalidated.
> 
> In addition, the dma-buf exporter is expecting that all importers unmap any
> buffers they previously mapped.
> 
> Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 71 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index d8ceafabef48..485515629fe4 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
>  	struct dma_buf_phys_vec *phys_vec;
>  	struct p2pdma_provider *provider;
>  	u32 nr_ranges;
> +	struct kref kref;
> +	struct completion comp;
>  	u8 revoked : 1;
>  };
>  
> @@ -44,27 +46,46 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  	return 0;
>  }
>  
> +static void vfio_pci_dma_buf_done(struct kref *kref)
> +{
> +	struct vfio_pci_dma_buf *priv =
> +		container_of(kref, struct vfio_pci_dma_buf, kref);
> +
> +	complete(&priv->comp);
> +}
> +
>  static struct sg_table *
>  vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  		     enum dma_data_direction dir)
>  {
>  	struct vfio_pci_dma_buf *priv = attachment->dmabuf->priv;
> +	struct sg_table *ret;
>  
>  	dma_resv_assert_held(priv->dmabuf->resv);
>  
>  	if (priv->revoked)
>  		return ERR_PTR(-ENODEV);
>  
> -	return dma_buf_phys_vec_to_sgt(attachment, priv->provider,
> -				       priv->phys_vec, priv->nr_ranges,
> -				       priv->size, dir);
> +	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
> +				      priv->phys_vec, priv->nr_ranges,
> +				      priv->size, dir);
> +	if (IS_ERR(ret))
> +		return ret;
> +
> +	kref_get(&priv->kref);
> +	return ret;
>  }
>  
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
>  {
> +	struct vfio_pci_dma_buf *priv = attachment->dmabuf->priv;
> +
> +	dma_resv_assert_held(priv->dmabuf->resv);
> +
>  	dma_buf_free_sgt(attachment, sgt, dir);
> +	kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  }
>  
>  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> @@ -287,6 +308,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		goto err_dev_put;
>  	}
>  
> +	kref_init(&priv->kref);
> +	init_completion(&priv->comp);
> +
>  	/* dma_buf_put() now frees priv */
>  	INIT_LIST_HEAD(&priv->dmabufs_elm);
>  	down_write(&vdev->memory_lock);
> @@ -326,6 +350,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  	lockdep_assert_held_write(&vdev->memory_lock);
>  
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> +		unsigned long wait;
> +
>  		if (!get_file_active(&priv->dmabuf->file))
>  			continue;
>  
> @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  			dma_resv_lock(priv->dmabuf->resv, NULL);
>  			priv->revoked = revoked;
>  			dma_buf_invalidate_mappings(priv->dmabuf);
> +			dma_resv_wait_timeout(priv->dmabuf->resv,
> +					      DMA_RESV_USAGE_BOOKKEEP, false,
> +					      MAX_SCHEDULE_TIMEOUT);
>  			dma_resv_unlock(priv->dmabuf->resv);
> +			if (revoked) {
> +				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +				/* Let's wait till all DMA unmap are completed. */
> +				wait = wait_for_completion_timeout(
> +					&priv->comp, secs_to_jiffies(1));

Is the 1-second constant sufficient for all hardware, or should the 
invalidate_mappings() contract require the callback to block until 
speculative reads are strictly fenced? I'm wondering about a case where
a device's firmware has a high response latency, perhaps due to internal
management tasks like error recovery or thermal and it exceeds the 1s 
timeout. 

If the device is in the middle of a large DMA burst and the firmware is
slow to flush the internal pipelines to a fully "quiesced"
read-and-discard state, reclaiming the memory at exactly 1.001 seconds
risks triggering platform-level faults..

Since the wen explicitly permit these speculative reads until unmap is
complete, relying on a hardcoded timeout in the exporter seems to 
introduce a hardware-dependent race condition that could compromise
system stability via IOMMU errors or AER faults. 

Should the importer instead be required to guarantee that all 
speculative access has ceased before the invalidation call returns?

Thanks
Praan

> +				/*
> +				 * If you see this WARN_ON, it means that
> +				 * importer didn't call unmap in response to
> +				 * dma_buf_invalidate_mappings() which is not
> +				 * allowed.
> +				 */
> +				WARN(!wait,
> +				     "Timed out waiting for DMABUF unmap, importer has a broken invalidate_mapping()");
> +			} else {
> +				/*
> +				 * Kref is initialize again, because when revoke
> +				 * was performed the reference counter was decreased
> +				 * to zero to trigger completion.
> +				 */
> +				kref_init(&priv->kref);
> +				/*
> +				 * There is no need to wait as no mapping was
> +				 * performed when the previous status was
> +				 * priv->revoked == true.
> +				 */
> +				reinit_completion(&priv->comp);
> +			}
>  		}
>  		fput(priv->dmabuf->file);
>  	}
> @@ -346,6 +402,8 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  
>  	down_write(&vdev->memory_lock);
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> +		unsigned long wait;
> +
>  		if (!get_file_active(&priv->dmabuf->file))
>  			continue;
>  
> @@ -354,7 +412,14 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  		priv->vdev = NULL;
>  		priv->revoked = true;
>  		dma_buf_invalidate_mappings(priv->dmabuf);
> +		dma_resv_wait_timeout(priv->dmabuf->resv,
> +				      DMA_RESV_USAGE_BOOKKEEP, false,
> +				      MAX_SCHEDULE_TIMEOUT);
>  		dma_resv_unlock(priv->dmabuf->resv);
> +		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +		wait = wait_for_completion_timeout(&priv->comp,
> +						   secs_to_jiffies(1));
> +		WARN_ON(!wait);
>  		vfio_device_put_registration(&vdev->vdev);
>  		fput(priv->dmabuf->file);
>  	}
> 
> -- 
> 2.52.0
> 
> 
