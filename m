Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864435;
	b=GtotU5pSXUPVsd73XKBtC8lt2WlvwrnF9+1Y5Kc5V2vfSRjRoJzgzKyl7pm3JjIOPzGk
	 9N65vfW+OPY99ynsx2/uwFlEQAPCrjNkGyawpkKLuFF8FGvlmt9MkP1NkgZtUCbJUPlL9
	 /5t6xnHPJzHbr86cSb5sxvwPSWdJWU+qk+yirhnx5qdMSzEzmNZX8mTC6VI8Y3ZGMqZPy
	 nxtGVID3eprAbp7x5U6a5swcJLw7aCdUyjh+cLyIBNMDStAOfbZ/tDkzT4aV70sH7/52E
	 QFMwOBglK7YyEFe/kPmEdcGSBNLJQ6H4UlR/arXKD2llbuP1hTDUM7/yrd06hrU1RHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
	b=0N+J0+V2lrdqcOqG9Om2E7vw7byJVMJsa091M2ZfdfnsAH/9kw/C9t67XzvjDdnLzeXG
	 QqQm81rl/cBtSExZORDD9A/Qm41kZamf4nHL9Ocpm491dUBIVWD/x0RKJIJ2w6P/FxdUr
	 hsO6WEcP00PHKTTDNu3pe/rd6vAyEegPF4j8qDCaa/2eWjM694w4Cj7EJuCMGEAki7s/1
	 DwqfMTDMYj9sRCuNB5Q7b4rS6jRBsTElJq0mQnUMNOChbSZc1NzHIN4dWCUtIvDGY9rag
	 qROMnnSTliHJsM7phdNvsNH6kQOMyUxqc8K7lTyW+VWTi9lprpfr3UdIGk7Z7zWkmow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XyHOkOw1;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73450606A333
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73450606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XyHOkOw1
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1997451f8f.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864433; x=1795469233; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=XyHOkOw1/bH5dybDt73kUZCufJReDcOltXkEa+zbV6ULLB8ACFKcOKXdcLcoambrJV
         EdTZ3sqchNTs6NKHkru3fZdKpDjPB1WmOphWBxp8wM4wR4KT9eREXZtKISke4nXvUK8E
         OQLC0J5d4wZjxLJ89LLaB1HXPO+2gMVtVU15OgTM1zVnykkdbUW0VqguXM9QYrfakqZc
         HT5+p3adI8dVAyH8sl9ufSO1T+RHYFAbZv6jMRqaVUadrTAedKsb8qFUWOQ8HrbPnkJ1
         uD6DRtLuFkTjnDTAtgT09U2OGd82Hfw7wtg1/S641xrcAXfgvUZr73SvAex1Qm3JbDwR
         i+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864433; x=1795469233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GDSoMHQsxRWl9RceBND7eXD7fNs4JK2UCz+AN9Gniw=;
        b=Tc9p+jksh/5pm22ryAtK/AXK9Tkcod6Cpa172vBEC74XkWIhH2TfMdLw3l13uFZRxb
         Uf21dm+LPuIsIhcaSmk2+7k/EDp/B6rRXWWKol6AgOAB0OJV+E6i4BHr+qgSe5Djs522
         GKmg0hD5psj/qQ9HIuNF20xLPcUrD5uF0vubqcMjA6N8ONNvid3nuSJuy1+3a4FyNKo7
         BlWsNAAaTleUEMk/Ag++p0puS6abL1o+iS4UQ9uEDbI6utTqywiDjpaVN4GTZSFCziqZ
         rZ15DuS41i3ReSWO7K63oqhP9rY0mm5NEO8jh0oM41VyhX7i+OnBNfP4eLccxV0k0kJz
         xRkQ==
X-Forwarded-Encrypted: i=1; AL+hErFi3o1eq68XzO8zjJDfCx9jHy8RJLrpL8zGblOLRdPc3IYTUFkeOZCrzB1rrIZ+O3/y8jLcxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9+nVI/K3bL+RXcTS77gC06pza65aw/o/89ekrnWBFas2QNyV/
	YXmPwrZ8fsmq/SE24Dg1R1+451hpmf8iNStE5PiUkysENkv07CIVSfht
X-Gm-Gg: AZFdTZctuIz0anD/clJ2iO7Sckw0Rmydry0VJenfSdCennofmTW5y+/kth2mA9SRnZ5
	rgW052xddi1a8nx9xxrUgwfLiIdDlam8zx5y19v8xVwkc1VLDPeFVSHK5F01PLqmHyAgM+Lkl3t
	Wq1FjdR7X91ghLEoIxbsFJEaQ2UooutZ2DOlbm4ADbxZW/btv5VBSYXw50s6I6WXXDuIhMJ0Gu5
	6vWIk6NAdWQCLNE+s0GK2h9KExBP9FEugqDerxYuI+6hclsxGetWnXATdBOX4gXaxl+Ty2jzw9W
	dGN2rc2SLPUz7p4FZpili1L2SQ3NXCsFw+wRuLOdRexRW1bVBYQx31biKGkr02xn2QSgyFSUuyZ
	cR3xWZqHHvnvwIRohTs/fKSCPkCPdCkPaCSz4uhjc8DF1v4Gz4MdeuEzaInfjUEbDe9b0KBoKxH
	7lUyiSe0cHak4fuH7MlUJXv7CiaNNR/Wv73BzuBdabQhZCB9xVU4/LHJfzDTDb5x3HfdZA8A3x1
	I7KZCt0MOPB6jYdBA8EmkHgdpufjLC1HRDK3+9DK0UUtdOMttVYI1xtGvtAYY1we+7Q+ZXcMt9T
	jyi+Y4YQ6bPJ4MET/983YJmKmrbrDyRUy3F26NuE
X-Received: by 2002:a05:6000:610:b0:495:5c83:51b9 with SMTP id ffacd0b85a97d-49c7467a893mr27328310f8f.50.1794864433590;
        Mon, 16 Nov 2026 13:27:13 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:13 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:22 +0000
Subject: [PATCH v2 06/16] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 Halliday HS PHY
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
Message-Id: <20261116-halliday-dts-v2-6-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=891;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=iomST/Qr961He4Ne7crBcxin7EtHuKLr8auNEsY1c6w=;
 b=XlBnHuuXKSsmwBoy79zd7CM/aQS0V4vz73O5I/ykrhOgY3nFJG4rnY0qnm4zfFTA5sK35VFT6
 GeLVT3WztE2DdDA/hh0iSPFr/rHt5tVJ5B9S1do1YbNU2FqHh/CJpdT
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Synopsys femto USB high-speed PHY on the Qualcomm Halliday
SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 661759b25064..8ff1db4a1d79 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -22,6 +22,7 @@ properties:
           - const: qcom,usb-snps-hs-5nm-phy
       - items:
           - enum:
+              - qcom,halliday-usb-hs-phy
               - qcom,qcs8300-usb-hs-phy
               - qcom,qdu1000-usb-hs-phy
               - qcom,sc7280-usb-hs-phy

-- 
2.55.0

