Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED914885B
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840962; cv=none; b=EgejB+2Ts7P++KY4TUmg3oBZ4POdDg6FbkWuz5HoK4pMc4QBHi7csvp4cvypxshC1ZLkhAOrp6wybxYIC96UjTyzcB4sykTYpBuevkTbY114jtgY8WqA4iLnBWm6UAPVEcuI6+5sotmT9/Vn9b/XDYhcYlzQMnTs19aSlr7v7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840962; c=relaxed/simple;
	bh=lMZ78FPtFBZxV+m67TF6REJkpUacIal4PFWF+mQQGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTYYAajtaZe689Mxiws86iPEp1A7jiwDXC4VAVbBJ1uR0jbvMkFfNN5gvwvJTGrzPjViRIsj6YurCqBO2K5D9LOG8uDJbhudUz2MrX6vrhVcpkYT3ypI5DhTHhxcITglO1XBvF8rn8eEhgxw+sgrr7atruglqbLgH5LaTd5CRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 589F65F8AF;
	Mon,  2 Jun 2025 07:09:12 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
Date: Mon, 02 Jun 2025 07:09:06 +0200
Message-ID: <2784838.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To:
 <CAHk-=wh4qRwm7AQ8sBmQj7qECzgAhj4r73RtCDfmHo5SdcN0Jw@mail.gmail.com>
References:
 <aDmght5YpHmJ6qZ2@8bytes.org>
 <CAHk-=wguPX5w3UVmQpOk+v1ahJwRzRNXKHUJB92cwJfNpMU4ZA@mail.gmail.com>
 <CAHk-=wh4qRwm7AQ8sBmQj7qECzgAhj4r73RtCDfmHo5SdcN0Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12677247.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12677247.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.16
Date: Mon, 02 Jun 2025 07:09:06 +0200
Message-ID: <2784838.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

On Samstag, 31. Mai 2025 07:20:02 Mitteleurop=C3=A4ische Sommerzeit Linus T=
orvalds=20
wrote:
> On Fri, 30 May 2025 at 21:57, Linus Torvalds
>=20
> <torvalds@linux-foundation.org> wrote:
> > Bah. This seems very broken.
> >=20
> > I haven't bisected it, but my arm64 build - which I sadly didn't end
> >=20
> > up doing earlier today - breaks with modpost errors:
> >    ERROR: modpost: "arm_smmu_make_cdtable_ste"
> >=20
> > [drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.ko] undefined!
>=20
> Ok, bisected to commit e436576b0231 ("iommu: make inclusion of
> arm/arm-smmu-v3 directory conditional").
>=20
> Which explains why I didn't see any obvious code changes that would
> explain that.
>=20
> This is with a plain "make allmodconfig" build, and I think the issue
> is that CONFIG_ARM_SMMU_V3 is 'm', not 'y', and the change didn't take
> that modular case into account at all.
>=20
> I'll revert it, but I'll wait until tomorrow to see if somebody has an
> alternative fix.

Sorry for the mess. Arnd Bergmann already has a fix sent, looks like it got=
=20
stuck somewhere.

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart12677247.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaD0x8gAKCRCr5FH7Xu2t
/KfyA/wPOfD5Mbr32oD0if+5JoaXI68IZAz3HHxDbBraW8JhmasIP98eX0M853IE
YWn6VsR+eX0zEQX0JBmRR1iZzHh4FWC37ZkEWPy7LiZRtK43OnIpTYNshD42vgPE
vpmMVVBOWdnsQJfZ7xrPB/zvNcMDmsbThbHIRgPiGWaUu2c9Qw==
=NtdT
-----END PGP SIGNATURE-----

--nextPart12677247.O9o76ZdvQC--



