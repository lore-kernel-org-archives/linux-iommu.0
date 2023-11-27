Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D753FDF
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Bu82Izlc"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AFAD41A6DDC;
	Mon, 27 Nov 2023 11:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079421;
	bh=7mEHQzLvt5ANszOUbDai1+OIHnL6YZTzhsqHHv6SGr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bu82IzlcjQk7yU+93aV8FsKw5tjv7diEHhh4QGS3Q3oVq8HU3lUGJlxLCLlpACUZU
	 ubG1awPJ92qMFDObCEa+80ICvZg0V5IuEblE45iMP4rH3KMpKiX7meKy4R5ymu4C/n
	 X0J7K9zPSNOMdJfA2Lp4+jcVwsmuUnzvuSK0+ptxSJ9rwfGDDN6vWge6nzHHKRqDSh
	 TcS1eFJLLuzSqAZPNd0A6E2mX27ZcDbMe5GcMlrcd7AoqRN8G9F6JS1oPu4aNrf1fG
	 fopS2epbj0g1XuoqA68twe9mEw27KexMPH4JHJ9PUPOOw0/PHlPxAdaYrgrXSyWcew
	 AcMKiPei/zBfw==
Date: Mon, 27 Nov 2023 11:03:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com,
	baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
	jsnitsel@redhat.com
Subject: Re: [PATCH v6 0/7] iommu: Retire bus ops
Message-ID: <ZWRpfKdkA0fsEu-J@8bytes.org>
References: <cover.1700589539.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700589539.git.robin.murphy@arm.com>

On Tue, Nov 21, 2023 at 06:03:56PM +0000, Robin Murphy wrote:
> Robin Murphy (7):
>   iommu: Factor out some helpers
>   iommu: Decouple iommu_present() from bus ops
>   iommu: Validate that devices match domains
>   iommu: Decouple iommu_domain_alloc() from bus ops
>   iommu/arm-smmu: Don't register fwnode for legacy binding
>   iommu: Retire bus ops
>   iommu: Clean up open-coded ownership checks

Applied, thanks.
