Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A73C38
	for <iommu@lists.linux.dev>; Fri, 25 Nov 2022 17:02:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59622B;
	Fri, 25 Nov 2022 09:02:53 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9FE23F73B;
	Fri, 25 Nov 2022 09:02:45 -0800 (PST)
Message-ID: <b5682296-4844-863c-83c1-1fb9a35009d8@arm.com>
Date: Fri, 25 Nov 2022 17:02:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
Content-Language: en-GB
To: Ricardo Ribalda <ribalda@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-25 16:28, Ricardo Ribalda wrote:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0

Hmm, shouldn't we clear any pending faults at probe in 
mtk_iommu_hw_init(), before the IRQ is requested? mtk_iommu_isr() might 
still want to be robust against a spurious interrupt, but then it can 
simply return without doing anything at all if the domain is NULL, since 
we'll know that's the case.

Thanks,
Robin.

(It might be nice if request_irq() had a flag to say "if this IRQ looks 
pending already just clear it" for drivers that know it could only be 
spurious at that point; kexec seems to lead to this problem quite a lot...)

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: Yong Wu <yong.wu@mediatek.com>
> To: Joerg Roedel <joro@8bytes.org>
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2ab2ecfe01f8..17f6be5a5097 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>   		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
>   	}
>   
> -	if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
> +	if (dom && report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
>   			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>   		dev_err_ratelimited(
>   			bank->parent_dev,
> 
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221125-mtk-iommu-13023f971298
> 
> Best regards,
