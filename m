Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C563B5
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 09:14:45 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C3D2B280529;
	Wed,  9 Aug 2023 11:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691572478;
	bh=SGxaJRH7ruuDkqvomeeEvIWwJeZf2ep0TTSd6UxpuLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y1kTi8n89+pbnGPvUliMJbKlprUY7d3zJ/Cgtp+m4T53/SRit/CYyT4JpgVIr1kmV
	 V2QgTVenXmjVgLbkErSu3AkNicNMsR7J304uYD+2k5au2NQpaBTG/nvQ9YcUYJllt/
	 yh4QvhPvP/rGTCcP5jQIySJDir6PZVJLL+x93A38w8P6ckxD07tIUG4FW/j3h7tE0r
	 dhHZwdil1tZc1MrfH+vBzU/jisPEk/DV9+dFdBVxciI7fxIx4479og2P+iCi+TE9rK
	 yrGIHHI7Ry3dA4qDbx1wBvM0qnAoTaLqgWxZlm98NvFYsyLIfmQkkfzPBUX4stvXNK
	 X7CdSOd2qXkJA==
Date: Wed, 9 Aug 2023 11:14:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 1/3] iommu: Provide iommu_probe_device_locked()
Message-ID: <ZNNY_NP-dCvSoVa7@8bytes.org>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <1-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>

Hi Jason,

On Tue, Aug 08, 2023 at 02:27:05PM -0300, Jason Gunthorpe wrote:
> Fixes: a2dde836050f ("iommu: Complete the locking for dev->iommu_group")

The right commit-id here is: a16b5d1681ab

Please update the fixes tags and re-send after addressing Kevin's
concerns.

Regards,

	Joerg
