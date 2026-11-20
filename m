Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182153;
	b=TYuPwR4ti8TXoZWnOs4yFKUqnuFv1ZnvK5FIWMJJ/457Ruiy9QCHDG38YSydo8rNbe4s
	 8pfUyz83uXd1qtl1sMOu2fIpwG4mrROlGvCUe8p6ZHHME877O1coAS4M6f5Nk8OEZ9Tbj
	 h/Vxgzteb+u7BMlu65o32TpZ7O4zM49xUjX5EHcQmP6h80BieXhM7jPiZ9MZnDmjosn5W
	 jkixyCDVjCDljQt1j9hbEbj8hl652YTSGYkZ+/5NDx5c1D+mEcRnzAwrbdjZRHpSrV9YU
	 g6FHcuyNcYggxGB74qXMCJ1OOp2Yau/3kZp8TmTOEpngoJbPbxQaw/+O84hdnaCMcqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182153;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
	b=CTboUfMYVdlzlfuWy2CdFy5wE7r80Z0gQhJ3Z+ucSN+DbCGhZywRI+3UIAL3TpPH2pGd
	 6YaHn8+FlKZqeP3vzgJkL8ITeVQfnauzBHUKj0CmDnwBvNkD6khMCMezmjq7RqVRK3LuX
	 XFPOtowpSnMJuiqqEZ2lo7ZwySHyqaEkTFRh8B25O4I6S+kzyaccXzE0hTABLxmZzwGM9
	 Fx9X+oq5/pnIMqZBm259dPYwUbQsMdwL5XKr4aoBlglTpjOS0RYUIQuak3T3yi5dMvLJo
	 WJsQ60az7nMh6eSt8JJxHP7UwquIUwAGhXcl8+TtKSFnWbWElfimhJQ8x0LJVgrnbFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=migPxDrT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZYI4+crP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979F606A32A
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A979F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=migPxDrT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZYI4+crP
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk77M3987250
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=; b=migPxDrTTyI6/FTy
	q28lmrP8ETqeT+SpI3zFUxhTOKhYcOYH1iNE/nOtgiQaNI+zolAkn7DTpXIgKxUl
	0OHhQhiX7xD1ve6vx5arZc78eFX2Kw5RUktAGYOf4ha0ADCWa8gCz6ucKEiIp2V9
	XsF9r4TEJEAjX9xKFLCdZgxk/IA4M4Tc5LMSE0DnEZDVY4w1L1VBLa4ugkjV3U3r
	+ix1/Srndu3GB5+bcNaSD4H2gXPMeNzNsGBZbyK++ceruNaGCgPK65Jn69UU6M6p
	FyW4MrM5bQ+UNW42r2eBg60FG6V3hE1uRO4oV3frvrZ/HXSUYCVkGjNf8W6Pft8x
	3RV/OQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu81pt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383f2d05c73so2789568eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182151; x=1795786951; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
        b=ZYI4+crPyTy5pvY2yHhueeR7sKFyoWu5YZ8UrBHP9lQWnCXglpZkb5Hgd25gjYNM2R
         A9Wb6VvCRvM9meWNl9UTHQYP969hJZ+Eeg+/fO7OhOkIxe+BWZzO1esSFd/516hxC3iG
         9+yxKzDMhRDe0+UuxI9XYAlHqLXCz7l6ZAxJoPhxDE/JwSY86qrSCv+JegkyoqBbUSUb
         bMNm8YnDPNS7GuXsT6kknndKT0DetKWQwJrz322XU7c5WOLtU9a6+gGphEVjZbQ21N32
         P45VnvOYo9RbxgzbQxGZ85y5c/UJggIFje5RaSUCxfy2FyPn6eapeBWp/Wt7TkWPP/5H
         kr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182151; x=1795786951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz2XdZj1N82zwwGf5rQXwFrF2Tz/A+hhelwd2ljU2qQ=;
        b=zown49u8sCrQkwE6YnFlRuJrOeTf0KKcsnF/yMzzON4kwrVA4fEIecLsPjPwCtqrXg
         QXHuvRi7roOAmE8Dkwv1gABmrXoj1ld42jD4kVRef6dNMIGhXxiZSEcwqhA+LrXW3iEh
         niu14meTtE+DDTrZw9zdzGxvXjQQDNKT7LaG87TWRaleG2DGR/F5JVd1lD9djpF+HRzw
         NHAVM+tdAOEBLPZ5NpaVb1jg0Oi24hya/rw60VfYCjGtQBsKcCZRfSdSm4TBNrrdwAbw
         t0i0F/zSJRd5G0PljtkYdlwU/6pcTNHfyX+UBImZ4x+/Ys3FVRXKUddeF2VUIjwD+iKe
         HkEg==
X-Forwarded-Encrypted: i=1; AL+hErGOoahz0G8VzPT4MUIZvDlSq7PiZSZbk1OdYPL9iBjOuZ87InynmKLFAiKIV5M79UIcPyMwIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ErZJXCKgakZRUfcyzO6aW71pkgQ3eHJgtvF11IGffamYXAzgQ
	3U/pi9tZU2FBnsoVAHV+szVc3WZJ3nD5hPGvICGjUTRrDBcqfUA2m7JeWOQjDKP+TYtytUZI4fa
	5aBdF8h3L9fPQL5xHXCVIKkkRCHJ7JFuTMAx4Gt0M3AHWbL3CHAFYPTT+GQ==
X-Gm-Gg: AZFdTZev+mWnuBzAgOH7un+q7YRlbfgqJh5ty5kH7IsC30whAnZCrBrh6dBNJuWkN1g
	MSr22KCbl+ExZSBLtgYC1ke9I6S1zaQd/CU4LTKGx0vp05NYcE29GR9yPjjk8izTAH0DtGYW7Aa
	uAcR9Y0Dg6iagL8YQ6pL9CVXc2Bm1gK+vkKLwiIq1PXjlbLp68+r7PUwE6NW1hFaHwWMq76LtMY
	wzFqk00LZJkSyY23vHDMC6a15WapN8AruyQphSxQhwEePlfswlVM3ityfRuG8SryEh0t8hlUZYZ
	8KMkJ+sUm5MG1I6FtQLkHFANXA7sXVJVcRHR79T9w0vC4FxYTnsOIpVUGtLzAeb2UfmMFYHzeCA
	7fJfXESpc7slw2PvR/JTtDg7jIgjX21dZ7qz9BxiSso5zZBDEIZPFDHiXVecf64Mmql9dp+1FYl
	pl1b8=
X-Received: by 2002:a05:7300:e9d6:10b0:369:efd5:9cad with SMTP id 5a478bee46e88-3856fd5b5e6mr3290396eec.8.1795182150845;
        Fri, 20 Nov 2026 05:42:30 -0800 (PST)
X-Received: by 2002:a05:7300:e9d6:10b0:369:efd5:9cad with SMTP id 5a478bee46e88-3856fd5b5e6mr3290338eec.8.1795182150128;
        Fri, 20 Nov 2026 05:42:30 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:29 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 19:11:32 +0530
Subject: [PATCH RESEND v4 01/20] dt-bindings: iommu: arm,smmu: Document
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
Message-Id: <20261120-smmu_interconnect_addition-v4-1-be30526391d9@oss.qualcomm.com>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
In-Reply-To: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=2417;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=L9ZDNV193MgcYYJuTHrN/Rk+LSdrA3XbSL8eIPKsLAM=;
 b=uY0Iae8oylJJB78xRp2RW53OaW97KnbRp1z7xWSKIKHPzU5GnoAeMZpdTPtMbwabSwKL6rJ38
 UUwBSOaoeG7C5EEzLSzPvYavoSyymBGzMhXJ24sUJHfdnpandMTpHnA
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX2QDsPuZp5aPS
 Ujh4CvWoAT0vY+gDvviaU7ptdl+0KwVkVBhN3DjVqYWEnDjpbUMwH8lDhks/YEgOJk+y0fZNkfD
 50RSWe8/Mj9Y9JJfpOXwtnwxWxImzaIAy8NHTVwAItPTOthU7zrz3Ix6Psz98jSCpoGsYplauQw
 AMiA4jrbxfOdXoCwi+aGbAOeC5aAWlRTTQLWS5ty18qdF5PVsjYx8W3grQ7FY/sHxKLruWnmJku
 iA9UifmwM+6BuJ6scPnz7mqETLAWlrcRH5eVS7V1u+jX2qye1i87nQZuqsQWdaOg1CXlpM+RMkH
 mv3iFj1J7iqHuDV5IkUzYAXsTkhrvjx4k0nlLS9LNQmS2lmhpKQzRkUtr8Nv9C+xRRqsMF+RqUk
 R/tZN6hN6nAuu3rW9wEJe3/xAQYgm7dqKmUadAeqdEf9nGbG1e7DFwWOeCbG+5lNS4cnupl7CNK
 ot/QbCbFZZtmpsKTRTg==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b004e47 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LIGS1bie0qojq0S7pNEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: YBPAP3lDc0X6yD4Xa6PEZLEN8ssleFJW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX/t10xRlzdWqD
 nSUC0lMFSl+ShThmQO2U6JKh4/bEkB8UGrc1f+KkF0E8CGjTcmVuVB+vImbJEwttt8mMeaPKTW+
 +0sa8iUNOFmGtKndJZWh+gSt9hJFh4g=
X-Proofpoint-GUID: YBPAP3lDc0X6yD4Xa6PEZLEN8ssleFJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

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

