From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 13:37:37 +0200
Message-ID: <20181115113737.GW2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112160628.86620-2-mika.westerberg@linux.intel.com>
	<20181112180203.lx72gjfplb6xlur7@wunner.de>
	<20181113105636.GB11202@e107981-ln.cambridge.arm.com>
	<20181113112700.GT2500@lahna.fi.intel.com>
	<20181113114527.GA12821@e107981-ln.cambridge.arm.com>
	<20181115102239.GU2500@lahna.fi.intel.com>
	<20181115111356.GA599@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181115111356.GA599-4tUPXFaYRHv6sAKXYmQ0tx/iLCjYCKR+VpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 15, 2018 at 11:13:56AM +0000, Lorenzo Pieralisi wrote:
> I have strong objections to the way these bindings have been forced upon
> everybody; if that's the way *generic* ACPI bindings are specified I
> wonder why there still exists an ACPI specification and related working
> group.
> 
> I personally (but that's Bjorn and Rafael choice) think that this is
> not a change that belongs in PCI core, ACPI bindings are ill-defined
> and device tree bindings are non-existing.

Any idea where should I put it then? These systems are already out there
and we need to support them one way or another.

> At the very least Microsoft should be asked to publish and discuss
> these bindings within the ACPI and UEFI forums.

These bindings are public, see here:

  https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports

However, they are not part of the ACPI spec as you say.
