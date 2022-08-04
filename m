Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CAF7C
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 16:31:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE0B1113E;
	Thu,  4 Aug 2022 09:31:45 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DCC83F73B;
	Thu,  4 Aug 2022 09:31:44 -0700 (PDT)
Message-ID: <90a760c4-6e88-07b4-1f20-8b10414e49aa@arm.com>
Date: Thu, 4 Aug 2022 17:31:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/omap: fix buffer overflow in debugfs
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@oracle.com>, Joerg Roedel <joro@8bytes.org>,
 Suman Anna <s-anna@ti.com>
Cc: Will Deacon <will@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org
References: <YuvYh1JbE3v+abd5@kili>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YuvYh1JbE3v+abd5@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2022 3:32 pm, Dan Carpenter wrote:
> There are two issues here:
> 
> 1) The "len" variable needs to be checked before the very first write.
>     Otherwise if omap2_iommu_dump_ctx() with "bytes" less than 32 it is a
>     buffer overflow.
> 2) The snprintf() function returns the number of bytes that *would* have
>     been copied if there were enough space.  But we want to know the
>     number of bytes which were *actually* copied so use scnprintf()
>     instead.
> 
> Fixes: bd4396f09a4a ("iommu/omap: Consolidate OMAP IOMMU modules")

FWIW I think this has actually been broken since day one back in 
14e0e6796a0d, but I'm also not inclined to care that much - 2014 is 
already plenty long ago.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/iommu/omap-iommu-debug.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> index a99afb5d9011..259f65291d90 100644
> --- a/drivers/iommu/omap-iommu-debug.c
> +++ b/drivers/iommu/omap-iommu-debug.c
> @@ -32,12 +32,12 @@ static inline bool is_omap_iommu_detached(struct omap_iommu *obj)
>   		ssize_t bytes;						\
>   		const char *str = "%20s: %08x\n";			\
>   		const int maxcol = 32;					\
> -		bytes = snprintf(p, maxcol, str, __stringify(name),	\
> +		if (len < maxcol)					\
> +			goto out;					\
> +		bytes = scnprintf(p, maxcol, str, __stringify(name),	\
>   				 iommu_read_reg(obj, MMU_##name));	\

I suppose snprintf is OK in practice since none of the names are 
anywhere near 20 characters long anyway, but I agree it's better to be 
obviously foolproof. Frankly this code is all kinds of horrible anyway, 
and deserves ripping out and replacing with a simple seq_file, but for 
this fix as a fix,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

>   		p += bytes;						\
>   		len -= bytes;						\
> -		if (len < maxcol)					\
> -			goto out;					\
>   	} while (0)
>   
>   static ssize_t
