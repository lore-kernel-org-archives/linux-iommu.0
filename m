Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3C42317C
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275424; cv=none; b=acSoxaQ9RUPonh1cZcSODC5BuedkfweElKVwFaDaLdIwX4dLiQIaUvk536desfDhyl0kcnU1LwKB9059ZXytCmHy0K6402i2K7FNsBMuKdIixNgCYit+20+XdD6IQBp5+A4JruTEWMutVwxYSA6akv6S+w53FdiAvd4Qozagwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275424; c=relaxed/simple;
	bh=7AVn6choG9U1fLKMAnVSJ1zfVNTIb/y7AKxs+8P5jUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyFP7E4wxgf0wtVgzJKf6xZBEofwhGXiwGYj9KOGI70C7mgXmO0o6w0Mpcx28ncPT5h1LZbaYbS79EWIw0NTQ2zInu+lRHOtSS/6+S4t6DoHyc71R5GlX2+Ful+tOxay+qmmZRtP/p6U2n2p4UeSFyJhWLsldSH1hGvBFwvzrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QtlXwfYW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K5V1S/ZU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QtlXwfYW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5V1S/ZU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648L2X47852373
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 21:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PlbMjBqGuJdYSGZkU4MUuEB+aZERXuCnNc/
	qXM66qQY=; b=QtlXwfYWM7+kz54uH0JcGtsMF0t3FZyRYSgq/6H++zDD51S2g+P
	enSb70kvKijhnz9MvhXsqvcACkwJ0DIc2utAKbqWyJwMF85CXY7X3vafZFweAJ1V
	6xCyRdEeh1KLs6G34MHF2RJjTjcGllFkuniTvfY4p4ftjhnQzaISy6oluKiuaxOr
	u+ZjR2oA5K2R6+cHDMxirudnGmGjgPJ39qHmabTQVYXVdkv8Im+AQjvjTaZq4c6f
	CInbP349r/xm0xnfDprxKo4Nj+n+LEEw5oNC1zO1lvHIBcwGBp+44UV1PPpxnS6P
	/QD+xzIAH5vmVtQPBp0WMYojCEEi0O1sf8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptj040-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 21:23:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee34588671so3610142eec.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778275421; x=1778880221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlbMjBqGuJdYSGZkU4MUuEB+aZERXuCnNc/qXM66qQY=;
        b=K5V1S/ZUiQQD1gldbZc/7RB2eoqzgPmXQMRtLWTMEml0EeJtlG/5/K8ZgrLOxskNkO
         E6mQU5r+ibkL2a2Rgt2aK1nbnwg/DkG2fr9Ng2YD41WC6hzyTPb8VjNErewnAd9lu2Gd
         rU8jhGgwf57RMJr772f1kr+VEOYXtVsH/KFLInM2TFCyl0bX2pFJIcXnmDZvmo/JsGpr
         Vf7QBLpvEfiX72+SAiST+V9htwr2iTVflnzisXjDau8MGokGFWLJgKTUoUNmBPKOyaeS
         awl95wUTFqConk95BXWgjQP5A93N1RGTYQ5qV/6h6DsXcPurG2F784IzFfsl6+pOOgaA
         I44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275421; x=1778880221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlbMjBqGuJdYSGZkU4MUuEB+aZERXuCnNc/qXM66qQY=;
        b=LqrYqhVnZDHp8E5rZhKKBWxvmAj18UwptPLNoHkrDFLeRijbp+5pAvtzcXyzh1Nfrs
         +xPSPjg84lav9irJzn3yl5vxRaFooYM5JfJVCTkXJ8fd3xTKXs7LLFaJuiMW+MvBeAsZ
         3uYlYRlChI+U1IXpR3gNpO2XPmUkpvniHNqQ5FQANp6j6Ee8/UPwNiz7JY2XE23c8uI/
         wk5m9YbYdooY5G2jTA1HTJDye+RmD34mnUHjKgWQ0IT6ifjKb0TsBEbG414P27nIXvjK
         cVgpEOD6B7ebfe9vbXh21ZFHZaY3X1FSzDYYlfziafD91Af/pxvu2gkhevPIqr39FRaz
         ukpA==
X-Forwarded-Encrypted: i=1; AFNElJ+YAWP0Q5hYWJIArS9pL0nb8zcoeQmsaNV5Ib98ZK6oCBYkQdvfcqJBW5wNAa3bSDzfsFvk/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZaceCe0yr68vEgi18ikIPVNnZD/sHiWFk1jn+C2YZWinohHW8
	A7xf/lFOmnRWcdWWmDwqBtOgHQnlc2OogMJpqa1A/UzJS4oxNAtHOiglx4CHoKbuLQ+3jt6I1Yh
	fw4aftjZ73o2lEwza8I+mABo/Xl4+ivlITRSvGfzagLBdTp5nJKF7rB7xdg==
X-Gm-Gg: Acq92OGk6tSSWWc0+ObA+PCsN7upr/jGSn1tFEsxEqM3jasBbnQIIwxB1z/SJTAAeLR
	p7kUh76mo4yvPTr9WPX6tP/mdhu+rsr9QLOEA83Ad5jeR9p3fuWGk9dHDXNiRk2AHL+HspJ4Pr2
	YyrollFYG2y3PRYiIbDmSQufiV+DI7+NRl9EAwAMfURXjcevRZMhX3F6/6dXKLdS19xSQQnDmmD
	FkgseuHg9yAv7Z5RYta1H69jLij6HzFSdHyhowoIcgERuUAQCIUhZDwqstf3GAfDB5b6WNqSJPx
	gJRe/E4hmzbl578AaaLPBSCi5CRgEJcuv8tkuKHW68AYjX/eSQnUH+JsA+68UsbK3sQGiA4W5g7
	c3FJX/DgeCKcNBeuNIAsYWHwUrD2qZkY=
X-Received: by 2002:a05:7300:2216:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2f5482663b5mr7637739eec.2.1778275421245;
        Fri, 08 May 2026 14:23:41 -0700 (PDT)
X-Received: by 2002:a05:7300:2216:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2f5482663b5mr7637721eec.2.1778275420681;
        Fri, 08 May 2026 14:23:40 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm4075754eec.2.2026.05.08.14.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:23:40 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
        will@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org
Subject: [PATCH 0/2] iommu/riscv: Enable IOMMU_DMA
Date: Fri,  8 May 2026 16:23:37 -0500
Message-ID: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QlLST7BVdWRv7SzeWn3V2M8ALOovgVo3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxMSBTYWx0ZWRfX6LqskK3WRlLy
 r14MMViBeEbhlPpi4jS4EyXJE647Jve37ZmdDAB1I1NjMLc5yMJKhjNMl4nR28s/ArHYJQQya8z
 oEHYRfaIziUG9kkO+0dunTB7hjoj2OGOlzu6NlWbeSNTC+LtaRJ32+OsPBnqiuha39N2i+ZUho7
 TzSGqQuGHlOX6FifojpOpBu0KKMCTY0jum8Z32AoBFQIQI1D5ReQxes5lqUj4fzlv+IQmS2VQxb
 jA1OzjEjnqTAjc6ARyAl7M4TrnOLJq8mzDglaxmILbfftUFweOn8YN41WejFr4NQ2UxPUBm8J4E
 ZJllCiueWv7dLpa5cBw2B/oltzGY10S22j/t1Scl0mparFzYVF/GuOv28DeaG6pxsWI2z3IN+dE
 tPvcoWT93f9K5AeW3s2DX9ttosvL9K7dc1h2pzQWQF9pPc2ijynjLZTfCHYQuIH8BqO9i+44jBq
 JaJmVBiThdRSllAS9iQ==
X-Proofpoint-GUID: QlLST7BVdWRv7SzeWn3V2M8ALOovgVo3
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe545e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vm3i78yGLUWP3Dov9wMA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080211

Arguably long overdue, let's start using paging domains. One blocker
to enabling IOMMU_DMA was that platforms with IMSICs would fault on
MSIs - Patch1 handles that. And, since QEMU is still one of the most-
used riscv platforms, another issue is that commit 69541898b71a
("iommu/riscv: Enable SVNAPOT support for contiguous ptes") exposes
a bug in the QEMU RISC-V IOMMU model. A patch for that is now on the
QEMU list[1].

Rest assured that the irqbypass work will get a v3 posted soon. This
series can be independently merged though since we don't need irqbypass
to enable paging domains and deliver MSIs for host devices.

[1] https://lore.kernel.org/all/20260508205129.377032-1-andrew.jones@oss.qualcomm.com/
 

Andrew Jones (1):
  iommu/riscv: Map IMSIC addresses for paging domains

Tomasz Jeznach (1):
  iommu/dma: enable IOMMU_DMA for RISC-V

 drivers/iommu/Kconfig               |  2 +-
 drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h |  7 ++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.43.0

