Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A348A2C5
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496495; cv=none; b=S12mpDV8kvuhJhnubBlM0ceNAZ/nAejkh6s/5T+sfKaw+3aJ41UWyoKmX752S43FzYbitASm/MP3OOU+o4ORwvVV4GF5sxopnBTH/EJPx+fISd4A2Tyfqckrzmdymmcfnsk6P15NILRiqh+vyV0jukiJ/LePu3IzTDqGJeUsGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496495; c=relaxed/simple;
	bh=ZedtRlFClaBXevVNFnYB8UGxbyP20S9HuW/op1IPHAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPyj+m6ks+BRW09oYZSK0SSquh550+I48evoPe5OYatgEQclZMIj+GjQNB5BhZ6mD3uKJgVG1mXW5PJ2sizGRSPNW+S+JhQuXW2aGiWJC1+GQ+BL0SwwyhqhQ6Nk7WbP7eEZuI1u7vZYEDyfmnC/YmbHeiS5xGvbInLmkDz3gr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h0m/aYQ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j4H6Du5l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0m/aYQ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4H6Du5l"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653DQtrK1956497
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 14:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=; b=h0m/aYQ8LGz3nWUC
	5B+xKAFVUnyzkM4SoWnQVCR4I6S1fYeZEtdIvzuarM0yLYakynr3kB50+Rpw3jtY
	/nyHIIfH9Hb7YTmzllSUh6JlKMctL93Pgn4Q7xoAmGm/523jcANoyfBg+cBicIXo
	Y7pd+tOKH58L1CAdZmry5uNjhh51DMI+hJVOizXskskeysjFujB9770I0eJLL8wj
	sa77vsgSgQ55uLhMI82PqujiygQFeWiTunziGZpCD6NuzkpYn52wD1eaqsJpjL2Y
	h1LoBu9GRpcDwY4CfyYS3hQHEfQANDhuCFApKgv4t/lt6ojUhgdbeISpe1t7KWCE
	mV4gaQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1nv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 14:21:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so6032595a91.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780496492; x=1781101292; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=;
        b=j4H6Du5ljGmsSvgPfE5Ijm3CZ7aIOYMKzs0hb/y4U2obnzNRKbaDkJmMMSnraV/1CZ
         Nr6d8NMjwMpBs490RYRmC4il0a/G+8iYi2vD8hfUBy+HxkTG36992lXIyJvmlJOCRNaB
         PWGAtdULdnZATd02DxbfbPnhxwC7Mh9BDfRoqYd40Fcq+CEQzn6qtd2mS0EWPTSuJHIB
         jvViemlgp+7o5m51eTMYDCeh/yLCAUmFA/LYj2yOPM5txTxCQOtcapsfk2ZP4c/ODgR1
         wg55o6arhKy4KqTDziuQbS4Ewoqv5QzW3sg6Zb+GJPcVss8K609NwqSVYXgslODeB5/n
         /oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496492; x=1781101292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4Gm/K+T3sc4qmyuI/6DYikh3FBs9pCLd7ruh8jMyfQ=;
        b=orK8x7262Rf4TKZQ89FgdHEXywALy8NicTLreWRBZ+Oqh7vtkdRdk/gVsLK8qqNkQw
         3d7XWlGyoAJ896z8bDMBu6o1me78GPHnyjDuSzO+Sx4a/+aTmjJirMR3lryyj36erV1+
         xz4iCN/gDNGYTriX5RYPQevUjQ0gCzzOWLLzjXPZWmqtBaHO0UYDYKhMhLIfiJI6ZFo+
         WIur/7p6DDrPDHd9w7aDKPWxuLtBtdUHtFTcQ0msJb9L23qsQsJ6lkD4kl2eHKxAGJCb
         9bCDKzGYChHhTCyyszZvegvY6h1sEIYpoSAsVRnIekd/U4CXaGj7tGf8BAKO3oPlvW/E
         1uKA==
X-Forwarded-Encrypted: i=1; AFNElJ9qQTfsE0KpiHN+Jw0uKDvpzMMf/xl1HgsaXHgwrljGiXI6X5+zyBYn9ZaLeplqfg3AIB/r4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF0GF8/OuuaKpCQH5UNLvl0Er4DZCUdHyWiIgFFaSW7htrFnQ6
	IhCIA1W7+m0AOi/tF+SEl+EqhS9w43zTDLQA5EJXDOFfkh5v3ovN+m245E+VzrNY6q4gvSPCtZ1
	s4PWSFeYPnOMuyc2HUVw2aWgY166Z3qNm3sqGdmL0sGkItFJBsdYZuFxNew==
X-Gm-Gg: Acq92OHL2Ae3gZzdcXeStNl4gsEard3yHBYM4LZdA2cV1fRuL8UbnUlEDH2w8nr6P9A
	T2PFLVWxk0xdzNy3PZe0vCWmFpttu7lmMiTHTZNHge7rqr8SAF3RMCADYOCEPL16Jzebo8CXp1C
	w2lIgkcMXlcEOhv+u8D0zJOMmYmQTVPfMGp+d7rkLY9sD5OGHJdP+WYhFCaRYy5xNvE8ajMsyQj
	XlpNX+seNiJ/a6QVr4mhqC8r1S79C3oudnFTLXYWN+/1pD3SauwIvzgB//lF+hC4krZufgBX7/I
	4PeU2WyiwG6bW07MBnL4WfkLFPjN7Lh0oQ7176H5lBMVvr7G6/LYwYNG6u08J1WWDigRw2HqLvv
	3fx8OCaHMYKhBN9pnuk8b58wf1Y776hMCGpqls+E07oXTJ+7zBQ27wvz/my24aq1ftg==
X-Received: by 2002:a17:90b:51c2:b0:36b:4d63:4a96 with SMTP id 98e67ed59e1d1-36e3247617amr3743130a91.1.1780496491853;
        Wed, 03 Jun 2026 07:21:31 -0700 (PDT)
X-Received: by 2002:a17:90b:51c2:b0:36b:4d63:4a96 with SMTP id 98e67ed59e1d1-36e3247617amr3743089a91.1.1780496491404;
        Wed, 03 Jun 2026 07:21:31 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm41514955ad.9.2026.06.03.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:21:31 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 19:48:50 +0530
Subject: [PATCH v7 12/12] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-glymur-v7-12-afaa55d11fe0@oss.qualcomm.com>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
In-Reply-To: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780496410; l=880;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ZedtRlFClaBXevVNFnYB8UGxbyP20S9HuW/op1IPHAM=;
 b=j6KLzRXja9vw21nECiRDIymu9bT8tQkMHvQods9ahk1D42LUixH/CxeLS/SQpISGW74WdmXD6
 6drwsQqNiu6A5EHUvmo7hBgLTSczmKwFmTd3bag+LS6ZEe2eaPj7UfW
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: L-IX_hsPOdzjGfAiXQEX4dd1rVefLyOK
X-Proofpoint-ORIG-GUID: L-IX_hsPOdzjGfAiXQEX4dd1rVefLyOK
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a20386c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Dn0IJEph4XI5J7oltBAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzOCBTYWx0ZWRfX8xQbkPjPCKmu
 KzzfrJl6EegNqZII2yOr6ajFCLDGm+byrUIkafANTwCTY5cxGAQSJzQQmH/pkHN873nW88GydMY
 onx+oPczDVxugIboi0U1cDo8d5VFN5qKzeApnyl00nUJZTUB69zCqLeZUD0EL2OIhaK56oQ6Mcx
 fdOEGF/+4jDezuW/Rt65DgSSY6eYBVgn2O5AKqGxlg01da8aliWjHdOAFDuFoJrx4Ev7i8CG65b
 dcZORcAnqM3KufDmOWWkKGNokwTMa2kkZW8RcBSm3vsOEeRvehZmLhLEO2HkZ/jqW0gBVZmax+c
 SzCmBSDW2Y9JRYG8a2WLaQLzPqe84nQZKJqx+p22qnpVHV28yRTf8HXdoIpcxshTJB1Bnw1iaXl
 c2x8r8S/e0D4V7h0d6hdViClLIPRXDX8TnvlqQGltVW++5K08VRBVs2wHailNpF5axpNtmsXN6q
 LXuryKUTmdF09sQn0BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030138

The iris hardware block is described in the glymur SoC DTSI, and enabling
it here allows the media iris driver to probe and use the video codec
functionality.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index c98dfb3941fa..9445badeb18b 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -198,6 +198,12 @@ ptn3222_1: redriver@47 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu36_p4_s7.mbn";
+
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.34.1

