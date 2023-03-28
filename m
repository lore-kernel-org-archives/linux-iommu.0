Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349079C5
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:32:10 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ECF3C243E1F;
	Tue, 28 Mar 2023 15:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680010330;
	bh=7wUFTu4/KeEPid3gvWJLapKraOrnVbtw5ZOtA5BQpIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iS6ir4opysvKaaRBLtZiSmdarVZtO6yRZfCp/s1hiTCjfJ5QOIPBhIKNIfyAbNZE1
	 +94Y5+iEDIbRG3obEX/Oe6LlE51exzXnfQi15njmG4wkiiX8tLTa63MLgL0SobLYUi
	 8qq+KypATXFZDAMUSqjdH2u3nYOk14rTiiUv+Mo6+RIEKy2/aYIu6Ud2ux+eiMxRBB
	 TXDTJ1GMiLudXzcZrFvS8jodiwlgxRp9Gnky/S8TEWeYi/1lrmhJ0vGbfNqzjGK3lB
	 QyZvAKkj0pC6rMmz/FSorTjaBfXbTYPqlyxoLdpBpTcsft4NGUZYYkdFn3xdBST5s3
	 96oGncoIvqVsQ==
Date: Tue, 28 Mar 2023 15:32:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH] iommu/amd: Add 5 level guest page table support
Message-ID: <ZCLsWKnZdI1h44vt@8bytes.org>
References: <20230310090000.1117786-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310090000.1117786-1-vasant.hegde@amd.com>

On Fri, Mar 10, 2023 at 09:00:00AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
>  drivers/iommu/amd/io_pgtable_v2.c   |  9 ++++++---
>  drivers/iommu/amd/iommu.c           |  5 +++++
>  5 files changed, 40 insertions(+), 5 deletions(-)

Applied, thanks.
