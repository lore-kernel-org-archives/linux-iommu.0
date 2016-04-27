From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Wed, 27 Apr 2016 16:37:04 +0300
Message-ID: <20160427153345-mutt-send-email-mst@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
 <20160421135416.GE11775@citrix.com>
 <1461759501.118304.149.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461759501.118304.149.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wei Liu <wei.liu2@citrix.com>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Amit Shah <amit.shah@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 27, 2016 at 01:18:21PM +0100, David Woodhouse wrote:
>=20
> > > On some systems, including Xen and any system with a physical dev=
ice
> > > that speaks virtio behind a physical IOMMU, we must use the DMA A=
PI
> > > for virtio DMA to work at all.
> > >=C2=A0
> > > Add a feature bit to detect that: VIRTIO_F_IOMMU_PLATFORM.
> > >=C2=A0
> > > If not there, we preserve historic behavior and bypass the DMA
> > > API unless within Xen guest. This is actually required for
> > > systems, including SPARC and PPC64, where virtio-pci devices are
> > > enumerated as though they are behind an IOMMU, but the virtio hos=
t
> > > ignores the IOMMU, so we must either pretend that the IOMMU isn't
> > > there or somehow map everything as the identity.
> > >=C2=A0
> > > Re: non-virtio devices.
> > >=C2=A0
> > > It turns out that on old QEMU hosts, only emulated devices which =
were
> > > part of QEMU use the IOMMU.=C2=A0 Should we want to bypass the IO=
MMU for such
> > > devices *only*, it would be rather easy to detect them by looking=
 at
> > > subsystem vendor and device ID. Thus, no new interfaces are requi=
red
> > > except for virtio which always uses the same subsystem vendor and=
 device ID.
>=20
> Apologies for dropping this thread; I've been travelling.
>=20
> But seriously, NO!
>=20
> I understand why you want to see this as a virtio-specific issue, but
> it isn't. And we don't *want* it to be.
>=20
> In the guest, drivers SHALL use the DMA API. And the DMA API SHALL do
> the right thing for each device according to its needs.
>=20
> So any information passed from qemu to the guest should be directed a=
t
> the platform IOMMU code (or handled by qemu-detection quirks in the
> guest, if we must).
>=20
> It is *not* acceptable for the virtio drivers in the guest to just
> eschew the DMA API completely, triggered by some device-specific flag=
=2E
>=20
> The qemu implementation is, of course, monolithic. In qemu the fact
> that virtio doesn't get translated by the emulated IOMMU *is* actuall=
y
> down to code in the virtio implementation. I get that.
>=20
> But then again, it's not just virtio. *Any* device which we emulate f=
or
> the guest could have that same issue, and appear as untranslated. (An=
d
> assigned PCI devices currently do).
>=20
> Let's think about the parallel with a system-on-chip. Let's say we ha=
ve
> a peripheral which got included, but which was wired up such that it
> bypasses the IOMMU and gets to do direct physical DMA. Is that a
> feature of that specific peripheral? Do we hack its drivers to make t=
he
> distinction between this incarnation, and a normal discrete version o=
f
> the same device? No! It's a feature of the *system*

One correction: it's a feature of the device in the system.
There could be a mix of devices bypassing and not
bypassing the IOMMU.

> and needs to be
> conveyed to the OS IOMMU code to do the right thing. Not to the drive=
r.
>=20
> In my opinion, adding the VIRTIO_F_IOMMU_PLATFORM feature bit is
> absolutely the wrong thing to do.
>=20
> What we *should* do is a patchset in the guest which both fixes virti=
o
> drivers to *always* use the DMA API, and fixes the DMA API to DTRT at
> the same time =E2=80=94 by detecting qemu and installing no-op DMA op=
s for the
> appropriate devices, perhaps.

Sounds good. And a way to detect appropriate devices could
be by looking at the feature flag, perhaps?


> Then we can look at giving qemu a way to properly indicate which
> devices it actually does DMA mapping for, so we can remove those
> heuristic assumptions.
>=20
> But that flag does *not* live in the virtio host=E2=86=90=E2=86=92gue=
st ABI.
>=20
> --=20
> David Woodhouse                            Open Source Technology Cen=
tre
> David.Woodhouse@intel.com                              Intel Corporat=
ion
>=20
