Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2723ABA1
	for <iommu@lists.linux.dev>; Thu,  7 Aug 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551417; cv=none; b=oCgn7a6zI86JtZFWZ7S4tEepLAz8T7+OVrpwgZJmRCvR2N0hYsKl+aFnymfyGGzED5UtPNj8DCCPC99LVXCgtNmi9kRpN/5cvpS1CwFfdHHuvlrWBxBxj9cNyHlSdUnPnjU5YwuxLAdd5wezwq8VLFnl6H/5s2h8cCx0WbplCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551417; c=relaxed/simple;
	bh=9de88VugsDPa/LIlbpkda0gcU4yY7d+htJ3VqGCOGgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Up/4UGkGmciJmDRPwDrXHboJ1tqzH6P1SCcqgjuWe8BQ3w9CwKXwsn4rr23Kfa0L3pee61rmVdr1LdkVj/ZauULDOTqvDV7e7pvZSDeH4zvHSdTgEWPpIO19wfOhZp9fFCgQluut0oD2p2OZlbbtHZLJ7Ol3h7OarDcL/bttkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gBjHSuVf; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gBjHSuVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754551385; x=1755156185; i=markus.elfring@web.de;
	bh=9de88VugsDPa/LIlbpkda0gcU4yY7d+htJ3VqGCOGgE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gBjHSuVfgC/vi/GNk88NmnfPQBzNLSCzNa8UfbElKnqXJE9IJA4Ip9LjvaZCYNl1
	 i/zNq3st4vePKRF0Kse3oX3XYgRV1ZfKv8MYZcabvtEXNmKwpPVtvdNZuJUN+A7+x
	 6dVKo0y6M+7h/9sIYDvWm4pFd76e4mL1X8zr6lUN/16kUdtLRnsIQfohB+QHbYciw
	 O1f7H63zT5Lwf2nvoHMCeSg8ion3t25kQNTk3d6uYcX//FinWOUgPuTWSAO/PJcBF
	 TTytK/S9mLQ0ydcGwZbasDlCZayWOa4XZ8+PEtYqq95bORfIiwFV14CQ5buQSeIiT
	 XzElQ891jo51iQdhHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1v5JRG3Zvq-00IGB8; Thu, 07
 Aug 2025 09:23:04 +0200
Message-ID: <effb29be-6d14-47e5-ab71-454119467750@web.de>
Date: Thu, 7 Aug 2025 09:22:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v?] iommu/riscv: check pte null pointer before use
To: XianLiang Huang <huangxianliang@lanxincomputing.com>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xXKAd9LN+7SrcX31YxR+DWd+PmSq61k7eWdXKUqnN2yiW7J3QZw
 RJpWlLJRRQMAjmoPmjGGbuS3he57QLxps7+hbJZ9wSrD0oWrVZAbiRZiIpblufjQq9yTrL3
 AHH6cxlSe8JRPRdswD9NMDuyZTXR5jqvhOCjddzvGMHMPlDu1Al4eBUBJiRVRyA9Id2DtJ0
 Y7x1mWOtCCc4Lewj1lbnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zIrh8QRrPQ4=;lXwciPgDaLAizrl8IkBjNqDT8OH
 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
 M0ZCWZ4mxrYty43wFU/8+CUMNR17mGVU=

=E2=80=A6> Check the pointer before using it to avoid the bug. =E2=80=A6

Would a summary phrase like =E2=80=9CPrevent null pointer dereference in r=
iscv_iommu_iova_to_phys()=E2=80=9D
be also helpful?

Regards,
Markus
