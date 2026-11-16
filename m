Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864394;
	b=gTkHQ+E/giEmCfJ4PwSCkLn0OzgPf7Gskgz3D1s+R/z5A9BoFdpDNhROvWXY+XqBkUTr
	 MQIzBdABwhUUrzhPUmQa7j54vdLI5Cn2XC00jxJNu6N8K0xdN7U+a4pU93BIwshPXYq1a
	 +fO3NfHMPy2puVqMeC1KT+BAcmOpJnmf6SKyQ60DA7u+H/Q7jp8uyuH54ET9WtHKOVvf5
	 Y7U9lvexb3iH4xWHnqpHfQU2OB3V9hYvLeEJ6rcDpKeqSxjP4nuSo9uZ+u+sXy0aSxN3G
	 1PSCO8taHi6w5CgYGj/er3SvVDkFzb998GZF7PvoKK3OGyMqmz2weP47KjUVNKfLH3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=geDMUZgvfuVvDJzC8y87j2/OgPMLvLdV6dtKH2mcnHM=;
	b=Fjz4OsijNKCFWwHCV48axFWOsa/Jts2VvLNy8FNEThfJfGmzRX5+23l9xsep6Ll8wDUk
	 mZwWI7kDvBuO8Ab3MVkGbQEYFfCd1RGobt1gkEBXX93WI4KRkqMaQVJbi9WqaAXlnQHgF
	 TzBKJWKJm4SRYiuMOpNctTGAO9PUALoNTV2vSv8y15Gl6CbCNwOR8Fk99AHvDhH7v61W+
	 1BplMwQxilfRhBTHQb1zB3AKoqUcOIHxg7UrwqdWraW+dln/GnG2owVtUAo3IsPNB3jPr
	 XEExxcM54qlBxjqkOQpzaDxWn+2a9/0ftqDa46cuIy9SAGt6EhAWZLVdZmqkLG7S+eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sorA8kcZ;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6F606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E6F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sorA8kcZ
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso381947f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864392; x=1795469192; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=geDMUZgvfuVvDJzC8y87j2/OgPMLvLdV6dtKH2mcnHM=;
        b=sorA8kcZE28C+vB/TNf+9DJGLvGD+mvOKsZNEvzJCzdBsnc6J8Af0BDLrUeHrMxZmW
         J19sCkizDmC9FwGIpY6dFADsUyfIguhDlc4Wgf6rSWlikJG3+e4N1BEcRuXVHl7c0Jug
         qfh3Zjzey4k+OfFJWFk3w4qtb1Pau4bU+Ak149DmjRguW11oCh4qk50D+lTxcvA6dlTt
         YD70bFn5ZIONx5nHsdhh+sNr70ZNmjPuuFEbiNqbLZJgI1tPg/hsPZwrwJgk7OlhOm0f
         Uj7hC48fLgAEEGZqMC2qYnFEpaNMmSxvY88FbS3T87XEsQa31np5uxzYfdlAw3Q/Yc3Z
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864392; x=1795469192;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=geDMUZgvfuVvDJzC8y87j2/OgPMLvLdV6dtKH2mcnHM=;
        b=KQF4o2p4XIIh598V8BBrnfEZIPyj4b5mqa64z5bHwLhIF5OZ+RhxyYp538J+dcu4LM
         Gbp3MMRnlblUz+h8PqDauzMvsfM94VeXOS4k+Kg+pNtHHp79Z777dvAaZxvnchUQP1vY
         UlgztVCuKcAEM869UGwLrWpy8BycTonuW2kje5HpLBxWWCTOTcrqao9ckMC5JjvKgX+V
         ndhKpC5KyYPGB+M4ZR3/hxu66MPTSc2d29ElkfIvG3EeC2LsfucWrOtaYCueIRtRv1a9
         GnmBSf2yn0+74+f4slZafF+z4ifVpQiwZqrl55BqsSwDjUmPTZKuKBy6LDHEXtN+YHe8
         53Vg==
X-Forwarded-Encrypted: i=1; AL+hErFYvlgHGc4SH+0vpPTuSLiG6goAKjzTTuS93GJAwFyW3zmCwdLuJ8yjU5PpGKXFjI/uhK7P6g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+v7LAo3Sf3N1RLogar9kdP8fspTc82diRZzK69X405zcdQ4Td
	7OcExBJLP1fkWJon3tLwf1v+iO2OFpVL4YBGbEYrM8WnqBKJ6cjzO8CL
X-Gm-Gg: AZFdTZdTJ/sJvJn0smA7i+6omPbSUwL1nrcQ8gJnXxMjUcn8Ucr9acX04e5cCHb2aBE
	aXteG14tIJMKPIAT1v0/+exWj0Om9KGhAWpAoHMiLFpI7CiWcXebaBcWHTxUfEVxaXkna6gbJKY
	7f7zIRo1N2Owcl/bRRC4q/4qFNtezYSXkWNPSV+sBjhg6gvFexc/Efn8j7Md99zSGHBil7JH8GT
	mLiqqsWLhqscshxEVgunQnCaoWWOq27TyGnpTPB2AroatDPhWcIN6Y8zdXytIYpjb8QsS9I3ln3
	7e5nNKiPmIZTi4/G6j0TQ1XlDmnR+syBxlCNKRDjBy7s1rSJeVmLJ3JpCGflkI1Pqd0s+Vrt6MO
	s99JvNG6yoQwAGFVqjEIQHYL2S2sDrQHVhgRr7W9Qkg8i94iqOSnw8cd9YoDGdJpNBbq/jaHHRu
	ekNVbwiC+Dw/hjPTKgA2m75Ln83Gl9fGvcXRY7+c2CCtC3F4KHMxJ5Yf1CFEr+bY3aD3fzKTFbV
	6Y5UF5qEJIZ/70Wjpyo9iDXvT/qcZwPEIHZpHpYttKpqhRhlf5qKHnF87ZB2QNa3F7t1SlOWvR1
	rv1enjMRhApOaHCLoP+uFfDsAIcRWPRMiOtbfMfC
X-Received: by 2002:a05:6000:2010:b0:48c:4f6f:62e3 with SMTP id ffacd0b85a97d-4a324348cc8mr2541077f8f.18.1794864392095;
        Mon, 16 Nov 2026 13:26:32 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:30 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Subject: [PATCH v2 00/16] Add initial support for Qualcomm Halliday and
 Samsung Galaxy XR
Date: Mon, 16 Nov 2026 21:26:16 +0000
Message-Id: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAPh0+2oC/42RTW6DMBCFr4K8rit7sA1m1XtUWfhnHNxCSDGgR
 hF3r0OQ2qpdZPk08+abeXMlCceIiTTFlYy4xBSHUxbwVBDXmtMRafRZE2CgOGc1bU3XRW8u1E+
 JokJfGrDSeUay5TxiiJ/buNfDXafZvqGbbjP2jhE/5syZ7m3fmEz9A5m6vqcBJCsrkSvImgXIz
 93+M7nunZYKuGZBBOn9I57oHFXSSCHAYi31Q5zzHPIxlKN2paw5ghW7z5qE1A19H6emQOPqwPL
 +oABN5blUglXeCGsCKAaaOxuwBHKLrI1pGsbL9pCFbwntZP07+4VTRqHWnAtja66rl2NvYvecq
 eSwrusXJrbDqNsBAAA=
X-Change-ID: 20261108-halliday-dts-e6ed3a2b5cd0
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=5564;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=D6pHxmjbT0YQnXObxaMbhJXnWglUC8bGXbRILU/YSwI=;
 b=kLkUaY9RvMn2SFKfEWKUHPt6napWByTdqsO3PWDWJfyn5BbOP9cFbM5QSqDucjMqA+sKciod9
 131P6WbXtcaABhTsVArttw14ogeyJI2M4IyfytTwUN7qU6QUoEuUPxW
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

This series introduces initial Devicetree support for the Qualcomm Halliday
(SXR2250P / Snapdragon XR2+ Gen 2) and the Samsung Galaxy XR headset
(board compatible "samsung,xrvst2").

With this DT and the driver series, the headset boots to an initramfs
with a shell over USB NCM.

UFS, cpufreq and the thermal zones work too. PCIe with Wi-Fi and more
will follow.

Dependencies:
- The dts patches need v2 of the Halliday TLMM, clock, interconnect and
  cpufreq series:
  https://lore.kernel.org/r/20261116-halliday-tlmm-v2-0-b4dd502ca142@gmail.com
  https://lore.kernel.org/r/20261116-halliday-clk-v2-0-28208928da36@gmail.com
  https://lore.kernel.org/r/20261116-halliday-icc-v2-0-6df8fc0e0620@gmail.com
  https://lore.kernel.org/r/20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com

This work was made together with Claude, ChatGPT and Gemini.
Reviewed and tested on my Galaxy XR.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
Changes in v2:
- Order the patches by subsystem, with the SoC ones last (Krzysztof)
- Squash the "halliday" codename patch into the board binding
  (Krzysztof)
- Add the SoC ID patches, which were a separate series in v1
  (Krzysztof):
  https://patch.msgid.link/20261108-sxr2250p-socinfo-v1-0-06244862f5c6@gmail.com
- Move the OSM L3 binding to the interconnect series (Krzysztof) and
  the cpufreq-hw binding to the cpufreq series, so that each subsystem
  gets its patches in one series
- dtsi: Keep the Linaro copyright of sm8550.dtsi, which the layout
  comes from (Krzysztof)
- dtsi: Drop the empty chosen node (Krzysztof)
- dtsi: Sort the thermal trips by temperature (Krzysztof)
- dtsi: Put idle-states before domain-idle-states and
  arm,psci-suspend-param before the latencies, like glymur.dtsi
  (Konrad)
- dtsi: Use 0x0 for zeroes in reg, ranges, dma-ranges and
  redistributor-stride (Konrad)
- dtsi: Break the reg-names, interrupt-names, clocks and clock-names
  lists into one entry per line (Konrad)
- Cc Ulf Hansson for the rpmpd binding
- Link to v1: https://patch.msgid.link/20261109-halliday-dts-v1-0-289114ab8197@gmail.com

---
Stanislav Aleksandrov (16):
      dt-bindings: interrupt-controller: qcom,pdc: Document Halliday PDC
      dt-bindings: power: qcom,rpmpd: document the Halliday RPMh Power Domains
      dt-bindings: mfd: qcom,tcsr: Add Halliday TCSR
      dt-bindings: arm-smmu: Add Halliday SMMU
      dt-bindings: usb: qcom,snps-dwc3: Add Halliday
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add Halliday HS PHY
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Add Halliday
      dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday UFS
      dt-bindings: crypto: qcom,inline-crypto-engine: Add Halliday
      dt-bindings: thermal: qcom-tsens: Document the Halliday Temperature Sensor
      dt-bindings: firmware: qcom,scm: Document Halliday SCM
      dt-bindings: arm: qcom: Add Samsung Galaxy XR
      dt-bindings: arm: qcom,ids: Add SoC ID for SXR2250P
      soc: qcom: socinfo: Add SXR2250P SoC ID
      arm64: dts: qcom: Add initial Halliday dtsi
      arm64: dts: qcom: Add Samsung Galaxy XR

 .../devicetree/bindings/arm/qcom-soc.yaml          |    4 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    2 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |    4 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    4 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 .../devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml |    2 +
 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    |    3 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/halliday-samsung-xrvst2.dts      |  218 +++
 arch/arm64/boot/dts/qcom/halliday.dtsi             | 1871 ++++++++++++++++++++
 drivers/soc/qcom/socinfo.c                         |    1 +
 include/dt-bindings/arm/qcom,ids.h                 |    1 +
 18 files changed, 2121 insertions(+), 2 deletions(-)
---
base-commit: eac8f0411262ea7d156407da4baf260291cbfe32
change-id: 20261108-halliday-dts-e6ed3a2b5cd0
prerequisite-change-id: 20261108-halliday-tlmm-f250374110e0:v2
prerequisite-patch-id: 0f6c7c801393ba2d1ed5fc82a65be6b05f0f6cbe
prerequisite-patch-id: 36f2dcc3de10d5ccba9eee25b73736189559162a
prerequisite-change-id: 20261108-halliday-clk-362190f4f5dd:v2
prerequisite-patch-id: 765d40b7543dba6580852939a5c3d177f12d0a1e
prerequisite-patch-id: f12c958fceb125bcefd8dc9de139f30a371f85a4
prerequisite-patch-id: a6559b14fa1badec8e7752940362d68306523557
prerequisite-patch-id: ef47e531053032f65d3d600e2213c8a78e50f20b
prerequisite-patch-id: c4b2cbea76a00aeb699d706e09a899aa18e510d9
prerequisite-change-id: 20261108-halliday-icc-65a5442be859:v2
prerequisite-patch-id: 94cd5dee75e96876c6a42852cf6d1b52df1c7ace
prerequisite-patch-id: 9ad58176d603ffd84e7f1239c3b646cede4c8a3f
prerequisite-patch-id: a5df517be2541ab439d324dfe23ceb4c71a0e655
prerequisite-change-id: 20261108-halliday-cpufreq-1e9c3581e2b4:v2
prerequisite-patch-id: 95b1ae328d8049ecbe450b0f18df15465619f2af
prerequisite-patch-id: f67013633e74af33f78e3ee4d9de38bb2842fe87

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

