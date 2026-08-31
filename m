Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8114FDE4F
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188418; cv=none; b=u2DA6NO9dtmjB/pb9mqJKi34FpxHIK/mGm225lcstxbtjCAT850CCw7EmlR6BzaBWLIRiqPStd17gS7g3WA7nkdLtt1igxm2x6wTHQKeJoYZRuKvKaFxuE9nvYlHpuByIHmtaBZqW0oKWfD7lYzuCB9kNRYolU2TF+xn6IJRz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188418; c=relaxed/simple;
	bh=oTI9lnA5nbjrxciBQ498nnak3FdH2n0sumiIJz66Poo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUOkvZXqAc/52Z82yOhee1l13Zj9sn4WpwJ4v8ZF+lcPYnrlKGXIr+LQrEj3Su9SoUcbQBa90CFvjCCN+ijPhJokMMPK2kaQuqUx6lHPT4kzLkD7MSgrk4MZ29Jf3am4WAdvZautUl8B20ml2B+IrLu7cEDm6y8pezaDp5aRIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XgdBwRPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aRqFPv33; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XgdBwRPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRqFPv33"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETTtB3969296
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sXxW/4DEUBO
	CwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=; b=XgdBwRPKuAeWSavL6oW2JczLZjG
	eruDKqXwZhkDW9VXSRqb7p93b8wMZmjMP2uWRLyyZp0d6Hi4f2lhZjpbhuRCgHyS
	wqYOxXVcdczKG6KsxWZqXHXT3bVm8wQ5f4ODYRGjv86K/rsKEBEdwMG6p/CcISGU
	rjgC70ovoDBe8V6y9X4wLg1y+/vj8GrHIRdsXrkHbL21Hm9xLJCKc57jN9+GYVPx
	JsHMgoQDJLRefNAjblb4tTe5qq4F1I3ePdl4d23XQsn69weEJmfOUVF95m9JUNc5
	Xhv4niPvSAnyS6eft7ByFTt6d3hjg+YWAXZXXiA3cpuzSVTKSrLyfOJUXiA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h91gyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so527874185a.3
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188415; x=1788793215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXxW/4DEUBOCwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=;
        b=aRqFPv338WxIW7RK+oTvab4BxHiyHMPjK3S8OKBb0zVSzL/BQJUer9W6/79Si8QWoa
         4JUfKS/ZwdqctUN5yCHQAzCt94N1jnQnCtjih7xjTGTo1KZfQVE94dvZ7xG9SX0IQxkt
         bkNwYzW2MRZUwZhkQCsuNRaTx7C5/rMTyCZm/AyG0U5SMOqC+ONtnQ3RSelwn/D7l5z+
         KRCnNAHPxhvTvb5MN0ky62zpoqTGJyCz25f5vhZM8yssx3G7iT5qqZCg/eKe4I9VCxLx
         iQ/D/s/5veii6Ft3dYtKzDkZ1kiOWjTdXYins5q5C6x4BERDs6yrm7feRZgQSK01MDsN
         wNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188415; x=1788793215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXxW/4DEUBOCwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=;
        b=BFwPX3CDhJXyqfNeZYEiKK4DWmvatncG9WNYtcEuS2SKsPjmKyauBJLKfdFMafC7HG
         +o0093cVh+K6B3gJKmHeYle3AvI/8D4zVaUz6FrP43I0sGh2ebQ3jPg3PFaurVQ9KlVI
         z2Aa8UQbrkmIiS5E/ppwOxMy7HyWm8LHWGaX2t1sWX5we7Dn2mGov6bvaE2JUpGtzUh5
         0hN48eeqdqz44kSZcURxFQJm0pjwitFIgSWwok5idgrkfbCnLcFu/i5QSgwCNpEQvmT8
         XLeh9HjEljmQacwgbqMquAtERdi8ORqLBNx/R5tpBlgfx2tVsX/I5S0IhsZu9sRYmkLQ
         SXMw==
X-Forwarded-Encrypted: i=1; AHgh+RpnqiB4R+6Nv6WiegZH+MXZr/6COHbn+Yefs3C7xXBlHTZDIZQk3TkxPU/67hDoeBWMgKGmZA==@lists.linux.dev
X-Gm-Message-State: AFuF++k3uEXDleaSZnr0NHhiisWSxTFYlFowWbHcbNmIVJY1GcOL7TUI
	pDlkX/DdHt33XrRtEEDiTSGo54uLF8mgqaH7OA/MTgYpUdXOM7bguEJsFjhI7cBz7N7TdWM3Xrx
	t5K4dfuSayHNxszU/kRl2khxFphR0LC7g8PbV1LLKBoOPbGAZxTtE5hhrxw==
X-Gm-Gg: AR+sD12UN/FHKDfovb8DeXMfgoPlUVaECt8W9uVrusW/wv0nkpwoXp77db4Dalyvsjt
	y7ZBfHpwabKYfksOT8mSqNv+gabRytbtR/xr9hNNljqMVddVOLyqu3GIudvzS5nJzzfR7god1pY
	OiZVfmOysVw9ujfEqYP0XJmLDUsVVlNZ0fh0xvi/DRAQGuSGU12CAjlNQF6t2WKji1cxQAnxgoS
	nlwPJgofGwcI62J64FDxP7XiTbHuoP49VRVTg+YuKTTsS1a98OH45dgCf7o+xi4UcPtq7JohxXb
	lQd9KPPJlpVwiBejmFA5dEk2Kf9eJIHLiIK0GGCalg8rfMzkigv9kwEMITD8vDqDxQTUOGv2SgP
	t5eTFhFrz6fw7JL8zZqWj2kd2xhMT/1/PJNw=
X-Received: by 2002:a05:620a:f05:b0:937:5ab5:53f7 with SMTP id af79cd13be357-939481bb845mr213389485a.43.1788188413221;
        Mon, 31 Aug 2026 08:00:13 -0700 (PDT)
X-Received: by 2002:a05:620a:f05:b0:937:5ab5:53f7 with SMTP id af79cd13be357-939481bb845mr213370085a.43.1788188412396;
        Mon, 31 Aug 2026 08:00:12 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49cc61cfsm414356655e9.6.2026.08.31.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:11 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 16/17] riscv: defconfig: Enable IOMMUFD and VFIO
Date: Mon, 31 Aug 2026 16:59:42 +0200
Message-ID: <20260831145943.313726-17-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a9596ff cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=B9Crq1QHcyRNgBBHHYMA:9 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: mEHKux3mJOibqIgIAA2jaDuERNg9pXNF
X-Proofpoint-GUID: mEHKux3mJOibqIgIAA2jaDuERNg9pXNF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX2OL8T+MQ5XaC
 RvqtWNL8NC8dRMRZpYrjg/olpWT/mCWZYqn4IZWpf5sbnxo0lgb9dCUAaDXxzqlW/IIMuYa57Y1
 tr1DdAt/LS8NsJvrdNIhlgQxWY9w1zY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXyHw2OhiMbgfp
 xjXRt22DG3xm9mWXjquJ5hLtg/94gur9rUcEos7M92BAdd+VWHlVwi1k3+8wbJkcHrz3XeoD9nK
 PB2fzY8YWuPKFwxD3/JFQ1srvvdpa8U4Y4INXQR235dMmCDB5+9qoWGBwfixeOPs1Kj4l8+s/98
 K6QAZTfCe+5Bw4tt8iU2PUJi/CAlEcUc7liFM8pCnktVOXpyIhBFBDS4HiqUrpCJdfM4CAqdCsJ
 k//0veGJ8j3yM+/g0CaOJ+inKQDenTwcJBkDPC4SzyzeBWYI7Y/Fz/FXj9IugUmCn40ndhmwt0X
 ZpyJoiIqtqidGgbSaydJ2kJJa1lGiWd47fZ4bjc9vxT0bdAcbs9MYmHP412bCSkTWrzHiQnuQFU
 nbSqGa7duuHZ+UDlOELWDu5FxvSd4To+PqpvswNOo5ephhJV+Xv2ZufONiIt75CwIQaaloaZHON
 AZ9WUQb7MXYQfBNjm0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

Enable iommufd and VFIO in the default configuration now that the
RISC-V IOMMU provides the DMA and MSI remapping needed for userspace
device access, including assignment to virtual machines.

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

