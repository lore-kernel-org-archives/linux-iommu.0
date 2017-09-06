From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
 STE.S1STALLD and CD.S
Date: Wed, 6 Sep 2017 10:23:00 +0800
Message-ID: <de4599d6-277f-00d6-40e7-7ca43a2bf2b8@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
 <738977bb-4cd7-7d86-0ea0-0c88b6af721c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <738977bb-4cd7-7d86-0ea0-0c88b6af721c@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 2017/9/5 20:54, Jean-Philippe Brucker wrote:
> On 31/08/17 09:20, Yisheng Xie wrote:
>> It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
>> means we should not disable stall mode if stall/terminate mode is not
>> configuable.
>>
>> Meanwhile, it is also ILLEGAL when STALL_MODEL==0b10 && CD.S==0 which
>> means if stall mode is force we should always set CD.S.
>>
>> This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
>> TERMINATE feature checking to ensue above ILLEGAL cases from happening.
>>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index dbda2eb..0745522 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -55,6 +55,7 @@
>>  #define IDR0_STALL_MODEL_SHIFT		24
>>  #define IDR0_STALL_MODEL_MASK		0x3
>>  #define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
>> +#define IDR0_STALL_MODEL_NS		(1 << IDR0_STALL_MODEL_SHIFT)
>>  #define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
>>  #define IDR0_TTENDIAN_SHIFT		21
>>  #define IDR0_TTENDIAN_MASK		0x3
>> @@ -766,6 +767,7 @@ struct arm_smmu_device {
>>  #define ARM_SMMU_FEAT_SVM		(1 << 15)
>>  #define ARM_SMMU_FEAT_HA		(1 << 16)
>>  #define ARM_SMMU_FEAT_HD		(1 << 17)
>> +#define ARM_SMMU_FEAT_TERMINATE		(1 << 18)
> 
> I'd rather introduce something like "ARM_SMMU_FEAT_STALL_FORCE" instead.
> Terminate model has another meaning, and is defined by a different bit in
> IDR0.

Ok, sound more reasonable.

Thanks
Yisheng Xie

> 
> Thanks,
> Jean
> 
> .
> 

