Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484B11C8D
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 08:18:18 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 669CF1A2200;
	Mon, 25 Sep 2023 10:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695629535;
	bh=rvI403sXHjIFnb/aVy8uQZA0DiZlvQIsvyech7TF9z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZLsAxkobYW4nXTZPQyTTI0CxJ1RLZBFxCnfvN4NEPAm86DIM+5jExytbxov5okMw
	 dzsjzSrCYlu5KOGlO4ynkW2vVywUEEYlCgVyaA0z9mGgynrXuNq/LcsDZO26r3fQT7
	 NV3yr15KdexSUtzI3pKvfERl+JWYijQxTp+i0WkPudGEfEto/ePIYkNIyDfcc/30D7
	 Rww5T8BdEnrp7T0usBJYfZO7nrJZ91kaMKhSzStj5naP7t4DVksnq4l4pKXs7XHAzN
	 W/LcRH51uY+IJD0iZrsZoBjt+iuYMv2XExCIOzPx6rzgtB3cugXOIXO200URKWmsr1
	 icn2IFHaTNEvw==
Date: Mon, 25 Sep 2023 10:12:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Huang Jiaqing <jiaqing.huang@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com,
	kevin.tian@intel.com, baolu.lu@linux.intel.com,
	jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
	yi.y.sun@intel.com
Subject: Re: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
Message-ID: <ZRFA3uj1-QjlXpGx@8bytes.org>
References: <20230821071659.123981-1-jiaqing.huang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821071659.123981-1-jiaqing.huang@intel.com>

On Mon, Aug 21, 2023 at 12:16:59AM -0700, Huang Jiaqing wrote:
> The existing IO page fault handler locates the PCI device by calling
> pci_get_domain_bus_and_slot(), which searches the list of all PCI
> devices until the desired PCI device is found. This is inefficient
> because the algorithm efficiency of searching a list is O(n). In the
> critical path of handling an IO page fault, this can cause a significant
> performance bottleneck.

Can you elaborate a little more on the 'significant performance
bottleneck' part? Where do you see this as a problem?

Regards,

	Joerg
