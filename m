Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D702F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 15:39:44 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4FD10262367;
	Fri, 13 Jan 2023 16:39:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673624382;
	bh=YDfxpt0cdkCktdyoWj0qryvee2/dgrIzq9fi9Mg/+VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1vS6cWGh9Q9eIut99rRq8Qx8ZszNRKfZFptjFcqz8DDRIN6tOfhSIIvSLNnGwlI7
	 2dXJu7U1bIflnsGAseIR4H1ARzjjuwQG4LbYokXopnjzeVYOHYh07r8sVMUIbdU4Cw
	 PeLFsgVRmzlKZp2DwfVDu7Lq2/J+demEIuBzp5PR2TUp5TUiFip1i/yNIS4nbj4CVi
	 CUi3QLYja3omKQ+Aa2BMA2mvZvriRMn1NAn8I29RlDwlVVzNGlbvzmcV25NpuhPio9
	 EzDEQ0GdtLWiYwvH7jjR+uB7bSsbhzXY2t6a848eZAIYlKSj5/R41kuy26FGqFlKsc
	 SwQaIhY0P+Vyw==
Date: Fri, 13 Jan 2023 16:39:41 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iommu: Retire detach_dev callback
Message-ID: <Y8F7PRT6JNXekXVO@8bytes.org>
References: <20230110025408.667767-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110025408.667767-1-baolu.lu@linux.intel.com>

On Tue, Jan 10, 2023 at 10:54:03AM +0800, Lu Baolu wrote:
> Jason Gunthorpe (1):
>   iommu: Remove deferred attach check from __iommu_detach_device()
> 
> Lu Baolu (4):
>   iommu: Remove detach_dev callbacks
>   iommu: Add set_platform_dma_ops iommu ops
>   iommu: Add set_platform_dma_ops callbacks
>   iommu: Remove detach_dev callback

Applied, thanks.
