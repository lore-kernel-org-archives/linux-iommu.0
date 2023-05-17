Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B89156E5
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 12:10:19 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QLsPB3yCGz4x1f;
	Wed, 17 May 2023 22:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1684325410;
	bh=Ugo6kiXu55PcZr+hR/ZzjsX8h/mgEpTIvZm7PzEg/B0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZyvRzNxZDgTENMcc7SO6HSQZLRnklkuNI5jYSrlwk6eDS9QWzDhA4Mlg+TUDrpiUK
	 wLpbE3kCiyIHkalylcZ0heknZPBtx/6ufj6LVXv6Zj89y1P0n8uorniOzcD0tebJKW
	 UG/Nfr88ShLGuN4YKxkgvLtg/vif8ZiijQOiI6nxnzXmbxkTfHjzskwg0MK4oyjAZQ
	 rAvNZoXbvkvoQR4Q8o0Ljv6XOUkz5ihAvg/QZkSHSJ3kXNH0qx6tUA9GJDATpQ1lbS
	 0OlPwkxkLKqlJ9DRBdQSPVdSl92FxvY62sOUMHoaMius03AxgJtWhcVPjKg4ULpYil
	 2tzwTdFSumZTA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Nicholas
 Piggin <npiggin@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson
 <alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, Timothy
 Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH rc] iommu/power: Remove iommu_del_device()
In-Reply-To: <0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com>
References: <0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com>
Date: Wed, 17 May 2023 22:10:05 +1000
Message-ID: <87ttwbyx9e.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:
> Now that power calls iommu_device_register() and populates its groups
> using iommu_ops->device_group it should not be calling
> iommu_group_remove_device().
>
> The core code owns the groups and all the other related iommu data, it
> will clean it up automatically.
>
> Remove the bus notifiers and explicit calls to
> iommu_group_remove_device().
>
> Cc: iommu@lists.linux.dev
> Fixes: a940904443e4 ("powerpc/iommu: Add iommu_ops to report capabilities and allow blocking domains")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/powerpc/include/asm/iommu.h       |  5 -----
>  arch/powerpc/kernel/iommu.c            | 17 -----------------
>  arch/powerpc/platforms/powernv/pci.c   | 25 -------------------------
>  arch/powerpc/platforms/pseries/iommu.c | 25 -------------------------
>  4 files changed, 72 deletions(-)
>
> Michael, please take this on the PPC tree to -rc thanks

Will do, thanks.

cheers
