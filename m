Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F77F
	for <iommu@lists.linux.dev>; Sun, 11 Sep 2022 06:25:51 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CD688401A0;
	Sun, 11 Sep 2022 08:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662877543;
	bh=1u59/s/UPIf0SfmIB1VHSvZNbjfTczSGhXuqMgzxONc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9K0vzpWLinvRDDMOcBZ0lkqkZkHwWDn0EdNRFdGQcfF9mpBN+/oRfVf7zcZ/uIAL
	 Q9hUoUr3/qB8WDxzFZpLKW6YbIZOIzuaHRIwg9JmnkJo54etBUOkcwujuZLFd5dNC+
	 hDXbwlOSHO6cXO23X5iIdXlP3tbdWBp6sJcEz8W2uDI8uy9wsGtNKi/te4lAfksjo8
	 C5+2z6Bsi2NuZ1i1wsZeoHvE2W6bAgrXu7Cvc4UpRUcCyruMhdwRbBUOeVlULGZA/F
	 9YqGNxe6lp/16xl9JVYmO/HbvYnzIvthDt/2i/AfICrQ+4EF/2CcIeO5Y7bP7VWRix
	 dMyGabThVl2qw==
Date: Sun, 11 Sep 2022 08:25:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/1] iommu/vt-d: Fixes for v6.0-rc5
Message-ID: <Yx1/ZolNr6IetMoz@8bytes.org>
References: <20220911031845.893192-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911031845.893192-1-baolu.lu@linux.intel.com>

On Sun, Sep 11, 2022 at 11:18:44AM +0800, Lu Baolu wrote:
> Below fix is queued for v6.0-rc5. It aim to fix:
> 
> - Fix possible recursive locking in intel_iommu_init().
> 
> It also eliminates the issue highlighted in commit c919739ce4721
> ("iommu/vt-d: Handle race between registration and device probe"),
> which has been pushed to linux next.
> 
> Please consider it for the iommu/fix branch.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (1):
>   iommu/vt-d: Fix possible recursive locking in intel_iommu_init()

Applied, thanks Baolu.
