Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC712F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:38:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 4018F4CC; Wed,  6 Jul 2022 13:38:37 +0200 (CEST)
Date: Wed, 6 Jul 2022 13:38:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bo Liu <liubo03@inspur.com>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Handle return of iommu_device_sysfs_add
Message-ID: <YsV0POm9lLEbQyIB@8bytes.org>
References: <20220701062008.6988-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701062008.6988-1-liubo03@inspur.com>
Message-ID: <20220706113836.9pwqfmVltbth3uYm58Pi0T9qtzBfLasq4nLwnr75oIU@z>

On Fri, Jul 01, 2022 at 02:20:08AM -0400, Bo Liu wrote:
> As iommu_device_sysfs_add() can fail, we should check the return value.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/iommu/amd/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

