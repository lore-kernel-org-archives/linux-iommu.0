Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184455;
	b=FiMdqtXI10VI+Oj1IfczXE9nLhk1J8Ug6l/p+wnvafRDC8q6rYQnkBt3Q73W/OaseL4h
	 dmOj8qEDuvfmMfwrujrjZ8fxOEoICkBeyRsI3Wez7SLNaCAas5QjOLz0ahleiLNINO43N
	 OlehhshcSLliaJmup/Wo9PgqW1bMPluMlwrvaj0mk8RMF+yh/mfz7Tj4UKFUKpit2BU6A
	 mgoWURInDokNjgC+jBMw6D5q3QDPLakFUS0lL28Y7EBHdpuyrtyXGsuDmiNj1JrOGzFQ3
	 CYVoECCVm3HNn0yyIMmU932LP93QGGzX5kouY0CwQB55uiv9U1D3GSaddPI0ZED1icA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
	b=Cx7gHj8f1hd/cEnVtyBc3/07TO9oT+bfJXGbTQuI8RkIyoaYkF14hRbiUv2pbPqKskJg
	 J0wvN9i+kaPYjGTcQkXs0qGPfJse7b9k5I1hW5HUdf7GsnjQUYAW3tnmsqQnOLFlxB3NI
	 XqWfx+6887uRCMzxmLZtk8hR8uY7wRsHG2hB4rWfLscgC380ew0kMgHWo8NVzGTxxlK1j
	 teEVDdMRMnBsX7DaBycA+zUutJl05n/fxWb/fl8m4kvy4GA57XiTqH7G27RFRgNzecYEB
	 PFJzHqGhEQ833HGyh+YzhVZA9EhgxMzGeRpjNzFmP2kPvhzacgde+XMXHi4ufK7E9Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOV+fypm;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE6606A339
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57BE6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MOV+fypm
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490c1d337d8so226150f8f.2
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184434; x=1794789234; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
        b=MOV+fypmfBKMWD/VeE5CNHPneO0GNvTI7rIK3/gHLm3LHUQ/CJ46nz1OWTMBsBeXrk
         RmXRS1fMvNzMowtUkq6xofUigDzxzzt5EAvqfbFzrkbK0B+6RnKdb06mLI18Xqsxmd+B
         CsuDYhIJjQ4ngMyLPQy6h5Edhf9GsY62nVGFUx9y3VpEepROwMnf2qXRiE4sbtVgAajw
         mdsXl9QWNYVhB1J6752wylVvBTr1o/Gmz+ayUJihaUultfEPnNDF6Tniwek63Hq76GKi
         qeLh2R9xmBUDAOqRBILjn7VYuY1eA4JIf99CIEOi7Q9J2I+DwpxDQwlhrR9rrYvTPuZP
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184434; x=1794789234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3VvGqgW7w89m51V5OtlQCJq1vHDswwHimQMB9pEHTM=;
        b=Zys+331NRYVEYQ0/uVcWYuVLRrDW+9w+xunVRSjsn6h4vjom4LOy0n8CIO6QOmitLH
         /ZDm84yqdO5Stq2pHT/tuooMBPEQACIsyR68408jIpcCNdLg8dPH98m0MmDQd7U2Z2WG
         /OQeNkzDeRyOxqo5TKdKPjLIcl9BoTS4fBQZbUx43tvbk5riwm8vpx4NSfrL72m0dvc0
         YD9vRZidZPgJxGJIXN2W/jatRHlEsBIBFlOcxYmY1pGO02v6fFbh3dsPZ6zNyxw8G3gF
         Ef9okjiqXQNfY5X+H8toq7R9DxErVi+vvbe9SRQe+en89bZkxn+FBpPNeY4+OB9E9LUJ
         sHWA==
X-Forwarded-Encrypted: i=1; AL+hErHtzhPkj67uT9qcPp4C/ohBWPzhrSeAZENd1Hktis5QaBZUcfsChDpP4PJX/XbhMgA/3pDncg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8EABnKnHHoM0jjntz9tlfSJ5w5Tl7sR1HTDjcMVibDHeIFoPeI
	5PGXaMgGb/Tmrf8Azq/CoOFesd8ZnoQKYRuanf00jxezkGc6z/iV7cJ/
X-Gm-Gg: AYBFou1Q/apwAx/7h+baOj5wxMYOtmPXgu+xeoIRDN5ZmJZjIoGetSgCeGZ9+OQPuE4
	YDN7aVWuH49zzozJPCHjQKxBXEN05S0aVZ8OMMY8RBjEMe7eph0sPULq58JzvYtjyeHQ4c2rBXC
	3SJNC2ygbqlrUY3PjPWVwT+Yn4FwudOewwfFfn9T08LT4kZVo0aKE4rzvbsuRAI/kJhSr0SSVj2
	6DCHVHl39Ix4MxlTnQqftEAt5upF9t5NwkY57YoD0V9IxO726pbjDRYbpANAuvXz7AUK7GbqgnH
	8UUO3wTrn4WkjdqZysuY4Rve7uQKRKk/VU1PLe/qim9sq2TuJqhax2iJYFRAk7KQDfDOdDMu+KA
	BaQIRCbjnLj/Qbji8z41N+BvR9QZyyRnt4w7JdYkvhMXbjdD2O8AvIuVnqEngRLbr0QcJZjPIgs
	qi9ytEPMX9nrAaLiqbGogBAwQDonIzZ7ZxFZM/Q8ivMUlbfqYQqOMDtDnR1yYOszPtHB8+g3ZNh
	TeQNT3yu7qKB+yGOTxhpZ4s/M1x4hOd67b/mOQMt7lVXs1RFq6zfL9RxtxrpPmz79G/wlDMu2sX
	8znwR5JwqILEXy6tCUZuw7vIN8shGUqD/RsDUr0JYA==
X-Received: by 2002:a05:6000:186c:b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-495856e15f7mr5379354f8f.41.1794184434351;
        Sun, 08 Nov 2026 16:33:54 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:53 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:18 +0000
Subject: [PATCH 06/17] dt-bindings: arm-smmu: Add Halliday SMMU
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
Message-Id: <20261109-halliday-dts-v1-6-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1112;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=ePrzoruUVeLDRq3OCS+DiCl1d/Uk3kZuK6w1BATsFKY=;
 b=pH81WehGSEFzi7T7LS+ShwXYAfu5lsev7imaA1JaeNifItRSFvMkK3a/y3Fr2K8IwuXgQfeAv
 1F1xnpR5tNxDdiiDmSxt0TVIqWh9HxtwfbMTz8uhxpsozlK3LlCAs7D
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

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

