Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C927B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 10:23:32 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 101552246CC;
	Thu, 16 Feb 2023 11:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676543011;
	bh=GzlsKWiPjthaX1/hbOABtB4YHX4tZBMzFva1szyVx2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wvRBZzXVqL50pYweSrzRifU3RS6TaDbn9kIT2DePHjDB7jD+eRMQ20DYs+ywtITiD
	 nHUTgqQILfZxJDMmRMmAPiH2+qZThFsAWwjB7Rt/iH7QR4DbEsvHNevSYvCaKqeDQM
	 q4zEU33Vzob+uwqqBdSo50X1KuY9oY9sXBVFzXxol1yfBP5rRVYLqz3mxlmafeFo7z
	 iP8aS1+VOtj/IP8eCprJ/v9qQJ7VqErhkj94r1vNmCWNxaJddJGG8488/NCRfIz/QO
	 aWfG0Hv9U2Y+Gaxkzki5BAzJ8JhfcYnzw7ah2BR9ZLV06bJjABtm71IP03NQArGiwY
	 WH0Eg3zXaeGnA==
Date: Thu, 16 Feb 2023 11:23:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jean-philippe@linaro.org,
	darren@os.amperecomputing.com, scott@os.amperecomputing.com,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+4EITP08CKPWMWl@8bytes.org>
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

Well, the spec is one thing, existing hardware the other. Have you
checked the history of the PF-before-VF requirement before making that
change?

It is possible that early PASID-capable hardware actually required
PF-before-VF enablement of ATS.

Regards,

	Joerg
