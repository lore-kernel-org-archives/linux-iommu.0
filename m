From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: bind pasid table API
Date: Mon, 25 Sep 2017 12:45:38 +0100
Message-ID: <ec2e5fe4-fb98-01e9-a1a4-7e8cbd94c36b@arm.com>
References: <20170918204516.2f6beffb@jacob-builder>
	<6ecc1afc-6302-cd22-6944-ef4c6ac09587@arm.com>
	<A2975661238FB949B60364EF0F2C257439ADB33D@SHSMSX152.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439ADB33D-zVW8+lm/ZpmiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 21/09/17 04:00, Liu, Yi L wrote:
> Hi Jean,
> 
>> -----Original Message-----
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
>> Sent: Wednesday, September 20, 2017 8:10 PM
>> To: Pan, Jacob jun <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
>> foundation.org
>> Cc: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Raj, Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; David
>> Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Tian,
>> Kevin <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Subject: Re: bind pasid table API
>>
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
>>> pvIOMMU would need additional info to indicate the page table format.
>>> Could you share your idea of the right addition for ARM such that we
>>> can have a unified API?
>>>
>>> /**
>>>  * PASID table data used to bind guest PASID table to the host IOMMU.
>>> This will
>>>  * enable guest managed first level page tables.
>>>  * @ptr:	PASID table pointer
>>>  * @size_order:	number of bits supported in the guest PASID table, must
>> be less
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
>> * 'default_substream' telling if PASID0 is reserved for non-pasid traffic.
>>
>> I think that's it for the moment, but it does require to leave space for a vendor-
>> specific structure at the end. It is one reason why I'd prefer having a 'model' field
>> in the pasid_table_info structure telling what fields the whole structure actually
>> contains.
>>
>> Another reason is if some IOMMU is able to support multiple PASID table
>> formats, it could advertise them all in sysfs and Qemu could tell which one it
>> chose in 'model'. I'm not sure we'll ever see that in practice.
> 
> Regards to your idea, I think the whole flow may be:
> * Qemu queries underlying IOMMU for the capability(through sysfs)
> * Combined with requirement from user(the guy who starts the VM), Qemu chose a
>    suitable model or exit if HW capability is incompatible with user's requirement
> * In the coming bind_pasid_table() calling, Qemu pass the chosen model info to host
> * Host checks the "model" and use the correct model specific structure to parse
>    the model specific data. may be kind of structure intel_pasid_table_info,
>    amd_pasid_table_info or arm_pasid_table_info_v#
> 
> Does this flow show what you want? This would be a "model" + "model specific data"
> proposal. And my concern is the model specific field may look like to be kind of "opaque".

It doesn't have to be opaque, it has to be defined in UAPI and an
intermediate layer (VFIO) can verify that they are present. The layer can
also inspect their value more deeply if it wants, since it is clear what
they are supposed to contain. But (in VFIO's case) it doesn't have too,
since the IOMMU driver will validate the values anyway.

> Besides the comments above, is there also possibility for us to put all the possible info
> in a super-set just as what we plan to do for the tlb_invalidate() API?

It's possible, but might require too much effort and might become more
difficult to do once the number of IOMMU drivers supporting PASID
increases. (See my other reply to Jacob)

>> For binding page tables instead of PASID tables (e.g. virtio-iommu), the generic
>> data would be:
>>
>> struct pgtable_info {
>> 	__u32	pasid;
>> 	__u64	ptr;
>> 	__u32	model;
>> 	__u8	model_data[];

This should be an union actually, since it's internal to the kernel. It's
VFIO that uses this interface.

>> };
> 
> Besides bind_pasid_table API, you would also want to propose an extra API
> which likely to be named as bind_pgtable() for this page table binding?

Yes, but we could use the same bind() function taking an enum {process,
pgtable, pasid_table} and the parameter structure.

> What would be the "model" field indicate? "vendor" or "vendor+version" ? You
> may want a length field to indicate the size of "model_data" field.

I think it should be vendor+version.

> And same with the bind_pasid_table API, would model_data look like an "opaque"?
> 
>> Followed by a few arch-specific configuration values. For Arm we can summarize
>> this to three registers, defined in the Armv8 Architecture Reference Manual:
>>
>> struct arm_lpae_pgtable_info {
>> 	__u64	tcr;	/* Translation Control Register */
>> 	__u64	mair;	/* Memory Attributes Indirection Register */
>> 	__u64	asid;	/* Address Space ID */
>> };
> 
> Hmmm, just for curious. What is the difference between "pasid" and "asid"?

ASID is an ID used to tag TLB (but not ATC) entries in Arm systems. It's
very similar to the "PCID" recently introduced in Linux for x86. In an
ideal system we could use the same value for ASID and PASID, but I think
it's safer to dissociate them for the moment.

Thanks,
Jean
