Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578243;
	b=aG+NdKc5oSf0I9BBBEZ66z+jSTUw3JJsLJYL4pCVrAkXeS9q9Ml0c34dM2jI0pK0wC4w
	 pt6fZn0bc7XMy/mcIbfTKQHCH0Rq437o9HWTXPbbfzCfscmhFJ9sB93fU0CkvVBXzew3O
	 UwJRQQoa+FMOYp9DM1p19TYDRWSIxsMn3AefISLgdUFwO/tG/KmSvrP/wurNk1nGvwAsh
	 zk2LfPEQ+4C/J5n3ar71amkUKoCjMmZV9nINxlGj3SJlLcHqL7j4MYlC7f+sI7LbWB9EQ
	 w/IXMILrYjtiN7ccGV4vVarEHrVVaBMDa4sGbutM8kGrGtqR5Nb2KOPgJHo2aF2ia/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qj41oco+fV9s3p+rSbInvqyHiLCYdw0nt/lz84zuf3M=;
	b=UmYcsq9pl8ZN30BnnAC8dXYs3/fbkT01lb6SCXBq8tyN9xQNdhRF/peMx63bNbqtce1f
	 0KCgKYkI4EHq6EwPEPupKPb/VUtz6RvKy6InIK1e4KnMrtfgjmWMkcTuv+9XNuV1dCjtm
	 TOZqQXurX4JDMWa7/3yn0oI02AeL3pwJpkjWg1S02m8a2IzUyxBhDAELjHgYOD80/aHdy
	 fGK4RU/zl9NQTFJ35vnfmg7boCs/wCJmYEtbBSJet071d4bSnMxPF5m2nYCmsIiRA3dHt
	 CqOq5+WcIKQRtTfIttXoM55On4dmz9FWpdSLML+N9UHKG/F6TlkVM+8ST/erByVdfSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VPYiKh7/";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B1606A327
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 03:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D74B1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VPYiKh7/
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso55193325e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 19:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578241; x=1796183041; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qj41oco+fV9s3p+rSbInvqyHiLCYdw0nt/lz84zuf3M=;
        b=VPYiKh7/QEgn9zGFfGreBzXXuRAmvFHKC+FJuXlZxN4A0Nag1Afbg39gS0B0Izlkqq
         xTTrGPoTBQ++NV9mkhSwy3XfwIE1irHSUVBV0QFEugcLkOiLjTiZagJBZKxjUpzh21CE
         iIixB082ZL1xE869bQc7pQ6Ab0F17OtCFfGzd284/dUkkl3/vtGGtLdB3e4U78XHN0Pe
         HPvD3y1CHDbHrPKYsUz3WPZ+ctEP+lx+bqrM/CFLcre790r8KoZJJbmGg4bqKFEKIoL5
         MQCUl8rJtKdQ03Rj7eRR4TBOrdcxqj3pZmIN8q8L2/moZMAgR8boN9ug4SUIOyVBMoRn
         uDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578241; x=1796183041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qj41oco+fV9s3p+rSbInvqyHiLCYdw0nt/lz84zuf3M=;
        b=I2WbreWaVNgmCXTLYhlYB6Tv2/zWnRZEt/VTw1lhILZxmIcIJ8lL4Oc5eojL7rQrnT
         v/R2TlGovtlcwqrDz0k4P577Bkty0kWbV9cfzvdlgkvZGIhg/oyFCFDk0APvbfi7PZEa
         Q3cb+0tTwb9gSGgNRnmQRtPPB620Ea0sc+thz4OxU7PYsUvVitLG5Aa8fqjm76R4LyOZ
         snVk+g+FuQ4J3gLo/19oTL2INQ/EVndVB1a2teMipTJj1Ral2SovHJukN5C8dpvHGctg
         0uqMhkF7e7RsAtFLDQKr1rdoDbbobbv9DaYrFWS2Kphl0xqWSHrc99FpXxQAk7/VCpDs
         tXqw==
X-Forwarded-Encrypted: i=1; AL+hErGIRSv5tiJmRYoglSVyUC5KVk5tVnxJKjYVBzQ/jrKe9cqGx/Wuz/RiaH9X6poSvjDvtdXRvg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/uF428TkReEDctGZKczr28vtj0JLLMHdxRlY+Asb8qHZZ+yrvw
	+/hzUx3oEc0ncAAhj3CCFoLWpYB8n9/FgnhuGMF0AOlCrYE3mgksuawl
X-Gm-Gg: AZFdTZeowhwFI/VEVG8PH3jb/p5Q5idsfSByOPDLo2uDSq96NcKEDXa5JoHKfxr5LVi
	jKic7XXEBTD+ehjsSiLqkygFVh6n3A5P6p/haG30UIarUEbNjfbKQATykNac9mHWm1HdakGLXf3
	3gXB8/rIY2/bAWbCnteK2jQeluBsBxJR2HG/bqrd8ra7vqo/tLTAOENm3klNcCQx3Ibzb8q8213
	7xyaesQ6kdzQq6fnxl8FDr0Mi5F7OWSVdGGU0i0ZxvnfK/c0p7K4oby1KWUTzDfEnG76mVurc7L
	srs0DpFTLa1QpwhqJSL8jUEL2FE6TtGbgJAq0zG/gBbo0Pb6V7Wm+FMwm2WzKcfvpx0d1q0GHYM
	0kZNgYX+GF9vHCQkUO+uf2Ga0DjTNIpM/+xmdbpjoz6sbkEunQG/V1+WjFwttiJcEPctdm2w8Ol
	zmQ7NcHooWNdUNAvRSvahVxOROPphOlm+xr+rONgHL6dwblBOuVPIVTxXUY/Ddvwhdvu1VMGN1M
	RLQa0ipYx1Lr2+0i0qrmI4JK2NJ3bkxwc0y+u/dRpWufxga6GKEyq1ysoBSSm7MMpXRwCT9mGFT
	q8XD0CA1SwvUjqL5VfidZOJOKSPL33t8qob0vDDW9enhAKGTam9w+IxF7Wlb
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id 5b1f17b1804b1-4bb8881099cmr321134335e9.12.1795578241263;
        Tue, 24 Nov 2026 19:44:01 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:00 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:02 +0000
Subject: [PATCH v3 06/14] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Add
 Halliday
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
Message-Id: <20261125-halliday-dts-v3-6-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1066;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=LnBBJKb9fDjzFgKcPxLWG+G1ECrWNheGC13yLk2PP7U=;
 b=AK3HsTIHMWrfVz7oshpUweVMA1RMXUBxsZdz2vUtNRXnyYZuhyvlqRD0igQTo19XNPCP3yBIj
 lrBLDzvfhh3Dy0LccQPBEZwfCNYpwtXoUv7VnuZeXacHd0nFK00aqKC
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the QMP UFS PHY on the Qualcomm Halliday SoC, which is
compatible with the SM8450 one.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 10435a0b5230..a42bba9b550d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -28,6 +28,10 @@ properties:
           - enum:
               - qcom,qcs615-qmp-ufs-phy
           - const: qcom,sm6115-qmp-ufs-phy
+      - items:
+          - enum:
+              - qcom,halliday-qmp-ufs-phy
+          - const: qcom,sm8450-qmp-ufs-phy
       - items:
           - enum:
               - qcom,x1e80100-qmp-ufs-phy

-- 
2.55.0

