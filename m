Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB03BBCE
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480013; cv=none; b=D28AWKoUoRzWPYqV1ZT32HeKuZjsQuSVwG/zoOa7AOmAWDpiSaDzyl5hrUnskEEkNm7/sKxZ8e4fORCO6hQEOpivFG0OCLIjRqHJrNc03vR1JlgXOO48slNSWorUw2kgdcQhKm6J0N29ozemipDI2azYbH+UuXINNV2ENU455SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480013; c=relaxed/simple;
	bh=qt1XEsOk5vXNGPRWZWnyoZrrno6rZqqFm/L8YdIS0kI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSxj792yZsJBkmDl++SjsPgpixGHQ4B08EbMFjJi0GLiRLRAwASqOyHvvrPz4qJER8fuBOoQ0/Mj+SbOG8kk0JfsnpoQWQ/JDb52BhK3Fi0T6x2itEuD5l5NAPuf85n1v7pexU4Nnkth89Mpg+EkfE/+iK+Juiv4ulDsYdK4Iw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I9oq3bVg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I9oq3bVg"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Aq7Ei006130;
	Mon, 8 Jul 2024 23:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8nKoI01F6Z4EuurtlDnpb+
	wjt4ns0mL+M/RbDFOpneU=; b=I9oq3bVg+SpnTfY1Y3CXTGBanWO1jX5sqMOvfH
	e8PsMlJu/gUyg/8xbv2ypoNaLvsU6OgFPjed186QO5Y+9pm0gXdA3+m/kpXxQM8M
	yJBe5E2AXM3Ia29Ln9P/hDTrVH68G/jYn444WXssyZ+ObQ29GopEMAGThEACtDRq
	b4+OciIC9VfB0DhZgm95pSQKs1T3uTvHK+DCuB1rrh1+vZLynYvZxj8Edqlyueer
	7AFbpYI5DrJ6bR0VOJbowUeubwf9aIzc8oVmwXUxgix6xyZSHCckuYFcSAA9+kkz
	Keqc0/tA1QrxDrr2/tbiFjhuNGKzJf+p4CKWwPa0P4eoj54g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa64tev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 23:06:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468N6hX3002213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 23:06:43 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 16:06:39 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <klarasmodin@gmail.com>,
        <aisheng.dong@nxp.com>
CC: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from reserved_mem
Date: Mon, 8 Jul 2024 16:06:09 -0700
Message-ID: <20240708230613.448846-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FM60Zs7zcx79mNLOdFsyTJKXzE2_eRNI
X-Proofpoint-ORIG-GUID: FM60Zs7zcx79mNLOdFsyTJKXzE2_eRNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_13,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=883
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080172

With recent changes made to initialize the cma regions before the page
tables are setup, commit f2a524d9ef5b ("of: reserved_mem: Restructure
code to call reserved mem init functions earlier"), an issue was
introduced where the initialization of the cma regions fail and are
initialized as "non-reusable" regions instead of "reusable". [1], [2]

This issue occurs because the device_node of the regions are not yet
created by the time the cma regions are being initialized.

The cma regions need to be initialized before the page tables are setup
for them to be configured correctly as was realized in [3].

Hence, since the unflatten_devicetree APIs are not available until after
the page tables have been setup, revert back to using the fdt APIs. This
makes it possible to store a reference to each cma node in the
reserved_mem array by the time it is needed in the init function.

[1] https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/

[2] https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/

[3] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/

Oreoluwa Babatunde (4):
  Revert "of: reserved_mem: Restructure code to call reserved mem init
    functions earlier"
  Revert "of: reserved_mem: Rename fdt_* functions to refelct the change
    from using fdt APIs"
  Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan
    reserved memory nodes"
  of: reserved_mem: Restructure code to call rmem init functions earlier

 drivers/of/fdt.c                |   2 +-
 drivers/of/of_private.h         |   2 +-
 drivers/of/of_reserved_mem.c    | 103 +++++++++++++++++---------------
 include/linux/of_reserved_mem.h |   2 +-
 kernel/dma/coherent.c           |  10 ++--
 kernel/dma/contiguous.c         |   8 +--
 kernel/dma/swiotlb.c            |  10 ++--
 7 files changed, 72 insertions(+), 65 deletions(-)

-- 
2.34.1

