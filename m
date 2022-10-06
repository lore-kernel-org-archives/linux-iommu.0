Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5487F6
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 10:34:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1157BD6E;
	Thu,  6 Oct 2022 03:34:50 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01A2A3F792;
	Thu,  6 Oct 2022 03:34:42 -0700 (PDT)
Message-ID: <32ecbd1c-0940-85ee-2ca9-687d80317948@arm.com>
Date: Thu, 6 Oct 2022 11:34:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] iommu: fsl_pamu: Replace NO_IRQ by 0
Content-Language: en-GB
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-10-06 06:24, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.

Crucially, NO_IRQ *is* 0 on PowerPC where this driver actually runs, so 
there's no functional issue here. However the justification for cleaning 
it up makes perfect sense overall.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   drivers/iommu/fsl_pamu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 0d03f837a5d4..1b53d2da2c19 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -779,7 +779,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>   	of_get_address(dev->of_node, 0, &size, NULL);
>   
>   	irq = irq_of_parse_and_map(dev->of_node, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>   		dev_warn(dev, "no interrupts listed in PAMU node\n");
>   		goto error;
>   	}
> @@ -903,7 +903,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>   	return 0;
>   
>   error:
> -	if (irq != NO_IRQ)
> +	if (irq)
>   		free_irq(irq, data);
>   
>   	kfree_sensitive(data);
