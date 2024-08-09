Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9622F56
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229829; cv=none; b=nVufFhMO3TA97ikvabOS+tDgKOSZGjPCB6L02039FAxilFVNz+0Gjjj/NtrbpEpf7Wi2ZxPWKuGMrxobyjgK9E9Imlta4p7ry7bdMeG3HoGDNBGvHwls7Jj7m8rl0Hr4uRd5blM3E0Tkt5En2Xnx07Tv16qZQpkRTq2GNA8zEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229829; c=relaxed/simple;
	bh=nvFn7mAb0Twh6vUcncc5orvAoBjxgOO3JfZOwABh1rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tHTl6T6TObUrMg6mS5TU/beQrOUmmk3nBHIhKSwgrc+kizn1vQxvYdIS5/dz6lM4sa/Yg8as/vwNd0qeHZyxD/U/pSHc3XCbUNFH/rlGv/DLj0PATZlVqhWCvR8h97CUdKKBS4usb+yBDXDHZOICCZLHp7drmNuZYYfHJi+xQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=joI7c/oa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="joI7c/oa"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479HfQcj005995;
	Fri, 9 Aug 2024 18:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nvFn7mAb0Twh6vUcncc5orvAoBjxgOO3JfZOwABh1rI=; b=joI7c/oaibUEdfuP
	bsCgeSJCrk2VKvmu4rZw5kOqaAoRijtZ+qZilWYSrtE8l8sK0puAXOcGTOFjI84Y
	Nqe6dzO46HGOK9F2kxDK4rfmR/4ExrMQFBjyULqKMp1Pfv3wYdAehLrxR/X/dWEZ
	iMJsIAaJgMu9+IsUCIR4KaMz+7FVcojQ/PwQ9PJkYnSDUztCNs/AhSvicc0jP2Fr
	aHcSsytLQnKxCcR0h1k4DSAPpz7TqRAP0OuS4IUG0TtVEab5tSlTLa97mCj+AcYn
	Mt60nNXPYEcSGgmQpUvXWXIspCGCNuDxOmPQ38m74l1oGivCZ3tlIgOj8CHOg/3T
	L2hNiA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40weqf9p8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 18:57:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479IuxZD008155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 18:56:59 GMT
Received: from [10.110.12.164] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 11:56:55 -0700
Message-ID: <1bece984-6f5f-41ad-b785-03803f6a2037@quicinc.com>
Date: Fri, 9 Aug 2024 11:56:50 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from
 reserved_mem
To: Klara Modin <klarasmodin@gmail.com>
CC: <robh@kernel.org>, <saravanak@google.com>, <aisheng.dong@nxp.com>,
        <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <kernel@quicinc.com>
References: <20240708230613.448846-1-quic_obabatun@quicinc.com>
 <CABq1_vjvPeF-h19-H99q5D1u7wvtbRPoKKqroMJFaMb+yUFLgg@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CABq1_vjvPeF-h19-H99q5D1u7wvtbRPoKKqroMJFaMb+yUFLgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0KIsqVITAaWxApNfnxic84WONq5N2WVz
X-Proofpoint-GUID: 0KIsqVITAaWxApNfnxic84WONq5N2WVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090137


On 7/9/2024 4:30 AM, Klara Modin wrote:
> Hi,
>
> Den tis 9 juli 2024 kl 01:06 skrev Oreoluwa Babatunde
> <quic_obabatun@quicinc.com>:
>> With recent changes made to initialize the cma regions before the page
>> tables are setup, commit f2a524d9ef5b ("of: reserved_mem: Restructure
>> code to call reserved mem init functions earlier"), an issue was
>> introduced where the initialization of the cma regions fail and are
>> initialized as "non-reusable" regions instead of "reusable". [1], [2]
>>
>> This issue occurs because the device_node of the regions are not yet
>> created by the time the cma regions are being initialized.
>>
>> The cma regions need to be initialized before the page tables are setup
>> for them to be configured correctly as was realized in [3].
>>
>> Hence, since the unflatten_devicetree APIs are not available until after
>> the page tables have been setup, revert back to using the fdt APIs. This
>> makes it possible to store a reference to each cma node in the
>> reserved_mem array by the time it is needed in the init function.
>>
>> [1] https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/
>>
>> [2] https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/
>>
>> [3] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/
>>
> These reverts also fixes the issue for me. Feel free to CC me when you
> decide to send the next version if you want and I can retest it.
>
> Regards,
> Tested-by: Klara Modin <klarasmodin@gmail.com>
Hi Klara,

I have uploaded a new version of this patch set and cc'ed you on it.
Please help me retest to see if it still works for you.
https://lore.kernel.org/all/20240809184814.2703050-1-quic_obabatun@quicinc.com/

Thank you!
Oreoluwa
