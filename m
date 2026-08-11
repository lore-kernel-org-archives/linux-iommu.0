Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7781367B93;
	Tue, 11 Aug 2026 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483319; cv=none; b=LiTXG7SlBAqVk1J4Yd/zwvlceqhhTgZTPZU67bGU4Yobd4SDQj9johkGDAG8rsf4OxLNbpW7kAlysHA24vLF5xznuOwmqofio5avuNXGhHO5RREdH0D+VTA7ipdgoOWPwvz2xfaG42wXfEjq7PabFq/B8A2SiMFTJAUlNkP2CE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483319; c=relaxed/simple;
	bh=vXkIPbCgY8fqRfBXgJsw2fkEihfRRXh4Uzp3SunNgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUmTRfxvjX7HBXErw8UTFrf+h1d8E1UnHpkUCYJ92tZZZgfAY7a/j984nnLLBrEeTJKNkiYUudKe760Tnf2E8X8MFCNbCig2YxftebDTir0a7hLnSt+fnbyWEbxnwgmQJe+78caF3/OLq+9Abt/MsuDON5Q38MIKB8rgs+HEgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEJbRNHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEJbRNHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB7E1F000E9;
	Tue, 11 Aug 2026 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786483318;
	bh=zIlAl7RJ8yMOdVKvygcDu2T8idi0tcM0JETLZGdlNSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEJbRNHQnCMabxHAnFfiywgX2vqVBKBCg++fbDMzkOVMLpuF47eS3paHExQT8MMef
	 XBGYbGIglHf2k2pEcKBuXX6Mf/bTcnh9B7SHkDeQHTTOWi4WI5ugx0snplra0PtAgu
	 D+xwpxfbQjddS69xB+p6N+WoH4gx/l17B1gvyUc41qcT8YFGwFjsLMbFrpo0NytOpK
	 4wH2urQ+fSpSli7Y4GpCaHrpXYfrqZREHb55eRmV/Fkyi6x9ioJDbikUcqAeDR48Gs
	 juzWXdOw7xrZ/C65qEtkOCFA8QxoFJVyxj78n7txmR18DHeQ4t7ObhqbVOVed1cHs4
	 Htf1/tV+S7UQA==
Date: Tue, 11 Aug 2026 14:21:56 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net,
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 5/7] iommu/riscv: Expose global QoS IDs in sysfs
Message-ID: <anuSdFS4Enajdqff@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-6-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-6-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:55PM +0800, Zhanpeng Zhang wrote:
> The RISC-V IOMMU QoS extension provides iommu_qosid as a per-IOMMU
> global default tag. It is used for IOMMU-originated DDT, CQ, FQ, PQ, and
> MSI accesses, and for device-originated requests when DDTP is in BARE
> mode.
> 
> Initialize iommu_qosid to RCID 0 and MCID 0 when the hardware advertises
> QOSID support. Preserve reserved and WPRI bits with read-modify-write,
> and use register readback to reject values which the WARL fields do not
> retain.
> 
> Add a qosid attribute to the RISC-V IOMMU class device. Reading returns
> the current RCID and MCID values. Writing the documented
> 'rcid=<rcid> mcid=<mcid>' form updates both fields while preserving the
> other register bits.
> 
> Keep this interface separate from resctrl group QoS. The sysfs attribute
> controls the IOMMU-wide default, while resctrl device assignment programs
> per-device DC.ta in translated modes.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 +++
>  MAINTAINERS                                   |  10 ++
>  drivers/iommu/riscv/iommu.c                   | 159 +++++++++++++++++-
>  drivers/iommu/riscv/iommu.h                   |   9 +-
>  4 files changed, 202 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
[..]
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 2c57625637bf..13ea67b7e42d 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -12,8 +12,12 @@
>  #define _RISCV_IOMMU_H_
>  
>  #include <linux/iommu.h>
> -#include <linux/types.h>
>  #include <linux/iopoll.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#ifdef CONFIG_RISCV_IOMMU_32BIT
> +#include <linux/spinlock.h>
> +#endif

RISCV_IOMMU_32BIT does not seem to exist upstream and these lines 
to just be deleted later in patch 6.


Drew
