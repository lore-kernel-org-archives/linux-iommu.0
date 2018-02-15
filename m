From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 08/37] iommu/fault: Handle mm faults
Date: Thu, 15 Feb 2018 13:51:34 +0000
Message-ID: <800c2efe-10d7-5711-37d6-fb45df9b6e5c@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-9-jean-philippe.brucker@arm.com>
	<20180214104621.7675579c@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180214104621.7675579c@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw@rjwyso
List-Id: iommu@lists.linux-foundation.org

On 14/02/18 18:46, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:23 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
[...]
>> +	if (!evt->pasid_valid)
>> +		return ret;
> I guess for not we don't handle PRQ without PASID, right?

No. I'm not sure how to implement it, though there have been some requests
(see discussion on 1/37)

>> +	/*
>> +	 * Special case: PASID Stop Marker (LRW = 0b100) doesn't
>> expect a
>> +	 * response. A Stop Marker may be generated when disabling a
>> PASID
>> +	 * (issuing a PASID stop request) in some PCI devices.
>> +	 *
>> +	 * When the mm_exit() callback returns from the device
>> driver, no page
>> +	 * request is generated for this PASID anymore and
>> outstanding ones have
>> +	 * been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
>> and 10.4.1.2 -
>> +	 * Managing PASID TLP Prefix Usage). Some PCI devices will
>> wait for all
>> +	 * outstanding page requests to come back with a response
>> before
>> +	 * completing the PASID stop request. Others do not wait for
>> page
>> +	 * responses, and instead issue this Stop Marker that tells
>> us when the
>> +	 * PASID can be reallocated.
>> +	 *
>> +	 * We ignore the Stop Marker because:
>> +	 * a. Page requests, which are posted requests, have been
>> flushed to the
>> +	 *    IOMMU when mm_exit() returns,
>> +	 * b. We flush all fault queues after mm_exit() returns and
>> before
>> +	 *    freeing the PASID.
>> +	 *
>> +	 * So even though the Stop Marker might be issued by the
>> device *after*
>> +	 * the stop request completes, outstanding faults will have
>> been dealt
>> +	 * with by the time we free the PASID.
>> +	 */
>> +	if (evt->last_req &&
>> +	    !(evt->prot & (IOMMU_FAULT_READ | IOMMU_FAULT_WRITE)))
>> +		return IOMMU_PAGE_RESP_HANDLED;
>> +
> If we don't expect a page response, shouldn't it be filtered by the
> IOMMU vendor driver in the first place? i.e. in the vendor IOMMU driver
> PRQ handler, it will sanitize the request anyway, for anything that
> does not need response, it will not call iommu_report_device_fault().

Right, we're not doing anything with the stop marker anyway. This encoding
is also specific to PCI PRI, and maybe in future architectures, LRW =
0b100 will mean something else and will require a response. So filtering
it in the IOMMU driver makes more sense.

Thanks,
Jean
