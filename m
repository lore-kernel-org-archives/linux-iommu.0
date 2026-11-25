Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578267;
	b=bHTFG7KhdOlxjXy07tuCff+CntSFG9jzGgZFBcxoLZBsY15dXH420DhadzreWTD9tJLF
	 jej69tpSkfuQz9Tk99vWuUhqg7nbuaCNnG679Z0whiy8ozNlRD8JNFp1hl7NVXwgDNfzq
	 X+lPwXbv3UxD5ysfsRfl8UDdUAr7s+cn66pEc+XP3ODJzilTWzSJ9x1zHtHTK6Me1cMDR
	 eOa1TPn+io1yHlKvdmndrLqVhJP7FToSU6TThZL44r423Fd7IPBnTOO9hY7S1zr9cOfJC
	 hj+pW3xLR8vKTfd9XD/OasaFyvoQW64ZNS1Oc0cTntlQqe9HpavTiFV3BNQnr8j/ppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
	b=IlOWE8umlGtYkv8/ZzGNwJdPIUMJQWPBIXOHVWhxQtZbL9r8tS/ljVfJZgpZRqsOMOiZ
	 7cJtntprVNicHNlDIZcwDhFBLkx8Kbtygbg/CN3d9rsbF7d4Lo0FHWOplHQLx+z90hQfR
	 J2O57fo+pMcr+vKUDctmmsX5mygFyE9jDNOZEF97Vocc9K7zN/wo5W8vi0Hl30fgwfiul
	 Q5n+sw4elsP6xat8Pt/JAPhLKHzTqGvaBZBLe1sLPwhMOlluy1AHVNeZO9i8f3W+/mwKd
	 pC4PAvTKqqu2CzFXyFVYm/zCARQvEUt4ZuZHySDc005HJXip1QfC3LqKQkw/NmLMrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0AiDCz6;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4108606A31E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4108606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0AiDCz6
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so50805485e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578265; x=1796183065; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=T0AiDCz67lJmXTg+Q+/0D4HY8KEnAb7CeaCIAVxMeaObkr1AxsU3cxZxgJgX9z17PZ
         5DGaRB6vHHrYJbrZDzlEy5xxxRe8o/WpiROO+mmYNvW7HqvJnS0NeArE9g0Kg6l6jR6w
         mJA5+EPY3uZsIqMMRNeUhxExA3f+ro+JOXrzYWGoCuCXA2Lx42H0gSQ7k7O0fFzhTNMr
         Evmw2LGuncxpxdUKpRh/q+0FPtW3NacgvfqdmeZG7ADLHM64O5OcxAcalRmFEeTSjW4q
         shqp9UbCMuFjq/cAT9r7QBFh8uUoADPqPeZF4gAXKXuM6Ok6wG2pYZfG4/wXTHL6sJeZ
         dhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578265; x=1796183065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZKraDRr1i3pFiLzoYIEWaHhHBRYyhj/gKsvyx4GUpo=;
        b=OVpTt+HnXXCYQxXc1YQyscm9iq5PEcZqXnjAWcybFM4HgsYu4c65+OWaW+nvS9HM6A
         zPgUbkHFUcjEvRli0TCGRdtmP9VZaMg8O85cSkTy1oEzxcjm4jkbEuwz1WciRM+KZGv5
         jYsglTAn33CqjZ/mb6cR3xk4rLLg8MhWqNCKz8apT4KaAJBrttcHprgXGUlQq2P/HQhd
         7uYAbXRuyDgtIwBA2FG1hilaDRSdiaSj07AwwrxYMSzlfdWC7pvvr3tZyK5FS7isIjky
         gEbqufLPAsia/IEpCU2k62PwZWUNvyP9WkNagyUAd6lEEZI0iiKnLz3djurik9dCa1oG
         GFTw==
X-Forwarded-Encrypted: i=1; AL+hErGy8VBWadQVUMCXAG6hDx5t3M2vnNs7WOVHU7uspofcijdZpML+CRQUFuikQndOdN6UWHgEEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/fDL8leLfmfpj1cMqRlWpE0lOI/c+VhiFOIVTQPdgk3ycpAJTJ
	4p6NTNQVR+oCGjxmtM+3UCq05hGfhuINUtP0Mkekm0vCP8vyzfD0EAAp
X-Gm-Gg: AZFdTZdvJqKwNPotA6tp0jOxouwzug5U0ZBSGGW/RxmFYl0EHmjXeUrtSeIbl9QFYQi
	JyxiMCQfo32ob8dsI5QdPooHxJtO6N/VVE5dc/AZtdQccvD2ZnF+o5FW55IKVAmz4aGoRfKretc
	cbX2Nq1kKjCGk9fpDFa887tmfnkrbJf2EHzEcOfnrKlbTGVcoUtPkLWV3/nQA2HVPRkWoKRaTtr
	ldkridcXujuEBmog3Vzwc+07GDvgaj+etc0dOVmMj8j03wpYJKncJlBTl7fPQON7iCXxUFaMQDd
	GEaZvz0uPKOXwMtd0R26N2nZiKj5B4WHIUzfv6A5iiWdsDPDUv7EqJ26XvIbMs1eIM0GxMcnBGL
	mFTeajwl2p74HwtedZGoVtHqA6fu/xuGFmajsagOYVZ+QLv1kxxcq9WCXdPO7BYPJ0TP/Juv7qh
	dxez5Lm1FVdPoKg2FF7HeNZhyF0cv4a9nR1ImqTq13djEAYuSXbdNkSfhy5KKVwUQSGMiJlTlVc
	GXkAombyElYjKzJopIL4E+RLq0uXQx0E5GhGV/aBeqEwSfAWGCvmWsRQ3si9gAuaSYriZwXUrT1
	dSdovEtR64o+84ClplBFl8uE7x+1W+8GWTn1+Ps=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr314413945e9.12.1795578265228;
        Tue, 24 Nov 2026 19:44:25 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:24 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:06 +0000
Subject: [PATCH v3 10/14] dt-bindings: firmware: qcom,scm: Document
 Halliday SCM
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
Message-Id: <20261125-halliday-dts-v3-10-5c8311c0b70b@gmail.com>
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
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1106;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=OQO+LwEeY64jVYcmV4r5bBUUpcSQt6/n4JPVT4Z/sxw=;
 b=ASSSZ1iPRbCJcDXI+svsrzgQJoNbt/i5IYWaxMLqGZRF5nHWw5kJhARXjldkVDjeYGCb2JyQL
 2OZ0LHRj/DeD6xQR3UFBtL7exxUKJQpjnA5HrXZmN3rAlw9HlvDVkc9
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SCM on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

