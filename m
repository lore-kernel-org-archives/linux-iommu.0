From: "Roedel, Joerg" <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Wed, 26 Sep 2012 15:20:50 +0200
Message-ID: <20120926132050.GB10549@amd.com>
References: <20120924210348.5f50677b@brain.lan>
	<1348597970.28860.114.camel@bling.home>
	<20120925205420.0a07dea2@brain.lan>
	<1348602226.28860.132.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348602226.28860.132.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 25, 2012 at 01:43:46PM -0600, Alex Williamson wrote:
> Joerg, any thoughts on a quirk for this?  Unfortunately we can't just
> skip IOMMU groups when an alias is broken because it puts the other
> IOMMU groups at risk that might not actually be isolated from this
> device.  It looks like we parse the alias info before PCI is probed, so
> maybe we'd need to call the quirk from iommu_init_device itself.

I fear that the BIOS does everything right and device 08:04.0 is indeed
using 08:00.0 as request-id. There are a couple of devices where this
happens, usually when the vendor just took the old 32bit PCI chip, added
a transparent PCIe-to-PCI bridge to the device and sell it a PCIe.

So the assumption that every request-id has a corresponding pci_dev
structure does not hold. I also had made that assumption in the
AMD IOMMU driver but had to add code which removes that assumption. We
should look for a way to remove that assumption from the group-code too.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
