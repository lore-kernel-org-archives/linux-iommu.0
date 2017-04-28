From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Sat, 29 Apr 2017 00:40:53 +0200
Message-ID: <20170428224053.GJ1332@8bytes.org>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
	<20170427210325.GE1332@8bytes.org>
	<20170428144634.7950c8cf@thinkpad>
	<20170428145513.GH1332@8bytes.org>
	<20170428200612.42b4f3d2@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170428200612.42b4f3d2@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Gerald,

On Fri, Apr 28, 2017 at 08:06:12PM +0200, Gerald Schaefer wrote:
> On Fri, 28 Apr 2017 16:55:13 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Also, IIRC, add_device will get called before attach_dev. Currently we
> allow to attach more than one device (apparently from different buses) to
> one domain (one shared DMA table) in attach_dev. But then it would be too
> late to also add all devices to the same iommu-group. That would have had
> to be done earlier in add_device, but there we don't know yet if a shared
> DMA table would be set up later in attach_dev.

I think there is some misunderstanding here about what iommu-groups are.
An iommu-group is a group of devices that are not isolated from each
other wrt. DMA and/or IRQs. This means that the devices can influence
each other, e.g. directly DMA to each other without IOMMU control. So
the grouping relies on how the hardware is built.

Domains on the other side are a software controled concept. A domain is
basically an abstraction of a DMA address space. Multiple devices can
share on domain/address-space, just as multiple threads can share a
cpu address space.

The point of iommu-grouping is to make sure that we don't assign
different domains to devices in the same group, as that could break or
cause security issues without proper isolation.


Regards,

	Joerg
