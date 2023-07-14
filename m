Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94107E4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 12:49:59 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5316428012A;
	Fri, 14 Jul 2023 14:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689338998;
	bh=pKXx/tlSBfreSTW9jJ+NT3bmQgDrV9UO7FfmAG9i2dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niDvHZdsvAm8y3EBx7zpohWiNRJXCeVZXwM/svrMLLcvZ4R1+dyqW2oR2nQKi54YS
	 lP3eDHK7+VEDsTG9NXxOSv5EPUy88HhyPg9R26Lvk+0gJqzXDykQDSfjS8uTs6I4q8
	 GqBlcaTtrNU6MdiZF2C00eDd3Djrxont/8OT7kRCDPbqxX1oM8hs3xmo8F7bXFUeiz
	 4QltoNko2qyCaFt3NPh5rcGaGxy/sirzXXP9XZoWW+Rwk6Z+FzDbe37KcruOBWY66M
	 4PliPdPTmpZI4VF51XfSv8UKuFeGV/r3JmVXUooAlknRnh3TskjTFc4JDaXLWaifZK
	 6CXQq5PD58yVg==
Date: Fri, 14 Jul 2023 14:49:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Message-ID: <ZLFEdfuppoWbRsLj@8bytes.org>
References: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>

On Mon, Jun 26, 2023 at 12:13:11PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/iommu.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Applied, thanks.
