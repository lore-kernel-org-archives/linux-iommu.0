Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59892271468
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091952; cv=none; b=WAeGX6sIIUVQzh5Ubm1EOM7eDJlYdugDxpjxaE/rmCRgHeGbHluakhG2meaWX5odDrUYzKFduqI4k+Pelkz05Ra0Tx5BwtbjO8QAlgkWxtXkAMnXNBW3ksIT96VlCj+4cEsJZG57HLRQ1W7TzT02G2mqgARhLrKRWWyLDqxxmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091952; c=relaxed/simple;
	bh=8Ascd7qDlVARDssM5L0tNXQ8Bm0xuOvsstgFiKGjAiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oUwPcuVLWBWX+cz4jwjiWDUFqrrY3HxeiBU4r6LuUx5P7OehXIzGKJ5oz2xpC0NrcSMmX9Pria56KVcyN6P8e3srDkzuoZFbybL/Kt2iyCUdvjEn3N2B4d1Uy6aUCjB1DQU40/JzrBowYULQir2WBfKC2fCiLUE1ulgdnFVBE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TU5UXh7k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CFCY1PH1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TU5UXh7k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFCY1PH1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4Vl3d1280887
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+O
	HjnRbIZM=; b=TU5UXh7knE8xQJ/ifEepPS8U5AFVtXyfM9wf5lZgq3LRAuJvkHy
	n93df+lyNnHKs/pi0V376ap2kbN5bh//yJQVol04YOMI+TuQdyau6bqwV9crZfdh
	VqR8Fc/JAFdWCRVCvxXpkgk80iSaEf3NJTj9Yq6UmZP+FFNrlJnPZSqFlxpF5smx
	IpzpI8JyjhPC8oPYz/bDQSqk0C3CNRCS7zbAbNx9ezlExAyooAu4n4siBZJiVJBf
	DqzFK7bq2FMXAMW/pFKWDPyTuEdkJiFb4g+2foNApUvKHV1Ga+7//EwwpLzNNtkH
	r6xZX8iVcKIC19TFck4D+5evSvqdJlpJ9hg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chx39krsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 07:45:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354bee18a62so367303a91.0
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772091950; x=1772696750; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+OHjnRbIZM=;
        b=CFCY1PH1/6+tqvI1H8S2GxVqVGt9HobjdXTdCuZbeYSfsyzPqOs1Ws4EZe3U9xBZr3
         CRivokp2ExtNKvdxN3HzuRt3pj2M7AMPWn9TmmkVJQgobSOt8H3LTKmZ4CRv5n08UGQM
         vdH+5yYB/mwrtAxaIYs4Cabxzjf32l/e8uATMMLoNie++WArqE/PT7lLRQb3Tk0WcliK
         UyAAXvLcAMJ5FtEUqUKa11d3IX0POJtarygq3QazsJefRRth35LfY35SW3+Dsro7yr3+
         s+qgGH1is+VLZjHRF1nWs6t4E2AJdnHZS3gJCkWiFHeY9vTiakD3Ud6QFcSMuOYZL2r7
         RtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091950; x=1772696750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuCQoAKdi3KuRHJyXKcVDZr2MMU4Vod0X+OHjnRbIZM=;
        b=XYp6fsUC9DvIQG2tf/VMElpeFHOwk2vhY5ChKfHRRgy9pzcSG6J++pd8SVMu4rzL6g
         p/+6iwQ+tat1MgDRVLvP9B3qdrOIqkj7Ko9J8zWz8zAIInLv/2YGP5NlUUnJkLTKsJRV
         DwC4A35E083RQih9xpxtKaAfDz9eHeKneR72wzeXsEAOfFYtc8LzclI1keHxL1dY8/sw
         cHvr/4wKTAN8Gz8fsX2CFpMX126w9dnYXnWvFc5XKBi9d6AKWKt6Sce480Uyfbj1+LLr
         sX/G8aHGtzrXPs8KwPEFMV9jbUiSxvUlMLL5NdB2i/9fithD7xZQLUnU99OBCPkJLtYY
         Dq6A==
X-Gm-Message-State: AOJu0YwYrCD9sRRUp91EikrZBKLQ/93ebhW+yMydJx5XoIPO5K5n3wt0
	A+mtO6V8D6hyg6OayVBkBo1P8WOM2Zj2TpT+U1by+Ku1WdIW1UlzLeOmeUh18k5bL7OshOlOrmy
	vJcDjA/yS7mVRswYQTyplBsABxaOEhqkqhsB76+8UMFIBzVF+QFJR/vPW4A==
X-Gm-Gg: ATEYQzwc83Mra6T/yBdWhuAc+jSdQD/C7QoMUu8+N+aCX0kfAH8ubFNBbYj02G+iuGN
	U0mOxW4YA4To3l4GqTGx9j9kFYg+9rYLSb4aJ4d83kXgU/UFU00D6JChvzCzDZUQWhvW1krvlEg
	APmFUiwTmXHhWk7zqE+Jvu5X+MJYj9KPLk6wvAkr5fxdCOzTSQdFI0K9EDwKcY9euDMZWESio+h
	bisEdbcVTfgb8GsAN/12rQO8uhcdIU6aDtR4dqwfOBkC3VS1LDgJZz/0EFJpWcfi78cN37YyWza
	r0jZ88xlmZB61smb9zmTSAcgtOGrCw7A4yd7o703g9MFq3tp/KUnDSjMLtLhxfagE4/CIlEbQPZ
	8wqWFIWuxclikwb5gXwS+p+R3AsQpTMm1tiN4fvGAbSZb5k060mZmjmM2
X-Received: by 2002:a17:90b:57c6:b0:354:a332:1a61 with SMTP id 98e67ed59e1d1-358ae7c3536mr13091474a91.5.1772091949888;
        Wed, 25 Feb 2026 23:45:49 -0800 (PST)
X-Received: by 2002:a17:90b:57c6:b0:354:a332:1a61 with SMTP id 98e67ed59e1d1-358ae7c3536mr13091439a91.5.1772091949403;
        Wed, 25 Feb 2026 23:45:49 -0800 (PST)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359034bbfd4sm4891168a91.10.2026.02.25.23.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:45:49 -0800 (PST)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [RESEND,v8 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Thu, 26 Feb 2026 13:12:42 +0530
Message-Id: <20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2OCBTYWx0ZWRfXzwr72kdxqYaG
 IH6MxZ9Pfv+ueQlh29c6ZnU1NsE+sTQs8cTHsNG128Kn5+2vyhUetQj8V/I6QjZ8uHcPnK1NxRI
 t25C87IoJ4wSRkzBt/OiAdCXcnmWSHZVtY5EJVEkicF6Au2jDk2CnqizyMVFOqzCoRuXA8KTD9+
 43O37y9EzckzqHB53205mv+ojHxZMvo9eCRYMbF6H2AKkw8YpxtBuc1Uk2io3MsMqRWOvVZk+IW
 W7bNFZxhoBVFGMHqx/pUAUGH/3MaJ0phbLkagZC3WmHwgpmHNtskmEMcTUL3tGZgbkh+61GdHhw
 3jn7Xzwb6a+NMjWG/Dmf4pB4rbmMf1mIomvMkRKcKqQ45EIDwEiVV32FBZz8/dACDm4GGDCC1o0
 FBnwXMBcoFyLNTtrdK+hlV+Vg4+z0+/Fom2T7fKSk8ZNZg6eegY6eNMIhi2ZS5HQEZLY8W+RtYx
 V/xY5ogXX7Lb4qup0yA==
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=699ffa2e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=bPDH9HW4QdDYPu8zaOwA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ikTQ3t5Pzvh8HL-9aLNIGrrCDbWLte8v
X-Proofpoint-ORIG-GUID: ikTQ3t5Pzvh8HL-9aLNIGrrCDbWLte8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260068

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

