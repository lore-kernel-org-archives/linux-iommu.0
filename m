From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
	6e4bf5867783)
Date: Fri, 6 Apr 2018 02:14:18 +0100
Message-ID: <20180406011418.GE12349@sirena.org.uk>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7870030099439641071=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180405205657.GA1788-SGhQLRGLuNwb6pqDj42GsMgv3T4z79SOrE5yTffgRl4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7870030099439641071==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
> Christoph,
>=20
> unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
> dmesg diff between fec777c385b6 and 6e4bf5867783:

Adding Vinod and Pierre from Intel in case they have any ideas here.
Which model of XPS13 is this (2015?)?

> -sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> -haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/Intc=
PP01.bin failed with error -2
> -haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not ava=
ilable(-2)
> -haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info=
: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b67=
72b23c7c983ce9dcb18a19
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mappin=
g ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mappin=
g ok
> -input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwe=
ll-audio/sound/card1/input15
> +broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered

> So it seems that sst-acpi is unhappy with this patch. Any ideas?

> Thanks,
> 	Dominik

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrGyekACgkQJNaLcl1U
h9CJoAf/TS90luzysqHpT36oUysr/MHhMQwatcObYyEFVwhYzJfWy3B0HlpFmh6A
nNsqRFbXDA8K6s7e4vewIKkke/v9lezzsuTFn5UYemwZinJzl5+LUSHWC6bmXHwt
4TKdW36F8BSD2s4nXaxxo1U+bqrtoR6h1UtvRJao4lLhbJ8pY08dK9m8BJx4ozzu
3rwb2RcZsoV+5aTJmYW3Iq4S9i5cbhBpsMo4EfKM8fM3Rf/vsHhp8o/ZErvyt8py
TSw8MoyUPwNqLxswlV5tZf6wFZ92/YI8vbMOJoeRmJEFi3xOX1AV3HQQXw62jbe5
U6I1OT9IpZcE+/kSgiEX7/CgJ6L0Lw==
=6dLs
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

--===============7870030099439641071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7870030099439641071==--
