From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Date: Tue, 05 Nov 2013 19:59:14 +0100
Message-ID: <1675842.yXNSE5Ofkv@avalon>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1652955.Gs3XDiEUHO@avalon> <20131030162854.GB2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3532503.p6jxkR2r3G"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131030162854.GB2493@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--nextPart3532503.p6jxkR2r3G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 30 October 2013 09:28:54 Mark Brown wrote:
> On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:
> > > For similar reasons as x86, can we please think about using:
> > > 	depends on ARM
> > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST
> > 
> > I'm fine with your proposed option. As I don't want to respin the series
> > dozens of time let's first agree on the course of action, I will then
> > repost the patches. Mark, you've pushed towards as few platform
> > dependencies as possible, what's your opinion on this ?
> 
> In general I think we should have whatever the real depedencies are or
> COMPILE_TEST (to the extent that they will actually build cleanly on
> other targets).  That way only people who explicitly go looking to
> compile test things for build coverage (eg, when doing global cleanups
> or API updates) need to be bothered by the extra compile test options.
> 
> I'd read the above as saying the code needs ARM to build at all and that
> the hardware will only ever appear on SHMOBILE.

That's my reading as well, and it makes sense to express it that way to me. 
I'll resubmit the whole series (minus the patches that have been applied 
already, I'll fix those in follow-up patches) with the dependencies expressed 
that way.

-- 
Regards,

Laurent Pinchart

--nextPart3532503.p6jxkR2r3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSeUAHAAoJEIkPb2GL7hl1PzUH/0y1fkbssjggEqaAGuDWBStl
K7b1v4BRNnGx+mFpgHNWiKtTt5uk1njHkgLY5/3O0ap7cFCt7upnfmQSxua1fGec
Wg1HujmXERMdRxHPOptDvC1qqx0mklD51q7QtPsCBknVJj7PdBcy7X/bGdviYsl9
0w5DARzJfhnhHiqWVbJgT3d/clY5SfQwlZRSIwcboXVMEG/jBRnNAYS3hgKaZaH/
YhtZFWL7zXJIMVv3FQpn2gdzL2LdkAgBlU/Ht3D334xQAaUpNiB0g5mS6Qczc1iK
q8GxP6bvLqrtLv8fd1szCbyx2OOlUQih4OgvAV1AyWE6PpOYUexN8LZLqOkP+Aw=
=jD+K
-----END PGP SIGNATURE-----

--nextPart3532503.p6jxkR2r3G--

