Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A32E3705
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392686; cv=none; b=FRcuVNWk+uDa5CacCNd6cv5JAoRUlrs5ueN0Zm75Nz/wmIg9p4wNhRLnOBndU5MbjupGqLRg1DFg1wACZR+kM1igm0MxXMvjgE0l7hwsQbHlBRSL/sXvhOTNRWCPMz6w0DbMawzvP2q3fWLBaZPkGnj4INqB3m0VghB/PCMRWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392686; c=relaxed/simple;
	bh=PoVfjS+IIiDEaV3vqdB42U2LFeidxnL7C6V4nh9E8HU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oDG3w9OjClfyTB/dUPa2I6aqN1rUOPCNmk81e4Vc248iculOyTR7iAEOYotVxgTatxeyegGXZhNtOEYiVY3lgg/hUURvQ2n2N7IDjm3xVVVW9uWdFBNFiUXRylUYfsyO0NQ6CrvWLYbBIwE0+IDaS5Ng2BSXXBycVgnTAYv1p3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d/fjxNud; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d/fjxNud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754392649; x=1754997449; i=markus.elfring@web.de;
	bh=PoVfjS+IIiDEaV3vqdB42U2LFeidxnL7C6V4nh9E8HU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d/fjxNudKbfSuSXiokzd0YJCcSScJvQtN/GuqLddKoYFiE8dgBSK2OMPY60oqajz
	 7NHHLbM1SbTSmvhkhhB9rkvshYqsmdMxwQuaS/Aok4nadu9Ko+dPeVVVL3Ny5jmGf
	 Ct79hZ279Uqb2O//H4E3oBvxvOqocapsziUn6CDUIve7ggO8Snu6K2cY8i20/pqxt
	 Ntx7rImk0bhE8DtbjIJX1xlz2IEfZIc35K03O0cBKC7D8jsgDFsxl9khd5P9r/7+I
	 PI4UYblt6ceGtCESBEDFMciuNnydfn7fOmNSAtvOvoPp5BbmRvZsfmC4FAYVS+FWN
	 qIBw7EWhhiFtln/RVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.245]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrdC-1uTdcv1Mxk-00vb3p; Tue, 05
 Aug 2025 13:17:29 +0200
Message-ID: <1f419739-4233-474d-b00a-4e1237352691@web.de>
Date: Tue, 5 Aug 2025 13:17:26 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Huang XianLiang <huangxianliang@lanxincomputing.com>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Robin Murphy
 <robin.murphy@arm.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Will Deacon <will@kernel.org>
References: <20250805101741.30819-1-huangxianliang@lanxincomputing.com>
Subject: Re: [PATCH] iommu/riscv: check pte null pointer before use
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250805101741.30819-1-huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rZRw1Dc32uiAT8AdtpTpiqWlHpArHWCfybApTsIC89EIG6zoUxn
 7u/w5EDKG+wYCdij+eN7wGdeukIHw7G3CsyfcdTw9yJL3uqfhul3EWodqoJ1nWg4YbK2hvP
 dxzklIBThoLwprbQsNkxw1cgLm60cu6yuY1aapiSeZ0dK5QsPLOnrhdZdAnhtfXf0P4wtch
 F6TY3MkJDc4mBo1PwX0Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6tznHkamoI=;TgYDuIPPrylpXeH9DlGMdWtO+O/
 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
 tgyZCWcmctFgag=

=E2=80=A6
> This commit just check the pointer before using it to avoid the bug.
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145

Regards,
Markus
