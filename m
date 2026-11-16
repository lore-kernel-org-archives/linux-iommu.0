Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864477;
	b=HzDVfYNWziGagAZTCjmxYSx7DmG/8PvAQ5LGPmgAuvj+tvfikpnCwWKZ9d7MEWaI1FPm
	 xxAOzmKZzLEp01HLmRU1ALZS0vgpoI5Kdf7BYNeSxwqzT6uuWpSIu3CnfPc356JAU0pH/
	 vts+PkFN/B5lYIbfRJmYrt85FF1xCHIz3JAgtBiyKtUwn2iy0j7RM+yESOWUd1B4DT/dc
	 aqjyIe1Cji7+stxGw8BKXwVrVao/pjxCS2yYD9R8DfIBi3Pei2OdxA74DH++o92Z/3qI6
	 AzwJ4sWRMJLeGIZzgXNv2aoQ3ENjOmgKKGACPuzu0Qy0jjHd2vJnFg3/JDOsbKgNlkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=mvVvlwCzdjoOARGkeb2HfQeJVG94oQ2ENGfT6+oUCwc=;
	b=ug7TyPd3o9+zmmb8oqWljSWUJZBy8TpAF/GKIShPqAOHLJjBqA4OqSYV7Kw8dFJi4Lq0
	 FZCDcmOgYwe5+HjI78dYY75dKMKTDC4SyxvL4XCFjRBDHP6DvkbMWzEc9/aozh15BQdZc
	 uW9Cevyosb1oVqXRBbP6PfpWFxeE/H+j6DJXP0+r8pYsL+Ns4PvDvWbtSbRj8nRTE+TNa
	 3WhIEwZQIy1qPFSHgrABFxGQkNHf67wAvJjBz+oczN0d9Sm7uZz9h8SRpZ8Od5kRfkx9l
	 oSUirvScrNHxdryvjebFwFIZ71n4DnWERhUxFnEH+ph7B0Il0+phX+svdWZe/ibaPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVBnGoPZ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA7606A32F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BCA7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVBnGoPZ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3edaso194014f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864476; x=1795469276; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvVvlwCzdjoOARGkeb2HfQeJVG94oQ2ENGfT6+oUCwc=;
        b=LVBnGoPZAsugVavAq5B6o3YahdoHXtl3auI9jRdvbDNv2Y7PM7WxyYRrYUmQpU2WK/
         mlWEAeO7189vcyy8kP76r/9UHjhihlInrrom6/xFGuK35M7QpckcQmcAlWuyy7e0gi4f
         sSgn49MqbTgn+axkrOb2EXlhJAFpHQM4+fZkBILkooldKXBtFbPZUz/2L/mGf6ipjKDk
         iThY9sY/IFX/NImft9OVh2sEoLry2rkxHldQ18bIkTRI59FbfRYOClpXcW2PnTzRyDXS
         SlmFFx9HtWaHSznd5oo3SI9FwU1zEFtYTdk0L9jAkuaf/x46JtBsuutLPtcAcWnIiPK8
         zRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864476; x=1795469276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvVvlwCzdjoOARGkeb2HfQeJVG94oQ2ENGfT6+oUCwc=;
        b=VJdpbPH87gGqfZtneKlqmf8au1mF6YuO1tSkkl1LLOSfmFOvY8HsjNWu+GFsHPg0fs
         1Xy/fTomWrF30+i1Ut1KokvB93jS9ToltzDDsfGscZ9I2+UN2Z5yv5108fJDnWJHqR+R
         Slkj6kReGOVuk7aCoOeMkICbFfei9Y0y5TJ0Ye4z88Ewpf2MkOurvAAzIipeMqOWyy6r
         9FejchO7FPnOJLrkBXASiNgrmLq/e/AB5FptZ+fqJ9coyY14lzPxjky+Pn1c4NTQY7BU
         cAzEXqafOqWmgMBJ5SMjZn6pYUmz9ePyhb/D1bKjSpZ/TmuakwO3KS/oBQf8F59cmUUL
         QcVQ==
X-Forwarded-Encrypted: i=1; AL+hErFIaEkUFQn6TZGXSZ5tX3VuoNFpOr6SduAkUwI/d2njzg5VvWSw3pjoApTkbGYdDLzJVUa+wA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9a/6zBmYyL+NplnaQtQ08bq35ynG1HDV72cUD/hB9wKuqF8xBh
	u5XVfg/WR9jA+MvzF9Fz5ECTd+mpe5nQtYCg7ioQn/UOEqO4f5NZygTe
X-Gm-Gg: AZFdTZdvsFHBvsrnYti8hbgf/7Tbzn4+m+jMU3a6BQKUrgspBeoSffophM2cR7kda+N
	ZthV0RQRdJJjFmDiPav+KBAKMM8iEsOTCflPioUWu2pY48H5kNxia1nYFH9fGW6tg8Q6psSXqZF
	kB0czr4NQy7yqNR4NFGIosi23JdxDLEkRilbfdsb0+nUvhiQ4PazOrnHiVvErjIj4/sSkGVWuOe
	tMpm4EdbHfbfhlhEe9E9nDJ/oFFiVJtncMfT9/+nxmfbBD1FVPHdJEOEmfNnchDP8Dx2iyHd3H8
	wGp6MgSs+mQ2nd62wvL+N5CbnkDeocpGzgQhe9w1evf6DjWWQ3vbIIsLBtXwaUU19ZSn1Ljc3qw
	HDCU6v9a340TrG9zisrhh0mWsqxrm7+azehKkiwJjQti99phYaKqD+psOi3LPEVLEyNAVubKG7k
	pFVWvMS3D7POlh4gRveu+7b88sRtdy1Sq4yLUPuQ2yxkkpn2QGOX3ZnXK7RAvO6lJ/a8efVoyQV
	cg2fTSu3VQFWO9mw3Cd9FFQ5cRBwqDlyLdnYbr+s1he/R2saFzP9NfQbqGgbGOJGH4rW/gN4hzX
	gfsjgibJQdZogRpkqD9E9t2T4eYWtfx+vokgdE6D5UTYVhcw7Vy+1DWY2MbjHQ==
X-Received: by 2002:a05:6000:4706:b0:49d:8ce1:2652 with SMTP id ffacd0b85a97d-4a36bd51c5dmr1648244f8f.1.1794864475624;
        Mon, 16 Nov 2026 13:27:55 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:54 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:29 +0000
Subject: [PATCH v2 13/16] dt-bindings: arm: qcom,ids: Add SoC ID for
 SXR2250P
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
Message-Id: <20261116-halliday-dts-v2-13-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
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
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=746;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=wp4yEFlEeRirWebvDUNwJG87yvgwIo0fuTVgUjPIFVg=;
 b=c3M0oozAyWICul1zqZyYV4A722e/xl51QI136kZKSBBz/N4l9sptO65yuOtgNCZsSpOrbqAMq
 sRMLJj/ahy6AipZ7ofcwU1aakgIIwxaL8YroDdkKta3ZC/C45UuYvvM
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add the ID for the Qualcomm SXR2250P (Snapdragon XR2+ Gen 2) SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 135297027580..cbcab632e01c 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -288,6 +288,7 @@
 #define QCOM_ID_SM7635			636
 #define QCOM_ID_SM6650			640
 #define QCOM_ID_SM6650P			641
+#define QCOM_ID_SXR2250P		649
 #define QCOM_ID_IPQ5321			650
 #define QCOM_ID_IPQ5424			651
 #define QCOM_ID_QCM6690			657

-- 
2.55.0

