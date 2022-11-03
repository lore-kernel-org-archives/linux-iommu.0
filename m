Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5507481
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:41:18 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A1ADE260071;
	Thu,  3 Nov 2022 15:41:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1667486478;
	bh=Zoh7PjkniCROsKV5e1IiT69/vOGMxEKbV1MJXsNEcR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VR7CW32QpMxjsIds88tibL5y1SMHxk/hOdswx0uKA+olVQnPSbbasN7FIv4UDtr6i
	 lRic9te3uZzh/rwt/9xJNT6eDciU9thwOLWqnqv3cmAGqPOoJijch+PcXNOcxK2Pst
	 dAef872cSW8/0+8q/FZdOQUUNUV77RbgQD2LsZgczOMDQBO917JDl+at1UefULUfd7
	 QXsKCoMpV+vbTJkI+iMnJTGNkX6DHuTlAmOvqSmQMP/6ui4KhVhKSPqaEZRYvNt6UN
	 606xja22rU243M20WUVf1zKtcUx4mxHH4N0gHF8JTFkZkhXp6+xB3BVbeQY0gETaLa
	 EgE36aa05f7Nw==
Date: Thu, 3 Nov 2022 15:41:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
	borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, linux-kernel@vger.kernel.org,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v8 0/6] iommu/s390: Fixes related to attach and aperture
 handling
Message-ID: <Y2PTDOHjwvy+IjGg@8bytes.org>
References: <20221025115657.1666860-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025115657.1666860-1-schnelle@linux.ibm.com>

On Tue, Oct 25, 2022 at 01:56:51PM +0200, Niklas Schnelle wrote:
> Niklas Schnelle (6):
>   iommu/s390: Fix duplicate domain attachments
>   iommu/s390: Get rid of s390_domain_device
>   iommu/s390: Fix potential s390_domain aperture shrinking
>   iommu/s390: Fix incorrect aperture check
>   iommu/s390: Fix incorrect pgsize_bitmap
>   iommu/s390: Implement map_pages()/unmap_pages() instead of
>     map()/unmap()

Applied, thanks.
