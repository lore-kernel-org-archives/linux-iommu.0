Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405823EA9A
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508172; cv=none; b=YbsRFbLU0Q420Gj1nwAZHLvydic9KqArKmeoyEBQ73EFJNmHVQBueVhOxVs7ukBgIkqdRnaVSkQbBuDzIENnbPEjPjTAtwb6dIGOTFIuUMj47FMV6xz7PYxXtUokwwihiuwFlJ+Ln8+5L8PuwiWtdUm0VG483NDSxZ218hk4bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508172; c=relaxed/simple;
	bh=aba1FJ3GcZd1jHvORczGzLPIu83bn/vJjpfMQjbuOJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ChOjfQRaCwiQBv7U7F0HfS8qqDf8HKByCxEQMVzxQ7PqxMpDdBsN6AxtxhTgnJVQXQD0SS2hr4GTpt0D2VIQlT6kVCDBozt9h+k222X3eLMM21yqgxstXVvmBZqLXZMVyyCA0oYTfdT1rlR6tTpIiFdu1e76zSay1rdqHvIAX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i35UeTMq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i35UeTMq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454AwvuC012642;
	Tue, 4 Jun 2024 13:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DdouOaq7ug96A1qXHHH0UP+fokLpC05AzBvwLLSH3Lc=; b=i35UeTMqGe0euzX7
	ZRoxTCOT+80zsVeSb+oOS3WuMSUv9mi7KLlWwba86alosoWogR8tgOjkrOPKCZ2a
	NCkUBPVJ0h58KMst8e2NXEphARU9xsb2YQM8lxf1YpdlPtLCwsNlibp82sCE9RFV
	+8eeXYDQDh8OHemH+FRCrzKOVC2noqZqBJsEN+L+5pAvCpzZta0DokR/j8cLVMwV
	I3kKk/sEhTE+OBTis/36CTXenBl4s5E3eTACZ/KZWqzMNhCDaGviGpBKFPK6vvUv
	QRW3K+Q5l/oEtFwWyGCkcV+klYtrbSRHS/OISocKgOMrAwtqLruzXspP+itAntd8
	UlZwtA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4aq3eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 13:35:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454DZsW9004132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 13:35:54 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 06:35:53 -0700
Message-ID: <778b979b-8046-482c-b19c-3494d0258435@quicinc.com>
Date: Tue, 4 Jun 2024 06:35:53 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/22] ath10k: Use iommu_paging_domain_alloc()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
        Daniel
 Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alex
 Williamson <alex.williamson@redhat.com>, <mst@redhat.com>,
        Jason Wang
	<jasowang@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan
 Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, <iommu@lists.linux.dev>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-12-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604015134.164206-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGUK3OcNwV8oBIZ_H19pTlotmWnV48HP
X-Proofpoint-ORIG-GUID: YGUK3OcNwV8oBIZ_H19pTlotmWnV48HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=792 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040108

On 6/3/24 18:51, Lu Baolu wrote:
> An iommu domain is allocated in ath10k_fw_init() and is attached to
> ar_snoc->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

nit: although the subject prefix you used probably matches the prefix in 
git history, subject prefix should now be "wifi: ath10k: "

with that addressed,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

