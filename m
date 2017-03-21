From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 4/5] iommu/arm-smmu-v3: Install bypass STEs for
	IOMMU_DOMAIN_IDENTITY domains
Date: Tue, 21 Mar 2017 17:08:16 +0000
Message-ID: <20170321170816.GE30948@arm.com>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
	<1489178976-15353-5-git-send-email-will.deacon@arm.com>
	<420a5345344b4b574878caf3a916f1f2@codeaurora.org>
	<7d39363e-90e8-4119-3b7e-b1c4f6250879@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7d39363e-90e8-4119-3b7e-b1c4f6250879-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Mar 16, 2017 at 06:19:48PM +0000, Robin Murphy wrote:
> On 16/03/17 16:24, Nate Watterson wrote:
> > On 2017-03-10 15:49, Will Deacon wrote:
> >> In preparation for allowing the default domain type to be overridden,
> >> this patch adds support for IOMMU_DOMAIN_IDENTITY domains to the
> >> ARM SMMUv3 driver.
> >>
> >> An identity domain is created by placing the corresponding stream table
> >> entries into "bypass" mode, which allows transactions to flow through
> >> the SMMU without any translation.
> >>
> > 
> > What about masters that require SMMU intervention to override their
> > native memory attributes to make them consistent with the CCA (acpi)
> > or dma-coherent (dt) values specified in FW?
> 
> Well, we've already broken them ;) My interpretation of "dma-coherent"
> is as the equivalent of DACS=1,CPM=1, i.e. not dependent on SMMU
> override. For the CCA=1,DACS=0 case (I'm going to pretend the DT
> equivalent will never exist...) the first problem to solve is how to
> inherit the appropriate configuration from the firmware, because right
> now we're not even pretending to support that.

Indeed, and that would need to be added as a separate patch series when
the need arises.

> >>      /* Nuke the existing STE_0 value, as we're going to rewrite it */
> >> -    val = ste->valid ? STRTAB_STE_0_V : 0;
> >> +    val = STRTAB_STE_0_V;
> >> +
> >> +    /* Bypass/fault */
> >> +    if (!ste->assigned || !(ste->s1_cfg || ste->s2_cfg)) {
> >> +        if (!ste->assigned && disable_bypass)
> 
> ...yuck. After about 5 minutes of staring at that, I've convinced myself
> that it would make much more sense to always clear the strtab_ent
> configs on detach, such that you never need the outer !ste->assigned
> check here...

I was deliberately keeping the strtab_ent intact in case we ever grow
support for nested translation, where we might well want to detach a
stage 1 but keep the stage 2 installed. I don't think the code is that
bad, so I'd like to leave it like it is for now.

Will
