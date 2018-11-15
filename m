From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 15 Nov 2018 19:33:54 +0000
Message-ID: <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
References: <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190054.GD4179@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: lukas@wunner.de, iommu@lists.linux-foundation.org, joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com, andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, ckellner@redhat.com, anthony.wong@canonical.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Thursday, November 15, 2018 1:01 PM
> To: Lorenzo Pieralisi
> Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob j=
un Pan;
> Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonc=
iello,
> Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.or=
g; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > Do you really need to parse it if the dev->is_thunderbolt check is enou=
gh ?
>=20
> Yes, we need to parse it one way or another. dev->is_thunderbolt is
> based on heuristics which do not apply anymore when the thing gets
> integrated in the SoC.
>=20
> The _DSD is there already (on existing systems) and is being used by
> Windows so I don't understand why we cannot take advantage of it? Every
> new system with Thunderbolt ports will have it.

Furthermore it's entirely in the BIOS writers best interest to do this corr=
ectly
as it applies proper policy on Windows as well.

I wouldn't be surprised if WHCK failed if it was done wrong.
