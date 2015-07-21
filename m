From: Joerg Roedel <joro@8bytes.org>
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
Date: Tue, 21 Jul 2015 18:30:58 +0200
Message-ID: <20150721163058.GF10969@8bytes.org>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com>
 <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AE7147.7070902@maya.org>
Sender: linux-pci-owner@vger.kernel.org
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-pci <linux-pci@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 21, 2015 at 06:20:23PM +0200, Andreas Hartmann wrote:
> Hi J=F6rg,
>=20
> I attached the dmesg output of the boot seuqence. This time after
> reboot, the amount of IO_PAGE_FAULTs is not that much, but now, I got=
 a
> few ata3.00 errors.
>=20
>=20
> Am 21.07.2015 um 17:56 schrieb Joerg Roedel:
> > Hi Andreas,
> >=20
> > On Tue, Jul 21, 2015 at 09:34:46AM -0600, Alex Williamson wrote:
> >>> Since Linux 4.1, I'm getting a lot of IO_PAGE_FAULT like this one
>=20
> To be more precise: The last kernel w/o this problem is 3.18.x - I ne=
ver
> used 3.19 or 4.0.

Hmm, so you don't know whether 3.19 and 4.0 show the same problems? Can
you find that out eventually? I look into your dmesg in the meantime.


	Joerg
