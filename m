From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 8 Dec 2017 13:51:48 +0000
Message-ID: <af3c1d0f-e325-9507-0d59-7faadc79d66b@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
	<20171204133715.50c45136@jacob-builder>
	<a6cfc27a-6121-1e67-6e0d-f94a383bcd6f@arm.com>
	<20171206112521.1edf8e9b@jacob-builder>
	<39fcbbd2-2e6a-f05a-8cb4-8e3ad4ead369@arm.com>
	<20171207145641.50830562@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171207145641.50830562-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/12/17 21:56, Alex Williamson wrote:
[...]
>> Seems like VFIO should enforce this quota, since the IOMMU layer doesn't
>> know which device is assigned to which VM. If it's the IOMMU that enforces
>> quotas per device and a VM has 15 devices assigned, then the guest can
>> still DoS the IOMMU.
> 
> VFIO also doesn't know about VMs.  We know that devices attached to the
> same container are probably used by the same user, but once we add
> viommu, each device(group) uses its own container and we have no idea
> they're associated.  So, no to VM based accounting, and it seems like
> an IOMMU problem, X number of outstanding requests per device.  Thanks,

Ok. It's not clear anyway how the architecture and implementations expect
us to virtualize stall, I'll try to clarify it.

Thanks,
Jean
