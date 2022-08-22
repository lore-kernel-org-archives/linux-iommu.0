Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC17FA
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktMzlSFdVQYUGp03litM44l4Gx4FNd+6ZShF2nft75g=; b=ljTOP2NOOOEPk/1TF0QWa2ajJK
	KqVDEbmCr3KQ/zmtQkDGm+QLYYN700ufnjfEvy1vtpoJ4aVO/lgj72RIHglIaG925iWDmeOjw3dKV
	czsJEaLgSURBV5wXu11GNsq/cyf4fehp4tVZce8bAqBR2CAwf6z35O0JglOYWn5R/jhd5UDHOoHgb
	Y2cfZz3F+KsGqv4Q4FR7ewbMpiTTX0ulhL4skI3GErKOcf0l/8usRywD9U9tl7oQsoQoAtvEPS+W6
	GeeraySviOpmiP/U4zpRidJB9qXKKrL/8KB2RW1gBml8txR18tMwhdxARX18wedHD0OKaP1CQVC0A
	BSGHMG1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ5UQ-0087Er-3k; Mon, 22 Aug 2022 11:21:06 +0000
Date: Mon, 22 Aug 2022 04:21:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, catalin.marinas@arm.com,
	jean-philippe@linaro.org, inki.dae@samsung.com,
	sw0312.kim@samsung.com, kyungmin.park@samsung.com,
	tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com,
	cohuck@redhat.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/dma: Move public interfaces to linux/iommu.h
Message-ID: <YwNmosMGZdGtY3LX@infradead.org>
References: <cover.1660668998.git.robin.murphy@arm.com>
 <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd99738f52094e6bed44bfee03fa4f288d20695.1660668998.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 70393fbb57ed..79cb6eb560a8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1059,4 +1059,40 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> +#ifdef CONFIG_IOMMU_DMA
> +#include <linux/msi.h>

I don't think msi.h is actually needed here.

Just make the struct msi_desc and struct msi_msg forward declarations
unconditional and we should be fine.
