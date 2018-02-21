From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 09/37] iommu/fault: Let handler return a fault response
Date: Wed, 21 Feb 2018 10:28:04 +0000
Message-ID: <11811f62-10d8-836c-f184-742d510bbdbc@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-10-jean-philippe.brucker@arm.com>
	<20180220151933.022f1036@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180220151933.022f1036@jacob-builder>
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

On 20/02/18 23:19, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:24 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
>>  
>> +/**
>> + * enum page_response_code - Return status of fault handlers,
>> telling the IOMMU
>> + * driver how to proceed with the fault.
>> + *
>> + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
>> not send a
>> + *	reply to the device.
>> + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
>> next handler,
>> + *	or terminate.
>> + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page
>> tables
>> + *	populated, retry the access. This is "Success" in PCI PRI.
>> + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
>> faults from
>> + *	this device if possible. This is "Response Failure" in PCI
>> PRI.
>> + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
>> retry the
>> + *	access. This is "Invalid Request" in PCI PRI.
>> + */
>> +enum page_response_code {
>> +	IOMMU_PAGE_RESP_HANDLED = 0,
>> +	IOMMU_PAGE_RESP_CONTINUE,
>> +	IOMMU_PAGE_RESP_SUCCESS,
>> +	IOMMU_PAGE_RESP_INVALID,
>> +	IOMMU_PAGE_RESP_FAILURE,
>> +};
> it seems to me two things are mixed here:
> 1. driver handler response status (HANDLED, CONTINUE)
> 2. PCI standard page response code (the rest)
> Can we leave them separate? then we don't have to convert this enum
> to/from PCI ATS page response code.

Except when the producer is a platform device instead of PCI :) But I get
your point. I liked combining them into one enum because it may simplify
some device drivers. I can separate HANDLED/CONTINUE and have drivers
always call page_response().

Thanks,
Jean
