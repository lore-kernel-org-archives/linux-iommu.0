From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Fri, 10 Aug 2018 15:30:12 -0700
Message-ID: <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org> <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Andy Gross <andy.gross@linaro.org>, Mark Rutland <mark.rutland@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>, sricharan@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Fri, Aug 10, 2018 at 3:18 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Add device node for arm,mmu-500 available on sdm845.
>> This MMU-500 with single TCU and multiple TBU architecture
>> is shared among all the peripherals except gpu on sdm845.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index 6d651f314193..13b50dff440f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -58,3 +58,7 @@
>>                 bias-pull-up;
>>         };
>>  };
>> +
>> +&apps_smmu {
>> +       status = "okay";
>> +};
>
> When you spin this patch please put the above in the correct place.
> Since "a" sorts alphabetically before "i" then this should be just
> before the line:
>
> &i2c10 {

Sorry--one more thing I thought of after I sent this out...

Possibly you can drop this part of the patch completely and get rid of
the 'status = "disabled";' in sdm845.dtsi.  As I understand it you
really only want to mark things as disabled in the SoC dtsi file if
some boards might use this device and other boards wouldn't.  For
instance not all boards will have the SD card controller hooked up /
enabled so having that set to "disabled" in the SoC device tree file
makes sense.  ...but it's not a board-level question about whether the
SMMU is present--it's always there.  You don't gain anything by
forcing all boards to set status to "okay".


-Doug
