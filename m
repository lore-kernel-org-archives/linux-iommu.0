Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CB3644BE
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838962; cv=none; b=Vfmc8aWT2qSUlH4COcDfe7dXLPej22JSuKGf0FA2YhpK9JLfT7jE/GjiEPT4dLFZLaDe50fhrZ/wtr0xOm2gDVFG/0OxaU7UG1pl3wj5fz2kNSjO/s3Y46OfXLGzVGsMiw/3cDVShC+CT3LLfSqKkpdYauc799rgAfXBxMvFwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838962; c=relaxed/simple;
	bh=eSpRBIQFx2Fm+8Fj1pvi3qgMO08RKixTmOFPmRvr3QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZA8c+9dJTef/NmYckl0emlnpBm5WxS6NqtKrT5TF5rwL0HhMvle+32t8ZznlaQcmNxLDRvb5xKCvHJAihRryplo/kqMJrFL+sXKolIs46CfwpixT0xCsLqzZrhbXuCQpAt1/rYur7azIqVmkle7/SoDexbiL8aG2M5Eo2Xw/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eZMiwTie; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eZMiwTie"
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C78EF211D8D7;
	Thu, 30 Oct 2025 08:42:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C78EF211D8D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761838960;
	bh=ysPZrd0ypANag9xbIeXXFA7XUkCdWdZgyvKIS/nwA/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZMiwTie9BYM8QHnCmOHnVQpzEmwXnPppJ/+gxLd1tL0NDnIZjWlBlA14zBEM2yYK
	 fzuE0NoPqBtH+HZs8xBWB9n3TmDMCnP2gjYQ+slASQFirdWKoM+xhrUcbDlbjUl/16
	 qlLNRUk8/3HFn6Btj/ZyVu8Xbt3bAZshCUSxpru4=
Date: Thu, 30 Oct 2025 08:42:38 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Cc: Zhang Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251030084238.00003fbf@linux.microsoft.com>
In-Reply-To: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Will,

Just a gentle reminder, appreciated.

@Nicolin, were you able to evaluate these?

By the way, I incorporated your review comments in v2, except for
extracting the function arm_smmu_cmdq_poll_until_enough_space(),
primarily due to concerns with the IRQ flags.

Thanks,

Jacob

 On Mon, 20 Oct 2025 15:43:51 -0700 Jacob
Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Will et al,
> 
> These two patches are derived from testing SMMU driver with smaller
> CMDQ sizes where we see soft lockups.
> 
> This happens on HyperV emulated SMMU v3 as well as baremetal ARM
> servers with artificially reduced queue size and microbenchmark to
> stress test concurrency.
> 
> Thanks,
> 
> Jacob 
> 
> Alexander Grest (1):
>   iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
> 
> Jacob Pan (1):
>   iommu/arm-smmu-v3: Fix CMDQ timeout warning
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 97
> ++++++++++----------- 1 file changed, 47 insertions(+), 50
> deletions(-)
> 

