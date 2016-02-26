From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 0/8] iommu/amd: enable ACPI hardware ID device support
Date: Fri, 26 Feb 2016 15:44:47 +0100
Message-ID: <20160226144446.GG22747@8bytes.org>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453850077-2539-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 26, 2016 at 06:14:29PM -0500, Wan Zongshun wrote:
> Suravee Suthikulpanit (3):
>   iommu/amd: Modify ivhd_header structure to support type 11h and 40h
>   iommu/amd: Use the most comprehensive IVHD type that the driver can
>     support
>   iommu/amd: Introduces ivrs_acpihid kernel parameter
> 
> Wan Zongshun (5):
>   iommu/amd: Add new map for storing IVHD dev entry type HID
>   iommu/amd: Make call-sites of get_device_id aware of its return value
>   iommu/amd: Add iommu support for ACPI HID devices
>   iommu/amd: Manage iommu_group for ACPI HID devices
>   iommu/amd: Set AMD iommu callbacks for amba bus

These patches fail to boot on my Carrizo system. Unfortunatly it fails
before console is initialized and the box has no serial port to grab the
early panic.



	Joerg
