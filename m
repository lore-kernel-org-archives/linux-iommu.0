From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Thu, 05 Apr 2012 13:21:23 -0600
Message-ID: <4F7DF0B3.4050500@wwwdotorg.org>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
	<4F7DBCEE.9080400@wwwdotorg.org>
	<20120405162318.GA10628@avionic-0098.adnet.avionic-design.de>
	<20120405180805.GB11601@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120405180805.GB11601-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/05/2012 12:08 PM, Thierry Reding wrote:
> * Thierry Reding wrote:
>> * Stephen Warren wrote:
>>> On 04/05/2012 02:42 AM, Thierry Reding wrote:
>>>> Hi,
>>>>
>>>> I have a device tree where I have a GART device and a DRM device which uses
>>>> the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
>>>> requires the user device to be a child of the GART device (it explicitly
>>>> checks for this when the user device is attached).
>>>
>>> Isn't this wrong?
>>>
>>> I would expect the device parent/child relationship to reflect the
>>> CPU-initiated register access bus topology.
>>>
>>> A device's interaction with an IOMMU is an aspect of a device's
>>> initiating accesses itself, not CPU-initiated register accesses.
>>
>> Actually I have no idea why this was made a requirement. Maybe Hiroshi can
>> comment on this. The driver really only needs this to basically obtain a
>> pointer to itself. The MSM I/O MMU implementation does something similar,
>> though, and goes on to register actual child devices (they are instantiated
>> in arch/arm/mach-msm/devices-iommu.c). Each of those devices is then assigned
>> a specific memory area it seems.
> [...]
>> I don't think having more than one device using the IOMMU will work properly
>> anyway in the context of the Tegra GART driver because there is not means to
>> allocate specific regions of the GART aperture to individual devices. So
>> really the one and only client actually needs to manage the allocations from
>> the GART aperture.
> 
> I've been thinking about this some more and it occurred to me that maybe it
> would be best to add an additional layer between the GART and the clients
> which could manage the allocations. Such a virtual device could actually be
> registered as a child of the GART device and allow individual drivers to
> request mappings from it so that there is a single instance handing them out
> and keep them consistent.
> 
> How does that sound?

I must admit I'm not at all familiar with the IOMMU APIs, but isn't the
IOMMU driver/subsystem itself what is managing all the allocations and
handing them out to clients? And client drivers do things like asking
for N pages of memory mapped into their aperture? If that is true, I'm
not sure what the purpose is of the intermediate device you propose.
Sorry for being somewhat clueless.
