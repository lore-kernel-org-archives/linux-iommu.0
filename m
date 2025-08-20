Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B92356B9
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689438; cv=none; b=t7eIp40ZPbSrI0ECsrXOPUq6qB/g4TFFTosvJgvzqv1HoBmTQfw/h+Bjv0gFBBXbohOOcD3Y4mh9/DD8xd74CfrpYAqk/9Qo6VJAXanJbJ9B6EBqG8vCBGsIzE1+lPWfD21C0p0VmBAVp4eZN6YTv9TMQ6Yfysaw8URh5F6WtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689438; c=relaxed/simple;
	bh=2wTDAZ+GPIuVbzGAIxAT92hwVPHD398H+TX61/inRI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1ZJKcrGdgikzeKE+1qG6hOF6SJnDJWd1nHYezTahELEFNaS96n6lkS8hR/SmDey6NTG5rkUHn1lNZkSqy07QJamQV5wX7t0iJ0q6Sb/YJgzCbZMGJTR51NrTqn8CMTJCqR/6Z51LZefrpLkhaAd2r/8maq08pTbkKr46Ue4BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QoaqKJLZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QoaqKJLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755689418; x=1756294218; i=markus.elfring@web.de;
	bh=2wTDAZ+GPIuVbzGAIxAT92hwVPHD398H+TX61/inRI0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QoaqKJLZZF8HQ1Et7T/R9Va/nybVVVUMy2FXP5jF/riZn5SiWih90t89VuoDNgsq
	 qJ8ky6cJjJ3HwPLiYgr+oVbG+1Q4gQbYfY0sBKAyiR45ok2tevyVbcgkqsIqq/m2S
	 rg24//cDk6qwNjNdM77RAKqa5r10fikT8c1qFsjIDxsUXW7EWU4hcsF4/n6DVlEEY
	 kol2CMSGkOPng81Do24ttgTArwE4yue6/otmz9X2MPC6FEtCYJnt9PhkTuuPVgWws
	 hT17NHQ9DXPaL5AGOZwpChIfUIeG33kaZ3ocKI2zU5rdGgP9V1cg6WAuLEnebF8vg
	 q8VtNEgS2/O1Y/UspQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1un0Cm33He-0017Wy; Wed, 20
 Aug 2025 13:30:18 +0200
Message-ID: <aed0e72a-3c98-4027-8676-b8f469d857f5@web.de>
Date: Wed, 20 Aug 2025 13:30:16 +0200
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
References: <17ba1116-35bc-4a47-ab51-0626006ee35a@web.de>
 <20250820111643.19464-1-huangxianliang@lanxincomputing.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250820111643.19464-1-huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6ZY9Ssezgy0q4GJ7kMAmfHiIM8Hpij8ThgyiovoiOACW4cAYLRh
 DwtPy77WtvoO/SlS40FOZhrIalJayaB68NDHlMk1EzVq9Q2NLnHO58hB13gH0aGapvd9eCo
 sRj768bpbfTHiyz8OvLu/6P9MFayv6RJTRiSWA9e6JVogNQSKX/a425E7qih+yDUSXgwWft
 HJqwNwCsCcl3VZd8WDNEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D8Npqas52Ss=;g+OL3yaEtSn1CgJGtNPOf680Ybm
 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

>> Does it trigger undesirable communication difficulties?
> No, and I agree that both subject and summary phrase can be improved

I suggest to take another look for the better distinction of mentioned key words.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n638

Regards,
Markus
