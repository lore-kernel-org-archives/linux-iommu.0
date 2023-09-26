Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911330FA1
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 16:08:35 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-49a885c5961so1208e0c.3
        for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695744514; x=1696349314; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oDat+15Yv8jvHk03dbPKuk8zwd+AnRHF/euH49EJVQ=;
        b=F+8ytQ4T4mrjhevvFxDynTYOXa3OJ4NpfISo4iKdfmWkSmy6bwI0o5U8bx58bD31WZ
         S+s4oau84wS4FY5S4OrD1IxerH0G1SdviD3xGv3qJaUqs+4pUR1GXWCthlR0Jymtm8v6
         JL4nqJPDDOzAVIocwhzTkK2dE0VWo8fWyUncYvmeWBZET6Vy9y8SIWzxCgCmR4MwHkPK
         0Y53WeGuVLTvHs/JganVxNqaahMbAo2Cuby2jX+cgF7191DZEbYfMjXpGqgauMski/Zl
         O/Rr3+dVuVCvBl2p/75rg4yEAWS5ML8V/KLpu2XS8p7KD5M/uRe4lVBPpUMdygC28JUa
         00ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744514; x=1696349314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oDat+15Yv8jvHk03dbPKuk8zwd+AnRHF/euH49EJVQ=;
        b=iZ2omnLtdS8DgfXeX0VBSmnDCh0tPb19QUHAhCiF5/y5VhFY5LgAF6wLUa13uKZu5I
         /7gvmDSmMSH+JLRyXB7vYGYFNhBtVWWUN5jXq2zpKczaVtJ4u0YVYX5oR/p5KD46WnWY
         7YRqb0oLilO/NjTdAzB2kZLAg0Wap2nsnsNcd+il7DJc18mOWc/nyGCYMgdI/JTDKjcm
         +YUsYcJfPwRAGQpdT2HttFhnp8BcrPeyVaossHEaiIndcinrDyiTCPQlV46YJNYh17hi
         TRhGzjseaLyLTRlgknbpkPYZRkgCt6+x+beSef+55F2ZLS/UU2mrVlZrpF3Tq4qm2jKd
         zhEA==
X-Gm-Message-State: AOJu0YwvuxWyMFzkyPyx+AvxNmX/Ny88pkRAPRqMkJWXDiJs0mgyQ8jT
	O4lVkC5NVetIf5O6RdBFydgKcw==
X-Google-Smtp-Source: AGHT+IFDQgBrhIPwgsFhbivVL+D36TCzBymyRjeSj3OWewpTHgWhOtDO4u30/jSZ3MjQP6HcqK5sVA==
X-Received: by 2002:a1f:c582:0:b0:48f:9778:2b9f with SMTP id v124-20020a1fc582000000b0048f97782b9fmr6177336vkf.11.1695744514328;
        Tue, 26 Sep 2023 09:08:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cb2c8000000b0065b13180892sm1817688qvf.16.2023.09.26.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:08:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qlAbw-001Evg-HO;
	Tue, 26 Sep 2023 13:08:32 -0300
Date: Tue, 26 Sep 2023 13:08:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Will Deacon <will@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Pierre Morel <pmorel@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Message-ID: <20230926160832.GM13795@ziepe.ca>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
 <ZRLy_AaJiXxZ2AfK@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLy_AaJiXxZ2AfK@8bytes.org>

On Tue, Sep 26, 2023 at 05:04:28PM +0200, Joerg Roedel wrote:
> Hi Niklas,
> 
> On Fri, Aug 25, 2023 at 12:11:15PM +0200, Niklas Schnelle wrote:
> > Niklas Schnelle (6):
> >       iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
> >       s390/pci: prepare is_passed_through() for dma-iommu
> >       s390/pci: Use dma-iommu layer
> >       iommu/s390: Disable deferred flush for ISM devices
> >       iommu/dma: Allow a single FQ in addition to per-CPU FQs
> >       iommu/dma: Use a large flush queue and timeout for shadow_on_flush
> 
> Turned out this series has non-trivial conflicts with Jasons
> default-domain work so I had to remove it from the IOMMU tree for now.
> Can you please rebase it to the latest iommu/core branch and re-send? I
> will take it into the tree again then.

Niklas, I think you just 'take yours' to resolve this. All the
IOMMU_DOMAIN_PLATFORM related and .default_domain = parts should be
removed. Let me know if you need anything

Thanks,
Jason
