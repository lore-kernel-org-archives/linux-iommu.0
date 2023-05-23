Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5971C74C
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 06:26:34 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9932C2481A0;
	Tue, 23 May 2023 08:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684823193;
	bh=PRjIinwlO62Z38DPKedPiQioIsmBR7lM8yRZDg3jYtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifU74kFsAuq8c6tOPQQtxpVpG8N5xd/1ixox0Mdj43a/vwKK0/XUILIh0Etrobzn7
	 LuJs1DP1FJcXRKePLIgH3pPAW/GpzoeYL07PYS1i7TTNZEuyYb7Hca4HTPAuyEF31d
	 oKiwTeZIYmtPDlr/zhe3JxIfDgxPS6Nc65QEvAL23IFrIA6u0ZYky46s+za2nuPNSw
	 ez5RztQKPRQO+YaN8V76aCM9KTb4z+k0Bm3WxDgW7xsr9KU4Isy28HF0baX2/hq0/h
	 ZLt7VW7QscTOmtkMmFmaDlNLegk3htEB7QnbpcJqVn3naS+nEJa9HPLb4zu5I4DhBx
	 rBTpVJoWQUwdg==
Date: Tue, 23 May 2023 08:26:32 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, iommu@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 0/3] Remove iommu_group_remove_device() from fsl
Message-ID: <ZGxcmJ3vH0Smqqxu@8bytes.org>
References: <0-v2-ce71068deeec+4cf6-fsl_rm_groups_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-ce71068deeec+4cf6-fsl_rm_groups_jgg@nvidia.com>

On Tue, May 16, 2023 at 09:35:25PM -0300, Jason Gunthorpe wrote:
> With POWER SPAPR now having a real iommu driver and using the normal group
> lifecycle stuff fixing FSL will leave only VFIO's no-iommu support as a
> user for the iommu_group_add/remove_device() calls. This will help
> simplify the understanding of what the core code should be doing for these
> functions.
> 
> Fix FSL to not need to call iommu_group_remove_device() at all.
> 
> v2:
>  - Change the approach to use driver_managed_dma
>  - Really simplify fsl_pamu_device_group() and just put everything in one
>    function
>  - New patch to make missing OF properties a probe failure
> v1: https://lore.kernel.org/r/0-v1-1421774b874b+167-ppc_device_group_jgg@nvidia.com
> 
> Jason Gunthorpe (3):
>   iommu/fsl: Always allocate a group for non-pci devices
>   iommu/fsl: Move ENODEV to fsl_pamu_probe_device()
>   iommu/fsl: Use driver_managed_dma to allow VFIO to work
> 
>  arch/powerpc/sysdev/fsl_pci.c   |   1 +
>  drivers/iommu/fsl_pamu_domain.c | 123 +++++++++-----------------------
>  2 files changed, 36 insertions(+), 88 deletions(-)

Any chance someone can test this on real hardware?

Regards,

	Joerg
