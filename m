From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Wed, 28 Nov 2018 12:54:15 +0200
Message-ID: <20181128105415.GV2296@lahna.fi.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
	<20181126111526.56340-2-mika.westerberg@linux.intel.com>
	<CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 27, 2018 at 06:14:43PM +0100, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 8c7c4583b52d..4bdad32f62c8 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
> >         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> >         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> >                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> > +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> > +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> > +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> >  };
> 
> One observation here.  Note that I really have no strong opinion on
> that, so this is not an objection, but IMO it is fair to make things
> clear for everybody.
> 
> So this causes the External facing port GUID (which already is the
> case with the Hotplug in D3 GUID for that matter) to be practically
> equivalent to the ACPI _DSD device properties GUID.  This means that
> Linux will consider a combination of any of these GUIDs with any
> properties defined for any of them as valid, which need not be the
> case in Windows.
> 
> For example, since the ExternalFacingPort property is defined along
> with the External facing port GUID, Windows will likely ignore it if
> it is used in a combination with the Hotplug in D3 GUID or the ACPI
> _DSD device properties GUID.  If the firmware combines the Hotplug in
> D3 GUID or the ACPI _DSD device properties GUID with that property,
> Windows will not regard it as valid, most likely, but Linux will use
> it just fine.  In the face of ASL bugs, which are inevitable (at least
> just because ASL is code written by humans), that may become a real
> problem, as systems successfully tested with Windows may not work with
> Linux as expected and vice versa because of it.

That's a fair point.

> >From the ecosystem purity perspective this should be avoided, but then
> I do realize that this allows code to be re-used and avoids quite a
> bit of complexity.  The likelihood of an ASL bug that will expose this
> issue is arguably small, so maybe it is not a practical concern after
> all.

One option assuming we want to prevent the potential discrepancy you
described above is to add ACPI specific property accessors that take
GUID as parameter. Then it would only look properties inside that
particular _DSD entry. I'm not sure if it is worth the added complexity,
though.
