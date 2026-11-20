Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172817;
	b=3h8KjPbhVPK9w2yGduBo2n5NHLEmM4yG6xjAkDjGdHwmNIFd7Fu5qsytslG1QjzW6M+5
	 W4lyzm3LK5f/bNCakh1i9mw/X+puqyj6CKaRvHlEF/PAMEnrnXPeOasKLh48s2PDld3o2
	 w/rYYdTyeWZlyKXG06vx76B5UUcpKBF1vm5HsA1XfKITGa7YOAFSThF3ZgsAals/BloaV
	 TXF5P89zki0cASq0Iv2wIuYnwb9Wina5Tg6lToLCaNJ9qQOXeHBIUCKv693+bFLh779Oq
	 jaDqY8HL5crwReplFev1gGoNpmoAEsGBWx13oojN/dx8XDDrFiUIbzeXVa5pB8RNTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
	b=alIIP6LCeFS/R6Ant0OACVQwic22Yl4l5a9EwKzVV87w//3KhUKNDhVgwS4GY0xFQ7Iq
	 Lp72Lj5/WQI0v6+fCzvlFrCczgcQNKD5j0XwN0HSA8FmB7V0ye7wuAWNhLxbeaZ3v+d/T
	 WgeoRw/5emLx4HkFd4sd5r+EP+oiWVbBjpiGbsV1zenEWsgXmOqzRCO04gYpUJ37lT2YM
	 pZudM/oNfkHc1coy/Hm5ItnP4rbfvyL97z3334i83NBJUPlUEuuizOTG4jkzdQyJoB7T6
	 PA3/8JzQG8J06/XMrhUF6JfYZsyy8Wg2JlMOKyGNXFqi6Gk/nL/Sz3lpWqNQpjfwn4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="OLE/ah2/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2l1fQFJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF260A2620
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAF260A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OLE/ah2/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2l1fQFJ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjv1u2155197
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=; b=OLE/ah2/EA/YApVL
	YDox7iNZKWVUiawjm/9KI34WLgg5QEIn0CJ5Xtj/tGcSNsBpjo8yuF5sLbGg4Ajr
	vhabz062Akceh+Xwm0SzRkpldVZOEMWeXCpGVBq7IK/fzgNzezHFiuA+w3qH18Tm
	dp3QWFIgoP7yJikeVctlZQO2suD3mHboa0Pd2LdktHuy2prEU1gfUVQBMxMCL2x0
	BmuWYWLFW+mgFvMqWEKREvnhOu6VK+V+XWJiI5/dkEnPlZ609NfHX/zX3JJCnS+c
	Z1CZU3tjMwmLdCpAEkXRy+5bhMWsAPVO9gOxL0RHxyBTQYaa5Cn8/rMUvEg+0WkY
	djwa8w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2f4yhk18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:06:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3724667bc16so591509eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172815; x=1795777615; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
        b=U2l1fQFJ5DLDceL8CkMzBGIbMcQxGuvbidoHQ+4tz4v1GbeWpuXt2GOxbmkGcjQsPw
         46/EcP4GQABsyFhSmUpc+L7YcTj+94j5rrxowTB67gNeGR1n/gZbIkfucR1Q4xCTDSkv
         tXlpD+2HfqIT+KHYmOyrZaEjNXG0XXqcUHnWE0nQ1kf50yX7ToaG2bxXNBNzoAZ9uI+c
         1mSJpBtxbC8uogL9cyoGhc+cFSSpR3z9m5bvfW4uc01hox3Q3hTwARyyPhvWezSgyQCZ
         AMds3pWrtzukmDwNCBgO6fvb9gDVpmpR8sCxvtMOoh+3BgCI6JGDRYai2japJ5jLa6+/
         /qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172815; x=1795777615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
        b=hRdqmuIim0A5vgTF5yJXd4OXzd6E4xFKxh7f6QRN10e7+7Tt5KmIbqHS4AbmRnnUJK
         IDxR3umdms7nZLDd01qGvvHuF8jqwQUx+R9sN0S7iB/g/bDFs3RhulznytgFMjLg5Ur2
         H+0sXh0OrZ49x1+e0gCWUp+n3KA8GbVwt4JwusRZNxzYdHd4H1aQBo1v0oqV71CglvFI
         WD+AEEjqZaJZawZ6zv06HIBQlWz6ZjqbJ2wJ9Vx1bUzjHGnZChfgyvlX6HG9tjdeMDxY
         7D9nrIOziPxX8Ao+jEZpwu15IAwaB/m0GH1qbm6UUj1J+YaS0WmgPMVnihyoe4W011+K
         SLtg==
X-Forwarded-Encrypted: i=1; AL+hErH4LLkqyiPIJu+mUEbrwpSsPJV1KoJqED6DngZuL9hD8utmfsTiWCjSsZcIFgH99fcdVq0R7g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8J/xagAwJB/aCKkb12SRmp7Khst2oISec0WvBN3dfzy3m/JZTt
	+XLZt7B2zRhqtQZ3uhbOISsaWusm3vgrKS+JZUzegnyR04xU449O7juAYLmPl/Ckx2JILAdn9Mi
	PogrtZrtyLLpdeH1zWHpMte0A8UOhqweHKRYrynggyW1NGQn+zzkWvGm/pQ==
X-Gm-Gg: AZFdTZc3oi1qxk9G2FsGJ1oUNml0gzkFvKjAicAqJj/IgBBvleHOqzH6PxmMg7UoMbB
	uX4h2CJxYYR6rWRDHUF07lxywDtNyioqdLGEg7u+gcYacBo66PrdrO6ai7OB68c66OJw5YzQ1wO
	asFLHnIvl8UcDHIwJMHACVqj9m207g8rh7Xc8Mk7mivwouX579MrKF2dqmccMLXrTGYAy6r6Igm
	8QIbhyob/Qnrflvdt7yvLt/hcScUqqv8Iv0b90ReUTQLuqr/hR25pRpTbb8Ugd/NEcCK6Xfi6b1
	yN6BHh9XZxT3Wcd2o1ikp+ZfIL8Wl5Sv1AAp8yaXJ0KFjXgt8tE8XspAS2FS8JWrlkGyXRCRPYn
	dqKRg0V3g6V8zTYWEtOcL90xUG8Gz/Cddi67cfJjKU9i3dOYKGH7n449TUTKd6BZdYRFz2Qs0FQ
	5tJ+xQ
X-Received: by 2002:a05:693c:41cb:20b0:384:4fb:510 with SMTP id 5a478bee46e88-384b4e7510dmr3920922eec.27.1795172814806;
        Fri, 20 Nov 2026 03:06:54 -0800 (PST)
X-Received: by 2002:a05:693c:41cb:20b0:384:4fb:510 with SMTP id 5a478bee46e88-384b4e7510dmr3920883eec.27.1795172814150;
        Fri, 20 Nov 2026 03:06:54 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:06:53 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:42 +0530
Subject: [PATCH v4 01/20] dt-bindings: iommu: arm,smmu: Document
 interconnects property
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
Message-Id: <20261120-smmu_interconnect_addition-v4-1-cab8ee8be0b3@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=2417;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=L9ZDNV193MgcYYJuTHrN/Rk+LSdrA3XbSL8eIPKsLAM=;
 b=wdg5TvZTBzYicERdTGjHlneO8uNo7gn2OPeJEAerjHG3UyVz5Pfkn/6J0N4Bhc0D+p0HdagtQ
 2sciI9FlJ7GDWUDJ5zSVep6gADyCUDd2XYfiX8Wc3WXC3zK6xtK0mkb
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Zs54uN7G c=1 sm=1 tr=0 ts=6b0029d0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LIGS1bie0qojq0S7pNEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXzXUroX+GzqiI
 c+hLQRok7WZ7XbMQR/tZ3yz9kStpGsBrzNe6nhUzVuj5MwfMk+q3MZjratIsub6+RfMKN3aqZeV
 A9ARuT01alksyDezYw3toVwXzC+ZF4g8mbP2Mya83XXK46sx8Pu8/CjTphr7naQWLfCkRBkpUAm
 EOQsy3fjygKtGG//WUnXXvyTw0wNye3K50J0umMHXELmR6+CP4eYlkmeUoozAAbQmlORZFRo60F
 5gLRZ9LTtyP37pIGMHKlqEf7rRqpRAqZK1DtKxFMIGK1fuTSKlh8DHN2BoqJP9PCs2oISzp8Bvu
 dLFg9omLxVfFv2DouvuDiYfjZwIlrz8rP5Wt6rR5yIKqXEFA+/GaDds3Fdm5Vh+6oqf470R/MSd
 vZUeJ80naHI7wTELCR+aR+Rnjgyl/Fcp4vHrEdV05TTNcqfbW/yc8diHi1Z0uvbM8ftSAMBJ0Lj
 8uuVLOvsEFmj0Hk18Lg==
X-Proofpoint-GUID: RxfXhasW81yjUUSDtB8_ZPQi8s9Z3YXr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXzc5jiCCfFYDa
 CiGc/dJbVTDeaXSDNA77Y7KEOh3DbM3EksQo5J5gidfpxHw2NTgqDUFGUom0Q2B5Id//DnkFdIp
 CwSrK+kOFmmrg3L/wOx1fNl33LwoYvE=
X-Proofpoint-ORIG-GUID: RxfXhasW81yjUUSDtB8_ZPQi8s9Z3YXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Qualcomm platforms using the ARM MMU-500 (qcom,smmu-500) as the
adreno SMMU, starting from SM8150 (Snapdragon 855), an active
bandwidth vote is required on the interconnect path before the SMMU
register space is accessible.

On these platforms the GPU TCU is a separate hardware block with its
own AXI master port (alm_gpu_tcu) on GEM_NOC, independent of the GPU
rendering data ports. This means the TCU can be active during wakeup
while the GPU data path is idle, leaving GEM_NOC without any other
voter and causing intermittent SMMU register access failures.

On earlier platforms using QSMMU (SMMU-v2) the TCU is integrated
inside the SMMU block and shares the GPU data AXI port, so no
independent vote is required.

Add the optional 'interconnects' property and allow it for all
qcom,smmu-500 + qcom,adreno-smmu combinations.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..ec0fc5f7d4fd 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -252,6 +252,13 @@ properties:
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
@@ -656,6 +663,24 @@ allOf:
         clock-names: false
         clocks: false
 
+  - if:
+      allOf:
+        - properties:
+            compatible:
+              contains:
+                const: qcom,smmu-500
+        - properties:
+            compatible:
+              contains:
+                const: qcom,adreno-smmu
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

