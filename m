From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Wed, 28 Nov 2018 12:24:27 +0100
Message-ID: <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com> <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
 <20181128105415.GV2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128105415.GV2296@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamso>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 28, 2018 at 11:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Nov 27, 2018 at 06:14:43PM +0100, Rafael J. Wysocki wrote:
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 8c7c4583b52d..4bdad32f62c8 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
> > >         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> > >         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> > >                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> > > +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> > > +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> > > +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> > >  };
> >
> > One observation here.  Note that I really have no strong opinion on
> > that, so this is not an objection, but IMO it is fair to make things
> > clear for everybody.
> >
> > So this causes the External facing port GUID (which already is the
> > case with the Hotplug in D3 GUID for that matter) to be practically
> > equivalent to the ACPI _DSD device properties GUID.  This means that
> > Linux will consider a combination of any of these GUIDs with any
> > properties defined for any of them as valid, which need not be the
> > case in Windows.
> >
> > For example, since the ExternalFacingPort property is defined along
> > with the External facing port GUID, Windows will likely ignore it if
> > it is used in a combination with the Hotplug in D3 GUID or the ACPI
> > _DSD device properties GUID.  If the firmware combines the Hotplug in
> > D3 GUID or the ACPI _DSD device properties GUID with that property,
> > Windows will not regard it as valid, most likely, but Linux will use
> > it just fine.  In the face of ASL bugs, which are inevitable (at least
> > just because ASL is code written by humans), that may become a real
> > problem, as systems successfully tested with Windows may not work with
> > Linux as expected and vice versa because of it.
>
> That's a fair point.
>
> > >From the ecosystem purity perspective this should be avoided, but then
> > I do realize that this allows code to be re-used and avoids quite a
> > bit of complexity.  The likelihood of an ASL bug that will expose this
> > issue is arguably small, so maybe it is not a practical concern after
> > all.
>
> One option assuming we want to prevent the potential discrepancy you
> described above is to add ACPI specific property accessors that take
> GUID as parameter. Then it would only look properties inside that
> particular _DSD entry. I'm not sure if it is worth the added complexity,
> though.

I'm not sure if this is worth the extra complexity either, which is
why I have no strong opinion here. :-)

Maybe you can add a comment, next to the prp_guids[] definition, to
explain that the GUIDs are made equivalent to each other in order to
avoid extra complexity in the properties handling code, with the
caveat that the kernel will accept certain combinations of GUIDs and
properties that are not defined strictly speaking without warning, but
those combinations of GUIDs and properties are not expected to be used
by firmware and they should be caught by firmware validation tools and
reported as errors anyway.
