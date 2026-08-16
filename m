Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41194B04A3
	for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891732; cv=none; b=X83aHyOtCsLCCyh8o98HF36t/v29SbstiraVFaZ7K+CAfxoxCiW4+itObXqf5hfzHLCrXO9prtC6zC66vlZeeBcR5Zf1l5sZXXeSwXoPSRSZ2a859MjpINJ8jJYqStFfEVkRAKR+e3LHK7XqVTBmRmIPRSHA4vK3QbtwSLfwtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891732; c=relaxed/simple;
	bh=qMudL2xYFtIFZ7kucdSPQjBSLIO2/zaKr5HkBMnbf4Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dD7gTl288YtltkglGVRuU75SOSGfsL1KKB6wndSvEiO7euD1ERNg5031JxnByHtFP1XQLeJZHU3hDL6E69ObOGNx2/C/i5NYyV3ISYP5dgHJeuz51ZFEmyP77w9E2t5RBFeMLwIieHFusewbeob7ZnfmSCygRoSvB/cKwJ+M7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hw7xC4ht; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hw7xC4ht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786891707; x=1787496507; i=markus.elfring@web.de;
	bh=qMudL2xYFtIFZ7kucdSPQjBSLIO2/zaKr5HkBMnbf4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hw7xC4htYypQLg5sG8oNIv1zHS7Xr1lJUkM5FCkPjPy3KzUyiabvWm/FpBQzbmP5
	 k8QpmRY9Qq+zQm79sykSJ2gftDCHjA1gsnwXrYwJ80+T6tHil+pe01ZAbBy8nPqm2
	 um1ig1X/pUSvqfTDyBxOwtQ9MPjVLLBEOBJvako6idVTnY2xlUOsAOSxNzq3Rlc/D
	 vTKKiUDE010ZXIhVlPju8LcoYulJUpmIwkl4COisOfBohqu/userORz5fJBMnYKhM
	 7Lc39FQax1VE0gmbSPWiabhf2P9GJ4FRPYO7AfbSwXBrf8ufElUEySAkzw8lpSIdV
	 apaACJRjXTmg2xG7Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1xChi03mAg-0098DI; Sun, 16
 Aug 2026 16:48:26 +0200
Message-ID: <eb7b71c6-bc93-4807-9d63-bebf804d3e3e@web.de>
Date: Sun, 16 Aug 2026 16:48:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ruoyu Wang <ruoyuw560@gmail.com>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Wei Huang <wei.huang2@amd.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260814133938.1385879-1-ruoyuw560@gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix PCI device reference leak in PPR handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260814133938.1385879-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6OmokLa6R9eaxnFRriTRBDI+bkLDqYRVM34BZTuhnEM85iEhESr
 u0UoiKjjHGeh/PiZ4sdgyYG19DTqdawpkFey7td9XicDER+p/HUw3ZUwMwYItQSxp9shZik
 VIx3dcq6VBKtj4pZ+/FsSpJp8S5SyJ9Jz7vXg3ecoXfZozZF7zD3uVECl5dJSAmrhKSCVR0
 x7hOodNB/2EMA6UjfoCDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k/rJ81dbVq4=;sS6W7HNFsSyyzyJ+I1yJ+vEVWOq
 unzKfy5xroIZXkq/yxxHt+UXJYcaeesRN+6E7NqMA6SJZicsdHHS9SjwyfDRoU4/jtaWzVUpC
 F7wDqozhKzRMxSxiwDfLIPfPAYQq9D56Ajv9IQskUbJEEqJhKxSzsSGp58BKenWQbH9eLHVcT
 w8NkatKtXHYaqkjsK8LlDSkIixlMbnZUBxA9DMGZ6DmD5rPnEECmC3CI11wy9t9Y4MP5yScqk
 pxKq46FnHo+rgNRIVd/EaXS24L+zD3L5NtZCPm+UWeWXR9F78Pg3lvd/cjREyAEysPvDr9FnO
 01E//F85aM3DJZcZbb9gY4lJ9XbqtYsfrZDey5FWt/zmPw+fECw/abeEOKLPoe6Zy5qrBGjly
 xO6HEBHp8G8fHzXyQ4j8d33yI82xJEQRPJ1aJh/iHXQqX4+YyfeqdHeKXue0WjK9NNaNAuHfS
 KfrXdeXKOpZQk5llCRuERWMy3ku1t7kUGkXIwKxsGy9jLMsUC9Jie4txQY2l8vGzOM/HvLt6D
 RM/xLBcFRIDbeS7+04evKcK462fYKni3S1EMNMzKQ5nOOW7NynP7buIyinbvK4zGIoMLimUaA
 mIUG+jUi/oh/EpxTbyQyxmYQr8z4A3RUcgUoqT9vNtgckotKlFfI21U9caIPqTeBOItsPUgUy
 6sacXawufH3h3x+CnMH3ZAo9310VGIS1o4/2OOfev8iVmpo2Gu8laZ7nm20yMVwIr2tbFhdSe
 lpOqQEEsBfacKpb5U2BJFgoKKgh4nGyCjAvy6y0qY3mleEzY3u8mG4egcXWhrGHUeHhy3afHu
 UMxB6xH0/4xdbdoWqGu+RcqYmyByxnH3d4GhwI4GnQMtU1iiEDMtPSUuPLj5cDlZHm1Y1Vdpx
 9wDCyFtganD9nSQy0Y+p400iz7G6Y/U0fjETLrysidwKOJ8+Cz2ovWAGIrHE/zu1fK1ItfIcI
 frg6O+s4X53UnM0AxyW8DpfR+c62vmSJsr4ALNU3pzpoAdfjkWRtwqmIzOjmRVEF0KU7min4/
 Xf00mwnTRGkVPObISeMNAdlAIlMmxvN5xBOrr1Bj3LdBwRmznytdYs7f5XsQlYX9+KSjDWJk6
 h66az2E0A0K3xBAoGTLWNRUXnYHe+Lkot4R0CaQgwnLkeM7o4Ymg2KzV1awuviXcbpwzysnyl
 3DAHnk2HG8OIxeSd/HHuO/iZ2Ci7j0OWaDHV60vuoIifWOd7Gt7iklrKqlM3GcegPajs7eMKy
 Rpdp9Li5wZ2TdtBBC47i+H+vMDGUNp6JW97SJ1M38Rl516exYAsjeBsBb7N86mtm7IXIVEeLX
 wpaZ34bTzaGBYaSFeO25+qpDAO/vg58nklADiqcf8l74TKJ/bXLPhOJ7X4iOOwCIYSIBzvUYg
 ffR8i9JTHUShslpeFOx5HJluHVruogpExC/1X2DFYlUqxdS2ru+H7ANmcMROxRXh6Wr0wmhxz
 /bcUFx1V9UT3RwkThh7OiJf33RDT9K1967/VJoxUoucPL+BgC60E3P6mGYnRdbI07ujUVSF3S
 ODShE4960bzEPdKaftkDj4+8SDUs1E51wfHEnatrLWM3AvDDiEV86bUUz9x5LtXMmEBnHt/52
 xYTxI4dg35cHj59AmUIdygjtS7AWBhUR+e9T5MCPDp98qgo8q/99lg7J1DjhpDADUJ7ptwfZh
 lbD9RB6xpTU0D9gNiXLmpHpbiW9dAALHJI6dmAWrWjohBXN78AvlDqM6k4QuS44Sj+Z8Tnvde
 cE/eV6UgIhAUVeCVcD1vFwHHyqMi3PekboLBaVNVcAsCGJ8nnut+cdSSQCU99xfq7QGATH7IE
 X+BIDAAa47zX4wzXufU7XiKW+wqN66sGe4hZ3WRYMDZvwgNsuVylTx0nmpNdfwjyvyVyNT7t8
 X+ViGlmUeWhbgdsqhxdgvBIm+ymJhf099D4dHkMZzH29UvZFLXwck7vu8NKfi5kRKDCJ0D4WV
 PLx38nqp/lHTHYPkLk8+KAm9BLZ8/o8QkOo4xz0c+KprcbLWvpA6nNc2kTwF5Qu444uIzG0bs
 q+xR25BzMrDjBG5aBaM6W8+bIB6lRCtyUpUj/vwzH29UlapGQtGgZtB4XM5ayzMJvFpVEgRuo
 JTBnbpgPl8zyUmxK9BU94CaXWEhwLd+8aC6f6GudrSyOrPkbb21ulkg9FWAwlPKa1hwemfLDU
 c3DiIjymOf95zko87nMD4zMrt66QmUsXL5tC1BX6BQF2caB3COVNmgjAZEwHfveh1iZ2lbznj
 SAtsvZNScwnJ1WOHwMirIi/cj9fXJ/VzPFWxTW9prlDVSSPBs0WjDmo9punaGZx3swJ1UVNn7
 BHBYUaPGonUl8E6TEsCNhLEN0iO5u4y7DAO5mUlZt7U9WKJkWqoSb4qlO2oJSc5OtcFApddrq
 o8basFMZaeD21RGVEaxByxHavvLEehO47K2xFEiFIE6LlsbREYPGL17NOGqV/o+gq+JTch2jq
 7E+kDwQgK7jaBzX9Iq9PnrnjcvJnZ7f7DHos6aNs+cciYAE68zWXzWJiyXBuPGeN1jcozvOLR
 FOCe7h+grvdbPae4Tbn0lQh+G6eNRZxeSzOz8+ppZAuw1mzM0tZYRXrMgmoHvqB1JXHCghWae
 i0nA95fc9F/84llBm7A8OTkc8vIg45oonZDBlzr5wWQd2cIK6evaq542NYlz+LEFxChcyGoEr
 QHVPoD5noiLCQfW+i4r3m98lfh9VGyFfPiZConKcrdwO7xzxUBi8j4I9Jas4Sxb0XGuBy5YIs
 Ee3rMJC/Ds7iT3zTdjuK7q/pE4GuBhlRuXFDqOG9KZAkb115ZnxcNvvFNOhApuLWu3R1k9ri1
 7+Ls3EDIqfaU5EqViOF8m4xACp+5RY2xhAkIzucWI9iRDmC80LNssLW/ms/mhWYBEIjX5S6kN
 69Wxy0E4+2Ge0pjl2icApxba2+UMzPs9xpMWqEmz8OU3w1i70JcSOh/a2zHNKCknCQceRORhK
 VXgxhDoRgsYrFctOH8OB/8JQUOQaTjczn3sh11gPuFkbxjU9qNJ9j4gOFCJ8QKXkestSMj/jA
 AorEw+R82HPT3k45ZkjS/4I76yoE/RCPTdq56ykg4uOfCNfl0SQmlPAPli6lVGQgHitmhTQkN
 LkG2Rel7/gO+Vb9nQ/wwpDWpWBVQlXXs3ZjfADdKyaHdRBtYZKKISpsTXJ5oeritOdCfnJCWm
 Yqf2WXqgHz5aEPCnEz6A41EOc+ssf6P4Hp8wofv+PSJgcisK+EAv+C/EnN5ySTj1R26X+pQJe
 wRjptlP8TEzd1t2T3lNjN25H3TPz51+TYxPOb395sJO3oqnW6Y3yFRKSo4p8nGnv9DXedNozR
 G3XZle59RQp94ZcGFmtN0202tp6V/p6CjDSe+worobomop/ztykWr3km1l5iBpT8SaXLMZ2EP
 zhaqXWHINoMtVeDi0rXp8Btae0DZDfmui4dR+jZv4g6H8GoN9a0EsL1TZQ4eIw4PXA8AMBlR3
 z+UQZrqIRlpsXx4+HwrVrc0BUA+BZU+oEDetmUtCJ+3aNjXLfWeUih/CDUO21zwKiz7Td+FRQ
 RN2A3IvoErtW4PJY3Th6FWry/3KKqKezq6qw1K3S67xdSr/EBIkEpgrpAU9Mbiqj/noYwDmY6
 I52hAKyVGYO6x56yHBGppYvCeNxz1JcpGFIPsb7kHrceHSbFU8GP3z8FksZf0TaZbRmoATA3t
 vBOTpribyrms/F/cFq9Jrvq97U2KZZ2pfwhXIlyePs1m2mQ6ixWvwQP8Bl5J98Qr6VEb1YcP7
 9HZamXK+wuye9Lt2FzhHmg3LW2TfsvBHLeigL3wh0ZQqbWS9EPTyDCT9Ii4kb4kTFx5T+BoBQ
 8svdcDaMgPVJdf5arHCGRWYQM1WdofYo7iJTEmdAMcZBRN3msYIHYHY/B2nXkRLJrhV0j6yyp
 IocKVeoN0GrFhn/fV2ABGceK50NNDBWsuHdRO7L6cqGz/umhdlwihMqGP3tX4UHNTDTzWRJ+1
 czYGHnxmoh5PqRRnUqdSGzSnF9DufLvcaPxGdEmpXdclLF6r+kx83LEr1c0enQTdTZ/tUvSIL
 F5ckL/VCY43pGxwQkCJaF87ljIYrtIBXsn2tiP8FE/FWhO13HvIu7nqAIdbWUsLqb1UREiFLK
 jlvo7GlQXrDOjLjHQuOMkJ38qoajT2xtXhAcxqlLss+5cz5sCMW6THwH87rFdhaWjHBej0BN5
 WTspESp0CxOFPWk9JIwZrgv6TDpMA/O6It9AfW0gJeOaU3a3MPB5oetvrJlxT+HX6RRT1skGi
 +SN9EysHHDr3mQACPqv5zhYf8vA9gJRXsyXLjzCRarnfOwdmr9olIsglIfM2vwwkEXeHzbayz
 LUjF00lwKFHGDG39c+93YPt/Ly3dpe+I2P/ZV75XN9ay0/gN711tX638/Ok/guWwepjBiMAm+
 Fi/o+fFOI3x3mSNLktMae9FQz6ENKsViRiu5tFy9Hi1pivwr5zXagqv4Yw8CB7hLc7xvthQDS
 Jla0J84QrildIHzvjSnVz3qBRXm76+cM5y3C46ozt0rWmYCkufrdO6+wA3dCXEFNqmO9cXxaG
 6uPCqsGASTWar9kC8ifYxeQvMAuC/m7xUZo5FPjb/jNlvubc/yODZetj1HidqwAuiHbxHIGLv
 TGua4h4trbficY3IaYyVkUnqDPu6XRE7kQxtYAvbH+psW2I6+HeB5HbDB5CHpwK0tkUmR+btY
 1W5eKdQlqYZJEXlJMNDMAbSuBFJbCnxz4oXwofiAHeWCpj7BdECeffJeRwtUubsBVQXB5iK+h
 BmlWeROTI9biHKXFNk/nNdBze00bULAEIrumiPZYU3OBsNP7zzwZnbkrVXTQR0pB7gRJh6Z7K
 rYptd2TuHRu4u2fXuAkw9z9KSeWkhLKixH3t4TNWoTnzPF+RunYFLV0w1+rBpApPSKsa78s4o
 yXTyQ6VAv3Fh04eb2q/vrffSS8RhCx4mlu9eM+CrR19UOUq0KWMbn3fxM9pkAwYITYR4tIGoy
 BUSuZ5enI7OPZLHAfuhkeNSZucI6jIxy3ynOyGMiyQGb59bc8foxZG60iwsAdcufIvxaLSQVt
 RaIJbEbKKc+y+9AzYburOive+Ty5juYPF4NAdp5dEJyl/Ha/knu4BIjObBasthnJ7AJRPAtul
 x5LTmRuBOaFO8khEmekHnEgo2V4IHewJYlJVxOKtf0kp5PkVxc8HCcQZROjVKm50AxiYkfKAl
 a5qpkz73AZfItnXBZl1bkZcHnRQ4LGFLQAAaMcPV9wG/OIxM2SoHuXMaglVX2d3tCS0Gn0LXz
 u6FfupY4vhjRRgYyu6NSJyUioVKJOCBFIxea/OpO4r82J3DFIxJ46ndadMK1tytsMYZu8M84L
 l1aRw59N9rlSmwJija4VnfghnSdbx3nsA5o4H16u+xAB2eFSzA3+bmuttD47jEfcT++dcaABo
 uGykk5Rpw2eBhMBuoKYx3kJ3sawUKoNmk0PYx5RhpDmaVJXEbFdKEnKceH7x0AiSdQqPtp7Zc
 jgWOewqkU2rnD5L8YwfvopqW3ZCR8gistOXtiXyXDqzlNu6IFmxGuR//81UU0aXvU0Hyu4VhM
 uEmv85jXS6PnK9lwKK12yKd672Zhrd+7FRTb3dL/ogbVLAtyykiEQu9VokYPFbRrze29Pp74P
 6TmloYmKpzoFQOcH1jEjQF5TMfwBIsmJ36mm6b/aB0L+hEzRrdEr3+0Ee1To2szm6hxR0zngD
 pUM65OqJy6X/Em6XlrNVRyOlvc7x2wLpGl0uPTNVNVND/F8Hwh1PeILu8k9BM3APAgim2ppuR
 8dogJm2ptNOedAjo99RE70traNe1a1Vd/ORvsDIj5SctvHJXzLORrc01iMyNwyYNdeiiF1jaZ
 RDJEJLhroNvVV6zFFN/yGxaeRtUt/TI5d3jy3NwD/cabyOpPGDZg5zY3F36u3PKNhBG836Od7
 LFRVwAQKMfiyX2nR4fQoW514SGwi0EAnRLWlsEhzD55GX8cGPfgp1I3XyNYhtcfHRzadDCake
 sq7WBi/pD0F2/ka5tfDeNMKuFYtjR/+zavNvoKW8JVvm1f+drrLKXm0nTh/zoJx+38zoCK4U2
 NV7+DbA==

=E2=80=A6
> Call pci_dev_put() after the final use of the lookup reference on both
> paths.
=E2=80=A6

How do you think about to apply the attribute =E2=80=9C__free(pci_dev_put)=
=E2=80=9D
also in the implementation of the function =E2=80=9Ciommu_call_iopf_notifi=
er=E2=80=9D?
https://elixir.bootlin.com/linux/v7.2-rc7/source/include/linux/pci.h#L1269

https://elixir.bootlin.com/linux/v7.2-rc7/source/drivers/iommu/amd/ppr.c#L=
107-L162

Regards,
Markus

