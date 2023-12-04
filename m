Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1B24B5B
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mONahwGq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-423dccefb68so46314921cf.0
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701696304; x=1702301104; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0moGbGhejv/srhz8+960qzSk1YcwHQBWsgkAUS7flGY=;
        b=mONahwGqy21BnOdGgBa6HNfJJhPNKDukuF+ebs2I3jYEIavWr+a+8dDqdvVEIMQABm
         m9RVG/Lc/xqAx1y5iCtH5rW2lYV1otP5xdAxkgP0+UoNhhsdDkAxuqjLEwT5ReR/I+mN
         yfkAhL1QMJ+NFt4hMQeT7fHktxz4HyAq2voFw8HeMvzNYt6M/yn5uMiZnmIBkeGq0/Ys
         K2x2F9iALBNvyDzQ41B2SisY31r7JConEfS+E/nM7Tbgf+6kXtj15BC7A/TIt1dFK6AD
         fU9x+Cy4/s9dJnzFZeArlVYbmGSAMKL9FppggHGSNdREzdzYpA137MtkR1dt+rxE3fce
         NQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696304; x=1702301104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0moGbGhejv/srhz8+960qzSk1YcwHQBWsgkAUS7flGY=;
        b=JjmsjAyMdzoIQEkrP04PWUhqJ+5eHlqoZCNi4JGBXfDRwOikC5YvQeY2REemxNkWwf
         4gcod4u54+wvI+afZNBt1Ti+qAzKilYRndkdN+2dJZNyP8pC3MbD/Wc8Q6W9jhntD2bd
         IwiMh+tDnUlYXI0mbvPqne2d46jsTAhcij/9eZFTV2fcyxxwbepKRNEnts7GG8rlW8RF
         L5Rsv3hVP8TwmEPnRbgzzJkJxMqkL61Ch5GpZMbyt1FY3hq0C3uyxC2sUFu3Vmk8xDyy
         cYBfVfXmqTAGkdnD/BWFTiptAojZ4Dhb8i7peTQLreBAl3eqv8YE0LdmHHPe+Yyl9Yok
         abIA==
X-Gm-Message-State: AOJu0YyVmtR6QtUCUoRQrZYJ5NUqGpE3qgP8FfmQVrDv/NGrwbsMBNw5
	mZKbU50nxe9G0h2lyyHyZkboTw==
X-Google-Smtp-Source: AGHT+IEuBtJDX6k91V+YITPMzc6IBzL+YpnMZews0QwJR4BifvUjKKT5gSJ3XU5n/QvsTf6dQHmbjA==
X-Received: by 2002:ac8:5b8b:0:b0:410:9668:530a with SMTP id a11-20020ac85b8b000000b004109668530amr6178889qta.21.1701696304412;
        Mon, 04 Dec 2023 05:25:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id jg5-20020a05622a728500b004252255144csm2544679qtb.15.2023.12.04.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:25:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rA8wZ-00AsHw-7d;
	Mon, 04 Dec 2023 09:25:03 -0400
Date: Mon, 4 Dec 2023 09:25:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231204132503.GL1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>
 <20231203141414.GJ1489931@ziepe.ca>
 <2354dd69-0179-4689-bc35-f4bf4ea5a886@linux.intel.com>
 <BN9PR11MB5276999D29A133F33C3C4FEA8C86A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276999D29A133F33C3C4FEA8C86A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Dec 04, 2023 at 05:37:13AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, December 4, 2023 9:33 AM
> > 
> > On 12/3/23 10:14 PM, Jason Gunthorpe wrote:
> > > On Sun, Dec 03, 2023 at 04:53:08PM +0800, Baolu Lu wrote:
> > >> Even if atomic replacement were to be implemented,
> > >> it would be necessary to ensure that all translation requests,
> > >> translated requests, page requests and responses for the old domain are
> > >> drained before switching to the new domain.
> > >
> > > Again, no it isn't required.
> > >
> > > Requests simply have to continue to be acked, it doesn't matter if
> > > they are acked against the wrong domain because the device will simply
> > > re-issue them..
> > 
> > Ah! I start to get your point now.
> > 
> > Even a page fault response is postponed to a new address space, which
> > possibly be another address space or hardware blocking state, the
> > hardware just retries.
> 
> if blocking then the device shouldn't retry.

It does retry.

The device is waiting on a PRI, it gets back an completion. It issues
a new ATS (this is the rety) and the new-domain responds back with a
failure indication.

If the new domain had a present page it would respond with a
translation

If the new domain has a non-present page then we get a new PRI.

The point is from a device perspective it is always doing something
correct.

> btw if a stale request targets an virtual address which is outside of the
> valid VMA's of the new address space then visible side-effect will
> be incurred in handle_mm_fault() on the new space. Is it desired?

The whole thing is racy, if someone is radically changing the
underlying mappings while DMA is ongoing then there is no way to
synchronize 'before' and 'after' against a concurrent external device.

So who cares?

What we care about is that the ATC is coherent and never has stale
data. The invalidation after changing the translation ensures this
regardless of any outstanding un-acked PRI.

> Or if a pending response carries an error code (Invalid Request) from
> the old address space is received by the device when the new address
> space is already activated, the hardware will report an error even
> though there might be a valid mapping in the new space.

Again, all racy. If a DMA is ongoing at the same instant things are
changed there is no definitive way to say if it resolved before or
after.

The only thing we care about is that dmas that are completed before
see the before translation and dmas that are started after see the
after translation.

DMAs that cross choose one at random.

> I don't think atomic replace is the main usage for this draining 
> requirement. Instead I'm more interested in the basic popular usage: 
> attach-detach-attach and not convinced that no draining is required
> between iommu/device to avoid interference between activities
> from old/new address space.

Something like IDXD needs to halt DMAs on the PASID and flush all
outstanding DMA to get to a state where the PASID is quiet from the
device perspective. This is the only way to stop interference.

If the device is still issuing DMA after the domain changes then it is
never going to work right.

If *IDXD* needs some help to flush PRIs after it halts DMAs (because
it can't do it on its own for some reason) then IDXD should have an
explicit call to do that, after suspending new DMA.

We don't know what things devices will need to do here, devices that
are able to wait for PRIs to complete may want a cancelling flush to
speed that up, and that shouldn't be part of the translation change.

IOW the act of halting DMA and the act of changing the translation
really should be different things. Then we get into interesting
questions like what sequence is required for a successful FLR. :\

Jason

