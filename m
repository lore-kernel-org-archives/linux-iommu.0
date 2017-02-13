From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RFC on No ACS Support and SMMUv3 Support
Date: Mon, 13 Feb 2017 17:24:40 -0500
Message-ID: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Vikram Sethi <vikrams-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,
I am getting ready to submit a quirk patch. Before I go ahead and submit
it for review, I wanted to get ARM IOMMU developers and PCI/VFIO maintainers
together to figure out what the best approach would be.

The Qualcomm QDF2400 server does not support the ACS functionality. 
The server chip implements the ARM SMMUv3 specification with Stream Id = BDF. 

SMMUv3 allows each PCIe function to have unique SMMU mappings and provides
some level of isolation. 

With the current upstream SMMUv3 driver, we are unable to do a passthrough
for a virtual function. This is caused by the pci_device_group() function's
failure to find the smallest isolation group in pci_acs_path_enabled()
function. 

Since no group is found, all the PCI functions are placed into the same
group at the end of the function. 

There are numerous quirk patches when it comes to ACS.

pci_quirk_amd_sb_acs()
pci_quirk_cavium_acs()
pci_quirk_intel_pch_acs_match()

These quirk patches allow a group to be generated per PCI function. Everything
works fine.

I can go ahead and add 

pci_quirk_qualcomm_acs() with the same contents as pci_quirk_cavium_acs()

Tomorrow, some other ARM64 vendors like up and start adding pci_quirk_vendor_acs()
functions. IMO, it leads to unnecessary code duplication. 

I can go ahead and try to make the patches similar with generic names like pci_quirk_no_acs()
so that every vendor can use to it. Still, it would require some quirk patch from a vendor.

Nate has been changing the arm_smmu_device_group() function internally to always
use generic_device_group(). This provides support for the Virtual Function passthrough
but it is not future proof. Tomorrow, some HW with ACS capability can show up and
the ARM SMMUv3 driver wouldn't bother to see if there is actual HW isolation path
available.

What I really would like to do is to find a balance between what Nate has been doing
internally and what pci_device_group() does by changing the SMMUv3 driver to query if
ACS path is supported or not similar to the loop in pci_device_group. If not supported,
fallback to generic_device_group() function in arm_smmu_device_group().

I'm just looking for a more permanent solution rather than relying on quirks for chips
A, B, C and D.

Please let me know the preferred path.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
