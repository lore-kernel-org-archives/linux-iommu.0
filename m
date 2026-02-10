Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B834A786
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718348; cv=none; b=nd3AuGv9vlATxwxZZmrKK8/3rHoGEo9NrnbU97RNti0fHcfdAnE2BaSpwV2B/jWV1tUbAC+mllZKo1h09NHvDmBNugtYvkqupKdKQeGR0nTmEwRVl7mDpQX1g2s+unoblX23Pw/qp4HRk1VU+cWjP+etz+qju4WQFWV3VIPXCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718348; c=relaxed/simple;
	bh=n9MmhsmrBg06BwA9AXyf4JpudzLUwtCHossabGgbLMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C6xMjKnd7xRj1RekgvnbhPixEcXj4ViGmTl9bBR6SHgOR0IorW9iW0/wPwTdrFbzwUWo98xf5Wg0Sy7PWNDtNeIVlroxUK+eSi+BftKXVHzEshAux8eVdQGbf/KbFtwi6CCISkOxI7nXVp3jytRCyJXRe+oRzvfFtxQXZwjxhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sq7PEECP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jmd82M21; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sq7PEECP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jmd82M21"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A756Px3436801
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3RJbkaXw9v1cGG0O6WIj+UDLPbuhKlUrIHP
	wBJQe9Vw=; b=Sq7PEECPH4B7zT49pxF1eT6alhcgovIMyJw7VB0hGXn4X3JzMbg
	/WbqLxe3FgATOqFDo27DmSHaCgZ3C0XcIe9RaULHZIlQjIxPF3Ainc6evYUrqZMJ
	fkbxjdtEkmXXawnQ3MckMQK26/aNoKtYFshD9FQMkYKNdoMjW5MBOEXPUz9Byy1+
	9DySGwUHb9Wpqtz/2Rl36ehY8J/BYbu4ERMweaBTTU/v+LAUui1UK8mR3vioMAwX
	df00hViWp18Aj5KtxrsHht+yfYb1XaJ5ypZkmzEgf6gk/Yf52/0aYKHpGS96ZJEW
	7N+HD5zqeH7nlz/ePyLRJCRAyDcNanwGtnQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7fevbxgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:12:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c65d08b623aso4188710a12.0
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 02:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770718346; x=1771323146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3RJbkaXw9v1cGG0O6WIj+UDLPbuhKlUrIHPwBJQe9Vw=;
        b=jmd82M21/14CrPMlT8gloe8bCspTKYnofwq/cjpWuSP6jfYojEinCZZ7ZKBexTn1zQ
         0HLOq/I9H/tg+fufElqjbLq7grlYsQoVFVGNliv+K5Xb2o4ARKjriZ8Y9wLdZcTc3UsR
         NOatP4qIR/0j0B9nLvLgWKLtdP2Qf8PHYHv8bS6lWSRkmEaTkHKKZZ5WhtzhG3EVX6xW
         JNchWoL0iziuwZIwDWPlYw9kjwOfC/bb3VgKbP9MeYwtaRhG31CoX4wMLUVC2/23wQlA
         vlPz65GR8ZD0arAXhJ+wQ0ochbhB+jJk3WlzTyEWXBBNzo155iRHlRyjAjXoeeU0umod
         kJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718346; x=1771323146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RJbkaXw9v1cGG0O6WIj+UDLPbuhKlUrIHPwBJQe9Vw=;
        b=YWE+cYhjspY9WkFWp/3RiHjhHg0k0X0zDQmJFCyAOVfH27avyzRRM+seLflmuUXKMs
         J8C/Xa8AvvRZoIl7X6be3dcyU9VQWcu2x2k42VO3OcwptNUZ/1f3OJrT6VxgP7yGWSaS
         ZxsLLx2Ylri9Z3QqpdG0pY2yUPQiOPQmSE9DrppGgPXm4vP+Uv6pfwVv/wtEncs0ZlRt
         PUfWX/qeC78pDIrk1m3lS53y+o7cY4Zp6dpzjVHevVZH8Mbol9K2vXJ3Ax6Z7Yhoe+5l
         2LFiFNb/Na90qtUM2RzZH+rJyTknr3srCDfMNLm04rIkwhbcGDlwgPkuqgrTvVX6TsdW
         n5Eg==
X-Gm-Message-State: AOJu0YyAqlS4K1XyIgchT/3ZLcydH2QCMXg3eey0NsKy610twVnwTj5G
	MPrn2J+jgeMdK9G5Y/y4lr5pdeVZ+RzJ4Oskhz4ePj1ZaG4aDlZbTz37Ag83qvaxmA/X20444kH
	6VSirmBif+779r/qxWntd2+ED2SmTMkgTvf6ZmoHSBbZEXmVWkwND591g8g==
X-Gm-Gg: AZuq6aLo1+fJRHN8/+n1zO6NEungugUw77j/bzbNhviPJBhb6k1umLNPv37YJDR/mmJ
	koKM/5VEe4ZHZ1wtFXQwTl6QetbBozK59Sh+LMUSIhrAUNytmeLb6DSO578rlP2xoty+N2DIWmt
	xbLw51kVyMit/V2OIHqN8065OXbv02v5eSmTR9uxAoQv5IAqN6Dk0XR+n/43G93wr/p4XcxKWbJ
	HdlncgGt/RMEXotOYct1+DvCLWe63mNMDOljYL76Dok2Mdkm4e3lw+zxk4LFMJk38xbHYpi31gC
	lvVkwz8H95kyM5p343BKEkTfjeyCcg6EKCHJYhIhQYdgiHE2UvOuUks7BoN18tUDhcXUayn4p76
	HleFoJo3McXXcoUKXDvoglaqdUFTPAvA03wyEKY6gStxPDOx9uctml5jP
X-Received: by 2002:a05:6a00:f93:b0:823:5729:a125 with SMTP id d2e1a72fcca58-824877f7ed0mr1584358b3a.30.1770718345725;
        Tue, 10 Feb 2026 02:12:25 -0800 (PST)
X-Received: by 2002:a05:6a00:f93:b0:823:5729:a125 with SMTP id d2e1a72fcca58-824877f7ed0mr1584341b3a.30.1770718345233;
        Tue, 10 Feb 2026 02:12:25 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441884b75sm14380940b3a.39.2026.02.10.02.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:12:24 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v7 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Tue, 10 Feb 2026 15:41:54 +0530
Message-Id: <20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i90NcA0NZccTCfsx7SeKC_FiNPyaP5WI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4NCBTYWx0ZWRfX3rD6heQesqEJ
 laOdc6ZlbUFfQ4O3fQSCCVWhXj50m5rQdBp4/tHipvtlLTxpnY2Tf9hCsZQN7n1NJYtQjk70OhJ
 G/zu/e8wTJJQBCV3BEY8KpMeVgFdxy7muutZixDp0kcr7RV3+cvxrMLjakYYmfmGxkUtYit+otS
 f2SXKNOBc+QGzwyrP/9b/QqLnJAaCe9GNfc7EuwGsQ4+wTarfiTlhFwn8QXe0entF5vZtrcA8lP
 LonqrvZ1Kren4rdMsU+PAR1EimBnoWp8wd5nJUjhrx2/tObLhnXFoYECdEvFoFIMmAQGbQOzpLD
 wirZA3iYDt6SHMEzGigIfFAA+RKCJCgYj/cOvd3E+6LlRf+UCQwWrS4SCIlY34gLVR2GCje5cfQ
 iyRGRDTlABDDpiY08GATY/0s3hbfTRJGy2qcFDvgwsHodb8Wpb3jFZsmNkc1XrnNjwj5VR/qvCs
 flbijxzmIpY/mtF5jLg==
X-Authority-Analysis: v=2.4 cv=F6Rat6hN c=1 sm=1 tr=0 ts=698b048a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=bPDH9HW4QdDYPu8zaOwA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: i90NcA0NZccTCfsx7SeKC_FiNPyaP5WI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100084

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

These changes have been tested on QEMU for the arm64 architecture.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V7:
  Removed of_map_id_args structure and replaced it with of_phandle_args as
  suggested by Dmitry.

  Link to V6:
  https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/

V6:
  Fixed build error reported by kernel test bot.

  Link to V5:
  https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/

V5:
  Fixed Build Warnings.
  Raised PR for iommu-map dtschema:
  https://github.com/devicetree-org/dt-schema/pull/184

  Link to V4:
  https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/

V4:
  1) Added Reviewed-by tag.
  2) Resolved warnings reported by kernel test bot, minor code
  reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

V3:
  1) Added Reviewed-by tag.
  2) Updated of_map_id_args struct as a wrapper to of_phandle_args and
  added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

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
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   2 +-
 drivers/of/base.c                        | 148 +++++++++++++++++------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  12 +-
 drivers/pci/controller/pcie-apple.c      |   5 +-
 drivers/xen/grant-dma-ops.c              |   3 +-
 include/linux/of.h                       |  33 ++++-
 9 files changed, 152 insertions(+), 63 deletions(-)

-- 
2.34.1

