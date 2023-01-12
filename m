Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D079385
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 18:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B66C433D2;
	Thu, 12 Jan 2023 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673548463;
	bh=M36E0az9apj/WWDPm0/qsCtZyG5YVmwB7+9Ke5kQ8LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sPSsKpSMDwEcWp40JGwOPacz6FK0Cr2zqz0qCkOPDZ8q7+P9fxiCSb/9sksSbOR9x
	 M1aOoEkm0rO8Bv+1/l4jtqekz5zEI8kbU6mqWCZHwv58ut/km0/wGEBUA6Imv6PpXP
	 2ngfp9Aino6ysyS1BMe4eQebFM65xlVnArOuS+D/RHCISDY6qKELCTi49Y6A1kHX/H
	 9A5hC+9aZdHTOPNAMgDRA9maQ0aBgMaJ3P1UC5SURxqVsVJYPf5sHiLZoZH2qurC0m
	 4yJXHqztabzDiFVA7s4KzandIcus89kPPAERFSUn63FRBm67QwN0j1jc0HAdjzNuJy
	 5/zHqWxz5T1kg==
Date: Thu, 12 Jan 2023 12:34:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <jroedel@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tony Zhu <tony.zhu@intel.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
Message-ID: <20230112183422.GA1778973@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a15f05-29d7-9dd3-175a-3915e7357c11@linux.intel.com>

On Thu, Jan 12, 2023 at 09:25:25PM +0800, Baolu Lu wrote:
> On 2023/1/12 20:38, Jason Gunthorpe wrote:
> > On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:
> > 
> > > -int pci_enable_pasid(struct pci_dev *pdev, int features);
> > > +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
> > > transled_only);
      ^^^^^^^^

> + * @flags: device-specific flags
> + *   - PCI_PASID_TRANSLED_REQ_ONLY: The PCI device only issues PASID
> + *                                  memory requests of translated type.
                    ^^^^^^^^

I don't like "transled" since it's not a word itself or an obvious
combination of "translated" and something else.

Not sure whether you need to abbreviate it, but if you do, "xlate" is
a common shortening of "translate".

Bjorn
