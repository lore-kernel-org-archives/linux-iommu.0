From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: bind pasid table API
Date: Mon, 25 Sep 2017 12:45:00 +0100
Message-ID: <ef71b446-ae00-29af-a934-2e253454df31@arm.com>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<20170920153510.4dc5e5c3@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170920153510.4dc5e5c3@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20/09/17 23:35, Jacob Pan wrote:
> On Wed, 20 Sep 2017 13:09:47 +0100
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>> Hi Jacob,
>>
>> [Adding Eric as he might need pasid_table_info for vSVM at some point]
>>
>> On 19/09/17 04:45, Jacob Pan wrote:
>>> Hi Jean and All,
>>>
>>> This is a follow-up on the LPC discussion we had last week.
>>> (https://linuxplumbersconf.org/2017/ocw/proposals/4748)
>>>
>>> My understanding is that the data structure below can satisfy the
>>> needs from Intel (pointer + size) and AMD (pointer only). But ARM
>>> pvIOMMU would need additional info to indicate the page table
>>> format. Could you share your idea of the right addition for ARM
>>> such that we can have a unified API?
>>>
>>> /**
>>>  * PASID table data used to bind guest PASID table to the host
>>> IOMMU. This will
>>>  * enable guest managed first level page tables.
>>>  * @ptr:	PASID table pointer
>>>  * @size_order:	number of bits supported in the guest PASID
>>> table, must be less
>>>  *		or equal than the host table size.
>>>  */
>>> struct pasid_table_info {
>>> 	__u64	ptr;
>>> 	__u64	size_order;
>>> };  
>>
>> For the PASID table, Arm SMMUv3 would need two additional fields:
>> * 'format' telling whether the table has 1 or 2 levels and their
>>   dimensions,
> just wondering if the format will be different than whatever is used on
> the host? i.e. could there be a mismatch? I am ok with this field just
> wondering if this can be resolved via the sysfs query interface if that
> is a global thing.

This format tells how the guest organizes its PASID tables. Depending on
'format', the PASID table can be:
* A flat array of descriptors
* One array of 1st-level descriptors pointing to a 2nd level of
descriptors. When translating an access, the SMMU splits the PASID at bit
6, uses the upper half to get the 1st level descriptor and the lower half
to get the 2nd level one (4k leaf table).
* The same format, but instead split at PASID bit 10 (64k leaf table)

So the guest has to tell the host what format of PASID tables it chose,
but the configuration might be too vendor-specific to go in the generic
part of pasid_table_info.

It seems that AMD IOMMUv2 can have either one, two or three levels of
PASID tables. See definition of GLX field in the 3.2.2.1 Device Table
Entry Format.

We could try to come up with a generic definition to cover all these
cases, but it might be more complicated than appending a few
vendor-specific fields. Only AMD can have three levels, only ARM can split
the PASID in two different places. And we can expect a future architecture
to come up with a new colorful format...

I'm mostly concerned about VFIO though, as the IOMMU API doesn't have the
same backward compatible restriction and is therefore easier to update.

>> * 'default_substream' telling if PASID0 is reserved for non-pasid
>> traffic.
>>
> could it be part of a feature flag? i.e.
> 
> struct pasid_table_info {
>  	__u64	ptr;
>  	__u64	size_order;
> 	__u64	flags;
> #define PASID0_FOR_DMA_WITHOUT_PASID;
> 	enum pasid_table_format format;
> };  
> 
>> I think that's it for the moment, but it does require to leave space
>> for a vendor-specific structure at the end. It is one reason why I'd
>> prefer having a 'model' field in the pasid_table_info structure
>> telling what fields the whole structure actually contains.
>>
> I think we have been there before. the downside is that model specific
> knowledge is required in the generic VFIO layer, if its content is to
> be inspected.

Yes, all of these vendor-specific fields would have to be UAPI. VFIO
doesn't necessarily have to deeply inspect each field, it can just check
that the structure contains the right fields (is the right size) and let
the IOMMU driver, that knows how to read these values, validate that they
make sense.

I think VFIO should be able to trust the IOMMU driver to perform the
sanity checks.

>> Another reason is if some IOMMU is able to support multiple PASID
>> table formats, it could advertise them all in sysfs and Qemu could
>> tell which one it chose in 'model'. I'm not sure we'll ever see that
>> in practice.
>>
> I would expect when query interface between QEMU and sysfs would ensure
> matching format prior to issue bind_pasid_table call.
>>
>>
>> For binding page tables instead of PASID tables (e.g. virtio-iommu),
>> the generic data would be:
>>
>> struct pgtable_info {
>> 	__u32	pasid;
>> 	__u64	ptr;
>> 	__u32	model;
>> 	__u8	model_data[];
>> };
>>
>> Followed by a few arch-specific configuration values. For Arm we can
>> summarize this to three registers, defined in the Armv8 Architecture
>> Reference Manual:
>>
>> struct arm_lpae_pgtable_info {
>> 	__u64	tcr;	/* Translation Control Register */
>> 	__u64	mair;	/* Memory Attributes Indirection
>> Register */ __u64	asid;	/* Address Space ID */
>> };
>>
>> Some data packed in the TCR might be common to most architectures,
>> like page granularity and max VA size. Most fields of the TCR won't
>> be used but it provides a nice architected way to communicate Arm
>> page table configuration.
>>
>> Note that there might be an additional page directory in the
>> arch-specific info, as we can split the address space in two. I'm not
>> sure whether we should allow it yet.
>>
> This can be combined with bind mm with user tasks also (e.g. DPDK with
> SVM in native case), right? In that case the pasid would be allocated by
> the kernel instead of passdown in pgtable_info, and your 'ptr' filed is
> harvested from the current task mm? There is also complexity w.r.t.
> user task life cycle management. My immediate goal to enable vSVM does
> not require bind page tables, try not to think too far ahead.

Yes, I'm working on the native case at the moment. The PASID is allocated
by the kernel and returned in 'pasid', and user can specify an additional
'pid' field to bind another process. There would be a 'flag' field telling
if 'pid' is valid or if we should just bind the current process.

Thanks,
Jean
