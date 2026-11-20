Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172843;
	b=klhBb8HqncNnXJtKY+kYJ/MAqnrD3pdn1ccO+6h9DxW4EtWmpfOrrJjvhhJIys0/4xk3
	 Lurzsb916FwDX1RbJrS2/2DhMDVs7BTJoPA3hkg12yuu1Fatr49FJpOmugHfEsq6hTx/V
	 5vfakteuJWujDJ1d4l674kQXLiY7YhHKl1uulpKL3bQeef5QWt26tII7k0uYiE43v+gRf
	 3xNPa7cwTiRJ8fLj9zcisPUaRH0Dc+PNZzXTP/VcOyPJmXQBebErfAKp1b3cdSBxuVGzA
	 m4T3Zx0AgwDj7DLbP7CKwupvkgOQD8jXgmfmJW3H3lXvM/9KV0c0pG825QhIANPim+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172843;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
	b=Zc43HKsWFNhAKdpopuohlJnPMGSbRzJdmaU/PguFTlLu9dAoO+WhYnu/jDc6rQimcdaG
	 K8DdXikOaaBC2MsTphmRf9W6ObSMNecS97AJRaTDKT2O4SzOev4blz2JwiQJ5DnHitE2a
	 eQlaqLAHpZ2MEU4YDQAwphQGuRQxDbjJG/F00i0pyD3UsNGKumxV7s3W4Dpb4I/t8V82V
	 /t/ymzWNoM9v6Hz/ZP08aZt9D+1WSkyXBBsLjtrugeX4vrdguSPR6aUMi/DZQ738Qfyby
	 7/SmzLt+2qvglXM6pL0I48rCucUhfMC5ATnRHTh1DwPv9fOYSIDZdfnGzZG6vslaeww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W5ebzzsf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XSc04ZVZ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE360A5BE0
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECE360A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W5ebzzsf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XSc04ZVZ
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkBit3987435
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=; b=W5ebzzsf7VsPPxpM
	wgD3pCatpFUOUy5/p47/gHoVKI48WEwh5flF87JheCRDoMizBtVEJb/3Vc8cBZjc
	R3wHNPtoMCzW5v8tuePAIaEmFUeMLrJKC/8RCYCpNFpwP4asU0Nlb2PSP5zdLL+K
	Gae7xJR/4DtcGJcV5Gn7vy+JOins1QZAhOBMghIZn1Hb65JfFJGd3LPYi35KhlNM
	yE5izBJKJFmLS0qjl/BF7iws2Cpw3NRPaHhvVUjxz/wsMw1LIb6nmQte2FTyvkpC
	9V8F8KS5PfVuC4wUvm8AP/us1nIjBviuqwLOZl+3Q/E31xUjd3s5+36QVVQ68JEq
	nZdNBg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu8141n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-370230d93efso2460789eec.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172841; x=1795777641; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
        b=XSc04ZVZ7U2y89OO3WR7tudGj9+JcUJXhJcPaf+cRt0QVwjh4n3D3CrwVP5H56sEJB
         bUAPbXb0Aw0NxMpLkO6+ATSki0fDvjvQEfIpNzCGAq9G0YBJ+xRC8STfCDRUjU0A/beV
         NCPedURrEAAnz1RSyxcCz+0rYeTfwTK9ggEXAlfxp2tz2LdwCps0whRWIGDK4nqgEdvq
         kb0caPc3geRhTnQAdtUy9XCYoUnQ+x+wc4nIreM7gLZGh/WAqQ4xnn4+B+CrAqtMHJfV
         vn0iLAyixLnUWlu6RtZn+VVBT5W9kcZs3AdAVil7tEL0UCYjjDFyPiHLh/5kO5z6qrwO
         hveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172841; x=1795777641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hL3HLP0Pt+BHfyVSk1KqizSGo5qiQYi0LzCy+jMNuKg=;
        b=jE8YLzCpL/vPdXGhzXdsCBSYszinzt0e8RBn3tzZtEPgaWhoQBDxa9HkTrzd/mfwvO
         Nc2rqyZQd1ZxDM1RQsH/huHdfAmWjWiHTh6x12zrPJAW5mGrfkUNuAJr4ptyXeiMIBRF
         mZF5yGTiU8YQKoSqZYWUx34SKDzdcB8yjoUT8C4PjNgczf9KM9b/1zo9d1SrSEkfCDHx
         YwAQLaFpNo3YSTz1Sb+7UVlMHGMh+IFcLIr/0dsd/ooOKBdpFWvh2/rR2zCyI6i90t5X
         xAun2f6HIKeFusVn66qnCnFuTzXULE5jm+YqiFUib8JN7VM9JFuAWqhZYbHdn1ByB7Lq
         h2GQ==
X-Forwarded-Encrypted: i=1; AL+hErFWs6CgHuvEZfiLOpaiLNcCtN0q89BP8+hcl59QQBRgRbZ/dF5m+aWWVu78dKhlletOg8y1Nw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/zbDJdSeK3y9WpbXE3x+eFyFglAhQwsRtmRE/57xy8GmRG6KmG
	nNlbdK7MPb+x3PRWV6N7lf3REGf7okp3WIvEhk8OOjJQJNp77AdzZQQln/ELtMW8tPnbrpfN1/f
	CJTdcF30Jd6T4d7wq60hx9muYlwkzPcJUhJTJm8AMDCTKnXlko9o7IsMWrA==
X-Gm-Gg: AZFdTZfSigjqsjfy6WZqLkDk3XfgsLVJB/kH8WABbn1qvixVsuZSDmcYn9HfqoXxsBX
	V2BnZ/QppS4HJCHLXgMX8tE4TSqL5RJenkCQlIXkzkP+fu9xX3Rtz0QgIHDxf6S0rnKg0/4gidZ
	vdSs7cL5pMRqbDKzYzpESnB2TrM1pxJkxzJU7VYfVoiysyTUx/5SNLP4IHeLTJwhfn/cQcrWZJL
	Y5z+R/YdIKYcEJBXoDEJVekMgOKNXISeypXBE5njdHGhZq5pQDD3M/X6UbM1sHauDuH/f6yzpvB
	ojXOdIpsHfv6XaCVSkLbMlA60TDGinDKBcv2YfZmDn1Rsvx5BygPq2RtIW8xCGUjKe+TlVUwmR1
	xF45BtuRX9k9r5q1TNqoa75QZDNgFAH2eXKWayIQK1fPfmuEm7EmyohZwqTQ/e21zeM40ldaXj0
	7upInZ
X-Received: by 2002:a05:693c:4142:20b0:381:7f3b:3c13 with SMTP id 5a478bee46e88-3856f4542e7mr2706102eec.23.1795172841325;
        Fri, 20 Nov 2026 03:07:21 -0800 (PST)
X-Received: by 2002:a05:693c:4142:20b0:381:7f3b:3c13 with SMTP id 5a478bee46e88-3856f4542e7mr2706055eec.23.1795172840688;
        Fri, 20 Nov 2026 03:07:20 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:20 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:47 +0530
Subject: [PATCH v4 06/20] arm64: dts: qcom: talos: Add GEM_NOC interconnect
 for adreno SMMU
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
Message-Id: <20261120-smmu_interconnect_addition-v4-6-cab8ee8be0b3@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=992;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=7PKy0XlSNrGfUIky+MIq+A+DSi/A91nh6BKC8dJ00Ww=;
 b=66qF+/nWyNlaszLHI6kXBTrNfnf56mWk2gMlIf8O2jXgkbggFAh7NqKDs7jmCnHNac8yzPs+7
 GLQvX00gi3tAwC66SIoqPkgnkyAmuUiWflZTxDS/kYgtXzWwiKmG/EJ
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX54OdsjNzMldB
 XEhkXsi3s87UKJ4jNP37CrzKKVwTGJqsLnpOEGyVBXzaNsWh+aHs992r6DVNyveqAe57w/zRsv6
 KfjaUeXJoOw4x9zetQwtsl1fbn8be4XofEtXpr9NqJAl0TndHirn1KfmMTkUR18sn3y1ePHkg0t
 N6z0miOlIcoH4/A7StJpzxf10CB0xaUNccqLoZ1sTpw6C9W3KY4UFRtg0Q23IjlbmZZOtfinM9J
 9l0gvJdV4gFaDfPLL+34AegE3doO//H5tI8gYdl1iCqLNlrwlx+LXTpLUJO7+d8yN0LVlIFBLQ3
 60ihGUB2jnhoY3wtty10TWDmADh2EAc4MBaDSsRr39QfpfMdSezNt7F9eH76JnCtgMSJKkJ1pWP
 saARBzHgR1CboUG5b64JTRw3sptKfLIjHLUL+y9N4ZmxRNw8TDjN4yeYQbwFDjQkMz0YtBOgH4O
 /iSwF9zQTFEoNLmXNdQ==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b0029ea cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rfUXoPsZI_F71NZxNB8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: K6CuVyKiD9pTLQmKOKudoJGWI8wtcWQM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX5A6PudxFlAvR
 aZH5E+5Sas5ZXPa9cTg19x4Xusc2gYQmCR75Z/X2HWvECldb1KZQ06hWULbGRB9rtL8X6Y2fQ31
 IftW1fvlKB5/BO5zDC0vss1oIc++vxs=
X-Proofpoint-GUID: K6CuVyKiD9pTLQmKOKudoJGWI8wtcWQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Talos platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 1d74e459f892..f022a44ae5c8 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -2102,6 +2102,8 @@ adreno_smmu: iommu@50a0000 {
 				      "iface";
 			power-domains = <&gpucc CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		stm@6002000 {

-- 
2.34.1

