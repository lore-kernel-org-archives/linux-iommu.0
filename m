Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184415;
	b=jd1XwkP0sWmuY2IIrHxINjJT1jaaeH8t1jfyCfICe6lR7uvQ2bRkBfQCYVy9tZi/ubf1
	 GKOqhVM6gNN0RL39mu+o7Oqy6ztcQehKdmzN6cd2bf+7+6jLRQHijsFiBks5/GXZ4j7Dg
	 hOjMbcisGXUbBDbdz+k38GbxmtQzjS6ioCrPbZSfe1IFbj5p2yYWZf9I48u1Xd4DxjonL
	 xn/3MC8AGICJELmSdaxY+7KDPGGDrM5uVyag/Hn1z/4hF9DkUjd97ThG/8nmYI27FOmyl
	 e9qYjAM3Ivs9hWoNgYKNYDFxchyR+Oj4u7WJgvQOudDnR5aygvPP37IELtwjPHrVn4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
	b=qgMqbfNDnJgeu3s8quAfBvuTu4OsMYaCOwfKoDFNWOU37JqvekEYyFCMgXFxa+/2oJw5
	 PJd2x3aIYRbLclpmgO4AvChevn3MhLfKwkkExYuylWygYYjE+fqUPCM93DJ7MjWyfpaTs
	 kcm/DGGnKUJW6YVnQUITzhTYzahA7q4r6s5QkEMaK8X83/SrW7UcknCW94QzuqOaAdCP8
	 sb2cFL4l4BdmK/EF8ziplGqL6e+zHjtFn0ngR5mMns2TRfh6Lq8tT4jEciAwTkV3Su7cU
	 PxkTlnnxSHqfuDs9lRf5wwpOlH/l5hIWJd3d0f8rCLBfecISDDGi4zYLTgRDIJ0fiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtmoCSg2;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7B606A330
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D7B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtmoCSg2
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so2792065e9.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184414; x=1794789214; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
        b=wtmoCSg2kF1Qe8H5rB7uGFZ17Dr5NBK/7ignptEqhd1hZqdJUY/oV1+WM1lvLcy6jJ
         t0i93c5a1ZeI+YcmyTQBaZ2PE3tfXUd+7xDNBW3RG07rFHYAMeMuiKDWNX7bJkZRQUGf
         Oe/6815+V82iI+qCm67meILg6y8oAWcptQeTxcDKFBP3DP/zebzjWY4XlhA1XzcbgsLR
         IwS33JhKGI7VVij7ASjSizxqia0jpf2d9FSPW/57W/iS49+zoGQ+05SvTlcfUWEzjGfC
         5QYRfX36A4km1gKtKisyETZ1QXLACOCeEKlwbdNXTBT8hau0C4t24marWBIMPU1se9nx
         FC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184414; x=1794789214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3Zvaf/6knxBP4r88bzQVxogNYmuURJ/Z9N4FNNEXXM=;
        b=Zpf6n84r59gqf5kAltjlw4LjaR/Q+1H76Yamv5O5Rk1h2hE3Pj+iS2oZyTZw9iB5eJ
         qWDIVyP/8W+N/Acp5EglbxSEHBtafHk9UWZwlYyuPMd2ttWg7Dg1YCS0kNTXqXQUQRoI
         3T5dj0vbxoLn+dQjOiYXUBWRklJw6aG8aOf6r5ha0chsjEGbsoX28WofJok99lRB9liN
         cBK6aQ8rGqMJsonxrnWxlk5E/2wLEgxA1kgeTAuZXwL9KsiPaQUAtHN4nZrEt2W4s9+v
         70mDoUvCkgK91aN0kVG6yhlTvt2FZ9mh/sbmzsHe6RJ/5NyF3Lm2XQ/WlY4S7MZF3DKl
         n/bw==
X-Forwarded-Encrypted: i=1; AL+hErEJTxlVdlOso0Hgjr+IdGzmYiyYYNJD74PzsMhW+kAkQJuMllgCN+tZfhSGrvxAc7Armx4dSg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+RpPNxbQ/Il2yB3n+Iy5w1oqJiqZet7EsUkQEW0td0J99wcY80
	msJeVXzzv/OH62dfG0IC+E7OVmmVTkXGZ/vLz2RaQnqibtMtwewsVLeF
X-Gm-Gg: AYBFou0tMTUi8a9ZHB59CQtl5Xrlmm/qlZujAIdyc7i1zvqN0EHUG0RqYNi4r4QvDnz
	TRD/bG174p8Q3Qr8rLWURmfdkUmkIv8xlEHTUuQBYcvMHflHD6MsAqfxPRi5tg7saI5Pg+/ueZH
	d3c5/qHf0IvWzk43fpzzCH6AzC8I0QzfDg0Zi5ItJWQWObf8nyINrJGryLIH0eopWFaoHHQIB5D
	WFSp+703hq1snB8qy0gGCpW2/PM7+hCg0jjK4x6WWNTpShvGF+IwQaAmzV+W61gt9+TBxENJ5I+
	t5HB/mAfhDayfFZLKWfDZAoYnC4awHeZ2UvYkVcZHvaKDmrR7yMxhnVuZLrlSXUCAzzQucC7eSN
	5qiWSbBIq5Uez5RH1rZfeab372RXW+UmamtLymh0JS4gAEoJZaTN2Rzc+T2iB9g0165G/S3FCvJ
	ZtEXEZBNtVop8SE+x1653LsQOZeyvQOb139d0XcfKZFVxAGXgzXUXr+rI7YWeqsV73ZCiAifBUp
	PGHYc9VxzgMHJijQKV1Z5JH8Hxl3Minxq805Cl2lF0x5EKgWzE6h9q+8idiAKqHn3GCW3lXsvxz
	LqQxkrK2vg8SSN6CGlThrOopzgDBU8xc5ZjvXk5S
X-Received: by 2002:a05:600c:8506:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b963c664fdmr50119595e9.7.1794184413846;
        Sun, 08 Nov 2026 16:33:33 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:32 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:14 +0000
Subject: [PATCH 02/17] dt-bindings: firmware: qcom,scm: Document Halliday
 SCM
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
Message-Id: <20261109-halliday-dts-v1-2-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1033;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=mntziyVI6wQ2kSkSteAmiaUttlX3LQ+YCHknAe0v+s4=;
 b=6KLs+gQMEgAdwwaI8XXKZHARhr4EIqJqXke9wpzWMnotth4jMEZlLGfBGwMvNoTpcE0tKCN8v
 aRJBBJI0d5iA+Opb629gN3RAQt1TeYIjZdEvW3ChlNmIbJyjVXak7Mn
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SCM on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 40a267c54b00..fb3da66443ed 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,scm-apq8084
           - qcom,scm-eliza
           - qcom,scm-glymur
+          - qcom,scm-halliday
           - qcom,scm-hawi
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
@@ -225,6 +226,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-eliza
+                - qcom,scm-halliday
                 - qcom,scm-hawi
                 - qcom,scm-kaanapali
                 - qcom,scm-maili

-- 
2.55.0

