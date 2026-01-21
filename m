Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0C2D5C74
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010002; cv=none; b=EQA3Gg4/WU7HlFJmOtVX4SGkPCFRBhGqcBJSDK0ceNA7erJxJSM+X+IL6RrJ4eEY50iEpwqLfNQzQOtiPPmDXumRlBH603FhJOghv/g1C2Q6zykAIm3/gbj8IBoiiLFnXBbeKPPQTRbhN9SphOH6oBoBUc46/t+I8UYx+9E5PLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010002; c=relaxed/simple;
	bh=6/tSgLR7J3UgafXRAX+XBEPxIV3H81+kUIgU8b8gh7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oowbIm9WhV2sjfL+EWF9j7i+Yb3ReMl1DVjzU6obuAt4d4i7mmi7Hef9Im7RjgEQV/AE11HPd1xtJazZvHp2Knd73IxoEYyNDHTdg8J0Q25YGi4RtZHviaeXTCazedAMdqvJe9dYHGsYFtcb/6Bx8aP6ckmVFKdfsP5ncKGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXA4LEGz; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXA4LEGz"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-89473dca8aaso343046d6.0
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769009999; x=1769614799; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
        b=iXA4LEGz5fsD2Eu9JKiw/1gGTfcaXvZsVKDFmPj/ELmcYytwNcpZpl8y5V3+T+enIq
         NtPuI0X0k5sFAjZUkYi+4Zd9q4hBpdPEgj5qEJpQzbpaGVfebFAm0dw3ZD8CRtIY69Is
         YSAEJTXR9/rAN2Ahmk0+ltOiGVz5PyDdhkx8Qn6BQU2kbjg0w0ySOdwGZV/RLvzu4Km7
         hh/zHg9/k58jNCgiZL9TjXT2B7xicvJRKC2BZBFSjFLuqxZW6H7fTGrb6GViAhlOVXP4
         8b5xpzqmjGmDBXY6POP6lvnCnkKxhKkN4khjV7nseg8WiU+CwsvP2OdXiM8IQB2AB4UI
         0TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009999; x=1769614799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
        b=cxkCeEpTjRqs/Grp75MJVOM3Z3aw8+eNG1VUJMJhouE4GHEvRS8PxHawxA4WZ5Ib1E
         6P9dM9hLLOuoz4cjowYk2Td4g1U/wB9bHHC4Ids3W8orjt5tgZcsg6Jw8jENzocgNtyk
         W51C2zfXT+X3KhGiAUAbzLYwdbuqsrGEfRMplpUI1FtNYrwStT07T+Ch34CTkeK8pRwt
         ThYMkrjUhnjE8YtX4wdbYHrUCqXSHdoaDq+4qeoqIew5dZ18DGGI/r91AF/7o5rKERS+
         iFsIZaUElFa85Bi8ZS5533BnTwKthnrXL2MIQNdTL4wSAFCGXybALdnbD7ywv4vT6E0U
         XdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7B87rrrXIv1wJzeEq8jxAIO4kw1Hv8u4EBAWRU6uYMoWZzgNs8N32GEgCpSl3NZXPDJ49ow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg+QOsRcKmnfLRPFlqPquOhxgecajQwzcx2HMNbTfQzOPyNrbY
	1Txhu8ZMj8YwH+PTkl5s3d9DTqO/6NDT+Yw1eKrp2PUwSfPezDsgbcSk6vRJltJmf84=
X-Gm-Gg: AZuq6aJSIY8GltJMn6kWuAp7hpnB7ZRtxB1AZ55nTjOpVOwbn+Yfr918XFkRf+vOxPb
	euRo2vsb04uU3WC2gMIAReNrsLHKYjcAC5c3b3H8ZC6ECCQgHwyT+wFUe1RW/lj1dz3LsUZ3Eme
	ETVgo85CUJUwKQ3P0jcu1MdOn9m3T3+G1t/rkGAyY6ieiVTYIuZAUyiGSE8BTYy3KhSb+At70ZU
	AVeFAIXZpqotDRNlYN3PY/8aav+yTHvs5TSdp4Ta/AXyPfFIBMABkchNx+dLfA743EwCPpuTV38
	s49MarWJoBsdSx+aaCbnFgbHJR55xdSCsKki/tmr9trGFAH9i4d1EOEOoJp1UNdQh1Ylh+w3YS5
	DS8OqIrhgEG2hVfTcDKPGNAVXRxm+DDSdatMlRPV+m6fjtnOk2BjhQ3YcpIYt6QBlefCVOSOFri
	EG2I0gIed7EHDCm+bWWrpkb6fGrYTSik7ZB1lhWUptI3aK1OvssU96DK64xqgG77Du2wg=
X-Received: by 2002:a05:6214:469b:b0:894:3cde:f81e with SMTP id 6a1803df08f44-8943cdef85amr237172426d6.41.1769009998640;
        Wed, 21 Jan 2026 07:39:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894592ba642sm58791866d6.57.2026.01.21.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:39:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaJJ-00000006EiI-13u3;
	Wed, 21 Jan 2026 11:39:57 -0400
Date: Wed, 21 Jan 2026 11:39:57 -0400
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
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121153957.GC961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
 <20260121131852.GX961572@ziepe.ca>
 <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
 <20260121135948.GB961572@ziepe.ca>
 <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>

On Wed, Jan 21, 2026 at 03:15:46PM +0100, Christian König wrote:
> > And let's clarify what I said in my other email that this new revoke
> > semantic is not just a signal to maybe someday unmap but a hard
> > barrier that it must be done once the fences complete, similar to
> > non-pinned importers.
> 
> Well, I would avoid that semantics.
>
> Even when the exporter requests the mapping to be invalidated it
> does not mean that the mapping can go away immediately.
> 
> It's fine when accesses initiated after an invalidation and then
> waiting for fences go into nirvana and have undefined results, but
> they should not trigger PCI AER, warnings from the IOMMU or even
> worse end up in some MMIO BAR of a newly attached devices.

So what's the purpose of the fence if accesses can continue after
waiting for fences?

If we always have to wait for the unmap call, is the importer allowed
to call unmap while its own fences are outstanding?

> So if the exporter wants to be 100% sure that nobody is using the
> mapping any more then it needs to wait for the importer to call
> dma_buf_unmap_attachment().

We are trying to introduce this new idea called "revoke".

Revoke means the exporter does some defined sequence and after the end
of that sequence it knows there are no further DMA or CPU accesses to
its memory at all.

It has to happen in bounded time, so it can't get entangled with
waiting for userspace to do something (eg importer unmap via an ioctl)

It has to be an absolute statement because the VFIO and RDMA exporter
use cases can trigger UAFs and AERs if importers keep accessing.

So, what exactly should the export sequence be? We were proposing to
call invalidate_mapping() and when it returns there is no access.

The fence is missing, so now the sequences includes wait for the
fences.

And now you are saying we have to wait for all unmaps? Not only wait
for the unmaps, but the importers now also must call unmap as part of
their invalidate_mapping() callback.. Is that OK? Do existing
importers do that?

If all the above are yes, then lets document explicitly this is the
required sequence and we can try to make it work. Please say, because
we just don't know and keep getting surprised :)

Thanks,
Jason
