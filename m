From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: io-pgtable: Add ARM Mali midgard MMU page table
 format
Date: Tue, 5 Mar 2019 16:04:35 +0000
Message-ID: <fa52078c-5399-19be-5fb6-d6c05bd9990d@arm.com>
References: <20190227232242.26910-1-robh@kernel.org>
 <e7a36bc9-e425-064b-ca12-3c655c8e5d4a@arm.com>
 <CAL_JsqJsfM1JM_7hhUboZx+zBo_tP8LUR8xTLZOQ0OWGdh=Q7A@mail.gmail.com>
 <a35c5c6d-b9fe-35f1-5be9-323a97d4755d@arm.com>
 <CAL_Jsq+YM=YJEN2Gfq8fa146kGJDAWVhvo4W0w55ZTHatd5hsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+YM=YJEN2Gfq8fa146kGJDAWVhvo4W0w55ZTHatd5hsQ@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On 04/03/2019 18:48, Rob Herring wrote:
> On Mon, Mar 4, 2019 at 11:31 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 04/03/2019 15:32, Rob Herring wrote:
>>> On Fri, Mar 1, 2019 at 10:28 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 27/02/2019 23:22, Rob Herring wrote:
>>>>> ARM Mali midgard GPU page tables are similar to standard 64-bit stage 1
>>>>> page tables, but have a few differences. Add a new format type to
>>>>> represent the format. The input address size is 48-bits and the output
>>>>> address size is 40-bits (and possibly less?). Note that the later
>>>>> bifrost GPUs follow the standard 64-bit stage 1 format.
>>>>>
>>>>> The differences in the format compared to 64-bit stage 1 format are:
>>>>>
>>>>> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
>>>>>
>>>>> The access flags are not read-only and unprivileged, but read and write.
>>>>> This is similar to stage 2 entries, but the memory attributes field matches
>>>>> stage 1 being an index.
>>>>>
>>>>> The nG bit is not set by the vendor driver. This one didn't seem to matter,
>>>>> but we'll keep it aligned to the vendor driver.
>>>
>>> [...]
>>>
>>>>> +     cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
>>>>> +     iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
>>>>> +     if (iop)
>>>>> +             cfg->arm_lpae_s1_cfg.tcr = 0;
>>>>
>>>> The general design intent is that we return ready-to-go register values
>>>> here (much like mmu_get_as_setup() in mali_kbase, it seems), so I think
>>>> it's worth adding an arm_mali_cfg to the io_pgtable_cfg union and
>>>> transforming the VMSA output into final transtab/transcfg/memattr format
>>>> at this point, rather then callers needing to care (e.g. some of those
>>>> AS_TRANSTAB_LPAE_* bits look reminiscent of the walk attributes we set
>>>> up for a VMSA TCR).
>>>
>>> I agree with returning ready-to-go values, but I'm not so sure the
>>> bits are the same. Bits 0-1 are enable/mode bits which are pretty
>>> specific to mali. Bit 2 is 'read inner' for whatever that means.
>>> Perhaps it is read allocate cacheability, but that's a bit different
>>> than RGN bits. Bit 4 is 'share outer'. Maybe it's the same as SH0 if
>>> bit 3 is included, but I have no evidence of that. So I don't think
>>> there's really anything to transform. We just set the bits needed. So
>>> here's what I have in mind:
>>
>> Right, my Friday-afternoon wording perhaps wasn't the best - by
>> "transform" I didn't mean to imply trying to reinterpret the default
>> settings we configure for a VMSA TCR, merely applying some
>> similarly-appropriate defaults to make a Mali TRANSTAB out of the VMSA TTBR.
>>
>>> iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
>>> if (iop) {
>>>     u64 mair, ttbr;
>>>
>>>     /* Copy values as union fields overlap */
>>>     mair = cfg->arm_lpae_s1_cfg.mair[0];
>>>     ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
>>>
>>>     cfg->arm_mali_lpae_cfg.mair = mair;
>>>     cfg->arm_mali_lpae_cfg.ttbr = ttbr;
>>>     cfg->arm_mali_lpae_cfg.ttbr |= ARM_MALI_LPAE_TTBR_READ_INNER |
>>>       ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
>>> }
>>
>> ...pretty much exactly like that (although I'd still prefer to use the
>> Mali register names for clarity, and presumably you'll still explicitly
>> initialise TRANSCFG too in the real patch).
> 
> No, TRANSCFG is only on Bifrost.

Ah, fair enough - I thought that your "cfg->arm_lpae_s1_cfg.tcr = 0;" 
was deliberately echoing the "setup->transcfg = 0;" in mali_kbase to 
imply that AS_TRANSCFG_ADRMODE_LEGACY was significant, but I suppose 
maybe Midgard *is* the legacy in this case. I'll admit I've not gone 
looking for the actual register-poking to see what's consumed by which 
devices.

> While the page table format seems to
> be standard stage 1 64-bit, the registers are still different from
> anything else. So I guess we'll need yet another format definition
> when we get there.

Hmm, at that point I'd be inclined to use standard AArch64 format and 
handle the rest in the driver, similar to how we repack TCR values into 
Context Descriptors for SMMUv3. Those TRANSCFG_PTW_* fields even look 
like they're pretending to be TCR.SH1 and TCR.IRGN1 (albeit with the 
latter having a wonky encoding, and the fact that there's no TTBR1 anyway).

I appreciate that somewhat undermines my argument for having io-pgtable 
fill in complete LPAE-format registers, so if you wanted the driver to 
handle both cases itself for consistency I wouldn't really mind - as 
long as LPAE still has its own init_fn where we can fine-tune the 
relevant constraints and sanity checks I'll be happy.

> Also, we may still have to massage the register
> values outside of this code. It's not going to know the
> 'system_coherency' value the kbase driver uses (And I'm not sure how
> we want to express that upstream either).

AFAICS there are two possible aspects to coherency. One is I/O coherency 
(i.e. "can the GPU snoop CPU caches"), which is already controlled by 
the "dma-coherent" property. The other is whether the GPU cache itself 
is coherent with the other caches in the system (i.e. "can CPUs snoop 
the GPU cache; how much GPU cache maintenance is necessary") which 
should be something we can infer from the integration-specific 
compatible string, because we should always have an integration-specific 
compatible string, right? ;)

And yes, the existing io-pgtable implementations don't really account 
for I/O coherency very well in terms of TCR values at the moment - we 
simply set cacheable walk attributes all the time on the assumption that 
non-coherent interconnects will ignore them (so if you ever did want a 
coherent SMMU to make non-cacheable walks for some reason, tough luck). 
It's a known issue, and there have been some Qcom patches flying around 
attempting to make it a bit better.

Robin.
