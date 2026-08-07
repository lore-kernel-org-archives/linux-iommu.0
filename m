Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB737BE7A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126676; cv=none; b=Jb6BxM0irpKgFZZFVDYFHwWXSxpUV01ARDsT6E8+613s2oK90pB6RGFlsGeNTi7dblBtUBznCHLYB9UZ0rWZ9Jj167lQMmLdI22Lchfwn0VVc6r589dDfHuSsRcpGix8tdeQtRhy2OCzNWN8jWRIFCmFM1yIjPn+HKDBTCHtXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126676; c=relaxed/simple;
	bh=kuhlC5G3/6NlE6rPB1WSALgHQUtGHginEesYshismm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLpeAxnb4vGopV+wvs16l+Ng/2NfkpRCFP6NsEBboKhAhHcS/3NgiM1u0AiSlcHezHLh/5+zDT+v/+RCXEEZ9SId8K+aWweJ1avaiu3PF3ydt1WxeFp6l6kEDdjoQHGcd7oaJySpKtSYVnLKspkpp/DNCXPsEJRKFdkAXadpDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SKB4x6Lb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YHIX/pqC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKB4x6Lb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHIX/pqC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbV431825898
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NMovdxH0w7X
	E2JSsdhyhOuYe63iAjdbny0JPkBF+9ZE=; b=SKB4x6LbbGe0RBEfXO6gu2z4g8M
	Q7kKh54USsLY8Lf/otMC1il42BC+jrIKFbsD+Bp6F7/zCLgg2k74zSPcGw4h2kwN
	BxpaZ6vsh5EV2pD8OK+SnSbos1qM8pJlXTUdL/aJPPrKI4zwb1Dm3W8u0KjIiPsT
	m7+7GHRvlAGQlUhYxDitSX0G8FgvIVHbP7Fok/dmJKwOLxUIad2TbCth+Kh+ujVT
	pesY7Nkd8GoFwwdFUINb0S/AWKa0Y8sWwF8TCCdAt3kZdnCybLKrYMvcEfuEyc1f
	hY6RS95Wl/hkCEsMmr08ICFZ4riLbdV7pbPhziDluGaqQaNK296bWHI5WHw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk21gf36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso198550685a.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126673; x=1786731473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMovdxH0w7XE2JSsdhyhOuYe63iAjdbny0JPkBF+9ZE=;
        b=YHIX/pqCgFz7GGViEAbWfhO7hRSTa1OIxVbphpufH5bIiOM0H8F2DlojPYp8gleIud
         Y9/Q1PQgr8LbESBdUSIqYyLdTe5PjOJhNwXBpYodRfLqgt7SIOuOqbKVVOItcEqwxeLR
         4GKuY7WiI8PeMU8VmKy5IRn+5ny3q1SnlYmn4JdhsGMxvSzSyCGRjMTYOhQn9OtQpLaM
         Qv9EcXk1HvUnagOq7OwafvKGh/LzlW3SHozDzjJByKgAXdZcX1iP9qdsrr6R0+I+yR/d
         J3TFaIhjIcQEh5bM3Ftpj8FjF4rKKvZTOAqmTqSHcYfMKwwJJUfHOoudLExEJ9ecbp/n
         9ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126673; x=1786731473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMovdxH0w7XE2JSsdhyhOuYe63iAjdbny0JPkBF+9ZE=;
        b=FfIC7jHU91NkDSesJsKCSRitWLGevsRvE4aWObC40+BoX+wTvDbQvNHroT0m3+Lm+N
         D7CjZV1KTp2sH/reJbxMr6v+TlRtR8SFoKjigtz3yxX45pcI7fyKFU54rMVkZMaXy4ou
         DcQoFr5/x7XoKVYk0WfytkuM/Gz9CHa9No3IgqSlpH6HptsfnhYR4VdQdyNpA9pUIqGh
         N0xtwPULPnxmDbmQxvIsjW+Go4vinLgXpDwFAbj/vcxDDb7tB2MEVRSdhIizrnNeez4k
         RmHvqKziXXNJS4qTLUcYlAJnWkZzCBOKJ+p83WRSeR1c8ZmUQxmkszhmXfhNxlk9Lxvv
         e9yQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnBqu8ZKmOAYv5PjuGbMjfrt1LEI47rGHyzOpW6nxqIlmy0BpxDa1koyWv5aJnJMuOR2D1ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIAAJg6kzyK59Ww1i7nv0Q+Qvzl1y7j7lYpY0CIE8etYu4WFCc
	vugVK0UQJ9TJA5zhl1ofCAAT2tsDbNKT36jvpeTwk1gS0LTbZVRJ7qfZcSz37E2zZM+uqg7D1JD
	tZAJv2r17IfFEQZDBEjCDM8U+VTaOLFZIPNk1xYIZwgK5bE9DjpgItmmDEg==
X-Gm-Gg: AR+sD12jJw0KStyVn+TYBZDUiqLsTyiwZn3Fm68JuB0AwX3IfSxtlC+R6v2TxRa1MOq
	GIWWs6W3ttoaP5X2OTfh2+/XzzgGJVb835zZtxuwZrWXxeEW3ZXJGAPEj2fBTHAwxAaQk0lhNxx
	m7cnQK4LJqFDX0VB9jXuc0j2N47UdjjOuBFZMA9IcktzEUoF97i8kE9Xpp6j/U2V8limiNg30sd
	+1yAGAk98FruDsQ1XrygIKJr4C6hmD26UbtfPLRBjz8x9r7BZw7m4nF60GLBZw0eD+ix62gdufS
	GYfZPfGVV+QscA9+Mdwow8vSuRjpZ6lDfhHqxcL5/Z7AY+zqMy2KPwXXPdWExkcYNCvBchmZsBe
	sLWuFMEwttUnYSvh6pej2sx9BRD1QjSDQQ50N/Yk=
X-Received: by 2002:ac8:580f:0:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52d2384efdfmr7512761cf.21.1786126673284;
        Fri, 07 Aug 2026 11:17:53 -0700 (PDT)
X-Received: by 2002:ac8:580f:0:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52d2384efdfmr7512311cf.21.1786126672838;
        Fri, 07 Aug 2026 11:17:52 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cc3963sm79683366b.50.2026.08.07.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:52 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 18/19] riscv: defconfig: Enable IOMMUFD and VFIO
Date: Fri,  7 Aug 2026 20:17:12 +0200
Message-ID: <20260807181713.228535-19-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eOtymYgxrijLB1V_C1cG_9MIsBFmrYuv
X-Proofpoint-GUID: eOtymYgxrijLB1V_C1cG_9MIsBFmrYuv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX3d2HEhnRrsgU
 o9okkTo87sFR90XFJvUoXGKJFGWDCwEKhJNR7la9HfOxCpUMbpeOIpxg6NBoOueK7QfGvB293d6
 YoC/jAdcXgrkZMW6rvFTg6KnjMBs4u0dmmDg3BjpLr7DC1OO49TUJ51LT9rxVFEgE/+XWU7J35Y
 NIk8Lt/YF+Ogrmeb7+5P+7xuiPFm73ba6HsWfTofxi9+gtbGxJD21lnTVQAe0CI3rz1LR+FyUyH
 e9ozPB8dSo5DQQ8J+Zvvnr7DFpTS0aL+BB1Vg76I7UzKe8F44S2rl8SheyuN1UeIZHV0whj3Wcj
 Oyg7nZEUFoWlNcTN5xDO/XUHfrB8S3847EvjSXUsrCuRy5MV5PLhq+xTni+9Ln+eATHOeZJedvZ
 hi9ZUEN09IGPJDAeELV90PL1xsaEGotWrgUPcFjXDPEm4Rd4rMNgBiiGFsxU0XVRfy1Dj6fauJ7
 vXgPAstPDMyFBPfB//A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX5G33mDeGuO4O
 R/u9qOM6ORtIjSBDD0VCKXFRJPyoj02dcHDz8I0evPb0WTKIvnyzj81mzkQF/GLghcH33Lej4DK
 /5l397W+HJF+OhCWo7buU0/2/Y3l5P8=
X-Authority-Analysis: v=2.4 cv=YJevDxGx c=1 sm=1 tr=0 ts=6a762151 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=B9Crq1QHcyRNgBBHHYMA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

Now that the RISC-V IOMMU driver supports MSI remapping through
iommufd enable IOMMUFD and VFIO.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ed605b5e3162..bae9a0f32f89 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -249,6 +249,10 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_MMP_PDMA=m
+CONFIG_IOMMUFD=m
+CONFIG_VFIO_DEVICE_CDEV=y
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.43.0

