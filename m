From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Tue, 8 Jan 2019 16:48:32 +0530
Message-ID: <9675f7d8-a726-07d3-34b7-99b7464a6303@codeaurora.org>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
	<20181011094930.17010-3-vivek.gautam@codeaurora.org>
	<20190108065935.GA11536@builder>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8135247141636077456=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190108065935.GA11536@builder>
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
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--===============8135247141636077456==
Content-Type: multipart/alternative;
 boundary="------------BCA6915A47B6E10C25D993FB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BCA6915A47B6E10C25D993FB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/8/2019 12:29 PM, Bjorn Andersson wrote:
> On Thu 11 Oct 02:49 PDT 2018, Vivek Gautam wrote:
>
>> Add device node for arm,mmu-500 available on sdm845.
>> This MMU-500 with single TCU and multiple TBU architecture
>> is shared among all the peripherals except gpu.
>>
> Hi Vivek,
>
> Applying this patch together with UFS ([1] and [2]) ontop of v5.0-rc1
> causes my MTP reboot once the UFSHCD module is inserted and probed.
> Independently the patches seems to work fine.
>
> Do you have any suggestion to why this would be?


Hi Bjorn,

Enabling SMMU on sdm845 when you have UFS also enabled, would need 
addition of
'iommus' property to ufs dt node.
You will need to add the following with ufs:

iommus = <&apps_smmu 0x100 0xf>;

Thanks
Vivek

>
> [1] https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/
> [2] https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/
>
> Regards,
> Bjorn
>
>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>
>> Changes since v3:
>>   - none.
>>
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..0aace729643d 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1297,6 +1297,78 @@
>>   			cell-index = <0>;
>>   		};
>>   
>> +		apps_smmu: iommu@15000000 {
>> +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>> +			reg = <0x15000000 0x80000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <1>;
>> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>>   		apss_shared: mailbox@17990000 {
>>   			compatible = "qcom,sdm845-apss-shared";
>>   			reg = <0x17990000 0x1000>;
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

--------------BCA6915A47B6E10C25D993FB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/8/2019 12:29 PM, Bjorn Andersson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20190108065935.GA11536@builder">
      <pre class="moz-quote-pre" wrap="">On Thu 11 Oct 02:49 PDT 2018, Vivek Gautam wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add device node for arm,mmu-500 available on sdm845.
This MMU-500 with single TCU and multiple TBU architecture
is shared among all the peripherals except gpu.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hi Vivek,

Applying this patch together with UFS ([1] and [2]) ontop of v5.0-rc1
causes my MTP reboot once the UFSHCD module is inserted and probed.
Independently the patches seems to work fine.

Do you have any suggestion to why this would be?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Hi Bjorn,<br>
      <br>
      Enabling SMMU on sdm845 when you have UFS also enabled, would need
      addition of<br>
      'iommus' property to ufs dt node.<br>
      You will need to add the following with ufs:<br>
      <font color="#330033"><br>
      </font><span style="color: rgb(118, 118, 118); font-family: -apple-system, system-ui, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><font color="#330033">  iommus = &lt;&amp;apps_smmu 0x100 0xf&gt;;
</font></span></p>
    <p>Thanks<br>
      Vivek<br>
    </p>
    <blockquote type="cite" cite="mid:20190108065935.GA11536@builder">
      <pre class="moz-quote-pre" wrap="">

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/">https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/</a>
[2] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/">https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org/</a>

Regards,
Bjorn

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Vivek Gautam <a class="moz-txt-link-rfc2396E" href="mailto:vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org">&lt;vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org&gt;</a>
---

Changes since v3:
 - none.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..0aace729643d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1297,6 +1297,78 @@
 			cell-index = &lt;0&gt;;
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
+			reg = &lt;0x15000000 0x80000&gt;;
+			#iommu-cells = &lt;2&gt;;
+			#global-interrupts = &lt;1&gt;;
+			interrupts = &lt;GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH&gt;,
+				     &lt;GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH&gt;;
+		};
+
 		apss_shared: mailbox@17990000 {
 			compatible = "qcom,sdm845-apss-shared";
 			reg = &lt;0x17990000 0x1000&gt;;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------BCA6915A47B6E10C25D993FB--

--===============8135247141636077456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8135247141636077456==--
