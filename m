Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26B3208
	for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 18:31:59 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 142so2575380pga.1
        for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=tELdPw6cFVNcMyBhuIyOulB/MhXq/rKQ1MSMiPfWj5c=;
        b=y6Q59yYYpbQekqcn8P6vPhRbEADfwYvjlPI62C8YD2vXLb40XRQYIecXP+TjzB1GOT
         tcDSfSHDD7Uw9P7hrK0Q8yHEJEyAucCPUYd7IbO9ScJmETl0dTJW5LQSNfbXPUBlQVu3
         Mn6pWksO7c49TcL0JLtGrmjcitT51OaAWGm4MJoJMljsuSu3bpAeUW2u6kKS3PzbVtRW
         yp/H1czioEipYvzWtU7TdBOGRkHMA5KLduBivzJKW/racpPMfI6KnxQ2EZESUQD7NV0V
         0mZCnZsdEOlaub+s/UB0TRAcjasOefUi29XqARGOCcv86r7honzhsBzKnMbKnR7aUHvb
         IkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tELdPw6cFVNcMyBhuIyOulB/MhXq/rKQ1MSMiPfWj5c=;
        b=RMhPYC4jNBHtLLeEmiAr5+XpQ1vAmLsBgBNXTAELNf3uo7lwq0vlx8TkPZEoyzJ33t
         atIg04ty7Yfg+cbkfxbAGlmqlQCWUah1ZjidBst1F6EyqoVE7z4xcK82pxq/obOWuW/4
         8+ktLbQjDmqhXf4SG/v0ctCoG0ADDx9feBlVsXLzSxLJQRyRhZamuk66m7oSiOLSpNFJ
         OQumAxFIdCfF3A086ZiIu4pWVA8i/EyGhwR1/6RjyV3I0qUWExIDCVK4J5tEONZYDxYW
         2wgdvd1GF/TPqVJqeTeJgSyCHAkEY0mAOz/Lm4P2AKo73DPBS62j0QgLvZGNyzAxVcmm
         zKIQ==
X-Gm-Message-State: ANoB5pkGvugape2/05q6knJp9WuCJmDq3l0QIjtQCJadnySWtWd4+yIu
	yVNOL62NITAmZGmEPv85vwKQuA==
X-Google-Smtp-Source: AA0mqf4HzKUoz5ydnwk633gHlvihbkPu5a+uyaupKo07EXeqhOttetSGXnQzPJJj0KTpewQOOM5JkA==
X-Received: by 2002:aa7:81cb:0:b0:572:8b7d:f350 with SMTP id c11-20020aa781cb000000b005728b7df350mr28816199pfn.26.1671042718997;
        Wed, 14 Dec 2022 10:31:58 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id d5-20020a621d05000000b005769436a23dsm153889pfd.218.2022.12.14.10.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:31:57 -0800 (PST)
Subject: [PATCH] RISC-V: Disable IPMMU_VMSA on rv32
Date: Wed, 14 Dec 2022 10:04:09 -0800
Message-Id: <20221214180409.7354-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, arnd@arndb.de, iommu@lists.linux.dev

Without this I get a Kconfig warning and then subsequent build failure
when building allmodconfig on rv32.

WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
  Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
  Selected by [y]:
  - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])

linux/drivers/iommu/io-pgtable-arm.c: Assembler messages:
linux/drivers/iommu/io-pgtable-arm.c:330: Error: unrecognized opcode `lr.d s4,0(s1)'
linux/drivers/iommu/io-pgtable-arm.c:332: Error: unrecognized opcode `sc.d.rl a5,s6,0(s1)'
make[5]: *** [linux/scripts/Makefile.build:250: drivers/iommu/io-pgtable-arm.o] Error 1
make[4]: *** [linux/scripts/Makefile.build:502: drivers/iommu] Error 2
make[3]: *** [linux/scripts/Makefile.build:502: drivers] Error 2

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

This one seems pretty ugly, but I like to at least have a workaround for
the allmodconfig failures before sending up a PR.
---
 arch/riscv/configs/32-bit.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
index f6af0f708df4..7a2fa9b37b1c 100644
--- a/arch/riscv/configs/32-bit.config
+++ b/arch/riscv/configs/32-bit.config
@@ -2,3 +2,4 @@ CONFIG_ARCH_RV32I=y
 CONFIG_32BIT=y
 # CONFIG_PORTABLE is not set
 CONFIG_NONPORTABLE=y
+CONFIG_IPMMU_VMSA=n
-- 
2.38.1

