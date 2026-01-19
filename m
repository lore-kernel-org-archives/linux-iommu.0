Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DB26E6E8
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841927; cv=none; b=rBjIxIz41MYPTybbtkzsYQP1Q/x/zayizxZoTDfVzb1zSmyjWC+ys7TwcJqJHLZDVs6uUd7g+BMWdfTkzWWd91qQV2EX3P9DubXTg6kxcveLVSWWu9L6HCJeSZB26AZGkSrRiO4Uz+6mWHAv/BvEOeb9qL1c3uIk4JAZNn5mCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841927; c=relaxed/simple;
	bh=nsqjKuZBX2xVAZ9wDedc6M6Km3uKRKGPzdUMml50yUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZ740WU52A04hPtdRYekZNX7olBhc163OG2+uoAedvxv/jvf1ozWYUn4elJLBxNVJcGyMS0V+svDYVem397DayhrWC4wRaklyTy4BdY0Wm8GOoUSwUUqOJLoN4X7ErnjhW9UOyK+TdVpls7Xrza2RyxnvmAq7TmxMuQFUF1iCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uw05Wsf/; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uw05Wsf/"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a379ca088so38126316d6.0
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841925; x=1769446725; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=Uw05Wsf/Lc8IguIUTL2YD/c5r+Q2RvrG2Bc/Lp0rz3o5BWVspqfLA8gdH49QhZz8zS
         TUBG0GQEN7yFe0sijHdZg/PdiJQztbudTQE4HJo9uuEnkUjSgeedstsxRsas0lVcP9IS
         5O/aute2UfGVpUnkey3ubXo3Ks6QRpF6PAOhKNFrs+kvszqPSePBK4KbJHFafdWhOTJW
         5mco/3yq5O6cqm56AjzGCs+wMyPfFoQMlSOod36XbCjDjSPbDti8sD7D5BT9w6qxpHA8
         GTihGLFgh2PmazMbBPX3S07wHh83Q0RAjmnhtk3Jbc6WQRVl6LF+8tfLmh8vrMlrM75M
         4SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841925; x=1769446725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=kbyXaG4YOBPp3ZRAWSeauoOCicNwuLOGB5hYvYo33PL/JsTotLqkpHuHGpE1xTNje0
         00Z/G6w5tXFXXgay+GWgmZ/x7+9oOwhvgFSoj3bCOzvWfSk94JG61nZ4I136YZ+VeGnu
         zs0jr4ncVnHs0yu8XZjeb+oe5Q64NMRmeYTA92b3P01scEBqq+sfhwmstgZRzIgZHSXl
         BwJ5r4C6bbqLf31d3tpN0rUxiAOjBlw+Jt92N0FfmbAHF6nP1cslD85m52QKm+9kbCFG
         yz6KZ9KBJinODCk5ZOGQIi+Tl5TwCWOL0AghqcwDuFtqCPM3VNUxA4STmMt4T9UNrIwe
         RAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXmrso4CrXcog8t4kYwaqT74+qfh0+ajH6sB8WalGRClRDdK0E7/E0rAg56KUnf82ku9aOtUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQAyrhmq/QD0o792PWv2IY8aViRfKxEimms7rHhsrRg3bVH+UA
	OvU99AF1ChSf7deXUxddRisuf7K/JAYxhYW22WRVYtnZTetunFI37+4hu20k0I3xgn0=
X-Gm-Gg: AZuq6aITR3zLasaywhCTH22RntEFrrfIfIXtfx0yMbkdUonEjkkmGy5ZxmWfZmKQGrf
	0Xdv0yspgfuPgvy7lmL57cHP7VRfRMgAx6jx9I5ZX8Wd7VjA59fD7Xvc3gKRcaJniXpX42iNDxx
	wBN+Qnv33Z1EgjrGWsG+yFCk2K1o8U0LH7M6c4ivAp65oawyVFcXlE7RqgF+oxgEdYwrozwvOR2
	Zy8RkTVn08h74caDcD4rGhDLY8xO+U6XtakxSp9wvxGIuhCLTIpeRiyEQOM3+dsHBv/oxmYpZqa
	P1rXNSFrzobpywzP1jO9shfbHCe2fepBEiyB+FQvWnXvdfdSN0jEvPoTz041Pyo11VCw4s68HRI
	Q6NRmzx7iG+BHY40zLGyQaP5mtu+v75QRNTOXYxu2g3EFFRUtauEhrcS0dC0SLHMZmAMoBkkhoT
	Q+DgCM5MK+6knsxKl576sh1jGc9SGyEPjWcsaecW2gcNTA8UuChDCR00isRMD/0WNHUPt8kD6zZ
	TvDhg==
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id 6a1803df08f44-8942dd9e90fmr129930286d6.57.1768841924690;
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e526dsm87021366d6.12.2026.01.19.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsaR-00000005IQb-2Wqn;
	Mon, 19 Jan 2026 12:58:43 -0400
Date: Mon, 19 Jan 2026 12:58:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
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
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119165843.GH961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:44PM +0200, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Changed series to document the revoke semantics instead of
>    implementing it.
> v1: https://patch.msgid.link/20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com
> 
> -------------------------------------------------------------------------
> This series documents a dma-buf “revoke” mechanism: to allow a dma-buf
> exporter to explicitly invalidate (“kill”) a shared buffer after it has
> been distributed to importers, so that further CPU and device access is
> prevented and importers reliably observe failure.
> 
> The change in this series is to properly document and use existing core
> “revoked” state on the dma-buf object and a corresponding exporter-triggered
> revoke operation. Once a dma-buf is revoked, new access paths are blocked so
> that attempts to DMA-map, vmap, or mmap the buffer fail in a consistent way.

I think it would help to explain the bigger picture in the cover letter:


DMABUF has quietly allowed calling move_notify on pinned DMABUFs, even
though legacy importers using dma_buf_attach() would simply ignore
these calls.

RDMA saw this and needed to use allow_peer2peer=true, so implemented a
new-style pinned importer with an explicitly non-working move_notify()
callback.

This has been tolerable because the existing exporters are thought to
only call move_notify() on a pinned DMABUF under RAS events and we
have been willing to tolerate the UAF that results by allowing the
importer to continue to use the mapping in this rare case.

VFIO wants to implement a pin supporting exporter that will issue a
revoking move_notify() around FLRs and a few other user triggerable
operations. Since this is much more common we are not willing to
tolerate the security UAF caused by interworking with
non-move_notify() supporting drivers. Thus till now VFIO has required
dynamic importers, even though it never actually moves the buffer
location.

To allow VFIO to work with pinned importers, according to how DMABUF
was intended, we need to allow VFIO to detect if an importer is legacy
or RDMA and does not actually implement move_notify().

Introduce a new function that exporters can call to detect these less
capable importers. VFIO can then refuse to accept them during attach.

In theory all exporters that call move_notify() on pinned DMABUF's
should call this function, however that would break a number of widely
used NIC/GPU flows. Thus for now do not spread this further than VFIO
until we can understand how much of RDMA can implement the full
semantic.

In the process clarify how move_notify is intended to be used with
pinned DMABUFs.

Jason
