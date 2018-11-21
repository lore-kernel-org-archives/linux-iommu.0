From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v4 0/2] Enable smmu support on sdm845
Date: Wed, 21 Nov 2018 21:36:36 +0530
Message-ID: <af01e45b-b35c-925c-e1b8-9847482adca5@codeaurora.org>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181121155249.GA24883@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121155249.GA24883@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, dianders@chromium.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,


On 11/21/2018 9:22 PM, Will Deacon wrote:
> Hi Vivek,
>
> On Thu, Oct 11, 2018 at 03:19:28PM +0530, Vivek Gautam wrote:
>> This series enables apps-smmu, the "arm,mmu-500" instance
>> on sdm845.
>> Series tested on SDM845 MTP device with related smmu patch series [1],
>> and necessary config change, besides one hack to keep LDO14 in LPM mode
>> to boot things up (see the commit in the test branch).
>> The tested branch is available at [2].
> [...]
>
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
>>   2 files changed, 76 insertions(+)
> Given that this doesn't touch any of the driver code, please take this via
> the Andy and arm-soc.

Yea, once the driver changes are pulled in your tree, I can ask Andy to 
pick these.
Thanks

Best regards
Vivek
>
> Will
