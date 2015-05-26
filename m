From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Tue, 26 May 2015 22:20:59 +0000
Message-ID: <26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
References: <20150324155007.GC23005@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150324155007.GC23005@leverpostej>
Content-Language: en-US
Content-ID: <0F2EA510BA163A4E92823CCAFACAC617-Tk6F3M/euE6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is some thing we also like to see in ITS and SMMU drivers. 
> On Mar 24, 2015, at 8:50 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> 
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
> by devices beyond the IOMMU(s), or in the absence of any IOMMU(s).
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
>    ||
>    || Requester ID (RID)
>    || Probeable from RC.
>    \/
> +-------------------+
> | PCIe Root Complex |
> +-------------------+
>    ||
>    || SMMU Stream ID (SID)
>    || Derived from RID, static non-probeable mapping.
>    \/
> +--------------+
> | SMMU (IOMMU) |
> +--------------+
>    ||
>    || ITS Device ID (DID)
>    || Derived from SID, static non-probeable mapping.
>    \/
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
>    ||
>    || ITS Device ID (DID)
>    || Hard-wired on the bus.
>    \/
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
> 	...
> 	
> 	/* Requester ID of PCIe endpoints, implicit at runtime */
> 	master-id-cells = <1>;
> 
> 	/* RIDS idmapped to SIDS @ SMMU */
> 	master-id-map = <0 0x10000 &SMMU 0>;
> }
> 
> SMMU: iommu@bf000000 {
> 	...
> 
> 	/* SID, derived from RID */
> 	master-id-cells = <1>;
> 
> 	/* 
> 	 * For some reason the high bit of the ID was negated.
> 	 */
> 	master-id-map = <0x0000 0x8000 &ITS 0x0 0x8000>,
> 	                <0x8000 0x8000 &ITS 0x0 0x0000>;
> 
> };
> 
> ITS: its@cf000000 {
> 	...
> 
> 	/* DID, derived from SID */
> 	master-id-cells = <2>;
> 
> 	/* 
> 	 * Master traffic not propagated beyond this point, so no
> 	 * master-id-ranges
> 	 */
> };

I think it is nice to have max IDs supported by masters. so that drivers can check and enforce.  

> 
> For the simpler case, this would look something like:
> 
> DEV: device@af000000 {
> 	master-id-cells = <1>;
> 	master-ids = <0xf>, <0xb>;
> 	master-id-map = <0 0xf &ITS 0 0>;
> };
> 
> ITS: its@cf000000 {
> 	...
> 
> 	/* DID */
> 	master-id-cells = <2>;
> };
> 
Is this is not depending heavily on discover order, how do drivers know which device to get which ID. is it implicitly assumed in discovery order? 
what happens to hot pluggable devices.  

Thanks,
Tirumalesh. 

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
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
