Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003D258CFF
	for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833214; cv=none; b=Cdks+/YAUJm5eXMIva01/1mOiMaJQ1e0YBpu6EgW7ziUhoZUmD/YrCiyK0tKct+I0U7Ar6xy5Izht8dxxrQOUz2ToioR+UJqhW6Ko9C3TkZq1AA1hSI57umKNulBjziAkOaGG9CmPAJBNXIttjxmpB3ephfLZdrktVppXcOMhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833214; c=relaxed/simple;
	bh=3DgpKVB/pSLud0xT/8QtkusLF9mlVr6jh1ABunswCBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qro/z2TqU0OGQ0K5jUK167fV/V1sJm4u9VeopA+89B1rS3TeW3tHHajrHGk0zcsJsd77aZCUZ9jaUMtbmKcSkX1MeHxL8BgyJms1zZkJeVJCnidqs3vawYsV/quMyXzIzvpzBDzo8iCLOXVkri6c74sUWgcSJjDcCdEIowvSNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y22Km4R/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y22Km4R/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so903710f8f.0
        for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761833211; x=1762438011; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z2y268+hKCDediNpvDReY8JSoVIK2MB3lP7GMYcaQM=;
        b=y22Km4R/aO1ygftmvCIbCe5SUU7E5aEyvBmGfJnc/w8BxEMgw25diSaPwpt+oxLxCN
         YieJsYqVOZU7vtkfFQO14BhRv6PKoLGQsKgbQR0lyNzZn/4VxVBqmHQlpvT49cLONUrl
         lu2UECr9HqRuBE1gvlDgeuqSfUBIQpPd3kpuAPEXmhyBAJ+AQDq9Kg2BVMssxw87h2cm
         lCRULrLPb9Wp9GNGGS7M7TLAV2rfhicUFltgW8Zqiy+dzTOXGPKHt2JdNlvuNFf3pHPA
         cJ/qqYUjFcks5IoFk6SVw5qMEJd0dzoqZyl8X1xfAQxiWS8qGRj06nPqTcaif6LSw1ap
         1K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833211; x=1762438011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z2y268+hKCDediNpvDReY8JSoVIK2MB3lP7GMYcaQM=;
        b=DXuP6LsutBh0KAV2/z90WaGLfU1oXBJc1mU5nWAfSE+LbMKtC0si8CQ4qtyqryEUtD
         N+IM5DLpQZN/dUT/PV/N+s7u1S3m1LsjGJ9pKDl7az4NfJwkupDkzEGVobphN41y6njx
         UOvjSs4CPOGjpOY1zPE6uqiJToJS8Vyx3JqFOo8CtInCYjy+8WnmWVoTirDbGcpBtg+B
         12jpVyXfbvz/cSCCCh5LIoXdM0d++RvonkR+fSyn02VsDr7WVIAx5YOYuuIZN3x150Rd
         cI2xKajw4QFz0aGECp0pwVrOZ4jrQH2f8Opjsd44RRtSE4Gqe6zr8rXuElnCb02Y/t/n
         y/Sw==
X-Gm-Message-State: AOJu0YyOcmReGQe2sYelIziA9YRCTp5stMY5IgqNrdLJy+L6E1eiySDD
	Ry+Yxnub3ELw8KHk7oZ6Ym1K4P+oLCAEw7mLu33aMI8JmsjrJt7K4k4FypJXeoFmi2g=
X-Gm-Gg: ASbGnctx6MYI3bFULdMehamYYKoKqltng+q2ntZxjUAYxBdrv/xKvtDLagru0mpeWc2
	Qg41pBseH1tpY2FAfw2s2O6HBTJAfm5s2gqINc+Q94R75Dmy238lHlvNobxUqTEzSDSs284kxcr
	FFCUtIQwwLcx6OlpfSyhHLEmC8g+0ayXg4SYU57B14cVQzu+6BZ4zZTyaiX+zxk1LacwlUWFojl
	IKN0fuuryWbjGNQnG3orFZz3b9+YW1CgtYCCG8+mVkBNeyyA6pSyu7aIoxTpywi54+RgIXWy6E7
	fWsjxSESfCcxrtk6ml/6BrNWRCwGSlPPEQriMdvxeCydg9/6yggWbO1hUNzOfhJqZWWRyYmkElj
	4tX4JJ+spCa/lYB2B8O7k8U2ZTOGQpAmJZrbrsgZ4RjF6paN5/fpZ8DRdWa44oggRnLSRMQ2eb8
	bYLPfCf0Kk6w==
X-Google-Smtp-Source: AGHT+IG6drLSzISITQtrS4jmzAyvc6V24O7Wr+2A7hxxgw0K0PARg4Kgeq+PQdUUvgvdHjEJZwIocg==
X-Received: by 2002:a05:6000:41cc:b0:429:b751:792b with SMTP id ffacd0b85a97d-429b7517c53mr2017418f8f.32.1761833210892;
        Thu, 30 Oct 2025 07:06:50 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm33438674f8f.26.2025.10.30.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:06:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 30 Oct 2025 14:05:27 +0000
Subject: [PATCH] dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-james-fix-dma_bit_mask-v1-1-ad1ce7cfab6e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKZwA2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3azE3NRi3bTMCt2U3MT4pMyS+NzE4mxdMyOTlKTUJAvLxLREJaD
 mgqJUoBqwwdGxtbUACyPxD2gAAAA=
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Guodong Xu <guodong@riscstar.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Clang doesn't like that (1ULL<<(64)) overflows when initializing a
global scope variable, even if that part of the ternary isn't used when
n = 64. The same initialization can be done without warnings in function
scopes, and GCC doesn't mind either way.

The build failure that highlighted this was already fixed in a different
way [1], which also has detailed links to the Clang issues. However it's
not going to be long before the same thing happens again, so it's better
to fix the root cause.

Fix it by using GENMASK_ULL() which does exactly the same thing, is much
more readable anyway, and doesn't have a shift that overflows.

[1]: https://lore.kernel.org/all/20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com/

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8248ff9363ee..2ceda49c609f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -90,7 +90,7 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
 
 struct dma_iova_state {
 	dma_addr_t addr;

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251030-james-fix-dma_bit_mask-624dbeb89afa

Best regards,
-- 
James Clark <james.clark@linaro.org>

