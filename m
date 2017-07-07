From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pci: Add drop mask property for MSI
 and IOMMU
Date: Fri, 7 Jul 2017 08:22:21 -0700
Message-ID: <a66fac9a-b8f7-489e-a32a-ab2100c89653@broadcom.com>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
 <1499411399-25103-2-git-send-email-srinath.mannam@broadcom.com>
 <20170707133052.GB3425@leverpostej>
 <89f871d1-fc28-aa0b-2460-cf834e7e99f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89f871d1-fc28-aa0b-2460-cf834e7e99f6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>, Srinath Mannam <srinath.mannam@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 17-07-07 07:55 AM, Robin Murphy wrote:
> On 07/07/17 14:30, Mark Rutland wrote:
>> On Fri, Jul 07, 2017 at 12:39:58PM +0530, Srinath Mannam wrote:
>>> This patch adds info about optional DT properties
>>> iommu-map-drop-mask and msi-map-drop-mask.
>>>
>>> A drop mask represents the bits which will be
>>> removed/dropped by system from Requester ID before
>>> mapping it to msi ID or stream ID.
>>>
>>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   .../devicetree/bindings/pci/pci-iommu.txt          | 31 ++++++++++++++++++++
>>>   Documentation/devicetree/bindings/pci/pci-msi.txt  | 33 ++++++++++++++++++++++
>>>   2 files changed, 64 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
>>> index 0def586..499cb27 100644
>>> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
>>> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
>>> @@ -44,6 +44,9 @@ Optional properties
>>>   - iommu-map-mask: A mask to be applied to each Requester ID prior to being
>>>     mapped to an IOMMU specifier per the iommu-map property.
>>>   
>>> +- iommu-map-drop-mask: A drop mask represents the bits which will be
>>> +  removed/dropped by system from Requester ID before mapping it to
>>> +  stream ID.
>> As mentioned in my reply to the cover letter, you're expecting this to
>> be handled as more than a mask, so this description is inadequate.
>>
>> [...]
>>
>>> +/ {
>>> +	#address-cells = <1>;
>>> +	#size-cells = <1>;
>>> +
>>> +	iommu: iommu@a {
>>> +		reg = <0xa 0x1>;
>>> +		compatible = "vendor,some-iommu";
>>> +		#iommu-cells = <1>;
>>> +	};
>>> +
>>> +	pci: pci@f {
>>> +		reg = <0xf 0x1>;
>>> +		compatible = "vendor,pcie-root-complex";
>>> +		device_type = "pci";
>>> +
>>> +		/*
>>> +		 * The sideband data provided to the IOMMU is a 10bit
>>> +		 * data derived from the RID by dropping 4 MSBs
>>> +		 * of device number and 2 MSBs of function number.
>>> +		 */
>>> +		iommu-map = <0x0 &iommu 0x0 0x1024>;
>>> +		iommu-map-drop-mask = <0xff09>;
>>> +	};
>>> +};
>> ... as this this example.
>>
>> Assuming this was truly a mask of bits to drop, you'd have:
>>
>> 	RID	->	SID
>> 	0xffff	->	0x00f6
>>
>> ... whereas from your cover letter it seems you want:
>>
>> 	RID	->	SID
>> 	0xffff	->	0x3f
>>
>> ... and I've just realsied you have non-coniguous masks, so this is even
>> worse.
>>
>>> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
>>> index 9b3cc81..1de3f39 100644
>>> --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
>>> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
>>> @@ -49,6 +49,10 @@ Optional properties
>>>   - msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
>>>     to an msi-specifier per the msi-map property.
>>>   
>>> +- msi-map-drop-mask: A drop mask represents the bits which will be
>>> +  removed/dropped by system from Requester ID before mapping it to
>>> +  msi ID.
>>> +
>>>   - msi-parent: Describes the MSI parent of the root complex itself. Where
>>>     the root complex and MSI controller do not pass sideband data with MSI
>>>     writes, this property may be used to describe the MSI controller(s)
>>> @@ -218,3 +222,32 @@ Example (5)
>>>   			  <0x0000 &msi_b 0x0000 0x10000>;
>>>   	};
>>>   };
>>> +
>>> +Example (6)
>>> +===========
>>> +
>>> +/ {
>>> +	#address-cells = <1>;
>>> +	#size-cells = <1>;
>>> +
>>> +	msi: msi-controller@a {
>>> +		reg = <0xa 0x1>;
>>> +		compatible = "vendor,some-controller";
>>> +		msi-controller;
>>> +		#msi-cells = <1>;
>>> +	};
>>> +
>>> +	pci: pci@f {
>>> +		reg = <0xf 0x1>;
>>> +		compatible = "vendor,pcie-root-complex";
>>> +		device_type = "pci";
>>> +
>>> +		/*
>>> +		 * The sideband data provided to the  MSI controller is
>>> +		 * a 10bit data derived from the RID by dropping
>>> +		 * 4 MSBs of device number and 2 MSBs of function number.
>>> +		 */
>>> +		msi-map = <0x0 &msi_a 0x0 0x100>,
>>> +		msi-map-drop-mask = <0xff09>
>>> +	};
>>> +};
>> ... likewise on all counts.
>>
>> Your mapping can be expressed today using a number of msi-map entries,
>> which you can easily generate programmatically with a trivial perl
>> script, without requiring a new binding or any new kernel code.
>>
>> Please do that instead.
> Indeed. The systems I'm aware of which need to express non-trivial RID
> to SID mappings tend to have the bootloader probe PCI and dynamically
> generate map entries per discovered RID, but even if you wanted to
> statically generate the whole lot for the worst-case bus range that's
> still only 512 entries, which is not unmanageable. Notably, it's also
> what would have to be done (in equivalent) for IORT, although I assume
> this is an embedded platform for which nobody cares about ACPI.
Actually we will care about ACPI and need to add it (doesn't need to be 
in this patchet unless easy to do so...)
>
> Robin.
