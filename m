Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF713B5314
	for <iommu@lists.linux.dev>; Sun, 23 Aug 2026 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787466043; cv=none; b=ge2b5JYkliXmewcmf9ZYFURhr6koeLPGptYpWFjstPsEbbb897RLQzkcPGVRluJMnAhsgQ1ZBjQWjFa4TZJQZMxVbSaUMVfKPnzUX33UZS6NXVdJsXR3Sy8bh7rad6+ecPEoqiJx99uxvPZzYh3RMm5Fu3r1PfpsKK4gWOeEIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787466043; c=relaxed/simple;
	bh=DfSOJM4VYxeD3HCa4tfUdjSYCWTwAnQZvs/ReNKJ4Wk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=o11XCW8d0NXrKH6bMDNLuXVdywMCUQD4q8NLX9kC74usuLlmokJzUf4kkRHj7P37YWQdRDFLFADJA9uYnRZjH98QCKGMwGEOWtfJFqxkSXplAaBCBo4FWIS98MZGOVJ0jyXN+i31wofURcorc3IPnee4VDiV0fY6H0UmXm3iZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K/YJCCGC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K/YJCCGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787466029; x=1788070829; i=markus.elfring@web.de;
	bh=DfSOJM4VYxeD3HCa4tfUdjSYCWTwAnQZvs/ReNKJ4Wk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K/YJCCGCHAvZOSNW4A8VJpe872nAhny1kb3ixJVxBl8DO0DFrdreagWOgT0TBVNQ
	 K/2lzffogAxjoMA2n9lpCm/Ejk+ABecQh2CB8OOy2eWu1Ly4lkzfRSE7SIA5fFI3F
	 xkkmYHjCMgby++QTEqTw0Gund6DGMqw8AM4tDjDDGawcOoBGUiCQlefDQ9MaxitLn
	 UQt3SUUTmVbaDJ/VFjv7hksREaqg08Bmzt/iCj03RMrYeoI1W5wFDs40Rzx9bHKcC
	 lvJ830a7d4BnDMRgX4YoTJN16C8qttUJZ2YtUIHcdryvfbPbBoGME0YO022PNTeov
	 Gz96RrrFm0p6CpZKnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1x8EhM1rQD-003O3R; Sun, 23
 Aug 2026 08:20:29 +0200
Message-ID: <238af9f8-1678-4b8a-999d-8d02767bcef7@web.de>
Date: Sun, 23 Aug 2026 08:20:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ruoyu Wang <ruoyuw560@gmail.com>, iommu@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Wei Huang <wei.huang2@amd.com>,
 Will Deacon <will@kernel.org>
References: <dd1d8d3b-030f-45bd-aaa7-e8760268b2dd@amd.com>
Subject: Re: iommu/amd: Fix PCI device reference leak in PPR handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dd1d8d3b-030f-45bd-aaa7-e8760268b2dd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6SLpUUd8OvqAAsVf3lnExCFKS3IfHuskIffysaTvJRThHmM2Sb
 cdViMFEyaas4C2dzkZN6Tu0nKMy1Q6fOeMJOxY7yyy+CtvBqGmurFlHtIs/nIuQh8DOvXPl
 tW8OgFn1VvnMccv0efEViTHZqP5PrCky0tLHvpUWVBF3DsxcZ4uHiYWdAjknSYUZni75bNL
 RrZSWZkGssvtriHi/Kqtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9xV/AbX3JMI=;hwtmvozS+1uGiKiuS/rxofjlfAE
 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
 qkzxeD25I8YFwi0uDi+4=

=E2=80=A6
> > Call pci_dev_put() after the final use of the lookup reference on both
> > paths.
>=20
> This was recently fixed by commit af3b69b16383.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/dr=
ivers/iommu/amd/ppr.c/?h=3Dnext-20260821

iommu/amd: Put PCI device after handling PPR faults
2026-07-30

Regards,
Markus
