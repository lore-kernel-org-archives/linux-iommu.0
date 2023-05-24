Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE715D0
	for <iommu@lists.linux.dev>; Wed, 24 May 2023 05:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DBC433EF;
	Wed, 24 May 2023 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684907074;
	bh=BAIEHKqWdw+wiFDljo7B9HdVaW+uTTTgwVeC0xa0/ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHUMXZt2BKIzx0FxwovB47fimiy4gupnFQON8FyBp2umdWGOZJafZc2PciYaqPyL/
	 18/1fL5ttqnT/pVs2mnirkPLZaR7vEGCYJAfxGasl9Oaqk36/cmhC6+qVHnvFsNwix
	 jHW3+XsOPA7BXqjtSHcd1cV+s55xQqL9m9yiEewEHh9Xp6Dj5D1U70pTbUColbo40T
	 EkZt2OFrJ7BcbbG5hAeHme6kRcSsJM1k25BMINl4kR1fDwumiAXY89WwtFOWypCFai
	 bpfdDbfFFCxixf7IMvy2mZiteUnRCZD9VY1Rtp1JT4Gl9YLPxGApALXwKf/kRJZHA7
	 NddS8fUQz49hQ==
Date: Wed, 24 May 2023 11:14:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	dmaengine@vger.kernel.org, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	narayan.ranganathan@intel.com
Subject: Re: [PATCH v7 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <ZG2kPbwMmW4B2PFB@matsya>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-5-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523173451.2932113-5-jacob.jun.pan@linux.intel.com>

On 23-05-23, 10:34, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now that we have the support for attaching PASID to the device's
> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
