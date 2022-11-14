Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47813FC2
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 11:01:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82EFF23A;
	Mon, 14 Nov 2022 03:01:53 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53BF73F73D;
	Mon, 14 Nov 2022 03:01:46 -0800 (PST)
Message-ID: <62dbd28e-0024-b506-ed7d-11200f08a1ed@arm.com>
Date: Mon, 14 Nov 2022 11:01:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [patch 10/10] iommu/of: Remove linux/msi.h include
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.889624434@linutronix.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221113202428.889624434@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-13 20:34, Thomas Gleixner wrote:
> Nothing in this file needs anything from linux/msi.h

Indeed, looks like it was part of a mechanical conversion and never 
actually needed.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> ---
>   drivers/iommu/of_iommu.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -9,7 +9,6 @@
>   #include <linux/iommu.h>
>   #include <linux/limits.h>
>   #include <linux/module.h>
> -#include <linux/msi.h>
>   #include <linux/of.h>
>   #include <linux/of_iommu.h>
>   #include <linux/of_pci.h>
> 
