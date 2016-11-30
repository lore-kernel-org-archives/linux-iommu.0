From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 0/8] IOMMU probe deferral support
Date: Wed, 30 Nov 2016 06:04:13 +0530
Message-ID: <00c901d24aa1$7d851730$788f4590$@codeaurora.org>
References: <60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
	<003a01d22f97$82534c70$86f9e550$@codeaurora.org>
	<421e2b14-0231-d376-02a0-097423120b3d@arm.com>
	<006f01d236ae$61751c40$245f54c0$@codeaurora.org>
	<9f36244f-62d4-08e3-d64a-2b04ad4dc2e0@arm.com>
	<002b01d24340$5d56e730$1804b590$@codeaurora.org>
	<918128b9-cdb0-1454-000a-146cee7a05ea@arm.com>
	<004401d2466d$5b8b2170$12a16450$@codeaurora.org>
	<f2ad6976-0f8f-d116-bc43-37337dd9f41f@arm.com>
	<000001d2499e$df7f2d80$9e7d8880$@codeaurora.org>
	<20161128181339.GA32078@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161128181339.GA32078@red-moon>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Lorenzo Pieralisi
>Sent: Monday, November 28, 2016 11:44 PM
>To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
>foundation.org; srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>;
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
>Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
>
>On Mon, Nov 28, 2016 at 11:12:08PM +0530, Sricharan wrote:
>
>[...]
>
>> >Cool. We're rather hoping that the ACPI stuff is good to go for 4.10
>> >now, so it's probably worth pulling the rest of that in (beyond the one
>> >patch I picked) to make sure the of_dma_configure/acpi_dma_configure
>> >paths don't inadvertently diverge.
>> >
>>
>> I rebased and was testing your branch with Lorenzo's series. One thing
>> i am still trying to get right is the acpi_dma_configure call. With your
>> series dma_configure calls pci_dma/of_dma configure, so i am just adding
>> acpi_dma_configure call there for non-pci ACPI devices as well. I see that
>> acpi_dma_configure right now is called from acpi_bind_one and
>> iort_add_smmu_platform_device, both go through the really_probe function
>> path, so moving acpi_dma_configure from the above the two functions
>> to dma_configure. I remember we discussed this on another thread, so
>> hopefully it is correct. I do not have an platform to test the ACPI though.
>> I will take some testing help on V4 for this.
>
>I am happy to test it for you please just send me a pointer at your v4
>code.
>
 I posted the v4 and CCed you there. So i am little skeptical about the acpi
changes that i have posted. I was checking for a function equivalent 
in acpi as of_match_node in DT, to figure out if the iommu_spec.np that
the master device is pointing to is there in the iommu_of_table and based
on that we can decide if to defer the probe. I was seeing iort_scan_node
was its equivalent. But if that is not correct, then last patch has to be reworked.
Anyways will be good to know your feedback on this.

Regards,
 Sricharan
