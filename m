Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D72F6911
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671075; cv=none; b=fEijIQsxQOe56PCPjAzh16hzyrfk8ELL11rrGg+ynR8+cbI95UUTj8aMAofAAI+qxObvWhAg3H+z6WNl+yldw8Wp+38rTSUH+hfUNAtsldYKM/BUh63pEHEZUnJFxsIqWrr3IhTvJ3u3NMHf1iuKr5VS9rb90p10mRYmiHh2hsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671075; c=relaxed/simple;
	bh=FouFj+iYJhzcqR59XAa2/WxqzLLfYvt1re4RY7l+JLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0K0wXodL5TIZbBhfaT6NgacM5z678ElCt6FPgL0yvB4MeR5RlWH9/AxG+V/UCCYZXIiKFvKwm4yuYieTJ1k/26z2R7sDJRh7bpQ30tTDz5XaI5ETHBZB3CgjX2kZIlE+1ZA77Nzyi+ixBMl8pnrQTEuVXTEc8t9uBzctBcGLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7gI6+6E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NNGDxRRy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7gI6+6E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NNGDxRRy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SHjEFf416637
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=; b=b7gI6+6E+IyJ3GMr
	JGNhNPvvWEuhGi2oyJJfH1DTEQHSNX6FbL0eowjjuI7VjiPh4XSwP7BLOWIIV8Rl
	A5H5QngRwub9KeE5tQw3SGiAAmKJu7prlKkvfGpNEUOOhu1aXTb8G+1dF39AbnKg
	4oRKopXTA/yYrMhvmtRymFr+cNs73lhBW/viD4ZGf+iYgNkZ1dgWeu+0Z40228t+
	DYBk8Md2Oe5xrscuUVFHeMtgpr/2kGYIYYQc1AArU103RO2M5jNoOdoDohy4Pi1j
	ChZgXuVhK9rH0fi/9OIhe9/AqvCbRqFlok0YejzT4ajEv3X9SkySW7YmraHOTTvp
	+5ggHA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7u9cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:24:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0a27ad86so5673465eec.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782671071; x=1783275871; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
        b=NNGDxRRy6qVIG0zou/3raCoZLqt7Jol7RZIqwW5joHZSweNy01rKSn0FaXa1tlWawz
         mg2+UTE3G8ROJ2RknCHiUfNNnllcJ0z5utCfEnysOSf9GvABfz2aUd+90Z2FaYiVwLzp
         bpcX3x8X4s6mrkbBE0mNzVQ5Zfm5zGI0wHhiy8swzMqqJQXQD4k8CUlAVvRglACAKIKE
         1UI9/7RCAZO6A3UYIuG5HcxlqoSuTHca0NJup23v5JkHyrPkjVuoPQG38Q/XFtTD1n+N
         xFV5RA6H1NIUfu+UH72wxMkQaVIpeMvKYjm65lRtaqC8KeQGpGs89xy6xi5qAVuX6S6h
         Bc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671071; x=1783275871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
        b=AuKDDiVa6u4bRDbRxop+8iLX4TZx/N52D7e55MOcPX+5GAd1Eou1Mpne89l01ASxHE
         qfJq168KeHrhQ8T0ZK1ptnKZWsWmqw3Dop6hiDgfjyD9BcwQ10Fr74MTKBI+QlF09OyQ
         RVenz/g+AaNUucAWuAPhg3pDEdmLyImmWXOCNfyIpyyX8fiEvEUpMZiGDMWeGMktieS+
         9XEniSzRxp0rpvLHQ4avjjXkG+MNhD5D/wxYunwkZF7k3eH0JHxQPTesEEzmkGR3rwBm
         zzt4+LF8PqfY1WueR3dDECFiDKORSMe9RGqduxTCXd8cK7nNFHtBJVek4Xq2wHd3QSnA
         zHrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rre1ptKuipQNUIgqy61C6JAVZuzIIdAyvhFDLuOObnTTSWeEM7fDn8DMKNVnGU4DezWGuDHLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxClpRJq5kPlhWeSbDiYEw41AyWcmvb35BiHKdVxSGjIaaRH+wk
	KxfI405jGbcBQms6B/jlzPey5UUOhpZGjlI3RrbTvatLVQcYHbOJyMRnZBy1QNAHXvCi83MjqGf
	NLSHDAmkmYmPoOMGCZxT6G+jpu7mhCwxHFIJT4uKHjqU9dhg82qXsUPF3aQ==
X-Gm-Gg: AfdE7cly34g7gCpi6QsOiJ1RShvV58/zEN5+9TMIf5LtQcGfU6+UpTQrFxIjYRmH8L3
	exK2ij377kdjfdk7yiHA1LN+rPLpeE3yzx6RRGQBJfmwwfRC0wCaIPu6jj2P4qcVgohXx+5ic38
	u+REnhXet/rdk6sAqaKvvjAfnB5TZ2yNA0gIMFH7c/mdQlAQrvFdG3fCYGt1lNsFmqxoD+E2IXU
	b8KCeyTBhNfqDpAKmsUZ2YyZ2HNDnHJy1fCLqeCL23JkQ8bQVYNmS+XM+JoKSb+Rl3aVjC+5oIM
	aNnN/nIegJvE0KVYzZwMzngBPE43f8r1UevhI0ftHbTgI0z1pDuv6FNm7jwCvWKSa6vmXRT4hu7
	jP1gpTVcDQd7QeeBJo1E2faYzZDMFK5l6o3Q=
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id 5a478bee46e88-30c84a265a1mr13670321eec.0.1782671071204;
        Sun, 28 Jun 2026 11:24:31 -0700 (PDT)
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id 5a478bee46e88-30c84a265a1mr13670305eec.0.1782671070686;
        Sun, 28 Jun 2026 11:24:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:24:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:54 +0530
Subject: [PATCH v3 1/8] dt-bindings: display/msm/gpu: Add support for A704
 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-1-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JBJQ6bZjxqgxmRsc6EMGB+P+JygJ8pgGviEVLPjhEKI=;
 b=22p2wlSkso0sZ4PEQ7LITGuwdJa9RASM+Jq+223nG5cAcH8yMmpZFDMuD6z9JBVhrbUJh2aE9
 UR9CUdoJ8n0B5yFmfy5Fk5N6AuTTQsx6RktlFU2oCAgzHBC3Pba4JXE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX0e9un7NZHA/G
 hOoQ/TJoTt+3fhj8NEzdzeahO4IsVipd8Xce51SGJ5JpI8x8vmcANWGj0yTg7QDPnSIPMq9uyfT
 siCKK+shxO6wGl8jqvE9wpiVUwyQYuSatLd91a5mk2rrLDYhUVs0Lr2oL87CTdm0Ps82F1w/pD9
 ZgulbscuIu3Yr15ZOcEWEIOHOiWmntTvltuqVOaBycN4jt3CyOeLUBKDlwKsasl6Ke1WIaRwHz5
 tzQgp+NuvXM8QGMaQNVdH0Bvk9/KviR6UIfR1T9N2diWVuE9AMkUo+xIRuOQ3IPuBwOo77pQ3XG
 nmxxOly6COCIRCibZdScVdGqLiMmncunVqt2FORAvwBAPdOnAV7/0sQ0MN/l3qS0imqsGGUOtuz
 FK4143QuHMrua0VVVZSY02ZN+60CjLd8LoDWwd8SNiwdRN7ERDfi/RBGi3uG0hH0kZaFzG+dftO
 eVC1V2m3+IlT9KUaDsw==
X-Proofpoint-GUID: v875YfIpPmwDt9u2ibOaMNssqAWNW_qU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX97e5zFtVcD8P
 F60j0ZYTr8Namzz4PUfjS1gyNAUMlwF++Dmtgxp7UiS9WlHR2x7MXBRhWh+/6eBGZOfogW7OrDh
 WPnMOkLRIC/1INM/njXj9gC5VyGgklA=
X-Proofpoint-ORIG-GUID: v875YfIpPmwDt9u2ibOaMNssqAWNW_qU
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a4166df cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.51.0

