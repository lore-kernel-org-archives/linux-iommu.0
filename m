Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879229E109
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842144; cv=none; b=PT1b1U9a0WXDRVw0X8czFUFt4BNUcYnonshZIfogn0hxFBEHw6lApmfTys3KO9RDSrQDhNaMj+j+sBL1i1n1o3TdK3YiYieDh/t+pITvuzZOljAjMeiVugUe07CJKBxkSYstbZoFc3EzWdKGWgt3P5p833OpE/QhiZbZ8FfSz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842144; c=relaxed/simple;
	bh=dYNYUjY6ikxZh56WSHbxDgmXCaZcm2S1pqIcbri6RjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8rYQ2Po3Dd2G+R26ONag3YmbLO7cXZu9sGnKZi30Ybb6zXdgTTQSMNwnT/AjxAkkY6OwSiiQ6pL6hQvBimMppDq4aKZyYJ2bictcpBk5ZXud+kyJFz9TluWPXC9rPOyFQtDmGA4gS/yZcCWGxbL4F8x4NqUOXoghWrxsMkG3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YUwsmk0g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsAluF0Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUwsmk0g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsAluF0Z"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4767u8515290
	for <iommu@lists.linux.dev>; Thu, 4 Dec 2025 09:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0CBS82JE97HEdddV9MujHpiyCYF+cW+4cfC
	P0rgquHo=; b=YUwsmk0gWpQr+TJQl2/ZVERUCk6QvjLsFnEx3aLHrg36h1gvhDW
	MKamww0EP/5CgwaH9KR+UgUkSBLBMR/rPCl7PeGJ4AXfDHdzJ0JAWrLzjR9APvUt
	dlZdy5UCYRtCp9Bf7Mtd/J64k9k7TM4WsmbFkHuuGAqGBc596c3/V3xCfoc0Ajyj
	7aVS5LTe5aMktgx2mZFYv3ez8bYvbmZMWVJjysOo9WHChveiAsjry2K0lzDTlBMo
	m2ZMgt++Uq/nN21kIVYFOcGrqyupsI3xXWkMxg5UulEGq8DWj0lYiGq4A572pkTS
	6vUhkWy0sWGbc/ybbt03nBsSN8ZmKffz/RA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4au5m30jxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 09:55:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e5a18652so9988545ad.1
        for <iommu@lists.linux.dev>; Thu, 04 Dec 2025 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764842141; x=1765446941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CBS82JE97HEdddV9MujHpiyCYF+cW+4cfCP0rgquHo=;
        b=MsAluF0Z4fqyXM1sCHRByRpNtdwBBD7+5hXsAc2rWgGp4/rcPP7T9wVydiezJ6KJJo
         bKE2cojOLKMlIKZ4zeI9/ziE6YEf0w+otwtO9vyklSlibhTECWYb0BGzyKluIA4KfE6D
         MZJzbC9wzsa4B529eBzedJBobKBNGUeGwdnURFbvw/viImMt/I5dycly1Cz1Oz6Va/qm
         kNgG+SaPBGJpG+K7IWBxoYQ7l+TcmbpernFNJt68ZVX1JA/YocT7MQmy6zQuNo3q2FVF
         H8SZY+ocWfzYutRTPbSSKh6HqtY9UF7uqijWRoeHnLG2T1lSGg29WnYkX5W1+89CdJbg
         w2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842141; x=1765446941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CBS82JE97HEdddV9MujHpiyCYF+cW+4cfCP0rgquHo=;
        b=vk5NgikamgQ/YahFJG338iZZlteTOUYcsq1chTfMU9d94FdPDs3czlgc/sSD0huWlK
         NbEI38Wn/3EeAFxx0bOa8OgMBbnD1/dvcEMkz48PSgWKX0DTnQe2tXmkjjzMtEeXD4cL
         +mhly6xuxNfMOT4qaLPvPNbHHJB45pk0YIlyDw7d64GCNhSYuA4npO7PHVzM3N9aBXbN
         fCQD7yR4TQAz7hXMXf6SsHinVrvpIGBmj2f6sx0aclZ6Ly7czbtpAzEy6icGxWab67q2
         2kspsE+7pRfAkNfGTrpcTsn+yTgkw1EWGJpHcAfaadRIgQhbYvplvVDVnwhF9l5NrfP7
         ma4Q==
X-Gm-Message-State: AOJu0Yx8u6Gvi+y2nEWBXY0WoHolhWt9tqLl9Q3mVd5tbAgPMCdPp4SM
	0X2lJJhfy4TqlP+7SXLkZ05ozTCf4hLIgFKicVeqpOhGRsJbuRMHsMvAaSgOorebifs+TbHCmyR
	BOCe8lqqEEkmGkzRbInD2ttfkFt1YeMN1994aPRdbvJSkSkZE6L48km2XXw==
X-Gm-Gg: ASbGncvOkQAkJskzR+AhRxQbKiLVJgPWpyv9yKo671rHHb11GNtzDgoKzEjPUSPv1mu
	UIwik0dKlgrco4OWJ8WEjs5/OHtUNkikFPFuDB9qoEce7B27oTXOfECF5M7CVpbNRPtOaK5id9y
	oDCUpeWhqJjJl24at+7Q8L4Kd9h6ER/OhJPD40Y4FGPoT0jOPY2Gy+yeYKNKZgOPgSd5NH4mAjY
	YkALtDxcvR5LUF3Wwcgqw6Rfs8YjdKsQ0bsSYeOw5HkUahsxq3bxxbrzzYJ8eM7Auk61wtGbyAx
	va9hFW1NjMfei+0usTFooG7DtRB/sPKqJAGrkorlk7jQ+XCrLy52SRWw2y0PTKGxlM1HbrmUV8+
	+rnYFKLc8o5AVbjUpWAA2BHm1fMvhrofYLOkKMnZXbEJk
X-Received: by 2002:a17:903:3c2b:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-29d9f5ae5b9mr29352325ad.27.1764842140532;
        Thu, 04 Dec 2025 01:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLmJJ1IqVAbpRWJYWX68AfdveHt+0MbsRDYek5+9K27SHrhh0a6ba8/TJ2nGMVM8HpcloKvQ==
X-Received: by 2002:a17:903:3c2b:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-29d9f5ae5b9mr29351895ad.27.1764842140016;
        Thu, 04 Dec 2025 01:55:40 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817389fdsm1380436a12.1.2025.12.04.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:55:39 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, charan.kalla@oss.qualcomm.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: [PATCH v2 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Thu,  4 Dec 2025 15:25:27 +0530
Message-Id: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lT2vLTPyrVJ8Hyu-yE315uPI3AlGSA1d
X-Proofpoint-ORIG-GUID: lT2vLTPyrVJ8Hyu-yE315uPI3AlGSA1d
X-Authority-Analysis: v=2.4 cv=esHSD4pX c=1 sm=1 tr=0 ts=69315a9d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=eQMVBvNRXY1Htgy04vAA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA4MSBTYWx0ZWRfX58udcOW8Sqty
 zLFujsrxeFnDQ133NgTZHUJfi705TtgT9AJ8Z4evpS/OL2si+DNVTb7+vKfxd/O4v1/W5jtDeAj
 FJanuP+3sLhV/rcusayfkpMTlI8R+8gtExQ9G5pMKr2NKtvbwDapJg3JyRwUzwFlpMqTdcCTy4N
 IZcF/uesOAYy2qdE3Gy3mne1FvC4JRqRwjgEf3cGNBY99n+zjV6tQs+14soPXi8f6l5rIlCP5iT
 lkkSUg8bkZMI+j1oHCVZz9brj2RteP6YBqx5JoQx+MIm6XE61TKV0tygkQdb0HroDQoeNeDbPPf
 bc3UTljmnR9mW3gQ6KP2sKCIoU9VVCpiG8ZME62B2pU/Nq6K3reGbIyNt1pNYJrmyzxsUhQ2+Om
 Wbrhz2AKBJqASploIlYxYX0nk6k/dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512040081

So far our parsing of {iommu,msi}-map properites has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1. 

The motivation for this patchset originates from the multi-map use case
described in V1, which will be addressed in a subsequent series once the
current fixes for iommu-cell handling are concluded.

These changes have been tested on QEMU for the arm64 architecture. We
plan to perform more extensive testing based on community feedback and
are sending this series out early to gather review comments.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V2:
  1) Incorporated the patches from Robin that does the clean implementation.
  2) Dropped the patches the were adding multi-map support from this series
  as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Charan Teja Kalla (1):
  of: factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
  of: Add convenience wrappers for of_map_id()
  of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |   3 +-
 drivers/iommu/of_iommu.c                 |  11 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   4 +-
 drivers/of/base.c                        | 132 ++++++++++++++++-------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  10 +-
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   6 +-
 include/linux/of.h                       |  36 +++++--
 9 files changed, 151 insertions(+), 60 deletions(-)

-- 
2.34.1

