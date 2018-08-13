From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Mon, 13 Aug 2018 10:59:47 +0530
Message-ID: <249d07c0-a2fb-b25e-84aa-ee820bace847@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
	<20180719175356.14753-2-vivek.gautam@codeaurora.org>
	<CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
	<CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:ARM/QUALCOMM SUPPORT" <linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Doug,


On 8/11/2018 4:00 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Aug 10, 2018 at 3:18 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> Hi,
>>
>> On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>> Add device node for arm,mmu-500 available on sdm845.
>>> This MMU-500 with single TCU and multiple TBU architecture
>>> is shared among all the peripherals except gpu on sdm845.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>>   arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>>   2 files changed, 77 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> index 6d651f314193..13b50dff440f 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> @@ -58,3 +58,7 @@
>>>                  bias-pull-up;
>>>          };
>>>   };
>>> +
>>> +&apps_smmu {
>>> +       status = "okay";
>>> +};
>> When you spin this patch please put the above in the correct place.
>> Since "a" sorts alphabetically before "i" then this should be just
>> before the line:
>>
>> &i2c10 {
> Sorry--one more thing I thought of after I sent this out...
>
> Possibly you can drop this part of the patch completely and get rid of
> the 'status = "disabled";' in sdm845.dtsi.  As I understand it you
> really only want to mark things as disabled in the SoC dtsi file if
> some boards might use this device and other boards wouldn't.  For
> instance not all boards will have the SD card controller hooked up /
> enabled so having that set to "disabled" in the SoC device tree file
> makes sense.  ...but it's not a board-level question about whether the
> SMMU is present--it's always there.  You don't gain anything by
> forcing all boards to set status to "okay".

Thanks for reviewing the patches.
Will sort the node as per alphabetical order.
Also as you pointed, it makes sense to not have the 'status' property
in SMMU. Will remove that. Thanks.

Best regards
Vivek
>
>
> -Doug
