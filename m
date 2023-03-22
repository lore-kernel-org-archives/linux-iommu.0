Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B848839
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:44:05 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DA85F242DBB;
	Wed, 22 Mar 2023 15:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679496244;
	bh=H6kJBq0FNN9bKpkCuiBclf0MG6YRfFs/T6O+tZOdJl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWI3u1g0e2DOH2cyowS1HWkSMsbPo0VcrFPcdIadToYm3ooqvOH8qJwzMvL+0XNfC
	 vfmhhG2iMaXkrrtvr30q8SULPDknkUFjzIvhIrrQ6tCqLUlA4uKViL65m/63bqnxhr
	 cssfPhg1aNNcxMe6KJ/NB4hUfqKu11LunRdj65M1FE5mXGZs6gnYHa/A25lqNNHA2b
	 Y+x9qdwkwF4qzOcgCkJdqf5fRdpaRKbw/qrYdZFAR10ehWjubQF6gM2Oc1q0KNex7X
	 QdKYYkUwdmKqOfsMviq5TyhRRFrniHCLUy0nXJnij+hg+6eeomEsmvh4WV46TJOBtj
	 VUkb9lbE9Jyfw==
Date: Wed, 22 Mar 2023 15:44:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, aik@amd.com,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 0/2] Allocate IOMMU irq/page table using numa locality
 info
Message-ID: <ZBsUM9SQjgUKjNPe@8bytes.org>
References: <20230321092348.6127-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321092348.6127-1-vasant.hegde@amd.com>

On Tue, Mar 21, 2023 at 09:23:46AM +0000, Vasant Hegde wrote:
> Vasant Hegde (2):
>   iommu/amd: Allocate page table using numa locality info
>   iommu/amd: Allocate IOMMU irqs using numa locality info
> 
>  drivers/iommu/amd/amd_iommu.h       |  8 ++++++++
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/init.c            |  3 ++-
>  drivers/iommu/amd/io_pgtable.c      |  4 ++--
>  drivers/iommu/amd/io_pgtable_v2.c   | 16 ++++++----------
>  drivers/iommu/amd/iommu.c           |  6 ++++++
>  6 files changed, 25 insertions(+), 13 deletions(-)

Applied, thanks Vasant.
