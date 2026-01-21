Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03623A8FF9
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974871; cv=none; b=LC190wLmbkvpuv8z/e1UlnQ9LfWI+nMsS6pPOeWq+jAKKSLEFXRpPfkeaBbtz6tWrSM1Hi77UYclBAHXmTIgw+SBlMsoh7KbY5UnhoIQf3ElLjalQH/Dhsyd3j53JaiJxx+U+Y0GtpqgD9+u9kEphSEKMqQ6egTb3fGDC2YNXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974871; c=relaxed/simple;
	bh=DNJDXPsUt1J6+u92cF2N8JlAKwnB9iuDYqHcttTUOfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSJodrNmDMO1v1eXOhAQILp0sORO4ivgMOmTbXU53Ygsd4prdGzS79qjXcvKB9w1wRsL5Egj8omlVpIlOwfLo9/XBcF11w7RT+YUzKWkz0PqJCN6Kis3KLH8zPyFcs2Nc8nv+XNhCnNPWy+YYuMF5KdH3JZF91oB1yLpgpepnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jt1LPo/6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8+lY4ta; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jt1LPo/6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8+lY4ta"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKj6XA798267
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=i6pPJkWRpzv2QmUHeIdBG2n9cDFr3LIvlRj
	x88PG7Hc=; b=Jt1LPo/6GqID9N4RIA0mWo/j9ZD9Poyk88nQpaBlfz5auBymK+D
	b8jFsABx5Y1J2nl6bZ1rKwUrh8URnBSdDpRX01qNhzsEXHOGc/kUDG7K184I3xNl
	QsFaErXX5JAC8sYcz18pjrxo4IYT3ZqOg0CbZrhEn4BvbcZQ/C6toqUqWc58nM4v
	Q/tLejPQIcfvpwPmzeLraoyUJXvDvvJWKtKeCf7wC3G8eCHNpBkYuU+HbO9yDoEH
	vLxDeK99Id+k2xJTuhwZ7gql4cPiwXc0BAE4KrCxUUKhirYn3sI8W/rdVmcwangp
	bAWCemOO7han5bR/4MdnEzxkilD+y5XnowA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q36u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:54:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f39ad0d82so11522008b3a.3
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 21:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768974865; x=1769579665; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6pPJkWRpzv2QmUHeIdBG2n9cDFr3LIvlRjx88PG7Hc=;
        b=E8+lY4taamnu5OGjg8CfZJMxfQ+G0EAeIy4DYWi8P1s5mBSoZMkWDtaxzv0UY1rN5K
         dIS9cEomyqCxQiZ3y1PN7eLBH3xlx/m94IlC5/AGDId9BPOJMgjSOszO/DR/mdjsM7JR
         Ux4oUtkxmLjtdlZJjvaWRHMEBKPvuAEZ1KPmQR9ZWlYfVNzBke5Cn+Pu6EMDqncVHGeE
         aHY16BM65u48my3fxQn3sBeQu+8HE2yGtVRJNT4LABjTwbgMM7M9aYUJzYcNOh2151ES
         QBda4H0UFH+ztd03TBE1oJ6R2OGOjjp98m/iDRdjtVK7t6Pqq3P2vaUd4Va+xoIcCwCX
         d4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974865; x=1769579665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6pPJkWRpzv2QmUHeIdBG2n9cDFr3LIvlRjx88PG7Hc=;
        b=i0gNY554E0AfrlaAanaJbVUGWNdMTXID1c7E6KxXmNH40UTrVke163oPSIYA/kv8S8
         EDQxsaIZqGYZ49iQzr3d5OeMygPlqZA8mXidYdGcpyYECThnGGNbW3f0ofY83S3J+jSw
         MY+cb284dzx8k1kscaAIKn03v2btelDfKqVQaNAjecW9Zj6RpRUS1sMQBpAjY+0sdxDB
         5lX6D8zv44gDKYU8LoN2Vd0840rCQ7UvHfX/uD/VxtnKaAG6d/kk7a/f+HyNBQM9wAKS
         bPEx05EojqUb7vWmOlpNwgrALOLPjlSsmCgbvN4EfpZKjLLbQDmf7MeS2CGXMBW9T04A
         xRkA==
X-Gm-Message-State: AOJu0YyoEn1HaFvxk1RgdeZ4KpHqZbgpB5H+Lo3B+1oCbzbih5vW961/
	sYZvtP+aBsdqNYUTNmUU8Mt+pOR6OEx3+gSFKngLbmTlp5FRkbPNTFBs+2e/LZBDrIDzmEgrEAC
	DAVzXlF8tYXMmDE4EBV94uu6kqjpyhPKVbGTUXuTKpA2agh+pdpKkOZeyyg==
X-Gm-Gg: AZuq6aLiuPctlmcNXsaiNbqCxVIqUmYJjAAVeSIUWd8TrjkoHw0EhcWbE4hR/xsrq7l
	iRPvhHp/vxm/IqZ1My7+sMvYr5kZlhctg5oh8VbF1/8lWcMtIGnbYNIUjER7h7lyOzl4aXvreK9
	WAU9FlazZNV4ljYXHXAAQqeNIBs4GdZDZO3ijw+LYY7nCnLkGotTY9IUi3PD67VbbzsPWyzMf+w
	A8RXl1P6m5KJmR4RwXjD/pU3R08xu+fny3EkwAspzjegqOY9NS5mfmtKAj+kibOvAYJvbx9QzQD
	O2MKyIj88q/Sl41LbYkJSStiSnfW2yWuafT/rdUq0B7z1IiURkr4XJszRqGtRZfU6Urrx7OolNW
	ZGFKveivy/hPoY/1RT0ts523kkd3BwikIkK8Nt8GhUO61
X-Received: by 2002:a05:6a00:8016:b0:81f:4ea7:91db with SMTP id d2e1a72fcca58-81fa01b95d6mr15826222b3a.26.1768974864892;
        Tue, 20 Jan 2026 21:54:24 -0800 (PST)
X-Received: by 2002:a05:6a00:8016:b0:81f:4ea7:91db with SMTP id d2e1a72fcca58-81fa01b95d6mr15826192b3a.26.1768974864282;
        Tue, 20 Jan 2026 21:54:24 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278061sm13831927b3a.44.2026.01.20.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:54:24 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v6 0/3]  of: parsing of multi #{iommu,msi}-cells in maps
Date: Wed, 21 Jan 2026 11:23:57 +0530
Message-Id: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=69706a11 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=bPDH9HW4QdDYPu8zaOwA:9 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA0NiBTYWx0ZWRfX8WIYvau84WDe
 8sKZqSMQZSI6n766V4uxljFqKeuIe86qEjs2qXIm2H7Ux/e5Ed3Dp6mtkkFeDhhtyyQrBF34bAY
 SJ2LU6rIieWUDvKzNFvFXJjI9lKvGwmQACb8OWGPCKxC5y8pMKdWnVjJZemYCSTeYTBp/oV3OHd
 Y0ocCRCs8viLMBpJntQKaNRvafcdrhSJPy6ayMKvFzQ6aQZ1XAy40mXU15/QnhhrXLYUjpcfeDf
 Tm8MG921MuqKR6VBXhfyuLLYolJeS0qOZYIummdG+C+Uc+79zVJa2G3AafzTH2bWxy1rJR/yiqJ
 k6UuT3njiVHkvghZObW2uKyx8LUAz/6hvZJjYP7C21LCqasBiGSNszpIY9JcYT9w4Ddsr66aRTG
 GGjNhTSllmVPcMNq30nxhcVZ1nBWIoTYiGNxnDDB21aJxL5LhZx0/QThuTza7XHzeM0Pue9XdKF
 cXockpI1XIWYYtxgWUA==
X-Proofpoint-GUID: MRRtLIbFC_75eYDb5zQTFCZXlAawoaFY
X-Proofpoint-ORIG-GUID: MRRtLIbFC_75eYDb5zQTFCZXlAawoaFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210046

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

