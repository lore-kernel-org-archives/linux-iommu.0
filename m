Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172869;
	b=L51f8dPtzpf0TFlvJSy3aRzNnVZL6LEvMIEAwRqvvjAkKv3ROl7HsL0fAT/c89sKQztD
	 /Q+8Hp5LmE3WOVhWrKd0SHeQMqtKRQg38CGwUj9O1Y5JAVM3C7EwY3r2VgD3c+tutVzYO
	 qlAl6JR1nkXK1KHN0ZBv/PJaQlr/ICNXCNmNQ7++mbMFq/n0aIYqL5/zSGBxdccgDXI60
	 AlbUj2JQH2fCpryt5R9Wld2IkIxbRzhDMd76yceFzKyv8jgSQ1rw4LX5ntLJNadKdwzj4
	 GOpEx+rtkjF8L+Mc7vv9KygWX6WYMgRuF1vyWDq/jOIELdak63ZQ+YZGLn3jLjzw0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172869;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nVuLCdGzCnBZ9fXthosPaTRy87UpgIN+crA9CifM16A=;
	b=xh6JtRTf74++m7TwVfxOqEuUElQmq1jcDVVbGsqEjwf3p7ty8zJ8vZKyQfS+zr4ph5XZ
	 rL4prD1cv+3M/FV0PEXgBAdcMpGuz7K97A0k1z7BfTiswO21oKNrEE7fkOzURlx1GyQjP
	 HP9ozoTPi7kVqdBzcIs3E2I1A5qQMBzr6sMnaBynELhqsOmiLTVDrTPa5qVDLDxLDHL+/
	 MoXnngO2M+VNergZZzKXqFtQSQY3d8Hq0U9kMgQt+4UE8iN/wDpkZ2D29dD9SDjsrDQ4N
	 75q1sD2y4xOvA2L5D5Fdt0WdRuaOEqhB3pwsZbUdF5+ra7DnEkxW2g3Y/X5DNkh/ydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1CaV0Px;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hrpASomD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E23606D84C
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E23606D84C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1CaV0Px;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hrpASomD
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAk24F2433184
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nVuLCdGzCnBZ9fXthosPaTRy87UpgIN+crA9CifM16A=; b=m1CaV0PxVcpSnDiH
	28HPG+7yoOHUsD6TQ/EMM+wsgLcFbA6mkd7Xv7572Jaq4kNDPtW329NS7BakGtCO
	nrxFpq7LsTV/3rrlRXweqMg7ZDsLj/EkxXKMDVS9T8Qe1xEWpX5fitey+N6hPETm
	vnlpcFqRFBcJ1iXbRmlSwsRoOjGiicm6NyCcQ4HWkoOtbdZfNV6C89IKE1r1y/eO
	i5ccwBVnU+IHv2iFd7OgPgDvlFfimE1TYVwMYilSA5giPHg0kCNiBmB5BOTHh3Tt
	uGjy8uaRyQ+4slp+ZzTZwn7ZtP5ybm/WAkO/OpGj0XMCmYiu1SZ1p9cHEkmzURPT
	PntkIQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj9f23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso1353964eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172868; x=1795777668; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVuLCdGzCnBZ9fXthosPaTRy87UpgIN+crA9CifM16A=;
        b=hrpASomDbZfxHXtMek4g9JtEHvoLBC9I/1S7yHrHAp9+Hl+/PJdK5sNkbZYhPUKabC
         MCyHsbwJhyqk5CPETG00aEAd2bDEVmnqI5T4TCVEu2RcQjKHvINrJjUxGYanT6A7eAIP
         RHfZs+hejpY6tviKguudRkCRhHrYvASfr0wHZbLPA0G00WSLmF58CQxxngSIOhGZh5CT
         NrVNtw168FFi4y+qbf7teLPoPS4ShwCtDxo7AXFjTfAYFPUGE+Q0JIelDWfdLnseSbas
         2gauBXESqDhgTNkiiz4OYl4m/8E1FwFQAAqnVq1AjvgChels44LyMVZZuEbHVstjqYgv
         +2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172868; x=1795777668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVuLCdGzCnBZ9fXthosPaTRy87UpgIN+crA9CifM16A=;
        b=gFCtM+8OxpeZsfl5C3qjJM9HmLR0o8FkFJbwhCz8oGgJAnHujJd7Ljd7bbHuwfAf6s
         sNPSpzzFNPLzA1eEDyRyaPtU40OAuEwo+IbiZXFiDNiGY+o6xagDZtaP2AJ8hXHo5vWX
         d2mcM+jo/H0womrb494uZKDfL5ouK+5z7ZXxKMIOZVOwhVdB5OkY7Ahax7UJKenJX49K
         FG9gRZIlNlmo1+/qZ5YMRj24JVMCjJpSsugw3uUD2ezS0GNlnEWMoPdU1QFZSIdrIXDy
         ed75w4G4RM3beMI4tLkw6Bz3XfMVHx8Al2WY4MbxTbIeZbt7cIuKp4P67m+63I88kq9Z
         T53w==
X-Forwarded-Encrypted: i=1; AL+hErG2ToAGNhuhigDDUI364Ob/ukmdpoZB6X44RVrVyqocZba2QPtSq9gQD1ZXeW95OLGy3ravtw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SOj4qn8CJrGgGZXLEnJCssLOX+7r9ThfYVH8xGPlRR3NglCu9
	1r1Pqq05k7pQ0Z6UsM9Q1rWiPmFgJgaC5R2sG8PeIXKqmLb7FrCTZSwuzC1MsObk2T8LlFOuBDD
	loFHvK5AB0i9+wxV4s2/Vn+6m8dEf2dEw5bw3ElE6DM7EnDES3XOBBGTPAQ==
X-Gm-Gg: AZFdTZeAaO27fCKJ4hjTVJ67qNON+y2UHtQJknE+NdSb2Y2uakKUGvdkcYWki9DNPUn
	ZnUt0kWesikcPPDxfeHroYkMiyj5c3vxUWdAKbRHbM3FcmW4CstARWc0xQhP3u+B7D4QpITykiz
	7zt5adOKELjF3h+chDA0lwrJTPEyt+7yasjyIFxeB2jR8x290GAKZYsA0AamJJpPtYM0SrlSIUW
	a+uI1/IjYvRPGZ9xlDCinf48SzH0enm82VB1GxpDLvTWkOZilhXFPncmY6gbQQmHuW/R0555sUr
	qyGbqoxiRkj22UcpetG/fI/BxpmHPkPlcw36KUnGytyGNiUGT0whJuSBX/EYppRlhsGA22axL8y
	Vx5w9knZHH1ll7ZsswhMxBThOmg/p94pj9tXJg+nkGASTRCHWVlRh5nsdlCdb4ZCL6B1yxPu+5i
	qdyVTX
X-Received: by 2002:a05:693c:884a:b0:386:319b:fb11 with SMTP id 5a478bee46e88-386319bfd2dmr534045eec.1.1795172867366;
        Fri, 20 Nov 2026 03:07:47 -0800 (PST)
X-Received: by 2002:a05:693c:884a:b0:386:319b:fb11 with SMTP id 5a478bee46e88-386319bfd2dmr534006eec.1.1795172866650;
        Fri, 20 Nov 2026 03:07:46 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:46 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:52 +0530
Subject: [PATCH v4 11/20] arm64: dts: qcom: sc8280xp: Add GEM_NOC
 interconnect for adreno SMMU
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
Message-Id: <20261120-smmu_interconnect_addition-v4-11-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1283;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=53qBBgRq2wi2XcZ5N+kmy8C1bgB9H+kOxJMHwtLtMZY=;
 b=TYQkalhmPfRM8mAGJ9GWhGPKxKVfz7ouAdcsaPaImMCvOGkdYQ7Rs52zM3FA3LYB//N4CyiWF
 uha/csTA3G4D314GdglDhRR7b1/8Q0yEdvi1WsHRpeEW5EWV4GKPUPC
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b002a04 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=UZQlob4mJqq41ALSq9YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX5EyM8MmSis8v
 6lzQn5MRDMCI51OvVIJ4s4ju2YvRq4eD9Y6Ib+aA8e8L0OOYVfy1J4TSAfEaleDXDzjce8CvrtJ
 rETVqQVECJKwhFlZjaU/hKKEgp53JPM=
X-Proofpoint-ORIG-GUID: T7c1FfL2cbjO3T4wwXJnWkbu-nNdTH_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX4F6CvvcI32tc
 Bm6+GpLVYmLTyV3OZfKR2JPT2TOz3oQcDbXieYmlx+ebsTCxiK107wD2VvUOj7CrGWkWNSgwI3g
 sGQNY2oZ2zNmoUKDwREhwLD+3PAayr/scPn7tGX0tb68l4FNnK2EB7x32fJzNcogpotYCMHULO+
 4dfQMCUT3+9omUMVSwSkXI2oJbHjZzDM9XuDtwSv40hjF1gy1C/+pGcOU8vaHuqZBVwACBpeqiU
 ku8BLG7bvPZH+tva0V8b2M6wzyyGI1r+u19UUY71/lpzIXwezqwEfB64aOF/1KbvBIt8xueNPEa
 IMLFxvZk41Xq/rshzTlaboxWYGiH82BUrw0adyBMWdONqkuaefbgHm313r5mAs6gzJ1e/5TXKhu
 BSr6TdfflZl1p+3HAW7org8tGeVRoCXXd9aWtssgE2ORQvj0WSOmD3Xd9XMIfIitOh2FxJp7HMR
 lqucAIuXVquMhR5EHsA==
X-Proofpoint-GUID: T7c1FfL2cbjO3T4wwXJnWkbu-nNdTH_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200044

On SC8280xp the Adreno SMMU GPU TCU is a separate hardware block with a
dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
interconnect bandwidth vote, the GEM_NOC path to DDR can be left
unvoted during sleep/wakeup transitions, causing intermittent SMMU
register access failures.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 703b4f4e2059..6eae42384a18 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3405,7 +3405,6 @@ gpu: gpu@3d00000 {
 
 			qcom,gmu = <&gmu>;
 			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "gfx-mem";
 			#cooling-cells = <2>;
 
 			status = "disabled";
@@ -3564,6 +3563,8 @@ gpu_smmu: iommu@3da0000 {
 
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		sdc2: mmc@8804000 {

-- 
2.34.1

