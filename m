From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v8 18/18] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP anymore
Date: Wed, 18 Jan 2017 12:46:02 +0100
Message-ID: <6ea18f9d-a09c-6af6-9852-decffa680e55@semihalf.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
 <1484127714-3263-19-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484127714-3263-19-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: drjones@redhat.com, kvm@vger.kernel.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, geethasowjanya.akula@gmail.com, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, bharat.bhushan@nxp.com, shankerd@codeaurora.org, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 11.01.2017 10:41, Eric Auger wrote:
> IOMMU_CAP_INTR_REMAP has been advertised in arm-smmu(-v3) although
> on ARM this property is not attached to the IOMMU but rather is
> implemented in the MSI controller (GICv3 ITS).
>
> Now vfio_iommu_type1 checks MSI remapping capability at MSI controller
> level, let's correct this.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

For patches [15-18]:
Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz

>
> ---
>
> v7 -> v8:
> - added Will's A-b
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 --
>  drivers/iommu/arm-smmu.c    | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6c4111c..d9cf6cb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1375,8 +1375,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> -	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
>  	default:
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a354572..13d2600 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1374,8 +1374,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  		 * requests.
>  		 */
>  		return true;
> -	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
>  	default:
>
