Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F663FFACF
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806540; cv=none; b=EK8JDv1xOlsDnxh3jZVFVYAKIEKcw45CFm6GGlah2a5zYwIfexCLOioW7qcm3L8GJgsbHSEyH9NaWKIEzo1Ufp0bFGhLDJFHNAybovCyFTLnFrw6B/mcz5LsZJCeDSwfX0waCgGwBgp2K16ZJU/yiyyLO4Unq9qe/cR9K9p/Yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806540; c=relaxed/simple;
	bh=hEmrpLF0MW67gYArKBeGVtgmYcIX/5PJzRk7wSNO0Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iziXotLOeGNdTfCXiYD8I2p+297G8wNO0fP/eJITQKtaBlxinJa6nIgURUTxk4nbIN8pgWHQy9XZSO+xExmeNFw6ljupqIis988ffk8XREl8ABwpQVZwW6TnedpvaoSKkF3TXXhQ40wcvqBbAlnWJHtnkwd2UPPvSHhvVj3mToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VXlAaWIw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6Jbul4S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VXlAaWIw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6Jbul4S"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QD40RW3693561
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjfO9SOxMjcqAbIgumxNQ0k4LXx/d2l2hM63+y8xMpo=; b=VXlAaWIwmJK5EYUI
	UkNs+7BBkpbO1UL0oXq+c0lLegdgaJC9cDD9iveZQAs9x6GLbsP5WmM2BPtNjjXy
	5qT+hqq/dxwDAMLR1hapv6QISvpJfbyEqH/IWvx0Bhs1UcvyKfDvUwhnONr5tTBe
	dRsll0eVDUw/4IJ6v6MB1l9TpZ1mKvTi4YLholuJbaP+Od02RhQB5H156G844wWh
	gF4H/8Xtbe1YlMIgtBzaArJFbdiYcq0AQ/1qLdJ+j4EGd0JOuaROltR/+NufQlFC
	XfsOQV3/aZ/IS1FhlxFbnEjXBjgxJKqCRAlF38KVdGgZr9frKMiGuH2esQksf5wS
	zL5GQw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2yggxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so3162813a12.2
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806536; x=1780411336; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjfO9SOxMjcqAbIgumxNQ0k4LXx/d2l2hM63+y8xMpo=;
        b=c6Jbul4S0WwU21FXX1bdvqroPJmKq1kt1nb10CGiE5jgIzBhoEka0r0OQskygp5p0o
         FdUNtMa6TLkON8pATlLWMK9Os0svellaJhQMleSzJ0o6jm0jTcFGvB5D/eURIzJoX9Jd
         UHDMqC7xaMtoj7SLWwAFRJh4s940C3kx9e5KFcvBSlG3pSXQ0hZw7/KuMo3bpXzID9GA
         mZH7/mQg8UjRHNA6cImof9lLn13i3xUaSjGNqGHwKLgqPHsTNjLOt0ca4Hut1WZlDY0h
         TEdJSpA5YUgG5zwj74lfkCafFkUP8QbJ9/z7HCm4GSyywsqQLX6fbTITjWG1elVjn/Mo
         boYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806536; x=1780411336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jjfO9SOxMjcqAbIgumxNQ0k4LXx/d2l2hM63+y8xMpo=;
        b=Egc4LozAbPgVUntgZsbEef8b2WFZCIcLcVww23S7vB1YhaS4vSsuhk78EZs7gAu+ow
         p+Ugb2dWQ2tixcnk9Qpol23snrcbfZxYKIjBT6wZwx1d6B9WDG/nwcClmf9sl0A/3npC
         RMPS+TjgzyVgi8O857OI6GD7ar4cHuEARCP5oghpZztnJ037BYg+0MH9rm4Hd/8Amdf1
         Rw510lFVQgDU7ejtMYQ0nCKq7RfayWoHpZ9A93Ke84Fieg1AIkutHS9sCDawtFfeTrNH
         bcbZz2rQPcAAzBRwB/gGbXob2ak4F/u3425lrjW/TcloJ7mYcdEbMnj7TS3PtK0Lrr19
         JhxA==
X-Forwarded-Encrypted: i=1; AFNElJ9+fXT0cePo1NtTrtASGkzHsniO9GClxLPx8X7bWUlJgtgNnJU5v/BSky+y+kIS/CoHC/EKBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo6To2EZZ5yPsjFILD4ROnRBli/aQxGzRtsJ+oEl/unfE/yZzF
	gYKzfkS2ud7p5QyRDuPLydE0/mE5ali/nLN+MVnEkLEiAyqaJoJzqP1rBufKy3Mr/0a/eGqnEaJ
	tO/bdsoaZU+hteQkrVGz7fbwaZxiBfPflQnRWrzyZsjJdlRO6NTYIhjARCQ==
X-Gm-Gg: Acq92OGanmcJLOnKNRXvRkCCAqX0TInQFLHZyTsBRIXWKftV996d7AfEyl+ueT5FtmA
	2iRrIDz+KpB/ggKjAdb0FyijRbGBDJvw6zWWm+xM+l3OSUZEQLmKX4eCgsR+WqJZCm6n405Hgns
	g2I20Av+JHHXqQ0xlJGfNzOM1UjA34jpv2Ssv8pIi6b48C3M5r0jR9Q+tHtq0WHRVACcIBn8BXC
	533NB0muY/YxSF2cUNLMGne3hfbmr9ApDI3bwThFqsj2tR2xukhWLScV7uQNEB6D/GeiByaqCsU
	RiJzCoPb4ooNrbBKBLZ2h5vZpd7d+dt6TTN5nFlZqOIJKJ0GwC7IjdxD+WChDnLoKFQd7v2rmNv
	d8/w7nb0RbGToYVotNKvMCKG1PI0j62AmFXJNwRBfIDY/XemU3vEI
X-Received: by 2002:a05:6a00:8c12:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8415f32e8c8mr19004458b3a.27.1779806536442;
        Tue, 26 May 2026 07:42:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c12:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8415f32e8c8mr19004412b3a.27.1779806535918;
        Tue, 26 May 2026 07:42:15 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:15 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Tue, 26 May 2026 20:12:02 +0530
Subject: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
In-Reply-To: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806526; l=1894;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=hEmrpLF0MW67gYArKBeGVtgmYcIX/5PJzRk7wSNO0Vc=;
 b=gaaHTeaT5YX7h0T0xeiCVH4zAimV20AfMBwiZOwwyrQIHqghXmhre0IZwn4uUza43qcyBi++z
 8neeKvagCaEDa8iau4fEqoE+egqDn/IUaoJFNmaGYUy3FbRK4uKdxQq
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-ORIG-GUID: BLTFOtddz0a86WVXNDhK8Gbi7xzCbC1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNiBTYWx0ZWRfX0YucX+kH5Xon
 GndILyQKsU75Y8nHdB0jTrZDRz3lm21j1Tzlz6n9UpYyZNHyMS/tT1WIWCX8/2mYC6VDIEOwc76
 SrVOcb6E0O/adgL6aCEIrdQfQptc25z9d4nfEj4vPtPD6hZh4/24+ZFCkfIouM6GR0x4ulrCtm9
 oLT6eOvj8y/esQ3/VGuZ7ZzWPGEWm2KZutADAgSU3tm2i1/6JrtBisUZcBNe4mTr/9KCrMIgzHq
 utnpVpmiWZb/AbgBP2kUX0lGTXG1ObCCEONZST05xdiTnUBpAD3XPlOo/UKwzkcT0NCznmBvZn4
 HMAEDvrcJclhMrRPA7u/rSA3/QStfwhEiVJr8ieR4hY8sMO3zS/pPpSqSQFlcwEUEcDEHbEaYJK
 JZsjxPio2Ks8pBVTEFcYIS2PCHy7+ccVbgEKXJ0B81xJoQ9g70jYXPnvLGeGMP5qXQRkW25w/Bw
 J14/QndjOuoOTWqgcnQ==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15b149 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=h2u_PYqE-o0iKWOXq5gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: BLTFOtddz0a86WVXNDhK8Gbi7xzCbC1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260126

Some SoC implementations require a bandwidth vote on an interconnect
path before the SMMU register space is accessible. Add the optional
'interconnects' property to the binding to allow platform DT nodes
to describe this path.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547cb7a92823adc2772b94f747376a6..3a677ff1a18fcdf5c0ca9ec8a017d41f9eb5ff09 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -243,6 +243,13 @@ properties:
     minItems: 1
     maxItems: 3
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path to the SMMU register space. Required on SoCs
+      where the SMMU registers are only accessible after a bandwidth
+      vote has been placed on the interconnect fabric.
+
   nvidia,memory-controller:
     description: |
       A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
@@ -602,6 +609,26 @@ allOf:
         clock-names: false
         clocks: false
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,qcs615-smmu-500
+                - qcom,qcs8300-smmu-500
+                - qcom,sa8775p-smmu-500
+                - qcom,sc7280-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        interconnects:
+          maxItems: 1
+    else:
+      properties:
+        interconnects: false
+
   - if:
       properties:
         compatible:

-- 
2.34.1

