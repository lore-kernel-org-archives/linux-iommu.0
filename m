Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4B8F60
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 20:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A003CC433EF;
	Thu,  2 Feb 2023 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675368772;
	bh=MQKMITOOkVxwlfpaG6ybSkQudYIrm/IEf9Xq09VMI4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ij6k1W+x/btHjzibEPP+mqaOcORyoeROaRTKdXR0bqowRVwYIzV0mZ8tt3Z2tfEYy
	 5j7kv3AtMz37z1ZRatjdsDESWXFI6G3dfvrYN4dFp5hwgMviQU9g0fxM34HB/mmddk
	 KcM/5lGPrDWiZ/8lx07wvvv833yy+88EC4dVLYdlPCVyjr1NXUJtiktYSFjHsSP0ud
	 UwNboaJUXukFznvNekv4QWnohI7QPvbTdwOtBvvljr/Ka09+FAJRJrcK65ZIhjiR7S
	 /BovMJY8UilkkZ591J9xncErp1HuUL25+d5nbX5eQi9s9pG9t3oTmtX9xSyn1L0z0s
	 p0Yb83XECJJVg==
Date: Thu, 2 Feb 2023 14:12:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Matt Fagnani <matt.fagnani@bell.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tony Zhu <tony.zhu@intel.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <20230202201249.GA1963053@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com>

[Joerg, you may be able to answer this.  Patch under discussion is:
https://lore.kernel.org/r/20230114073420.759989-1-baolu.lu@linux.intel.com]

On Thu, Feb 02, 2023 at 11:08:25AM +0800, Baolu Lu wrote:
> ...

> ACS is unnecessary for the devices that only use translated memory request
> for PASID. All translated addresses are granted by the Linux kernel which
> ensures that such addresses will never be in a P2P address, i.e., it's not
> contained in any bridge aperture, will *always* be routed toward the RC.

Re 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on
upstream path"), does that commit actually *fix* anything?  I wonder
whether we could revert it completely.

The intent of 201007ef707a is to use ACS to prevent misrouting, which
would happen if a TLP contained an address that *looked* like a PCI
bus address, i.e., it was inside a host bridge aperture, but was
*intended* to reach an IOMMU or main memory directly.

201007ef707a only affects pci_enable_pasid(), so I think we already
avoid this misrouting by restricting DMA address allocation for both
non-IOMMU scenarios and non-PASID IOMMU scenarios.

So what about PASID mappings, e.g., consider a mapping of (Requester
ID, PASID, Untranslated Address) -> Translated Address?  If either the
Untranslated Address or the Translated Address looks like a PCI bus
address, a Memory Request or Translation Request could be misrouted.

Does that actually happen?  I assume it does not happen for Translated
Addresses because that's basically the non-IOMMU case, and we don't
need ACS to prevent misrouting there.

Do IOMMUs allocate (PASID, Untranslated Addresses) that look like PCI
bus addresses?

Bjorn
