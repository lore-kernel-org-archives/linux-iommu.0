Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9891FAF1B;
	Tue, 15 Oct 2024 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026174; cv=none; b=StssnZmou2Fo44ZmtdB1LOzgEoKbtGUJL8BxuIP6bwQVW+an5lZj/XiqGOLT2FsK6b7ckxm+ZpG4rE3+XTe5gr5cr5YAVOPoBe03ROd5yrxSX2iDkvFwLCx/p3mPymGs6UcKdYsw0yxOlhHnx+AVibIBiOJxjqaiSkY+p4mL1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026174; c=relaxed/simple;
	bh=IStmbp49oQUCiF1c7nzEmUaK3D24x4G9Piuzy0UPP5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMmmeMGfLAiAsgH0Duyrcfe45gOYPKKErVqnJ0jwkmJOurGVOJgy6dkGKjzsV6/l0/9/X81r3212JEln+eH3rMvfMQRCHhp7Nld/4HEPS2/qSxY9AWIoUiuYx/1LoLfWol7kojaZFxp5n3WVTBZUjAuxCXqff0G8+7JNntBsY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWySHYgO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWySHYgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0F7C4CEC6;
	Tue, 15 Oct 2024 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026174;
	bh=IStmbp49oQUCiF1c7nzEmUaK3D24x4G9Piuzy0UPP5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWySHYgOvVQqExJ1q8UWZqHVUepypM33JsWT97P3YPPhy4GI+H9N1GCGx8P4DtdyY
	 V6vst7EjDSVBc7Q4vja/vbykOaHUpg0Em3SlH9Ax/jWDJ/uQMSyMGLGqjMOnWxARuZ
	 t9eMPYpWmZTjYE/9/FFo/gFSDa+Q3XzmHP6Eua1vm0BoTegN/d5+Qci98LBM6cV8JY
	 939rDcuHl1kmLwAc87ZaMUVpAOTLRXJ6LHQpgeFQ6qcVOyfEU6JqBHae8icsYRtdmR
	 8Z/3n2EPhE3gP7NWLeqQ9TLkCcTpWUxqUEU1aSFw5ULIoB/U918Yi5g0XQzoxnTPKY
	 iV4e9TnRL4/8w==
Date: Tue, 15 Oct 2024 23:02:47 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v3 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Message-ID: <20241015210247.3ezydc5pavwitkiv@joelS2.panther.com>
References: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>
 <20241011164033.GA1825128@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011164033.GA1825128@ziepe.ca>

On Fri, Oct 11, 2024 at 01:40:33PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:28:08AM +0200, Joel Granados wrote:
> 
> > Changes in v3:
> > - Adjust wording in cover letter
> > - Include "_iommu_" in the prq Intel function names to be more in line
> >   with functions in iommu.h file
> > - Rebase on top of 6.12-rc2
> > - Update my ID in e-mail, git author and my Signed-off-by.
> > - Link to v2: https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com
> 
> You didn't include any tags from the prior version?

oops. I was so concentrated on adding my new signed off by, that I forgot to add
Kevin's trailers. Let me send a V4 after running a `b4 trailers -u`.

Thx

-- 

Joel Granados
