From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
Date: Tue, 14 Feb 2017 12:10:27 +0000
Message-ID: <56c15010-c009-81e5-95d3-a6f50469223e@arm.com>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
	<20170213160652.7c141eb1@t450s.home>
	<2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
	<20170213184643.2d2bdce7@t450s.home>
	<546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <546869d0-d05c-9550-86d5-276bc7a3c284-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, nd-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/02/17 01:54, Sinan Kaya wrote:
> On 2/13/2017 8:46 PM, Alex Williamson wrote:
>>> My first goal is to support virtual function passthrough for device's that are directly
>>> connected. This will be possible with the quirk I proposed and it will be the most
>>> secure solution. It can certainly be generalized for other systems.
>> Why is this anything more than a quirk for the affected PCIe root port
>> vendor:device IDs and use of pci_device_group() to evaluate the rest of
>> the topology, as appears is already done?  Clearly a blanket exception
>> for the platform wouldn't necessarily be correct if a user could plugin
>> a device that adds a PCIe switch.
> 
> I was going to go this direction first. I wanted to check with everybody to see
> if there are other/better alternatives possible via either changing 
> pci_device_group or changing the smmuv3 driver.

I second Alex's opinion here. The SMMU driver is absolutely not the
appropriate place to address this - it's a PCI issue that needs to be
solved in the PCI domain. To flip things around, regardless of VFIO,
overriding group allocation may just plain break some devices - if you
plug in, say, some USB 2.0 card with an OHCI/EHCI pair on two different
functions, assigning them to different groups such that they get
different domains and can't hand off valid DMA addresses to each other
is liable to go downhill very quickly.

Robin.

>>> My second goal is extend the code such that ACS validation is up to the customer via 
>>> pci=noacs kernel command line for instance. This will let the customer choose what he
>>> really wants rather than kernel trying to be smart and protective. By passing pci=noacs
>>> parameter, customer acknowledges the risks this command line carries.
>> Be prepared that this will need to taint the kernel since we make
>> assertions with drivers like vfio to provide secure, isolated user
>> access to devices and we can't make that statement if the user has
>> bypassed ACS enforcement.  There is absolutely no way that such an
>> option would not be severely abused.  In fact, I tried adding such an
>> option with the pcie_acs_override= patch[1], Bjorn rejected it and I'm
>> thankful that he did.  I don't think this is a good idea, sometimes the
>> kernel does need to be smarter than the user to protect them from
>> themselves.  Any easy bypass also lets hardware vendors ignore the
>> issue longer.  Thanks,
> 
> Bjorn, any inputs?
> 
>>
>> Alex
>>
>> [1] https://lkml.org/lkml/2013/5/30/513
>>
> 
> 

(apologies if a disclaimer appears below; SMTP problems...)
