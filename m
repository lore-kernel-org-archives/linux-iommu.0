From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] Docs: dt: add generic MSI bindings
Date: Mon, 24 Aug 2015 08:37:59 -0500
Message-ID: <CAL_Jsq+-xKsfBwqjHnSKPxtO1muu-NLEHZTTLpSqw=sBuU1Gjw@mail.gmail.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-2-git-send-email-mark.rutland@arm.com> <20150805165120.GB28849@leverpostej>
 <20150824101755.GC7139@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150824101755.GC7139@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <majun258-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tirumalesh.chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 24, 2015 at 5:17 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Aug 05, 2015 at 05:51:20PM +0100, Mark Rutland wrote:
>> Rob,
>>
>> Do you have any objections to this, or are you happy to take this patch?
>>
>> There's a user of this binding (the GICv3 ITS) queued for v4.3 already in
>> the tip tree, so either we either need to be ok with this binding or we
>> need to rework that before v4.3.
>
> Sorry to ping, but are you happy to take this? Marc's replied and
> provided his ack.

Sorry. Looks fine to me, so I'll apply.

> I'm happy to resend if you prefer?

What about patch 2 and 3? I can't find patch 3 in my mail.

Rob

>
> Thanks,
> Mark.
>
>> Marc, can I take it from your use of the binding that you are happy to
>> provide your ack?
>>
>> Thanks,
>> Mark.
>>
>> On Thu, Jul 23, 2015 at 05:52:43PM +0100, Mark Rutland wrote:
>> > Currently msi-parent is used in a couple of drivers despite being fairly
>> > underspecified. This patch adds a generic binding for MSIs (including
>> > the existing msi-parent property) enabling the description of platform
>> > devices capable of using MSIs.
>> >
>> > While MSIs are primarily distinguished by doorbell and payload, some MSI
>> > controllers (e.g. the GICv3 ITS) also use side-band information
>> > accompanying the write to identify the master which originated the MSI,
>> > to allow for sandboxing. This sideband information is non-probeable and
>> > needs to be described in the DT. Other MSI controllers may have
>> > additional configuration details which need to be described per-master.
>> >
>> > This patch adds a generic msi-parent binding document, extending the
>> > de-facto standard with a new (optional) #msi-cells which can be used to
>> > express any per-master configuration and/or sideband data. This is
>> > sufficient to describe non-hotpluggable devices.
>> >
>> > For busses where sideband data may be derived from some bus-specific
>> > master ID scheme, other properties will be required to describe the
>> > mapping.
>> >
>> > Signed-off-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> > ---
>> >  .../bindings/interrupt-controller/msi.txt          | 135 +++++++++++++++++++++
>> >  1 file changed, 135 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi.txt b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
>> > new file mode 100644
>> > index 0000000..c60c034
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
>> > @@ -0,0 +1,135 @@
>> > +This document describes the generic device tree binding for MSI controllers and
>> > +their master(s).
>> > +
>> > +Message Signaled Interrupts (MSIs) are a class of interrupts generated by a
>> > +write to an MMIO address.
>> > +
>> > +MSIs were originally specified by PCI (and are used with PCIe), but may also be
>> > +used with other busses, and hence a mechanism is required to relate devices on
>> > +those busses to the MSI controllers which they are capable of using,
>> > +potentially including additional information.
>> > +
>> > +MSIs are distinguished by some combination of:
>> > +
>> > +- The doorbell (the MMIO address written to).
>> > +
>> > +  Devices may be configured by software to write to arbitrary doorbells which
>> > +  they can address. An MSI controller may feature a number of doorbells.
>> > +
>> > +- The payload (the value written to the doorbell).
>> > +
>> > +  Devices may be configured to write an arbitrary payload chosen by software.
>> > +  MSI controllers may have restrictions on permitted payloads.
>> > +
>> > +- Sideband information accompanying the write.
>> > +
>> > +  Typically this is neither configurable nor probeable, and depends on the path
>> > +  taken through the memory system (i.e. it is a property of the combination of
>> > +  MSI controller and device rather than a property of either in isolation).
>> > +
>> > +
>> > +MSI controllers:
>> > +================
>> > +
>> > +An MSI controller signals interrupts to a CPU when a write is made to an MMIO
>> > +address by some master. An MSI controller may feature a number of doorbells.
>> > +
>> > +Required properties:
>> > +--------------------
>> > +
>> > +- msi-controller: Identifies the node as an MSI controller.
>> > +
>> > +Optional properties:
>> > +--------------------
>> > +
>> > +- #msi-cells: The number of cells in an msi-specifier, required if not zero.
>> > +
>> > +  Typically this will encode information related to sideband data, and will
>> > +  not encode doorbells or payloads as these can be configured dynamically.
>> > +
>> > +  The meaning of the msi-specifier is defined by the device tree binding of
>> > +  the specific MSI controller.
>> > +
>> > +
>> > +MSI clients
>> > +===========
>> > +
>> > +MSI clients are devices which generate MSIs. For each MSI they wish to
>> > +generate, the doorbell and payload may be configured, though sideband
>> > +information may not be configurable.
>> > +
>> > +Required properties:
>> > +--------------------
>> > +
>> > +- msi-parent: A list of phandle + msi-specifier pairs, one for each MSI
>> > +  controller which the device is capable of using.
>> > +
>> > +  This property is unordered, and MSIs may be allocated from any combination of
>> > +  MSI controllers listed in the msi-parent property.
>> > +
>> > +  If a device has restrictions on the allocation of MSIs, these restrictions
>> > +  must be described with additional properties.
>> > +
>> > +  When #msi-cells is non-zero, busses with an msi-parent will require
>> > +  additional properties to describe the relationship between devices on the bus
>> > +  and the set of MSIs they can potentially generate.
>> > +
>> > +
>> > +Example
>> > +=======
>> > +
>> > +/ {
>> > +   #address-cells = <1>;
>> > +   #size-cells = <1>;
>> > +
>> > +   msi_a: msi-controller@a {
>> > +           reg = <0xa 0xf00>;
>> > +           compatible = "vendor-a,some-controller";
>> > +           msi-controller;
>> > +           /* No sideband data, so #msi-cells omitted */
>> > +   };
>> > +
>> > +   msi_b: msi-controller@b {
>> > +           reg = <0xb 0xf00>;
>> > +           compatible = "vendor-b,another-controller";
>> > +           msi-controller;
>> > +           /* Each device has some unique ID */
>> > +           #msi-cells = <1>;
>> > +   };
>> > +
>> > +   msi_c: msi-controller@c {
>> > +           reg = <0xb 0xf00>;
>> > +           compatible = "vendor-b,another-controller";
>> > +           msi-controller;
>> > +           /* Each device has some unique ID */
>> > +           #msi-cells = <1>;
>> > +   };
>> > +
>> > +   dev@0 {
>> > +           reg = <0x0 0xf00>;
>> > +           compatible = "vendor-c,some-device";
>> > +
>> > +           /* Can only generate MSIs to msi_a */
>> > +           msi-parent = <&msi_a>;
>> > +   };
>> > +
>> > +   dev@1 {
>> > +           reg = <0x1 0xf00>;
>> > +           compatible = "vendor-c,some-device";
>> > +
>> > +           /*
>> > +            * Can generate MSIs to either A or B.
>> > +            */
>> > +           msi-parent = <&msi_a>, <&msi_b 0x17>;
>> > +   };
>> > +
>> > +   dev@2 {
>> > +           reg = <0x2 0xf00>;
>> > +           compatible = "vendor-c,some-device";
>> > +           /*
>> > +            * Has different IDs at each MSI controller.
>> > +            * Can generate MSIs to all of the MSI controllers.
>> > +            */
>> > +           msi-parent = <&msi_a>, <&msi_b 0x17>, <&msi_c 0x53>;
>> > +   };
>> > +};
>> > --
>> > 1.9.1
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
