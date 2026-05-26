Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A263A6B8A
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811174; cv=none; b=V23sAFpRtHWAnXZJhzpQ/5hfGg82WaDA3kKXiKzEmVSJRuq/qM3Uqw8g979ivEEHhSUHfH42+gF73genq4JdqE9tptbqxFos2NEuE2XIFmZPE80c97nPt5Ls8mYx+UPhHCFKJ8p/z2jpQgcZlyAGZ7tGx+9cGCH9DlwZPQbkrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811174; c=relaxed/simple;
	bh=zMxD3VFMtLBC+cWWCo5EuPrYgR+8m01z1rYD6jA7JfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7pLmaPkQeQU1YuVMaeCtCrmXEytnvDZDyzGWovbXArYgctbrgeylXI3nbkC9kV+6BMuexyuDs3RugQqGxASf2Wzrgut8q/55Y8Gms+sDw8Iny2iYo+Vcb3szm60KRhrdBl0tw8Qqs01uFPxLwar9NaHOqRkTUXTC+iXTx88Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wb5ulU78; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wb5ulU78"
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 230F020B7167;
	Tue, 26 May 2026 08:59:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 230F020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779811161;
	bh=zFzV3Un4dqyonf7aw2EN42W6GrQT5R1zy8VSVcK8S5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wb5ulU78Hy9cU3laPGu/qlSfqxt3+H6DhLEw4ypsEHlaQMJ8Lo6M2izZ4O3xyrJuj
	 7GIAyB1ouQQS9kEEbxHg4RJQOFcF7x7+R49Re6p5MQGe49GXmYoR/+ylG8x4CTYb0G
	 ZJLC6hOjXJmHcJ7SaLZrzGG/R6vXJpQ8gRCqhmQA=
Date: Tue, 26 May 2026 23:59:28 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	mhklinux@outlook.com, wei.liu@kernel.org, jacob.pan@linux.microsoft.com, 
	schakrabarti@linux.microsoft.com
Subject: Re: [PATCH V0] iommu/hyperv: Create hyperv subdirectory under iommu
Message-ID: <kqzr5ue5g5pdlp6pei37mfrymoln6y63iizzuiehtj3uiurfod@54fugjcdtuqr>
References: <20260526012037.3874959-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526012037.3874959-1-mrathor@linux.microsoft.com>

On Mon, May 25, 2026 at 06:20:37PM -0700, Mukesh R wrote:
> Create hyperv subdirectory under drivers/iommu in anticipation of more
> hyperv related files for upcoming PCI passthru and pv IOMMU patches.
> Also, the current file hyperv-iommu.c actually implements irq remapping,
> so rename to more appropriate hv-irq-remap.c and move it under the new
> hyperv subdirectory. Lastly, this file should not be tied to
> CONFIG_HYPERV_IOMMU, but to CONFIG_HYPERV and CONFIG_IRQ_REMAP.
> 

Thanks for this pathch, Mukesh!

Jason raised a question about whether Hyper-V's IRQ remapping file belongs
under drivers/iommu/hyperv/ at all, since unlike Intel/AMD, Hyper-V's IRQ
remapping is not co-mingled with the IOMMU hardware:

	https://lore.kernel.org/all/20260520133807.GS7702@ziepe.ca/

Though we don't end up moving it elsewhere (the IRQ remapping framework
and its internal header, irq_remapping.h, live under drivers/iommu/, and
all existing backends sit alongside them), it would be good to acknowledge
this in the commit message and explain the rationale,


> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  MAINTAINERS                                             | 2 +-
>  drivers/iommu/Makefile                                  | 2 +-
>  drivers/iommu/hyperv/Makefile                           | 2 ++
>  drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} | 8 +-------
>  drivers/iommu/irq_remapping.c                           | 2 +-
>  5 files changed, 6 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/iommu/hyperv/Makefile
>  rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..b651ee0c6e6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> -F:	drivers/iommu/hyperv-iommu.c
> +F:	drivers/iommu/hyperv/hv-irq-remap.c
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0275821f4ef9..d9683422aecb 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
>  obj-$(CONFIG_INTEL_IOMMU) += intel/
>  obj-$(CONFIG_RISCV_IOMMU) += riscv/
>  obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
> +obj-$(CONFIG_HYPERV) += hyperv/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
> @@ -30,7 +31,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o

Any reason why we are removing the CONFIG_HYPERV_IOMMU? You are leaving
CONFIG_HYPERV_IOMMU an orphan configuration now (and also the  backward
compatibility issue?).

>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>  obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o

B.R.
Yu
