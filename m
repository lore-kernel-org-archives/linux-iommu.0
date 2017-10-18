From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFCv2 PATCH 12/36] dt-bindings: document stall and PASID
 properties for IOMMU masters
Date: Tue, 17 Oct 2017 21:06:20 -0500
Message-ID: <CAL_JsqLFDeNq=PoipFv4qjKKP2mhE+2Eou4dBZhfm=XuXxjHrg@mail.gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-13-jean-philippe.brucker@arm.com> <20171013191051.lgxbcobkzzj5guhv@rob-hp-laptop>
 <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e7288f51-1cfa-44ce-e3ce-e9f3daf91579-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 16, 2017 at 5:23 AM, Jean-Philippe Brucker
<jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> On 13/10/17 20:10, Rob Herring wrote:
>> On Fri, Oct 06, 2017 at 02:31:39PM +0100, Jean-Philippe Brucker wrote:
>>> On ARM systems, some platform devices behind an IOMMU may support stall
>>> and PASID features. Stall is the ability to recover from page faults and
>>> PASID offers multiple process address spaces to the device. Together they
>>> allow to do paging with a device. Let the firmware tell us when a device
>>> supports stall and PASID.
>>
>> Can't these be implied by the compatible string of the devices?
>
> I think that PASID capacity can be deduced from the compatible string but
> don't know how these devices will be implemented (the only known example
> being a software model for testing). In any case implementing PASID based
> on the compatible string is tricky, because the IOMMU driver needs to know
> PASID capacity before the device driver has had time to probe the device.
> Maybe we could get away with a static table associating compatible string
> to PASID capacity, but it's not very nice.
>
> For stall it's a property of the integration between device and IOMMU,
> much like the "iommus" property, so it can't be deduced only from the
> compatible string. It's crucial that the firmware validates that stalling
> is safe, because we don't have any other way to discover it.

Okay, fair enough. I'll let others comment.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
