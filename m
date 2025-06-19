Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA51EDA2A;
	Thu, 19 Jun 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340768; cv=none; b=H+WqSRBYs2y/yijIJF0Emhc+ZrnDlHkaCQ5k1dhaOwV3aaYMUNaCmsUlDkUCCi9K9MFX7fZiWxi5o4S0BFiQnIEms0RqOMF4ImwpyJXY5nYdw3Shi+vAaHk67TocCFnMtSe9Oc4DxlZ8NX6gSCRnSTZ7hCdAWbzB0oLqOB8n/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340768; c=relaxed/simple;
	bh=CxmE7gb6BqmwL8WS1UR7jU57trPXDnvp2EPKQWRkaAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf8d9fNz0Hpbh/a8IdVjpFPO0LURivWPanbJYXrKJ2ro70th0QACqpoOLlktBjcDGksFzix2nTZsA+2twFSmmCwBIAOBeMT+CeW/sGHciS7lN1cbYPhdaoVIUmXGy7ZdPCkEwW16c9crs+32FC7nGPhiV3Go3sGeyATesat09H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DFC4CEEF;
	Thu, 19 Jun 2025 13:46:03 +0000 (UTC)
Date: Thu, 19 Jun 2025 14:46:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <aFQUmWC1MYhai1fo@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
 <aFPu4SorUGlFt-2p@arm.com>
 <20250619115132.GA20673@e133081.arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250619115132.GA20673@e133081.arm.com>

On Thu, Jun 19, 2025 at 12:51:32PM +0100, Mikołaj Lenczewski wrote:
> On Thu, Jun 19, 2025 at 12:05:05PM +0100, Catalin Marinas wrote:
> > On Tue, Jun 17, 2025 at 09:51:02AM +0000, Mikołaj Lenczewski wrote:
> > > +	 * whether the MIDR check passes. This is because we specifically
> > > +	 * care only about a stricter form of BBML2 (one guaranteeing noabort),
> > > +	 * and so the MMFR2 check is pointless (all implementations passing the
> > > +	 * MIDR check should also pass the MMFR2 check).
> > 
> > I think there's at least one implementation that behaves as
> > BBML2-noabort but does not have the ID field advertising BBML2.
> > 
> 
> Yes, I put "should" instead of "will" because of the AmpereOne
> situation, but I didn't want to "name and shame". Should I explicitly
> call this out? Or would you like me to soften the vocabulary here to imply
> that as long as the MIDR passes, the MMFR2 check is not important?

I missed the "should" part. Anyway, I would just drop the explanation
from "This is because...".

-- 
Catalin
