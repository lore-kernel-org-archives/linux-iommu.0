Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CE7F2
	for <iommu@lists.linux.dev>; Mon,  3 Jul 2023 05:30:30 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ893YGmz4wxW;
	Mon,  3 Jul 2023 15:23:21 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, Timothy Pearson <tpearson@raptorengineering.com>
In-Reply-To: <0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com>
References: <0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com>
Subject: Re: [PATCH rc] iommu/power: Remove iommu_del_device()
Message-Id: <168836167608.46386.6958520140413578635.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:21:16 +1000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 15 May 2023 21:12:31 -0300, Jason Gunthorpe wrote:
> Now that power calls iommu_device_register() and populates its groups
> using iommu_ops->device_group it should not be calling
> iommu_group_remove_device().
> 
> The core code owns the groups and all the other related iommu data, it
> will clean it up automatically.
> 
> [...]

Applied to powerpc/fixes.

[1/1] iommu/power: Remove iommu_del_device()
      https://git.kernel.org/powerpc/c/ad593827db9b73f15eb65416ec975ec0311f773a

cheers
