Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E71FA2
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 08:23:52 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A2DC7241329;
	Wed, 21 Sep 2022 10:23:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1663748631;
	bh=MYuHxvj/Q7zzlHiVuddhFHKtriP8Yz93gdzqFp+IyHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hb7mYU+nLEwDcPzlVhhlWLt89ynFoUxcdvt45QhBTsi4M8gUCAHTZahBafKYMTSOl
	 u858776kY48iBdsAoT9UoMcG5gk1DP3DR7i7lRBFX8corFueOJk9pHt7KfiHGGQw5h
	 kv14FtXc/sMIAZKxbPHDmEpGB6kEaBT5U5cfQTZBMWqU46by53aTe6kPHYeGpviwMz
	 3FBRP2quwVcDhVHx0L1VMNBeqyz8nTxVKHFzgvs6ya2L2LnKuwZUtaonRn+2qnmhhO
	 84WuvbVQ4uW8yW7ZqdwJ7U8FY+5FPu3lQhb+B7oKFmqLOpt6MorXX5618YbdIGauD/
	 BhcYReHZcXDOg==
Date: Wed, 21 Sep 2022 10:23:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	George Hilliard <thirtythreeforty@gmail.com>, iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fixes for v6.0-rc7
Message-ID: <YyrKFpqgrp3zyzx4@8bytes.org>
References: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921024054.3570256-1-baolu.lu@linux.intel.com>

On Wed, Sep 21, 2022 at 10:40:52AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   Revert "iommu/vt-d: Fix possible recursive locking in
>     intel_iommu_init()"
> 
> Yi Liu (1):
>   iommu/vt-d: Check correct capability for sagaw determination

Applied, thanks Baolu.
