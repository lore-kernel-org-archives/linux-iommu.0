Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB579F9D8
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689240016; x=1689844816; i=markus.elfring@web.de;
 bh=8NTDajyormUAz5wmhhVqIQ6P4Nq6xXUUs7OpULQZvSk=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=Hhpk8+lbQ1UlCbmAzgJCjo4PzKkdznbpPYRDIJ3aFjIjizdVNWDZeTX7YHKeeFeUIKH96G9
 NkiAdBRsm6butf8LYRKfz7ZRcADDc0QAcPwg9/mWAOj2a8V9dh7a47l0jZnp7i/TgcoMiKloH
 C6de7+tJ+I68T47QTF7a9Bu6oi5OmWbJ9tRjtn104dMMcpFM6tRROzWs99aR0xdwXfgPmtp6r
 f6BZj58AI6+n97s+bXLiYT5T/TtQLptGMh1au3LTrQZKwxORKvGHs0Pk0zPYNcOutQSod0f3s
 FXgKIEG6uDInmlzuBgHaVTkCllfqA09zfMNXsv21O7zqjFs6tesg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1qIEbO0epC-0022RH; Thu, 13
 Jul 2023 11:20:16 +0200
Message-ID: <c7c718e4-b583-cc0a-cd84-305d0fc0b66d@web.de>
Date: Thu, 13 Jul 2023 11:20:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Thierry Reding <thierry.reding@gmail.com>, Minjie Du <duminjie@vivo.com>,
 linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org,
 iommu@lists.linux.dev, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>
References: <ZK-fD7inmxjwPyL5@orome>
Subject: Re: [PATCH v2] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZK-fD7inmxjwPyL5@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rEJjolO3iQSztRd5ZFy1HrL9srjjCRs2SoYetLp8QSEE6FxN1St
 x5fGHT8sj17r65gjEZCr9htWUoLODdT5/9WawvqDGhArYS7ewKPCTfOPf0JR2d2k+R1vPL0
 UL6xTXwHjxEjGbVvSmSveGCEcIRUEgKv2SIij7AyK/d4gSFzHVZYgRKpTyVPmMBpbR/kZkt
 YEuJJWHhflCzOU483uvew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLgR8lvwTzU=;oOMTNvrEWlcuankfjL2OSrIphp1
 cIRAQ2hOk1V/W1BiWrJDydhd+ZqRZp+Az5ukxHi9ticCbAGo8MCenmzbmutBRunPOfOrtg4bL
 y7qceYjxTalXcvR/1aA0Z2HtRCF6PUpHTDIa3q/rsQFyrllqFNeyT2EMUJmrAFOCeuTvXUbGw
 AKpzbviZbPjlg4QzB0KNXJxvpgvlXSvJKfX4Nsz1/sUYk0i+OKso5J1XqCGTFYKhzWhIOF5DS
 kEo3igLWxo9d/Dm6m1/5jJbrOHwKmH/BJA1PGkOTEEHer9eMIdVaYxlk2x55whUmtU0KLGNfG
 hcaZVuJ1aMNcAIGZEenwGMD+DE7cA1kwY+c9QcUm0hXax+YgZJRDkmwxmCjl8FWOU1XACe/88
 EDPgod/kkIw3jGOfqRfHzl6ZDyRHXv3bI1Js2CVPTBlTCsF35acL6q+xCfAf/OlZXmRZAczDL
 nxxBFdJMvn3m5RvqUlhuTeL5nJ6o4kJ/B6HXRE+F9mVd09DVd8xmVBgxUQykkkepEG7fInWZy
 XuN0tMvls2cFMEZ2e5GfVSQA8+Gk0xJVyMlYLD+VQImvpLxw87/JYhWpKUTay0Q43wthg+zx1
 G1vtQbqjvRkyio70CXOclnmL8Bj210b/9qJ6SWSZDsokAOhhiL382aZYQS+IEfikX+ghEoNXy
 QmHHMu96VVnFkCGN2lzaAvVM/AMoixUjLC84lint6MtprlhARjqVknwqzsZLHGaLeF+EEuYK6
 t5vtYpfzkPbSki5T4J2QSegn6A4DFbf/wP1yhmvg1Ubgskm3mFB+7w9IwRULn2aQy/TZ78fIS
 flCxCNW44uVN5497Gf/gx51tq+5tTWktspce67FBG1oaJhFmGVaWZzh8HSvkK372uMNjI3uxJ
 PzwtviOo1hTANJ0C2r5uhdp2l7taS4JKcaFKA/TQ75BKzbrvxXI1mVUzkAUcWpq/5FyGFuGFj
 QUx/hF4Od4tZF2/2LXeuigPRPCs=

>   debugfs_create_file() will return early if smmu->debugfs is an error
>   pointer, so an extra error check is not needed.
>
> With that fixed:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Are there any risks to consider with your presentation of this tag =E2=80=
=9Cin advance=E2=80=9D?


I would also appreciate another improved imperative change description.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n94


Would a subject like =E2=80=9C[PATCH v3] iommu: Remove redundant error che=
ck in tegra_smmu_debugfs_init()=E2=80=9D
be more appropriate?

Regards,
Markus
