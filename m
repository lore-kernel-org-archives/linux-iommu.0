From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Fri, 14 Sep 2018 02:53:37 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19130381B@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
	<aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
	<3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
	<4b24f0c6-5985-efbc-f842-8bde239dfc2a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4b24f0c6-5985-efbc-f842-8bde239dfc2a-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David
	Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Bie, Tiwei" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar, Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Friday, September 14, 2018 10:47 AM
> 
> Hi,
> 
> On 09/13/2018 01:54 AM, Jean-Philippe Brucker wrote:
> > On 12/09/2018 03:42, Lu Baolu wrote:
> >> Hi,
> >>
> >> On 09/11/2018 12:22 AM, Jean-Philippe Brucker wrote:
> >>> Hi,
> >>>
> >>> On 30/08/2018 05:09, Lu Baolu wrote:
> >>>> Below APIs are introduced in the IOMMU glue for device drivers to
> use
> >>>> the finer granularity translation.
> >>>>
> >>>> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
> >>>>     - Represents the ability for supporting multiple domains per device
> >>>>       (a.k.a. finer granularity translations) of the IOMMU hardware.
> >>> iommu_capable() cannot represent hardware capabilities, we need
> >>> something else for systems with multiple IOMMUs that have different
> >>> caps. How about iommu_domain_get_attr on the device's domain
> instead?
> >> Domain is not a good choice for per iommu cap query. A domain might
> be
> >> attached to devices belonging to different iommu's.
> >>
> >> How about an API with device structure as parameter? A device always
> >> belongs to a specific iommu. This API is supposed to be used the
> >> device driver.
> > Ah right, domain attributes won't work. Your suggestion seems more
> > suitable, but maybe users can simply try to enable auxiliary domains
> > first, and conclude that the IOMMU doesn't support it if it returns an
> error
> >
> 
> Some driver might want to check whether hardware supports
> AUX_DOMAIN
> during the driver probe stage, but doesn't want to enable AUX_DOMAIN
> at that time. One reasonable use case is driver check AUX_DOMAIN cap
> during driver probe and expose different sysfs nodes according to
> whether AUX_DOMAIN is support or not, then AUX_DOMAIN is enabled or
> disabled during run time through a sysfs node. With this consideration,
> we still need a API to check cap.
> 
> How about
> 
> * iommu_check_aux_domain(struct device *dev)
>     - Check whether the iommu driver supports multiple domains on @dev.
> 

maybe generalized as iommu_check_attr with aux_domain as a flag,
in case other IOMMU checks introduced in the future. hinted by Jean's
comment on iommu_sva_device_init part.

Thanks
Kevin
