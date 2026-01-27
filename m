Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E035F8B7
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531280; cv=none; b=HPpkGCbgne/IHFmMMcxTtUUZb0xIrrRx9B5pudskFLU6abTRQ45NGQzFWIz2y4pYrswlSFaKR8q7REnGBXdqpdaQ3kdB/+2HJtbp9/JKZbP7lMgRiTAYUCf8CDOnMuJWFnEuZHC+fwYok7srjDsMjZ+KscJEH0BObkR3hAaNd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531280; c=relaxed/simple;
	bh=EzvzbPpROKuqvVQCoJHluXwjW5pJqoCNcXzstaHV6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHh0ArXU+XMXMH8OP2WKqM+uB+hC+/3IYTwZ7/pxkTqDCnOy+oWwrxAK3NfeQMuj9H0+ofgph/yfI8S7kuC65Rp8Y+uCdlciHI/u9v/J5Uyn38ub7fOVYtpCUUd68QRzasI84XRTqJtZJuMHc/hXoxT9++LdmPm960gxkuUo7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QbHzJ0+s; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QbHzJ0+s"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5013d163e2fso65737521cf.0
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769531276; x=1770136076; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=QbHzJ0+smE6PhWIo5Phi+Yhw1URDugVYWz8I2pHz3ogvOciXOu16vdGuRjbo6cIktn
         asFrAlE1agEkgOq2/mNuDG/lNFaZx19I4FmDtRWquEC9V00/iVUR4j2CN4p3KScJfZoe
         thZwHqqxueRVgCOnY1JDLCsHf9NX8Ls9nlQP20rt2E2c48SeGcRdU3kTdrGMEkiUsU65
         9xhgki86gRDZJseNbd9fsP2ugtSg2aSXm5CATMkR8UTifJeKPkSfdxnYh5CiRlxMp2/E
         pOWkvmLKEH4J5bv1cuC/n1526dRrdC9ZoNhH8zhzII1N4FOh7ZDD6ewI3LQL9W6Nhosy
         XGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531276; x=1770136076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=TFxdbCUY8CUl58ZTcOwcCPIJSeRj0uWAWCaKmuYn9y7bcjVNv35/glg9P9TJbn0J2Q
         CHo5AriAqHG7RFFs/lRqkrJZvx/W1kTBKZ9ZwawWPS/Jj0flZDL5OsSpWDluCU3pivsU
         +Y9IdNJQ9GDrBU/hD1MxHqAv/14erXHiWjby9AG0PRKDy4IsOgcnwJ1jEOjUyu9sQC/B
         75vuF20SHw5pl4NPd8ok66L5MDA802/YX1DHEZGB8pG55SK9Xtidi4kTIVyEhNDMV6Wz
         o1Pqwd+qZd/rmnfOHA75hTPsSbzJiF56/5ITjpZ7KRTEHskxlPgYovGSm0x/IKhVvY1r
         KVPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkC4f/5I1zSIhEsyIWs0kkxiwE9Av/8WmnKd9c1emq0Z1GBodom8oa9+GyCxf5BwnCo2SNdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5bV4T0e2/qW1GIovJ/2ePVN6JH7HABoJ6ePDwkPDqizQi2Hv6
	d9SOoSbNCCXd8tlUrfVHys5ONcoy6sJkEJmIYlXrohIzjAEOQTE4jwi/fnUsoopOfiM=
X-Gm-Gg: AZuq6aLlygyDzCxUN74g1Q/hnAOoy55E+THHsRfLTTBFtIq+vhVTLtlcS187pk+3dwe
	4foHOJw2H5qVC7uXdbmq0OPs9UhJgv9qcn1WBcbIjdid128GjAW/wfaJI7PuyPt8OsiKhjjbMDn
	sfQohVoyeQNdL8AThRHt21h3FKmpH7xXaiKk+O+CKkL/hpsSn+Bho/BlqvRSousMXMunmZkemB2
	geqqLkYK1RqB+yhfiUCgJ6lAdjkOzINewPv/pdohj8TBo0PByOU7mWlGbWXlCDJxylrkUF5gIz1
	6XkAcw5dXHCdDZgIeZ/5XF7TTQmPtpsYzT5fdr7ZsfvMV4czWRSo0xoEp8WQ0u3ueMumnnfQv61
	o7OQqDOCfgy8Rt/sB27sdBbVoPc2k7O9ZkObKClcmfgBy0UeDLpuXAUWvLkeBAmjYHZxpk4T/8/
	sSnARtgAeelwo7fLD+cJ/d/8EzOtJDvYLF2HHK5kX7MsaJ+mmPpjgXZB2D1j8Hdh7D2xPwqXIh2
	DU2GA==
X-Received: by 2002:a05:622a:612:b0:4f1:ba00:4cc6 with SMTP id d75a77b69052e-5032fc167d4mr25702421cf.79.1769531275530;
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502fb8e74ebsm102277581cf.0.2026.01.27.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vklv0-000000095Ys-1TUe;
	Tue, 27 Jan 2026 12:27:54 -0400
Date: Tue, 27 Jan 2026 12:27:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260127162754.GH1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com>
 <20260127085835.GQ13967@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127085835.GQ13967@unreal>

On Tue, Jan 27, 2026 at 10:58:35AM +0200, Leon Romanovsky wrote:
> > > @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> > >  			dma_resv_lock(priv->dmabuf->resv, NULL);
> > >  			priv->revoked = revoked;
> > >  			dma_buf_invalidate_mappings(priv->dmabuf);
> > > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > > +					      DMA_RESV_USAGE_BOOKKEEP, false,
> > > +					      MAX_SCHEDULE_TIMEOUT);
> > >  			dma_resv_unlock(priv->dmabuf->resv);
> > > +			if (revoked) {
> > > +				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > +				/* Let's wait till all DMA unmap are completed. */
> > > +				wait = wait_for_completion_timeout(
> > > +					&priv->comp, secs_to_jiffies(1));
> > 
> > Is the 1-second constant sufficient for all hardware, or should the 
> > invalidate_mappings() contract require the callback to block until 
> > speculative reads are strictly fenced? I'm wondering about a case where
> > a device's firmware has a high response latency, perhaps due to internal
> > management tasks like error recovery or thermal and it exceeds the 1s 
> > timeout. 
> > 
> > If the device is in the middle of a large DMA burst and the firmware is
> > slow to flush the internal pipelines to a fully "quiesced"
> > read-and-discard state, reclaiming the memory at exactly 1.001 seconds
> > risks triggering platform-level faults..
> > 
> > Since the wen explicitly permit these speculative reads until unmap is
> > complete, relying on a hardcoded timeout in the exporter seems to 
> > introduce a hardware-dependent race condition that could compromise
> > system stability via IOMMU errors or AER faults. 
> > 
> > Should the importer instead be required to guarantee that all 
> > speculative access has ceased before the invalidation call returns?
> 
> It is guaranteed by the dma_resv_wait_timeout() call above. That call ensures
> that the hardware has completed all pending operations. The 1‑second delay is
> meant to catch cases where an in-kernel DMA unmap call is missing, which should
> not trigger any DMA activity at that point.

Christian may know actual examples, but my general feeling is he was
worrying about drivers that have pushed the DMABUF to visibility on
the GPU and the move notify & fences only shoot down some access. So
it has to wait until the DMABUF is finally unmapped.

Pranjal's example should be covered by the driver adding a fence and
then the unbounded fence wait will complete it.

I think the open question here is if drivers that can't rely on their
fences should return dma_buf_attach_revocable() = false ? It depends
on how long they will leave the buffers mapped, and if it is "bounded
time".

The converse is we want to detect bugs where drivers have wrongly set
dma_buf_attach_revocable() = true and this turns into an infinite
sleep, so the logging is necessary, IMHO.

At worst the code should sleep 1s, print, then keep sleeping..

Jason
