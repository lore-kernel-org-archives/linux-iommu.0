Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71F13AD5
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 09:04:37 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 129E31A1D87;
	Mon, 25 Sep 2023 11:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695632676;
	bh=mVN2siWq/+A4oehimH4/zFfXc1ZPW7A+Lys1w4Ln8aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGGkX447j2SD4e1l60zsxOL4PWn0J17VBsnPjM3Mas2j6RDYKNY+yq7MnonnyC8Kd
	 IAOqw95z0hzJH3hjTKhLR7eGDwCNJcqRSOLkop/LRd2LI9QCx0JmwsR44chiaKN69R
	 O+HOWWVpjLFxtUXbhoWQrF6+8kbhK1E4rnCvUGns+G+LJ9jH/MZEpREjO32b/b/6xe
	 Vpr72C+kGuGd004apbQtavDV6bFTr2ZhCRjQJc/bEvO9dad26ugXQm83YLJ4sySNmW
	 tdm0lcpjCzpSQ0G1B2s+ahEv/paSgY6xjlUqgG8HzLHVnb07B8U+9mx0vCe9VNx5Gx
	 WPsUsUZnUgpyw==
Date: Mon, 25 Sep 2023 11:04:34 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <ZRFNIsHmKpNmmOc7@8bytes.org>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922121812.GM13733@nvidia.com>

On Fri, Sep 22, 2023 at 09:18:12AM -0300, Jason Gunthorpe wrote:
> IMHO iommu drivers should not override this.
> 
> I think it was a mistake that iommu drivers could override to identity
> domains. If we need quirks then the core code should have the quirk
> list, similar to how PCI works.

Sounds reasonable, but if we transition over to an iommu core facility
for quirks, we must do it in a way that does not cause temporary
regressions for existing hardware.

That being said, Alexander, can you please test this series for
regressions on the older hardware to make sure nothing regresses there?

Regards,

	Joerg
