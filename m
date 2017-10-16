From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: CONFIG_DMA_NOOP_OPS breaks ARM arch
Date: Mon, 16 Oct 2017 12:14:46 +0100
Message-ID: <3562ac98-544b-ea83-423f-0a91ff471bc4@arm.com>
References: <CAM3PiRyBpa7vipUfzEYqvYzeLu=tkUWCo+_G79BXrgG0zG3asg@mail.gmail.com>
	<960157c0-13ee-9953-d654-9891465c987d@infradead.org>
	<ffa1481b-de82-f163-6cc9-fbb24615572f@infradead.org>
	<04535c78-d418-b2b2-89db-ab4732a05984@infradead.org>
	<CAM3PiRxEC7uqqxL_Z__a7T06-Cqyq0Go5n1Sn2TDmWkVjypbww@mail.gmail.com>
	<001f1d21-e85c-21c6-726b-9a69b43d4ca6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <001f1d21-e85c-21c6-726b-9a69b43d4ca6-5wv7dgnIgG8@public.gmane.org>
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
To: Marian Mihailescu <marian.mihailescu-sKtvjTG20lXX/JP9YwkgDA@public.gmane.org>
Cc: Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bart Van Assche <bart.vanassche-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/10/17 09:12, Vladimir Murzin wrote:
> + Robin and Christoph
> 
> On 16/10/17 06:27, Marian Mihailescu wrote:
>> I am using 4.14-rc4 with a patch on top that includes
>> arch/arm/include/asm/dma-mapping.h in a module.
>>
>> I have MMU enabled, so
>> select DMA_NOOP_OPS if !MMU
>> does nothing for me, and I get a compile error because dma_noop_ops is unknown.
> 
> Can you post an error message here, please?
> 
>>
>> Maybe I should include linux/dma-mapping.h?

That is the *only* dma-mapping header you should be referring to.
Including the arch/*/asm/ version directly is just broken and asking for
trouble.

Robin.

> Where to include? In your driver or what?
> 
>>
>> Thanks for the quick reply.
> 
> with CONFIG_MMU compiler should optimise out dma_noop_ops in:
> 
> return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
> 
> What toolchain are you using?
> 
> Cheers
> Vladimir
> 
>>
>>
>> On Mon, Oct 16, 2017 at 2:28 PM, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>>> On 10/15/17 20:29, Randy Dunlap wrote:
>>>> On 10/15/17 20:27, Randy Dunlap wrote:
>>>>> On 10/15/17 19:27, Marian Mihailescu wrote:
>>>>>> After commit 7844572c633964c864d9f32dc3f2a8ffe5d70371, dma_noop_ops
>>>>>> are built only for architectures that use it.
>>>>>>
>>>>>> For ARM architecture, CONFIG_DMA_NOOP_OPS is not selected, and cannot
>>>>>> be selected.
>>>
>>> What kernel version are you looking at?
>>> I see that it is selected:
>>>
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -22,6 +22,7 @@ config ARM
>>>         select CLONE_BACKWARDS
>>>         select CPU_PM if (SUSPEND || CPU_IDLE)
>>>         select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
>>> +       select DMA_NOOP_OPS if !MMU
>>>         select EDAC_SUPPORT
>>>         select EDAC_ATOMIC_SCRUB
>>>         select GENERIC_ALLOCATOR
>>>
>>>
>>> That's in commit ID 1c51c429f30ea10428337f3a33c12059ba59f668 from May 24, 2017.
>>>
>>>>>> However, arch/arm/include/asm/dma-mapping.h is referencing dma_noop_ops:
>>>>>>
>>>>>> static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>>>>>> {
>>>>>> return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
>>>>>> }
>>>>>>
>>>>>> I will let a maintainer suggest the best resolution for this :)
>>>>>>
>>>>>
>>>>> add Bart and iommu mailing list.
>>>>>
>>>>
>>>> and add Vladimir.
>>>>
>>>>
>>>
>>>
>>> --
>>> ~Randy
> 
