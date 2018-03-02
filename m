From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
Date: Fri, 2 Mar 2018 09:20:54 -0500
Message-ID: <feeab007-951d-7743-70e6-122486feddf7@codeaurora.org>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
	<20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
	<2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
	<20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302000303.GD74737-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Goel, Sameer" <sgoel-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 3/1/2018 7:03 PM, Bjorn Helgaas wrote:
>> 3. The last one is adapter gets into fuzzy state due to not coming
>> out of clean state in the second time init and being rejected by
>> SMMUv3 multiple times.
>>
>> [   16.093441] pci 0000:01:00.0: aer_status: 0x00040000, aer_mask: 0x00000000
>> [   16.099356] pci 0000:01:00.0: Malformed TLP
>> [   16.103522] pci 0000:01:00.0: aer_layer=Transaction Layer, aer_agent=Receiver ID
>> [   16.110900] pci 0000:01:00.0: aer_uncor_severity: 0x00062011
>> [   16.116543] pci 0000:01:00.0:   TLP Header: 0a00a000 00008100 01010100 00000000
> I'm not clear on this.  I don't remember what an IOMMU fault looks
> like to an Endpoint.  Are you saying that if an Endpoint sees too many
> of those faults, it gets into this "fuzzy state" (whatever that is :))?
> Is this a hardware defect?  Do we care (this is a kdump kernel, after
> all)?  If we do care, can we fix the device by resetting it?

fuzzy=funky=funny=wierd

Regardless of what we do in the IOMMU driver, I think we still have to reset
the endpoint in order to have a clean initialization.

I'm not sure if all endpoint drivers can recover an adapter from a live state.

I wasn't expecting to see a Malformed TLP error. I was guessing that this was
caused by SMMU giving a CA or UR to the endpoint or having a live adapter
in the middle of driver initialization. 

I think we do care about the adapter coming up properly otherwise how would
you collect the dumps from the system?

I was expecting to come through the network interface and download it from
the target.

That's why, I was suggesting FLR/PM reset etc. when we know that we are
booting a kdump kernel.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
