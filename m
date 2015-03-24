From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Master-aware devices and sideband ID data
Date: Tue, 24 Mar 2015 15:50:07 +0000
Message-ID: <20150324155007.GC23005@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

For some devices, identification of particular masters is critical to
their operation (e.g. IOMMUs, MSI controllers). The identity of masters
is determined from sideband signals on the bus, and it may or may not be
possible to probe and/or configure this information. Worse still, these
information may be rewritten by intermediate buses, so the
information for a given master may differ at different points in the bus
hierarchy.

We currently describe this master information for devices attached to
IOMMUs, with a master ID being encoded in the iommu-cells. However this
only covers the ID between the master and its IOMMU(s), and we don't
currently have a mechanism to describe the master IDs as they are seen
by devices beyond the IOMMU(s), or in the absence of any IOMMU(s).

The following are example of master IDs:
* PCIe Requester IDs (RIDs) (bus:device.function AKA BDF)
* SMMU Stream IDs (SIDs)
* GICv3 ITS Device IDs (DIDs)

In the case of a system with PCIe, SMMU and GICv3, the master IDs are
rewritten in a chain of RID=>SID=>DID, as in the following diagram:

+-------------+
| PCIe master |
+-------------+
    ||
    || Requester ID (RID)
    || Probeable from RC.
    \/
+-------------------+
| PCIe Root Complex |
+-------------------+
    ||
    || SMMU Stream ID (SID)
    || Derived from RID, static non-probeable mapping.
    \/
+--------------+
| SMMU (IOMMU) |
+--------------+
    ||
    || ITS Device ID (DID)
    || Derived from SID, static non-probeable mapping.
    \/
+----------------------------+
| GICv3 ITS (MSI controller) |
+----------------------------+

In simpler cases, you might have a simpler set of master ID
translations, e.g. just a DID:

+-----------------+
| Platform device |
+-----------------+
    ||
    || ITS Device ID (DID)
    || Hard-wired on the bus.
    \/
+----------------------------+
| GICv3 ITS (MSI controller) |
+----------------------------+

Ignoring current bindings for the moment, I can see how we can describe
this with a generic master id-binding, with master-id-map along the
lines of interrupt-map, with a tuple format like:
<child-id-base child-id-length parent parent-id-base>

For the PCIe example, this would look something like the following (with
properties omitted for brevity):

PCI: pci@af000000 {
	...
	
	/* Requester ID of PCIe endpoints, implicit at runtime */
	master-id-cells = <1>;

	/* RIDS idmapped to SIDS @ SMMU */
	master-id-map = <0 0x10000 &SMMU 0>;
}

SMMU: iommu@bf000000 {
	...

	/* SID, derived from RID */
	master-id-cells = <1>;

	/* 
	 * For some reason the high bit of the ID was negated.
	 */
	master-id-map = <0x0000 0x8000 &ITS 0x0 0x8000>,
	                <0x8000 0x8000 &ITS 0x0 0x0000>;

};

ITS: its@cf000000 {
	...

	/* DID, derived from SID */
	master-id-cells = <2>;

	/* 
	 * Master traffic not propagated beyond this point, so no
	 * master-id-ranges
	 */
};

For the simpler case, this would look something like:

DEV: device@af000000 {
	master-id-cells = <1>;
	master-ids = <0xf>, <0xb>;
	master-id-map = <0 0xf &ITS 0 0>;
};

ITS: its@cf000000 {
	...

	/* DID */
	master-id-cells = <2>;
};


However, this conflicts/overlaps with existing bindings (at least iommus
and msi-parent), and I'm not sure how to reconcile them. Am I missing a
neat way of describing this that works with the existing bindings?

It's also not clear to me if it's sufficient to have a generic
"master-ids" property (with the relevant type being implicit from
context), or if each type of ID needs each type of ID (RID, SID, DID,
etc) needs its own.

Which other devices out there which require side-band master
information, and what do they require?

Thanks,
Mark.
