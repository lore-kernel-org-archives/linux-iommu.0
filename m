Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352660253
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529930; cv=none; b=KPZA4i7VIcLgeSwBILfbb1HEfHH5vZsGH8NswbkoijXURgpoXaiWekcy3/PlBp2JKU5xuHG3vlT/4/Mfq0EgZIBb5T8D/zCK8ntxHyCHphg38XraRzZ93WNmSw0CMVgvw2e9Xm2wehdKPe5CmOno80R6yxwXZMGWfeAdiJGwkgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529930; c=relaxed/simple;
	bh=fe7fWuR8CZcckqpXBcvwxnGl25xTfb4ZA+w7PhvWzjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk0bn3dqnNRy2eFmQ8gANyHCJPsDMP/W2T6l5d6rBupbg9GorwvLMbBgG4oxPGlbzkENF5maBGV+Tgjr8Kq9LulfMBUtzj05SgCsAmCVGoL0J3uRfUY1QZ5DhqNqt6TYm0zsmcVWr8N6blIs2ZAQ2cXvrB8DwS1JMobAO3TjiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=i35PccJE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i35PccJE"
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 538A11803;
	Mon, 29 Jan 2024 13:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706529842;
	bh=fe7fWuR8CZcckqpXBcvwxnGl25xTfb4ZA+w7PhvWzjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i35PccJEFHeXR9FJe6HRoq2FHZwexbE7G4k7+MMsEuYkoU8tY9U8nVmesgF5JN0SM
	 9qy+y6rUK4z1lXbif+37pJUtUzTjWHmEINuCbXd9q6Xm0AwN+ajVE2Amf9lPmCoDEw
	 xB9rPr2BRV8mAGyM7zACIZ31L87PqjmSzCMaf2Lk=
Date: Mon, 29 Jan 2024 14:05:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@redhat.com>
Cc: Lucas Stach <dev@lynxeye.de>, Milan Zamazal <mzamazal@redhat.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, kieran.bingham@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: Uncached buffers from CMA DMA heap on some Arm devices?
Message-ID: <20240129120520.GA8131@pendragon.ideasonboard.com>
References: <87bk9ahex7.fsf@redhat.com>
 <d2ff8df896d8a167e9abf447ae184ce2f5823852.camel@lynxeye.de>
 <rhfec3v57xeoliukqxaives3uerb6phbxphgcua6mvxkdnzrzr@xm5zvoevxf4v>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rhfec3v57xeoliukqxaives3uerb6phbxphgcua6mvxkdnzrzr@xm5zvoevxf4v>

Hi Maxime,

On Fri, Jan 26, 2024 at 01:17:50PM +0100, Maxime Ripard wrote:
> On Thu, Jan 25, 2024 at 12:41:01PM +0100, Lucas Stach wrote:
> > Am Mittwoch, dem 24.01.2024 um 19:27 +0100 schrieb Milan Zamazal:
> > > Hello,
> > > 
> > > in the libcamera project, we experience a major performance problem related to
> > > DMA buffers while working on camera image processing using CPU.  This happens
> > > only with some Arm boards, we have observed it on Debix Model A (NXP i.MX 8M
> > > Plus) and PinePhone.  We use /dev/dma_heap/linux,cma (or reserved) DMA buffer
> > > heap on Arm.
> > > 
> > > Reading V4L2 camera data from buffers is very slow.  When we memcpy the data
> > > from the buffer to a malloc'ed memory before working with it (reading each byte
> > > multiple times, without any big non-sequential jumps across the data), we get
> > > more than 10 times speed up.  It looks like the input buffer is uncached.
> > > 
> > That's right and a reality you have to deal with on those small ARM
> > systems. The ARM architecture allows for systems that don't enforce
> > hardware coherency across the whole SoC and many of the small/cheap SoC
> > variants make use of this architectural feature.
> > 
> > What this means is that the CPU caches aren't coherent when it comes to
> > DMA from other masters like the video capture units. There are two ways
> > to enforce DMA coherency on such systems:
> > 1. map the DMA buffers uncached on the CPU
> > 2. require explicit cache maintenance when touching DMA buffers with
> > the CPU
> > 
> > Option 1 is what you see is happening in your setup, as it is simple,
> > straight-forward and doesn't require any synchronization points.
> > 
> > Option 2 could be implemented by allocating cached DMA buffers in the
> > V4L2 device and then executing the necessary cache synchronization in
> > qbuf/dqbuf when ownership of the DMA buffer changes between CPU and DMA
> > master. However this isn't guaranteed to be any faster, as the cache
> > synchronization itself is a pretty heavy-weight operation when you are
> > dealing with buffer that are potentially multi-megabytes in size.
> 
> My understanding was that the CMA DMA Heap is already allocating
> cacheable buffers,

I'll be a bit pedantic here. As far as I understand, the CMA heap
doesn't allocate "cacheable" buffers. It allocates pages, and they are
not inherently cached or uncached. Whether a page is mapped to the CPU
as cached or uncached is a decision made at mapping time. Unless I'm
mistaken, the CMA heap maps pages to userspace cached.

> with the expectation that you need to call the dma-buf cache
> management ioctl. Is it not?

Someone has to manage the cache, yes. It can be done explicitly by
userspace through the dmabuf sync ioctl, or implicitly within the
kernel. For instance, when queueing a dmabuf to a V4L2 device that uses
videobuf2-dma-contig, the QBUF ioctl ends up calling
flush_kernel_vmap_range() and dma_sync_sgtable_for_device() (see
vb2_dc_prepare()). videobuf2-vmalloc, on the other hand, has no cache
handling, which is a known issue when sharing buffers with the display.

On a side note, the cache handling in videobuf2-dma-contig.c seems
problematic to me, as vb2 shouldn't assume much about imported dmabufs.
It should instead use the operations exposed by dmabuf to delegate cache
handling to the exporter.

-- 
Regards,

Laurent Pinchart
