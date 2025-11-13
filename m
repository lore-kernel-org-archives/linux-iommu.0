Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781A946C;
	Thu, 13 Nov 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028327; cv=none; b=XBeJwWt1dPhVtVVowNczw28EmAlj6Gg4gEjfMKVOzj2k5Lr3gp2K2HTYhr7UtUMteP9wKbIEZw8nbfCEWTpGDYkGHtAlQ4CaUW1WE9oiC4lt2YpfIqE+BkUAAFoo2JvXDJ89iA0GXNrJDCbLSqbDZJCdMYab8VfwnsspoTseHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028327; c=relaxed/simple;
	bh=BLTb5heskjXzTldos1Pbf98tCoJwck1drSSFzaVhr3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs9bmk9wqqSxegSQbDo/mDq2vOhxhSQqHnqUPtP271OFRJ61w41R/SXjSQVGfbneDsE38b0yeskUg8ynNu74FAcW7TGkse9znTN5Pwv8JmubRQMExR66a31yfLkxloJpqFpILGxgjLw9PU2MSS5YC74H+pcDfcIMsvlLxqN/vIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB4GxgXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB4GxgXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C075AC4CEF1;
	Thu, 13 Nov 2025 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763028326;
	bh=BLTb5heskjXzTldos1Pbf98tCoJwck1drSSFzaVhr3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KB4GxgXqJZ7cO7XBy6/guf626zim6beEsg/YfQpCnDOK4CIsFLP+coyBB5LQx6Ybb
	 I7s2JOUvrf+DC7c4xVdeR/uJQIhZpbiDJGmjcLEhP+OEhRO1+tbsNZG6fuOByhSJgv
	 hrWjyJWa5kG9pfQAPvUoU/pHuUUk5rTrKamkIEBUA+G0CgjhCtK37Erfyu+rqbuvOS
	 1dlhMdtne37nyvq7Z/8tU5sJt3/Nqm6oEBR+LDczDAuItX4mBgczhd8bAdZ7MliWdx
	 jGvHbgZSquL92vYPhyoBVwk+3NUER/r21+FimVga8kmJjEWv6mD2TE90Sd0NpsNNX1
	 bpUdQLOkX6ukA==
Date: Thu, 13 Nov 2025 10:05:19 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <aRWtX3n2I7El4Ykv@willie-the-truck>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106163953.1971067-2-smostafa@google.com>

Hi Mostafa,

On Thu, Nov 06, 2025 at 04:39:50PM +0000, Mostafa Saleh wrote:
> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> page_ext.
> This config will be used by the IOMMU API to track pages mapped in
> the IOMMU to catch drivers trying to free kernel memory that they
> still map in their domains, causing all types of memory corruption.
> This behaviour is disabled by default and can be enabled using
> kernel cmdline iommu.debug_pagealloc.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  drivers/iommu/Kconfig                         | 15 +++++++++
>  drivers/iommu/Makefile                        |  1 +
>  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>  mm/page_ext.c                                 |  4 +++
>  6 files changed, 75 insertions(+)
>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>  create mode 100644 include/linux/iommu-debug-pagealloc.h

This looks like a pretty handy feature to me, but I have some nits below.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..9a1c4ac8ba96 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2557,6 +2557,12 @@
>  			1 - Bypass the IOMMU for DMA.
>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>  
> +	iommu.debug_pagealloc=
> +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
> +			parameter enables the feature at boot time. By default, it
> +			is disabled and the system will work mostly the same as a
> +			kernel built without CONFIG_IOMMU_DEBUG_PAGEALLOC.

Can you be more specific about "mostly the same"?

> +
>  	io7=		[HW] IO7 for Marvel-based Alpha systems
>  			See comment before marvel_specify_io7 in
>  			arch/alpha/kernel/core_marvel.c.
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 70d29b14d851..6b5e9a2d936a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -383,4 +383,19 @@ config SPRD_IOMMU
>  
>  	  Say Y here if you want to use the multimedia devices listed above.
>  
> +config IOMMU_DEBUG_PAGEALLOC
> +	bool "Debug page memory allocations against IOMMU"

Perhaps "IOMMU mappings" would make this a little clearer?

> +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> +	help
> +	  This config checks that a page is freed(unmapped) or mapped by the
> +	  kernel is not mapped in any IOMMU domain.

I can't really parse this sentence :/

> It can help with debugging
> +	  use-after-free or out-of-bound maps from drivers doing DMA through
> +	  the IOMMU API.
> +	  This santaizer can have false-negative cases where some problems
> +	  won't be detected.

Maybe just say "The sanitizer is best-effort and can fail to detect problems
in the case that ...".

> +	  Expect overhead when enabling this and enabling the kernel command
> +	  line iommu.debug_pagealloc.

I'd reword this to say something like "Due to the overhead of the sanitiser,
iommu.debug_pagealloc must also be passed on the kernel command-line to
enable this feature".

> +
> +	  If unsure, say N here.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 355294fa9033..8f5130b6a671 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>  obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
>  obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
>  obj-$(CONFIG_APPLE_DART) += apple-dart.o
> +obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug-pagealloc.o
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> new file mode 100644
> index 000000000000..385c8bfae02b
> --- /dev/null
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 - Google Inc
> + * Author: Mostafa Saleh <smostafa@google.com>
> + * IOMMU API debug page alloc sanitizer
> + */
> +#include <linux/atomic.h>
> +#include <linux/iommu-debug-pagealloc.h>
> +#include <linux/kernel.h>
> +#include <linux/page_ext.h>
> +
> +static bool needed;
> +
> +struct iommu_debug_metadate {
> +	atomic_t ref;
> +};

s/metadate/metadata/

Will
