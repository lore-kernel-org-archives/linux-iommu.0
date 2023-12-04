Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB72421D
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eUazscUX"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58cf894544cso2953096eaf.3
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 05:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701695532; x=1702300332; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RWsKxXhxAMEDfXPpZR35TsYFyeNBhVQ2t6NvxM6Pec=;
        b=eUazscUX+TUHT5UleCXDYD8eTb3YiEry0w8EQBKdnjN5E7430ZuMAvXFA0C2ovFJ20
         uPVG61MTmRPbdpUDvEsypx9dB4xfdZdw7srwtEyFmEFdCOb0EdG4JYFV2cQ/igLTjdDT
         PTSUehwrdq6I+G5nJmCLVS3rMKVxuFcf3n1xdUoH0kzOiG1pq2gEOQnJeK035ZeoMAbC
         Om05pau+PWfkS2pLqKsH679IUamxfLP1yYLtJk/a2JMPBWw12UTSCiZJlthETvkIXBnZ
         ELz61L7hKo14Z3c3xjIdLB5Rq2MeUlqjzqa4Kz7Bv6bMyGuTWI3UcSuoUBR0h3QOEbE6
         +iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695532; x=1702300332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RWsKxXhxAMEDfXPpZR35TsYFyeNBhVQ2t6NvxM6Pec=;
        b=LbWXf1laTdI09dyY67/TucAZbqf8S7HWRkI0gBuiPnUGHkQdnICNKOfpu7D5xNw5GM
         STKiR2nHSSqZGDveqDnOOB+3NN2TtkoCf8q3CQnZU6A4hb3qapCIIXeGX99zJlePeMpd
         cGwm0jw6+T/cJkukcNYtQNSQRx2yDjweGEy0MBMEB8ReJZQwRUYb/8BbfIVn7uJkP4aX
         /iee7A7VGn0zYCg/pzV9RhU34q7iDp4lO0EcsXJCGMsgdkm3ZmyINsiN17lVe7CXiF1i
         w2aSEYGK1P0gg3svv1FCm1xKQKc1ihEVD6CAwY4cpwWFv2xbxXeTkhfuaSrfA/ToC2PQ
         WK1A==
X-Gm-Message-State: AOJu0Yxw0cj2yDBv2LeUUxBWFN4jiKow39vhKjsLfcEl9G2gdbmNP2CR
	fk+IA2TgTlFfRgXNdLAKiwjToQ==
X-Google-Smtp-Source: AGHT+IGoQOzPPQKNgLswcbzAqC7rBuTYY1wEC/9v3DXJqgA/wrMtqAvrBw+cZGFjMr3uAfVfX68LDg==
X-Received: by 2002:a05:6358:299:b0:170:2f86:392e with SMTP id w25-20020a056358029900b001702f86392emr1553337rwj.60.1701695532580;
        Mon, 04 Dec 2023 05:12:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z21-20020ae9c115000000b0077d8ad77069sm4248899qki.26.2023.12.04.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:12:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rA8k7-00ArNK-HA;
	Mon, 04 Dec 2023 09:12:11 -0400
Date: Mon, 4 Dec 2023 09:12:11 -0400
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
Message-ID: <20231204131211.GK1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>
 <20231203141414.GJ1489931@ziepe.ca>
 <2354dd69-0179-4689-bc35-f4bf4ea5a886@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2354dd69-0179-4689-bc35-f4bf4ea5a886@linux.intel.com>

On Mon, Dec 04, 2023 at 09:32:37AM +0800, Baolu Lu wrote:

> > 
> > I know that is why it does, but it doesn't explain at all why.
> > 
> > > 1. Clears the pasid translation entry. Thus, all subsequent DMA
> > >     transactions (translation requests, translated requests or page
> > >     requests) targeting the iommu domain will be blocked.
> > > 
> > > 2. Waits until all pending page requests for the device's PASID have
> > >     been reported to upper layers via the iommu_report_device_fault().
> > >     However, this does not guarantee that all page requests have been
> > >     responded.
> > > 
> > > 3. Free all partial page requests for this pasid since the page request
> > >     response is only needed for a complete request group. There's no
> > >     action required for the page requests which are not last of a request
> > >     group.
> > 
> > But we expect the last to come eventually since everything should be
> > grouped properly, so why bother doing this?
> > 
> > Indeed if 2 worked, how is this even possible to have partials?
> 
> Step 1 clears the pasid table entry, hence all subsequent page requests
> are blocked (hardware auto-respond the request but not put it in the
> queue).

OK, that part makes sense, but it should be clearly documented that is
why this stuff is going on with the partial list. 

"We have to clear the parial list as the new domain may not generate a
SW visible LAST. If it does generate a SW visible last then we simply
incompletely fault it and restart the device which will fix things on
retry"

> > Requests simply have to continue to be acked, it doesn't matter if
> > they are acked against the wrong domain because the device will simply
> > re-issue them..
> 
> Ah! I start to get your point now.
> 
> Even a page fault response is postponed to a new address space, which
> possibly be another address space or hardware blocking state, the
> hardware just retries.
> 
> As long as we flushes all caches (IOTLB and device TLB) during switching,
> the mappings of the old domain won't leak. So it's safe to keep page
> requests there.
> 
> Do I get you correctly?

Yes

It seems much simpler to me than trying to make this synchronous and
it is compatible with hitless replace of a PASID.

The lifetime and locking rules are also far more understandable

Jason
