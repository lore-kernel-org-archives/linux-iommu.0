Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BBF49B458
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996144; cv=none; b=aEmBzqEYqfLehe9m1COppG5x95fIo/xZptUUrwSQ+XlthJ70pbCcoey71Bh3PKFenosAAdj6BqpVipzbTcYqxoyb1Bu1VVO6bfg3dvmtktf2+W6l0azcIVrbWY1cxFKsRZG+m/tcf56MtqiRDVe15fuo3qNvvBd2frDMQxQZXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996144; c=relaxed/simple;
	bh=7iRzAcHHARKyQ+ATaMDpW4DruCrP6jplXNxnuj7OqwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW3twCjgUv3cg+6eMoBGPKMQb5u39H6NKGV8eaJmxF2B7AncR+nC3GbDRV2SeAso3HjfIaL2xOWoIMd1qcZTeSThkEcprKMgAql2SO2iw0e8GZUd8PTZJg/sOuS/X/gIm+SrZBOcxiqTStM7S4l0b02A9kZTiRqAF8t79rGQXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eHT4Tb5w; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eHT4Tb5w"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso2635973d50.3
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789996141; x=1790600941; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/I4CnabOFJ3V+cBV+khghf4ltJkhcHX6gZAKyxfIiuU=;
        b=eHT4Tb5wlXNEkIzqACwF9nllEFBlLAjJM+Czpbr9WyiO3D2Bu6KIWLF4S2SBhiYWGC
         b3V3sBqWUC3AZAdz/KsdnCAx4GhyJWzYuqp+Qzl8WTpd8tCKXYeGpHwWhlqCfB3bNMt9
         K0/VakN/gdRWL+QOKW5Y+3PHrtovYq+KgkoynAZlUESGVwkY0jsxDFIJQPotE+r9gvBG
         dec4DYhDF2W3TIR0WTAmm82Ktx/OLg+SEODSwbbwbWJGV1bP9EtzqsIE8YDgKBG6tVmp
         q61UQV9GCLBcew4ingXl4CrXvN7hhyJSfAb+GOvhRYBvApkTO/C35IAaljOeP7eBFxt5
         lSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996141; x=1790600941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/I4CnabOFJ3V+cBV+khghf4ltJkhcHX6gZAKyxfIiuU=;
        b=zqLe5JD3+Evvh34s8Oo32S+gZLPVIfzqvBnim/JMpsu6aNN+KG0ijuRIZ9ZEB4LM0F
         AlHhJawXEzg7vIlU8PHHYqlUfUGiBwk/wCm4wceeGrkT2uLQSezPtsnTO0PyshXu4yaj
         8QkD0ib5dmYs2LDXih0MfUeLHNtMw7vv2aK3YhR4J7JGhYCFWqd0Qf/6UYfspe++Rpoc
         QfT7JSFaNf5POzUNe9bBGVIx+vAS1ENdF/g7olrsQM7rRhULUnzWrxakd8l3cuAWj+/t
         uygwb8mue2i0FXecFDbERhXG9PbhISbg790urIZ83Cu4XyZonsI+1aKGk7EtHaHR1Lo4
         wZGw==
X-Forwarded-Encrypted: i=1; AKwUvBzfowF7TyRFsB1mooLMo8VNDGy4t9QeGOvoOJ3iB7cx/nIffdxyvwPVnTLyp5BuFPZf+i+tlQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kP5RYjWfS2NljGNQHudZZhXui5V5LTgpFotnoELNR2Sfx0AkCN
	g8MnsnYUCkTpM8utmRgsLBFZGhM3ARCYlnYR6VtU6HsonUyFc6YoUEcJh+nTOpMK91o=
X-Gm-Gg: AYBFou09BMxVL0dqJEyoEQdAgE2TBU8y7EpZSxrpK1rCoFsBmYfMk8E8Pg1iqxDJvSa
	WYELpusVc+vm4M+OG09T6+QeE2G6PYLm2a5pQl0lReav1U5kiZDpZCEk9K60AIV5tj+hfJzIuCG
	FMraLRsomJXB8hwg4UdHS8ngose6pq4TPDxk6JWxF00l0YwfLxElWFJ2akf97jpNXa480XDL+S1
	UrV6RdecrGi+E6t3rGfDtSy645J1vYlzblwadK5Qqkurlsy8NmmvjDGFPb7DUCeebszksNLwIU1
	KrsPcyWKvLWjpIHmqEI4NMUMCLYzom+fkwxJwwwm2rMhIbl3QpxKwQdvows0DmQd40J011AIwna
	iACsHW8VKefXBYTpcymKk+mCT4pfX8AHVetv6APyiZwTV0acNlNSMi+52PbIMn/SJnQ4s013gMz
	BA06WLW7yKp3wG5/9hcopWEfc/U4LTFEEkZIZ9q6VY3wkh/xAsAE2bB42zO1kPteBNlIdBIKB1O
	ya8kKssK8tuSWH64ulE0BLT9HSnEs7Cln22PpbTANBBlQjYrenRHR0Y
X-Received: by 2002:a05:690e:11ca:b0:672:a52c:db25 with SMTP id 956f58d0204a3-672a52ce30bmr1843524d50.109.1789996140490;
        Mon, 21 Sep 2026 06:09:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260aa1db7sm67720106d6.44.2026.09.21.06.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:08:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8dlS-00000006Jlj-41LR;
	Mon, 21 Sep 2026 10:08:58 -0300
Date: Mon, 21 Sep 2026 10:08:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260921130858.GO11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
 <b517070d0b9236b03962fcba649faffcacda23eb.camel@linux.intel.com>
 <20260918170524.GH11599@ziepe.ca>
 <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9656f2f9-2e39-4007-b065-3b763b53c6de@amd.com>

On Mon, Sep 21, 2026 at 08:43:49AM +0200, Christian König wrote:
> On 9/18/26 19:05, Jason Gunthorpe wrote:
> > On Fri, Sep 18, 2026 at 03:42:28PM +0200, Thomas Hellström wrote:
> >>
> >> 1) Xe attachment check if pci_p2pdma_distance() returns OK for the
> >> path. Then Xe always sets up dma-addresses using dma_map_resource(). 
> > 
> > Open coding pci_p2pdma_distance() in drivers is a hack. Using
> > dma_map_resource() like this was never "allowed".
> > 
> > We've fixed things so these hacks are not needed, the drivers need to
> > move over to things like dma_buf_phys_vec_to_sgt() and the hmm helpers
> > to use the DMA API correctly.
> 
> That is a completely broken approach as well since it limits the
> exported resources to addresses the CPU can reach.

Yes, of course it does. The DMA API only works on phy_addr_t. If you
have a struct p2pdma_provider * then you have a phys_addr_t for it.

If the exporter knows it is working with a MMIO mapping on a PCI
device it gets to acquire a p2pdma_provider and use the helper.

None of this is suposed to solve your "resources the CPU cannot reach"
problem, that has nothing to do with DMA API or P2P. It is not broken
just because it doesn't solve every problem.

> Christoph Hellwig is right that drivers should never use that stuff
> directly, not even through that dma_buf_phys_vec_to_sgt() function.

Hellwig's point was that the subsystem needs a mapping helper that
goes from the subsystem address representation to the HW
representation and hides these details from the drivers.

Look at what he built in nvme around biovec.

The dma_buf_phys_vec_to_sgt() is the dmabuf version of the same idea,
the subystem provides the mapping helper. We can try to do better, but
better is not making the exporters touch the mapping algorithm.

Ultimately I want to see something in lib/ handle this with a
non-scatterlist datastructure, but there is a huge gulf between where
dmabuf is now and it being able to work with a non-scatterlist
datastructure.

Look, it is easy to complain you don't like how it looks, but this
stuff is hard there are lots of competing concerns, if you have a
better idea now is a good time to present it. Maybe if you look
closely you will appreciate how much work has gone into even getting
things this far.

> >> It seems to me that a pci-device settable flag "ATS always enabled"
> >> should be enough to fix both issues?
> > 
> > It should be be per-mapping to support the NIC workflow that isn't a
> > global operation.
> 
> I just realized what you guys are doing and I'm not sure if the
> Linux PCI subsystem should support such hacks at all.

I don't know how to respond to that. It is spec complaint, it is
shipping in enormous volumes, of course Linux needs to support the HW
that exists.

> Basically from the point of view of the TA the NIC has ATS enabled
> all the time, but has a per request option to use translated
> addresses directly without previously translating and caching them
> using ATS, correct?

Yep. Very few devices in the world can use ATS for every single
operation. Many have this split operating model. Some even only use
ATS for DMA flows that are faultable.

Mostly the OS can't tell what the device is doing and doesn't
care. The P2P routing is the main issue and we have hacked around it
in our systems till now. Leon is trying to fix it. Thomas needs it
fixed too for Xe. So what's the issue here?

DMABUF needs to learn how to do interconnect specific behaviors. PCI
is an interconnect, it has lots and lots of crazy rules. An
importer/exporter that chooses to use PCI for their DMA should have a
way to exchange PCI specific information.

So should UALink and all the other zoo of options we have now. It
cannot be completely generic and meet everyones needs.

Can we focus on that instead of arguing if the PCI craziness should
exist or not?

> If yes than that is extremely questionable behavior, I'm not sure if
> that is covered by the PCIe spec.

Spec doesn't say anything about when a device has to translated vs
untranslated. The ATS flags only say translated is allowed to be used.

> ATS is meant to be an optimization which moves the TLB from the root
> complex (TA) into the devices at the cost of TLB invalidation
> complexity. But what you do here is abusing that functionality as
> far as I can see.

ATS is for alot more than that, and there is no abuse here.

Jason
