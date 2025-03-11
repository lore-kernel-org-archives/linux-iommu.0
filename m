Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129B23237C
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688167; cv=none; b=FrGp4AToL38vqoSudt9Qr9iS6KkJzXZWGrpsvAQJZLgEZ+JP9WatvfX6u+nQ3WjtLlg1ppPLva+jfUXiRb4bhrfy/heNtXejIK/AVP5PHnVcqgViMtl13U0OjGDyT0ho1s3MQHDNHeFSTwvD191CEAMHwLeqowVuSN5l9sgq6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688167; c=relaxed/simple;
	bh=l7N3lIPhG6mdsLNH9OgsXxQwn7RtsJGYnICoz2Cvqyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=om/YKNj2Do8MIo6zAN6EJnAAJM/4H1FW/i4TQ1FestVi47tlAHtxHQM93n8RiBisHVrp8AhOu09dTRrZRxAVkvgCeWSkVdlF5f+9AgqyDeKQamvVBqe9kLwnrtKmNYmhk1S+UgvC6Ruqe75SXtNq4lMuZ05b4t3ETXfsWQbUNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id A91915FFD3;
	Tue, 11 Mar 2025 11:15:26 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] make vendor specific subdirectory inclusion conditional
Date: Tue, 11 Mar 2025 11:04:31 +0100
Message-ID: <2301497.iZASKD2KPV@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1996534.PYKUYFuaPT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1996534.PYKUYFuaPT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 11:04:31 +0100
Message-ID: <2301497.iZASKD2KPV@devpool47.emlix.com>
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
=2D-=20
Rolf Eike Beer

We are nominated for the embedded award Visit us at the embedded=20
world 2025 March 11th to 13th, 2025 | Nuremberg Find us in hall 4 at=20
booth 336

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
--nextPart1996534.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZ9AKrwAKCRCr5FH7Xu2t
/JcNA/4t/tbF7kSeUHSlwCGN4/iZKNe0z7438EMg8dahTOCx+Y2B4NfrRo1+ax8Z
D8+3DWeiQh+X119CEQinAZDCBMhBdwL0UIHwYmQBczZrTk21BXn9+iUzNlfYsnqA
hUuedlulFcM6VNoF/1q9rz4/dgJ84FlKCHiJCEWm40yZhkRlVQ==
=gkz6
-----END PGP SIGNATURE-----

--nextPart1996534.PYKUYFuaPT--



