From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
	caching of bypass entries
Date: Wed, 2 Nov 2016 19:26:02 +0000
Message-ID: <DB6PR0402MB26942C3D65D70A1C1C84F746E6A00@DB6PR0402MB2694.eurprd04.prod.outlook.com>
References: <1478093714-17219-1-git-send-email-nipun.gupta@nxp.com>
	<d1c89f6f-1b7a-6180-a376-27505d3b6c9f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d1c89f6f-1b7a-6180-a376-27505d3b6c9f-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, November 02, 2016 16:51
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
> caching of bypass entries
> 
> Hi Nipun,
> 
> On 02/11/16 13:35, Nipun Gupta wrote:
> > The SMTNMB_TLBEN in the Auxiliary Configuration Register (ACR)
> > provides an option to enable the updation of TLB in case of bypass
> > transactions due to no stream match in the stream match table. This
> > reduces the latencies of the subsequent transactions with the same stream-id
> which bypasses the SMMU.
> > This provides a significant performance benefit for certain networking
> > workloads.
> 
> ...at the cost of increased TLB contention against other workloads.
> However, in the general case we'd expect the system to be fully described, so if
> there aren't any unmatched Stream IDs there hopefully shouldn't be an impact
> to leaving this switched on. I'd be interested to see some actual performance
> numbers, though - you already know my opinion about unsubstantiated quotes
> from the MMU-500 TRM.

With this change we have seen substantial performance improvement of ~9-10%
with DPDK l3fwd application (http://dpdk.org/doc/guides/sample_app_ug/l3_forward.html)
on NXP's LS2088a platform (single core as well as multi-core). Also, with ODP reflector application
(loopback mode - NXP in-house) we have seen 5% improvement in performance on
LS1088 platform.

W.r.t. the read latencies, they are reduced to avg. ~50 platform cycles from avg. ~140
platform cycles per memory read transactions which follow this bypass path (on LS2088
with DPDK l3fwd application).

(Apologies, I cannot share the DPDK/ODP exact performance numbers on the mailing list).

> 
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > ce2a9d4..7010a5c 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -246,6 +246,7 @@ enum arm_smmu_s2cr_privcfg {
> >
> >  #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
> >
> > +#define ACR_SMTNMB_TLBEN		(1 << 8)
> 
> ACR is entirely implementation-defined, so there are no generic field names.
> Please follow the naming convention handily demonstrated in the subsequent
> context line.
> 
> >  #define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)
> 
> Actually, can we also please keep these in descending order of bit position like
> everything else?
> 
> >  #define CB_PAR_F			(1 << 0)
> > @@ -1569,18 +1570,26 @@ static void arm_smmu_device_reset(struct
> arm_smmu_device *smmu)
> >  	for (i = 0; i < smmu->num_mapping_groups; ++i)
> >  		arm_smmu_write_sme(smmu, i);
> >
> > +	/* Get the major rev required for configuring ACR */
> 
> That comment is nonsense.
> 
> > +	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
> > +	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
> > +
> >  	/*
> >  	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
> >  	 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
> >  	 * bit is only present in MMU-500r2 onwards.
> >  	 */
> > -	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
> > -	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
> > -	if ((smmu->model == ARM_MMU500) && (major >= 2)) {
> > -		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
> > +	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
> > +	if ((smmu->model == ARM_MMU500) && (major >= 2))
> >  		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
> > -		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
> > -	}
> > +
> > +	/*
> > +	 * Set the SMTNMB_TLBEN in ACR so that the transactions which
> > +	 * bypass with SMMU due to no stream match found in the SMR table
> > +	 * are updated in the TLB's.
> 
> Or simply, e.g. "Allow unmatched Stream IDs to allocate bypass TLB entries for
> reduced latency". It's already clear from the code what bit's being set where, we
> only need to remember *why*.
> 
> > +	 */
> > +	reg |= ACR_SMTNMB_TLBEN;
> > +	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
> 
> Are you sure it's perfectly fine to set that implementation-defined bit on any
> SMMU implementation other than the two-and-a-half ARM Ltd. ones which
> happen to share the same meaning? I'm certainly not.
> 
> The correct flow would be something like this:
> 
> 	if (smmu->model == ARM_MMU500) {
> 		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
> 		major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
> 		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
> 		if (major >= 2)
> 	  		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
> 		reg |= ACR_SMTNMB_TLBEN;
> 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
> 	}
> 
> The shape of the current code avoids an extra level of indentation, but once you
> have to have the nested conditional anyway, it might as well all be predicated
> appropriately.
> 

Thank you for providing the useful comments. I would incorporate them all in next version :).

Regards,
Nipun

> Robin.
> 
> >  	/* Make sure all context banks are disabled and clear CB_FSR  */
> >  	for (i = 0; i < smmu->num_context_banks; ++i) {
> >
