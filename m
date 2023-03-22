Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE08C01
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:47:53 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8CA95242E0C;
	Wed, 22 Mar 2023 15:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679496472;
	bh=e6ntdoYKIlmy8eZXXKM/yz6f+rfPawT8id1Orru0Mng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UelYpbZW8XKyweH59YjIRsv7gF2+/dQ3z8w4Pqkqagzd+6OZPeQGFJrIjg5kVJ0zz
	 IOV+eubMUHtnntuqCia7UHO5E7N+IHXl2VITQyheSxhmIX8LMlT3JzyeJVNXyi/c0+
	 dOeV9m1gB+Fp3q4Oan9DK9Wb1D98emrHU2EOaDfR1ATTZ+wPYZ4cVu2iwJfFTxVaoN
	 62KWu4jfvJKZkx51rO83uIwQprWUM3BRqX2LG6qiDLyFNHucbqNPgM/MPKN0S/2LlA
	 gTtxFxv9JTh5qhHpQcFQdoJzVAmQuwPtW7VE3WSEIzdp0QyD1y0+vyiv6SLj3Vg4U5
	 1l+giSVQxIMOQ==
Date: Wed, 22 Mar 2023 15:47:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Use sysfs_emit() for sysfs show
Message-ID: <ZBsVF+WJbsCip22A@8bytes.org>
References: <20230322123421.278852-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123421.278852-1-baolu.lu@linux.intel.com>

On Wed, Mar 22, 2023 at 08:34:21PM +0800, Lu Baolu wrote:
>  drivers/iommu/amd/init.c    |  4 ++--
>  drivers/iommu/intel/iommu.c | 17 +++++++++--------
>  drivers/iommu/iommu.c       | 31 +++++++++++++++----------------
>  3 files changed, 26 insertions(+), 26 deletions(-)

Applied, thanks.

