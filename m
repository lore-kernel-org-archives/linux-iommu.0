From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
Date: Tue, 14 Feb 2017 08:53:59 -0500
Message-ID: <c7516332-259a-a807-91b1-7bcaebec1b43@codeaurora.org>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
	<20170213160652.7c141eb1@t450s.home>
	<2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
	<20170213184643.2d2bdce7@t450s.home>
	<546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
	<20170214123605.GA25144@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170214123605.GA25144-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2/14/2017 7:36 AM, Will Deacon wrote:
> On Mon, Feb 13, 2017 at 08:54:04PM -0500, Sinan Kaya wrote:
>> On 2/13/2017 8:46 PM, Alex Williamson wrote:
>>>> My first goal is to support virtual function passthrough for device's that are directly
>>>> connected. This will be possible with the quirk I proposed and it will be the most
>>>> secure solution. It can certainly be generalized for other systems.
>>> Why is this anything more than a quirk for the affected PCIe root port
>>> vendor:device IDs and use of pci_device_group() to evaluate the rest of
>>> the topology, as appears is already done?  Clearly a blanket exception
>>> for the platform wouldn't necessarily be correct if a user could plugin
>>> a device that adds a PCIe switch.
>>
>> I was going to go this direction first. I wanted to check with everybody to see
>> if there are other/better alternatives possible via either changing 
>> pci_device_group or changing the smmuv3 driver.
> 
> Just to echo what Alex has been saying, I really don't think we should
> support this type of system by quirking the topology code in the SMMU
> driver. The SMMU isn't at fault here; the problems are all upstream of that.
> Legitimising non-ACS machines in the SMMU driver gives little incentive for
> people to build systems correctly and undermines the security guarantees
> that the SMMU (and VFIO) are trying to provide.
> 
> I appreciate that I/O virtualisation on arm64 has been a learning curve for
> everybody involved, but that's not an excuse for moving the goalposts when
> it comes to device isolation.
> 
> Will
> 

Thanks to everyone for feedback. I'll follow the quirk path as requested. 
I'll be posting the patch soon.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
