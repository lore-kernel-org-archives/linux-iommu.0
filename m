From: Yehezkel Bernat <yehezkelshb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date: Mon, 12 Nov 2018 21:04:08 +0200
Message-ID: <CA+CmpXt4cZJRoo8U=pMt7Y65oLpXwpr2oVgbxuFj8C-SU6yZnA@mail.gmail.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
	<20181112181214.xaahc5wni4vuwl6h@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>, michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 8:12 PM Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
>
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
> Won't this suddenly break with these patches? That would seem like a
> pretty significant regression.

My assumption is that either it isn't supported on such platforms (at least with
this security configuration active) so this doesn't break anything, it never
worked there, or the BIOS configures IOMMU in a way that allows the disk to work
until the OS will take control and configure the IOMMU according to OS
decisions.
In the latter case, the kernel+initrd will be loaded before IOMMU configuration
will be changed, and then the kernel should be able to config it correctly to
work. (Unless I really don't understand the mechanism and workflow of using
IOMMU, which is possible.)
