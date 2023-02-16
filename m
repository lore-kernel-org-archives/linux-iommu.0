Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC320FB
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 07:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE39C433D2;
	Thu, 16 Feb 2023 07:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676532380;
	bh=eJEQHIPlenJG8lQt473cDjk+4g+XrKqUDMyiKiKZ4eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvK78HaUCCqokQtOPxdvaIwZqWKadYV1QL0dEQgwweACu97H/YlOr4Xw2i+l+XXaY
	 O59UDyiqEz6yhstPI6QrA9JSzksxr6uCvJGCB+A0GK8CDIuip4xPhXB63UfflGbVwT
	 brFUrD1FjSnZ5ztW0w5xC41axFiElbd1ipj4FtK/9ervRbFRQxD+PEoH/IpOSqS566
	 jLI2n3wi9dgWyqaQ6xW0z0rZM9WFfbNWu60BHcBSX1IIdGI6KmHRvzr79ykDdV3cF7
	 fRwkfzbuHeoykhu7uJKyvBTiUkNLKEVQ033Wwnp4LZLCjjafpU1VGfgdTdO5Hf6AE1
	 cGVjG6L0FGGUA==
Date: Thu, 16 Feb 2023 09:26:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jean-philippe@linaro.org,
	darren@os.amperecomputing.com, scott@os.amperecomputing.com,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+3al/a3HPrvfNgh@unreal>
References: <Y+ksmNWJdWNkGAU9@unreal>
 <20230215205726.GA3213227@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215205726.GA3213227@bhelgaas>

On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
> [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
> 
> On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > > As per PCIe specification(section 10.5), If a VF implements an
> > > ATS capability, its associated PF must implement an ATS capability.
> > > The ATS Capabilities in VFs and their associated PFs are permitted to
> > > be enabled independently.
> > > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > > hardwired to Zero and the associated PF's value applies to VFs STU.
> > > 
> > > The current code allows to enable ATS on VFs only if it is already
> > > enabled on associated PF, which is not necessary as per the specification.
> > > 
> > > It is only required to have valid STU programmed on PF to enable
> > > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > > when PFs ATS is not enabled.
> >
> > Can you please add here quotes from the spec and its version? I don't see
> > anything like this in my version of PCIe specification.
> 
> See PCIe r6.0, sec 10.5.1.

Awesome, I have old versions.

Thanks
