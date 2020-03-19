Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA90C4332D
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 15:38:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA7E20775
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 15:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA7E20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lespocky.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 203F286C8C;
	Thu, 19 Mar 2020 15:38:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FuL8aOp8o_e9; Thu, 19 Mar 2020 15:38:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FD7686C37;
	Thu, 19 Mar 2020 15:38:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8074AC18DA;
	Thu, 19 Mar 2020 15:38:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6B35C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E00D186C76
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aaP1EeSn8max for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 15:37:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9592886C37
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:37:57 +0000 (UTC)
Received: from methusalix.internal.home.lespocky.de ([92.117.55.187]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCKd-1ijxzP1qAz-00VCg6; Thu, 19 Mar 2020 16:32:02 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
 by methusalix.internal.home.lespocky.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <post@lespocky.de>)
 id 1jEx9I-0001AW-FT; Thu, 19 Mar 2020 16:31:58 +0100
Date: Thu, 19 Mar 2020 16:31:55 +0100
From: Alexander Dahl <post@lespocky.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20200302181612.20597-1-post@lespocky.de>
 <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
MIME-Version: 1.0
In-Reply-To: <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 5d1699e822705c24f051c25a2c63fb4e
X-Provags-ID: V03:K1:cXX8UFKkqY3BP0w/SJ8Qky/hBe1VOgQfSpYwQ3wWO3BhAMLQKyT
 qMaCMxG5eW95fMiDqh86DxQy+xspNijXV4Q3uJ1/OI25ImFc4FxujtbJ11u+AQ1gGV567ka
 pcuaaUtu2xqpMHk3muaoI2tLNhKeqTojiZ1uCBrHHAl9y/bMVqkPNIiNpzrYyA07rXYKshv
 vDCZ3jgc70lqvX/wcAadg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AVHi2LwLXRc=:6nX6fzdQolBz3ZqpdSgS44
 PLE9Aa3gEcsF/Gdg7Homz8n5CIsWifAktiQ9ostnH2SHpXD3cs9VE/Cnx6FGBrh1G5uMuS0YN
 pRSEwTn5vN00cWD90RRkNSOGhJiAs/8mWQqYfIf724kGDYu3EjNincEdglOR0CfDXOj0qF7kx
 tB+oqXXN8is5al+YLrpxHPbDW5Tlvq4k+Pe8FEi3D1iGTjBlU6xxVQV64GZy/h//sSfkCQZzx
 9E/sjF8Z2yNxB1tcJU8Oh/9dDQc2iPTw3oWahrsW29AoRi2uAorNl2TBK88QjyfafRDWF6ilf
 a5Vt+kdtk1CM0kw5m9cgIkQ+Eg/UZXbxjYrjNdWR+jbg8z+uQufo13CTMv9gU3v73+NXeyRDw
 o2XsYOxPcjicOmsasZz0b7W502t7LRs18dYIeA7DMLySpgwTzBqIDlSYbeSxMmPs8f20W0AAD
 lnLKa8wr2GrkopGkj8BaYCP1mP5WB8KBCZujEZEeilagA/L0bB+92Z04MKBK2i03wuCc7cn0n
 3cUYVW4lbrCJ6ZmO/tuFUufL/Ziw4fDNdVAHpff8NaKr8iXhDN0VQATyDwlKoWUEm6CP6qxCr
 iVeSf1ILVgoRQPNajR4gFOIz+CnLvobC3uCVsxkiFkEB4yO/3XMf9wj4QTzg9N8OvGIoqvD4U
 tqTpaWsEwBcu8SHilLRoq6hSIkyGYbbEq5jtCBnKPvs+5iSRtgZwQWBD7qPufFWtQqlbdV3Ej
 L+9ot3TQHG7e9ZPczh+uWrMM4GvZIgEiy9AHti+BGlSBJTCQ/WlHxXboOxI9nu7GJ0DtygsnG
 Syej6QVd9UsseE25GloYILsqyeZB0TDv+O+2UpZkVGJo+FwLXofQfI1phtyzgd6NkfuQFzJ
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Alexander Dahl <post@lespocky.de>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5844684488520254265=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5844684488520254265==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iodayy4zmltei4qo"
Content-Disposition: inline


--iodayy4zmltei4qo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Robin,

On Thu, Mar 19, 2020 at 01:50:56PM +0000, Robin Murphy wrote:
> On 2020-03-02 6:16 pm, Alexander Dahl wrote:
> > ---
> >   arch/x86/include/asm/dma.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> > index 00f7cf45e699..e25514eca8d6 100644
> > --- a/arch/x86/include/asm/dma.h
> > +++ b/arch/x86/include/asm/dma.h
> > @@ -74,7 +74,7 @@
> >   #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> >   /* 4GB broken PCI/AGP hardware bus master zone */
> > -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> > +#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))
>=20
> FWIW, wouldn't s/UL/ULL/ in the original expression suffice? Failing that,
> rather than awkward parenthesis trickery it might be clearer to just copy
> the one from arch/mips/include/asm/dma.h.

Both of your suggestions yield the correct result, and at least for me
both look easier to understand than what Alan proposed in the first
place.=20

I would opt for the variant which is already in arch/mips, because it
avoids 64 bit calculation, is most obvious in intent in my eyes, and
we have the same calculation twice then instead of two variants.

Thanks for your review, I'll send a v2. :-)

Greets
Alex

--=20
/"\ ASCII RIBBON | =BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--iodayy4zmltei4qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl5zkGYACgkQNK3NAHIh
XMZVuBAAiot7wus5KYr1BSz88DPoujOTs5xhPjApYgOx9xpEOlKq1GmMXbiiumEX
U55+iU1afQEvSNJbHrsaLDtWxOQtWcZOuQcBCCBE7s6+fZQ21IbdoxqUlnurMZcm
O1nAoNxqQ+IzKVsQk2g7M5LKZZpZe0xHQNrBw/Jkhwx1ePLAuJRYNzWlV2zTE533
0UiNmWQweS4tUleXtne8ErWWCyq9Gic2wtK+IMApvbG6iHbhjIggOIDzLWFUB+Zm
67KWFhKT/rbLDjT1dx4FsTw1Lve0zk2/I+nPMUpXs2uSX7vHsR0nymZ/UQrD6u+C
vIqfa3RbgBFB+McCqFDPgJIuvA0/MsXujHnSDdGjltWqVPsOcd8MV8uEi8FfZoPE
1n/29F+wSMmgi1GB2uV+mBC8/uKzzFGr2r42P1OhJwieKW7sxyigC9v+IlLPm2hE
8LxN9B9It0GViBTYt6IfyD6XDOEjFwE/e8FlhzyRBj2Bn6vsqzwSLTjBxgjxEtLg
VuGSBjCCHc9vxZ/gfIOeDzQxiBKX7DiwtbuEG4VjcIqJWOgdX9h6Un2aG8H2tXhs
q5FVUtb1IcEAKIwd+ESXGSuwvBDIP6jdl9JGKk/MhEg2THpCH3zLgZE3z1kabVE2
DSdbRJnZuf5xz7+R45KBCXI3Vyjr4o1EluQgH+kM84Es/TKIzGU=
=LvT4
-----END PGP SIGNATURE-----

--iodayy4zmltei4qo--

--===============5844684488520254265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5844684488520254265==--
