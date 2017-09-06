From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFC PATCH 4/6] iommu/arm-smmu-v3: Add SVM support for platform
 devices
Date: Wed, 6 Sep 2017 09:20:32 +0800
Message-ID: <b0c8ca8f-8d12-5438-91e1-6c984d9debb9@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-5-git-send-email-xieyisheng1@huawei.com>
 <039adc54-00f5-bf4e-e509-ffdc67baa15e@arm.com>
 <3f4e17fa-dcd0-5692-099a-73105e0e0095@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f4e17fa-dcd0-5692-099a-73105e0e0095@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bob Liu <liubo95@huawei.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 2017/9/6 8:51, Bob Liu wrote:
> On 2017/9/5 20:53, Jean-Philippe Brucker wrote:
>> On 31/08/17 09:20, Yisheng Xie wrote:
>>> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>
>>> Platform device can realise SVM function by using the stall mode. That
>>> is to say, when device access a memory via iova which is not populated,
>>> it will stalled and when SMMU try to translate this iova, it also will
>>> stall and meanwhile send an event to CPU via MSI.
>>>
>>> After SMMU driver handle the event and populated the iova, it will send
>>> a RESUME command to SMMU to exit the stall mode, therefore the platform
>>> device can contiue access the memory.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>
>> No. Please don't forge a signed-off-by under a commit message you wrote,

Sorry about that, it is my mistake.

> 
> Really sorry for that.
> We sent out the wrong version, I should take more careful review.
> 
> Regards,
> Liubo
> 
>> it's rude. I didn't sign it, didn't consider it fit for mainline or even
>> as an RFC, and wanted to have another read before sending. My mistake,
>> I'll think twice before sharing prototypes in the future.
>>
>> Thanks,
>> Jean
>>
> 
> 
> 
> 
> .
> 
