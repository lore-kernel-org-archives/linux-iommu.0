Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D613AEB
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wK6npJ2b"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 673DD1A6646;
	Mon, 27 Nov 2023 10:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701077261;
	bh=vQpNvz4tXNOtI3SlzAQTo7xVyAAZoeAnZPoiW7Qf4yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wK6npJ2bcjwrxH2HlnrnFuv3U6BXMzV9ySKpHZ/ytEtanu18iYp44zYiEtdrNqnKg
	 n6OxL3FoUAxP+sa6K3aj8GpIgusAMtDAPARHcgyCpX6CCy3IrC9aGQnsfaWnzxxw0Z
	 aGQcSKI0Tx18jy3ac7oS7YIDUTmkIlcbgn6Lz7d0Zcll7Zrb/KWjFmn6KYovkJu9+I
	 6fO9BOzaPPK/CllYtcYn2occgUdM4L3iuVAkZiCON1QpvmrlbC0zN7Sps8zLkwWgkG
	 sACRHpl+ORx50VUR4T5Co7YdINguOj7wXtHbtI+/tyNahHL3+YgzLNdeMsiJT0NICT
	 gsgPimnep7BUw==
Date: Mon, 27 Nov 2023 10:27:40 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Baolu Lu <baolu.lu@linux.intel.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] iommu/tegra-smmu: drop error checking for
 debugfs_create_dir()
Message-ID: <ZWRhDMgPCjP_hlZW@8bytes.org>
References: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>

On Wed, Oct 25, 2023 at 05:25:58PM +0200, Dario Binacchi wrote:
> The return value of debugfs_create_dir() should be checked using the
> IS_ERR() function. The patch, however, drops the check statement without
> fixing it because the subsequent functions (i. e. debugfs_create_file())
> can handle the case where `@parent` is an error pointer.

This deserves a comment in the code explaining why no error checking is
needed.

Regards,

	Joerg

