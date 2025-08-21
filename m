Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD0264624;
	Thu, 21 Aug 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791870; cv=none; b=SD4Hcl1CA9+8MYAhQD3nMihE1UyqfmZDbxcLgYyPuUDix+/QWVx12XdSf3RjaVBb7EOMfAGurZmo71XmG6V8LJnM7adRd9wT8BPy2LsIMaoccslFO8G/6CydYlJvtpEgtJwE+HFjA5FOkiED6iQsavc9YNoFzXrJ8sRRN3KScro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791870; c=relaxed/simple;
	bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWM3bGT5B28cAZ+wnsABsmLPBEme22CcYoZWNUD2tb5iA37RydQxb26YadiWJcPlYcGGkgltSp9PMgEk2TsKgPHpt1qHlUSxnvP4Bwys8muiJbm8YL+bUpDISz6jqjbIPqOj2QQbj6V89l0VsNkl6j/eAWb6OQwZA5TlQ9JQF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZgtZUJL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZgtZUJL"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1054859b3a.2;
        Thu, 21 Aug 2025 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791867; x=1756396667; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=nZgtZUJLZWajGbiA9JZs1q5WB31egw5OoRuojVE3ejcat2JiFbbQWLIRUmoaK06w1i
         rPN+m6o1SB1YBY6XqdhXZ7+TRV5JeAI/XM18FariQmb+82p0YgjoeO6Pnaif4kQvxJC0
         1VJiKH4CG8e9O6lEcN2ec1+6Z4zZiQCYR0tL2YKEoDyMuVpToiiSPMiS3hyavZKG4Q9w
         yDo7xgp+AJNL+zmyN0eZeUerG/IpF4rBlh+NLfDBm6vrQ8soUCLjzCG39YjyL3G/+oJS
         S1iQRbb3f5SYfhwDqdJ0fikjYY58fEhmR5yI7GklB4orMGKBqjzYJ2hJgoDBl4y8zcbT
         1rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791867; x=1756396667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSlcmBn836lmKLvSRFZVTpwMuANIj5L8XhF7F6TdWMg=;
        b=jWgupaci7Q89si8QUKPK1ZYCWbyxqYK4XndST70+i4voW0KTg6IcLqwXfQgEvII4vV
         JzNSwONaz1dXyCV3zkLvySV+P3fY+6o4QI0UbnD4SYEwOoEnFo/IWfhPAe8SikSAdiIJ
         7DncHVAM3jiPCHzuBcpIpSz1YDR9THiSxeTltO8iq51Wkv32+QdLKwnK3GMaArvr7B0r
         gsOr/JuDz4oHaLxafoBK/DthSdMh+Yjb8fc7laizuitOgdU0sfWGScoOn0ykoC4lEpU+
         3MPNiftN7WIR4DSFt0HScI5DrFCKR5oyM30qEePioEmPAI3QEYl4xVfxlXRWXMEAJDgV
         ikHg==
X-Forwarded-Encrypted: i=1; AJvYcCXr9fd0S9sg5S6zFHzWOUUcDtGtMdBUiBkBgl8uFQK9pCXmtM9/3JCozZj6tCAUAUMzXgS1xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTfj4OOiMrm9edbLVs5gMxGKe2MKBCtCLGxm/veOvKPGH+elpm
	3EiBfyj7IeThzPQOPBpHBa85H2VPZY3LzxL+BWKg2jRpp2Pg0eIWzVwHlgpN4hoO
X-Gm-Gg: ASbGncuvK+oIzN3nnEXBvmvsxQPkNEQN4jv0YR8T7wSDrfxm1/mnI4PphO5iUkgDPXH
	9r9/YIHghOwOgIiIAXer9XdkZWoaGzCbQ0OKmez6vAecX0SB4senLXM0wLXMyHIHwMjSxtxg0mT
	Q2VbCWVPsR/R/Cjq/7T48o7IVBmwIGixCMhD+NQyqg4/Nbq5oahwubG1FiDHjJqBw88KBarWyCI
	MlGitm0c3FEShGrZ+r1cZT5e3VnwIp2id6tysGQ4Bf3bENj5amkv4b17mEEvyFIZEid/rEYigjb
	0nRiHob2rXenMbWS3kBg94MJ8WvcgD/fAgW2BmldX4Gc0r7avIQ7zR5iMoBDWvygEBlW2Cigo6f
	OiGcOgg6fK71opN2OkpaChWtqqRvuPRmSfpDOPXoom5offKQ=
X-Google-Smtp-Source: AGHT+IHE9fgaPPSfoST2vYimjcU0YIs92qxt+lOf7Yhtfyjt1G9Z059hmKnvX2aribVrwcXalhAGdA==
X-Received: by 2002:a05:6a20:2591:b0:243:78a:827b with SMTP id adf61e73a8af0-24330b47cd1mr3790459637.51.1755791867100;
        Thu, 21 Aug 2025 08:57:47 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:46 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:42 +0800
Subject: [PATCH v3 5/9] soc: apple: sart: Add SARTv0 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-5-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=wJH6bCh+c84MG5dltlJIecbSR1A7z9mKknCoraX6plo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUSDKOE7o9/KxkLrLGisPDzdwRuzUZKZVkV
 7t/hhYav/uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JEf3D/9MTNaRSanW5d+XC6IKcZa3GXuBd2THZSYlnSMl/pfWwiWIbQF5SB4vv859yM0RFDxVNMW
 enLM8hzLdaD5r2oRWcL96Nod5A4EqiuZvW7aGis8F/E+kjVUPsn0xQnS8lKuZNWMBVNoIzSrUor
 E36L2vEbycW204QtjTRjwf14pH7jPEkmqIOnT0yO7nvbEVTdydbNO3uUX5g5J0Yro1eWXpUAEs9
 m5W1CEKXBGH/T/KB0xVf09DSqJSBXaiEe+sd4ApT8v/HZsUSZ3+pazTwk3Yqk/OLoVS+NfVM6bb
 NNxHirWbh0or9sSKaZ8OPRYD6MiFPT3WdjW5c8ujlR0xZ6yJvP9gKV7ERuEGuNo3gw75yI4pihD
 zYHh/7Wz6gnBZR129m7mJYboTPn17sO777Khk9lxyD+0V9xzfoUnr2Xf4Jr9qObs7peOHkrsBPP
 Pzqfj6X2P92L9oQIEVLeNNHpX2YcMNtQ9V1g1T2De5yCIX2Z/eLYXFOef1MDbycGXWyE7XA0qaL
 ED2IcpHnSfBe1Cy7gsLVY2znvNhiELVxQ4bvEB8tKDNjhDpDtYla2IpttmBlFMuO5VGC75iyJ+e
 C3heKdxfJwbYnLLkrwskHcN2AWgVDklnhvps4Hzqm8M4NlL6XHB39DsxPtEVp6Fdiv7QrtH6EnO
 XKmwQT0EXEP0rjw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 318f6e518a54f6edb8b97e320519df8f77c7f143..4ff1942b82a74cabeda99540ba63c6e92386986d 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,6 +25,18 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
+/* SARTv0 registers */
+#define APPLE_SART0_CONFIG(idx)       (0x00 + 4 * (idx))
+#define APPLE_SART0_CONFIG_FLAGS      GENMASK(28, 24)
+#define APPLE_SART0_CONFIG_SIZE       GENMASK(18, 0)
+#define APPLE_SART0_CONFIG_SIZE_SHIFT 12
+#define APPLE_SART0_CONFIG_SIZE_MAX   GENMASK(18, 0)
+
+#define APPLE_SART0_PADDR(idx)  (0x40 + 4 * (idx))
+#define APPLE_SART0_PADDR_SHIFT 12
+
+#define APPLE_SART0_FLAGS_ALLOW 0xf
+
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -71,6 +83,39 @@ struct apple_sart {
 	unsigned long used_entries;
 };
 
+static void sart0_get_entry(struct apple_sart *sart, int index, u8 *flags,
+	phys_addr_t *paddr, size_t *size)
+{
+	u32 cfg = readl(sart->regs + APPLE_SART0_CONFIG(index));
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART0_PADDR(index));
+	size_t size_ = FIELD_GET(APPLE_SART0_CONFIG_SIZE, cfg);
+
+	*flags = FIELD_GET(APPLE_SART0_CONFIG_FLAGS, cfg);
+	*size = size_ << APPLE_SART0_CONFIG_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART0_PADDR_SHIFT;
+}
+
+static void sart0_set_entry(struct apple_sart *sart, int index, u8 flags,
+	phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(APPLE_SART0_CONFIG_FLAGS, flags);
+	cfg |= FIELD_PREP(APPLE_SART0_CONFIG_SIZE, size_shifted);
+
+	writel(paddr_shifted, sart->regs + APPLE_SART0_PADDR(index));
+	writel(cfg, sart->regs + APPLE_SART0_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v0 = {
+	.get_entry = sart0_get_entry,
+	.set_entry = sart0_set_entry,
+	.flags_allow = APPLE_SART0_FLAGS_ALLOW,
+	.size_shift = APPLE_SART0_CONFIG_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART0_PADDR_SHIFT,
+	.size_max = APPLE_SART0_CONFIG_SIZE_MAX,
+};
+
 static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
 			    phys_addr_t *paddr, size_t *size)
 {
@@ -319,6 +364,10 @@ static const struct of_device_id apple_sart_of_match[] = {
 		.compatible = "apple,t8103-sart",
 		.data = &sart_ops_v2,
 	},
+	{
+		.compatible = "apple,t8015-sart",
+		.data = &sart_ops_v0,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, apple_sart_of_match);

-- 
2.50.1

