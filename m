From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 5/5] iommu/arm-smmu: fix compilation issue when
 !CONFIG_ARM_AMBA
Date: Thu, 13 Feb 2014 10:55:25 -0600
Message-ID: <CAOZdJXW6tY=MjHGMa1EQtJayY=ToqiJOWsggCsEjfPzirUeUxg@mail.gmail.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
 <1391710173-4343-6-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391710173-4343-6-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 6, 2014 at 12:09 PM, Will Deacon <will.deacon@arm.com> wrote:

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 0ae4dd39197f..6fe7922ecc1d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2004,8 +2004,10 @@ static int __init arm_smmu_init(void)
>         if (!iommu_present(&platform_bus_type))
>                 bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
>
> +#ifdef CONFIG_ARM_AMBA
>         if (!iommu_present(&amba_bustype))
>                 bus_set_iommu(&amba_bustype, &arm_smmu_ops);
> +#endif

So I admit I don't know much about the ARM kernel (yet), but doesn't
this break multi-arch?  That is, we can't support one binary that runs
on a processor with AMBA and one without?
