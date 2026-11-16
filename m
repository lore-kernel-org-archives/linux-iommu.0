Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864428;
	b=b1PzPfI2JPOLe/7OpmPOfwWaxVME/VmhQ/tKjQhkclS0ntvg+Xk8j7rD7lvrOGmD/aOu
	 AvyYb/djzoCnq/NPohBijy+qmIM/XMYUysRzOmAUpJrfO/LoN0lE2h5e0pjh1+dGbHFLU
	 iajPd7FU3QGszz6IXfWRf0zvzx/EhYu5m5BoDu8QH59QpDvKpn62YbrhVkWr1UsWIGOFH
	 uuW0QHdp8HMPb3YtBHqeEHpl3n4MZTnXtSdr7th2pxH4GM+2yVDjgI9MdqT2C98qQkH8P
	 ky7Y9S4cIck5IGZdBp/Y827F/gb9Ga/n7SpMNvqtQ2SMrusKe7NQaFPGTECjWDpRVMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
	b=ZDqrNSWcMZsB/p3A7po14a+Y5UkOXH6vid+TZ/jbEpMTPDLnetPv/VG/JakZzldmHSNU
	 DcJDfIhrM2R5Z5LMLz0hOX4KxuYonFfkPl5VLUNwa/yKCy1lBfg1sci9153ALi/2sap4U
	 TLQPklakimLqJ4euzTK82X9CjuRcFWFL8E8l3yxp6BsPYAJojcH+1IwPJ1Uvey/7w1T+S
	 fYBLmgNb91dcNP4uRnoqIgNztVlYupeiIOoXH+uTjfAEEjc1BSZhsMyET8yzS/ie/aK3O
	 Pbs+HMgj7FBFfeztCGl4pvaHy/LlZVB60y+uWkt+BMKqUeiED/BY+0Ti0OhjyuLNKew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q0O/a964";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9C606A330
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A9C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0O/a964
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3edaso193680f8f.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864427; x=1795469227; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=Q0O/a964qe6zvke0n+YZAreXFf1Xe04yeraddaXOyTbXiH8oDUWLmFr2xIRhyOIIeh
         nXHfPTtJuy7MoV1iKRucjYmg91kzVdshAvwmXMBbisUEUWyJaivxebyVzo89DyTNBN1K
         56qDsk7NQ67mj8agBhXgmPZiN5iVFaUedW+LxeDP6jxuCRdb3b6Nym2AdwYDxzCLtPnr
         L9l03zmWsAFf3l79VoecKkOAZjrB/V8K6f4KdW6K7rbitjljnvRR/t57CKm+tTztv+oA
         wOn6+G1TbeTcwjlHyygYbjBhwaeIqD4G5Y1WeJFawUOlCH0Mn8vKjzpfPcGeArCIcUQl
         mf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864427; x=1795469227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ro51FgAwM27DOCsfxJX1DqcXySD2o72+3qO5nSN9dQg=;
        b=yTt7q5UxL1Kq6O1ZTKKOxd6UdTew3P33gi7WC9gV5815UuQSlRZ4AJTsRC9TYugROr
         MgvGD20gD2bBWzXoNhF2JK3krVUrcMMKrlrZkQQHV1P2LFeRppuBQ/5DnyApZrt+qh2l
         fa6w6QMGtpiIzHBZ1yN0VmvE/SZYfT11u1JFOKX76RS6ELqdsxIe8okN/CKHjVTN5CVC
         1GYY15gtGZ4/bM8JeGiwaYxpeI8LHfOrJEeTMbYjX+59pj4dkEl0OjIuoZSpRZ19TBjP
         Wb1Bk9XtBNR5z/nsNEu1pHPZpxGcgil5P2ukJI6ChgZ29IghYgJQRBZjMUebJ8wvGM+H
         vlOQ==
X-Forwarded-Encrypted: i=1; AL+hErGI2lbkRcW1jUOFHDvuXV7k94YDJlEilD3VdB31O+qh/LvIaXFnANduCPFb7R4W2uH9253u3g==@lists.linux.dev
X-Gm-Message-State: APuU4Z94S9HtCcSBWTnBx1pwwr887U1UMXz2U+xpuKkssbTmz11KbQxa
	XByPYw7izmfKsUFxQW0+D2Ndud0xeKdPU4zZoleyfe81hIh2jqqXiXzQ
X-Gm-Gg: AZFdTZf+ANukXrW8s1uEQHen6JLc8PWUKuLkhuvvS8bF3oAOxGS1kxsgFR/PypGdl6N
	+QEMgsA6FEwo5xMiwWLhNkRD/miCqILzB0FKXY5ypmeu/NNoYFGomZLHmPSuOGjUPO+8hg5eaqG
	+TcnVYhOvcvxvunxYUiHcELs33kGsZqS3/kCCwVYx7vs1AEUip3qYHXGWQ5vfMD7MlhVHdNltV1
	ugcvoRGos37WKChHdOLarRk+ntGhqJOlXotqLHpD0v8u2MdrNBCSryXnbd54CY0ZhQxLPDvjHRI
	EOvSUk+8BjvwbLwHnAO2LwqtHo8siCTTIO9jCMSGCRk3nKpL2oChb8P10R4sW4PDxAC/4zUzdVC
	Vqvbl/tQz/ymc1lDvcmdAvSQnyKuGJOh/OCksGO8pa35YiBoIdFaTK4yn/VHT8cJXTFvfsdfjAY
	LtrbKZnuB5X2qng2ndvzdPfPJfWv0kxsNB79SH1cw4U4lrRW6Lju1sio5QtJQc44oe9riEXRQWM
	yzxXwV6tAnYP1abNoAeGOt9o6S3SXROIyjHODeoNE+Z5bf5wZid4Qds4EaWNgvDyGRaitoGVnuK
	RAArTjQvYGnzUw2hvPt3j0iU75tkYWe2EDnEK2KH2w==
X-Received: by 2002:a05:6000:4a01:b0:48e:7833:2e7b with SMTP id ffacd0b85a97d-4a36c30c79bmr1458441f8f.1.1794864426917;
        Mon, 16 Nov 2026 13:27:06 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:05 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:21 +0000
Subject: [PATCH v2 05/16] dt-bindings: usb: qcom,snps-dwc3: Add Halliday
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
Message-Id: <20261116-halliday-dts-v2-5-2c92438c6c46@gmail.com>
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
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1289;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=cCyX7eu7E67i1+mb+zFb+/V3MZ2Z8Bvs+BbDvfy8HQI=;
 b=jodb8KTCYJuS0IWgZE7KB4t4x5w4vx+XqSva6vd9XaFcHbRLapvwh0kujvjIVh3aEijgselYV
 FDfNsOtrAj3APDDTnmVV1I35ZxWejVLlN13Q6QOSjvxv3VTGu5EUwMp
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the DWC3 USB controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index b77c02c64d45..7a8b72d2929d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,eliza-dwc3
           - qcom,glymur-dwc3
           - qcom,glymur-dwc3-mp
+          - qcom,halliday-dwc3
           - qcom,hawi-dwc3
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
@@ -209,6 +210,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq5210-dwc3
               - qcom,ipq5424-dwc3
@@ -570,6 +572,7 @@ allOf:
           contains:
             enum:
               - qcom,eliza-dwc3
+              - qcom,halliday-dwc3
               - qcom,hawi-dwc3
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3

-- 
2.55.0

