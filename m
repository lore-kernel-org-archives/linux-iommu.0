Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420122;
	b=yCzXLOc3/TUG9T706VyPM4YjXaO7/SHmDD2qTsj3bNwZyLcoYi2KIcEUPlYM7Q+M78r9
	 xJchrLH8anIX/ElgiltnSsDwyuqS5MPTOHrU1MjA0rkrE9i0lITWcN+Ah8WAhLA+yt9L2
	 SWudH1FmBZ5DNXEITxEdOyWiFet9IZBueAfFQxbiwl1lE20tg5CoH8nhG1UwdAUxC6t9f
	 pBAsqvkIyIIcMhOZ0lCPiOEUB3vxVo5RJovtDsE9P3NMndHRBikehcr8jRhuV8/Klj0Ag
	 4XsyR6wlelCuH+bBuocbHiX2RAg85B4g/KDQ6LyQ1GdWNiC4NTMNWDPL5lPZoT9KbmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420122;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wokkkNFzIsEepckDi99FN8dnTWAUR1CbtTzouCd22Tg=;
	b=mHJN5HstvJNhecibR5sNbmclfn6T4m9Fo2DCOfVht9vTYZk0T290wDNlAvM8JAukmF44
	 v8rffN247d24IgYApq9wkDTe0fypFlwL5pFj0KGF5qM+xE081QMTW6qvHmx//9MqG1NLZ
	 0zqvgcjYX2crQ8jJMLuDfHU4tbIf9RVfWTqhoCnhOidS+U/9BvU8xvTDswbDKZ2csezcg
	 jdgOCB3bTGBYgmlS0pj2C/gpZIhRFJS3LESOK9eB8XfST+zpFXh++KFOrxy1X/Bw8xqAJ
	 cPGl2vAjTH7nQRugD/1eNLVbpTtA1h97Dq1GBvqzvMh+xiMzOsjT7vF2zzgJcyxhXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/09oUYo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11E606A327;
	Mon, 23 Nov 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/09oUYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3393A1F000C0;
	Mon, 23 Nov 2026 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420121;
	bh=wokkkNFzIsEepckDi99FN8dnTWAUR1CbtTzouCd22Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/09oUYoKCSYwJaW3GkPBONE8TRwPwEk8ZbiKnv9b9YP27Y3LV5Q84YuhNBNtkNkH
	 x0yS+zWDWDfVwBvmGas7wYDYLry6drkRy1/QTYfS2XDJIAoU3fzJq7ZpEqHIYAltSt
	 Vy8j0HsJJ30DjVtr+Tvww2mWIQMRRIt0+7lgMENzmB0yIBEY8c6+XwSdlF+ZVqe78v
	 j7xYhMrH41G4+tv6YpjNzUrCE55V15wmLv9usx+oK3EnhbrWkKkZp9SR8F66yMOpnr
	 z2jP+17DrGid3+IM1hL7Cdx0qGFgCeDGtcghVmjk5Ra1ox4L4s5RVOeqyPKT6CrLeY
	 pLollFP25n7yg==
Date: Sun, 22 Nov 2026 23:48:40 -0800
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, jgg@ziepe.ca,
	james.morse@arm.com, ben.horgan@arm.com, xiaqinxin@huawei.com,
	will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
	babu.moger@amd.com, kevin.tian@intel.com, corbet@lwn.net,
	skhan@linuxfoundation.org, shuah@kernel.org,
	randy.dunlap@infradead.org, cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH v2 2/4] iommu/riscv: Register independently tagged
 devices with resctrl
Message-ID: <awPv2KwSZdE_Biuj@thelio>
References: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
 <20261116071338.35991-8-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116071338.35991-8-zhangzhanpeng.jasper@bytedance.com>

On Mon, Nov 16, 2026 at 03:13:41PM +0800, Zhanpeng Zhang wrote:
> Register independently tagged devices after default-domain setup and
> retain their IDs in driver-private state across domain changes. Program
> all firmware IDs under the context-update lock and report command
> completion failures to resctrl.
>
> The DC.ta field size does not describe the implemented QoS ID widths.
> Probe the low bits of the global write-any, read-legal fields with DDTP
> OFF and all queues disabled and idle. Preserve and verify restoration of
> the original register. If the widths cannot be obtained safely, do not
> register devices with resctrl. Reject IDs outside the probed range before
> changing any device context.
>
> Track exclusive device-context ownership without changing IOMMU core.
> Discovering an alias resets and unregisters any previous QoS owner before
> marking the context shared. Shared contexts are excluded from independent
> QoS assignment until IOMMU reprobe, without failing ordinary DMA probing.
> Serialize registration, alias discovery and release so an old owner
> cannot become independently assignable again after its context is shared.
>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
[..]
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index fbdca69c436e..dd2ebb25312d 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
[..]
> +static void riscv_iommu_probe_qosid_limits(struct riscv_iommu_device *iommu)
[..]
> +	iommu->qos_rcid_max = rcid;
> +	iommu->qos_mcid_max = mcid;
> +	iommu->qos_ids_valid = true;

The iommu spec requires rcid and mcid to be at least as wide as on any
hart, and resctrl only hands out IDs that the harts already use in
srmcfg. Maybe the limit probe could be dropped?

[..]
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 5676001548cc..72bb536190d1 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -15,6 +15,9 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/iopoll.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/xarray.h>

spinlock.h is already included above.

Thanks,
Drew
