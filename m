Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3A2E283B;
	Mon, 18 Aug 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506630; cv=none; b=BvnMywuid6uwS1On6vLSEWlusyLd7Xb7prH/6TiVbMz81SeAAOvIYenqhh4zad9ugKmBzJmW9XiQe7rGoBfVTsepRBmil1e0DXrNYXZFdYdD1DyLWyQGPkmhzSoKIKcUGF+9IxCvQjT+7cOuxfT8g+zQdY93Nhg3GsvWvJQpAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506630; c=relaxed/simple;
	bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIx8sNHmjzehOuVczlIfCLaVV+O8Ir7qvArpjJ4aUo1iuV3O82jV5ev6QLzS4djeywEjwDT/eZORKqdTAqbYE6Vr2bjyeiTuCCH7xkAdNnxNXh5N9XqvEydPsFizyQvGLgabAiOOaHL3uKbP1pIReA78MNilrQo+bs2b14PNEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtxRgcOo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtxRgcOo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244581cc971so46302635ad.2;
        Mon, 18 Aug 2025 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506628; x=1756111428; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=GtxRgcOomAYRhsimUmW6Y1AYRapR1OVI0K0Yl8MtEdP2+ID+BPzR0P4CdmSSggJH8p
         Xe9GN5lRR1aHBXedpUOHkBg9GqYLsmkOqtMh43qs5WGS4n6NdbsODHDpeZlaL5J2MkkK
         soIhUzZpbnjOMJ8lWVK3QlZTzy8FcvzKWI/ZxPD29sBBo05g6XmRG6//dr35q7sRz4EW
         WLfS27mfZCatUCQSIXnTmy9No1UNgOkT8d8ifMbQiNSI+lkKsPSk3vqLaJK2iIsg5iwa
         3zMyzee+7J6TzgFkPSMwIR48EgqqB9oDheY7585rew2ltZ89LD/JQwVkQ1mzkEEDF3qV
         7Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506628; x=1756111428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6d/3iSNfW69zNSjSYVLBPlm+V1j+wnMpITzuYS4AA=;
        b=pVYpoRY3vM+qg9NZCSSTQjYY4iMRSwbAvkeSxtVT0ko9lDdzIcD2CTmsNwYGeO865D
         xArG0hfuB0SHOONH0X7E8ELZPqmoJZTOfrBJ5kxjmP1wSWOQ0xYQLcSq6neAVMjf5E/0
         JF3Z276eS9fcgxc2cFKYuy6DuvERzrJHsOZRjmssvXnvtvRyN/g3tM3ztjXREu7/17UA
         IIXOzDl/CNls+FcuaNStTwi5I84ydNQv3kIKZKHnnV3e5t5nD0ZN8jTRmYItVsJVcXMB
         EV3wiMnbdh+PeTJETxacntmPcR4scggmRjed/Tykhwjy11jWcXf/Tx5C3eMgXH1SrhHx
         fInA==
X-Forwarded-Encrypted: i=1; AJvYcCWHrQs8/sjKYBd5dWgC6YD3asuK39kinZq1cy8+S1ox1X8i3yeptbLYC4/U3iwfxePuaoyi0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBJJ1bGX/Nx7cr4869zcYHrEa/uxSGR4wmTk/I0W2F5AKB8PQ+
	lkMJLTzPjre/ZRMP3LNPyF4Pqc2Tup676veZSFV7Ifwdxkz1v5yom/5F
X-Gm-Gg: ASbGncvHeXaSU2OZkg/4f1dWmslwra0BA4Bg4Mo6dgjw/81BVi/PeqBwm2VaXNgT9B/
	IdCXcWvt9+vz4S8bPksYh/8Lmd9P7/uzEo9NgYKlEWPRiPzCPr/nWz9atMFX8wsZcrNVoH0qJx+
	ozOXLCdAMrSZ5WaVvSO/AgP8ZD/pJKh/8UHgxfd4LB63bf37HYdUQM1pHaSDFNWQQAkGwaRtGQy
	sjpYBogXYaBPVqJaKIfwt+bad+q6Oz5qOnn7dUk3hHLyW8n9/xTRGN9UuoyePRBKFyYjdTZ62/y
	wxNIbm6+sgCXP8DLl+Yi1R097CCH/gS4jsNeK0tamO7Seo1XtcUTTMJ7iS1UwaTmG0t9P1B9h+Y
	agOJmrrfDC9e/rMNB1QtokqFXlVrbAjl6i6NYZlTWdLYVcAM=
X-Google-Smtp-Source: AGHT+IGE0067BnqCsNs4bYtEQYzzJ4UirziWwa4iYUzmO8cpWyztzcvYDjdk1rlUKAgEjbaBIMQQEA==
X-Received: by 2002:a17:903:1a2c:b0:240:50ef:2f00 with SMTP id d9443c01a7336-2446d8f407emr157641995ad.26.1755506628132;
        Mon, 18 Aug 2025 01:43:48 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:47 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:57 +0800
Subject: [PATCH v2 4/9] soc: apple: sart: Make allow flags SART version
 dependent
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-4-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SfdgOsOFi3dLK60ZgLb2wBFpqlY1bGwIVMJiWwSGmDY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouellqqMH4V1jKMBzMhHfZrJO3Ydy7TcAv3fU
 mzAcpZmYteJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JBSAEACShbYtnm9veqAOH7lI1/GZtCd7iTn7NwNjLKYJCZjq3yEnkhimjP4juRRTv5iz1xUuRmC
 MXxW7WqQxAx1f/aAGdD3IYPSjtyA54MWPXesBRUkI/enofpJH+TW6uhs9W7FFPmC4rYBsDEm4fF
 V/5EUWfSYN8FJ2mC2mq+J+de/x5f+liD62wXjiCapu0CggzjOohIJ0+jjL6WVX4yJDXpfwEDIH1
 vjqtG116IqW76NfkHFZFq5EyaiLSprlAmFsio0rjQ31LFlLKFOkbT65OX4XKPWJreTevTOt0NZ6
 FnJ1VhTJ8pkSvRwsTEUKU8J0E21dnSj6U+rLdVfzjduUnqrljcgC2zmWUDW49vutVfb+KhRtZra
 s22lDgrQBFBX7vAaDR18a31ttMjPllD3YcEqQuZXkXpjKn38TizxwyLyiOcsw0TFmqWtGaKm5A6
 OJtM2sNKMDuW+w0vEKi0zY9LoAV261VD7WqKk9fCYFvQ6cdswkLoNYd8heyFHoKhwkFbhvv4PHb
 vJElNLuTXfiHkBUlGqeyRZylNvMCJkzvTbaD635wXjf/raQOFAhyR+S+CYSErzGqyVeJKRGXPmD
 rp53KBdtTrqzbJphtsxkJe/Adrm/HWWGXzPQJJ7sBf1z5a5SQ+gKiPRKrcVKWp23oFKxTKFAEaa
 5p1slDUgrXdxSNw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

SART versions that uses different allow flags will be added.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/soc/apple/sart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index afa11173689979f100a63221af03214f4a928a7c..318f6e518a54f6edb8b97e320519df8f77c7f143 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -25,9 +25,6 @@
 
 #define APPLE_SART_MAX_ENTRIES 16
 
-/* This is probably a bitfield but the exact meaning of each bit is unknown. */
-#define APPLE_SART_FLAGS_ALLOW 0xff
-
 /* SARTv2 registers */
 #define APPLE_SART2_CONFIG(idx)	      (0x00 + 4 * (idx))
 #define APPLE_SART2_CONFIG_FLAGS      GENMASK(31, 24)
@@ -38,6 +35,8 @@
 #define APPLE_SART2_PADDR(idx)	(0x40 + 4 * (idx))
 #define APPLE_SART2_PADDR_SHIFT 12
 
+#define APPLE_SART2_FLAGS_ALLOW 0xff
+
 /* SARTv3 registers */
 #define APPLE_SART3_CONFIG(idx) (0x00 + 4 * (idx))
 
@@ -48,11 +47,15 @@
 #define APPLE_SART3_SIZE_SHIFT 12
 #define APPLE_SART3_SIZE_MAX   GENMASK(29, 0)
 
+#define APPLE_SART3_FLAGS_ALLOW 0xff
+
 struct apple_sart_ops {
 	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
 			  phys_addr_t *paddr, size_t *size);
 	void (*set_entry)(struct apple_sart *sart, int index, u8 flags,
 			  phys_addr_t paddr_shifted, size_t size_shifted);
+	/* This is probably a bitfield but the exact meaning of each bit is unknown. */
+	unsigned int flags_allow;
 	unsigned int size_shift;
 	unsigned int paddr_shift;
 	size_t size_max;
@@ -95,6 +98,7 @@ static void sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v2 = {
 	.get_entry = sart2_get_entry,
 	.set_entry = sart2_set_entry,
+	.flags_allow = APPLE_SART2_FLAGS_ALLOW,
 	.size_shift = APPLE_SART2_CONFIG_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART2_PADDR_SHIFT,
 	.size_max = APPLE_SART2_CONFIG_SIZE_MAX,
@@ -122,6 +126,7 @@ static void sart3_set_entry(struct apple_sart *sart, int index, u8 flags,
 static struct apple_sart_ops sart_ops_v3 = {
 	.get_entry = sart3_get_entry,
 	.set_entry = sart3_set_entry,
+	.flags_allow = APPLE_SART3_FLAGS_ALLOW,
 	.size_shift = APPLE_SART3_SIZE_SHIFT,
 	.paddr_shift = APPLE_SART3_PADDR_SHIFT,
 	.size_max = APPLE_SART3_SIZE_MAX,
@@ -233,7 +238,7 @@ int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
 		if (test_and_set_bit(i, &sart->used_entries))
 			continue;
 
-		ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
+		ret = sart_set_entry(sart, i, sart->ops->flags_allow, paddr,
 				     size);
 		if (ret) {
 			dev_dbg(sart->dev,

-- 
2.50.1

