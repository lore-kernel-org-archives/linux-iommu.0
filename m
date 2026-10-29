Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281990;
	b=E8tR2jrZQOvMYugNWIEHeTxlwYAzFMlCVWKFWyz/T2sJGyEINd10eHun2jnA/+EcpNp+
	 /pngyJO7XILk6av8te0+eAruljbYTe+5SFpB4uL9PdFsOJ8BAl5+S45GVSZq/AguPFBQq
	 TrMPlVI10IryyKidWXHWyVr6MGWZqSNThalDH+l7gOqmRbOHZufJEsRTOJXCLKOd9Whiv
	 +1trs6egcy0r9q1m6XkKQsFLjbdio541czlyqTmdJ0mwSL+p4BW0NO3uqAM9NllYAg8o5
	 10hFNJksPo0aGoYBPsu+tx97JE+PN39zWoFpIaGwqxGVtRX5X6v/5a2l4Zk7241NKPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hqI3xUsD2cNMA3OqjFeaiLeXLoIzktOWAoDJXR6bb7g=;
	b=VVKx/6QUnpVXJCxKsgqha3HWJoKW8AdJuGcMKhUyomJuUsZjLPh6cVZPM6cbQYo/iX72
	 TOYRmjQHPQrLPvU63+4Ooll+BVDerG4w2lgZlESxPY9AQ81JVIbIWn3WJLnaAGPYh+Lnp
	 Wb2lLKZt61/iduChb3TIplquXAYwuiye7VzfXDuxUUO2yBQkWqeZrbWCT8CRFanTRtTsq
	 AxD5+WrGnCye0yGOPkRMSJm/2WKjA8CuYemf9ua1hP7nNpjsigHbbEJ0IKDtyVkLy5FGv
	 2JE0Mo1+SDQd5XKYnjfVQ7kfDkMQ7Aoqb5hzajJLlRo9E4uoc7rXUs0S96sleb0trBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRXbJJrh;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896060A3809
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7896060A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRXbJJrh
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1625650f8f.3
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281989; x=1793886789; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqI3xUsD2cNMA3OqjFeaiLeXLoIzktOWAoDJXR6bb7g=;
        b=eRXbJJrh2ugVbTiXzNyrO2W+kN8bi4fPsSsKH9KlzoZ9rpnNisLE5zOmSYDA0RgcW+
         WBBgTSYJAU+8ANrlAYC6ivnFsPNmem0rOTA89t/SMDupVysLvWNx1iiBUSZGTI5vCg/C
         jl7IpHXrLZM9ffggZx2ghNPgXwauW6rxCe4KUyuTxGy6qnSIrdjHlJ1An8EJoHr2TaU7
         0q5B5809JJIPxAyGjnc1ZIwbMO75FWWjGDJgF6ocFTMVY8KYRqOW8kRbTZbLVBh4bjXq
         KF2KVFtDqz7+Y2pF98DoSrfTVpEJkhfcTJ36ft7bjJSOCSvJm7q25uoHs7al8+3znLCe
         v8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281989; x=1793886789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqI3xUsD2cNMA3OqjFeaiLeXLoIzktOWAoDJXR6bb7g=;
        b=rhNzFRjibf7ZtVuWgkZWAaoqTv00qq1VNx+Ww0nZOfSLrJBKc7PMjl+BfwCH4ELUc8
         YRd92c9820GWaN9dajfYWVe/7dK+jYuRqMR62h5rXFuctrOJwXJ/pcPWoJVyqkhc3Cq+
         iaskSKu/kuDTQO2GI/Pqe9U9EIpbC6YyBNlQHtlEyiFs0M+5zLfzRyfZbHXJVwitKYGh
         0AKl9281ueXYdOPRrvTbYWaUzmV4tgGgoI3zUj/eMTCfVkTGqipHwtiArZN8ioHlKzP7
         MJhM4ASuinsPQsnopTjewtEqVR6jn2+p69oOTGJvXNFLsSuuGzIIXvX60ig2h4q/eQJ+
         a5Mg==
X-Gm-Message-State: AFq9FYLZ77xU21V4z/l+voz2aC4ah9dL45P8tebPJHBbhBAKdPPQMzKW
	17lf6wMR2CGss4qVa9/IS0fQuTL1qit/v35gTT3XN5+sJG+ucfv3Z4c=
X-Gm-Gg: AYBFou0lQsj9l7XPW4Sg5vlPK37JvhAnJ+/RxZMVH2M+NkxnxsjJagjgGEnzXQkSCgU
	f97rhqLuEvdi/ryoZbtiZunEGtKqSsbOEvg+aYHID8IFnUe7+IeCFGY6RZwma71Y1pd2BJelCEX
	g9bTvh8FyHIXtfBxV+Cj1AYtNrgIgssY6cJ1LRIreRrWsMME59MWM6TtKS1ugnjSAAmpONJfHS6
	USB8RhQtvZbrQkhYppCCFGbqNJCdDeQsr5AWZ7zsh/kPb6SOm9oEUP4tHZDBMAQJmTakhKn8aSv
	wq2xKHfUyxFjhTwusYsME2r9ceZiwS3RIRUnY9HM9C933RqsQLCu/ZO8auwE2dk8rFrH1kQ9UH9
	IVEhYroT1Icq0V/86nbJvDbscEGFGjjRcnIkHvrDbGg4HXuV+QFhuV/YDZrsc2SqXqLmhGaqlZy
	6X67NK3Sgb+snu9n/WhzT3viCedZP89vFskZiEia48BaUK532AKaCASW3yJ2YLPL4qhW39bzzoL
	AUJ+XOydblhvRJyArC8GvjL6Y3wZ1mYeW56vFsOrHdw9lzwcjGzUQdSnqqx6JgQj3GGdKwwrAMI
	yRDQRXh0AkiMAWgwYOiwZK596oOx0WGTC60CxSwbbiGjvA==
X-Received: by 2002:a05:6000:2806:b0:48d:ff0d:cfa5 with SMTP id ffacd0b85a97d-48e5d5e237bmr9297013f8f.47.1793281988693;
        Thu, 29 Oct 2026 06:53:08 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:07 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:41 +0100
Subject: [PATCH RFC v2 04/14] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1186;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=m8LjyZqlFLsxlRip5l3NXkwO7GG8cECPX+LNQd1tpmo=;
 b=ARxR4H9sfFo+nvh8rZ3WMz/5vBOcWptYc4QScQ6BwDzQQ9ZqJR17Rkbis3J/NCOw2T3Y+DXYV
 1uradRrW6R5Bl+J4M4CED5l+9lrrUHdMAtWHma7WA0JnTxjPc/6/H28
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Previously both SID 0 and 1 where associated with the same domain.

When LPAC is not used this is needed so firmware can acces memory when
initializing using the same page table as GFX.

To use LPAC however we need to move SID 1 to a different device.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1604bc8cff37..f47d1dbd06da 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4144,8 +4144,7 @@ gpu: gpu@3d00000 {
 
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
 
-			iommus = <&adreno_smmu 0 0x0>,
-				 <&adreno_smmu 1 0x0>;
+			iommus = <&adreno_smmu 0 0x0>;
 
 			operating-points-v2 = <&gpu_opp_table>;
 
@@ -4158,6 +4157,12 @@ gpu: gpu@3d00000 {
 
 			status = "disabled";
 
+			lpac: lpac {
+				compatible = "qcom,lpac";
+
+				iommus = <&adreno_smmu 1 0x0>;
+			};
+
 			gpu_zap_shader: zap-shader {
 				memory-region = <&gpu_micro_code_mem>;
 			};

-- 
2.56.0

