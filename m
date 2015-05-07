From: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Thu, 7 May 2015 12:49:32 -0500
Message-ID: <CALRxmdAE_=SubN7dY-W1K44cjVVRhKLKknpgG9af_g64+GHPtw@mail.gmail.com>
References: <20150324155007.GC23005@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150324155007.GC23005@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 24, 2015 at 10:50 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi all,
>
> For some devices, identification of particular masters is critical to
> their operation (e.g. IOMMUs, MSI controllers). The identity of masters
> is determined from sideband signals on the bus, and it may or may not be
> possible to probe and/or configure this information. Worse still, these
> information may be rewritten by intermediate buses, so the
> information for a given master may differ at different points in the bus
> hierarchy.
>
> We currently describe this master information for devices attached to
> IOMMUs, with a master ID being encoded in the iommu-cells. However this
> only covers the ID between the master and its IOMMU(s), and we don't
> currently have a mechanism to describe the master IDs as they are seen
> by devices beyond the IOMMU(s),

Is there a specific case you've run across where conveying this additional
master info would be needed,  or are you just thinking through how to fully
describe hardware?

Are there really cases out there were there is a hardwired hardware
relationship between RID and SID?

> or in the absence of any IOMMU(s).
>
> The following are example of master IDs:
> * PCIe Requester IDs (RIDs) (bus:device.function AKA BDF)
> * SMMU Stream IDs (SIDs)
> * GICv3 ITS Device IDs (DIDs)
>
> In the case of a system with PCIe, SMMU and GICv3, the master IDs are
> rewritten in a chain of RID=>SID=>DID, as in the following diagram:
>
> +-------------+
> | PCIe master |
> +-------------+
>     ||
>     || Requester ID (RID)
>     || Probeable from RC.
>     \/
> +-------------------+
> | PCIe Root Complex |
> +-------------------+
>     ||
>     || SMMU Stream ID (SID)
>     || Derived from RID, static non-probeable mapping.

The FSL LS2085A SoC has an actual RID->SID mapping table in the PCI
controller, but it is not static in the sense of fixed in hardware or
firmware.  It's
a programmable mapping table, and we envision Linux programming this table.

>     \/
> +--------------+
> | SMMU (IOMMU) |
> +--------------+
>     ||
>     || ITS Device ID (DID)
>     || Derived from SID, static non-probeable mapping.
>     \/

Is this even architecturally possible on ARM?  Can the SMMU transform stream
IDs into some different number?

> +----------------------------+
> | GICv3 ITS (MSI controller) |
> +----------------------------+
>
> In simpler cases, you might have a simpler set of master ID
> translations, e.g. just a DID:
>
> +-----------------+
> | Platform device |
> +-----------------+
>     ||
>     || ITS Device ID (DID)
>     || Hard-wired on the bus.
>     \/
> +----------------------------+
> | GICv3 ITS (MSI controller) |
> +----------------------------+
>
> Ignoring current bindings for the moment, I can see how we can describe
> this with a generic master id-binding, with master-id-map along the
> lines of interrupt-map, with a tuple format like:
> <child-id-base child-id-length parent parent-id-base>
>
> For the PCIe example, this would look something like the following (with
> properties omitted for brevity):
>
> PCI: pci@af000000 {
>         ...
>
>         /* Requester ID of PCIe endpoints, implicit at runtime */
>         master-id-cells = <1>;
>
>         /* RIDS idmapped to SIDS @ SMMU */
>         master-id-map = <0 0x10000 &SMMU 0>;
> }
>
> SMMU: iommu@bf000000 {
>         ...
>
>         /* SID, derived from RID */
>         master-id-cells = <1>;
>
>         /*
>          * For some reason the high bit of the ID was negated.
>          */
>         master-id-map = <0x0000 0x8000 &ITS 0x0 0x8000>,
>                         <0x8000 0x8000 &ITS 0x0 0x0000>;
>
> };
>
> ITS: its@cf000000 {
>         ...
>
>         /* DID, derived from SID */
>         master-id-cells = <2>;
>
>         /*
>          * Master traffic not propagated beyond this point, so no
>          * master-id-ranges
>          */
> };
>
> For the simpler case, this would look something like:
>
> DEV: device@af000000 {
>         master-id-cells = <1>;
>         master-ids = <0xf>, <0xb>;
>         master-id-map = <0 0xf &ITS 0 0>;
> };
>
> ITS: its@cf000000 {
>         ...
>
>         /* DID */
>         master-id-cells = <2>;
> };
>
>
> However, this conflicts/overlaps with existing bindings (at least iommus
> and msi-parent), and I'm not sure how to reconcile them. Am I missing a
> neat way of describing this that works with the existing bindings?
>
> It's also not clear to me if it's sufficient to have a generic
> "master-ids" property (with the relevant type being implicit from
> context), or if each type of ID needs each type of ID (RID, SID, DID,
> etc) needs its own.
>
> Which other devices out there which require side-band master
> information, and what do they require?

For us, at least, the  master-id-map cannot be a static property.
Our PCI controller's DID->SID mapping table is programmable
and we won't know how to program it until Linux is running.  A PCI
SRIOV card may have virtual functions that appear as hot-plugged
devices and there is no way that boot firmware would have the knowledge
to have set that table up ahead of time.

What we do need is some way to have boot firmware convey to
the OS what SIDs are available to be used in the DID->SID
table.   We have a very limited number of SIDs available and boot
firmware may need to convey to Linux that for example-- PCI controller #2
has only 8 SIDs available for DID->SID mappings.

We had invented a property called "available-stream-ids" for some
proof of concept work, but perhaps the master-id-map property could
be used to convey available stream IDs by using a child-id-length
of 0.  So to convey that stream IDs 5,6,7,8 are available:

  PCI: pci@af000000 {
         ...
         /* Requester ID of PCIe endpoints, implicit at runtime */
         master-id-cells = <1>;

         /* RIDS idmapped to SIDS @ SMMU */
         master-id-map = <0 0 &SMMU 5
                                    0 0 &SMMU 6
                                    0 0 &SMMU 7
                                    0 0 &SMMU 8>;
  };

I'm not sure the above would conflict with the existing IOMMU
binding, but would seem to be an extension of it.

If you have a simple master with 2 stream IDS do this:          ...
          iommus = <&{/smmu} 23>, <&{/smmu} 24>;

If you have a static DID->SID mapping to convey, use the map as
you proposed:
         master-id-cells = <1>;
         master-id-map = <0 0x10000 &SMMU 0>;;

If your DID->SID is not static, but you need to convey the SIDs that are
available to this bus:
         master-id-cells = <1>;
         master-id-map = <0 0 &SMMU 23
                                    0 0 &SMMU 24>;

I am less sure about how to deal with expressing the relationship of masters to
the GIC ITS, but is there really a problem there?

Thanks,
Stuart
