From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 10/19] iommu/arm-smmu: Keep track of S2CR state
Date: Thu, 1 Sep 2016 19:42:59 +0100
Message-ID: <20160901184259.GU6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<e086741acfd0959671d184203ef758c824c8d7da.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e086741acfd0959671d184203ef758c824c8d7da.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 23, 2016 at 08:05:21PM +0100, Robin Murphy wrote:
> Making S2CRs first-class citizens within the driver with a high-level
> representation of their state offers a neat solution to a few problems:
> 
> Firstly, the information about which context a device's stream IDs are
> associated with is already present by necessity in the S2CR. With that
> state easily accessible we can refer directly to it and obviate the need
> to track an IOMMU domain in each device's archdata (its earlier purpose
> of enforcing correct attachment of multi-device groups now being handled
> by the IOMMU core itself).
> 
> Secondly, the core API now deprecates explicit domain detach and expects
> domain attach to move devices smoothly from one domain to another; for
> SMMUv2, this notion maps directly to simply rewriting the S2CRs assigned
> to the device. By giving the driver a suitable abstraction of those
> S2CRs to work with, we can massively reduce the overhead of the current
> heavy-handed "detach, free resources, reallocate resources, attach"
> approach.
> 
> Thirdly, making the software state hardware-shaped and attached to the
> SMMU instance once again makes suspend/resume of this register group
> that much simpler to implement in future.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 159 +++++++++++++++++++++++++++--------------------
>  1 file changed, 93 insertions(+), 66 deletions(-)

[...]

> @@ -1145,9 +1198,16 @@ static void arm_smmu_master_free_smes(struct arm_smmu_device *smmu,
>  static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  				      struct arm_smmu_master_cfg *cfg)
>  {
> -	int i, ret;
> +	int i, ret = 0;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> +	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
> +	enum arm_smmu_s2cr_type type = S2CR_TYPE_TRANS;
> +	u8 cbndx = smmu_domain->cfg.cbndx;
> +
> +	if (cfg->smendx[0] < 0)

Shouldn't that be INVALID_SMENDX?

Will
