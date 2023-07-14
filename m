Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCC63D6
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 12:53:45 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E4E6428012A;
	Fri, 14 Jul 2023 14:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689339224;
	bh=lkD8TmGSRaY9Zn5gN70FLIyunGvFhzFcj6rPT2CTADs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nk40X6UxAFy1QYjV+Tqa3NJSjxL/7dRhvbgOy4nzdUSEZHB2mOrzIXVTsam89YBuK
	 FMRFrGj8gs9EtFUTCo2kRB6At0LWM3i18glYtI2DKoazhu4dlo7JhrZFRoduOxHfbW
	 sVbxqpxbS3Lhgnz1BgUpIYyIP7+r8zhhR2IzD9IZ0cK8YTMKHjDunj5r/+HowrRI3W
	 w8omSGtALWCOQncKIREdMEPT7VWFUEXhb7Th3s63s33X3VDmbEpg6eZewTAzZoBwpE
	 B704qtCUuysOtNCgK7/pZCayRikFZgBXv55BrzyRfwaGb4Zi7qHFquzEM1TKo1K0+K
	 7hd+ZIW+2q34w==
Date: Fri, 14 Jul 2023 14:53:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Will Deacon <will@kernel.org>, Dan Carpenter <error27@gmail.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: fix signedness bug in iommu_sva_alloc_pasid()
Message-ID: <ZLFFVrGB3hjZhr2B@8bytes.org>
References: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
 <5e474464-34ee-414a-8eb3-b11e74540b14@kadam.mountain>
 <20230710092713.GA32673@willie-the-truck>
 <5574a5bc-e108-4206-b189-03ec79bc08ec@kadam.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5574a5bc-e108-4206-b189-03ec79bc08ec@kadam.mountain>

On Mon, Jul 10, 2023 at 12:34:19PM +0300, Dan Carpenter wrote:
> I should probably resend this?

No, just applied it, thanks.
