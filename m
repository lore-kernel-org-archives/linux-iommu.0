From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Date: Sat, 28 Apr 2018 02:41:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19113D5F3@SHSMSX101.ccr.corp.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <72ee47c4-55fa-4ff1-d94e-cc26203e3eda-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Liu-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org" <Liu-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Saturday, April 28, 2018 2:08 AM
> 
> [...]
> >> If this corresponds to QI_GRAN_ALL_ALL in patch 9, the comment should
> >> be "Cache of all PASIDs"? Or maybe "all entries for all PASIDs"? Is it
> >> different from GRANU_DOMAIN then?
> > QI_GRAN_ALL_ALL maps to VT-d spec 6.5.2.4, which invalidates all ext
> > TLB cache within a domain. It could reuse GRANU_DOMAIN but I was
> > also trying to match the naming convention in the spec.
> 
> Sorry I don't quite understand the difference between TLB and ext TLB
> invalidation. Can an ext TLB invalidation do everything a TLB can do
> plus some additional parameters (introduced in more recent version of
> the spec), or do they have distinct purposes? I'm trying to understand
> why it needs to be user-visible

distinct purpose though some overlapped effect:

IOTLB invalidate is more for 2nd-level cache on granularity (global/
domain/PSI), with side effect on 1st-level and nested caches (global/
domain).

Extended IOTLB invalidate is specifically for 1st-level and nested
caches on granularity (per-domain: all PASIDs/per PASID/PSI). 

Thanks
Kevin
