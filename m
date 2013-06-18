From: Don Dutile <ddutile@redhat.com>
Subject: Re: DMA mapping API(IOMMU) for ARM64?
Date: Tue, 18 Jun 2013 18:08:15 -0400
Message-ID: <51C0DA4F.1010405@redhat.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
 <20130618101914.GB3539@mudshark.cambridge.arm.com>
 <5159282.rrJMaZuYMv@wuerfel>
 <20130618.140137.1551430695673122122.hdoyu@nvidia.com>
 <20130618125054.GL9930@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130618125054.GL9930@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On 06/18/2013 08:50 AM, Catalin Marinas wrote:
> On Tue, Jun 18, 2013 at 12:01:37PM +0100, Hiroshi Doyu wrote:
>> Arnd Bergmann<arnd@arndb.de>  wrote @ Tue, 18 Jun 2013 12:32:44 +0200:
>>> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
>>>> I've spoken briefly with Catalin about this and it seems like there might be
>>>> *some* scope for sharing common dma-mapping code between architectures.
>>>> There doesn't really need to be any architecture-specific details in
>>>> allocating iova space and the interface to the iommu drivers is
>>>> well-defined. The arch-specific stuff is bogged down in the non-coherent
>>>> buffer management, but that doesn't necessarily equate to lots of code.
>>>>
>>>> So, the best bet would be to figure out how to split up what we have under
>>>> arch/arm/ so that it can be re-used by arm64 and potentially other
>>>> architectures (powerpc has some simple stuff for coherent mappings and some
>>>> less-simple stuff for non-coherent buffers).
>>>
>>> I'm sure that other architectures are interested in sharing the code.
>>> Best move it into the global mm/ directory, at least the version for
>>> coherent mappings.
>>
>> I'm guessing that this kind of unification usually takes some time
>> since we need to factor out the common code from the different
>> ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
>> it. So if we want to develop our 64-bit ARM with working DMA mapping
>> API during this transition, the step to take would be:
>>
>> 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c(+swiotlb)
>> 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
>> 3, Factor out the common code from them into mm/dma-mapping.c
>
> Or add the relevant code to something like lib/iommu-helper.c, convert
> arm64 to use that and we can work on converting arm and other
> architectures afterwards.
>
why not in current drivers/iommu directory ?
