From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 11:02:45 +0200
Message-ID: <20140521090244.GB19268@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<5123714.0MpMQfsmcr@wuerfel> <20140521081608.GA11068@ulmo>
	<4506822.XX7GrvtHhk@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4146369168205019524=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4506822.XX7GrvtHhk@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4146369168205019524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2014 at 10:54:42AM +0200, Arnd Bergmann wrote:
> On Wednesday 21 May 2014 10:16:09 Thierry Reding wrote:
> > On Tue, May 20, 2014 at 10:31:29PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 20 May 2014 16:00:02 Thierry Reding wrote:
> > > > On Tue, May 20, 2014 at 03:34:46PM +0200, Arnd Bergmann wrote:
> > > > > On Tuesday 20 May 2014 15:17:43 Thierry Reding wrote:
> > > > > > On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > > > > > > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
> > > > > > [...]
> > > > > > > > Couldn't a single-master IOMMU be windowed?
> > > > > > >=20
> > > > > > > Ah, yes. That would actually be like an IBM pSeries, which ha=
s a windowed
> > > > > > > IOMMU but uses one window per virtual machine. In that case, =
the window could
> > > > > > > be a property of the iommu node though, rather than part of t=
he address
> > > > > > > in the link.
> > > > > >=20
> > > > > > Does that mean that the IOMMU has one statically configured win=
dow which
> > > > > > is the same for each virtual machine? That would require some o=
ther
> > > > > > mechanism to assign separate address spaces to each virtual mac=
hine,
> > > > > > wouldn't it? But I suspect that if the IOMMU allows that it cou=
ld be
> > > > > > allocated dynamically at runtime.
> > > > >=20
> > > > > The way it works on pSeries is that upon VM creation, the guest i=
s assigned
> > > > > one 256MB window for use by assigned DMA capable devices. When th=
e guest
> > > > > creates a mapping, it uses a hypercall to associate a bus address=
 in that
> > > > > range with a guest physical address. The hypervisor checks that t=
he bus
> > > > > address is within the allowed range, and translates the guest phy=
sical
> > > > > address into a host physical address, then enters both into the I=
/O page
> > > > > table or I/O TLB.
> > > >=20
> > > > So when a VM is booted it is passed a device tree with that DMA win=
dow?
> > >=20
> > > Correct.
> > >=20
> > > > Given what you describe above this seems to be more of a configurat=
ion
> > > > option to restrict the IOMMU to a subset of the physical memory for
> > > > purposes of virtualization. So I agree that this wouldn't be a good=
 fit
> > > > for what we're trying to achieve with iommus or dma-ranges in this
> > > > binding.
> > >=20
> > > Thinking about it again now, I wonder if there are any other use cases
> > > for windowed IOMMUs. If this is the only one, there might be no use
> > > in the #address-cells model I suggested instead of your original
> > > #iommu-cells.
> >=20
> > So in this case virtualization is the reason why we need the DMA window.
> > The reason for that is that the guest has no other way of knowing what
> > other guests might be using, so it's essentially a mechanism for the
> > host to manage the DMA region and allocate subregions for each guest. If
> > virtualization isn't an issue then it seems to me that the need for DMA
> > windows goes away because the operating system will track DMA regions
> > anyway.
> >=20
> > The only reason I can think of why a windowed IOMMU would be useful is
> > to prevent two or more devices from stepping on each others' toes. But
> > that's a problem that the OS should already be handling during DMA
> > buffer allocation, isn't it?
>=20
> Right. As long as we always unmap the buffers from the IOMMU after they
> have stopped being in use, it's very unlikely that even a broken device
> driver causes a DMA into some bus address that happens to be mapped for
> another device.

I think that if buffers remain mapped in the IOMMU when they have been
deallocated that should be considered a bug.

Thierry

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfGu0AAoJEN0jrNd/PrOhMaEP/3U9wYaiRJENl/qkdrq9JmXA
dIXncqJqMIPhM28PozMRPib9Eb0jiMLBKit0nweuhn2JdwujKqgOoZ412vYefMaw
baYXUgwoemsQGzJSUGegqYVSiCLfCswO05sZodgvjdlViKqEcU2ajSxQtnZHU6LC
xEiZu2E2BTq/AM0kKLk0MKv/2U9zYzwcYRKTgqUKrktQ0Hgyth/kxWNWJUp5XLl5
nEDd/Cpz6AOhOx3M+CHhJIo540ElZIaLji6lkhTi45Or5F7Fj2LDr7Q8zUPZslwX
1S6LA7ooGyAS5TfeJw/gBA+q3fzl8vLk2EH/LeNHybtEanV+31n0tymTEXcOLzCG
9gMWdnOozhDnEvu+vVmDZSIYRV4FGGShElSHFT7f/xuzupKHCGeHTAt71a0eDRAE
cItHgWvxyjE5dYVhWKtShsR7xrIkSKT0XJADyUFDzyi/eU1GBd6WgFyQAk0XKOf/
fMkWlbdEd9uIyNJWsJseB9p/AxYQcYDprd9HIyUisVnZqjSqW/3ycYxF5bMqrptl
onNks9Vzg+7tUKZPtYdHaeuus8IHuOGiCOZ+TRVyanri/zIre5h8tSRwbZQKl08O
ztrRuEtTmbd39HV4dlutDnqrPNU2KdHNiDMZtBz4U5AkAxZLLZ+pYTCHsZlCYf6i
hqAuw8SlkAvnE1KjpKBg
=NkWI
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============4146369168205019524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4146369168205019524==--
