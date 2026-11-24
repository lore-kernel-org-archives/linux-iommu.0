Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517652;
	b=eKmhLEk5AWPo4575118P6AtO2AA6k4Xg1keokxkimsCAu8S9O+N2+1Pf24v1JrIwHqb7
	 sVBuSquSZ2Xo4q78hPfUSjszTK5Kvfa8iPAGX7bGiTICg9y8G5x+XVR0tkDycbhzOQnLx
	 LsKxD6x6S64jfd4JogkmH/vkguWltDHnj7b76klrs+YCPW2P63PntgQ1QaDcO++hAQI9p
	 5B1zwEbuylzxnnSXBYs4ib103vl/wyIiMq5LiaLLYDnUeZyu4S5fDUQL/J07oTyO32KDg
	 smsxgPmjG0cYTMejJaLaN3+ZG9tSjosMniIrYWOANjf0V8UY4Sj0sKkMzMNxZJV2FZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xtnMeRk0k0X/YY378KWkQdBLEz1neR4yAcGqKsNa8lo=;
	b=ktgbBnLS5qQAXXiwz2YcWD39gtIq3Li/klYZPxqF11X1dIxmRW2v66nbOM5BKwzEj2+Z
	 pjDGO9WaS7KwDHE7XMrzr4XgTjmzAqD3nv0nAP8oAYaO6xts8rFLJs+o7oG8BGuDwlfQv
	 ixjY19vyGooT2KG4j+AKoClEsU4td1cGTI8yL5jd1QmVEmmq+3GW1sUCCRUoik62a5Ude
	 QO4SDTMZm2gRFZ/ENYtjNxQPKG3MmGr+cV72zHTJg+HcjMgWDrUaQtzbtiBQWhwt2FsPh
	 kkmFcnhFStdUNfZ1cj9YXVMsQM2u40+XWtUzZEZW+jQLOC3iR11cFWWR2lmHbj37QOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U54QDspb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cdWy6e/o";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B22606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26B22606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U54QDspb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cdWy6e/o
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8USRv3701109
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xtnMeRk0k0X/YY378KWkQdBLEz1neR4yAcG
	qKsNa8lo=; b=U54QDspbURrXSFvwLCDnst4SWJrgGzcewuAFI+pXYnHplW/6MFC
	a7u2D6vIyX1jn6NTv02kFtu5ljRnqAXMfnx3A+E/SnK+z6VsYLkFXsbr/wxUFAim
	WBy5B43P47xCERB6OkVo7WGc85ImIibAjESElACLlJ6iUwT4ARZDVdBPDRDsFQwb
	gZTrIofwsI2m8jEuGNr4UGIR3htH/sHmIYk85YiwCvuL1w9CXX3F1FadoMqJMxUh
	iPLdlu9fmu/UZaIQpndXY1mm/+9ypiTFGJ+vkDHvrlDbQ/H0gr40U9e1FLsuy/np
	ZU2NVlmp/wycRwq4DmFOwMSJO6geEo3i1GA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky2673-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:54:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso5523911c88.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 02:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795517651; x=1796122451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtnMeRk0k0X/YY378KWkQdBLEz1neR4yAcGqKsNa8lo=;
        b=cdWy6e/oTkffRI5LnCH/1PNsSLOY62nx+Eo/0ctOoeRh65ZOJ7kO484IZwv19Be4Xw
         687orC83eQru0xiyQRk6UPWMmXukZ1NFgeVHNCwvQ1RQUJXamz+oAP5M9M1D2TSPEImp
         hoa7GUx/qtMKxRD9dE+xTgPgI9TleC+6vt9axvftjrOkfUe5kqs/VHi8HOWIk6VXLLOJ
         nzIUStF9q40wb7y6WI6snoQ+FlZWs9xL/4nmZQrv809pgoJTka4dPDBjg/CWfFkttPY8
         FNwiz3OKFI8GmFMS47cIFxkx6oeBIG7OQIJ9zcpWHHDhh1BaF6zsinKDQjZ/UTyCsZOa
         WcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517651; x=1796122451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtnMeRk0k0X/YY378KWkQdBLEz1neR4yAcGqKsNa8lo=;
        b=UyWl7OIFEeCi5x+pqyt5Of2pUC4JySjZEFTQhY96sv0lKViCC89ZtFXgQg6ep32Dg0
         4CToPN06WGuIlIDOpP8K6MHJghqNHiaB6DZ+yuTinp3y2AsUtBwOW7WvTMrfp7nQpq88
         dPBDPww84vu61GZnNL4oYYFPl2X/NoufoVi07156FVsyYFvplL+E+aQQRrLmVLe3f6Bx
         xZykgZbQqlBKpUc/afBXqiOWJKdzK1KYwtpK+xnluf6hNl9uextYIRcB9rwczCNdI9Yy
         9SfHRVOq8yK/iFDBlZTJe+77pfDzW48BqEm0UfYGcnjz0+7BQwEGzCkY2E6/TwEYIH8r
         qrzg==
X-Forwarded-Encrypted: i=1; AL+hErEQpMvxllqPgjDnK72gvzeHuf8lOWJMWFRfDhnYRPQ2H4IQ7r46tk7PseWsuWPie4sNRcYEvA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9tjF4kRep3DBXaPi0G+CkEdyhx0ABnAvBmcLDfeEbkr2ngjj1
	H5v5jR4slkSJUp4rQj1+789pRpbm/JCIExk4OXaFxhWIAPshyvqy3nn2CCLfX4thvCc01TG/xw4
	NxL4AJlsSIbLxnBuVIAHamw4Df13kGB50o3N9c2frk3oOCR2QA96wfGP0Xg==
X-Gm-Gg: AZFdTZdrqTS///bbIPIjN5My2+eWJnxz0fZ7zn2WdKHgSx9nBMLZ7NCGfHj8WLLkdgL
	54K/83OcaEobmq2tftVx/ojv5yx3wenqjMKfhlOQjja5VsZlfV1PvulT0A/LW6XowymPhsfjukp
	mHwqVuoThzU2FTiIJZmbuGrEMx98Lc48UiW1fFvZ+NthutnE6NA7UHvxyB9nwZXDYxWRN/nImtK
	rons22mjrjVg5/5MHsaszh5X6Vo4EKDbVGLcY2HgGIJfUgKTaEHr0jL0PbddR8X/MwC/9uwNCe3
	P78qkfQMEiFmdtyKw+84+K3+Z2ngGXyOHgeXafOHG5ZwxBjlRsF+Jv3Ebg6e7723nBfEWsnm84g
	NWyY2LzJNfnUVOTcNz9ZdOvHcU52q/6Ow+KbauTTX84BlTsrjA5myLJZJ2aFW2Uo7ZmVtsL6tH+
	2OGktPK3Xq58KQXKi4eshmAIJjuXrKabj+lwY/lUmN3ylpyiP80JsWi6k=
X-Received: by 2002:a05:701b:2313:b0:151:5d01:9316 with SMTP id a92af1059eb24-1b5568b0f32mr15389021c88.23.1795517650488;
        Tue, 24 Nov 2026 02:54:10 -0800 (PST)
X-Received: by 2002:a05:701b:2313:b0:151:5d01:9316 with SMTP id a92af1059eb24-1b5568b0f32mr15389004c88.23.1795517650083;
        Tue, 24 Nov 2026 02:54:10 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm39083831c88.13.2026.11.24.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:54:09 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: iommu: Add Seca SMMU compatible
Date: Tue, 24 Nov 2026 16:24:04 +0530
Message-ID: <27f6e560a71f770078ef26137207905870c6ce58.1795517644.git.yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b056cd3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lHObh2IfMKzVuqTG74EA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: AWw-YtfO4GnldsMeaD_PvRlUM1vuuG8v
X-Proofpoint-ORIG-GUID: AWw-YtfO4GnldsMeaD_PvRlUM1vuuG8v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX+km2RFl6jy1e
 xyePSrBP5oUkiq3azUxadQlidZd3cvltL+LfydLgosgpK9yLJO2Pk8dQ61ReeTWWadVucat3x0e
 rgUPcFvMI5p8e0g4FaXRo5Zr/hlzOnQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX3CzLiDMqp/Vy
 Xd15CGCH49OR5O6t/jeJYmCIail8QVkrOSB9V47DWgPO7SQWdsvuotYSrhTd9B+/IIJa7V9y1j1
 AD2mRLoO/Ni2pS1L/225H5dLC6CSZCT8Th1UlToKxTY50UXR8z0wMlEqDM5EfLymoRKuSt4aQFx
 0hvlGUNxuUXkUXrcFuFSvKTMIG6Ks25pQiasa5viWmy3BTzq9NPtJK8vgXPyELRw7TwfK8Nvw2i
 2oTAfW7n/oOtNUeNfp6nwZiH/chCe4F6ZogEehcSqhTYbPMT2xx1GCzIdfb4sZ4I7C+WVW6a0j+
 +RiK7DaugDrYrE5ALJUe9/89jZRtBHGuJTGvnItlcQMdl0drxs9jcNxWuWGK131FurwGJGejOjO
 0Kge6fGyo3EokBDmwC5Cr2K/RP6WSd/sk42x9Ho6PODMoltpVhbWrYgazq35kMjAQh+n9Uwlk3O
 WcNLN/7BU2nroECZjDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240042

Add qcom,seca-smmu-500 compatible string for the SMMU instances
in Qualcomm Seca SoC.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
The Seca SoC device tree using this compatible will be posted as a
separate series.

This series was prepared with help from an AI coding assistant
(Claude). It assisted with review on the device tree, bindings and
driver (formatting and alignment fixes), rewording commit messages,
and running the validation steps (checkpatch, dt_binding_check,
dtbs_check and W=1 builds). All changes were reviewed and tested on the
Seca Ride board.
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..6700d3151783 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -59,6 +59,7 @@ properties:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
               - qcom,sdx75-smmu-500
+              - qcom,seca-smmu-500
               - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

