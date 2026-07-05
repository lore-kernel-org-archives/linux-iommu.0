Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D63A254A
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278875; cv=none; b=M/VgYUN/yaAPCppXEJIae7UgWNyqeB3zEnQQx7zuhF81Y1svHjE6ylXO3OGcYQu2h/N/woLNvglq3Dh3SbXN4rPmkcWHmj7YzKK6rcsMTNpmkQEBTwRVz4rfAhZHic7+k+6a1hDPCAGeP1OJmAWn4cwKl/upyBtyOwpFwYv3aVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278875; c=relaxed/simple;
	bh=lEQBWGFQsawhS3Z+empPXIW4pjOUFPTBX61IJG+8wpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZLUG1JBKJJEqegcwgVm8h+Qln77JFXdCt8rzrv+mvs8SO4oMULeeljBts22+5I7aL4KZVZDlWdPjEGFuNphbJ0BMPsqZNGlXDQLRDxuWGUuaDtD8w3/hpk7JQ87HD8Cno0aJcLmbi6cDOBiXi+IjNT82JxFFrTm+XPEFFibXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUeh2cnr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUeh2cnr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1540217f8f.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278869; x=1783883669; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBnb62S3pox4azVRKerhjkKWZjHIp9f0CrUrLIrizHI=;
        b=mUeh2cnriMuVASiXuB5rwE6SFKnrWVwCwMBo7PzAnmUBE1AJDD5UVaGpXuoar7wPQX
         Aa2CO8V6wvqlZjXmXdGz0pIMIEjlotQ4/0XspIa/6/5PdoKCV3CsNrvzzp08Q+JWpoWw
         Oafue785J7GYlXXIM+fHggZwoDT/bZqfNZjfcf1U44IlBEz2YYohW9r5gTIM/TepQjtc
         ZFdgcc/g0l5S4889eJe7KPeQ0lnBWx//gRexW4POch80iwK+SD4rc1leUFymbfageFYj
         Uxofaak90Jyj4fPg8wSjfrw5Wrhmaz1eBxZXT2n5H9+Ck/9GmmwUmcqSmVf5EifWm6X4
         FwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278869; x=1783883669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBnb62S3pox4azVRKerhjkKWZjHIp9f0CrUrLIrizHI=;
        b=YNsq7aKJmuXjrHaAjPcs7zX2rW1S8NEmWfyOcKw4nT5Iayd3AIPHCXFSnW47nnfnMh
         2jfAkFkBX0O/sLFZbIRyeJCM2nkXwnK6dTYV6fkQivSrZzZBGY/xZdnFyX8/U9Wo9qVv
         aLEYtjl6vUhw2pRJkb/BFwzBFb9y7BSaABFR8Qv8WU6P/DQnBZ3Pv/8eu3l+d3JC+4/N
         a89yeDZHVNkTmQVAcBQwtQAL42LUg6C6DlKz+tn/tQwPfZ3umALRR2NOUJc+Na7hsgvR
         Pl3OK91NLo7f36p2bc/C/2eI0fGgpMpjVcm+KEC4sW9S1cLuLIvlzEKEJoxDMhlx+Aga
         njTw==
X-Gm-Message-State: AOJu0Yzw4lwb2pmtLAmZImpJHMW0lfLi36N/Jviw/z0NwyfqNIkzyUCZ
	pQxAI+2lEtD85Rb7EMjs+XG61JLw6ofnlF0DPLFsJNvUCSWzn4c0W4g=
X-Gm-Gg: AfdE7ckWaXN1sqMvyBp2FFj65h1OowIACOfSv0TDy+byJzVoLstT919SY3QKgQ58pAN
	4WkV1LS9GJ4czOwlstfkCmAmYyHD9tzhvX8/wLItmErtNahILC5Ul22CNQSBMYAl2PqMySTK5P/
	gP6hbQGogjeOh0cG7DpZsw3eF4p2SkEYdMWeSNzaub8SLbHVtsuEJUiIskZ1H1FThujEvnbmS6U
	ae3rcWB/a3cgsFYzxcub9Sr/VoiLRIAOZ209ysKT45Yxd0YFkioflVzt6rADeFf9IbUFu+p4gF8
	potqNkXIerbfr/lrwhH95WoMNg0pXE8iyBEyNBu7K1s3F7ElPow4NFZCE0WeaBh4w0nSz6oYSZV
	Yxg74dMElJv78myNB6wWvejldqQ9Z5R3bTh+kNgiY/vg/kLppXOG7WEQpUwIUFQCqc1jcF71ajN
	0+x8dEI39L476A/dUFNdqrtc/detAXAQ==
X-Received: by 2002:a5d:4530:0:b0:472:28f2:506c with SMTP id ffacd0b85a97d-4793561c1b7mr10294287f8f.13.1783278869284;
        Sun, 05 Jul 2026 12:14:29 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:14:28 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:42 +0200
Subject: [PATCH RFC 08/13] HACK: use cb1 address in lpac dtb node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-8-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1103;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=lEQBWGFQsawhS3Z+empPXIW4pjOUFPTBX61IJG+8wpQ=;
 b=ghyBtO3mPmOZCBw2AnqYHPShuXdJyTE+gTcOSZ9YU5rU1L9CLwjDKC2Kyv3ZqsOQvXyq+rMJb
 aTedKIXba75Aenv0imb3SDNfjufYxVMYzOkJYRnVags1gnQPFh42M4o
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 44e5f9d4b335..66ea9155e228 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4133,13 +4133,6 @@ tcsr: clock-controller@1fc0000 {
 			#reset-cells = <1>;
 		};
 
-		lpac: lpac@3d00000 {
-			compatible = "qcom,lpac";
-			reg = <0x0 0x03d00000 0x0 0x61000>;
-
-			iommus = <&adreno_smmu 1 0x0>;
-		};
-
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-43051401", "qcom,adreno";
 			reg = <0x0 0x03d00000 0x0 0x40000>,
@@ -4254,6 +4247,13 @@ opp-834000000 {
 			};
 		};
 
+		lpac: lpac@3dc1000 {
+			compatible = "qcom,lpac";
+			reg = <0x0 0x03d00000 0x0 0x61000>;
+
+			iommus = <&adreno_smmu 1 0x0>;
+		};
+
 		gmu: gmu@3d6a000 {
 			compatible = "qcom,adreno-gmu-750.1", "qcom,adreno-gmu";
 			reg = <0x0 0x03d6a000 0x0 0x35000>,

-- 
2.54.0

