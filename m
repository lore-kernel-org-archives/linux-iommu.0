Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7422A7E9
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304302; cv=none; b=GNf0o1JMmg3fJ1fafFMLzOD127TSdsaUpOd85l4w+XAIv6Q/MGvU4wv1x77bgVfl0ms8haq8tBtc/Ul0Z2OG1dbZiT/jfDcMJmxOprQS3Wwv4XjBKVljkLYwjH1fw1YvWvlPBGikt3UFECw02h0gUbwmDQCzBA7r/FWL7fkXZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304302; c=relaxed/simple;
	bh=tiD+q2iLPecaXdqBIUQA6kHgOTtsV3xRVQmtbqKQgbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAmMqfjKlYxpjXZtVEZA81uAwgp0a7/97UN9EzU184KZtaBhsrla0Ll8oOLLn7j2zOcOql5lWyCAm/vgtktd3GVdid0CHLKa3t60IFuH6kXr/Avuk7LClvZFOeZW0Mm65+TXl6dmvCvwQwxfj529aICB2SyP+H/zWGKEIK0UUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 195285F86B;
	Tue, 22 Apr 2025 08:35:14 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
 Lu Baolu <baolu.lu@linux.intel.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject:
 Re: [PATCHv2 0/6] make vendor specific subdirectory inclusion conditional
Date: Tue, 22 Apr 2025 08:35:08 +0200
Message-ID: <2779144.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aAERFUJj_6NuxAv3@8bytes.org>
References:
 <12652899.O9o76ZdvQC@devpool47.emlix.com> <aAERFUJj_6NuxAv3@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12651545.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12651545.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Tue, 22 Apr 2025 08:35:08 +0200
Message-ID: <2779144.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aAERFUJj_6NuxAv3@8bytes.org>
MIME-Version: 1.0

On Donnerstag, 17. April 2025 16:32:53 Mitteleurop=C3=A4ische Sommerzeit Jo=
erg=20
Roedel wrote:
> On Thu, Mar 20, 2025 at 10:01:45AM +0100, Rolf Eike Beer wrote:
> > Changes in v2:
> > - clean up subdirectory Makefiles to use obj-y now
> > - add arm/arm-smmu-v3 and iommufd patches
>=20
> This conflicts with the core branch, can you please rebase once I pushed
> the updated tree?

Sure.
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
--nextPart12651545.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaAc4nAAKCRCr5FH7Xu2t
/Ho+A/98h1tQPHZhbsX2KdIBKcFTRVlxRJvscAWNQs5Bko1+iniOMO2sfq6HClPQ
7VC+G41TiMT5lg6jPBJqNlM8AXmA/dt85cmYSP0YuW+JRaE5aHfprhlJwjy7/o99
Yy23Gp0kOkRaa2sm/N32llKyzxpn14YxBKPR3GZm1c5IQhbsng==
=8mcp
-----END PGP SIGNATURE-----

--nextPart12651545.O9o76ZdvQC--



