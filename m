From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
Date: Wed, 27 Feb 2019 00:54:19 +0000
Message-ID: <0bcd215e-e013-6891-ecd4-da4c91bb4eb9@arm.com>
References: <20190226181716.14556-1-robh@kernel.org>
 <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
 <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
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

On 2019-02-26 8:05 pm, Rob Herring wrote:
> On Tue, Feb 26, 2019 at 1:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Rob,
>>
>> On 26/02/2019 18:17, Rob Herring wrote:
>>> ARM Mali midgard GPUs have a few differences from standard 64-bit
>>> stage 1 page tables.
>>>
>>> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
>>>
>>> The access flags are not read-only and unprivileged, but read and write.
>>> This is similar to stage 2 entries, but the memory attributes field matches
>>> stage 1 being an index.
>>>
>>> The nG bit is also not set by the vendor driver, but that one doesn't
>>> seem to matter.
>>>
>>> Add a quirk to handle all of these differences.
>>
>>   From the look of these changes, this isn't a quirk but a distinct
>> format. AFAICS from the mali_kbase driver, this must be "LPAE mode"
>> rather than "AArch64 mode", so it seems unlikely that it really supports
>> the full VMSAv8 gamut of granules, address sizes, and page sizes that
>> this patch will happily let through.
> 
> Right, but the page size bitmap and the in and out address sizes in
> the config struct should be enough to restrict those.
> 
> What do you propose? Add another init function which hardcodes all
> those or add some checks of allowed settings?

Or rather somewhere in between, i.e. add a new io_pgtable_fmt with an 
init function which sanity checks/constrains the request appropriately 
(like the existing ones do), and which could at least help make 
arm_lpae_pte_to_prot() less of a mess.

We don't treat v7 LPAE as a quirk of v8 AArch64, even though we 
implement it as a strict subset, and neither do we treat stage 2 as a 
quirk of stage 1 (or vice versa). This Midgard "LPAE" format appears 
more different from any of the VMSA long-descriptor formats than they 
are from each other - it certainly doesn't seem like a case of someone 
aiming to implement AArch64 stage 1 but getting one or two details 
slightly wrong.

(I know I implemented Mediatek's Frankein-short-descriptor as a set of 
quirks rather than introducing multiple v7s formats, but that's largely 
because it's the only real user of that code, and most of them are 
generic enough that they could well be common to other formats in future)

Robin.
