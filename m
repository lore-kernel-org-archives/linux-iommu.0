From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: bind pasid table API
Date: Wed, 20 Sep 2017 13:09:47 +0100
Message-ID: <6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
References: <20170918204516.2f6beffb@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170918204516.2f6beffb@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

[Adding Eric as he might need pasid_table_info for vSVM at some point]

On 19/09/17 04:45, Jacob Pan wrote:
> Hi Jean and All,
> 
> This is a follow-up on the LPC discussion we had last week.
> (https://linuxplumbersconf.org/2017/ocw/proposals/4748)
> 
> My understanding is that the data structure below can satisfy the
> needs from Intel (pointer + size) and AMD (pointer only). But ARM
> pvIOMMU would need additional info to indicate the page table format.
> Could you share your idea of the right addition for ARM such that we
> can have a unified API?
> 
> /**
>  * PASID table data used to bind guest PASID table to the host IOMMU. This will
>  * enable guest managed first level page tables.
>  * @ptr:	PASID table pointer
>  * @size_order:	number of bits supported in the guest PASID table, must be less
>  *		or equal than the host table size.
>  */
> struct pasid_table_info {
> 	__u64	ptr;
> 	__u64	size_order;
> };

For the PASID table, Arm SMMUv3 would need two additional fields:
* 'format' telling whether the table has 1 or 2 levels and their
  dimensions,
* 'default_substream' telling if PASID0 is reserved for non-pasid traffic.

I think that's it for the moment, but it does require to leave space
for a vendor-specific structure at the end. It is one reason why I'd
prefer having a 'model' field in the pasid_table_info structure telling
what fields the whole structure actually contains.

Another reason is if some IOMMU is able to support multiple PASID table
formats, it could advertise them all in sysfs and Qemu could tell which
one it chose in 'model'. I'm not sure we'll ever see that in practice.



For binding page tables instead of PASID tables (e.g. virtio-iommu), the
generic data would be:

struct pgtable_info {
	__u32	pasid;
	__u64	ptr;
	__u32	model;
	__u8	model_data[];
};

Followed by a few arch-specific configuration values. For Arm we can
summarize this to three registers, defined in the Armv8 Architecture
Reference Manual:

struct arm_lpae_pgtable_info {
	__u64	tcr;	/* Translation Control Register */
	__u64	mair;	/* Memory Attributes Indirection Register */
	__u64	asid;	/* Address Space ID */
};

Some data packed in the TCR might be common to most architectures, like
page granularity and max VA size. Most fields of the TCR won't be used but
it provides a nice architected way to communicate Arm page table
configuration.

Note that there might be an additional page directory in the arch-specific
info, as we can split the address space in two. I'm not sure whether we
should allow it yet.

Thanks,
Jean
