Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269F2566
	for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 08:31:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id E2AB7669; Fri, 29 Jul 2022 10:31:33 +0200 (CEST)
Date: Fri, 29 Jul 2022 10:31:32 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org,
	jsnitsel@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 0/2] iommu/amd: Misc Update for Virtual APIC support
Message-ID: <YuOa5Eyl4KLGoSRO@8bytes.org>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>

On Tue, Jul 26, 2022 at 08:43:46AM -0500, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (2):
>   iommu/amd: Consolidate Virtual APIC (AVIC) Enablement
>   iommu/amd: Add support for AVIC when SNP is enabled

Applied, thanks.
