From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu/io-pgtable-arm: Support 52-bit physical
	address
Date: Tue, 6 Mar 2018 17:54:15 +0000
Message-ID: <20180306175415.GC19134@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
	<fde583dacee8099ed4e952dbf1c4dfb42070e9c5.1512038236.git.robin.murphy@arm.com>
	<20180226180501.GC26147@arm.com>
	<52ff8cd6-64ec-d7d4-2135-0b17becc4251@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52ff8cd6-64ec-d7d4-2135-0b17becc4251-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Robin,

On Tue, Feb 27, 2018 at 01:49:14PM +0000, Robin Murphy wrote:
> On 26/02/18 18:05, Will Deacon wrote:
> >On Thu, Dec 14, 2017 at 04:58:51PM +0000, Robin Murphy wrote:
> >>Bring io-pgtable-arm in line with the ARMv8.2-LPA feature allowing
> >>52-bit physical addresses when using the 64KB translation granule.
> >>This will be supported by SMMUv3.1.
> >>
> >>Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >>---
> >>
> >>v2: Fix TCR_PS/TCR_IPS copy-paste error
> >>
> >>  drivers/iommu/io-pgtable-arm.c | 65 ++++++++++++++++++++++++++++++------------
> >>  1 file changed, 47 insertions(+), 18 deletions(-)
> >
> >[...]
> >
> >>@@ -203,6 +199,25 @@ struct arm_lpae_io_pgtable {
> >>  typedef u64 arm_lpae_iopte;
> >>+static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
> >>+				     struct arm_lpae_io_pgtable *data)
> >>+{
> >>+	arm_lpae_iopte pte = paddr;
> >>+
> >>+	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
> >>+	return (pte | (pte >> 36)) & ARM_LPAE_PTE_ADDR_MASK;
> >>+}
> >
> >I don't particularly like relying on properties of the paddr for correct
> >construction of the pte here. The existing macro doesn't have this
> >limitation. I suspect it's all fine at the moment because we only use TTBR0,
> >but I'd rather not bake that in if we can avoid it.
> 
> What's the relevance of TTBR0 to physical addresses? :/

Good point! I clearly got confused here.

> Note that by this point paddr has been validated against cfg->oas by
> arm_lpae_map(), and validated to be granule-aligned by iommu_map(), so it
> really can't be wrong under reasonable conditions.

Fair enough, but I still think this would be a bit more readable written
along the lines of:

	arm_lpae_iopte pte_hi, pte_lo = 0;

	pte_hi = paddr & GENMASK(47, data->pg_shift);
	if (data->pg_shift == 16) {
		pte_lo = paddr & GENMASK(ARM_LPAE_MAX_ADDR_BITS - 1, 48);
		pte_lo >>= (48 - 12);
	}

	return pte_hi | pte_lo;

Ok, we don't squeeze every last cycle out of it, but I find it much more
readable. Is it just me? The magic numbers could be #defined and/or
derived if necessary.

> >>+static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
> >>+				  struct arm_lpae_io_pgtable *data)
> >>+{
> >>+	phys_addr_t paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
> >>+	phys_addr_t paddr_hi = paddr & (ARM_LPAE_GRANULE(data) - 1);
> >>+
> >>+	/* paddr_hi spans nothing for 4K granule, and only RES0 bits for 16K */
> >>+	return (paddr ^ paddr_hi) | (paddr_hi << 36);
> >
> >Why do we need xor here?
> 
> Because "(paddr ^ paddr_hi)" is more concise than "(paddr &
> ~(phys_addr_t)(ARM_LPAE_GRANULE(data) - 1)" or variants thereof. It's
> potentially a teeny bit more efficient too, I think, but it's mostly about
> the readability.

I don't think the bit-twiddling is super readable, to be honest. Again,
something like:

	phys_addr_t paddr_lo, paddr_hi = 0;

	paddr_lo = pte & GENMASK(47, data->pg_shift);
	if (data->pg_shift == 16) {
		paddr_hi = pte & GENMASK(15, 12);
		paddr_hi <<= (48 - 12);
	}

	return paddr_hi | paddr_lo;

but I've not even compiled this stuff...

> >>+	cfg->pgsize_bitmap &= page_sizes;
> >>+	cfg->ias = min(cfg->ias, max_addr_bits);
> >>+	cfg->oas = min(cfg->oas, max_addr_bits);
> >
> >I don't think we should be writing to the ias/oas fields here, at least
> >now without auditing the drivers and updating the comments about the
> >io-pgtable API. For example, the SMMUv3 driver uses its own ias local
> >variable to initialise the domain geometry, and won't pick up any changes
> >made here.
> 
> As you've discovered, the driver thing is indeed true. More generally,
> though, we've always adjusted cfg->pgsize_bitmap here, so I don't see why
> other fields should be treated differently - I've always assumed the cfg
> which the driver passes in here just represents its total maximum
> capabilities, from which it's io-pgtable's job to pick an appropriate
> configuration.

Can you update the the header file with a comment to that effect, please?

Will
