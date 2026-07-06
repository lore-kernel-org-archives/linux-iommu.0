Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF943849A
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357042; cv=none; b=SbsLSqH0oSfT5z8j7FH4Hf97UlodEgY0tmhh4MPb4Wki870R05s/DbkJzEy27/hz0E37anJ4ZqYQXtbDIDIQv5iFiZ8ShxfgavQ6Rm7N57JH4Ykb3sUkaM6rwXC5nwElin5WcINdFGhjldPk9gjTdYh7fxrGzAgWxmPLpJ+iSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357042; c=relaxed/simple;
	bh=wbPY7V/FOl4cQCe5O2DtEsw3MYaK7JiEV4us8ye3x1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3fBahG1IAEjG1MKhd72pAiAJg6H9IgDSL3P1V/UczNUxh7rtlQQfZR9yiQfx1dkZRotlCBhXdE2+Q5p4cgunG7CTRvTY8mmo50gJE1OpGpEnaN556RXOEc9OvQSo/8gzewhU2sLwsL20fVTkSlpEDgaNq9iy4Ie32FEJO2Iq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xc2Q1tBd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCN+YURw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xc2Q1tBd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCN+YURw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FsWG01049974
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LlsyewBqxauWJCEQm7ANRaFSqV4fDdt46wPdk71U6iw=; b=Xc2Q1tBd4ObuSVGv
	Z2uWuZG/ah0C0okCAzSaWsmYSqLXRHVShTyuVimtessLLVDQSDdBC0m+yRsrdsAZ
	Cr5UW7Ltudr9r0M+T191BnRUs5vhxUD49HLonGX2zfl62+emnRDaxycOqYHLeVcb
	wc+Hv71lQ8Fp1QXhlSykLaFSUdyNxvcr0sn0C/RSYIscZwrkh46LUbveP83M2jZg
	HSI47RDxtqeFGMJ/WHZSap7RjmktmAUgCN9hrZMqy5K+KFVh1DJ5l3pDVLvRc3pn
	CSajoF9i6Jbk+rd5c5DXVl1UtTMI5zNr/4CUjAxiBaPbI9Ubn90FAI+kjjvoWIy0
	Er+8Pw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw0apk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:57:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85798977dcso4746823a12.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357039; x=1783961839; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlsyewBqxauWJCEQm7ANRaFSqV4fDdt46wPdk71U6iw=;
        b=GCN+YURwWx1yrKkGYIKIAtI4o8fh+sWnd1gGS5kIi1iad3K4VtXgD39qPVk+ojYYcM
         cT/66t/Z6257EC2VNB5OODZHxxZtbqrno7GY8fy9GR34V0RCplU2DkIakpkG0iSnwipK
         A8JVcnfpy22bvDc4RUo6CnqG7flFOqpxlP47Hh/AWOUa4GHivUXU9QePjRsPhQ2OIYfF
         ttn27kyJDZbIdRZPwHg7Xr7w764J8Sby+0GFil8kRn3HLfnPErrInuIhGWkwsQRBuCv2
         KMUusJaKMvxyB4GHgdCEehi6nd5c3CyUdTuWViv/L1iRI79ckNWl5bG6q/ItA1FTl2NO
         sEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357039; x=1783961839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlsyewBqxauWJCEQm7ANRaFSqV4fDdt46wPdk71U6iw=;
        b=eXYg7bJiOn8PuQNAxKINnl0bz7FAl5x/nvtt10TJp49U7bYUjAVWnLpGC1y2QFt39q
         93qk9UkBJyMavCcdvaFQUKfjC1t6Qn48LL4K1FrXoESb1Zh2zJCZKSr+7rim8YM202L5
         RlsTojpmlll4WXQtIS89BzYe5gWLJ9ym9Xbw0YvVf7oBx9TvJ7u0u3jP2+ZbN56dSJ1/
         TFlWHdGZjdZswYkmxwyxP4gIrLp89LjwoORkvwgkRcwTKoWlkduTkIeFR39nrje4q1W0
         aI/QBtQO+MmGcI/oknTQeo6Ga1qU5qmtfoSxtwCBYISF+oBWZCY9omxWYJLXe+9J8FCU
         D/Ug==
X-Forwarded-Encrypted: i=1; AHgh+Ron4sTaVmxALNBCY6RxGjDfi8CuI3b1BOYXIGOI+znTE8kzNpaEflEhVdQ96EzrqI/P5TqHog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcSo9yO4APyoLlQuTwwdTwm2CpdoaGdI934u8v18wyl8xui45z
	5s/tz905CSZ8aIoGu3NcnrGhQzbg8hjSc5QthRw1ylcA33VLhfKup5zJnwrpbtZYIky31AoOxVb
	etfzFmOFddQ/YHv6rIq83oMxvl7znQGWw3yYAQUT9PhUXP7UJqkiZciRzJg==
X-Gm-Gg: AfdE7clDDR5hIKmi7haGB8dMm5D76OP9CcymBHa7hwn9JvAAJnkezo0+YUkYdXi5qtP
	/2JrPa4joug0L/dMBsdpSy1rkCHF7mNpSGNaMLHSEjwarryEpRoIVXL9Nqdqwd5QUCAByTETNTS
	/1UheC1/mEdXCyvUk5aRQDSzTFVH8KLQto6QfS64k3xrEALYizdCkaAJltzMvaOya+Z1S6mURLW
	2ft0GMyWCAY0uuCfcMKAHwR2zuOKNqP1IEgkAkJBAougwJCHPX7iLdQVTDnDVrFLyDIf5FAIdUl
	azQ1PljxOkwX0N70mwMP32W2k1LXLI5hsRJQOVMxxq0RN4RdezXPI/HgQXaI9eLP26bRU1clsas
	ftkAny9qGbPQvBgnKLB4rYmDO9uABDSGlmM7RvF93hg==
X-Received: by 2002:a05:6a21:118:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3c08ed0f40fmr1869374637.4.1783357039224;
        Mon, 06 Jul 2026 09:57:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:118:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3c08ed0f40fmr1869330637.4.1783357038743;
        Mon, 06 Jul 2026 09:57:18 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:57:18 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 22:26:39 +0530
Subject: [PATCH v3 6/6] arm64: dts: qcom: talos: Add GEM_NOC interconnect
 for adreno SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-smmu_interconnect_addition-v3-6-afdca0125a65@oss.qualcomm.com>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
In-Reply-To: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=992;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=wbPY7V/FOl4cQCe5O2DtEsw3MYaK7JiEV4us8ye3x1w=;
 b=uIp4SJQdb1agf7l0A1zJf93Xn7ky6npMpVlZAoLLOlESlUMOfaywlUkQrpjdFuhJvffGiF/zC
 Wp42e5jaL2MBLNqPZ4dOCIwPH4FLxkvnx1FF0fFlDAOxJ32l0G6R0YQ
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX1CKxRhu569Oa
 7z2VBqSlk55p6g4a0Di26FHbub33QDlscJpr8/M79k/ZIJQ+z280Fs+MT7sWeFWiGky2v1d+QSP
 w5ewyomgaz9+2VEXA0bJ/xvJBcsuZAg=
X-Proofpoint-ORIG-GUID: wDiLrvkCy933UVBptx-nfj3b1NZWUKdo
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4bde6f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=rfUXoPsZI_F71NZxNB8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX9uyRIqaNPK65
 gMFpmdeT2cnzxotCvqE33EAQBVtPtT7vgTeiqn18FmyHUQI6ctwFulRoOtxMCfw6gIZt1JF5X2W
 MZRBMmjZ0kSl7N6yNKi3v6WBa8gV4wHooTfZg76rdBv54xiJpa37dp5odSiGysEzyaUhEDGgetB
 hon/wozGI4ZgfVxyZoJLl/phEarnDpM0+cYC/BxiM8/A9S82L+4rnervgPL69CRFUOJ+Un4CWc9
 ZoOt8l/HIYxHx8wQcFEbw/3UazrF3iCGQbXz4XL1XMKGqozLXgHSV5LXq1878B6xmLVvMZtuefH
 sd2S7bVCYC+9+zLUPDVxQMDQGajXXVarce3UPbuPPgV+75g3ING0Le8mRtZMa6ES0FT4lOzjW0v
 2tKTuiYevJnej8xLbdIEU4AhXOlnl1S0qqbXQ2pw9asd8/LFNAVYeQd32ZoM1KijvZmq4+2FZxm
 ZU23sLn/KYtgLBhGeig==
X-Proofpoint-GUID: wDiLrvkCy933UVBptx-nfj3b1NZWUKdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170

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
index e506a16c9070..ec7f2c78ad18 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -2090,6 +2090,8 @@ adreno_smmu: iommu@50a0000 {
 				      "iface";
 			power-domains = <&gpucc CX_GDSC>;
 			dma-coherent;
+			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
 		stm@6002000 {

-- 
2.34.1

