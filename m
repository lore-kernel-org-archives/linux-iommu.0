Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303238DC6
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGj0dv/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04985C43397;
	Thu, 12 Oct 2023 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697134033;
	bh=eVbB8xX35Yk0N11tWIGxUMld6J8/6Xc4vSFxzS1n4Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGj0dv/q+NZ1Q50USGtzh4/zIIRdBFRLv0dv2svogvgypbDIzIlkDzAnCrL23bfPW
	 hjGV+S/OVa37uoalmRq9YnJHJfsNA8P/7q9a2PPW3BsimtEgb7F5lPoCr3ITHs2P7r
	 vB0EXOm2P7Tylf2NIjnV+K6vaDCXbWGUxFEf18MtNrz2Q6EL2lFwiHgYiYe7hp81ff
	 nJOEi909BaRxXuhVyHBPAW/PwttqZVh3S3/4MzETr4HxICBLZ+Tv64rm2qOAH+q/nh
	 JG+mvRD6QrTgjpG4j4DnT9Jfgu/O1ZKPaPwuTqpHEEuOd0RhlWmDi2jBA1hrzKwHXa
	 Qzjk7YDvEaWBg==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Shavit <mshavit@google.com>,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Tomas Krcka <krckatom@amazon.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	nicolinc@nvidia.com,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	Alistair Popple <apopple@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Dawei Li <set_pte_at@outlook.com>,
	jgg@nvidia.com
Subject: Re: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
Date: Thu, 12 Oct 2023 19:06:48 +0100
Message-Id: <169712689838.645382.14628592932614139960.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
References: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Sep 2023 21:17:31 +0800, Michael Shavit wrote:
> This series refactors stage 1 domains so that they describe a single CD
> entry. These entries are now inserted into a CD table that is owned by
> the arm_smmu_master instead of the domain.
> This is conceptually cleaner and unblocks other features, such as
> attaching domains with PASID (for unmanaged/dma domains).
> 
> This patch series was originally part of a larger patch series that
> implemented the set_dev_pasid callback for non-SVA domains but is now
> split into a distinct series.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/9] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
      https://git.kernel.org/will/c/987a878e09c6
[2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
      https://git.kernel.org/will/c/1f8588834016
[3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
      https://git.kernel.org/will/c/e3aad74c51a7
[4/9] iommu/arm-smmu-v3: move stall_enabled to the cd table
      https://git.kernel.org/will/c/1228cc509fc6
[5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
      https://git.kernel.org/will/c/24503148c545
[6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
      https://git.kernel.org/will/c/10e4968cd511
[7/9] iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
      https://git.kernel.org/will/c/5e14313df2c8
[8/9] iommu/arm-smmu-v3: Update comment about STE liveness
      https://git.kernel.org/will/c/6032f58498b7
[9/9] iommu/arm-smmu-v3: Rename cdcfg to cd_table
      https://git.kernel.org/will/c/475918e9c4eb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
