Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D52F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:31:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 626004CC; Wed,  6 Jul 2022 13:31:09 +0200 (CEST)
Date: Wed, 6 Jul 2022 13:31:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.garry@huawei.com>,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/iova: change IOVA_MAG_SIZE to 127 to save memory
Message-ID: <YsVyfB8ygYm7owJo@8bytes.org>
References: <20220703114450.15184-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703114450.15184-1-feng.tang@intel.com>
Message-ID: <20220706113108.GAlthXXpRBzk4zUPUpTRUofERUd-URvAW7Uy2iv4sbs@z>

On Sun, Jul 03, 2022 at 07:44:50PM +0800, Feng Tang wrote:
> kmalloc will round up the request size to power of 2, and current
> iova_magazine's size is 1032 (1024+8) bytes, so each instance
> allocated will get 2048 bytes from kmalloc, causing around 1KB
> waste.
> 
> Change IOVA_MAG_SIZE from 128 to 127 to make size of 'iova_magazine'
> 1024 bytes so that no memory will be wasted.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks.

