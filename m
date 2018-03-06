From: okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
Date: Tue, 06 Mar 2018 07:52:37 -0500
Message-ID: <93dc46c9f4c9f5f6f9dc50c26333398b@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-8-jean-philippe.brucker@arm.com>
	<77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
	<430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <430e9754-4cf7-0aa8-7899-fc13e6a2e079-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-03-06 05:46, Jean-Philippe Brucker wrote:
> On 05/03/18 21:53, Sinan Kaya wrote:
>> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>>> +static struct workqueue_struct *iommu_fault_queue;
>> 
>> Is there anyway we can make this fault queue per struct device?
>> Since this is common code, I think it needs some care.
> 
> I don't think it's better, the workqueue struct seems large. Maybe 
> having
> one wq per IOMMU is a good compromise?

Yes, one per iommu sounds reasonable.


As said in my other reply for this
> patch, doing so isn't completely straightforward. I'll consider adding 
> an
> iommu pointer to the iommu_param struct attached to each device.
> 
> Thanks,
> Jean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
