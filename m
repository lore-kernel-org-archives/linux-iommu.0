Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188F1E260C;
	Sat,  8 Aug 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208956; cv=none; b=bEdcL3XnHNrS9625MxQzEL/cOwhuZoxVqAJW4ZWODTZJb33CM8HJPxSeDAFxgEU3cPARgdT5pj/K0P8L40WptBJ0LAwfZbID1II9Pr6HiS+A5hPLA+wpEDVgrwSaaVsKo5lY9LEfOgExQVg9QLScVA6Komw6W/Nq7WDb4MLLg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208956; c=relaxed/simple;
	bh=n4s/si9haKkTIrqgJN0hnQY+FPX49fGXqEwAWpDbqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKQCOQd8wYIWEaejRy+/IGYCwoM02Iqe4luAz49d9nsZC/TgVsZXDQ1KkRKbtDV5k3FIaOMyEJH/VAHVi9tTILdhi2SD78rk5RC4FVn2pm3e/yJLDZIM16puxzJNpXWzzw7/GqE/ZBU1SsU00w+WZHiBHlXThLG2+8mCBz9GIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPB8Woob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPB8Woob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A461F000E9;
	Sat,  8 Aug 2026 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786208954;
	bh=3t2FU5QAhOESQfdCB5hI+9szIiZ8abQ+zdqjjWFA9FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPB8Woob7raC0tlwHTe2yEiGhF1JQCEbzsn7BjsYhQ/28Pnh9rAmfXM3c58q7AZzU
	 CiUTsdZa/IsA6BZGIXs3P0JMQ6w1OymlmbmU2pvzu5+0RdrwJxlNacCUG8o2HvNbwQ
	 FxKxMt78u6UVXKYrEzVtPSOMoXeJpHAwkaHeVghjWnd6r6W9AQcxYwLFsNvtOrhQu7
	 ut0uEP7nJk+osZdxed9zvq0z05XtUCxcjsuc7pdeVjt+MRiZqBM/WJ9jBwooFivfW7
	 swyQy2gbeQNjiFz3ENfbPkA3cd0+431CyOR+wXcUXLecvUCXgFZKEKNIfnhdFM0IqJ
	 L4mtvthCHrL3Q==
Date: Sat, 8 Aug 2026 10:09:13 -0700
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
Message-ID: <andiub47zsUsL4qh@x1>
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
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
> new file mode 100644
> index 000000000000..b0cd68997f17
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
> @@ -0,0 +1,27 @@
> +What:		/sys/class/iommu/<iommu>/qosid
> +Date:		June 2026
> +KernelVersion:	6.18
> +Contact:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> +Description:
> +		The RISC-V IOMMU global default QoS IDs for this IOMMU.
> +		The file is present only when the IOMMU reports the QOSID
> +		capability.
> +
> +		Reading the file returns the RCID and MCID fields from the
> +		iommu_qosid register:
> +
> +		  rcid=<rcid> mcid=<mcid>
> +
> +		Writing the file updates the RCID and MCID fields while
> +		preserving reserved/WPRI bits:
> +
> +		  rcid=<rcid> mcid=<mcid>

I think it might fit sysfs better if the rcid and mcid are separate
files in that directory. Is there a reason you combine them into one
file?

Thanks,
Drew
