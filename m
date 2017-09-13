From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
 STE.S1STALLD and CD.S
Date: Wed, 13 Sep 2017 18:11:13 +0800
Message-ID: <2f952821-afc3-46dd-17eb-40e8626bd6e5@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
 <738977bb-4cd7-7d86-0ea0-0c88b6af721c@arm.com>
 <20170913030643.GD12411@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170913030643.GD12411@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, xieyisheng1@huawei.com, lorenzo.pieralisi@arm.com, lv.zheng@intel.com, joro@8bytes.org, liubo95@huawei.com, rjw@rjwysocki.net, robert.moore@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, chenjiankang1@huawei.com, devel@acpica.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2017/9/13 11:06, Will Deacon wrote:
> On Tue, Sep 05, 2017 at 01:54:19PM +0100, Jean-Philippe Brucker wrote:
>> On 31/08/17 09:20, Yisheng Xie wrote:
>>> It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
>>> means we should not disable stall mode if stall/terminate mode is not
>>> configuable.
>>>
>>> Meanwhile, it is also ILLEGAL when STALL_MODEL==0b10 && CD.S==0 which
>>> means if stall mode is force we should always set CD.S.
>>>
>>> This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
>>> TERMINATE feature checking to ensue above ILLEGAL cases from happening.
>>>
>>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index dbda2eb..0745522 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -55,6 +55,7 @@
>>>  #define IDR0_STALL_MODEL_SHIFT		24
>>>  #define IDR0_STALL_MODEL_MASK		0x3
>>>  #define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
>>> +#define IDR0_STALL_MODEL_NS		(1 << IDR0_STALL_MODEL_SHIFT)
>>>  #define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
>>>  #define IDR0_TTENDIAN_SHIFT		21
>>>  #define IDR0_TTENDIAN_MASK		0x3
>>> @@ -766,6 +767,7 @@ struct arm_smmu_device {
>>>  #define ARM_SMMU_FEAT_SVM		(1 << 15)
>>>  #define ARM_SMMU_FEAT_HA		(1 << 16)
>>>  #define ARM_SMMU_FEAT_HD		(1 << 17)
>>> +#define ARM_SMMU_FEAT_TERMINATE		(1 << 18)
>>
>> I'd rather introduce something like "ARM_SMMU_FEAT_STALL_FORCE" instead.
>> Terminate model has another meaning, and is defined by a different bit in
>> IDR0.
> 
> Yes. What we need to do is:
> 
> - If STALL_MODEL is 0b00, then set S1STALLD

Yes, and within this case, we can only set the S1STALLD for masters which can
not stall in the future?

> - If STALL_MODEL is 0b01, then we're ok (in future, avoiding trying to use
>   stalls, even for masters that claim to support it)
> - If STALL_MODEL is 0b10, then force all PCI devices and any platform
>   devices that don't claim to support stalls into bypass (depending on
>   disable_bypass).
> 
> Reasonable? We could actually knock up a fix for mainline to do most of
> this already.
This sound reasonable to me. And I can be a volunteer to prepare this patch if
Jean-Philippe do not oppose :)

Thanks
Yisheng Xie

> 
> Will
> 
> .
> 
