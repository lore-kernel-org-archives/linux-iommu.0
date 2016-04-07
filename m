From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 0/9] iommu/amd: enable ACPI hardware ID device support
Date: Thu, 7 Apr 2016 13:30:51 +0200
Message-ID: <20160407113050.GL17838@8bytes.org>
References: <1459515965-2865-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459515965-2865-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 01, 2016 at 09:05:56AM -0400, Wan Zongshun wrote:
> Suravee Suthikulpanit (4):
>   iommu/amd: Adding Extended Feature Register check for PC support
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

Applied, thanks. This works for me now on RD890, KV and CZ systems.



	Joerg
