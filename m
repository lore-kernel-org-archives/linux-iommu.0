Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D50448BB8
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905977; cv=none; b=Npzm2DF4NIl1ym+xYy51mHpZcZ5DsXSh1htotFJ5IlF9habWkNd1YL0FdQXjjaRus8iRBaV+hP4SN1mxmlYVcmfhsL7IgGhVDX/uVf6lsPNePIKyugB3TWS4xY481McuvbOj+QcIuYM3kRRUiqIGrcTV/bWuqjC/TOhCGt6tmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905977; c=relaxed/simple;
	bh=pM9OzqC+JppqJ9OLBzr50An+hP8IrbWEsl8B2wg3CJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K70oZzD0EFg+4JSdfigggqTK/LRsYB+mx58v+YsF1ouKPPutxH3fT8VUZ0YQmkbg/wQfJ4mtiEIEo4AoTTOUaPhwJkL+pLumREKPgvOiU36JQmUzMoexiOrgkeFOdXFd+Lk6Ey8KVotqltbmgtFuqj40Stcberwnbq/qC28a17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odTxbkPQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MxEw+1Zy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odTxbkPQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MxEw+1Zy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbObM3178447
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=R7YNZfOENHc
	YgWpnD4HYMuzIRdW2TX8OzaYCiKE22VE=; b=odTxbkPQrLFGXTEGHp3WdEboF8/
	DsFlU8Bnne7tpcNNz625rqLtYKvqzgUYu9PXaRmzZMk+OltJ8ROc37d4o3jeoZGc
	rX2tL9sAdrOq3iJyNDuH2pnuGWJoUSpIuP2Wpsrq7S2l8cLcXa4R77nik3Ikgs1A
	+l7xds+v1du+XVKqtYwgU+LK3q3RKCIRj2upjt3MjpsUE8izWDCNxKpiwmowRPFS
	OFstzidsS2QZnGurARUtzkzDKJV+jWXRlOnA+3SiIRCWBjzFqQmF/XF6BdhNP0yh
	Pi1Vr5ALf362WQDfuKrdT6YMmcTUg5QLSVyYNbrJmtQT1G7EkNtuOyn7OTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yah4n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c075c1e25so6998921cf.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905973; x=1785510773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7YNZfOENHcYgWpnD4HYMuzIRdW2TX8OzaYCiKE22VE=;
        b=MxEw+1Zyvf/SQ9cIOMel14B0LKCI15GBiTpItL2IQdpUGO+vwWyM0fkzUM5aCCHYXs
         T17bESb9nJUCSTYKdTCn2jzQv/EhqXMJjApyJTX0uKqyJ5jDGGAtRDjWYn+liewSfOv/
         1t7S0LX/tH6n7wx4SjJhJVOtfefENA17qUXWqLh2RfyiQiQjSXxmbMcN6AkSdaopJK6M
         El2LVloBYjTfOnw1raz4nPH+/uwf0Z5rRroSWkad+684o/viWD7eNTChgcxX/xOfjxV9
         +HugM4VYgrBHVHuUqOuEztKFWq/iJSEfNR2qgopBP8RNPCykFtIk0uOLrLn7kKChElD5
         8ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905973; x=1785510773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7YNZfOENHcYgWpnD4HYMuzIRdW2TX8OzaYCiKE22VE=;
        b=IaFQyzmr3Fj+wJEKD29Gduq4IqTqHdyA+32ffUAE4CV0RjoBKcjx7ocDkWAsMerjb1
         EVEZ9GiF269AsVYPbnfBeQihAGLU87HOlrQF5+84F9q2xTrBMp0JBQpZytYMKbhtY54U
         agCo48MKIxa64IhnPpxJe7mHih7TXetLnO6A2Kv0RH2dnX6ZC/7tKzd5WeDMLCmkKSH0
         1C4eKvNA+OHpKTq2zmIN0e9xc52hGPao/07sm0k/9FtTotY5hD6U1LH+suY41CU07uW8
         ZQXI1n1pT9V3sZOf32nwbudRuECukt3DV04H+Dor4Clgstgkp55tHgRsADd5PULQWFNG
         Cr+w==
X-Forwarded-Encrypted: i=1; AHgh+RrXNBEqSxkffFEU9lp3h4zaUL043whcka1XexHMltWr0sxoS5m5AaWfUes4VpA82J4bPwUpMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw51raLNmIToWVrJwtrEYN+CUMEj4/N4AF/JrJXCIDnU42u3GSH
	K2byVcsesmhWgM0qLEyuu3KtGu+dn0l352hIdIBMxJOy6BFrsQdYUwv/Z7FoOZwnxrbxEX6BR7X
	i+Fb6RdMz3xJZQgMlvEAt6Nh9EYqykM5miX3NqnJiVZpkn9R9OKU+MkayJQ==
X-Gm-Gg: AR+sD1238KnJWQc5DwGc/foPL+CwUPGk8j/4BfqlVfU45DKasaXrJziilh+W4Q+Vclc
	XBJijerbcZlWoBZVVeQPks6g2CqgEVX97t22mdUHVC1apWuCLl0f3O6600MwLjMHtOljOEjR0QJ
	/uuoQ5nHMuNkksOfp3WzLACquR01LVloNB//l+9CIirmAnQeLu3IjMfz948nYMKowpC73sdIFSS
	7LDE1AbSxEtogLGDoqGGdfnxSGdxi5Sb8I/gPCe0DUA7N3m6vI2Zk1C7LI6KVLgGQ/S1436qven
	v0UKF+lrF9ZDXGdsHuRRWXlaYQLZEefgFK4b2HOgBMXcyP/CyWB6/FTsgf0HpISeryE1TBOeKg6
	TemkwviMclT1fwQEcaXzAPprZRZqf3fBOpQek
X-Received: by 2002:a05:622a:6206:b0:51c:11a0:9af5 with SMTP id d75a77b69052e-5283df52ff1mr73705431cf.70.1784905972494;
        Fri, 24 Jul 2026 08:12:52 -0700 (PDT)
X-Received: by 2002:a05:622a:6206:b0:51c:11a0:9af5 with SMTP id d75a77b69052e-5283df52ff1mr73704791cf.70.1784905971900;
        Fri, 24 Jul 2026 08:12:51 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c4ec7849fsm230083466b.5.2026.07.24.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:50 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 14/14] riscv: defconfig: Enable IOMMUFD and VFIO
Date: Fri, 24 Jul 2026 17:12:18 +0200
Message-ID: <20260724151218.965929-15-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXxGYWiX14OzvJ
 t6InRDwdn8RW0oHk/11+dGeDKvWCMYOd7JhPVsLxnQmaiVIrxyxWrQjFZbjkh61iPGQ43lVNVVi
 KqbacpIlR55CrwJ+FYmZo5jeJH2BX8Y=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a6380f5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GqzxFy3tBpXcAUtZkFUA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: va_2WfeOM0NxqaGU78oHVJxMIbzh8aDh
X-Proofpoint-ORIG-GUID: va_2WfeOM0NxqaGU78oHVJxMIbzh8aDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXyl1B5FIN53tu
 YzI35pjxu7KaZIMhWJmCqv3Yhad8RVF9O5TElEua2Y8tea6E08NAbEyqWtUBPmOS0XJ4X3h4f6f
 o+kpXHV2JExk1TXadh2bMh0DOPD6RF0APHSVUYn1bsLChxL+Za4IJXoTU0CcD29zVAI3iCC8qtD
 XyMUpAYFv395hif0KfYO4eRLQ1kA17fsTR9XXPGzYu/Bx/Tz58RaX1kfJW1EPWgj3KA2BEenXjY
 fWk5rhht2tqEmdkpIIhnAtgf3DgaXQxVtmSSvNxhlckIEch8OWRY5p83uauEcjfknhtF0fLD38T
 nTQPicautwBEk6sHLi40UFDucVxeBrbZz6X1IvFDEQYBGXY/IdtDs0LKtvOyQHOrYd/CPC/0IKt
 AsxANFBqkM58sdP8GZXE1BBLdPHJi63qELBpI29BozHUg/gNzWe7LD5CZ1cpF2wgwfE850h8VPW
 b/Q0WGv9dZxZzWi8OKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240137

Now that the RISC-V IOMMU driver supports MSI remapping through
iommufd enable IOMMUFD and VFIO.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ed605b5e3162..fb3cea5712b2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -249,6 +249,9 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_MMP_PDMA=m
+CONFIG_IOMMUFD=y
+CONFIG_VFIO=y
+CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.43.0

