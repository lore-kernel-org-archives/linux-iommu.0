Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8201A08A3
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686467; cv=none; b=WIHP3koC+viGWj9O5Kk+B2kJtH0iMhtdBbvUkItY2qWY7A2fKFp+0Gb7W0M8aLTAUuAOdnf2jKxgR3Z7YvU6T/6oHwrlRJ2NcHDPSkwlyIje6TtXyFaGp6EJmzteRRZNjTM/79MUNah2TLOCKRc0Uog3kaEdH+BYdUgnMzkD564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686467; c=relaxed/simple;
	bh=AHuXBTFxcxocvj4BxQLFQjPbuTRuQ7KRfmsRM7/bPXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnzjSLyqaWsyzn5z/MT8dA+qELj06cOh0mpePbr+H1dMGSRXrgTm4dR7aAqcnCVXUmPQdsB/3e8E8YjsghG/6b/DvgQ3IjmkqmRpQ/Dug/aHAA93Wyq+mkB4p4q6mwyf5FxSE6QQS71LRIg+w2uVmq4s7502TF9PMa/QnMgzEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oqH/EZ9R; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oqH/EZ9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755686459; x=1756291259; i=markus.elfring@web.de;
	bh=AHuXBTFxcxocvj4BxQLFQjPbuTRuQ7KRfmsRM7/bPXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oqH/EZ9Rj8+ct/DD0nmo/5q3qlAetnLZck/KFkDU8kbAwnBwHIgkGUKKaPvQRv09
	 lA/M8G1KgqPweVqqp9wk35jkWtna9St7LQShupBHlIrQbR9mdTWgFT7/JL8gRcZon
	 Z/99bCvX0RzWc6DsUNDO5jqW7kO9H+Qbjnz8HNJrF460IWGOFrLkBqxKPh0rC1xUL
	 APA5svDAIC3oit/WKad/s3eN7zQUeh4gbA2UE6E8AXG+q9HfV7IThUVonousigY3Z
	 uhw/2nbx+teIUXK1W0csQwyOjMW7trizTrcPplwGFnJIXT/SuLMaFtEzYG7fUeVpI
	 RU/fCgsAdxna+H/rsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1v0Gq912IE-00SjdF; Wed, 20
 Aug 2025 12:40:59 +0200
Message-ID: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
Date: Wed, 20 Aug 2025 12:40:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] iommu/riscv: prevent NULL deref in iova_to_phys
To: XianLiang Huang <huangxianliang@lanxincomputing.com>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Robin Murphy
 <robin.murphy@arm.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Will Deacon <will@kernel.org>
References: <568d8b25-8cb5-48f8-850e-0298e3fc456a@web.de>
 <20250820092128.8069-1-huangxianliang@lanxincomputing.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250820092128.8069-1-huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmMIgwZxpcnx9uXCpVgI9b8wFBdYmU0JB/76T7DnOX7LFJ5EY9Q
 5ep55ygyR9aBJhG0GiijO21r4ku+qqhKpfdF5wExOBN0gLv/sZWmAb2cu0BWHOm3O8Y+gPj
 +D3sb1P5QD2DW/yNYg1Q4p9DaDM8p+8NiNgvEzu66tAMjp737XEPZxaFNDIEY9TYQda2sWg
 7dlIwfHK5fibWfVPatbig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/8jzp7G7PtA=;tuBZ+4E0xzvkgoWlJawydAJhlgc
 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
 dAIMGnoN5Q7ctECzger0P+jiQrfjRqRN+tXuF

=E2=80=A6> but put your proposal at the patch Subject...
=E2=80=A6
Does it trigger undesirable communication difficulties?

Regards,
Markus
