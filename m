From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date: Tue, 13 Nov 2018 13:13:36 +0200
Message-ID: <20181113111336.GS2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112181214.xaahc5wni4vuwl6h@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181112181214.xaahc5wni4vuwl6h-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 07:12:14PM +0100, Lukas Wunner wrote:
> On Mon, Nov 12, 2018 at 07:06:24PM +0300, Mika Westerberg wrote:
> > Recent systems shipping with Windows 10 version 1803 or newer may be
> > utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
> > different from the previous security level based scheme because the
> > connected device cannot access system memory outside of the regions
> > allocated for it by the driver.
> > 
> > When enabled the BIOS makes sure no device can do DMA outside of RMRR
> > (Reserved Memory Region Record) regions. This means that during OS boot,
> > before it enables IOMMU, none of the connected devices can bypass DMA
> > protection for instance by overwriting the data structures used by the
> > IOMMU. The BIOS communicates support for this to the OS by setting a new
> > bit in ACPI DMAR table [1].
> > 
> > Because these systems utilize an IOMMU to block possible DMA attacks,
> > typically (but not always) the Thunderbolt security level is set to "none"
> > which means that all PCIe devices are immediately usable. This also means
> > that Linux needs to follow Windows 10 and enable IOMMU automatically when
> > running on such system otherwise connected devices can read/write system
> > memory pretty much without any restrictions.
> 
> What if the system is booted from a Thunderbolt-attached disk?
> Won't this suddenly break with these patches?

Like Yehezkel commented, it either is not supported or alternatively it
is (the BIOS/boot loader utilizes IOMMU as well), loads the OS image and
what is needed from the disk, disables BME (bus mastering enable) and
resets the IOMMU back to the default state before handing over to the OS.

> That would seem like a pretty significant regression.  What if the
> only GPU in the system is Thunderbolt-attached?  Is it possible to
> recognize such scenarios and automatically exempt affected devices
> from IOMMU blocking?

"IOMMU blocking" does not mean that the device cannot be used at all. It
actually means that the device is immediately usable and can do DMA as
the driver has programmed (using DMA-API) but it cannot access any
memory outside of those regions the driver has programmed.

The point of this exercise is to prevent so called drive-by DMA attacks
where you go to take a cup of coffee and during that time someone plugs
in a malicous device to Thunderbolt port of your laptop and reads all
your secrets.

When IOMMU is enabled the malicous device still is usable (assuming
there is driver for it) but it cannot go and read all the memory, just
the memory driver has programmed.

So in your GPU case it should just work assuming the GPU has a driver.
