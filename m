Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739841;
	b=KHv/JS1M5sj6LJhzfQOlzrYp2TALeJmGGC8Ak/U96xEo+RRwj33zWA0Zn3cqRdTWuquT
	 kBMZyxK9vb57igczVUR9lhUHgcv8jEQuqxid1VJ6D35W7N+r1xQZ39mGDuMUB0C7yJ4Gc
	 IKn6eqSYzNAtJBG2lBc24bCHEGWYwh6pTpwsQO+jawUsFl8AopU2JdPNyt0M4CP37PQgc
	 PjzLEBeRBBJovDS8rhPhjHcdc1bFxPKw2L8yo+zaqrC/pMw4DV059lbhax8fe/wcK3VfU
	 UlZvk72ptuuRfexsqQxXTx++ZfMnrT3tOrgp62CQ5hwjViSggpEqzWcIwoUc8pvB3Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
	b=a8etXxP4wNTiCbfA0fDkg61F82alZnlQ+3p+O4hq8Mt3M4+np/IRRK5umKaHqCbfWmil
	 5If60VCfVeH7NCiyon0IKFLAGKlsdfqJl63OABQQ89RC0kVtUYjXzEuyCKBD/3Ex6NAdV
	 zh1U/6oVMJc77zGUwW4Hw3xEZEkuGOMMcVeTa1j63cDtRbQiSToRTA8Jjdt7z8EEFIF1T
	 yIutIsFU5BB6FpImAkEBGgVMuLKDceT76hq84O7yeiwDRAgUVRZSWc5yCJlehiMCt3TMZ
	 QCdOd14dxgJGeSV50j1eNXwghV2ITnV/yxNVAAHd9toJP0F7jSCYY563QQtqF7EC+ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=a3FKDRTa;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAC606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 00:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74BAC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=a3FKDRTa
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55d6deecef6so75019841cf.2
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795739839; x=1796344639; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
        b=a3FKDRTaWZYwjF0hOEgP/wg1A456Xg3h0Ky7qmYFLIrBzHnxWmsxW3Thl9phLK3ch6
         aAuhvWypoOuzKYYp10PJBpmeCE0uFHSAEWt6ya7NvicQdltZeW06FdgeZAWqajh8eBW/
         Lt/qiJeNS/VOIyX5ZugHjhw7BQwYzblorsMHQSIvqwMJJrABE6zLjuuZtZM8+UgwkC7U
         A7nhxM17+eNdfhxr8OTNotKe9izVbKlJnan0A7UFaE0yEU06IK/Ja7S/AKA8JpyaADV3
         jlKUJNJwB7saUptVqzy2oikUMzLWiagXFWJDWH4gKD0Xh2XHtDlBRhWDSBh+tnJq8Q99
         wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739839; x=1796344639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
        b=WLrU+ECBsdDcSqDDXlvG/O9VYHBU4K+D3Lx61yKOV7CXFGJWjyiioZ7Jup2FwaEnUm
         HX/WXfsiJE56IF217z97PA0QqsAodai5d6JMRiSdorfgywQEKawlgiw4nl2WmwW+fQYu
         XfA8sW5sa2LMH5pVc/oVfrTG2uj1pUgb/9jstC2DXbO5oY6dfzrk/pRHAtsrMKyuVMMN
         YW9dZxsSIgUn4q7Bvq94qm6JB4e6ZQed6G3S5RVLxisUZOaab27dGhObNUb2qYQs8GMe
         xrBYtAvqquGZBirHjVON6zLm6nARk7p0Bzifek4ei7pOuEzsKuq9/dAGflmqS/lIkW4H
         kW+g==
X-Forwarded-Encrypted: i=1; AL+hErELdYbuMMa5sLKqtNcPDpP6YoSXN4aRLvHZt9YHisbenpkekmsBjkbZWjYr//CzgvTQ+ks7JQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YH2dBbFvMUVa75xVWz6aSkxU2NnxWebHYE2vfMl1coV6xjBIz
	u/faYCZSQJCVd0OzwDtl4Hs1XhJVDDSkg4dGFZlc+n/k3kSR3e7FiofriN6ApM1aDUg=
X-Gm-Gg: AZFdTZcpBFAuGUl7KCpdgFWruCj5xHjA1I/dZCc9fdc4U1ocjlxJuCmEe9JcuFMbP9r
	eLM8X4KSt3MwvzWhpWwnGSjt1FDXXIL0jrC58rrqR7xwv0mtrZJB3GWwIi17GkfLGoMMmX9duU1
	m4BZ1Akswf7InXRfvTk5yGpw9MhxC/dLLPN0O1oLHJRI89ZiFChRFUQuKtIlbEN/NkNUeRNwDkk
	hdW2fN4772JZ92/ag9AyCkWzweud9tvVHhweQNZYT9lyTTznnuH6lEgNFWz7PvIDZVFxaVFztln
	G8N3QI/x/oW8/NDLkb1fpilG0w49BaazEIARYuhX39wW0Ueiok/XU3e8vG2QhocZqy6q98HuBtg
	7h9eVsgY4ve4KT68sjvyMo1RIj4cxnYAIRdH0vujAXFjb59RmCEzHLswAJsFaIgAGtQcAy3FBey
	PeyFZQ2NtVp++IKeE7Dg2pY133T92KGUHlgkK7gDQzAP2td/hNrL+8EbmhMbccJTgV3xfWiSC3A
	bTSVPk0S3X8lwwC4mrfybD6/8Tjg0PEPbH9+AKCJ15aTgvWP5FaDGoESdXw4qUpJNh6Ya8/LU9H
	ghNwLQ==
X-Received: by 2002:a05:622a:1f13:b0:533:8900:4eae with SMTP id d75a77b69052e-55d76a168d0mr403124891cf.13.1795739839275;
        Thu, 26 Nov 2026 16:37:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm192115611cf.17.2026.11.26.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:37:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWjxm-00000005OdJ-0d4j;
	Thu, 26 Nov 2026 20:37:18 -0400
Date: Thu, 26 Nov 2026 20:37:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261127003718.GR246011@ziepe.ca>
References: <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
 <20261125190705.GN246011@ziepe.ca>
 <awfMy1d8ICL6mr9i@nvdebian.thelocal>
 <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>

On Thu, Nov 26, 2026 at 10:58:13AM +0100, Christian König wrote:
> Would it help if have a call on Teams or similar services to discuss the whole thing?
> 
> That might be easier and especially faster than by mail.

I think that is a good idea, I suggest you and Alistair should pick a
time and see who else can come. From experience eu/au/eastern na
doesn't jive :)

Jason
