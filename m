From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Tue, 13 Nov 2018 11:45:36 +0000
Message-ID: <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112160628.86620-2-mika.westerberg@linux.intel.com>
	<20181112180203.lx72gjfplb6xlur7@wunner.de>
	<20181113105636.GB11202@e107981-ln.cambridge.arm.com>
	<20181113112700.GT2500@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181113112700.GT2500-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 01:27:00PM +0200, Mika Westerberg wrote:

[...]

> > To be frank the concept (and Microsoft _DSD bindings) seems a bit vague
> > and not thoroughly defined and I would question its detection at
> > PCI/ACPI core level, I would hope this can be clarified at ACPI
> > specification level, at least.
> 
> I guess that is the way they envision to use _DSD. Instead of having
> single UUID that covers all properties (like what we have with device
> properties) they have one UUID per property "class". I certainly hope we
> don't need to keep extending prp_guids[] array each time they invent
> another "class" of properties.

It is even worse than that. This is a unilateral/obscure change that
won't be part of ACPI specifications (I guess it was easier to add a
UUID than add this to the ACPI specifications through the AWSG) but it
is still supposed to be applicable to ACPI PCI bindings on any
platforms/arches; this way of adding bindings does not work and it
has to be rectified.

Lorenzo
