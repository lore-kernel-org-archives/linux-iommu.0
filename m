Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E151FECB1
	for <iommu@lists.linux.dev>; Mon, 19 May 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635419; cv=none; b=ncCF16VJ9A+2CXmfwxXoAGqFDvt0LKr9ovJZtYVMcavqKdSX22wko59kvr0WZUG9GK/rGCKGKgkD+C0qOg/+Rn+CnBLe9WQRIa/KnJIt69/Yg1ZWlgaVuc0F0rjsFOvgBtXqgHBDKjGumpU8GqDb4uA4KaLcor7V/zApMUh92Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635419; c=relaxed/simple;
	bh=f+ghl9HUmV6Tg7G6saf/pELhUkFnmClKpc3fN4KNYDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKHdVG8fymq/UQXKGYqjFackbYk1jHNfKbSd2Mke6xItjhd3afR3ybCeVftrujW41nEgNcxtoUSs2jSTX1HDbrURtOSMw5hNDW9VyXvbyPhzYizQpXD6YVrWX7i2s3bfkdgdOETHeGT1fThbSLwqlFm4Esf1WxWuZ5ZBAXfVWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id E143E5F937;
	Mon, 19 May 2025 08:16:48 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Subject:
 Re: [PATCH 6/6] iommu: make inclusion of iommufd directory conditional
Date: Mon, 19 May 2025 08:16:39 +0200
Message-ID: <2782498.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aCc0-ClDbiUpNUgh@8bytes.org>
References:
 <1926170.CQOukoFCf9@devpool92.emlix.com>
 <5568089.Sb9uPGUboI@devpool92.emlix.com> <aCc0-ClDbiUpNUgh@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12668088.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12668088.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Mon, 19 May 2025 08:16:39 +0200
Message-ID: <2782498.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aCc0-ClDbiUpNUgh@8bytes.org>
MIME-Version: 1.0

On Freitag, 16. Mai 2025 14:52:08 Mitteleurop=C3=A4ische Sommerzeit Joerg R=
oedel=20
wrote:
> On Mon, May 12, 2025 at 03:15:52PM +0200, Rolf Eike Beer wrote:
> > Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the who=
le
> > directory can depend on that switch as well.
> >=20
> > Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and
> > makefiles") Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Had to remove this patch from the branch as it caused compile breakage
> with allmodconfig builds.

I did not catch that this is a tristate, not a bool. The same happens for=20
patch 5, which is what the 0-day bot has reported.

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
--nextPart12668088.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaCrMxwAKCRCr5FH7Xu2t
/K/KBAC993BYydA8im/ZNUxEqiptuFBivFH9cqeX9o+RMEpcIVGElgOM0rwZmL7K
djVmNqPN3/Q28Zon5V6OwjO9fGjtp5rdfhMceOeOS8v5pbvXw0QnoW/idBX8qhiB
lYMld3fWr8YVspYhggu8iLrEzuiFSnTqryVzX4/q5wuk0JyjTA==
=K5sl
-----END PGP SIGNATURE-----

--nextPart12668088.O9o76ZdvQC--



