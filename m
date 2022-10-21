Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6377E
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 08:55:36 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D0178242598;
	Fri, 21 Oct 2022 10:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1666342201;
	bh=cfUwgLtB39hN+mxHSysvq+yWIatvClQidnX8Cm/4Wl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fi6NSOqWAegHInoG7ee0kItylfJTR1WSMcJuy+C2Xu3d4q9h4yCOsoITPPuOipl50
	 Eh/gRKzhiljtdQLQdUj7LxsljH1TpeTwPFK4w1tAhdV4wqqrzvwylvvle8M3kI7GvX
	 zPhYKhJ+oTohpMUfokdMHRq7EQc+Dw9h14r8pygFH7nNh4n0T0Eyu7fT/9uFUUaWRc
	 HZrwCWXsKGQuU2HYd+GHv/9BMVAtcaVpUCUyvFAxFCm4x8uYRo+4rX0Pj12s6jz1UL
	 WU/D4+XWV0pcejhYt7rO3iscv9kygmrsNgZoPnHP3hmnwr2xmXhGaAIDWrIapIHkC8
	 3j/y8Fl+FFaEw==
Date: Fri, 21 Oct 2022 10:49:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
	Charlotte Tan <charlotte@extrahop.com>,
	Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc2
Message-ID: <Y1JdN+UchhONn0Eh@8bytes.org>
References: <20221019004447.4563-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019004447.4563-1-baolu.lu@linux.intel.com>

On Wed, Oct 19, 2022 at 08:44:43AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> Below fixes are queued for v6.1. They aim to fix:
> 
> - A lockdep splat issue in intel_iommu_init().
> - Allow NVS regions to pass RMRR check.
> - Domain cleanup in error path.
> 
> This series is also available at github.
> https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc2

Applied, thanks Baolu.

