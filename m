From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Date: Tue, 12 Jun 2012 18:04:27 +0200
Message-ID: <20120612160427.GE2624@amd.com>
References: <20120611152021.25959.71601.stgit@bling.home>
 <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
 <20120612062000.GA6932@8bytes.org>
 <CAErSpo6J61+XhtEeXdE-5Evhs-SJ4=3iEZDAXGuRi9moAU8KhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6J61+XhtEeXdE-5Evhs-SJ4=3iEZDAXGuRi9moAU8KhQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, aik@ozlabs.ru, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, dwmw2@infradead.org, david@gibson.dropbear.id.au
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Tue, Jun 12, 2012 at 09:55:59AM -0600, Bjorn Helgaas wrote:
> On Tue, Jun 12, 2012 at 12:20 AM, Joerg Roedel <joro@8bytes.org> wrot=
e:
> > Hi Bjorn,
> >
> > On Mon, Jun 11, 2012 at 06:59:25PM -0600, Bjorn Helgaas wrote:
> >> On Mon, Jun 11, 2012 at 8:26 AM, Alex Williamson
> >> <alex.williamson@redhat.com> wrote:
> >> > v3:
> >> > =A0- Small change to device specific ACS check to allow quirk to
> >> > =A0 support yes/no/pass type functionality. (no change to other
> >> > =A0 patches and no trickle down through IOMMU series)
> >> >
> >> > Bjorn, what's needed to get these in? =A0Thanks,
> >>
> >> Sorry for the delay. =A0I applied these to my "next" branch (heade=
d for
> >> 3.6). =A0I didn't feel comfortable pushing them towards 3.5 since
> >> they're not bugfixes, and they haven't been in -next yet.
> >
> > Great. Do you applied them directly to your next branch or do you h=
ave
> > them in a seperate branch I can pull in to merge the IOMMU Groups
> > patches on-top? The later would be really good :)
>=20
> Hi Joerg, I have Alex's patches on a separate topic branch.  I folded
> in the pci_get_dev() fix and pushed it to here:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> topic/alex-vfio-prep
>=20
> This is also included in my "next" branch.


Great, thanks. I will pull in this branch and apply Alex' IOMMU group
code on-top.


	Joerg

--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632
