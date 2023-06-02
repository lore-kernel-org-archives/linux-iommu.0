Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FB107B1
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 11:19:50 +0000 (UTC)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXgWX33svz6J6qG;
	Fri,  2 Jun 2023 19:19:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 12:19:40 +0100
Date: Fri, 2 Jun 2023 12:19:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
	<hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Will
 Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "Ard
 Biesheuvel" <ardb@kernel.org>, Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, "Joerg Roedel" <joro@8bytes.org>, Mark Brown
	<broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 10/17] iio: core: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <20230602121939.00000e20@Huawei.com>
In-Reply-To: <20230531154836.1366225-11-catalin.marinas@arm.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
	<20230531154836.1366225-11-catalin.marinas@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Wed, 31 May 2023 16:48:29 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.

Jonathan

> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 81413cd3a3e7..d28a5e8097e4 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -722,7 +722,7 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>   * must not share  cachelines with the rest of the structure, thus making
>   * them safe for use with non-coherent DMA.
>   */
> -#define IIO_DMA_MINALIGN ARCH_KMALLOC_MINALIGN
> +#define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>  
>  /* The information at the returned address is guaranteed to be cacheline aligned */
> 
> 

