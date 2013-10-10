From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Introduce automatic stream-id-masking
Date: Thu, 10 Oct 2013 19:01:07 +0200
Message-ID: <20131010170107.GU2935@alberich>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381358286-27065-8-git-send-email-andreas.herrmann@calxeda.com>
	<20131010160539.GC8528@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131010160539.GC8528-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 10, 2013 at 12:05:39PM -0400, Will Deacon wrote:
> On Wed, Oct 09, 2013 at 11:38:06PM +0100, Andreas Herrmann wrote:
> > Try to determine a mask that can be used for all StreamIDs of a master
> > device. This allows to use just one SMR group instead of
> > number-of-streamids SMR groups for a master device.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |   79 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 63 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 91316a8..4e8ceab 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -28,6 +28,7 @@
> >   *	- Context fault reporting
> >   */
> >  
> > +#define DEBUG
> >  #define pr_fmt(fmt) "arm-smmu: " fmt
> >  
> >  #include <linux/delay.h>
> > @@ -341,6 +342,9 @@ struct arm_smmu_master {
> >  	struct rb_node			node;
> >  	int				num_streamids;
> >  	u16				streamids[MAX_MASTER_STREAMIDS];
> > +	int				num_smrs;
> 
> This is easy to confuse with smmu->num_mapping_groups, but is actually the
> number of SMRs in use by this master, right? Maybe tweaking the name
> (num_used_smrs?) would make this clearer.
> 
> > +	u16				smr_mask;
> > +	u16				smr_id;
> >  
> >  	/*
> >  	 * We only need to allocate these on the root SMMU, as we
> > @@ -530,14 +534,11 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
> >  					ARM_SMMU_OPT_MASK_STREAM_IDS));
> >  			return -EINVAL;
> >  		}
> > -		/* set fixed streamid (0) that will be used for masking */
> > -		master->num_streamids = 1;
> > -		master->streamids[0] = 0;
> > -	} else {
> > -		for (i = 0; i < master->num_streamids; ++i)
> > -			master->streamids[i] = masterspec->args[i];
> >  	}
> >  
> > +	for (i = 0; i < master->num_streamids; ++i)
> > +		master->streamids[i] = masterspec->args[i];
> > +
> >  	return insert_smmu_master(smmu, master);
> >  }
> >  
> > @@ -1049,6 +1050,41 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
> >  	kfree(smmu_domain);
> >  }
> >  
> > +/*
> > + * no duplicates streamids please
> > + */
> 
> We could probably check for that actually in register_smmu_master.
> 
> > +static void determine_smr_mapping(struct arm_smmu_device *smmu,
> > +				struct arm_smmu_master *master)
> > +{
> > +	int nr_sid;
> > +	u16 i, v1, v2, const_mask;
> 
> The bitwise stuff later on could use some more meaningful identifiers
> (although the comments do help).
> 
> > +
> > +	if (smmu->options & ARM_SMMU_OPT_MASK_STREAM_IDS) {
> > +		master->smr_mask = smmu->smr_mask_bits;
> > +		master->smr_id = 0;
> > +		return;
> > +	}
> > +
> > +	nr_sid = master->num_streamids;
> > +	if (!is_power_of_2(nr_sid))
> > +		return;
> 
> As I mentioned before, we could do better than this if we forced the DT to
> contain complete topological information. Then we could round up to the next
> power of two and check that we didn't accidentally include another device.
> What is your opinion on this?
> 
> > +	v1 = 0;
> > +	v2 = -1;
> 
> I'd rather this was written as 0xffff;
> 
> > +	for (i = 0; i < nr_sid; i++) {
> > +		v1 |= master->streamids[i];	/* for const 0 bits */
> > +		v2 &= ~(master->streamids[i]);	/* const 1 bits */
> > +	}
> > +	const_mask = (~v1) | v2;	/* const bits (either 0 or 1) */
> > +
> > +	v1 = hweight16(~const_mask);
> > +	if ((1 << v1) == nr_sid) {
> > +		/* if smr_mask is set, only 1 SMR group is used smr[0] = 0 */
> > +		master->smr_mask = ~const_mask;
> > +		master->smr_id = v1 & const_mask;
> > +	}
> 
> Hehe, this is cool, nice one! I originally thought you could just xor stuff,
> but that ends up being slightly nasty because it all has to be done pairwise.
> 
> > +}
> > +
> >  static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
> >  					  struct arm_smmu_master *master)
> >  {
> > @@ -1062,15 +1098,22 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
> >  	if (master->smrs)
> >  		return -EEXIST;
> >  
> > -	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
> > +	determine_smr_mapping(smmu, master);
> > +
> > +	if (master->smr_mask)
> > +		master->num_smrs = 1;
> 
> So the next challenge would be to allocate one SMR using your power-of-2
> trick, then mop up what's left with individual SMR entries.

BTW, the coding style of this patch might be nasty. I had cut it out
of some later version of my prototype driver and adapted it to your
driver.

So you don't generally object and it seems you'd accept this patch (if
minor things fixed) and I should scrub the other mask-stream-id patch.

Sigh ... so I need to figure out how to do the mop-up.


Andreas

PS: Even w/o the "mop-up" I could get my sata-smmu combination get working
    with this patch as it is.
    (I'd just need to add some fake streamids to get to a power-of-2. And
    yes, while I am writing this I am pretty sure you'd hate this ;-)
