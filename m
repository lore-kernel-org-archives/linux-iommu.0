Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE117463
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 21:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D92C433C1;
	Wed, 17 Aug 2022 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660771066;
	bh=vuBF7ADDDys2amXNJQY4RfW15B+ZTZQfk/0OWbwwenw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ofD9MlTRsM+ltsFAOYVSogg5ogb3x7ZW3QI7kj49uZBU91x2mfKtFMZ58BQsw3HnA
	 sSFgdsPJvKSJ+x/Y3Rcg7Lw4lyqWaVbogfwRD+e0bkmwzbFbVKW+juv4QP/u6MPQgW
	 MSd4J1iR0deRRgQvx3JScGxjaygZpvYmydy+qGScozCiWnMPbfvfrj0qeOo9imc9Xo
	 +9+8F5Ezf90+utCQ3VFXzpNmtbrWgU+HHe7asljI2m47nf0MTq+/DqhC9AiPDAJeuL
	 OlnQ84RqPSeS7SL8S0fqQjXiXDxihIP8JXGb8CXoPiPFOZ8+6L11JCTC6MECCEr1qR
	 8tV+A/QFCL4wA==
Date: Wed, 17 Aug 2022 16:17:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Message-ID: <20220817211743.GA2274788@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817012024.3251276-5-baolu.lu@linux.intel.com>

On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
> Some configurations of the PCI fabric will route device originated TLP
> packets based on the memory addresses.

This makes it sound like a few unusual configurations will route TLPs
based on memory addresses, but address routing is the default for all
PCIe Memory Requests, and ACS provides a way to override that default.

> These configurations are incompatible with PASID as the PASID
> packets form a distinct address space.

I would say "the Requester ID/PASID combination forms a distinct
address space."

> For instance, any configuration where switches are present
> without ACS enabled is incompatible.
> 
> This enhances the pci_enable_pasid() interface by requiring the ACS to
> support Source Validation, Request Redirection, Completer Redirection,
> and Upstream Forwarding. This effectively means that devices cannot
> spoof their requester ID, requests and completions cannot be redirected,
> and all transactions are forwarded upstream, even as it passes through a
> bridge where the target device is downstream.

I think your patch actually requires all those features to be not just
"supported" but actually *enabled* for the entire path leading to the
device.

To use the terms from the spec:

  "P2P Request Redirect"
  "P2P Completion Redirect"
  "Requester ID, Requests, and Completions"

and maybe something like:

  ... even if the TLP looks like a P2P Request because its memory
  address (ignoring the PASID) would fall in a bridge window and would
  normally be routed downstream.

Does the PCIe spec really allow TLPs with PASID to be routed anywhere
except upstream?  It seems nonsensical to route them downstream, and
hardware should be able to check that easily.  But I took a quick look
through the spec and didn't see anything about PASID by itself
influencing routing.

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/pci/ats.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c967ad6e2626..0715e48e7973 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -382,6 +382,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pasid)
>  		return -EINVAL;
>  
> +	if (!pci_acs_path_enabled(pdev, NULL,
> +				  PCI_ACS_SV | PCI_ACS_RR |
> +				  PCI_ACS_CR | PCI_ACS_UF))
> +		return -EINVAL;
> +
>  	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> -- 
> 2.25.1
> 
