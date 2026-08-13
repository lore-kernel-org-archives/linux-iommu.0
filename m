Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC13B0AC6;
	Thu, 13 Aug 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643016; cv=none; b=FFHRNzIT4ohgCQ0mBiyxkn90+9UrBUB73GF6kvkTrDJh9mYxsM2NUUCxkeVIwfcc6B3vnZnhTyjEm4EphyDXfVy1P7Pm8dfbOSQC6FRd57rdFlbW9n/aMnUSvbzaPIf92uBeDr2XSCQReSOcGJa/054UgsAm+rB9qclt9+G+dGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643016; c=relaxed/simple;
	bh=NkN7ngna0Humtq6uQBf0uHYiqsiYczmvr3m1gx6JMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2dwbE7HD879HWn4szFB66zpQu2vVWEH6KZ+MB61dW3MGc1+yAqWknjCbMqyY9oBCllcIBP3dGezmjU1IB4KbCG8QVWaPJEBczT5k1J3j0HDgziY/BOfM/bFYdfEM7qaz15i2rW7VrnW7i1XADVnITLNIBITX4PmSHoi0l6CkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3+gv6vC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3+gv6vC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608CA1F00A3D;
	Thu, 13 Aug 2026 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786643014;
	bh=Vx7YXtRMyITi1C1CRhaAFx1V9a28c3m1pyOxBUtEric=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3+gv6vCEM7acrABINQc35rhIjGyDCPJ41fVl9NaG7cp8eMtHLI/ty+6SglNFTvXR
	 DEw9jcdreOnKrTgNNoA+ZUi/r/oYs+vnPO6ZO/6gn/H2eIzJkx7lGzoGh2TAJgxGQH
	 MVD3wRG6jb2pWoioasY1HoKyxsDuijgY36DCD6bbCOLgJmgGjCoJXfA/hLRt9hJggW
	 IgRqC+E2I6E/sMpkrmgE5BENK/YUiarqFRFUv3+1yoo0KF1LyEecHLGQTrAf7LBhug
	 Rvo2dXld/tAgAMGCbNk0ct2+nypHgfp9/7iGcxq07G0vw36OtX4WM+RZp3ULSi5xVt
	 mV3c3snvnfQIw==
Date: Thu, 13 Aug 2026 10:43:33 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Ben Horgan <ben.horgan@arm.com>, joro@8bytes.org,
	palmer@dabbelt.com, tony.luck@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 6/7] riscv_cbqri: Assign IOMMU groups to resource
 groups
Message-ID: <an4CRRXt44+PhHgy@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-7-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-7-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:56PM +0800, Zhanpeng Zhang wrote:
> Allow the resctrl devices file to accept iommu_group:<id> tokens on
> RISC-V and map the target resource group's closid and rmid values to
> RCID and MCID.
> 
> Record non-default assignments in an RCU-protected binding list rather
> than inferring membership from hardware IDs, which may be shared. Keep a
> parent reference obtained by numeric group lookup so the binding does not
> keep an empty group's devices kobject active, and prune bindings after
> their group becomes inactive.
> 
> Publish an explicit UPDATING state while hardware changes. Paging-domain
> attachment rejects that transient state. Static FSC=Bare transitions
> preserve the current IDs so a mandatory release-domain attachment cannot
> fail. After the checked group update succeeds, publish the packed IDs. A
> validation failure restores the previous active state without partially
> changing hardware.
> 
> Moving an IOMMU group to the default resource group resets its hardware
> state and removes the software binding. Device contexts created later for
> an assigned group inherit the IDs through the RCU lookup path.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
[..]
> diff --git a/drivers/resctrl/cbqri_iommu.c b/drivers/resctrl/cbqri_iommu.c
> new file mode 100644
> index 000000000000..4086c32546bd
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_iommu.c
[..]
> +#include <asm/qos.h>
> +
> +#define IOMMU_GROUP_TOKEN	"iommu_group:"

I am wondering if maybe this should be parsed at the resctrl layer since
it could be possible for RISC-V and ARM to both use the iommu_group
token. I am hoping that Reinette and the MPAM developrs will add their
prespectives on the the resctrl devices file and at what level the
tokens should be parsed.

Thanks,
Drew
