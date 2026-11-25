Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578227;
	b=UOU9aspWbSTSp2ZjQjdvuq1+EphpxBfmWWYMZVR6aRHt12OVj/LkmlpxEpTjYHdIhoPC
	 yjV4J2UFa1XtagIWvP5I4LofBUFuQ4pY8yAMGfP6yeVvAiksG+00R6y1YlkTRnFYxGplv
	 hv/rZlbWiNSS//xYwL5wVcGcICmd+rL92GBW0rbWhCwZFXC8YdIE3bGeysq2F9J7NI9Et
	 Yc0q94uPJxh17d/Q3wa1z8dyExqBmHle58To/hyyK7GQjdvbEvgzAs1CcQ+uA8Rjbovsc
	 te17IcWCLpitmz1kNvxCd+HYFF/ibas2/XHRacDkRta76RyVhUH1qhqqQWt6ytivFjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
	b=sUINiNqX8opqiCZ3Kt6UFjIvy1/RSod2g1uqYJreRpHOKb8Np9v04/uh+UhaKJjf8P0m
	 6ya4AGOXovMuMkSoS1Xrn5HRcXyhRLNGj2t/lLaPQff2IX2/kt+aVCTxkGpWTiKsSFiZq
	 nSMu6dq53k6rTgoWx5r7OzQn9a/R8BvA7YA4Xqjhv/AHegQT4+Y7yZzr4BiyuUIs4Ri1l
	 oavQvGjk4spWIPQD8SvmUOgZDib4BeOALtp9NCgVLZcLPJ18A+HbMHkGIJHEjVCp6gS+5
	 Q44NTZGUmZ8eJij6yCnhhCGGWk80dk9nmbVoxI3gXDL5Y9Y5zIgZPnQRcMqJKnDxxAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zYj/xSns";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B66606A323
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B66606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYj/xSns
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so48219035e9.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578225; x=1796183025; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=zYj/xSnsIL6wq2qOe9ogN4nGBUStf9/yMFAnez5GWy16uOZiGqCHXzWE8qPGO1bIcK
         +3Bo8ehgCaOKcX7bj78pTOiHTekkcEtxT1QEKLOzB6vWpfbOuleDV4m4CnOPznL9sUr2
         omOtcBy6++b81oZHgzIKj87TUJtiuCUHO7Ibt/jzeoKexrJYtgRajFivPmh06SuNd133
         THnV8xKEdKZp6w7dGC83DZFD4kDMTjxETWVj1gJZ9grtrYsQ22nW+nUOhlkPd0RJmoDq
         s0GXQoKvzJBuZs92SpH9N4w8D1900TelnuVXUyqvV5xTqmR2QgF9Vk3DQdzcuk0u+pbv
         Xhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578225; x=1796183025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=JQ00lMwTJtnjK2CTIRVeydAaHZ8OSdE56ySLVi/jolwHPM4b6d6HTn/HNP2Singumb
         TcMAik4aUUSOaoggW/0kwYA4jq9lX7y2CwGy2LWRGrzHAVtitdarcZObPA9Xei7LcFId
         lrF5muw7EVSS9DwFuGh/JlsFdIPWdmM2MGzz221ptnygEIwc7Vurv9cO+my+vOwSS2rj
         m5ZhpklYbtP04QyUMDnWuEWk0ZgFFcuiXWiCCXi2hX2WDae9Md4Za264IUjkZ3u/l/yJ
         5p619JIA8MD+DEdPTL6V4UgcfmWK0ZpLZXCU2EFdto78dPXthJ625+4rid3byiA4ZpCt
         sa1g==
X-Forwarded-Encrypted: i=1; AL+hErGiLtmFszmPN9wg0DtK5MmNRPGHpTVA2ZSIMuib4pvtQFDW/4rzgxOtykNUzPdoORvDbDR2oA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Y7syQFi+X3K4youPVGcXi8fLIf4N3NXgcoac1A2AbKSyaFH4O
	VXvObBacjNUdtLO5ASyLD2Gs6eLrI8NGnh+3M4on7wdS5vvzubjkNfOE
X-Gm-Gg: AZFdTZd0mWIZCUH6L97mN3mOfPPD5Dcc4e3JL1VMaUb/AT5FD8wIJDGO+bxBYLdpBvc
	X2bF5VyU+FdquoY2D48XMRaccELSbwxN9qSO6qWEVz/hzYWZrA9MCq9hnk4cdQsUYWt691Lp9PJ
	AVnj3YR7VtmUCkj1fuhkROYbLENSAGLca+3bNo8PxkockcOkoCnj9lyWOrk3zkvDpdWhoTdo+Qx
	YRYrTO6zXqO3DkZd41wBogqjFq0cOjzkUBadVPZVx3g0zbNLz11evD4e291zXn6R41W+y8WM4PB
	ZmsqiRzJdNbgFhdsnnPgQmI4HIIsg5zxPi8nTIhF4VKxhxbFmZ++CWG2fcZGeoA0e+NEN5rIKj6
	Cycacbn36os8dGmiVC9aldr75h3X2QjiG8CMP5yDiGK/NGXwIBJu7eEot+aTx0bN/mnzL56Dasz
	00rdZDpaXVMeV2mNBdKDIZ9OoIKkFy5i44BBAkxUs9Vbe544VTb26Vtkb/MX3aj2IDCJMtM3y1J
	+42zljfQr1bvndOTi+FsUIsYsNS/yD0Q5Ztf711T0kGjQvtAkly7pyPkO3nkbRaAAXw8XTCC7Ly
	fZO8K+mcvBecAm01KsWNfidA+s1bo7/hnH7QNg==
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr346060575e9.3.1795578225601;
        Tue, 24 Nov 2026 19:43:45 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:45 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:59 +0000
Subject: [PATCH v3 03/14] dt-bindings: arm-smmu: Add Halliday SMMU
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-halliday-dts-v3-3-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1185;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=48k8tRM2Ds8B2KdX/k6MNHyKgJdAqOSEc8lLmnEqak0=;
 b=xCVPapQpg3IOzKVtAOHGmXsvfGx4fLaMkQfgRrvbjtK325rtMzpV4avhI4qPqmiTdlTgkoLxC
 dBxQBhGhobHDwrnWCUlsJvGEoN9HKps7J2KipZyJFkE2yjFIhJECBv7
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..925afa8cca8d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,halliday-smmu-500
               - qcom,hawi-smmu-500
               - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
@@ -629,6 +630,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,halliday-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.55.0

