Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979EE3195E0
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781681; cv=none; b=lyldtW7Jy4HiIF0LkqLmHG5sln6gXiFfnMfurb10gBVbjIVORSUucJHNvcX5BUrBx3tKjXIqOMS6XsQuben2vUzIsnBPAiC5UZCKA7juIZtwekCo1PWi+V7QG4I+Z6wyl0CxJvGVrpMLwGR8dvyZ+ft+69mWVnnZhQJntjI5WzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781681; c=relaxed/simple;
	bh=B2BjUDXErJP5w+VRNup6GLKty66RY3PW3GzWxgahGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmN9hKa3HdrWRdB9Lm5gvCyJ0hQCdp/kJM88R/7F2ws1n6xFd9cMTV5lya2t0Ux563MCq7ycxLRWpLPrG00vKu4AScWZbJ6fjuZQbA2eoKi2YebQOQWq9wDVUMk0GgI2EB37sE4UHJ7myNNTrYQd1HvRORSc9to2jtiQD9olx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BCBE4/hS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BCBE4/hS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c533228383so134623485a.3
        for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 06:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769781679; x=1770386479; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=BCBE4/hS6fo0DTZ0gzevSQjor0Ne4XLHYsu+UPZTmGQvCEsrYCYVIgEmBl1I7UMS6r
         mdCnVp194MEbJn81k/kYNRLO4W9NlAG9UGDfR14JOwzAGgHPzlzKoRcvEysQCNZgH6l4
         q1IF33NbEomgpA/SDRLy1VlIrGPn9HUS5ai8TZOsHayTvcQo3V1KiOP3xHQQinxoNyy+
         evrPai0k8QN0NpPN3dYVg/qF7/gMVllK/ZvQTwaQrCbcQyyNM2/TS9x4MmastcgTkTAZ
         J5KHI4BuV3Tb/b+IQMWIb+kmE0otr2frE/gYcf4wN/1SLUl52+8HOZOja7ynLRR4dDJN
         qX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781679; x=1770386479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=F3p5bp1PXhVGJxNlDaqqgAXGBw0q+YFyWQNOIA+XAYKPp8am9WsZ52s1ZQWiNcVz0f
         42a9YYK0+vLibIBo8trLXahxBHD5XmwQPPIwHvSYUg93MsbAxQ6sfH2h3d1wDRkXrN4P
         fNyb+PUQUq4e+t7iCcX7jry8wvNrTd5WloochPR5OD1vpkNQcfseNrlvOzlZLZ8Szxug
         4PkytuCfdDDHIgR1q8zpcDm0Dq3Y/Rxx/YPIwaFpTg6lp6wjn2v8WG130SMrDrnen/jX
         ve4O7i05YZEe9lQ9YKDXa6hPNVdvYCxAuNFJ8n2qPrgEiwfRx9BHNJH7sPLJyrRtHgtN
         unTA==
X-Forwarded-Encrypted: i=1; AJvYcCVnTTiyfscHGiRtEtqBTRd2bcHn4oCsXnErYEw0Wh2J7sdetXUoaMJSJ4IuhKmp6j6atU0p3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAMlSz1JockF8QsLMj5cQTck3UrtxAoVcNR8ClzYwH4r2lzNFJ
	H49N3vgrJSFQ7hesiXn2v9W9dEMeBSPgfGwtHJfPubp3yIUtlUkDXb4XOv92dABiA8Y=
X-Gm-Gg: AZuq6aI0s4xHHxv9OBxkD07UrTKR7hxSwobuhB0Dxa//Oin2dryHU+WcUPg5SUuV4SB
	vXZFPkMUdubDZHg63+XLGA7g5fE0eSWekRqIa8nVMEKUrYT3TMs3IbRD3Js2plUdU31UZkjJPzT
	E64g4+g3sNe+sHyvPrw7gLwIZtgOb0xhquLw1SjP0YpGMnDfSf/Tb385tDHRTlTuJuw21FdMKjO
	4L7TjwlnWV24/dOUECCrMmgReKw6OltKyLF/BlcSeM4uaN0N4H/BhMkbru4qETeYmLH8nWPMfX/
	PREHnm4iJZxC95X7BkSkfwlSK5V+hzUvOsBoP0e+n9gveFY7ZuRBAqs8Vccmy9bOYUjtemr3G4d
	frs4qbZLheaXf8GrzqxXStGGDHyP1ay0FBLWFpfXuRR7Txc+BJKqsTvmLbZ8n8J3U8DWhGXxJqI
	3I4BdXqTq8gkV2+dadtCX/WlpHdu3WaaDOuAyf7knQMs59FSnfcYgM5th4Meb3snOXT6rzsNgFv
	v3tng==
X-Received: by 2002:a05:620a:290f:b0:8c3:650d:577e with SMTP id af79cd13be357-8c9eb224827mr368793585a.4.1769781649371;
        Fri, 30 Jan 2026 06:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e4esm700915485a.15.2026.01.30.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:00:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlp3H-0000000Annc-1AWG;
	Fri, 30 Jan 2026 10:00:47 -0400
Date: Fri, 30 Jan 2026 10:00:47 -0400
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
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260130140047.GD2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>

On Fri, Jan 30, 2026 at 09:43:22AM +0100, Christian König wrote:
> On 1/24/26 20:14, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Some exporters need a flow to synchronously revoke access to the DMA-buf
> > by importers. Once revoke is completed the importer is not permitted to
> > touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> That approach is seriously not going to fly.
> 
> You can use the invalidate_mappings approach to trigger the importer
> to give back the mapping, but when the mapping is really given back
> is still completely on the importer side.

Yes, and that is what this is all doing, there is the wait for the
importer's unmap to happen in the sequence.

> In other words you can't do the shot down revoke semantics you are
> trying to establish here.

All this is doing is saying if dma_buf_attach_revocable() == true then
the importer will call unmap within bounded time after
dma_buf_invalidate_mappings().

That's it. If the importing driver doesn't want to do that then it
should make dma_buf_attach_revocable()=false.

VFIO/etc only want to interwork with importers that can do this.

Jason
