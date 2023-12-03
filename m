Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0E16438
	for <iommu@lists.linux.dev>; Sun,  3 Dec 2023 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJNuytSl"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d81faeefc4so2026506a34.2
        for <iommu@lists.linux.dev>; Sun, 03 Dec 2023 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701641010; x=1702245810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXGORkgyD8V8K3kt/4/CeA1q7F0AqMm8u3Qa3gndrU=;
        b=PJNuytSlEWjGttO1o33uVTsUycKftyEhquzagKrIFCcbq9UhzZNT+kkEGyKEpqRiUo
         GcRGLNAUkg8EFNiwLQ0OUSHDx4OGZrFVWiX5QZ6e4p2s8ImMPltuQhGq84J5T4yLFUT1
         hV4nNs1nVynCQ3eQiZjmRBh8XAzvgTXhW9ylVGp5rM7xgwtm0eGTqxtvzn3xnX5rgc8E
         pk9PbGkVALATVT4UgzYx/GPKVk/kWLQQAPXeiDGcj7jrlq7YrOoxrjQF59MSR8R2qKe1
         jSd2iYG82r891+zhFfx5OHtJn6kMceF5IqEgv6FG80eJT8c9ZyDRpHmUQFjvsbFF68DF
         gU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641010; x=1702245810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaXGORkgyD8V8K3kt/4/CeA1q7F0AqMm8u3Qa3gndrU=;
        b=WCYKOXslTUV8Ofs1x0xr9hUEZhC6BGeufLScpKR8FpfNsEZlppS0Wbh+ma2Fp0JvLG
         uf0hPbIulNXfMALKQvOEQ/u5zKaORkksdazSDh5JinFAJZ3HzI3w6It9dPZhSLzL9827
         s3MxJ+xNKJHR7LpuIrZrXKXw+cIa1Zq2n28CB8IlcmTtGUmu8XMggtWmPowb4Qm9lnvn
         ZqxOSaNQk+SfOBA45JU4lfi7ChzrlBI2LYtOGhXA4a8L2ZC9wmOddNxPZcCFLs4fs+cA
         KUqI4C9yZ2cFgatgsApM3qbKaxJ8i3QkBbt7rJtJHxOx4Rd0MASR7Ny8q0zNxSeQ4Drk
         5cYw==
X-Gm-Message-State: AOJu0YzzhHzK3ZwLVDLQv/PUi6GuwNePWfO9sqfB51622jPchzMiMWEv
	nDoEKaayF1pTwJ7HgqPMZ8FJ7A==
X-Google-Smtp-Source: AGHT+IGeqQeHNRAbzk2GAKjNpH/XD8SXpDM22washvL7aENUe3mDXZJxd4VQhDC4t5x3Ye/GoOZf1Q==
X-Received: by 2002:a9d:7691:0:b0:6d8:7c2c:2045 with SMTP id j17-20020a9d7691000000b006d87c2c2045mr1837646otl.77.1701641009868;
        Sun, 03 Dec 2023 14:03:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s7-20020ac85287000000b00423d75e0444sm3692763qtn.73.2023.12.03.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 14:03:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r9nEc-009I57-0J;
	Sun, 03 Dec 2023 10:14:14 -0400
Date: Sun, 3 Dec 2023 10:14:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231203141414.GJ1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>

On Sun, Dec 03, 2023 at 04:53:08PM +0800, Baolu Lu wrote:
> On 12/2/23 4:35 AM, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 11:02:26AM +0800, Lu Baolu wrote:
> > > The iopf_queue_flush_dev() is called by the iommu driver before releasing
> > > a PASID. It ensures that all pending faults for this PASID have been
> > > handled or cancelled, and won't hit the address space that reuses this
> > > PASID. The driver must make sure that no new fault is added to the queue.
> > This needs more explanation, why should anyone care?
> > 
> > More importantly, why is*discarding*  the right thing to do?
> > Especially why would we discard a partial page request group?
> > 
> > After we change a translation we may have PRI requests in a
> > queue. They need to be acknowledged, not discarded. The DMA in the
> > device should be restarted and the device should observe the new
> > translation - if it is blocking then it should take a DMA error.
> > 
> > More broadly, we should just let things run their normal course. The
> > domain to deliver the fault to should be determined very early. If we
> > get a fault and there is no fault domain currently assigned then just
> > restart it.
> > 
> > The main reason to fence would be to allow the domain to become freed
> > as the faults should be holding pointers to it. But I feel there are
> > simpler options for that then this..
> 
> In the iommu_detach_device_pasid() path, the domain is about to be
> removed from the pasid of device. The IOMMU driver performs the
> following steps sequentially:

I know that is why it does, but it doesn't explain at all why.

> 1. Clears the pasid translation entry. Thus, all subsequent DMA
>    transactions (translation requests, translated requests or page
>    requests) targeting the iommu domain will be blocked.
> 
> 2. Waits until all pending page requests for the device's PASID have
>    been reported to upper layers via the iommu_report_device_fault().
>    However, this does not guarantee that all page requests have been
>    responded.
>
> 3. Free all partial page requests for this pasid since the page request
>    response is only needed for a complete request group. There's no
>    action required for the page requests which are not last of a request
>    group.

But we expect the last to come eventually since everything should be
grouped properly, so why bother doing this?

Indeed if 2 worked, how is this even possible to have partials?
 
> 5. Follow the IOMMU hardware requirements (for example, VT-d sepc,
>    section 7.10, Software Steps to Drain Page Requests & Responses) to
>    drain in-flight page requests and page group responses between the
>    remapping hardware queues and the endpoint device.
> 
> With above steps done in iommu_detach_device_pasid(), the pasid could be
> re-used for any other address space.

As I said, that isn't even required. There is no issue with leaking
PRI's across attachments.


> > I suppose the driver is expected to stop calling
> > iommu_report_device_fault() before calling this function, but that
> > doesn't seem like it is going to be possible. Drivers should be
> > implementing atomic replace for the PASID updates and in that case
> > there is no momement when it can say the HW will stop generating PRI.
> 
> Atomic domain replacement for a PASID is not currently implemented in
> the core or driver. 

It is, the driver should implement set_dev_pasid in such a way that
repeated calls do replacements, ideally atomically. This is what ARM
SMMUv3 does after my changes.

> Even if atomic replacement were to be implemented,
> it would be necessary to ensure that all translation requests,
> translated requests, page requests and responses for the old domain are
> drained before switching to the new domain. 

Again, no it isn't required.

Requests simply have to continue to be acked, it doesn't matter if
they are acked against the wrong domain because the device will simply
re-issue them..

Jason
