Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D153B5
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 13:15:27 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 182AD40793;
	Wed,  7 Sep 2022 15:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662556526;
	bh=AIfvvYnil4b62COaF5XYoCQGAUh2LfQZk3YCm2nfDgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YV3Ej0xEVxd+KYgvdbAluGke5WZqAQNYh6jfFfIL3dIlH1EcA6ee/t5/LCNnpSTnk
	 NAjNaYR+vu7Qyt/FnJNWcv+6OO/1n/DoM9+JZP0AD7Co3x8yVOJGIy+0/gF2RPED7k
	 G0c7Xm9c37cH9JOQON0w4sKIY9DYFCxeqgyUN8/aFQwwE7o8htRok5Fc+Z967n8hh4
	 4z7aeoPBRITsmrVXMqKx9AP47Xsn2axmGKmrdD9aYmhtJAVrUSsQE1eTEqXyvx0X41
	 eFo4SogU7vNCG3Gn4Zppg997MH9s/YDoOakCl44k9t8Q9uv2btTc5ZPvEus1FKZoRw
	 p0bh61OVIDqLg==
Date: Wed, 7 Sep 2022 15:15:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>, Wen Jin <wen.jin@intel.com>,
	iommu@lists.linux.dev, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/4] iommu/vt-d: Fixes for v6.0-rc3
Message-ID: <YxiZbGucnalhwdlJ@8bytes.org>
References: <20220823061557.1631056-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823061557.1631056-1-baolu.lu@linux.intel.com>

On Tue, Aug 23, 2022 at 02:15:53PM +0800, Lu Baolu wrote:
> - Boot kdump kernels with VT-d scalable mode on
> - Calculate the right page table levels
> - Fix a recursive lock issue
> - Fix a lockdep splat issue

Applied, thanks Baolu.
