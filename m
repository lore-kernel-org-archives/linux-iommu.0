Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172838;
	b=s/Wza7I20Br1w7frDmAyHKBpsWARoZi+FofDqluIvftiK94iyrev8OiU/JoxAyczXABy
	 BjG5jxvGwACATEwcyGgCAQJbGK/34EGLg+efvTb6wP10chhnlmErTvj7ZIB8axZrsKD/4
	 r04Yvf3J1+sAFwCe2LQFwvdy8ASlCxu9DuvMZsheo6azU++daSr17eLkt+VMQaqG7834r
	 8yOOHCNV+h9BgzJitF0bgFmphjsEwuPKmuVN5AKxTa6KqieWSe6WiC4pXfMB9rwJLrk9x
	 DJnUGR0FhUmuGVVYxiGw7FA+BSGaU600EmZ64U1krSCHeRhsJacizCfn0tzGz8VXFtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172838;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
	b=sLlv7pW/kT7aI37CoJDVyxHNDajN82xwyxa2u09wzvinYLVtgCY3rk82VACRC3gh6zwC
	 yMoQ4Wuj/Wnm5qyUC4XAGoP7sBqAV525eybbinpJBh4yUQHDm146WcmY8/0luWN8t2l1g
	 NlLbD/j3RrurnlVrk2SeKasIoKTbiN4aJfFcXTKaKoErwblMbP8SMdAs0ItJ47l140qJg
	 7chhxQqGTFUf1rJwTaybQjTGbxZmdWMMuxi0JYMaiAklcrYNJfSlez3r2/M9HHFyuZS+v
	 AQL9DFGqaVfnrMsxJHvw5XxohN/LnLEePLnSKAmWbPuqV700Lq6gRZw6qjIpnokXlSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="lGydtnL/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hUjb8C6U;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA510606A334
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA510606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lGydtnL/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hUjb8C6U
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjq931681886
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=; b=lGydtnL/WG1DsZsr
	17EAMCvTzQgd9jOSLkYuBrFAuTXmuYZoViVwJwitUwXrFS0t4AO/5kXW8o+gLxm6
	UKbB1UZi2yCbzqPRsBvXnSOYtmQMNYHa8RqlT+/pdJ4q7Bx0Xywx3F8bfKO4zVPa
	MLQzdPCXKUItZg2FDvtKbrvXbd5FrXXp6fQznMHJFo41i+S797L+mMXYrLlatzpk
	BO4FUGusnZI4cVcip1JFi7mcXUt7tu4p8GTcbv1f896NT/3obcCeYElZW2CcHyB5
	oUXURG1tpmu51DWv3K9wZVt35YsMSSZt05tRmY7eXZ+bRMAzmRPPbSokqHR9wcV1
	/B4EHA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1t3ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:07:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383435e46f9so604621eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 03:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172836; x=1795777636; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
        b=hUjb8C6UpP0Mn5cBVHvtRbbwslYvOjApA0is3BCDAt5ydumtaOZ04zXoWO4DLYvt78
         wodJrtJk795cMidie14KgPBF1a4MBHu1xjHUEpc+6G6aTV6wx7EtIbeIUCqDvQ0H6kEN
         M91mLcUjvuyzu0/CBMmfjcMk42/z62jSUGrXtJ1U/rbG+UPDrDXxDSULgGsSECY+8qhx
         AATZID/htNfC0sxIODSQOdl5bbXcvG4nE/UbqZJmG6KgFJZuZrMXbmlmrb6mj8Ma6tuX
         WqdsQ94Wcj2DZsQThdcsrJ6bAeHqCvjlX4aZWRJSj6wILNBYWvwhCSt82u4al8Nomxsa
         g+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172836; x=1795777636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNsUn4dSC9kKr5schE1mZh9un8wSnTsQUYTEKMmA6ZY=;
        b=PsQitcA5RfU2ueUaar4VW9gnpL8M1qJ7ZlvYaHMiW/v/3mK31FVKiEucuaZhu6VMQl
         JAsK/47IKo0GjdMuA0s+ebq7kdlZUtAo/S8OiGekTNqPT8N0oOMhCoXty38urO0NDKPM
         84lKKCoTVcrrpxS1fRfOvWgomyfcsDqzFcEw1BlMc5bS8a8sfdqipdWGvPjrtoz5iXJo
         tWKjLid4eOH50CDQJNQMmsfX76eyGRFzw19ak+hPQ2T305Qz7dR63JNLjlOkjauMZzfE
         9JdX0JKkrwSMtCNaQQFa1XLGlVc3RQMrLKds5qJs2I8yI3hH9fM6NVa4rhXPIORVY4QR
         unfg==
X-Forwarded-Encrypted: i=1; AL+hErHx3ZUpEjSB1+eKNDj4ngGs2PHaaLbMm4zYGnEb/KFOfg+2UPFba6Wv5jdtU0G2FiDW373p0Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/k96DrE4EEh4Gc6v+laNSxlmk7mb/lMawyjqT04pG3oX7p34ms
	dQB5aiB2kjrdseG6Q7wNwQLYhObZRq4WjrAHCwIV+vmw9vh4BntjIOgacBVnXo4XLbk0NzK6bpk
	AsoNZ4v2JfOPgN+udT92SIDSGsE/+AlRC7BxZI9S81sPhpebEdwloD6FnEOaOJZcw0g==
X-Gm-Gg: AZFdTZd3PItzxhWl1qZIMUGbP59UaEPpKJGGPzHWJf3NZ+aBH9SpXltpZwINckewoiv
	BrEyYruk1eA354DKcslViFEG/+bHtzGVUYnWKrdvkA05WfJTGniq4VdTuLaQthF9Yg1S199ygvl
	pLRyQ0N4UhF6Dh+8j1bofUP5dUVXWT+iPTTEcLcCk6k1ODAo//iRooTgBvUyqhMmUGSsybypIkm
	/2km24xsCRQdyarIwQ/PQWRIJdWfdmMvusFMin+uOI6RBL1LWn4BPfBkFeU9EY1r2wEsmoTAEZH
	91OVy+2c5uy7TVcX77oa+ramUcRxz+qxGe9NZwCVoGd4Mq7uNk9fWR1o2Z13QsYVkZG8a+yXQPq
	FcnkzFQaAENObM2bw4/c77r7Hc1l80Nkof0AfddygeL3qqsZMJNeIiEftLOrqUhtA6fFXKO5d8D
	TAvFJ+
X-Received: by 2002:a05:693c:87c2:20b0:36c:dbac:705d with SMTP id 5a478bee46e88-3856f65a86emr2125681eec.15.1795172836154;
        Fri, 20 Nov 2026 03:07:16 -0800 (PST)
X-Received: by 2002:a05:693c:87c2:20b0:36c:dbac:705d with SMTP id 5a478bee46e88-3856f65a86emr2125639eec.15.1795172835468;
        Fri, 20 Nov 2026 03:07:15 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm9252594eec.5.2026.11.20.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:07:15 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:35:46 +0530
Subject: [PATCH v4 05/20] arm64: dts: qcom: monaco: Add GEM_NOC
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
Message-Id: <20261120-smmu_interconnect_addition-v4-5-cab8ee8be0b3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172803; l=1018;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=1lPh+lGGWLKglbX1purFejDWg8n5fwBJBYl3rhWzR6U=;
 b=w7+YMTrpj/odsbvoZBGQJvWKHZSfz1g8C/fkwsgmPpO4XjyzY8ommBMbxvyjAoSlDyRaqpIGL
 0nBHrcLcbdtCZEPljT/X3t2bHMS8fnSMi8mpqaaQfepYWjPVWWOr4P7
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b0029e4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Jjng17ChVe8r-G2aFk8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: PsjPA4UfS2RewGKQoDYczKBiud5L6Rye
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfXw37bFJ1an4dk
 PZA95k2VvUqDuq0GiDH0tIVPFFOeQbkAv7rZaaoLjDbvhKsYL7Ulc4pp2UBE1+6AHiU/7ZEcLgy
 BUaW0ziyPpH26mkfItDD2IZs+cWlDdk/drxfzgShGisXwq2QU66fEvQ6yOBD6TWyV8Cpzgpqx8U
 ACQzkorROwyYEJkbZewCh/slmiG9rqpOkadGI4DLA4ovfVWA3CFrkdIAG6eCk6fhdJgE4TBK/qA
 /ZU2yoZ0Uh9OW4DfSkYdq4VSth9MiEB25RD3CwWybxNWX66MVcD+sGu/OkbyfF8LB0hGHCkVnUi
 1GqANccmOa7HUXHU8wU9RO5tNGwnd0v/dbpB48jF8lpzsd1dKcTJX6/g5AAKb66tYBK5k4ZwK70
 /zgaz5T5gvRCiwmgFMQ8fOUGJfZ6LF/AsEz5QPTNbbsIbONzi/uWyMTU9jZglvaOTK2A9viyh1O
 H3oQLd7f6ayWfVAg63Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NCBTYWx0ZWRfX1n9MNpag1jVV
 7Ye244VTRW3Fhr1arzo3q0/vp8TcqqGTeT6zWJNw0hxKchy7sU5obBPfKu2NPe/nts9w3PyZZFQ
 oR+tsfuFLHy0kLJybfea9uVbo4dhI8A=
X-Proofpoint-ORIG-GUID: PsjPA4UfS2RewGKQoDYczKBiud5L6Rye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200044

On Monaco platforms, the Adreno SMMU requires a bandwidth vote on
the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
are accessible. Without this vote, the SMMU may become unreachable,
leading to intermittent probe failures and runtime issues.

Add the required interconnect to ensure reliable register access.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 3541313a79bf..13214aa77279 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5113,6 +5113,8 @@ adreno_smmu: iommu@3da0000 {
 				      "gpu_cc_hub_aon_clk";
 			power-domains = <&gpucc GPU_CC_CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		pmu@9091000 {

-- 
2.34.1

