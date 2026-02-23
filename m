Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D123EAAD
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836407; cv=none; b=IVY5Xhn2r5ISisjws8Ce2EzXEarAHyeBXnLsh6/wvAJH+I01hwFfUhGzgC3tp4i6p7w5TWE1rBAoE7q6d5Ti+mbvhKarz7zWX/sQJ6KjWQwH4ND5fSoGmdhz+Yp/syr6+9G2YuyDrafY0oW0u0yVJgLfhsav6arBOfouowo53jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836407; c=relaxed/simple;
	bh=8AJH83rXVfEXW1J33bR0nuh0ov7Mv+Ai5lWlF96GRHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QeeZfMqrqt9zvX0ixJVDdH4exN/BtnFuAS0HXN/FXGw14lVSUFgnaQACc3GloAoEg/sC7zKrL8smcg74Ifie7LPRruCm1hYtC2KIjQBXrkHDHjE1OJmcVY0BwTwG5+aM7dFIIZH24DOcubnUwb6iQpJx2meipWyvA+AzYqVg2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCwqAXMU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwIgIVfp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCwqAXMU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwIgIVfp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMAjdp2154922
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 08:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n82k/w55FcgX53/IQIrWIx
	Dm3R2DN+nUhmvaKVw8RtY=; b=jCwqAXMU9nDaE6lanrFtjPTBEz5aOVF1yvjS0t
	vHqw0UgdoC/mZT7Iul4bm2wpBCkPpXmAJhr+NHTVf4cTfdRyyO6cmd7+FWOkJSih
	M6y1zY8iEhp85VHK4Zi6HtzAWU+rme7600bWU4dmJMGXPhl0phNaoTBlUQb5DSNu
	4TI4uv9M9iA75421TmyXmC4qcMUx9WlbLotml4Y4CkK6re7IWdbhkwqQt4Ksce5+
	MOI902ribAwL96WYxz7GYJ0oxcdEOBA14ejNK0zBVP6x78vtGWzPnf6WUT71oImO
	PxmtH/L+ERXGr8gN5DJG0tVYemJHDkZGHZ8pCYW24RDFLBPg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vukxg8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 08:46:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ef98116so4595519385a.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771836403; x=1772441203; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n82k/w55FcgX53/IQIrWIxDm3R2DN+nUhmvaKVw8RtY=;
        b=WwIgIVfp7cyJDlpYZs4wjenc9m3Vs5pRHULToGUP7VY+5ZGRXChc3z6EBHtedBquWi
         lGC8+TCtss0YXtbhV1Xwj+9+/4sBiUTS/fyWmUwbikuu/P0+3qWUVM/1gxjQRiavgz1B
         /L3SSkG30BYp0KyQsau2YH1T3Jl29yNltkVs0TbqE4C6DU1/DhIQhtYaxhyhkII68/C4
         XizrhNsduXdrUMavJn8zaN3PCq+NmLWxk9GQmBjIm2LOchqmH1yKE0g32X98xLcRLfQa
         MOfGHsHiah8REOkiANTXvgOSqZnVEpwam1b6ZaPLIpPAiaxiI90NPoQPnumdDPjq0Ax0
         WwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836403; x=1772441203;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n82k/w55FcgX53/IQIrWIxDm3R2DN+nUhmvaKVw8RtY=;
        b=HCMmVIYlZ1HJqq6JJfFmJPLDknK87gpgRypa9/bX83g3TjiynnE4evfKrCe97vhu/G
         CSLACHp/lu13fa+XDDnDFv5hlxo6n3o5ryXykkKyw9DwB6RNphffQtQNs5gdrNg5wvAk
         Z74FSMNc/t1iu80ENVT/Dz4RCcR62EpknowMb+rBn0stMsyhbguk5E2hoM0NURtso9D9
         6eL0cqA81mYFCTKwBOUeofK2syvtRrsnukH6keltomrVI0YXfXpEU/kO00VB1Uyt0wuQ
         k4EuXxYD5bVRwbAEplc36WIyRlhU11+oVFKJazEswmkOz85Oe7mmQq858KH9WQzOQnfV
         JO2A==
X-Forwarded-Encrypted: i=1; AJvYcCWYLMnqBpD7TPR6FMD6/tdwQbcJdAP/hYsaaNyk+mf5//lt/AxJ9v5IFnLOrv08rzEihHT6Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywmi/LxQtJTIA/oogFeKRz6FrQqsPMNLcRI1ef0TBfYHtdbLDN2
	9MARQLYeEwcQ+Q/hPabRfytbjIP2e7YAL4yhq0VTdl8K5xPCHgDDt21APuRKT7RtM+gDW2Pq2gQ
	xO68ILfty6Pc8BL9ysCWtAw0Y67bg0BAoupW4YcRvh47jiBiODYQ1z7GQZA==
X-Gm-Gg: AZuq6aKXp9sSLi+Wz3lLNERcLMmZuso+VRkz+xJsVTJo/bwklT1pRC1aLT5Nlx0QZAK
	SS3n0UQZNmZh6J1O5Dh2fQ/ftC2BFpaF3OKscremMPtWPD4/b2HPsi4FhMnyNclt8X4qzWNXvVy
	G6Cv4ADrJ7acdP/87cYCRDufSzQwoiRmYCEHyOflCtCSz48Kz0RoRFt8/47cJwyrz3ieXK1i9Bd
	EpCPBIf3HJBinPJFklE4S/vMyhryWxAmtLgvDqfjSLdzesMgg4QAYm/pcL2xn7kgaLcX2KlHh4a
	K8OyPFz5ELCvAKVxE5NigUDoTi8v72GSpG1N5ayPZ2Ay8Eg3HRV1chUcdf6E4aQtR2scLEi1mEo
	jbzdK4SJWAHnkDXslXVUNM2X0L/vBGw==
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8cb8ca18f94mr1010153185a.34.1771836402943;
        Mon, 23 Feb 2026 00:46:42 -0800 (PST)
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8cb8ca18f94mr1010150785a.34.1771836402375;
        Mon, 23 Feb 2026 00:46:42 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm16370928f8f.20.2026.02.23.00.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:46:41 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:46:39 +0200
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for Eliza SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-eliza-bindings-arm-smmu-v1-1-7a35a76201a5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO4TnGkC/yXMTQrCMBBA4auEWTuQTn8EryIu0nRSR0yUjBGx9
 O6Ndfkt3ltAOQsrnMwCmd+i8kgVzcGAv7o0M8pUDWRpsESEfJevw1HSJGlWdDmixljQHn3bdG3
 wQ+ih1s/MQT77+Xz5W8t4Y//67WBdN3ChCx97AAAA
X-Change-ID: 20260222-eliza-bindings-arm-smmu-07c3143fc6f5
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=8AJH83rXVfEXW1J33bR0nuh0ov7Mv+Ai5lWlF96GRHc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnBPwntu1jZtnK8ugi9hs0WbYg/8SVKBq55Fzr
 /vn16m6wdKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZwT8AAKCRAbX0TJAJUV
 VumoEACoxr8gPTQ1ALnN+9TxkqknqMgEDfZ05rcBASrOF90m/1O8Hu/FgATUyOdUYKLYM1BmSp+
 FkgsaNhrN5dQ7iWKEgUNm76WbuUiNnsq6AvMkSgbfCxZHD3F2aL3CJqB6FyIk+lGHs7LOXTvw1B
 xNRI+dOD3pL1EEedUG3U8vd/sRbxpZFTvaS8xm/9fTgWwWk1tV7q0ZbeDUT5XTMpVHQkIfuzqDF
 STTbOiumq466QlNR9YKrCyY++aSVGvt1eHw2w5w1kdWLUghTlEi8cs7FvGPvz1zjmBlh98ZA41+
 EsED3oSE3Vxp6k45cLlarvp2AlPcAmBrTk84AyE2GrtvrHyWVB5nCRHPnPQtZP9pzboSCN9tCtc
 cphD6VY5WT8jrGCgM6Y5yrb6d4YQ4i/vYOg6yBNuYwPtb2xaRPs4dmNQqrgLQomYuXY1YzckFrt
 tWDubq/MU4M1Rnc60wGVNOvtnkAnWqOXqTt8QW5ajsLMldrUuO7ZtaPRLdeH+f4dTzbQ/jWWe9B
 weLPgKvGLECz2Efo2vq38NMK3yfysjDHnjSl3tgRX6anAr92myxlWrNjwkG8dYg8rTfm9jmtsh7
 6O7RlJqS4nIjHPZtVB5O5UfFSeJb1yfYHmb3ThFqVi3Wi1b3b60ayatm9zPyFk9WSY4RlY2e0MH
 +Rpvu6wHmDPAJkg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=AL4GpdX7 c=1 sm=1 tr=0 ts=699c13f3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cTTMG9H1hPCtB3K_XmwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: oGjeJnSO7kbuBih0VWqT5_VJ5bUWMgt9
X-Proofpoint-ORIG-GUID: oGjeJnSO7kbuBih0VWqT5_VJ5bUWMgt9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXw4FsPIfJuZPV
 HmYiydGtmY96LYA1jEiaeq2J+O1Z7eJmTVPZfMd1aV/n3laMkAGXgH8nDu/G3RBFayikUt3GUlw
 YfidmZOydBJ4dr7IRCXEYP1dhsl/iqJsTO/Pq82toRhiHl02EpiKD3UphFP4vg8x1cu+zB1J0Mq
 uhEWUDMElwBbGAj/qYYcdo82ehj5DwhBmdg0IxCfw5ae3LA6g2QryOjGElDs6C10YgnYsiK/Kgv
 6f21NYJ5PTNYWPAA8sZNjIgf/tXGdv/kW5p+iriBO+tykFL1webhK71Xu2/K/KGJruy/EgyJSXu
 WXUF/2gasp+AaovtHDwqUrvcI6TyutKZKE+gv5epSdLcL+h30+4ganCucm+4EDj5HAVJKP3ohgo
 gVnmRQD/1/aiav5PhIQeGCOzYKKmqwU8p0Q/YSWDz9N/B4HWRBy6f565F+mNYXbxGi/H9KWrm6t
 xS5gLmEVktBQBBgLUZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230076

Qualcomm Eliza SoC implements arm,mmu-500. Document its compatible.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index cdbd23b5c08c..27d25bc98cbe 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-eliza-bindings-arm-smmu-07c3143fc6f5

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

