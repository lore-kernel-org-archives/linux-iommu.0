From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 01/16] iommu: introduce bind_pasid_table API function
Date: Tue, 10 Oct 2017 14:32:14 -0700
Message-ID: <20171010143214.05fe8ecd@jacob-builder>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<20171010131433.fgo5tnwidzywfnx4@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171010131433.fgo5tnwidzywfnx4-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liu-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 10 Oct 2017 15:14:33 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Hi Jacob,
> 
> On Thu, Oct 05, 2017 at 04:03:29PM -0700, Jacob Pan wrote:
> > +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct
> > device *dev) +{
> > +	if (unlikely(!domain->ops->unbind_pasid_table))
> > +		return -EINVAL;
> > +
> > +	return domain->ops->unbind_pasid_table(domain, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);  
> 
> Are there other reasons to let the unbind fail? Otherwise I'd suggest
> to just make this a void function. Also not sure what the user of this
> function should do when the unbind really fails.
> 
Agreed, void should do. There is no action for the callers.
> > +enum pasid_table_model {
> > +	PASID_TABLE_FORMAT_HOST,  
> 
> What is this FORMAT_HOST for?
> 
I was thinking it indicates whatever the host format is, if the guest
does not care.
> > +	PASID_TABLE_FORMAT_ARM_1LVL,
> > +	PASID_TABLE_FORMAT_ARM_2LVL,
> > +	PASID_TABLE_FORMAT_AMD,
> > +	PASID_TABLE_FORMAT_INTEL,
> > +};
> > +
> > +/**
> > + * PASID table data used to bind guest PASID table to the host
> > IOMMU. This will
> > + * enable guest managed first level page tables.
> > + * @version: for future extensions and identification of the data
> > format
> > + * @bytes: size of this structure
> > + * @base_ptr:	PASID table pointer
> > + * @pasid_bits:	number of bits supported in the guest PASID
> > table, must be less
> > + *		or equal than the host table size.
> > + * @model:	PASID table format for different IOMMU models
> > + */
> > +struct pasid_table_config {
> > +	__u32 version;  
> 
> Can you also add a define for the version number? Userspace needs it
> to initialize the struct and the kernel to check against it.
> 
Good point.
> > +	__u32 bytes;
> > +	__u64 base_ptr;
> > +	__u8 pasid_bits;
> > +	enum pasid_table_model model;
> > +	union {
> > +		struct {
> > +			/* Intel specific fields */
> > +		} intel;
> > +
> > +		struct {
> > +			/* ARM specific fields */
> > +			bool pasid0_dma_no_pasid;
> > +		} arm;
> > +
> > +		struct {
> > +			/* AMD specific fields */
> > +		} amd;  
> 
> Thinking more about this, we can omit the sub-structs for models that
> don't need them. For the amd-model for example the base_ptr and
> pasid_bits fields are sufficient.
> 
> 
Sounds good, we can always add later and bump up the version. Intel does
not need model data for now.
> Regards,
> 
> 	Joerg

[Jacob Pan]
