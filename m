Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668523ABBD
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760006; cv=none; b=HKHr1UReYun6eKoV7RN4dAyAYmUWX/qXDEajp4E4jq2glQt4chtGCLbF/zWQxLHMXBfB5etWGODsg1lKqCkdMuSQOxEmsd6npG2vhwwz/ys6F+NNd4XYOPM5nzeezonkjEA7YG5yE6QUclr8I2Aq0Ozvrnj3rrjbrtnkza2RTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760006; c=relaxed/simple;
	bh=VlFSFWvHnQMGVVCrh3MMKzAZQDdauOFrjxddbturkt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6nRW8VkVI5SUauJMI//Qti99TEBemH6DgHja2pJD/3lU70VD+ebcatZ+7dQltQWwhHDnkd3XGe8SXFIpiGXUOH2yTNpwR5Zet55XmGJ0NoWBR4l40qSe++On3r4iEtG2cIWga9fb6yilirYAhYSg4KduN1kfAJewN46dP5N1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6bPl+vT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LrtJk54G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6bPl+vT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrtJk54G"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IDM8MV3246862
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Z7BCDE6NuBKjmTnS7pl2AkICTLrCUaSZNrs
	/2I930h4=; b=B6bPl+vTzyYkcmy+Osu8ma+nQdWIlIR3cGoNAOxlhv4otpIRqrG
	fTuhvY70dKXZ076m/Ld/iX7G5RKwzrk2xLJZJ0oyuUeuaIsGJFiS9sScl8Xr296x
	tEZLZACUI5v1V/u2vKhyutitziZoM0SUkhZoHkOIu/P/y8wKRv62+vHu91skSrsI
	OvfzZ6BrJg/aNnUWgcyljDLlxCeBhe3dKrT6zb9CwknSgAOVJPWaB4E53U+0WNTh
	KkPzc180v8iEzVdLH/putwHny/Ekp+Zli6qcBv7hjkBpmcVYSIizjh5pGcTz4SVW
	IWREJZ5IhyS1hxrXRrEoFBNeQj4Vym5Y5cA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2guju8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 18:13:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7f66686710fso6185320b3a.3
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768760003; x=1769364803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7BCDE6NuBKjmTnS7pl2AkICTLrCUaSZNrs/2I930h4=;
        b=LrtJk54GaCpwtac8nstT4pdakjlQqFTEfy6oQtQCMs1BwZtNs2u2fyDvHpZF+0mvx+
         y/Goh8pu/EZAOWGq8zErb318FqwaKvW1iMYe1IaUBtt5KkumZydQiilmEfHVW/tI7opx
         vWWICEmUBLNLEvyNQ51Lbt/gMayeNCPWj85/6TKIV7P75zkOl9CrTyLZC1cxCGTaHgsm
         ynxxL7c+CIgW3Y+X0HFMDdzHsKNzhq0IvBO2cO/s7imJX30GRTq51TTcwpyStsnFdGza
         L40JFvs3vwm84ukxGJZhtg3YoxVoOy+1rPIk0zqP9zJVXVoYIZ6kC+OZHHpVG3l5sXGR
         qHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760003; x=1769364803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7BCDE6NuBKjmTnS7pl2AkICTLrCUaSZNrs/2I930h4=;
        b=OIC/owEOzjsNBmOeACuvydpozw0eexIjesWJE95FhvZfHcOCukYfqbp7H8j4lS9Fdt
         rcm+rTAwRaMpE6nnXLkKESnKO15zzVkQjV4m+nZNPTY1s9IHRG0af3++xFyBcCrF53uW
         mCxZfaqS4ymPjlZO1ESGIDFmTJYBLZ/7+jHMur3gnfFEHwixZ8cSTsPLTn9a1f3OLmo7
         XzdjccuYuJTeGBwcNuNKch6LxU0pgzTr2mT87MqAIiwGtli/S77lLY4QDD/zvxIRYvTe
         rBx/1WkEQy+I+58P6IYy3SHc0FVIslpu+kbJgm4fm+8X5r8MjY3KMpZIj4x1cJXxSGKK
         DFCA==
X-Gm-Message-State: AOJu0YwCN5mUg1p7zq07pBhZBPpvoFC8HFgdDWLql8WANRDvTXMz9zhC
	0w7HcqiUKqyTttC25jl/vD9QAQqHA/liIHKdkvFTt5+BgJvEc7093qTQVadXpk2wyUSuQWkfyeT
	B6Ya5QNeV3v0KMbr7yNARsvUm77nurFIb31+K9OZbDCkblPzzmj+NqOt6SQ==
X-Gm-Gg: AY/fxX4DalZ1NRp4axqeNQQ25vTVCRupcyOCtkW3bSYX38GuTggrTkA+T0eEkKCpd6q
	0+E3UINgx9uPO8hudyNRIgg52alMhrFUufr6AFttii/Nk8zjImQe0vxvVnkUig+QreEbjDD2B+U
	vWNxXpvCFTsVkHZDLGGmy208gQTi1MrZObcklccj9hps0z+p3gK+Cf1r1BVyPLQ9p6Bj5u36h+6
	ZV2JiyQAAtPrIhnQRiDy0TgHqtXQjOgoIrmm63Pbn7L46Q7zM4fO5sylWWZROwFTg2FDKLGX13M
	Xx6UG41a/Bl22G0i2JVxQHXN6cm1qmfrJ+xCl89nQokVaWVQHTW2wr0tgFJ9c0PRMLlTXyyyaVA
	ek3/9GDwgAYhOLE1Z7MTwIIq5pefTAISVI0IqL/b5J/PS
X-Received: by 2002:a05:6a00:ad2:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-81f9f6a63e9mr8389035b3a.24.1768760002753;
        Sun, 18 Jan 2026 10:13:22 -0800 (PST)
X-Received: by 2002:a05:6a00:ad2:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-81f9f6a63e9mr8389021b3a.24.1768760002236;
        Sun, 18 Jan 2026 10:13:22 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm7070759b3a.42.2026.01.18.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:13:22 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: [PATCH v5 0/3]  of: parsing of multi #{iommu,msi}-cells in maps
Date: Sun, 18 Jan 2026 23:41:22 +0530
Message-Id: <20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX4P2ZLkVa+vys
 peXPyY1VwbkZfOeZllXhsfu0SrEn1vIjex8Gj8P/kll76Pmt/j2gsWq2/OUWhqS7RffSnRnl3G2
 TmU/2i2pTkmqWBp3vU3YViqHaNDpNjN6+fQqcMHm1DGhPBMCuOkH0rcX9b1gojnEnaLJCz99ZDo
 HfrjBO9QJRzoV4nOHEP66AB/2H1ulfReJ00QuQ8Tc/caPSfjUNkV4HcIAom3dpu+Nag+JgBCWH6
 cO01M8iLX5vgyEwwVPHWJGJDUWQvpAatuBDjdCk6I+nkyK0RAUOHLo56yR7EItDnbZ0dl3LZlZk
 vF97H14QdIDaTYMJpX2EZYVzx3L/CBpbzxBHDyF/GRascyRVAJ2rjrqBXP2QJatO47GlBFljXvr
 3k46hT/gfuC9Z0k26VdCpgxmcG6o3oNpaOPC0j5+1tjo8HRFPoWFtsyolcQ6lRjyKdHBnU30/1h
 UwYwxRmEVpDODAUv/8g==
X-Authority-Analysis: v=2.4 cv=Sev6t/Ru c=1 sm=1 tr=0 ts=696d22c3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=bPDH9HW4QdDYPu8zaOwA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mE0YxPO4cQy_4a11wSDDyQ6gN8Vn71SD
X-Proofpoint-ORIG-GUID: mE0YxPO4cQy_4a11wSDDyQ6gN8Vn71SD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180160

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
plan to perform more extensive testing based on community feedback.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

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

 drivers/cdx/cdx_msi.c                    |   5 +-
 drivers/iommu/of_iommu.c                 |  12 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |   2 +-
 drivers/of/base.c                        | 146 +++++++++++++++++------
 drivers/of/irq.c                         |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  14 ++-
 drivers/pci/controller/pcie-apple.c      |   5 +-
 drivers/xen/grant-dma-ops.c              |  21 ++--
 include/linux/of.h                       |  44 ++++++-
 9 files changed, 179 insertions(+), 73 deletions(-)

-- 
2.34.1

