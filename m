Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B0214A98
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463125; cv=none; b=gr//LVyxrcolOedi2/BerC8jgvnhj2TIFSEx8DzmN0PreVfn5G6OT8jzYWIHp7vW0PRpRdO5DQxsnDbKNS8dbyLdpwW/LXYMQU+oPdeOHx7VRW3j0ei7RMEHuywcie0bktovFoPi0MKzxaCoqyyfo8tLm05EoIikIZHD8g4TWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463125; c=relaxed/simple;
	bh=cP96Ga6Wb2QsqdS2mmypFULWz7tPrLEpp/5d+TrLzAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RtnL7zw1ds9Mg9lUHqqryT/BwF5lLWl1ZInb200nTH2Xm1iI1NFP2Mo1oEr/H4cWRQavhT6+oZlyUwhtJ/G1okEgGDJoFdzDd8uxJBdOxOfdsDSj9r3AYGNhY0ambW2Z8VfqlvRntaquj8HlPI8X8+VU0673tUqQxQbf7LFKRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id A88995FE16;
	Thu, 20 Mar 2025 10:31:12 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCHv2 0/6] make vendor specific subdirectory inclusion conditional
Date: Thu, 20 Mar 2025 10:01:45 +0100
Message-ID: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5893241.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5893241.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Date: Thu, 20 Mar 2025 10:01:45 +0100
Message-ID: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

I found it strange that the vendor specific subdirectories were uncondition=
ally=20
added. Everything in these directories obviously depends on the specific Kc=
onfig=20
option. This series cleans this up by making the directory itself depend on=
=20
the respective option which looks more natural to me.

I must confess that I am too lazy to find a good solution for the "arm/"=20
directory, so I left it as is.

Regards,

Eike

=2D--
Changes in v2:
=2D clean up subdirectory Makefiles to use obj-y now
=2D add arm/arm-smmu-v3 and iommufd patches
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
--nextPart5893241.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZ9vZeQAKCRCr5FH7Xu2t
/KzhBACEdmdr0bY0N6eQxB1byUc3X3h+0fMpnAPDybVl8uNLVdes2BnFk1VDMZCt
Etxao2Oyzq2vNJuDl8zYA8utbXiiIz0LeenQwyrVo1kgEev3GkJbqRwIkpyko3q/
K8Esb1BlIF85LDn81KbjQgi2YHG0fMEuRHID/dL2/4SUbTConw==
=+N/3
-----END PGP SIGNATURE-----

--nextPart5893241.DvuYhMxLoT--



