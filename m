Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C623208
	for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 19:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF99FC433D2;
	Wed, 14 Dec 2022 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671047186;
	bh=/g9jMPLRe2IrjPIOgu1rRx8LFMWlUSID9w6uDvMaQeo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YVFG5eSNzAuZdCWJr+3U2UOKPR1wDfWO9+l121gOaqgjsv0Tl5xz8fWDKS+Hsv87p
	 wdLtRoA+nT/Ogxfcc2LI+IP0gN/40n/eWN90A7ZvhB+g3TndrA94A/1f7EVT1yUvGY
	 nG3Z5TuoI2g2JF1oVV0Qf4D1KKrwjk9cygzuw+e/hYv7tpKV6k2uWDOu6rk/AnbIce
	 bYClpcakHqyblj3QulCWIpN/87hjrhGPdfcv+ZR/YtTitDN1r3K2i1JbkbpcnLRkGK
	 qxjBHXNVvCnY1ahrV9BnvaUoguTzIsZ/TGPP7/nvCYLFmStPRYbYdT/QfBNPId9YGP
	 UTTPp/QNGGBug==
Date: Wed, 14 Dec 2022 11:46:26 -0800
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@rivosinc.com>,
 arnd@arndb.de, iommu@lists.linux.dev
CC: prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH] RISC-V: Disable IPMMU_VMSA on rv32
User-Agent: K-9 Mail for Android
In-Reply-To: <20221214180409.7354-1-palmer@rivosinc.com>
References: <20221214180409.7354-1-palmer@rivosinc.com>
Message-ID: <8DACBAC8-F220-4DA7-BCC2-4E2ED9E3E03E@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14 December 2022 10:04:09 GMT-08:00, Palmer Dabbelt <palmer@rivosinc=2E=
com> wrote:
>Without this I get a Kconfig warning and then subsequent build failure
>when building allmodconfig on rv32=2E
>
>WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>  Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST [=
=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
>  Selected by [y]:
>  - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] || =
COMPILE_TEST [=3Dy]

This here is your problem afaict=20
I got a report from lkp about it yesterday, "blaming" Prabhakar for it:
https://lore=2Ekernel=2Eorg/all/202212142355=2Eb7vf3Jh0-lkp@intel=2Ecom/

I hate selects, just ignores the dependency :(

 && !GENERIC_ATOMIC64 [=3Dy])
>
>linux/drivers/iommu/io-pgtable-arm=2Ec: Assembler messages:
>linux/drivers/iommu/io-pgtable-arm=2Ec:330: Error: unrecognized opcode `l=
r=2Ed s4,0(s1)'
>linux/drivers/iommu/io-pgtable-arm=2Ec:332: Error: unrecognized opcode `s=
c=2Ed=2Erl a5,s6,0(s1)'
>make[5]: *** [linux/scripts/Makefile=2Ebuild:250: drivers/iommu/io-pgtabl=
e-arm=2Eo] Error 1
>make[4]: *** [linux/scripts/Makefile=2Ebuild:502: drivers/iommu] Error 2
>make[3]: *** [linux/scripts/Makefile=2Ebuild:502: drivers] Error 2
>
>Signed-off-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>
>
>---
>
>This one seems pretty ugly, but I like to at least have a workaround for
>the allmodconfig failures before sending up a PR=2E
>---
> arch/riscv/configs/32-bit=2Econfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/riscv/configs/32-bit=2Econfig b/arch/riscv/configs/32-b=
it=2Econfig
>index f6af0f708df4=2E=2E7a2fa9b37b1c 100644
>--- a/arch/riscv/configs/32-bit=2Econfig
>+++ b/arch/riscv/configs/32-bit=2Econfig
>@@ -2,3 +2,4 @@ CONFIG_ARCH_RV32I=3Dy
> CONFIG_32BIT=3Dy
> # CONFIG_PORTABLE is not set
> CONFIG_NONPORTABLE=3Dy
>+CONFIG_IPMMU_VMSA=3Dn
