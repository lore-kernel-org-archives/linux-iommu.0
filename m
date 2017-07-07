From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pci: Add drop mask property for MSI
	and IOMMU
Date: Fri, 7 Jul 2017 16:47:30 +0100
Message-ID: <20170707154729.GE3425@leverpostej>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
	<1499411399-25103-2-git-send-email-srinath.mannam@broadcom.com>
	<20170707133052.GB3425@leverpostej>
	<89f871d1-fc28-aa0b-2460-cf834e7e99f6@arm.com>
	<a66fac9a-b8f7-489e-a32a-ab2100c89653@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a66fac9a-b8f7-489e-a32a-ab2100c89653-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 07, 2017 at 08:22:21AM -0700, Scott Branden wrote:
> On 17-07-07 07:55 AM, Robin Murphy wrote:
> >On 07/07/17 14:30, Mark Rutland wrote:
> >>On Fri, Jul 07, 2017 at 12:39:58PM +0530, Srinath Mannam wrote:
> >>>+Example (6)
> >>>+===========
> >>>+
> >>>+/ {
> >>>+	#address-cells = <1>;
> >>>+	#size-cells = <1>;
> >>>+
> >>>+	msi: msi-controller@a {
> >>>+		reg = <0xa 0x1>;
> >>>+		compatible = "vendor,some-controller";
> >>>+		msi-controller;
> >>>+		#msi-cells = <1>;
> >>>+	};
> >>>+
> >>>+	pci: pci@f {
> >>>+		reg = <0xf 0x1>;
> >>>+		compatible = "vendor,pcie-root-complex";
> >>>+		device_type = "pci";
> >>>+
> >>>+		/*
> >>>+		 * The sideband data provided to the  MSI controller is
> >>>+		 * a 10bit data derived from the RID by dropping
> >>>+		 * 4 MSBs of device number and 2 MSBs of function number.
> >>>+		 */
> >>>+		msi-map = <0x0 &msi_a 0x0 0x100>,
> >>>+		msi-map-drop-mask = <0xff09>
> >>>+	};
> >>>+};
> >>... likewise on all counts.
> >>
> >>Your mapping can be expressed today using a number of msi-map entries,
> >>which you can easily generate programmatically with a trivial perl
> >>script, without requiring a new binding or any new kernel code.
> >>
> >>Please do that instead.
> >
> >Indeed. The systems I'm aware of which need to express non-trivial RID
> >to SID mappings tend to have the bootloader probe PCI and dynamically
> >generate map entries per discovered RID, but even if you wanted to
> >statically generate the whole lot for the worst-case bus range that's
> >still only 512 entries, which is not unmanageable. Notably, it's also
> >what would have to be done (in equivalent) for IORT, although I assume
> >this is an embedded platform for which nobody cares about ACPI.
>
> Actually we will care about ACPI and need to add it (doesn't need to
> be in this patchet unless easy to do so...)

Similarly to what I said for the DT case, with IORT you can solve this
today by using multiple ID mapping entries in a node's ID mappings
array.

I don't imagine the sort of change you are proposing will sail into the
IORT spec.

Thanks,
Mark.
