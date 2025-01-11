Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584901B85D0
	for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622011; cv=none; b=WCEq2iFQwZtNXCHqfF/dVl0klNNa06+JmnKoQ3b5qWO8r5ndl3OLczgPKgCR3Fi3OxOyq1XaBqoNFUx28hck2SruZmL9sFJKZgwGc8v/B8RLsFnJP6HJ9Ky19EbR/mkG2hkfgwR3I5IZuS26huZ6yz4CtyY31kH8/0ZOyy7vrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622011; c=relaxed/simple;
	bh=w2RLalgguC4wcmcCrxQZEvgRN248gOCpyiQk92eiW8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E22/j/TTY6rodQPNle2T2S+JwI8L28JLsPg+CV+M3mQ0+ENO45KyhTkny89Rdn9leHO+qPNzkldXRtTDNwDkqglLB6AMHatqihdiOGW/w9aXWZPzCvwRG+Q+mgJoc+8Jcp3kSUs/jz+tPAgNy4WKpQ6fwZbSYY3xhHd95kmwD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFodHIYg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFodHIYg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso4374225e9.1
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736622008; x=1737226808; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83YnfLV99c7425ULqd9YcQOCKGkrgnBiUCwGR41A70o=;
        b=pFodHIYgxvBLDEGjVzuj27iYQYL85r2a+6GJBZFwGqBBY/21LeVGSOBsF+dEUdC9aE
         iXil9dEmDXxGLR+zjl9N92S7tDaMuBk2ZYQL08VWl3XOvSp7dF+5duJ6CiFwDlIbhVo/
         ZNxpAIJcdHwKtPd7sh29cx9hwufMHf/j+e54teR5QC+0joh6k42YQ9+XZLkdyrpPKU4I
         XI2lUvC/wycnyqDjcbksjkPR1KhJZoyT6sWYlvZpBs9jSU46/Fjzd7ela29RCkrtXPKR
         mCt0uQquGfdJXuoTPGE4+Ls1BCIVsUx6I9T07/N8e0loARb2Fjdip2RidNEh5KSZBws5
         deSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622008; x=1737226808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83YnfLV99c7425ULqd9YcQOCKGkrgnBiUCwGR41A70o=;
        b=XW7cLxJVrpPG0e+t4+ahIiFvP2n1nPNgllX/rATRT3QgNtyg4h2R5WoTrtHFHO+7AM
         ePS/MfazbKpJEVhriBXPRISl0YYTtELYrWwQUHbdxPpFCmyKhB0z4P6dl53G5NsM8OmR
         X9eMsJLAgnVZ+9HMjIqi86pYuFI6RO976r+1Z0s9QKejOi8kccKEQYELq4nSaJpJSMw2
         xGULvbWZCkES4gd0QDlkLfv5JsBVrXjm9CN9byooNK46w4r5Ye9nSwQ9cQEE7/nhna1O
         UkfAwQRWC3w10Gd73dOqHz4G2YuPsTc1RPwRUnwTeMJSOlmtFfr8GjCbyShAGSNfJ8tY
         X3mQ==
X-Gm-Message-State: AOJu0Yz2M2ZWOWnm/2H58k1bdIPzZkhqg52OIdW+kNEJYylawZOha3lY
	KG3cJV1sjBZIXX8HCJp8Igt8UYSr+w57DJUQYTVPSVCQl/C225eNbpozzorqDLA=
X-Gm-Gg: ASbGncucC6bH8u5/u1QKQJm+mFTBSQOV+XLaG3Iyz0TvMYSWNnI7MLKpuh51uDNe7EK
	fOrLdHOKAh6SfR45k5Ki87GNtGBQt8L0nJ/FZKt+hwhxuB62eZdnWUBFxZNTs7Yx9OsjiD9/6ox
	g/yyPCuWT0BnMYJLzGFBp8H/YfKDHzrx6BCsGbPmDcG+7mWSaLKbN1+oF3vB0wjQ1bE8dAJHXF4
	bn2wgbQHIK2tBW9MvtMtsaq0z5d987KFX0YlGGQXFW4UIHl8s/L1UYmyQvaJaLH3yelYUks
X-Google-Smtp-Source: AGHT+IELQO/OxTr5IXZCsTt3zJMTR1Diaau7OFJ11SNSSvofDLey97QdtnPb/Ld8MtAYleoaOKhKcA==
X-Received: by 2002:a05:600c:1385:b0:436:1b94:2deb with SMTP id 5b1f17b1804b1-436e26f556fmr57845815e9.5.1736622007736;
        Sat, 11 Jan 2025 11:00:07 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm91309075e9.5.2025.01.11.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 11:00:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] iommu: omap: Simplify few things
Date: Sat, 11 Jan 2025 20:00:00 +0100
Message-Id: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALC/gmcC/x2MSQrDMAwAv2J0jsBSl0O/EnJwYzUVNHawSGkJ/
 ntFj8Mwc4BJUzG4hQOavNW0FgcaAszPVBZBzc7AkS+RiNC+NteCm8v8EkxtMdS6rjuyJLrynfm
 UzuD91uShn/97nHr/AatGR9RrAAAA
X-Change-ID: 20250111-syscon-phandle-args-iommu-2ea162b223a4
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=629;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=w2RLalgguC4wcmcCrxQZEvgRN248gOCpyiQk92eiW8A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBngr+yHwT2CYIdMSwSBejwoZJi06/jF4kSiIAhc
 PrwCXSsJt2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4K/sgAKCRDBN2bmhouD
 12pTD/46KozNwCKqZpYIeZshmkdZtABBy8WpNFremjg8L6lJOKxsqUpOX/ry9ci5PK+8hzX6rhk
 Qzk5TvQLy1NYtAik6M+95cFfnKmvVWh9kGmvkE8j/oqvMbjNEb5SpTglKIYrMHMgcf2ZpDS8+6v
 hsMUHguzLXzNf4qWlG95WX1URFlM4UDlHO6Hx+1g0wAlS+CTTzyvRJy1tFaw68QqXBVoDHbou2C
 lLNua9I3l9DQFrCQV4yNTGBfTGZN7LY8okQIJ7EvIxHWACpfWWEgk3KoH2YWLtqsf/K/9KPwmvg
 WjcPuozn4X96bHXGaNmAiT1DAofIGq1afMvD7BPDg0SxOYzWHP7TmDZ7n/PrMTCqXiTI8hdjH8h
 WSuaN6PYQekukfpYCJOC5QzMsMocJcyuTtZ+HydxRmgWCLwb4fR3Pu1Q1nP5CAI18bXvuV28Mnm
 7uNCLaABd/NRaAgtYIDYx4zV/vOzw7TKrUbSJxPmOdToIIZtp6bnt8D3AGkvPoK2ol9GnlLrw3V
 rnOlVHgaLVHiJ9Fl9xgJY/vAxVPfwf8JL90lOy/XVIMLzR20NpulQ/NwRehAPKpZFG4leYm4OHu
 MhSd/Y9rtKhgb83o9tZjQtUXIKzOl6JCduThAMTxAdkXnyLKvzrWZx1V6wy7Qj7ZMcnNBQy8GOR
 R7qSvO9UrLzjaPQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu: omap: Simplify returning syscon PTR_ERR
      iommu: omap: Use syscon_regmap_lookup_by_phandle_args

 drivers/iommu/omap-iommu.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)
---
base-commit: ed46c89bfab3e10f8c38d95bdeab32e1c5ff82f2
change-id: 20250111-syscon-phandle-args-iommu-2ea162b223a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

