Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF06379C57
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126669; cv=none; b=QzC1zO5+z0z/zlmz52Iyo9S/6vKChoQ1vhXrqvey3mXXfrFLbVxTfYv0SqVdy3/1G1o7KHxQvDwpAqCcNluiedjcUEV8uEN9QeQpA2kZaNMzl/7eGIGvS6SBoB4mJEzahEdqBeCu9IFI8Q05ZHSe1iVsLC9F9+LBGEpZWbQFIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126669; c=relaxed/simple;
	bh=+ofXmQ6aEwgY9wsAg+7EOB4x9r9B1VPmqlK+pXTFlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+VeW/mewpiAaIpf21lpPggoZHcxF8rekCwR7TlgQUhRMM4X+joUd0SRpFFMa16ysXHW5Ybr8WopuwybDt3z7PezJTdhzhIp43PMr2byYcGJKnUGR7h6qbHSTN8Y3PUbnkpgBTaeYw3EwV4wV5LYoe9C12cXrZSasz2r/9la2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+7lVxov; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+sNfsBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+7lVxov";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+sNfsBX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOCvA2039882
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CZ0/AJS5lrL
	G+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=; b=H+7lVxovafJdb6/bh78wXlTxnO/
	hxXuE3v7qmmZrro8zMWpWWiuMhTOiW9VM1FZVgN5KUoUD0TpLbdIdJW+GL0HxQv2
	hjffmFWX78/JOKI41XRPBuPOnSxNBVlkl1MlDXlvugK+TMKHFNegWB8zYB4BUGAZ
	J4nT+WTr0hFh9rM2mYOAy5MKLYmHGSzcgIQ7Xf7tb8dKG0+MGTVK43uhbqQte2AI
	Z5dE+eMW7ZJyH6FAfd9dpQ+DQOm6Lh4UiQXFsGGUiARSOaca1twoaFKSh6+OhwcU
	fe0/iQlqvqivY5aHO3caKY7AOyWa4NIRBJ00RmaW76gCjfpFulKklqZHkhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb2761-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e38fbc5so410988685a.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126666; x=1786731466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=H+sNfsBXRmGNjEeQPxY6PA3kC1ODOQk8eHbbb36Z4INOCDupDQLYpqx3dLLEWzgUGn
         7KKy2JmQLF1N9Vp7J8Ou1/Fy03MvN3bDERJ+GxsuNRED+cZiiL1ygVLC+f6N59nOWYSf
         KeQTtZxpGpb8MgCkC9Kol6C7Yj8+DKal+iqXko9HVRL24+ITStCj2za3RXRsemdukMHl
         Hi8+EjD/uBRbAaAEufEXitD1JF2rVcwrqDp/4jGuT/1C/O7QLny2I2uOhbWe3kxlQ5Ci
         X+UWXICdKbrK6sIrzex3eUQv2cHSc3HdE7mcgFTiGWkqUdOEi7XOVqKDubc+DUy1Nz8f
         XM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126666; x=1786731466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=GgOUj3zEQII/wyf4N94mIceh0SsWK4Au9hfg1326EAWmJeFKLxxQwGA+M4qeziUpfu
         /uzE4j8qk3d/JtAPlJV0J2sBZRGC+K2wXS1yYdjOXfCy4k6JWUPuLjDaTADph3gyE6bW
         YAsaftx0tOL8PKK6iihSWPp2BagIZ7vbh/VRWJwQEO1DOj4mpcZ0ZHaSDmmcrYNyK5dv
         ge+Glvrsw1ibM7TB8G14aptjDv4ekcPd8CEdQD6GYTdkoneMHXBW3QsPWgP40FD5yufk
         3nUkNJf6kMFiWBtrZYsKvDwRacJiGde0LGmgmkearyjjpJ7wYFWc8nmUubB5SZ5e+cnt
         ODhg==
X-Forwarded-Encrypted: i=1; AHgh+RokOpULEZPj33wSHFHfZe7eWNfdMf8UJAUcjHdQYBT+onjONC0uta9itqZ6NCD8e8FnRvQyAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/FpRafPQ/mYsptUOgbtJdaSUWq11bw/IkF5kdZLCGMJBIqLW5
	NV93uheozpFhxt0fCh5kSbos2nV1Xl602ZRb0zlx+HlNa+GYgPLsoQQM6m760PW0yGB7SKYlu1n
	GAwZ+ePMqyRBpdmr6OK5rFcTbppgQ7c91wjKYQjqVdEM5qa4nMidfmOheSg==
X-Gm-Gg: AR+sD12PF/9/x3wb8W5KzNFKaIE8iYuFN1qWS6Kv95p1KxXX9iUJ+QSeRVvitr9T3uA
	zalvAAF4yMAK24+lkF3F0r/iEYBj8sJ+wEf6IY0MiUEGOa8i86wODbuqqkscGQ1PbDnreEo0Yo8
	aAr0naJjV4Tj8/kPllrv1vDPn6iJ9yljbnceXFgHvfPdH+/6m+BL9+nzD/RTo0FcT1fyPC6olbN
	McBu+GgplLlfj1hgR8luRFuwLK++OOXEPgva4T0NKLssfunLpdOpxt/0f3Mc+oIdCcWsGtQzXbZ
	BaLZXjXSZk0YSJlH3syvmdOZ6HS3ogYdYQqf6LTkAmgRwanhFYQAad0Tq/Ep+5iu7l0Z8duRtGu
	KuFw0pqf8e55kRfCWurKMLDiTdO9hp9JzvYg36vQ=
X-Received: by 2002:a05:622a:229e:b0:51c:1ec5:d00 with SMTP id d75a77b69052e-52ce622e53dmr287585891cf.44.1786126666431;
        Fri, 07 Aug 2026 11:17:46 -0700 (PDT)
X-Received: by 2002:a05:622a:229e:b0:51c:1ec5:d00 with SMTP id d75a77b69052e-52ce622e53dmr287585251cf.44.1786126665899;
        Fri, 07 Aug 2026 11:17:45 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a79sm81544466b.11.2026.08.07.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:45 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 14/19] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Fri,  7 Aug 2026 20:17:08 +0200
Message-ID: <20260807181713.228535-15-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX5h9CNyL6WVQE
 xZ201EYewb/0sZErXkYoGK2hbIRwAM76j73LyVv8QS3Xg9d2qbgITlBi6Mt5mSA6rrmyC6q+kRV
 dVfBYERd++CZfByVecLjnrKmD8sgaL9wX2iDLq8QgUlPndjcSrGfBG2RXKOFV/LTREbiH3VXgvQ
 l0/Piy7SdydV2+JTVMK1bVguRsaHsRCHjHHfwS2PBvGRB+gEtQRptgWsUpIqiH9FmwnnPjvVleP
 Cn4hsdnq+hGfmGCcetOp20DwaHPxrq/wWcG7WuU9xqRqpH3IK0s03yBKRZGHiA+kzgCEJAL1xVK
 6iYqMY+32lyH2IqT1lDt7l+LRNZZ3xki0Em4E7StKw2pe2o9+LaXhluSmPRVzhBnkcU4pdfwv42
 UpzZ+jkh5o/vwdEx5Z3dLvw6b5XoyiyAkDLfvah0OyRIkrjaweZ7AIg8hD0mwgTZqhrHJEI9qa2
 YnnYVHg1dNbgURwYLuw==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a76214b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=vvBRGx3AIC5YeKHJuXcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX8nr3FaZYNtEA
 H/qDCu6J9hlJ9xUwyxVlI7ou+ULT4X8AnfLGCpZa5uGhfyLOW3Vj7xx6fhhWrJDw5dhz7HVgFHf
 rYk5jJ7sRvmtEMrNmU7fhQiXBrE7kv8=
X-Proofpoint-ORIG-GUID: wDGbIQrEdRci1fo41seX4XfnyWgOfWpw
X-Proofpoint-GUID: wDGbIQrEdRci1fo41seX4XfnyWgOfWpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

From: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
IOMMU driver supports MSI remapping.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6e07bd69467a..1c9f2ad10f36 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || (RISCV && 64BIT)
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.43.0

