Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C57178CDE
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601133; cv=none; b=bvtdVI/zQt8KaI7PLs4cGhRZ2LWS1bUcK7olHItXr6f3Op33HpMS5vqg89ygDMfqoTPydxbXHPy6KbiPMEHc79kKeBMWcpDhfbHL1IabQCvsvVt5AZzpUUCc+NFtB99tmAtpz6bjmeWSEBWfMW/3AL01dLdrJSN6EwN00XLupnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601133; c=relaxed/simple;
	bh=Fk34GaC/hTLP6m0UNDLPdCaDiAz8BRxxGQykrmrUHjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMZ78XKMUIr1Ijxsa+sSHj8a+H7OezIN3Q4PLJ3R6eH729uadV4YsoWgfqsQ+BTS3KaTwCCZZcF2bZ+QzCa1GTE5PiMt2qjrHbTCPxXjdXCd+cX6LQU8IRoZ+LqHRREV3LKk5VNdQNYGxG1liYstp6IWXUEQjD/u50MeSTO0xWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V2QBqcA3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V2QBqcA3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso6011975e9.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601130; x=1732205930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sV1q1LQk/q83S2J2BpeMk7gg4mJdAxo4Zufy5rZGAM=;
        b=V2QBqcA35Aj0DB8DACUm+ruK4hm0N85oWOxjVxlChVa3Q7T/5DOdKvpdzX2nhwXMp+
         14/FZK64y3OUpIZXuxkyCnFJJT2UVNJg4F1+MtJLTiFKjpOzZ3HlF+2YMN8XuDYVBDli
         lNQXsGfMIKvl+E2nDuo1SrlsLiDVLVStE8/3RH8Ku0+otcbQTdocqCMVG5/w1Ydzh27V
         +S6+252vbmcjUTvu0TSPcGm3BXODNH20c50PFNXkkAFEGjynYDVeUzh3UuVSe5keGddr
         dSMzfN2Qe2VnAl+c28GmrSkkOAK1dICP479/k5eldaPBmJqg4DAgZhxHWNUuBk68qbF0
         iezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601130; x=1732205930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sV1q1LQk/q83S2J2BpeMk7gg4mJdAxo4Zufy5rZGAM=;
        b=Y/HlS4Lnm3H7eFGwxZscI2Q5eDE5WntwzkCI8p7p8etA5cDc8zG+Qy0riAxU+fndhj
         OEz7zm9Zl9pRItAuRNC6P/vu2xktUECD9MxkUQniiIq+JoaQIiH7VWrwudHS/qnK2oQN
         hVypoIOEnxeB+djf+x354xa8mPhWpdLeZEAsUNs8rTjAB+ymEWkgdP7PCrP4xlHxu1J6
         PL4ozEstbTGAEGU2k4OrLYTWPEq7MOej4EwaG8Xh2EQ7sJFXAwFO/D+kAkGWLd6r956E
         G15k1OMJqchWLfzvBFljPqJNlisjPGivzKMv0+PaanTnWOPl9zgja3VBkRwgRJ/+mu/K
         9nJg==
X-Gm-Message-State: AOJu0YxcLmNTSTyAQmJs85yV/cmFNyGxg+4qHyQY3uG5Hnzw2KDgUtjX
	pthuZ5MkXB+TWLlOIzE6BWoBeYxqbvLypdyo1ql0D9w1msvvGylM8I4+cUNcAFOGITJ4+W5HLNh
	nWgQ=
X-Google-Smtp-Source: AGHT+IG+PIdlvaNPVTcrNev34iOeURvR6kwzzOllPVjWxdCbuE/GqDAX+WoRpo6pTqFd8njujj53Ow==
X-Received: by 2002:a05:6000:2a10:b0:382:2084:19b3 with SMTP id ffacd0b85a97d-38220844ac9mr1324585f8f.22.1731601129621;
        Thu, 14 Nov 2024 08:18:49 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265c45sm28633555e9.11.2024.11.14.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:49 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 02/15] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Thu, 14 Nov 2024 17:18:47 +0100
Message-ID: <20241114161845.502027-19-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a domain bus token for the upcoming support for the RISC-V
IOMMU interrupt remapping domain, which needs to be distinguished
from NEXUS domains. The new token name is generic, as the only
information that needs to be conveyed is that the IRQ domain will
remap MSIs, i.e. there's nothing RISC-V specific to convey.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 include/linux/irqdomain_defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 36653e2ee1c9..676eca8147ae 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -27,6 +27,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_MSI_REMAP,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
-- 
2.47.0

