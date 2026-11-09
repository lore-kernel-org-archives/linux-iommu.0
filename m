Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184410;
	b=GasNadC94cmTOIQkZuQiG2pA/Av7ihPFfPUyK2amTkbsgPxLVLTJD0fE6INQUxdKGo07
	 kM5EtGBhxrfhp752MaTtIW5iyz7FcijWtwQcCVuYE1N8f5aZqmRmo4FXHnKClAVGaYKoy
	 cyg29tFVX1+snTOT4WasjBSaE44SYWUN0rvV1i1fLr7fWaR+8+ZOkw4myWQCOUD0nsGEr
	 5klxL4y8dLAsbG7oKmjptrb13U2yiMcrAXPCosYSMeNqfoXouUmcnsJzMzaJuUqvNhj+2
	 ZSqfpnOPObUwfQEsvlMvntpFxFIzT6+xHBHg7PycCdZ3dYw8gzbNjPuiy9sJkHfiqkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
	b=eLdNrr6FG5dZwbOu2fOuP3gIVo+2Oyk8ytSSpM9jI21TaENmivCcGNhs4XyJGVw5UQnS
	 bGIyxMp3aOfccTcYymH5tRskc17swTJRJ87udfAajnSFNYoo+eJRwQI22WpuOcYUyNxYp
	 FFcSGRW5nrClEXYmNZ/WfB5ZY1abkbWaGEbKzixy83J8hxb9rwQeu9FU33hTC0LzGI4i0
	 0V8/3o4rsfvfcLMkiDetB9edc4MO5I9HN6MgErMVHSnheo5RBFWMUDaJXIiMbf3loHCZW
	 S+4lzv+R2RIirdk+gvCv1USuxVf9qDUuUAWz/14HMRJ26azEJ2rXb+h/ECpIXsRJozw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BjoFOjAH;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119B606A339
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3119B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BjoFOjAH
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e09aa5264so180839f8f.2
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184409; x=1794789209; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
        b=BjoFOjAHbgfrvoI9qJvBdDJuooyFPdqNz8tjAsts3QEE4ayLU1rh32EKik97RJ61kn
         7Oaeet6ITU2X4VRSypySayyIQsXPJt0jN/LiXcYNIKPU6axvr7RH+iaSpSdCla+ZO4t1
         SwxmgwAPnyEtMdv883a/sQBi4wzT+//PHkyosJ6iNirkFYtyXIeAkxmLf5yV7nYnQ33a
         MoIYbxWb+dC0ErLYMVd8qdIc369i925dlLOZjSC9JIrlxCFA2gWsDZVBmGMWvY/Ugrv/
         Dvh4B7cs1DUbMaNyFb6VZ+GgLZARglAQhwfpyBdgEbHNjwjOyDuYVe1rUUNuFrC3TSNe
         Jfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184409; x=1794789209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
        b=sWnSWpHcLD7mGr7qK1RL7lHUBOoh9wZJ1mSqD+UXv0iVwXs7rOkKWBQEYLQGy4Ihpt
         Myp52ODNPEVqHs8kg6ePtqKh5fZ+ckMep+L2Rkg0nll0qu2Oo56q/NMFtGEFGwJ5b+4t
         Q3nz+FomuXlxvObJ3NM5rrqq97ysZMZ5pTHvFcE6d3LOSLskmZD/AUHCo5YBwhlw97hp
         +y+FIMCY/MSA9EtPgd8lioNWrjEOy+PKjrnyPYPauTeanbMtNXkkQE3gJG7uB1ZFSJOc
         gMRgKNNfynveULmModngZcag8QLe25pBK08lUM99EpjtvOJqwr8ZSMDng/BhOdHImefC
         DbUg==
X-Forwarded-Encrypted: i=1; AL+hErHvv4HSu49ShQXcCEgx4v/aM6P27SPoQZ1mk+9LhuW6/wmvTDDexkL3vlwdCPQC7QPgktCgsQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+oaJJvPgIak+/OyYtDLFe+eqt7fDExTB72qe1aMUVEduGIaBDb
	NWoa9LPVnrgzlrutu4EHukStMXvCQlUoYwsgYGXfkR+qVaboWpcNAJd1
X-Gm-Gg: AYBFou31e5yT2zZrgiV5JkUs2Wd5zqbmmueae8cCz/4c4FJgq7GeOTcqiDCsx+NOmLS
	YUJrMGsB70+vTmZHdG0RCHjvYMQc9UPZf56N6jiV/1bUrU+7kxUL3MynkVPpkhgWu70p/vyf3mz
	CKuSiupyko43EYmARvu0QsOXxiKIb+XtKRBPaUZyqnTDkF8FuTuuzO9sGQU8H1Uawxmy1rJ8K9D
	/qEpPzRUG9akwmPyEh6i2geLvD4rwg3HUZqN44iZ4OMce8SaZ4iI5SKWr4cqfG3Ate0amZ/tf68
	GabIsU2p8mG1TdkzKJJ++dc5H/31tXdpNNWuQLkVbMbgplQNbLb9DiMAMn6SFA2mEWBwFOedE30
	ir3C1PHLoLJqMYP/jRgoR8/CsGhQ2FEwoWauxMD0NrEZ/KR4V9XlYv381ALAxN+vsS1bfkSQhd9
	zg68GcCd3dFtE/4SUYGwVN0ICBW+YCRIoex5P5U37fJc4anbB7anaczNT0OpT6+R7I9L4nKQYlS
	/SJ0SDPRJVH9JVOXJGfVKxrL8CO3pGoYWT5ectYrCQuy8G/50u58hDpoBsC9/Aqzw+wE2yBcmLw
	N1SbrloePXwOiGr8Mbe2IayB4D011Zy9I77oPqaD
X-Received: by 2002:a05:6000:41de:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-4958363aef7mr5202460f8f.25.1794184408539;
        Sun, 08 Nov 2026 16:33:28 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:27 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:13 +0000
Subject: [PATCH 01/17] dt-bindings: arm: qcom-soc: Add Halliday
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
Message-Id: <20261109-halliday-dts-v1-1-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1550;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=tUWocDfAfCJsF3v3OtoKwfhNWUHIfuzBBTQPqmsMKT4=;
 b=6d7YwzTFYjop5p0/v6W6IN2CR4pGsNNDgYvAeTsTx60B++SOP4IVlql7QjUftzoP94efcMQBt
 9wyXGd+1Qj8DJV/y/ijna8Tz4UO7i/9OTJJYJc+5QBZZdn3iTw6kOCC
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add Halliday to the SoC codenames allowed in Qualcomm compatibles.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 179aadc86a9f..9d392329d437 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:

-- 
2.55.0

