Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8EF24B50
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F01B68B05; Fri, 15 Dec 2023 12:30:14 +0100 (CET)
Date: Fri, 15 Dec 2023 12:30:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, rafael@kernel.org, lenb@kernel.org, robh+dt@kernel.org,
	frowand.list@gmail.com, m.szyprowski@samsung.com,
	james.quinlan@broadcom.com, iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Don't store redundant offsets
Message-ID: <20231215113014.GA6479@lst.de>
References: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to dma-mapping for-next.
