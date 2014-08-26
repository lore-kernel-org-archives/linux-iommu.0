From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC 4/5] vfio: amba: VFIO support for AMBA devices
Date: Tue, 26 Aug 2014 17:39:21 +0200
Message-ID: <CAG8rG2z5Jqwnpr49vX7=rgXMtuKd-4=eBaS2JaOrdT6Tgn0hqg@mail.gmail.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
	<1408698088-5349-5-git-send-email-a.motakis@virtualopensystems.com>
	<20140826105027.GH23445@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140826105027.GH23445-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello WIll,

On Tue, Aug 26, 2014 at 12:50 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Antonios,
>
> On Fri, Aug 22, 2014 at 10:01:27AM +0100, Antonios Motakis wrote:
>> Add support for discovering AMBA devices with VFIO and handle them
>> similarly to Linux platform devices.
>
> [...]
>
>> +static struct amba_id pl330_ids[] = {
>> +     { 0, 0 },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(amba, pl330_ids);
>> +
>> +static struct amba_driver vfio_amba_driver = {
>> +     .probe = vfio_amba_probe,
>> +     .remove = vfio_amba_remove,
>> +     .id_table = pl330_ids,
>> +     .drv = {
>> +             .name = "vfio-amba",
>> +             .owner = THIS_MODULE,
>> +     },
>> +};
>
> I don't understand what you're doing with the IDs here. What's the point in
> the empty list?
>

The empty list means VFIO will not bind to any AMBA devices by
default. If the user wants to use an AMBA device with VFIO, the idea
is to use the driver override proposed in [RFC 1/5] driver core: amba:
add device binding path 'driver_override'.

> This also raises a larger question about whether or not it's safe to allow
> device passthrough of arbitrary platform devices with VFIO. In the absence
> of a bus/device standard like PCI, I really think this should be in opt-in
> decision, where certain platform drivers can declare that their device can
> be safely used with passthrough.

In a sense the driver_override is already an opt-in, although under
control of the user. I don't know if we want to take the decision for
the user and whitelist the devices one can safely use, and reject any
other device one might want to try. I would argue that if a user
decides to use driver_override, he should be able to do that (and then
report the consequences to us ;)

Some of the differences between PLATFORM devices, could be handled at
the QEMU level. With the addition of the VFIO device node info patches
we also proposed recently, any VFIO user essentially sees a bunch of
MMIO regions, IRQs and some device node properties that describe the
device. So a VFIO user (e.g. QEMU) has access to more or less the same
stuff a kernel driver does.

I could see this breaking if a device tries to do memory accesses that
don't go through the IOMMU (maybe if it is directly connected with
another device), but in that situation that device is probably
unusable with VFIO even if we special-case it. Any other ideas?

>
> Thoughts?
>
> Will



-- 
Antonios Motakis
Virtual Open Systems
