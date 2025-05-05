Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F024EAAA
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448147; cv=none; b=iGTZWEwQ6aS17ARpB4j3xYlcpiutdBe3mw5hO4L8nsyoAtM2HdNpKEa+UIpCtp+bvjxXkvRGF0EhKUM2sw2AoCsdsgoiOpnN+iPu31paP83khSFNYUlfkfGPRJr63QNnazMlduzGjaizROPEEqt0J8SLAFEq1ZAFfjaR711IDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448147; c=relaxed/simple;
	bh=8st2WkhNjYa0sS1ZjGydQ5cI8qeMQD3qVytw+PewtLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7eFdgEgaO3UPveEzFordoz4sC9wciBOSkPPbMG+RULcSF9DhVLltE08bNOaS5ir2Q+maoClJgS7coFT3vjfEB5D2e961CEKQPn4W+eKhmovV/8E88h/J1j8sHeppoi5k4KQPmPB9ZVle+aHwEHDuY5xHODIeuM0+dqF5aA0hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lfKn7SDp; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lfKn7SDp"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fce04655so47271186d6.3
        for <iommu@lists.linux.dev>; Mon, 05 May 2025 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746448144; x=1747052944; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=lfKn7SDprx1uMBi1Fe8nRB+wUYBeaFlUziuM3LrlbNXwPJDck8bE98HJ8QEXmNC0cC
         0w31QHdJmFR2Pednu3j/qKlRvYVbEJiGFNs/CJ+lAZCpIFfbFV3AemdH766vcyr+bkIr
         FS1nvC0FNWFS70R8ieEiJdMRF4dJ3DZ26hboO7G6yrKeJwpMrSjoOkQ3TXCXAj6ZR3LH
         dOpuN0vodhrQtyCroaG+twtRoOGYjQFsu2j0YHVFUMYq7p74oJrxeRMBgfZt2SFQa4/8
         oK+ZfCqTgpjcMZDyR/ca66SQF64QIcVTeXam5X/aw4SPAAcMIs9joNg9viFQY447qdSv
         qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448144; x=1747052944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=CndTJAG2gKXv6ZohqstTsLBUble5n7A6wJp6uDtj1dgjkI6TlEq5eI6ED9CJgd9LUH
         TUmd2sVLPKP+2SXsC1ttlTuaEZqmYCwostNfvh0B01/RlhthfOgHk7krlOnjRtnDuMId
         UWFYFj8e/+W+LoYhP0HJVPrkBHoTtCoXG0AsJ0HWGLYHHdFdL4pUgjBpCy2t8TKcPIPK
         YXz9KG4pkZtXCddEBYQQDz3oIDQ6DZ7dfLg8M87kJ+WgPGcFzT0B7liO0P3wYxBK3R4n
         NPF96Eu+K19W0aJ0DrzPw74uAYaIsJ/mUKKc0JndIkZ0pev6kn1fPdiM2vQtTjwDIDEJ
         Ww0A==
X-Forwarded-Encrypted: i=1; AJvYcCW6N32Xr1LzGCv3tAUf9UsuctLb2Fw7mCN3l2GEV9CxP5FwK+agFgtqSSEljs9idKNU0JCE6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz3JZhVHUtyzOGPcUf1wWm4Nhw/+D+zjh+IoIMnFaHvjIHHjTw
	t091e88mF0DwstwV1jsR/vDnzal8KiILudv0jyAOIIc6SlCmFHan5a4QVdkpD9U=
X-Gm-Gg: ASbGncvFHLrSJVtaY0XO3ozf8o7t5d+nvGYJv0yafW7wpy7/F2TsLNG8KgxUNIMyQra
	PpvpOZH1QX3sbHXymN6VJbvuMiFj+r0eQf4EVlqQZLSgLJ3h0BuUJSH5oeEorCQkGUvYkkE+OM6
	sdvcWwolF9uietv7UDNHzq4qrS40OypW5uae7cDa/oQ3I7lFmBRdXsX0+/01atQ5bvbrgADbs0x
	hvX93M4cMQe6ygt6zrGUsOTXnIsGCsTRL3C8jp/mKWQmIFwJOhfR9kEt53l4oMsJzS7j6cZiRH2
	bXdnRhfxCAIm+81CDh8wRYaAEJ2FKdn2LfOh9UzyMd+qzIfEejPwrzrh60kD+xHuHIDypDGmBBf
	nq7ZJaANeuwHRcgxtuT8=
X-Google-Smtp-Source: AGHT+IHrrCkbPkXSi1eXZMzeybSC5P++W/lKXALdeEOdhNPGMmZG6yFN5oZZyeIbSctGCJtNUEnJAg==
X-Received: by 2002:a05:6214:b69:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f523852b68mr146814446d6.38.1746448144313;
        Mon, 05 May 2025 05:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3887sm54983076d6.38.2025.05.05.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:29:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uBuwQ-0000000GxAs-3q1W;
	Mon, 05 May 2025 09:29:02 -0300
Date: Mon, 5 May 2025 09:29:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v11 0/9] Provide a new two step DMA mapping API
Message-ID: <20250505122902.GF2260621@ziepe.ca>
References: <cover.1746424934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746424934.git.leon@kernel.org>

On Mon, May 05, 2025 at 10:01:37AM +0300, Leon Romanovsky wrote:
> Hi Marek,
> 
> These are the DMA/IOMMU patches only, which have not seen functional
> changes for a while.  They are tested and reviewed and ready to merge.
> 
> We will work with relevant subsystems to merge rest of the conversion
> patches. At least some of them will be done in next cycle to reduce
> merge conflicts.

Please lets have this on a branch so I can do the rdma parts this
cycle.

Thanks,
Jason
