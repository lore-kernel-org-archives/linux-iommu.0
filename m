Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82C44DB89
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921881; cv=none; b=njwlVA2DWmbNgMHu15XoiTAvgWDcNOfn4fDciHGaSIogD7o1KwEgIqUf3DtaLxPYyeX2rCJGQ2aytCw3M090IQ1R8ZcleHK0usJptO+8TqDYEuhCJbwrMPRBd86vo4nxzjnPwjYDq1DcJtRwPOI+1ixqd+mM2dlMNSpNFQPr+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921881; c=relaxed/simple;
	bh=j8TwNbvdrY0oB2uJWlrb4vav4uY7HtWhGnmH8BAkF60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qbp+jBd7/d1H2yCeg4cwrrQpz802WOC7iUKzvJ95mvQ4ojV9YmCIFFpwbzOrystycVr36nY5zR/JarrGYWDBNU+ttmDGyd1yVgOTBDe/WOvQCxUNCtT8V+HVhUVPA+hiSvclVSsmNEWaWvVOBp7c0za02ZceNmH+1GBUIiLJYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bBBvBljP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g3JA5zGD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bBBvBljP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3JA5zGD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KELqFi428546
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 15:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R2Q7SvHuSDAVtZr8Kc9/++
	hSXyyDNQmsxA9fUfbHm9s=; b=bBBvBljPPxpPV5HYM08TIgyh/CiAGq1DVhJI/z
	WV/3EaibeIUHHqyvZYNU/mqVecoDq/0I3RG6qo5Cg0V27alaYHB4xr/GrOlB+vhm
	+mS7QlFzqMbj3vX9/856P/X+GsDwX1lna92E+Kg0OecQ/rzBb9xG444T1cq7GG23
	xbK46ntct770xJEX+R8rmxGWfVJ0pP+0Yi8x63msbvssv14HeSGXm5S+kdNsJVZd
	rpGGH11RyqkpGKC3aCp4ERJIagq6TmLFNfQzWaXIxhudAUYwVHWbid8jyoqHx8LH
	xNBPXSutXSohsGxuDGy2zxtIcdlo7MY9qO/2M3iEMrz/h70w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4ps1f7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 15:11:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so4786755a91.3
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768921875; x=1769526675; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Q7SvHuSDAVtZr8Kc9/++hSXyyDNQmsxA9fUfbHm9s=;
        b=g3JA5zGDmivnCRZUY1oQGvbR400ZZcYtPfrUuxp6fSnlWDFAGf/nRW5UOxrb1bmXhL
         ntpmW0/gTeKkJmh+SMZgG/iZdLATl4x4OAwF/57btqFFuriKPdq5+ohbQHMJ9lL4DbgY
         X6XIMQP0sDYSwpCBAtAciEdyuACdIYOdN3SxZOZAZedZV7JE4OWvyAvGeL2OFgUurzeG
         X8vX3DGZ09MyPTFNHVBR/CEeUdTzSaNk/THZDX87NOXAszKbLj/C4goNAJ63o6ZjCnD6
         JXNp3M4tj5YRwex2EX0j1gJMFwYhIYZcb+Y8jZIhGWIroElBGWISvUdLRSJC4gD2Izg1
         bmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921875; x=1769526675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Q7SvHuSDAVtZr8Kc9/++hSXyyDNQmsxA9fUfbHm9s=;
        b=Ij2+aSRhS3jiGokfedH/PMjVMFir8/ddFzVi28H2KIuzrrun17iWPmZ64jVEXOJgrl
         Tir7HJiysEiomgHD2onvU7+1DamvxaKi7/MlGuK5mQtMQJ6WjjMv/nAkBK71q8fuTYoT
         UohHplfeK3dxZpFsfc7rBdSJIZBWnDuDP0qF8IKYEHzhvTf6DB1zq+05BUr2fIMEFBKo
         jlZDZxA9jYqK2v/VSEzBL7EQVeR6ijdrpss4MyVv2A39sIVNm9+UR+7IEsvflAheH1po
         LhSSXE1Wb/iaCCC2TtaAs54kWuMbSbSFtYUarjLulfp9hHy2qr5VYeW/qdZxYzz+w9Ye
         JvzA==
X-Forwarded-Encrypted: i=1; AJvYcCWUnmD0HDDEfh1p+qfNi50C9BozCrwy5tagCPRDr95m3CSxoLDfHRdIYxZbXVsSTXnnk6r7NA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNqOtUS7tWTWj4ZtVXZScBO+hx5GFkB9dAwsa0UT/Rz4Oah+lx
	+Ow3IeeRcg7Hk1905YD5dri78c5yn/PAgdtNdvCz4VOkKcKIr2qdTOTkzUUjDG1lRi6mfW5vKHa
	7oWKkx4KjIKWGkhEnZulNhHCEmeUmpm97LGitQoxcuDq5RfIc4rP1NrCGPA==
X-Gm-Gg: AZuq6aK+wFKUZ7Zl9VUWG0ogzDfVt38+jDBuAS0ytuSo1d4pw9YOOKk5qC7HeVT/KSJ
	oIMv2acpJj+1qe7zAk1jl6q6kvp0UhEe5I6h5gkIU7b3h0sNrYvnqd2uxzsNvg6TlUo21IAfuZR
	nyf/MWyi0N/MABVU8xwzz7Snbn1S529uEgdCoZShpr2NWE7Z6LVRemuiUGZlIYm2B3UlBMDdL6K
	49wGwkFPtZko4oqA5Nly2fN26sSOsqSl/8m5sSqFtamoduSpdZcrOFG/o6ONq/IkhpRp9ulsnCB
	gmEkZBkLAFMxveEuTgQ7qjo6YEUd0ZN1Sc4zTQ2PtI/NcVwd1UIsYh/hP5sPB4QujFPFTQwF6rZ
	IHUMqiI66CUT4k/1j4AiHtM7DO6ub3ztzueGNdcMx
X-Received: by 2002:a17:90b:1e0b:b0:34c:f5b5:c1b6 with SMTP id 98e67ed59e1d1-35272f028a0mr14267291a91.12.1768921874713;
        Tue, 20 Jan 2026 07:11:14 -0800 (PST)
X-Received: by 2002:a17:90b:1e0b:b0:34c:f5b5:c1b6 with SMTP id 98e67ed59e1d1-35272f028a0mr14267256a91.12.1768921874153;
        Tue, 20 Jan 2026 07:11:14 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527306c41esm11517836a91.5.2026.01.20.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:11:13 -0800 (PST)
From: bibek.patro@oss.qualcomm.com
To: will@kernel.org
Cc: bibek.patro@oss.qualcomm.com, catalin.marinas@arm.com,
        charan.kalla@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        iommu@lists.linux.dev, joro@8bytes.org, kernel-team@android.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.clark@oss.qualcomm.com, robin.murphy@arm.com
Subject: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on sa8775p
Date: Tue, 20 Jan 2026 20:41:05 +0530
Message-Id: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9RNXM_pqJ88C3QuUd1YV1SVPmN7f4j4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEyNiBTYWx0ZWRfX6OdXrnkyoHF+
 84j5iV85i2N2DAlOTgOF3juslnEIZgGGkNmAcdbvn7qII9sRY4scdcHBn0sU2v0cwBu52+pi99I
 MlozWBjyaO9pQ9Y0ZX8CxJPs/0f0RVOptjDcBkr6nY31xvywEOfdNikjMK/FXLZBYvBPcoUhhZF
 oXaM17dZB/FSuVA7apvT6U7pdeZwHIR/Vq51uHGRph5qsSX0VB7JKkaQfEOuwJu1+Hc2toodgow
 6qsw5777tit+ZhKg7ewIhWRVL4tA/sXDrJbmhh5gTYtZ9gR3+Zrtd8Tevej5uu+Pm196Odhb3kU
 3Zcl9Vzoy2Rwz0WkLr5/WXaKs4BPuzhlL6XdAS2PF9kwdKoUuYA3I65yIc1rl6cUaj+jthLKC5G
 Q/4U4rTi8f7douMLNdwLjoflWpIXOYdUrESPVUJ2Vgomo6GOfMwAdVPoa4TNnWXF9rj4o5OivRa
 iCzjQ+9CmeNem5Jsypg==
X-Authority-Analysis: v=2.4 cv=PdfyRyhd c=1 sm=1 tr=0 ts=696f9b13 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=X4sqO_BnIXgP0qhT90oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 9RNXM_pqJ88C3QuUd1YV1SVPmN7f4j4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200126

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

The ACTLR configuration for the sa8775p MDSS client was inadvertently
dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
Add actlr settings for mdss on Qualcomm platforms"). Without this
entry, the sa8775p MDSS block does not receive the intended default
ACTLR configuration.

Restore the missing compatible entry so that the platform receives the
expected behavior.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---

Hello community,

Resending this patch as the earlier version was sent as an
in‑reply‑to within an ongoing discussion thread [1], instead of being sent
as a new standalone patch submission. This may have caused it to inherit
the same message-id and appear threaded incorrectly.

Please consider this as the correct patch submission.

[1]:
https://lore.kernel.org/all/20260109204551.845959-1-bibek.patro@oss.qualcomm.com/

Thanks & regards,
Bibek

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 456d5146831e..718d102356d9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -43,6 +43,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,qcm2290-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
+	{ .compatible = "qcom,sa8775p-mdss",
+			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
 	{ .compatible = "qcom,sc7280-mdss",
 			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
 	{ .compatible = "qcom,sc7280-venus",
--
2.34.1

