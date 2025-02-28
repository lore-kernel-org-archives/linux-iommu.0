Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6217A5BE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765792; cv=none; b=IoNN3+yMids4sjycJYZ+zPCAX5ZS8fQ2elolYuMDGPhjHxCuiW+0O8V79Vr8qmsylIWc1zo5a4IVk1MLbgBouZ3MOiSfnsDNAHjz6Lsln8ipS8EyxN2x+Wak7Gexgy6XlRSrRAOofUEbKU6cJAGXWJDCi25zIh79A+3MxT6/0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765792; c=relaxed/simple;
	bh=G1RdgFYwYiv8OZYyj0ZW5nrkjWK977pB0/fDGk9nHiM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Gcazoe+/0DQqpkzDZ12xY7YNrxUQ8XoycMS3C3ZskiVbUiMQeQgTve7qfU6JFNZD/spI2CvxCsnqjff3jANAiUrpLR+enXZXhlMy1jC0H9FbqPMKzb95kWZB4QCJ8LpUbzIhAQ/dTnnZ4I0d/IxVFUb2hkbpX5RqnHuUFJZ5/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=w4EP1Dr4; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w4EP1Dr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740765768; x=1741370568; i=markus.elfring@web.de;
	bh=eK4M2CFdXyu5HI4LNXAJHZUld6l0gBUVOZFtbpGEcuM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=w4EP1Dr4nX7i1ypthZxZaqC6R8RKbvjT1tbSR5Sd9XcTggZJ3CoAP0PdZGtijFog
	 qKBQ93iiZHBzuSendP6hW5q76+n9GTq82pY8GYjCZOq2BXSVAEZlcRDok++N0Xsw1
	 jHboR3FEhgJqt+OmZJMs/cHOb6X4eiPCsssSi5NlgRWFkkDMZgPKVSQqkr1TEm5DV
	 VBR4j56vbl3P/0W/MrbjntSs3oNTaTf76kNW821GJOkC9yG+ZWngWnIwaKeT8PRoe
	 B+YKtAJ05q9X4UWRUzX51IQ5GXUIdqMuQ9ZMa3LO7obSvyrj51R+2S0KjskuBSCCw
	 Didtat45J3kGDz+ltA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1sx4XI2bgG-00rzh6; Fri, 28
 Feb 2025 19:02:48 +0100
Message-ID: <d1a384c9-f154-4537-94d6-c3613f4167bc@web.de>
Date: Fri, 28 Feb 2025 19:02:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Robin Murphy <robin.murphy@arm.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] iommu/riscv: Simplify maximum determination in
 riscv_iommu_init_check()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JhTdCVQrTH3pRqWkfDnqBWlut2oSUyDj0pt7WEcCMTNueMxWxYg
 JvvkBvFN/0ZMbF4W2dISPA1soxLiP4NNwwKMA/XAAj0qbmlpcKLANJy0EcVwmA+40xn5CP2
 Ad4v/QnlvWdYFNJAieE/IZxdvGE/obOvtYYLKbkwdsVUwewbDqnvqVsoES1Zo4mxIgSgk1Y
 xm0ZqezCcfCzQcgo0/teA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eSSW5lU399U=;I50OgSrD9TkwusxDqXip34QlRPb
 VRJrx5LDHhRSjIqkw/dYopfM+HANiY0G+c3eLx3BBLrU4nQf1wK6Ptv7B/wPsWy5zdPVSEaX9
 vUYVYZ4+zKZ2Z1gfTMeC7rFSSCxoyFou0DDz9SNV58CgbpSfEz+CKe4KzKAbgiQ6gWn9lfx72
 cJz4a14T07W/ywdQuJzzg16lvIMdEXUqDD20UFkxjbeB4/xNR5++coD0wxX1U57pKGwNdGDRt
 W3ktG+3W1r/HGf0S4eEtGLAxtUdlCveX59LZ71UNmXihu+lQ//h7iJdxykLIrbDYzZtMM4MJs
 tPFOqhSKNGKtA+/1RfOilWLER/eXI/QIlbyajgEc+Zd6vlhNMsl6fHwHFeAZJNTlISnqNRoo3
 alKI1FaOjkJplEb1U0TRzVPRJFYjQvN/SKZdOLfKD+fTDFTNHR64TMvNgy9WUOIH3S9Lh2xsk
 um961lNiFYHwMckYF3IlZIXVeHfDF8q6ilw73XHxgJclefs+Q6FWQZklPg+6TCc2csBCGt/Xm
 +wOFBdzcbWxIeKumkd3Z5StntIryfQFSOgEWtSivspwH9WMOxpobSHU6gEC7nMMbOlJVj205N
 a7xjRMSxNl7GX6YxMv36bt0Pf9LEiYzyhIyk6FxBb2CQglnNhYZd+Zue4WJIpsJ0mhFoxw8DX
 kADH+IRlGlQzGC77mh1IcyXV6PDhiuvnukjb/6oadLVP5tLMFPogFYiZK9T/wB/9pQpoCa5+k
 uOO4LUjDC4i01UB4LLO1Lfp5Gge6TxKg/XorK3U8+VvfDpg0vMHYDa/0wiRu8ykBvVQD4JI9p
 fKCamJC/+mc0rG/pAjcjd+zj+pUQby6FHHfif+p0YVKa2fuSAPk5aZC6u9o/aVeBTUalTL/8G
 usJDKebWf+t7CCa78fWXpnFYMmO9CQMjUL7mZvnC0D2LZArag8gKINplrxUrrkU3P3Bw3XJmp
 G4+qlRUcmolGOx1rcvbdw06ac1J2kFZmb3dhe/ygt4nv4WvKNnPp4TOrElPZuWKOXPzhygvDi
 vDICyLwD6btuw0Bok8dMsjBiCbSSaVVFz8TyVkInur1ZOHsOJC3Huh2OWdYFBNTXvS618/Bnf
 SdoUi5c6NfseHwMEX2RJS3YaLVvj0fFEjXOeElxU3rfLP2Db8ho3epAZOQfZ1g7NAdE0MMfc7
 G7ohwNc9erqsRiugD275jtlTJXJjKCIzcu6UjDsNs7/LaJMOpopJDX8Rc2PIjO/iphLlE2ZgV
 8uP57d8MaQfkB92jb9sEv2OV41ZHukzpyA4f/2o+0VtxPvvhjwQdppRQ8f64zTZKnCAm+pjGr
 XLYiWWlCOWzrBAW3PXqokkrcktaepxR39XsZJcc+ctjmrwSb8iWYzx18ucRR+Zg2MLdYQ35j/
 p6ZWo825qxiSkH3qyufQVpd35UuSWAzxDbzhp4FFf0dxZQ90Uj2yYmtJikARBYOg8RfiRHVr2
 Mz8SVkw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 18:56:00 +0100

Reduce nested max() calls by a single max3() call in this
function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/iommu/riscv/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8f049d4a0e2c..31d20016a0df 100644
=2D-- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1588,10 +1588,10 @@ static int riscv_iommu_init_check(struct riscv_iom=
mu_device *iommu)
 		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
 	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
 	iommu->icvec =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
-	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
-		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >=3D iommu->irqs_=
count)
+	if (max3(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
+		 FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec),
+		 max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
+		     FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >=3D iommu->irqs=
_count)
 		return -EINVAL;

 	return 0;
=2D-
2.48.1

