Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C793C05
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 12:09:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D675139F;
	Fri, 23 Sep 2022 05:09:56 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A84D3F73D;
	Fri, 23 Sep 2022 05:09:48 -0700 (PDT)
Message-ID: <a5a3ae17-ca58-d93d-e6b0-708ea5fc1ff8@arm.com>
Date: Fri, 23 Sep 2022 13:09:44 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Content-Language: en-GB
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kbuild@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20220923113835.21544-1-masahiroy@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220923113835.21544-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-23 12:38, Masahiro Yamada wrote:
> sg_alloc_table_chained() is called by several drivers, but if it is
> called before sg_pool_init(), it results in a NULL pointer dereference
> in sg_pool_alloc().
> 
> Since commit 9b1d6c895002 ("lib: scatterlist: move SG pool code from
> SCSI driver to lib/sg_pool.c"), we rely on module_init(sg_pool_init)
> is invoked before other module_init calls but this assumption is
> fragile.
> 
> I slightly changed the link order while Kbuild refactoring Kbuild,
> then uncovered this issue. I should keep the current link order, but
> depending on a specific call order among module_init is so fragine.
> 
> We usually define the init order by specifying *_initcall correctly,
> or delay the driver probing by returning -EPROBE_DEFER.
> 
> Change module_initcall() to subsys_initcall(), and also delete the
> pointless module_exit() because lib/sg_pool.c is always compiled as
> built-in. (CONFIG_SG_POOL is bool)

Makes sense to me. Short of having some cool-but-impractically-complex 
system to derive a dependency graph from the config and compute an 
initcall order from that, initialising helper library code at an earlier 
step than drivers certainly seems like the next-best option, and subsys 
doesn't seem inappropriate for the nature of this code. FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Link: https://lore.kernel.org/all/20220921043946.GA1355561@roeck-us.net/
> Link: https://lore.kernel.org/all/8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com/
> Fixes: 9b1d6c895002 ("lib: scatterlist: move SG pool code from SCSI driver to lib/sg_pool.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> I am sending this to DMA subsystem because I did not find
> a corresponding one for lib/sg_pool.c
> 
>   lib/sg_pool.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index a0b1a52cd6f7..9bfe60ca3f37 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -#include <linux/module.h>
> +#include <linux/init.h>
>   #include <linux/scatterlist.h>
>   #include <linux/mempool.h>
>   #include <linux/slab.h>
> @@ -177,16 +177,4 @@ static __init int sg_pool_init(void)
>   	return -ENOMEM;
>   }
>   
> -static __exit void sg_pool_exit(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < SG_MEMPOOL_NR; i++) {
> -		struct sg_pool *sgp = sg_pools + i;
> -		mempool_destroy(sgp->pool);
> -		kmem_cache_destroy(sgp->slab);
> -	}
> -}
> -
> -module_init(sg_pool_init);
> -module_exit(sg_pool_exit);
> +subsys_initcall(sg_pool_init);
