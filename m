Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D3D9050
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125456; cv=none; b=hHeL7B1uzj0bkV4zdb4pZFL9qcBFvUXV+K7cq9DYgwCBMWE0be5z57Lh9/J8Jo04amkUNgGeo7BlDEtUqpNfSLkcdwLnZnajA+orIvbf4uNsmAjLfpnnBtYim2IkrMljn1fsu3CE8JkIIrwQs12fgbYsFcmAY3Ujt3JJehJu4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125456; c=relaxed/simple;
	bh=tD5f+h84ofqnK09ZH5j1acZDqC2EpodfEzB0D4Jj1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoFz3xiigg4CsFVy8+x+qxowMOJRh+U27mT+/oca1A5tH+u6iEVs0NRJL5l3/XTCmikminubg8lURChv/e0uJ7OvB3D7pIx8Vn9vxgknqikwKHQN51sIjxNoaLbQunk+X9kdaGISDafQVNQuDom8Ddj5ARGJqAvfGrduYMkjMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QaWjTl2G; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QaWjTl2G"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-894703956b8so24751206d6.1
        for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 15:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769125446; x=1769730246; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
        b=QaWjTl2GNlmqM7AA3iQDtHNOQnxRwDeNgeisoyFAlSa41uKV2oCHE/C1SKVqa3ldRN
         d3K8LsS/SCL3rKF7PgttV2xHEFzVvoj1BC+WJi+6X0m0FpVyl7eGHyRTn3VWJ7+MBeTe
         EVQ+lXtrtPEj/CFjy8uKnfwZbgE5VnUM5bL6la2BbzbkGDWORjHQjKeQ5RCcNbPTfePl
         35CiTTZwGuHCTuZ6I8Ugw4sN1ku1F63ualVuEaIZlBTa6alhG+mELDueTI27/HFVFzSj
         vwiT4UexK9DxcwDTmeQVJH/IU0/mF8MApqCT4CE3Gv3f2hJN6Q4SVHWaMTtVkhjOAvhc
         gocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125446; x=1769730246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
        b=B/B9fV6+1UncvmWucvAxuNK1GyLU/RAxu5wuhBpb1y3wm7V56uUWXHbTIX0I48mNWs
         BJLzJaCp31ALGCy2zloGizoCyJfzYtIsfE/sayA/ZrvVbmQ1iXHFG2PXJUkNLXbGllex
         hLn7hbtYIv1sk3tXKkRJjtWWCDncPo9mY6Q4i1XfqdDqDNIRrU443mvtT4tGPSBs32o/
         FlXJd6dchqKuHOtfTO0jCdbPFErpf1XBeGH998WPLmdyipTgJfnwuVMFm60deikJGxb/
         WrhkqmxIdYTV5C1e9JpRJI/voyw5Mf4b1NgaiTmehAolaTg634cFEdl5SW6lp3zeNpKY
         DR5g==
X-Forwarded-Encrypted: i=1; AJvYcCXEwUUKVgD0ICiG88cZ9pXoqwey43+AGAuo+FRKd9U75LhMwji12YQToWge9Hxgbi7vBm0F8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVztxl4PasFTXvIIY2zKo6fX6YA8xsOezyrjdyKMNp8aZKgZ/J
	GZINMaGYnznW3QzYjKhwsjiirUpPpVXslEws6yDps+17buhptqeBPvTBtVcE106/0N8=
X-Gm-Gg: AZuq6aL2CHLrxg3D/7hMkIIdNwvBRBnPvI1KZSZhfma7PHJwbGSpZYrcMa3IGpobcIX
	S1QzGyETQQ9Nkul94AwgLxNWBVbC2gVxJW9VnFq70Xmdbo+ihq1gVQ1ar1Fvi+jdyV8m8rVh/u6
	u/34qRzEmq6OmeqgNrYk5gdKnUA0X8iOa85JD3DBOj2XuIJqZHqaXkDbveF2duJwBayudfcPafv
	QFNhSnnxhL4kMtFI8gDwwbLHBE8vIAgu03RqU8VTNlMsetDFXaor1wBoseVL4aeg3KKip77RTCt
	8NFimEVi1zKgltfWGVlSZMibX1APC2X6CfkpnWjwGlA3uH0Vyr+YZ4RYaAbkQnPHcCy4wsr9hjN
	ybca5lophaO9Tl0MAoq7MARVrg2sbH8FnV9a6lwIpr1jckCeIPFUV4rEzX8qYRp43uzXB7pp/xv
	q121VEHg58eSuDqJB+mXlWbakbbSUI1HT6daAsfYRnNE1tTMs7/Q4XEy9uOTnSj+l2ZJg=
X-Received: by 2002:a05:6214:2269:b0:894:6530:efd1 with SMTP id 6a1803df08f44-894901ac85dmr20677696d6.19.1769125446269;
        Thu, 22 Jan 2026 15:44:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854a6csm44128885a.41.2026.01.22.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:44:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vj4LM-00000006gRo-0Lke;
	Thu, 22 Jan 2026 19:44:04 -0400
Date: Thu, 22 Jan 2026 19:44:04 -0400
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
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260122234404.GB1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>

On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> >> What roughly happens is that each DMA-buf mapping through a couple
> >> of hoops keeps a reference on the device, so even after a hotplug
> >> event the device can only fully go away after all housekeeping
> >> structures are destroyed and buffers freed.
> > 
> > A simple reference on the device means nothing for these kinds of
> > questions. It does not stop unloading and reloading a driver.
> 
> Well as far as I know it stops the PCIe address space from being re-used.
> 
> So when you do an "echo 1 > remove" and then an re-scan on the
> upstream bridge that works, but you get different addresses for your
> MMIO BARs!

That's pretty a niche scenario.. Most people don't rescan their PCI
bus. If you just do rmmod/insmod then it will be re-used, there is no
rescan to move the MMIO around on that case.

> Oh, well I never looked to deeply into that.
> 
> As far as I know it doesn't block, but rather the last drm_dev_put()
> just cleans things up.
> 
> And we have a CI test system which exercises that stuff over and
> over again because we have a big customer depending on that.

I doubt a CI would detect a UAF like we are discussing here..

Connect a RDMA pinned importer. Do rmmod. If rmmod doesn't hang the
driver has a UAF on some RAS cases. Not great, but is unlikely to
actually trouble any real user.

Jason
