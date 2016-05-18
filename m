From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V4 2/7] documentation: iommu: Add bindings for msm,iommu-v0 ip
Date: Wed, 18 May 2016 17:38:25 +0530
Message-ID: <002e01d1b0fe$00488730$00d99590$@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org> <1463381341-30498-3-git-send-email-sricharan@codeaurora.org> <20160516164414.GA25899@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160516164414.GA25899@rob-hp-laptop>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Rob Herring' <robh@kernel.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, robdclark@gmail.com, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

>> The MSM IOMMU is an implementation compatible with the ARM VMSA short
>> descriptor page tables. It provides address translation for bus masters outside
>> of the CPU, each connected to the IOMMU through a port called micro-TLB.
>> Adding the DT bindings for the same.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 64 ++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>> new file mode 100644
>> index 0000000..b22c607
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>> @@ -0,0 +1,64 @@
>> +* QCOM IOMMU
>> +
>> +The MSM IOMMU is an implementation compatible with the ARM VMSA short
>> +descriptor page tables. It provides address translation for bus masters outside
>> +of the CPU, each connected to the IOMMU through a port called micro-TLB.
>> +
>> +Required Properties:
>> +
>> +  - compatible: Must contain "qcom,iommu-v0-apq8064".
>
>qcom,apq8064-iommu would be the preferred order and I think you can drop
>the v0.

Ok, will change this.

Regards,
 Sricharan
