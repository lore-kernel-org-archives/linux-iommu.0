Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297B5663
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 13:42:20 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 28D312245E3;
	Thu, 16 Feb 2023 14:42:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676554939;
	bh=yOTiUP0Jwiv6lAYuLmeP8b3CGVgkw7PMeJqE90Xxj+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2L34TKAd+XrPb/18XNnKZpLr4BFEot2XeuXjTL0whTNiLrE1E7Cu88Aw926/WmiUt
	 0mPCi7JKC7lNZsx/lvvwUQYsiagESxyGCATaGsRMGk4fkX1/QHFBYTzrlsDZPqpLDz
	 NFVZYnfB0fiH83OEXdl+XJ/P6YYzofRu//INuUSZX9Qg0uFJskO3zFP8ETrpbSxsoJ
	 3HTb5QYWXGYX5+GnQa6BzMN0MbtefMtmxsixjGow0NXmzJGn8Yl3UmvqONLOhslQ1i
	 YC3eJDC/w8EOXPY+si49N6OXqFB+y410vEhzSIasZQ9okkZMaun35RivIP6TUAWBSA
	 GDgvyItR8k2mQ==
Date: Thu, 16 Feb 2023 14:42:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.2-rc8
Message-ID: <Y+4yuaciYYnptpKI@8bytes.org>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>

Hi Baolu,

On Thu, Feb 16, 2023 at 09:08:12PM +0800, Lu Baolu wrote:
> Below iommu/vt-d fixes are queued for your fixes branch.
> 
> - Two performance optimizations
> - Fix PASID directory pointer coherency
> - Fix missed rollbacks in error path
> 
> Please consider it for the iommu/fixes branch.

So nothing of this seems really critical (e.g. fixes a regression that a
number of people are encountering). Especially the performance
optimizations do not qualify as fixes at this stage of the cycle. I will
queue them in the VT-d branch so that they go upstream in the next merge
window, unless you convince me otherwise.

Regards,

	Joerg
