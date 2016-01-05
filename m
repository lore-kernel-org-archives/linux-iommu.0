From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/6] iommu/amd: enable ACPI hardware ID device support
Date: Tue, 5 Jan 2016 09:40:27 -0600
Message-ID: <568BE3EB.3010205@amd.com>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1451988444-4694-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

Also, the latest public version of AMD IOMMU specification that 
describes the support for IVHD type 40h and ACPI HID IVHD device type, 
implemented by this patch series, is available here

http://support.amd.com/TechDocs/48882_IOMMU.pdf

Thanks,
Suravee


On 01/05/2016 04:07 AM, Wan Zongshun wrote:
> From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
>
> This patch series enable ACPI hardware ID device support,
>
> There are some devices indentified using ACPI HID format in AMD chip.
> This patch series enable iommu support for those ACPI HID device,
> since the existing AMD iommu only supports PCI bus based device.
>
> Suravee Suthikulpanit (3):
>    iommu/amd: Modify ivhd_header structure to support type 11h and 40h
>    iommu/amd: Use the most comprehensive IVHD type that the driver can
>      support
>    iommu/amd: Introduces ivrs_acpihid kernel parameter
>
> Wan Zongshun (3):
>    iommu/amd: Add new map for storing IVHD dev entry type HID
>    iommu/amd: Add support for non-pci devices
>    iommu/amd: Manage iommu_group for non-pci devices
>
>   Documentation/kernel-parameters.txt |   7 +
>   drivers/iommu/amd_iommu.c           | 158 +++++++++++++++---
>   drivers/iommu/amd_iommu_init.c      | 309 +++++++++++++++++++++++++++++++-----
>   drivers/iommu/amd_iommu_types.h     |  14 ++
>   4 files changed, 433 insertions(+), 55 deletions(-)
>
