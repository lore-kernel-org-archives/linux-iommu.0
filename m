Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8A59220B
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655294; cv=none; b=Zn7zeTQhcz4ydoCLJCvmJRLkD59CvHK7w7Hatuem5SEGGHSBzLsGvS8CShaDcQ2Wr63hieIcyUxi7nCNUKpjIP376cLxYGorJ+9W64PdTZDXU0vQgV9mwtfJC6CQ9CKq23/njNWY6GAu0KqoSQ2J/r1iL4XHa6l04PlLkV9UPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655294; c=relaxed/simple;
	bh=zD+yqYOk9BEwYrlkE41XIJFd2WjARDFI5ce4WJxm+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qetht6IUWWCdp3WT1AaXLF7YxN9tfEKDlUFA4KxpJILxiHH7qHV5dkOui/iqy3IhfinDV0IdlNobAYEx9vt9pxgXE9v6GY+bp7VJHpbRndXc0g0CI57YchDj3I+PLC8JucprB+TLnXGzOuGILZ7SNA4f2sWDkpaMDG/NR9Ula/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hsfj+92u; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hsfj+92u"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so9285566d6.3
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789655290; x=1790260090; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
        b=hsfj+92uJM/NVcCc40Z0dfIVut1ueNMt3nKKrxMG5aLSDj1HQYlhKVYljOIRvOe7hj
         8stG43Ht99Xqg7NRO7hV2aBWNu56uHSfICZcflNkJtNXcG33N49m7zGupUvrs3IAzRvV
         Zp+fYXJl0Tm0gEXZSHchdTBPn/zjUWJUOpK8VnZUnkV5rCu7cwx77Pr6MfKaqPvn719u
         aGC4BgvLDfX1OA8MwFElzeJuHDzyX6Ly7QTv6Sj/5UYAsYIkkVhLdVV/SSNFZoRWewmQ
         0/x0CYkMlhkdVQjSagBg0ihLG+nIENqc1+DnWIP0OKw7g2R9X1mEhaEgN8OqRK8UovII
         e6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655290; x=1790260090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
        b=ZCZCADmBWghktdLSQvyvWzpHrKedoLjzpSfNrk+XD9/2xpBAvjSfZEymM8xKd8yQE4
         D6SDXsf0wztNKrDyueqXU/ke7zpl0sUlz5rZwGxO/gc8IEj0e6bLb72F0fPRKgsCpEYi
         AfUnPbHscYrxXqrb9k0hSrYn/17BbFcJ1KilJHvEmQmrlP1Ymo7w5EXzsr8jEjLHl8xn
         TFMMi9Wf9U0TVzNWtW2oEz1CnS01ayMIst6mlQZp4vnb0UtT1DWswWa/icCnDH9ms9Ge
         zWMFlDyKQy8AKWxN+2PGN5ApXHOPDGqIybGbDN7x9XiKFU7ZF9JiQZfQ5jAcVztjuV2N
         pNsQ==
X-Forwarded-Encrypted: i=1; AKwUvByu0YjH3Fl0NaxSQ11WP3QDcZFiAwg63aaHGDzVnH9OEukyk2rlrhn3AEZrVio7h55btt9ASg==@lists.linux.dev
X-Gm-Message-State: AFuF++mxsswqIeGWWEu+3eha3SdpvJbV0vT4FLwpxszEuJ76BZBkgeB8
	axoCISAhf4l5fWYUzZVKMOh4jx0pblGIKo3fV4KDpb7tZYt3iL1CUaYfBuFTvmlYMbo=
X-Gm-Gg: AYBFou2bvNgqdHgrecHzeE5NXyK6tp5E3y4ISSGtXIk+dnS3Ld8rj9R7boI9/vN63t1
	GXGreMxbN8OhK9bqxoP3jrUhw0s8pvqJdXgQCCVf396+9eKhUmZYs/q6EV86Ag23gdKaegY8Vau
	P0Y+t4w5bvnTFvriYQ2bvC20wjxNNWyCLF5BRAlAmEQAFoi/aiUce74k4lLqwOSp7nc1t5zt5+w
	A2F2VF/l5eoRZH1wQ5EE6hKPrGArSNnqrU5OcDM5WETN1jTTD0F3Il1SbcMfn8sEDdxUkmGuuni
	wH3NMsorQTY+/chA7a81x19BnKXJ3cYrm2tYT883wENqoDYynuMmt63GFgEDsehc1QVQHkz4X0x
	vGFtRQydJZ+IeU87l1oNCjY473x+Vomt6TCUTghOmGef/LWmorLSk/rJqoIFlypc1LVQf8jHpVj
	CoRmLyAyjSAvwlohxnHCYuNI2Iu3QQIbi1ZE1jXqfuVvyQ0wZ9gGLlz4YQVK66Gv/PRPX826t9H
	hpQX6rlBEVVfupZZCEkoOYBe/2hFSzPjb7NXsJhqFv7SV1aWVcV0KoG
X-Received: by 2002:a05:6214:1316:b0:912:517b:911 with SMTP id 6a1803df08f44-912517b0beamr9926716d6.48.1789655289706;
        Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be9ca82sm51192626d6.32.2026.09.17.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7D5s-0000000CrE5-25RS;
	Thu, 17 Sep 2026 11:28:08 -0300
Date: Thu, 17 Sep 2026 11:28:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20260917142808.GH3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <f3708893-4760-4157-83a3-313867a94e78@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3708893-4760-4157-83a3-313867a94e78@amd.com>

On Thu, Sep 17, 2026 at 04:00:33PM +0200, Christian König wrote:
> > However, at least for the Intel GPUs, ATS enablement is based on the
> > PCIe-side enable bit.
> 
> Yeah, I can confirm as well that this is something really exotic.

In most datacenter systems it is only the NIC that initiates the P2P
transfers, so it should not be surprising that NIC HW has more
optimizations for this. In real systems ATS carries such a perf cost
that you do need to be selective about it. I would expect every
serious NIC to have this capability or it will not be perf
competitive.

NIC and GPU are using ATS for completely different reasons.

> Additional to that the setup that ACS seems to be disabled for some
> bridges bit not all also sounds extremely uncommon.

I'm not sure where you saw ACS disabled, you can look rdma-core now
has a tool to help people get their RDMA NICs working in GPU systems:

https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_topo

I would view most of that stuff as completely normal at this point,
people have been doing versions of this by hand for almost 10 years
now. Especially the asymmetric translated/untranslated routing.

Jason
