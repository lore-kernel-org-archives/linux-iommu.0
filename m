From: "Wan, Vincent" <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH V2 0/8] iommu/amd: enable ACPI hardware ID device support
Date: Fri, 4 Mar 2016 01:52:31 +0000
Message-ID: <DM3PR1201MB10235E51027C3330C9BAF888E6BE0@DM3PR1201MB1023.namprd12.prod.outlook.com>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
	<20160226144446.GG22747@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160226144446.GG22747-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, "Xue, Ken" <Ken.Xue-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



Thanks!
Vincent Wan.

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, February 26, 2016 10:45 PM
> To: Wan, Vincent
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit, Suravee; Borislav Petkov;
> Huang, Ray; Xue, Ken; vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org; mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH V2 0/8] iommu/amd: enable ACPI hardware ID device
> support
> 
> On Tue, Jan 26, 2016 at 06:14:29PM -0500, Wan Zongshun wrote:
> > Suravee Suthikulpanit (3):
> >   iommu/amd: Modify ivhd_header structure to support type 11h and 40h
> >   iommu/amd: Use the most comprehensive IVHD type that the driver can
> >     support
> >   iommu/amd: Introduces ivrs_acpihid kernel parameter
> >
> > Wan Zongshun (5):
> >   iommu/amd: Add new map for storing IVHD dev entry type HID
> >   iommu/amd: Make call-sites of get_device_id aware of its return value
> >   iommu/amd: Add iommu support for ACPI HID devices
> >   iommu/amd: Manage iommu_group for ACPI HID devices
> >   iommu/amd: Set AMD iommu callbacks for amba bus
> 
> These patches fail to boot on my Carrizo system. Unfortunatly it fails before
> console is initialized and the box has no serial port to grab the early panic.
> 
Joerg,
Can you provide me which branch you are using to test those patches.

We are validating the patches in v4.5.0-rc6, and no issues like your description.

Vincent.

> 
> 
> 	Joerg
