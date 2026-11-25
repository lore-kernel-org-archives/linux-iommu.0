Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578278;
	b=XNuaWjx8eO1GkbsuSSSIwy9JVCQ9fLHKhznJ1NEqNvSrdT0FyOROAIn138+mxViLPsW7
	 EDcfgklb/+oM+f29/yeLXGKnf2x/fPuZaFBgi2dAw5ntMbMK97CoSuWxntjRHbobaCDCD
	 ytTAXnJtxLx2GviU/sYxzj8PFkLtPuiAZVAz3ibpH/K1J8c64gpXSBeWCssZtjpzvm+G0
	 nKLgA36teCatZNKJsuqtvKpwPCN4fWdLQ5hraiDg7iV6kUSLO1hfwNLBYHOG2q3oXlX1a
	 IQCmJo8kSeXGPyZt6NEpYWrrNuJTF8u4ESAS8pm9FtbkMlQ7auFMfLBtNJCdDYCSLIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
	b=Ztdx+zjja/KcKgtqj7yrcSlXTLqwVSYBk6/ELDAqOZmNp+4cErsRXwOcBNHfkrlo7VlW
	 AN9MCVDKRxXa01IUi8GfRCVztX2Jm0st5JIVsrhO2q6xKwPN9HCTe1hB4r/uZYkH0gyrJ
	 ZMpAO4Qm+XjQFESo9xOPQOy6qalQlIAutBUx7qbO8BZ53NisV2Uxe8wlNJh/DmaJsm4IN
	 4e/WlPu8iSVw0/B2kwlVVBBLBhJdM3IvlzKZBDpj6FFUYiWDKfs2juEXdW85ddGrBnFcs
	 CaDPxaut0YbUS9nkmCiDbdhOEwg6w8YuZGxC0ZO6s6sSTpKqWlH104Y5A4J8Y/h7mCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tav+hv5z;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63194606A32C
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63194606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tav+hv5z
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso50162625e9.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578277; x=1796183077; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
        b=tav+hv5zSbpYGf/zj+qOW3nAlTudGbaOdptmOdM2h3m1Lhwc0fO9PhuFuwqiMq+2B6
         r8soF0jSp5DdjAixHQKl9uT7l+m5zXK4sG+9z8gRvj6GYFidDtF0bfO7dyYN/6eO9aRY
         UUGIk9qYURfUIoogpmCLxuynoX85KtYtAA81L5Yk8O2+rBrhgFAzIve+ikI9cqAZaEmy
         M4N02byh+6wv1bqXcLWkY2wlu1x/M8GtBfe8jAJ1BHe867jmakCSSLZJBVCBbjBP3HXH
         /kLU3D/o22RqinlwLr40BnZFLgaI5HeucFL8Bdsk1HmgWpWR8HrJktDtJf/5tVsq041a
         e7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578277; x=1796183077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
        b=jlxW7q0lykrLYRODxsbKM5xI4AoOnNwpmD/A1DeWiF2/Zz24lXo+rVW8LLgZlYhuvW
         My6vBCwpRAO3oqySXCXKxd4swL9/Th+0z5icx+vSo1Zhce4QegyuUpQZ/T9hVgcuytmL
         oagKMyHKfcCIJBBUy8h2cwWJLMCot4fsMgQk2fu3W+kIg1eub5uiA0mq7kOz+geREegr
         EKQioTir+pu+aHdL3sac7mgOARfJTyEdBrc/FlMOvb28457McLzT7heUE9Pvod7AEEKm
         +4ZmLdq0l1t2xzEgA3GW9pRZNrkfqGZ9X9Y24pGY2KeUGbUq3/3a/8VaBhbmtRClRLKv
         y3WQ==
X-Forwarded-Encrypted: i=1; AL+hErHlT9tvpJFhzX8G1VXi55g2ogR1vl1AvTMP8UWB9sc/CwFMmZ+4MTHp33sIGzv/E/uc7s/IeA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Z2wI2tI75t2TEwabl44ngyA1EH6kdM4HeAQQ0nj3JHmRCV/nX
	33n9qItaMuntdm0PqKAO+jn5AzAcLl8y6lnrHjUwBP6sCZv/jYKKqGlH
X-Gm-Gg: AZFdTZdfAFkNO8iV/FAjtpghbJvawgTKKWvjCTaW9Sd742RIq50jhJL2ixY+Bo++cSO
	1aot0nXw+wPOkzHaMZkxGy6i1snQA8fI18j0zhe0mLNtgshzQ349xNm/FJ1+5x/rUVdjKlrFXVu
	EbOuCDD69ybP2RN1zmmqOF/JsDBGZlTx3LlDJNqPUaz4sgpk9B7Kqa2jg5DJna0fg7hDkP/N/E8
	uV46oKXooucDTQNyf0V7rCK2g2eELzcKr93y/VdYZJIT8j16hv7Cx97SSD1LDSQQmEr+JIDUoMM
	ieg1hERMrtr3ubmIWJcIb2wtugx56Hia1415s2otsS5y4MLzLc4vcxR1H/VKwPVpWLkE3DY7WdW
	6fMLG1d2udqjD7uVb2KQAcabIrcgDinzgtty0XSYdJW78Mrg1zzDz0poSWZiDQCJwc0K/4HFglj
	Go1/R0y0ki2V4tXApIG+6Q1VIBqBovGRzGKO4LUebGOO/DEGhKyDhWwrqn8Kw2T17qGHabSMAN8
	zjRdpJiWOM0YnOak4yVdrun0MwCUr2xekDmssRAfFY+CIAFscgka2pxkXuP36B2LJfZdCrS9QNU
	aIo3Ukt3p9hm11BK8P/imEoM9shcDi4iRV2Y9w==
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr346080945e9.3.1795578276823;
        Tue, 24 Nov 2026 19:44:36 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:36 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:08 +0000
Subject: [PATCH v3 12/14] soc: qcom: socinfo: Add SXR2250P SoC ID
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
Message-Id: <20261125-halliday-dts-v3-12-5c8311c0b70b@gmail.com>
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
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1207;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sbEeAuvm0vdAU7a79gy3cwCbc+niIPSz0ebsMUqvyM8=;
 b=KR7TljwE3x2QteRIhm5O5gc+Ovt804bPNXZE2SHYg9Q0Owpdf51fj2CIb7ZGKKfP0khgNSrGC
 8wxHPG6P0W8DmuSngwRv4oXHEtyjNPML9jsnvTjumi9JPv03PdDisQP
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add the SoC ID for the Qualcomm SXR2250P (Snapdragon XR2+ Gen 2).

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 drivers/soc/qcom/socinfo.c       | 1 +
 include/linux/soc/qcom/socinfo.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 18105ddcf04d..72d282f17b0e 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -529,6 +529,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM7635) },
 	{ qcom_board_id(SM6650) },
 	{ qcom_board_id(SM6650P) },
+	{ qcom_board_id(SXR2250P) },
 	{ qcom_board_id(IPQ5321) },
 	{ qcom_board_id(IPQ5424) },
 	{ qcom_board_id(QCM6690) },
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index 317dcc26c504..3a3d7c7089d0 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -170,6 +170,7 @@ enum qcom_socinfo_feature_code {
 #define QCOM_ID_SM7635			636
 #define QCOM_ID_SM6650			640
 #define QCOM_ID_SM6650P			641
+#define QCOM_ID_SXR2250P		649
 #define QCOM_ID_IPQ5321			650
 #define QCOM_ID_IPQ5424			651
 #define QCOM_ID_QCM6690			657

-- 
2.55.0

