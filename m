Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9E20E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:10:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id BF661AEE; Fri, 15 Jul 2022 10:10:32 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:10:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
	will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2] iommu/virtio: Add map/unmap_pages() callbacks
 implementation
Message-ID: <YtEg9kwPoIH+p/5u@8bytes.org>
References: <20220605161152.3171-1-tina.zhang@intel.com>
 <YtEbCYzOQ8TN9idm@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEbCYzOQ8TN9idm@myrica>

On Fri, Jul 15, 2022 at 08:45:13AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jun 06, 2022 at 12:11:52AM +0800, Tina Zhang wrote:
> > Map/unmap_pags() allows map and unmap multiple pages of the same size
> > in one call, which can improve performance by reducing the numbers of
> > vmexits. With map/unmap_pages() implemented, the prior map/unmap()
> > callbacks are deprecated.
> > 
> > Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Patch is now applied, Thanks Tina and Jean-Philippe.
