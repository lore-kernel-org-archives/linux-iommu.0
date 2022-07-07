Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25534362
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 07:41:47 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id C1678423; Thu,  7 Jul 2022 09:41:45 +0200 (CEST)
Date: Thu, 7 Jul 2022 09:41:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 RESEND 00/35] iommu/amd: Add multiple PCI segments
 support
Message-ID: <YsaOOBuJZSUT1C2B@8bytes.org>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>

On Wed, Jul 06, 2022 at 05:07:50PM +0530, Vasant Hegde wrote:
>    As discussed in other thread, I have updated "From:" tag and
>    resending patchset. No changes in the actual patch content.
>    This patchset is based on top on "iommu/x86/amd" branch.
>    Base commit : 0d10fe75911787 ("iommu/amd: Use try_cmpxchg64 in ....")

Replaced it in my tree, thanks. I now also added a hook calling
checkpatch, which should catch such problems before I push the tree out.

Thanks,

	Joerg
