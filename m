From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: RE: [PATCH] iommu/arm-smmu: fix bug in pmd construction
Date: Sun, 21 Sep 2014 07:56:28 +0000
Message-ID: <1dbe5bf443a44828bf27d282a93c1065@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1411163922-8833-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411163922-8833-1-git-send-email-mitchelh@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Mitchel,
I have made changes to the arm smmu driver paging support, as a part of the huge page support patch. Will is currently reviewing changes made by me. I should be able to post my patch in the next couple of weeks.

Regards
Vaun

> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Mitchel Humpherys
> Sent: Saturday, September 20, 2014 3:29 AM
> To: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> Will Deacon
> Subject: [PATCH] iommu/arm-smmu: fix bug in pmd construction
> 
> We are using the same pfn for every pte we create while constructing the pmd.
> Fix this by actually updating the pfn on each iteration of the pmd construction
> loop.
> 
> It's not clear if we can actually hit this bug right now since iommu_map splits up
> the calls to .map based on the page size, so we only ever seem to iterate this
> loop once. However, things might change in the future that might cause us to
> hit this.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
> Will, I was unable to come up with a test case to hit this bug based on what I
> said in the commit message above. Not sure if my analysis is completely off
> base, my head is still spinning from all these page tables :).
> ---
>  drivers/iommu/arm-smmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> ca18d6d42a..eba4cb390c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1368,6 +1368,7 @@ static int arm_smmu_alloc_init_pmd(struct
> arm_smmu_device *smmu, pud_t *pud,
>  		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
>  					      prot, stage);
>  		phys += next - addr;
> +		pfn = __phys_to_pfn(phys);
>  	} while (pmd++, addr = next, addr < end);
> 
>  	return ret;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
