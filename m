Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411F357D08
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568490; cv=none; b=K09nN7uOLXdH8f0VvJPA4UOQ3WEKzb82p0TyywvEFKgO1DZSMhy3dX7dBTAX7G3B7ZHoWGhXnJSgeu/K1C+t3h0oBv1dm72kY3/Md+tFbhIy5lFxFpl6vgYcgOKwj3oDUGisTPd0ubdd+IFvk9h8MKK1on+oNm22XF1lO2SNahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568490; c=relaxed/simple;
	bh=6wHpFlaVWQkthUTDK+s3QLO3JjBHD2R8lY4J2EbLGW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p0FzSApI4gUkH0E2rjcMbl3IXEvFgn27/7sq5wSxkR5vYJ22YiDu+DP4i2xWWO4Is5myF7jVdMw6rs9otYJ55/VYWcNvgrCbGsYOzDlNs6olCCb6zglfSmIY+8GZfwVpdVcQm/gFdlIaZ3uBxIcMojGYO+qNqCG6EtR22cNF7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UEw/GvlX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jeptGHf7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEw/GvlX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jeptGHf7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C4mrPw3444396
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 06:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2SU0b/R9kMyW/rWWdhry8C
	NcsvlSGgNqEIUHRWdESF0=; b=UEw/GvlX84o4q+ulkg5Km5SZFyOP/B8hQGKbsI
	ber+XvZDoLl7uGz0YXOsEwbGcsFV96SpbVCq1IpqK3RuAoAR57TMUFUPJok9wyOP
	F6WWWYkxEmiY3ogu2Vv7PAEKIwNP8j+qQw6qwytq4Dt62gqBZVv2fm/Phf803Fyy
	myd/MKjAFO3GYJpw/Qy1slIJGqF2NoS1kKmqzI86XbpfYd9JYjVxduqtf7fk3Cmd
	B+05jEMPm3nX2N8osyZLpTOdf3ojz8FN7MNRcWCkGMr6dLq1RfSxFRKqam+fdDrG
	chz4RqkPOhfkilH7mzK6h8TD+ALHOM7CaVAY9QUEEerLpTyA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0hvmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 06:47:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c828cee4fcdso1160530a12.3
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778568478; x=1779173278; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SU0b/R9kMyW/rWWdhry8CNcsvlSGgNqEIUHRWdESF0=;
        b=jeptGHf7DxJG3JamX2PuNzdZI5hpE6DacXKgIL9m4HvokJOlVOl9tOZE7kqEIt06l9
         NoKG5TykoZlXkEIR4S7hVHdEBKetYFJQwGAQuFFcGpP8bcYGB+VF9WGp99rQDJzuQqUh
         G6tbBTnB+hGtPKaSO/UU1I6Emrg5dmOgZARsK2f7yjTLSwXmFE/lVVkBWHqQbdlwdMpL
         b6JgSMMKOWYcrMkKTHblUh6UED+jDa1ZhxSL/6fuWbGFIrDvo6nxB+DBQ/AW0vWv6wh6
         ATIFcAooe0fYIhkBHS8FzAeFBJSj3mdTI2pkQtnbA5DadkMR0VNu9OspcSmr27rSlUzT
         BF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568478; x=1779173278;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SU0b/R9kMyW/rWWdhry8CNcsvlSGgNqEIUHRWdESF0=;
        b=dSBIE6ifcVb5b4k1D3E0sST0FXArnAeFiSPr7MFAmliIVhB+6O8eBmLLBGLiV7wDaT
         2PHMR4L6BI/iDiCs6BaNRlYCfnfnpZaOkqUmmaWrXSHWOjKTUbcLRACoIFngWN0a1lkr
         Ralldfecm4nj+O6Q90xf2B3rRXhx2GQfuhclXxkY4DB6liSaTrdMeREV0VjXfhR0WPLn
         36V6WQJPKQu90X9bC3D2ICuIJ85xTeHgMLpgS6lO7+LTGVHZSxNGIcNdURYLQor8xYk6
         rLitMqAMoqdgMdFaplRmJwNZbKaXMuAd5WU7ZHOL30EhlRJKErQwxPWWgmr3dwexlKzV
         fzog==
X-Forwarded-Encrypted: i=1; AFNElJ/r9YtucTrvQEjjlEiMYc+uQH2CWTju+GY0CUO5Zi61C0O9iDCpZSayioPsJ8eHQSbbXn3HFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHQFIt0P3vN+eNRnyUFg2wPuAIy5CFuLODzrz2kHtIt/9nGkgH
	SWdIvyiKWsythXpAzRx/3yLbCAxQZ/84byAqEjxN+vQQE5E4+EN80gqEHymW5ZQNJtGttr94x4k
	RqY+Xn0ZxZg5e+hTaN1ozkZewNP3NJN7zX1vIOsSliUwkpd08+bLJWbHFIkk7rxsfgA==
X-Gm-Gg: Acq92OFLELVYS1UxOUVWF0C2yCFDDEROC2fkLn8lKn9yPTSeP4wqcLfXpqrFM1foUuN
	nWnSRIouPQQjAQveG9GIvyucwl8NVB7vdWXczXYAvrimy8oHpZm3UzUCNqc42offv++eoiGpqIn
	SbG93HAXbOTPZ6Hgr6QkkjRpNLi3ziKSE9nFLMB1R2qtxQtpVvwCxRIh0VfkFMVME9x3SbawoDc
	dEw7yYloNaCPxPZMBXLspyQtfnqzR2dWidTnKz+xRV/nwOFSDOUn/4tpT7ddy4ca1ueQoAC58uZ
	havKfYgUF85+gIBj07cbGfYNgxpyd4eG027f4pbRU9RQI5spowsbq9rAe5Lu7P8f43Qr6d5PPjD
	QeDoNOzyaNoqT2c5yTOmml8U0S8guIdMJvd6F4UfEcoKmUtm3Vy7UZcSLn4kmSB5yyLi0co6njF
	7glD9l91KZ31g+MiYeg19sesdOaaP8xOe6/2r2oCJ8ylohqwKyXr1S2r2t
X-Received: by 2002:a05:6a20:472a:b0:3a8:2af3:ce8b with SMTP id adf61e73a8af0-3aa5a94e12dmr22068173637.14.1778568478283;
        Mon, 11 May 2026 23:47:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:472a:b0:3a8:2af3:ce8b with SMTP id adf61e73a8af0-3aa5a94e12dmr22068150637.14.1778568477780;
        Mon, 11 May 2026 23:47:57 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267711b21sm11301479a12.15.2026.05.11.23.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:47:57 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 12 May 2026 12:17:52 +0530
Subject: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for IPQ9650
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABfNAmoC/yXMQQqDMBBA0avIrBsYIwnqVUqRmow6gtFmqgji3
 Zvq8i3+P0AoMgnU2QGRNhaeQ0L+yMAN79CTYp8MGrVFk2vFy6eyBhuZprVpOXgOvSqsd2h8UZU
 WIaVLpI73a/t83Za1Hcl9/y84zx/kotdNeAAAAA==
X-Change-ID: 20260512-ipq9650_smmu_binding-36dc05d39860
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778568473; l=1078;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=6wHpFlaVWQkthUTDK+s3QLO3JjBHD2R8lY4J2EbLGW0=;
 b=WA3d7eYS8WENn5BlKpezS7JDFZq9Qiakj8wOlHNjrws/8ygcUSCPCJ87Cr1QXn049NbMh/6kK
 3kR7G2kvZU3B7dH6SAJwNg6iKQgSjBxHYa57xvnVHZ6wiqOe1mfI3X9
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a02cd1f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hjL68i5Il40rG0QApAQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 57xlv6sSmU-HV6LwswuIsdbDwtUyTog9
X-Proofpoint-ORIG-GUID: 57xlv6sSmU-HV6LwswuIsdbDwtUyTog9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfX14fr3pYcZBuT
 Ye/oRnXollMpBLh+ygEm4Vg3kPr2DZ7xJyDOHyV7jU70yle0yw8G92ALtN4XUKdXJl9Ho1BPm4s
 e5+EcLH/1jo5vDOs5kuA+Z4vBAxUjIuTyhLIi0zzqCedmNUljf5+kTLWEnpbwwLirMlZRtIyciq
 aQOnPWtTmsa/IO8eDDL7dvAGR1EUGlWWeGv9e0iWMp7oAfH1iDA/ZcPwuvtxKXvYkMTOMf9epuc
 hq3fpmR5Dc8JcIlelg37EjK9r7v88UDNbjGdPFvPLGULN6N2a8XIxB4+RJ7gg6tZClAtLlidM+m
 H/DAuo6Y5qy9fK4K3t9VvL+itKGW7/dTQj3OQafjtndvvhYtCyKyJCkFDWD7N6nqYbMh5Iw7/nK
 oSbLn9oyD4EUrLSnNonG2WFfPAIGwgPlsocqE2LVp0dcmw8xPK7C/qZLinirUogzI27VLUQqSXL
 aSh7a9Ewtx06CZfpS1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120064

Qualcomm IPQ9650 SoC include APPS SMMU that implements arm,mmu-500.
Document the compatible for the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..226f16711d67 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260512-ipq9650_smmu_binding-36dc05d39860

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

