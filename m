From: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Fri, 8 May 2015 14:30:00 -0500
Message-ID: <CALRxmdAEvQPGN_xvwU5Xb4eNfKegPfTyM-GKXg4jRD7JyRxHJA@mail.gmail.com>
References: <20150324155007.GC23005@leverpostej>
	<CALRxmdAE_=SubN7dY-W1K44cjVVRhKLKknpgG9af_g64+GHPtw@mail.gmail.com>
	<20150508154903.GH25587@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150508154903.GH25587-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 8, 2015 at 10:49 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Stuart,
>
> On Thu, May 07, 2015 at 06:49:32PM +0100, Stuart Yoder wrote:
>> On Tue, Mar 24, 2015 at 10:50 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Hi all,
>> >
>> > For some devices, identification of particular masters is critical to
>> > their operation (e.g. IOMMUs, MSI controllers). The identity of masters
>> > is determined from sideband signals on the bus, and it may or may not be
>> > possible to probe and/or configure this information. Worse still, these
>> > information may be rewritten by intermediate buses, so the
>> > information for a given master may differ at different points in the bus
>> > hierarchy.
>> >
>> > We currently describe this master information for devices attached to
>> > IOMMUs, with a master ID being encoded in the iommu-cells. However this
>> > only covers the ID between the master and its IOMMU(s), and we don't
>> > currently have a mechanism to describe the master IDs as they are seen
>> > by devices beyond the IOMMU(s),
>>
>> Is there a specific case you've run across where conveying this additional
>> master info would be needed,  or are you just thinking through how to fully
>> describe hardware?
>
> It's a combination of a few things:
>
>   1. We are aware of hardware that has ID transformations
>   2. ACPI allows this to be described in IORT
>   3. We need to be general enough to encompass current and future designs
>      in the device-tree binding.
>
>> Are there really cases out there were there is a hardwired hardware
>> relationship between RID and SID?
>
> Yes, I believe it's actually the common case (at least, from Linux's
> perspective).
>
>> > or in the absence of any IOMMU(s).
>> >
>> > The following are example of master IDs:
>> > * PCIe Requester IDs (RIDs) (bus:device.function AKA BDF)
>> > * SMMU Stream IDs (SIDs)
>> > * GICv3 ITS Device IDs (DIDs)
>> >
>> > In the case of a system with PCIe, SMMU and GICv3, the master IDs are
>> > rewritten in a chain of RID=>SID=>DID, as in the following diagram:
>> >
>> > +-------------+
>> > | PCIe master |
>> > +-------------+
>> >     ||
>> >     || Requester ID (RID)
>> >     || Probeable from RC.
>> >     \/
>> > +-------------------+
>> > | PCIe Root Complex |
>> > +-------------------+
>> >     ||
>> >     || SMMU Stream ID (SID)
>> >     || Derived from RID, static non-probeable mapping.
>>
>> The FSL LS2085A SoC has an actual RID->SID mapping table in the PCI
>> controller, but it is not static in the sense of fixed in hardware or
>> firmware.  It's
>> a programmable mapping table, and we envision Linux programming this table.
>
> Ok, so I assume you're not planning to use ACPI with this system?

Not initially, but perhaps in the future.  I guess I don't know the implications
to ACPI yet.

> Also, we can't just program this table willy-nilly, as I'm sure you're
> aware. For example, updating a the SMRs in a live SMMU is a big no-no,
> so although Linux may initialise the table, it can only be safely changed
> at device init/teardown time, surely?

Correct.  That would not be updated when a device is live.

>> >     \/
>> > +--------------+
>> > | SMMU (IOMMU) |
>> > +--------------+
>> >     ||
>> >     || ITS Device ID (DID)
>> >     || Derived from SID, static non-probeable mapping.
>> >     \/
>>
>> Is this even architecturally possible on ARM?  Can the SMMU transform stream
>> IDs into some different number?
>
> From the OS perspective, this is what it looks like. What we'd actually
> have in hardware is multiple SMMUs sharing an ITS, so there would need
> to be something prepending an SMMU ID onto the StreamID to construct a
> device ID, otherwise you'd have devices inexplicably sharing MSIs.
>
>> > However, this conflicts/overlaps with existing bindings (at least iommus
>> > and msi-parent), and I'm not sure how to reconcile them. Am I missing a
>> > neat way of describing this that works with the existing bindings?
>> >
>> > It's also not clear to me if it's sufficient to have a generic
>> > "master-ids" property (with the relevant type being implicit from
>> > context), or if each type of ID needs each type of ID (RID, SID, DID,
>> > etc) needs its own.
>> >
>> > Which other devices out there which require side-band master
>> > information, and what do they require?
>>
>> For us, at least, the  master-id-map cannot be a static property.
>> Our PCI controller's DID->SID mapping table is programmable
>> and we won't know how to program it until Linux is running.  A PCI
>> SRIOV card may have virtual functions that appear as hot-plugged
>> devices and there is no way that boot firmware would have the knowledge
>> to have set that table up ahead of time.
>>
>> What we do need is some way to have boot firmware convey to
>> the OS what SIDs are available to be used in the DID->SID
>> table.   We have a very limited number of SIDs available and boot
>> firmware may need to convey to Linux that for example-- PCI controller #2
>> has only 8 SIDs available for DID->SID mappings.
>>
>> We had invented a property called "available-stream-ids" for some
>> proof of concept work, but perhaps the master-id-map property could
>> be used to convey available stream IDs by using a child-id-length
>> of 0.  So to convey that stream IDs 5,6,7,8 are available:
>>
>>   PCI: pci@af000000 {
>>          ...
>>          /* Requester ID of PCIe endpoints, implicit at runtime */
>>          master-id-cells = <1>;
>>
>>          /* RIDS idmapped to SIDS @ SMMU */
>>          master-id-map = <0 0 &SMMU 5
>>                                     0 0 &SMMU 6
>>                                     0 0 &SMMU 7
>>                                     0 0 &SMMU 8>;
>>   };
>>
>> I'm not sure the above would conflict with the existing IOMMU
>> binding, but would seem to be an extension of it.
>>
>> If you have a simple master with 2 stream IDS do this:          ...
>>           iommus = <&{/smmu} 23>, <&{/smmu} 24>;
>>
>> If you have a static DID->SID mapping to convey, use the map as
>> you proposed:
>>          master-id-cells = <1>;
>>          master-id-map = <0 0x10000 &SMMU 0>;;
>>
>> If your DID->SID is not static, but you need to convey the SIDs that are
>> available to this bus:
>>          master-id-cells = <1>;
>>          master-id-map = <0 0 &SMMU 23
>>                                     0 0 &SMMU 24>;
>
> We need to be careful with terminology here. Can we use RID to mean the PCI
> requester ID and DID to mean the GIC ITS device ID?

Sorry, that was a typo on my part...where I said DID I meant RID.

Thanks,
Stuart
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
