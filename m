Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E736C0B8
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580691; cv=none; b=eG9VBBOH7imSMTGRcm1a3VU9LNrpAhPHX7JOf4IqPZXZqFm0JQwX4ZHQimk0dbv307WJ0ZhuIfqbVuExZTfiq4/sspUC6nnQyWIAPzQp6ykNX4sBhM2vR411ezEdcIAZFEqBcH8cG6dd327nR3zGs4LSBaaih7bdAqtu96r0J/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580691; c=relaxed/simple;
	bh=31o43Jiq7+42iBKuCHD0EJijctYU11Xzmoh7F9+p7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQAuLcsdABiBLvnW20fZQ+yxT4lGpvjm1ewd/rzTs0rY8IqAGMnHUEwAc8RoQ1XzWIueWABMhyQV4K/Q3de6s1Ek5QFQscnbOUACgYzNvakMaO8dIJSZ0Dnq0dVOEB35Q5dUttDoze/UT0lBvpu5BPmDDbqzw1E7s8NtOGCnsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igCVGap4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igCVGap4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so806841cf.1
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763580676; x=1764185476; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=igCVGap4mapaaFdixylPH/b9qixgTzXiITQGazx/GU68o4utkfnVCXpc7eEFwS/VOZ
         lqZlQQCTi1uOGHInBCYQQLHVS9T2RPcqqdZLFo6So9gHX+riiEs7y9a5oYyxfgO3+qY/
         xNnZKH4rDu/zqTGLtxd8WzoIfMyAOWDT0iF3p43cTss/gefmZQ0aXbr3IHlpMbdNSrBd
         fY9BF8w6cx/qDAO8IBCn4V06Gm1ZTRVjHWY7ahpgqH0FjB0FCanm4qKhceAOJMQRZdKi
         sIkRAg1MNLkcCj2BN6LhiYDKbnQNMnJbjmQvK3H3Hf7yxs2sBimRPMHOmaH6tZ5tTqBj
         aYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580676; x=1764185476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=GWUQmlQKlQXbViiA5kByqnqyFidE5rU5o241g6x4taYhKGAPyV7goGc+YPM+DnoP3w
         5DVP+BkS/3b0uylBGvuYASEYXQVmkIC4HloCmvPPnTBYWSUVyFfKKtsQ2BNblULm31CL
         ANSx1nKbrdG78PloQYdGxmvO46tmomuML0Gesc52MFbqdGeVNOnPt2QM7y4IwzjGZhUZ
         8G3qXA3wru+bWZnd2M45yJozESSI7/xnVbg4gMmW7cs0njPK6H7fvlYPJVm/TD+JZyVL
         qtmzrVYYf/mXJ6ilB40+1P5H2xBqtdm/pNoHd3yg+62SCh9QwInDwOycF/QKuIUEFniZ
         YzzA==
X-Forwarded-Encrypted: i=1; AJvYcCVoZKIfmoz7PuPLVjN8aB9ctORJEWcuGmkZjN/pwZrfJSzg87s0KDMXxx/A6ZNfHesAKQ3M4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzx9yAi1EK5FKTPbIaeHhMvyP56PemVLDd48/w4mbKUDJyyWWYC
	aagKnmRwxMrHsR/gozOExry+3DBuaILavr0x7Y7Rg7pAy/oE44jBNZFoGHduKZJDuN0=
X-Gm-Gg: ASbGnctTc65X8f3lTnLR8GcPuxfrAg/1uorhQOCe4Scn3IkMDOo0vA3NvN7iTBfHM7Q
	tR+49sdzD2OzrepDQVr97buCSDC+TrRVZnUiqvAsZ8cBIAO80Zdf04p+mAOjHcPOOBZWh1864Ma
	sa6gZv6BuPTqoOrJ5U1hwDbC6qYIh6S1z80v9m5Lh5ubzNOysEdKs780budyE/UQV48S/VEXwmY
	6kU7obN6DJKR3CYZDcgoNpz3Jpps/bUqwzk0dtQTQxu55IXQqhKlCSV9wY9eI64CwsCds5emmqm
	qQjJbLuEeHIAzcO5TRaCBmRn/tByfvrrHzFwJ2yA4+Xg5Q9QIZ2SePC8Cs87oUI6wSBMfjdh5Th
	/GKw5vnA8eucUdqtlPbL77Bw5StF37yodJlDBZDACX3Z8Nd7yuEcc1k2d+v0R0+fLqhPqcZcrXf
	krRQ9iwgdQB0UfSoU68g8GYtyjETEmw5hO5T8tbN159V+tKBXp/RjMzN3SUp1Y2djZaV0=
X-Google-Smtp-Source: AGHT+IH0hpvR5twkqRmVGMRtAcrCxesRIOb4Xizv2z5I0TXHRJV8nSPA0Y9PLt873fJAl178vHWixw==
X-Received: by 2002:ac8:7e4c:0:b0:4ee:4a3a:bd18 with SMTP id d75a77b69052e-4ee4a3abe64mr1136891cf.76.1763580675980;
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e46ed0sm2807721cf.20.2025.11.19.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnta-00000000bWq-3r3x;
	Wed, 19 Nov 2025 15:31:14 -0400
Date: Wed, 19 Nov 2025 15:31:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119193114.GP17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>

On Wed, Nov 19, 2025 at 02:42:18PM +0100, Christian König wrote:

> >>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >>> +		dma->state = kzalloc(sizeof(*dma->state), GFP_KERNEL);
> >>> +		if (!dma->state) {
> >>> +			ret = -ENOMEM;
> >>> +			goto err_free_dma;
> >>> +		}
> >>> +
> >>> +		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
> >>
> >> Oh, that is a clear no-go for the core DMA-buf code.
> >>
> >> It's intentionally up to the exporter how to create the DMA
> >> addresses the importer can work with.
> > 
> > I can't fully understand this remark?
> 
> The exporter should be able to decide if it actually wants to use
> P2P when the transfer has to go through the host bridge (e.g. when
> IOMMU/bridge routing bits are enabled).

Sure, but this is a simplified helper for exporters that don't have
choices where the memory comes from.

I fully expet to see changes to this to support more use cases,
including the one above. We should do those changes along with users
making use of them so we can evaluate what works best.

> But only take that as Acked-by, I would need at least a day (or
> week) of free time to wrap my head around all the technical details
> again. And that is something I won't have before January or even
> later.

Sure, it is alot, and I think DRM community in general should come up
to speed on the new DMA API and how we are pushing to see P2P work
within Linux.

So thanks, we can take the Acked-by and progress here. Interested
parties can pick it up from this point when time allows.

We can also have a mini-community call to give a summary/etc on these
topics.

Thanks,
Jason
