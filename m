From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
Date: Mon, 13 Feb 2017 19:14:31 -0500
Message-ID: <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
	<20170213160652.7c141eb1@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170213160652.7c141eb1-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

Thanks for your response. Other comments inline.

On 2/13/2017 6:06 PM, Alex Williamson wrote:
> On Mon, 13 Feb 2017 17:24:40 -0500
> Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
>> Hi,
>> I am getting ready to submit a quirk patch. Before I go ahead and submit
>> it for review, I wanted to get ARM IOMMU developers and PCI/VFIO maintainers
>> together to figure out what the best approach would be.
>>
>> The Qualcomm QDF2400 server does not support the ACS functionality. 
>> The server chip implements the ARM SMMUv3 specification with Stream Id = BDF. 
>>
>> SMMUv3 allows each PCIe function to have unique SMMU mappings and provides
>> some level of isolation. 
> 
> "some level"?  Regardless, this is irrelevant.  ACS is how PCIe
> describes the specific forwarding behavior of transactions within the
> PCIe hierarchy.  The granularity of the SMMU translation is different
> from ACS.

Fair enough. SMMU just protects addresses that are not mapped. SMMU won't protect
any transactions happening inside the PCIe hierarchy. The likelihood of common
IO addresses varies from application to application.

> 
>> With the current upstream SMMUv3 driver, we are unable to do a passthrough
>> for a virtual function. This is caused by the pci_device_group() function's
>> failure to find the smallest isolation group in pci_acs_path_enabled()
>> function. 
>>
>> Since no group is found, all the PCI functions are placed into the same
>> group at the end of the function. 
>>
>> There are numerous quirk patches when it comes to ACS.
>>
>> pci_quirk_amd_sb_acs()
>> pci_quirk_cavium_acs()
>> pci_quirk_intel_pch_acs_match()
>>
>> These quirk patches allow a group to be generated per PCI function. Everything
>> works fine.
>>
>> I can go ahead and add 
>>
>> pci_quirk_qualcomm_acs() with the same contents as pci_quirk_cavium_acs()
> 

> Creating a quirk is not simply a matter of making the code do what you
> want, an ACS quirk is you, on behalf of Qualcomm, vouching for the
> hardware behaving in a certain way.  

Sure, let me clarify what the hardware does below.

> Specifically you're saying that
> the device does Source Validation (ie. a downstream device cannot spoof
> translations for devices on a different bus), 

Correct. Hardware supports source validation but it will report the issue
as Completer Abort instead of ACS Violation. Also, each root port is a different
segment on this particular design. 

> the device does not do
> Request Redirection (ie. peer-to-peer shortcuts that may bypass the
> IOMMU), the device does not do Completion Redirection (same, but for
> completions), 

Hardware doesn't support peer-to-peer and no segment sharing across root ports
unlike Intel architecture where most of the devices are sitting on segment 0
with multiple bridges/switch.

> and the device does Upstream Forwarding (ie. no
> shortcuts).  If the hardware does not honor these behaviors then adding
> a quirk is only putting customers at risk.

No p2p again. The assumption was that p2p would be possible with a PCIe switch
connected to a root port but we missed the fact that there are security implications
required by the ACS implementation. Note that this is ACS requirement is a Linux
statement not PCIe spec.

> 
>> Tomorrow, some other ARM64 vendors like up and start adding pci_quirk_vendor_acs()
>> functions. IMO, it leads to unnecessary code duplication. 
> 
> Which is exactly why they should be implementing ACS in their hardware!
> 

Note that I'm not disagreeing with you or telling that ACS is unnecessary and SMMU
has a bigger hammer etc. I now understand the value of ACS and what it takes to build
a secure peer-to-peer system. I also want to put a big fat warning about the fact that
we are sharing the group to the next SOC designer's attention.

My only concern is the fact that the QDF2400 and QDF2432 missed this requirement and we have
SoC out in the field. I wish this requirement was explicit somewhere like PCI/ACPI
documentation.

I'll make sure that the next chip gets this feature. This is an iterative process with
lessons learnt on the way.

>> I can go ahead and try to make the patches similar with generic names like pci_quirk_no_acs()
>> so that every vendor can use to it. Still, it would require some quirk patch from a vendor.
>>
>> Nate has been changing the arm_smmu_device_group() function internally to always
>> use generic_device_group(). This provides support for the Virtual Function passthrough
>> but it is not future proof. Tomorrow, some HW with ACS capability can show up and
>> the ARM SMMUv3 driver wouldn't bother to see if there is actual HW isolation path
>> available.
>>
>> What I really would like to do is to find a balance between what Nate has been doing
>> internally and what pci_device_group() does by changing the SMMUv3 driver to query if
>> ACS path is supported or not similar to the loop in pci_device_group. If not supported,
>> fallback to generic_device_group() function in arm_smmu_device_group().
> 

My first goal is to support virtual function passthrough for device's that are directly
connected. This will be possible with the quirk I proposed and it will be the most
secure solution. It can certainly be generalized for other systems.

My second goal is extend the code such that ACS validation is up to the customer via 
pci=noacs kernel command line for instance. This will let the customer choose what he
really wants rather than kernel trying to be smart and protective. By passing pci=noacs
parameter, customer acknowledges the risks this command line carries.

> Intel VT-d and AMD-Vi already manage to do this, what is it about an
> SMMU topology that makes it significantly different.  Note that like
> SMMU, both of these have BDF level granularity for identifying devices,
> but defer to the ACS based isolation for grouping based on downstream
> components.  The best IOMMU available cannot overcome transactions that
> it never sees because they're rerouted before reaching the IOMMU.

Sorry for the wrong pointers. I was not debating what ARM SMMUv3 does vs. what other
architectures does in HW. 

> 
>> I'm just looking for a more permanent solution rather than relying on quirks for chips
>> A, B, C and D.
> 
> Implement ACS in all downstream ports and multifunction endpoints!
> Thanks,

Understood. This should have been explicit somewhere like PCIE Appendix of the SBSA
or some Documentation in Linux.

I'll make sure that I put that big fat warning there.

> 
> Alex
> 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
