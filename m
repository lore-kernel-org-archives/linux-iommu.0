Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7333E356
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224109; cv=none; b=oTAi63UHIwjnvmsJA13lOd8TP4LvKXw6SoRKaX00rJI/YUVTnka1ZOFUFQSS1VJ71YSQhhFJQROPXvnNSqDKOPXYjVRg+H3cLjns8B8zNO8nrwLRyvw6fzfalbc2THafnG5qF/PbCcZvSMIVtqUAqHaOCOaK0u4cVj1X2WLs5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224109; c=relaxed/simple;
	bh=5K5fR+HxBrdqjMKErGIv55w9oITaTZk9Qf+xlROKnSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKWJHZDEiN2hFx/4vfyVD0RGCKrpCJ+tjSaBR99+RDhjX+22JKzdMpmWMGn/uF5r8yhFN6uGRfpO5B+WkeVZ9D23XfkjQkPVmPWNDzr8WvjtaSW8keI7PKfQtvmk7uxKhZo1yeLTSWy+pgrW80dsiQi+cAodnBI4pm+t/0G1OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HeGGuWC1; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HeGGuWC1"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8ca3807494eso53239185a.2
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770224108; x=1770828908; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
        b=HeGGuWC1fQBTG0lpEEEr/gWuYCP68dbDZzZembJEiU8IrCCHn/TdHCh3vzu6FNQg3c
         IBQ+zqqBPrTJPn5kh0xA/hhag/8/BJ+TJqhhTkqOYOcykvkvDm/pvgiROywYe0201VyH
         e+WxMZygsPXg9s6iDgLpdCvxyJIHPiowgaYPtCebrM6385xc0jSgXSoYYRhrIf/pFteq
         eg1xiVG8JoS2SZXNwwQ2lrLWYBvqz2tOmv+/mVmgJRE6/CbDy/bXOTKoPC+DIn2hc3m6
         usGtKMDR9vbQneB6NxFlGHUho+/f4teigcB4XN7oUGHKTJFYXiBLe6KyrBag9MxG2BXn
         6D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224108; x=1770828908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
        b=NQpg+GA5kTG4hoGXNG32460AVvkl4nQAif4Heu1yuRnKcvs14na3SeasSL6v5TK4ff
         /rmUkPmp+K5YRKbJ+mg3nsw6gF/cmM8rltUF8jjwjS2ZKDDxjgkmxSi9tNuCZrP39gPy
         BYbLf96G29jP5+B8vAvlugGGy47W1+B4BnpyZ/aahNZxBN8CZ18suTr+2G1KzSAcNpDN
         /sJWXJPAuEuDrAwlhRtEGb+q/RFkrCUa1HbKE+Gn0qwlv/6J6uPeZtTSCMY35/AKRMEg
         M3oFj3ltsnYPyc13SFE3AegXKwrMRZvrKIwMyNQeTz0OD6uoJk/RukZ58GyapZVyTtyi
         bqdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5q/wz8Qrl1CfswkbysVuSCnE862t2yCQYWGGtnGhgOI57QTupYQQvjOLhmMLhEm8n/7cwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy12Ma1n28r9XVIS4oohU5DpbYNAgEbxzRe+XJKwECUqt/iiRxH
	mPJtdDzPguhBef1pc8n4FomuC4tKNS4ORjBcF35d81h2NFNRAucUH8fT6GZgjGsyqzs=
X-Gm-Gg: AZuq6aJE0Zgr+gqeWd3ToBUD0CNDVf/F1GjUzJegpA8SgFwKdo/BPSZzRw1YcnqgsGK
	GZZdtAZrws/1NGS3qD6NYljdcA43vIUbXLmJwNe9GQ2ahyQLggsT5wKf0keh4ANeeUkM/4gzTJa
	FP7Ns7LsrbQctPnG6YKnAaMXT+Uw+BUtaP61WYgpL1WGFk2yzaPCNvmBoknOOvFAV9gkVKHuUWF
	OfUapXJ72P9+oGPxPkF5n4GFzitNPHnTjIDx6BlaLRByC8xTgf4HV69T0ssO+T5vtvAMWtl5ch8
	v2YGeUoKYcd6qg0RIwMTwJe+irkwB9e8dz+p9yPlfiIQFtzRaJ7LnhjFP095AmHPSXHMxWK0FOG
	hwnFkHd3ouM9RD2+X4ZUBrancBfDv7w6mcKy4E0enVZJzPeo0c4RPNTK9Dzqp8YjQkXAfP7/XBO
	juoFdDmbcTg/QRuMXSVVbuppwFdNw84+oC0f5jAAdAfIh/NlGkzqg7A7uFpwI9l3coPAE=
X-Received: by 2002:a05:620a:4627:b0:8c7:177f:cc17 with SMTP id af79cd13be357-8ca2f9bbb5amr467025085a.46.1770224108469;
        Wed, 04 Feb 2026 08:55:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2cfb4sm226461485a.33.2026.02.04.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:55:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vng9j-0000000HH15-13rk;
	Wed, 04 Feb 2026 12:55:07 -0400
Date: Wed, 4 Feb 2026 12:55:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260204165507.GH2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>

On Wed, Feb 04, 2026 at 05:21:45PM +0100, Christian König wrote:
> On 1/31/26 06:34, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Till now VFIO has rejected pinned importers, largely to avoid being used
> > with the RDMA pinned importer that cannot handle a move_notify() to revoke
> > access.
> > 
> > Using dma_buf_attach_revocable() it can tell the difference between pinned
> > importers that support the flow described in dma_buf_invalidate_mappings()
> > and those that don't.
> > 
> > Thus permit compatible pinned importers.
> > 
> > This is one of two items IOMMUFD requires to remove its private interface
> > to VFIO's dma-buf.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Alex Williamson <alex@shazbot.org>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 78d47e260f34..a5fb80e068ee 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -22,16 +22,6 @@ struct vfio_pci_dma_buf {
> >  	u8 revoked : 1;
> >  };
> >  
> > -static int vfio_pci_dma_buf_pin(struct dma_buf_attachment *attachment)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > -
> > -static void vfio_pci_dma_buf_unpin(struct dma_buf_attachment *attachment)
> > -{
> > -	/* Do nothing */
> > -}
> > -
> 
> This chunk here doesn't want to apply to drm-misc-next, my educated
> guess is that the patch adding those lines is missing in that tree.

Yes. It looks like Alex took it to his next tree:

commit 61ceaf236115f20f4fdd7cf60f883ada1063349a
Author: Leon Romanovsky <leon@kernel.org>
Date:   Wed Jan 21 17:45:02 2026 +0200

    vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
    
    Some pinned importers, such as non-ODP RDMA ones, cannot invalidate their
    mappings and therefore must be prevented from attaching to this exporter.
    
    Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
    Reviewed-by: Pranjal Shrivastava <praan@google.com>
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Link: https://lore.kernel.org/r/20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com
    Signed-off-by: Alex Williamson <alex@shazbot.org>

The very best thing would be to pull
61ceaf236115f20f4fdd7cf60f883ada1063349a which is cleanly based on
v6.19-rc6 ?

> How should we handle that? Patches 1-3 have already been pushed to
> drm-misc-next and I would rather like to push patches 4-6 through
> that branch as well.

Or we get Alex to take a branch from you for the first 3 and push it?

Jason
