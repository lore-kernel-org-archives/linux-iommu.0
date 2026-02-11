Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263032AAD1
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788504; cv=none; b=WXHVcNo3HuMvDPQEOYSu+lEFnoQO7ORktTPuc+XOzv3AR3UMh5AcTGwAoaf+1IWuT2aqJxIftt0TL9jsThtQVQrvOvw03+bsIBt2rwc9sq1WOnCYxprzEvA4aJ3lXgERe5j3AqIFWvL1H0zsTPk/tUACuBcV/1jbcCtqcF9gWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788504; c=relaxed/simple;
	bh=8Ascd7qDlVARDssM5L0tNXQ8Bm0xuOvsstgFiKGjAiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxyDEeJ769/jk/qWgYylN0V9iuZQCCl0uHS0t7Kd+6OF9+smWuslfrtnO0T/eR6yiHno8CLeOB0A84m2sf0O9ZDWQ7Ek7f9n4C4kdn+tcE94QjwBlC1YAIytE/OH5+X4BPq5Qyal/u67xnaLQOE5Si/O5TgOXPcxBMKdPHYiErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBqZYwxD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DiGLbhjZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBqZYwxD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DiGLbhjZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B2bXHk3203772
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+O
	HjnRbIZM=; b=KBqZYwxDlEuOj5b/TTcFCiY0fFIO/zLdtc0VLe3VmPoUCzn1ntb
	/EqqMhZ+UVWIoXjttedBkm6YHRCMpXrKGOO2KwU8YB/9WIAevhv9oHPWdeuI6PYH
	Z9oH4V4X44CIJ9RfM6RBmZ70RxajaEdNIkFCq6lt+UGKIDzf0k6uUJ+OTF7zT2Ev
	xFAPNcCGUbkCYlF2tuRkD6hW+gzg3aFY5gkTYJW7Ce1saQV0mxPIbaIJk4KiMnN3
	8q/V5lU0d30/svGIxyAvqHyvWMCWP8V15pvd2I6Jv2mVD+SI9u1qd2HZ/aFzhQVK
	H0QUhFlUSYlLegsjJsVAdldXFGbz6nuQhFw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c894g20ku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 05:41:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad60525deso94460075ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 21:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770788501; x=1771393301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+OHjnRbIZM=;
        b=DiGLbhjZzG8dxwTNSnK04yoK7/E4a6mP81VTuSGS79qfGlQZkrpojN77+Fc4UkaEr7
         NZQoyy7MaTi5ZbBaXh5yWAUWStAfGleyQSQItFU4eqEjqrgZkyLqrVyGCYQRjmXoeQhe
         Mt28wPWZ/2YQ5ScALEpHOtITZvFaeeX8UqtGopsCMtj2cQYDagHeCdSvxWwpMAaqWj18
         8jS/sN4Wh50tyj7nU0HiYW067MuGkG7R4dpxzlbIURLMbfzAyvmWkCLRRcHZahOeFvTr
         Of8uQ6XDHl5fWL6m0IJ1SgydaNDmtziwg80J4bIF71nu5K3yY6CiYCjot900t6+v4T0S
         Grgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788501; x=1771393301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+OHjnRbIZM=;
        b=J92oDEGi3in4wtWq4BYwe8lF8PZjnRRvaRUQom/gdFct5uaHZggJXN8oecUlX/IDx5
         o579vUvYr/gSDh9UHf2wDFmUm3frSnPTz2H4mCfOkHj4/6PnpJ9b0i35arUaNtvDrWeM
         NcLV1ADcsm1JxzdsUY4upoijsAskq6BR22vbh2myhnmVd1BjoH7bOgDATBEQ6VoeGA/3
         2gffo3ElVp7X/V0BipOHBKv+gxDhcLsDtag7mL8/Hz4i8c6aV8Awpu2Znk0frX5FlIPO
         tsZPwWkG69BHRANz3Yot1whJvvJnWJbH1c4VWqs0iBao6DYOD6qb/J378zhYJ5VjJBdK
         7c/A==
X-Gm-Message-State: AOJu0Yxzp7kGue31hSJHpEw6I/cud5wY43OctSCoqWU+kHy/WgfvQj+q
	gbpL8tf1iVa7Oc6MGnHw4vu22g1bx22kZ3a8vFh2vk+KtURWPekgfZ9uaVEE79Ad+HelM2HQloZ
	Tgiv06OB+xdKCAGQcOh1YaUNGZyfjiLcQmPl/+NP+7qyTE+z8iK4bzrATtQ==
X-Gm-Gg: AZuq6aIpMm5sWqbTksjOGC6TQ0+qztYLZrLNwLpbyEpOKmsiGdPZZ1Moq3E4qxZsEvb
	ZtYGwknToDlsLkaMAM5s/pkEMmMMWrHyJ++GACKC+V+7c6/pMW3qXRby4sAIujsvaeRNeN2vu00
	fPr20K97Hpapm1jNgmD9fLr8OsBGACY9KYSHuksgiZsNpu0JpnAyfcN0UOk7BWh9DMG5DbuOOII
	m7wt4+C1pkUKRERTNv25hTr1zt4zulM3BdxnCe5NGKW1RkmiAe8zQUOIaDv0kUK4N8pF4srnHiN
	g4Xd+Aiyz4lpwTXxUk01Iz/6aNNeigZIb3OvFMFXMj72T5hgg8zdnLXBUjd8IKLZXtALWTP58tw
	El+UaiPN5X/LaHo3kcwX1ChurNFFLoXkyyuHDZNMR/jH6gzn+Qo/8gXzE
X-Received: by 2002:a17:902:ccca:b0:2a9:411a:c5c6 with SMTP id d9443c01a7336-2ab2ac85094mr10787335ad.39.1770788500886;
        Tue, 10 Feb 2026 21:41:40 -0800 (PST)
X-Received: by 2002:a17:902:ccca:b0:2a9:411a:c5c6 with SMTP id d9443c01a7336-2ab2ac85094mr10787095ad.39.1770788500379;
        Tue, 10 Feb 2026 21:41:40 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986f0adsm9932875ad.26.2026.02.10.21.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 21:41:40 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v8 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Wed, 11 Feb 2026 11:10:30 +0530
Message-Id: <20260211054033.2796660-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NCBTYWx0ZWRfXy64Md0+yoppF
 2YvhXJUOzn2nXGwasoGpf2/dX7eSKukITw3MXBIvZBy2FXlLc9Uql4JOYIiabAC0gUxUmNIf3iQ
 DxqhlfhKHX8Mlj9UR//KvqltB7vvDgo7AvCxzd1lZGVEbSRiBSmDhAVjxLTSdtvudiQl3dq6JE1
 gLLHLhR/mUIS44EeumbzJtllk7fCwuONcQQ9QIleIuBtCnp5eMyVQ4dOi5uhSVVEcjASq1EiW0W
 qXn4G8sLscN/Eey8Q24keUU/YhqGv3rylyvHDNwVTUtXpLV5dQJTinHigo6v03+l0V+J6R8GSVp
 E8ezxS54uqwI4g6iCd3muvN24URmeQUV0gPVVEg52mZ6KcKUSgf87QGE6iouACHgwnNrBT6xQ7l
 hEiO/22r6tngEMWNLbQycx/vk8NpYE5I6x7ESVl84fYyB8QKhGOgJsDJU01yh2HDDg6Dvb8gkrz
 I06xJfxlfj8/EwQGPjA==
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=698c1695 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=bPDH9HW4QdDYPu8zaOwA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: h-Ad5gT3qbN8QWaFbK7fIWvO26cH3BIY
X-Proofpoint-ORIG-GUID: h-Ad5gT3qbN8QWaFbK7fIWvO26cH3BIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110044

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

V8:
  Removed mentions of of_map_args from commit message to match code.

  Link to V7:
  https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/

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

