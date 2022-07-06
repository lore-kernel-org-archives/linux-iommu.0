Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBCF2F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 10:59:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 0DCF44CC; Wed,  6 Jul 2022 12:59:42 +0200 (CEST)
Date: Wed, 6 Jul 2022 12:59:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/1] iommu/vt-d: Fixes for v5.19-rc4
Message-ID: <YsVrHVlLkMzj7c/s@8bytes.org>
References: <20220625133430.2200315-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625133430.2200315-1-baolu.lu@linux.intel.com>
Message-ID: <20220706105941.3rv_GDD3704vq0ainiqOEKSKNwAVAm-mWWyTBjL-8xc@z>

On Sat, Jun 25, 2022 at 09:34:29PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> One fix is queued for v5.19. It aims to fix:
> 
> - RID2PASID setup/teardown failures for pci alias devices
> 
> Please consider it for the iommu/fix branch.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (1):
>   iommu/vt-d: Fix RID2PASID setup/teardown failure

Queued, thanks Baolu and sorry for the delay.
