Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F01BD039;
	Wed, 23 Oct 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709591; cv=none; b=qov9G9xUAM6bTzjXIEh4fj8oZYenCqfbBAtPVYanR+MNOAcjgGDa+cO0kcepNpwiDKyP1pQMAHETrNxvze7Zo60uHGaQz1EAP/wKqk/vGoaavWiiAx/vWlDGNCZPV9DMqUkQswJ41G6gfPz5P4NvEdd/M/LNu3iwznTzC5gIabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709591; c=relaxed/simple;
	bh=EHxBY+6+T/wQBDA8vKVHwUkCkmIn1IhA4tV2W5b8hH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kT9CPJF071+XzA6IBoMYTq2M9Xh5q/ToI8kGvX7kvIwRBLqLe2hvxRJTWBXilmYxLuKga+00Oy7/2YHAdCXMImwEh+QleoX4erWzDNll9O6HeUIGh0QpQCGpbuTPPTuh4vMSMHhkVO8z5CNtwK1xTHJT0DWphDKmRB2NzIMI5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M4DNjJjX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M4DNjJjX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9hUiH025415;
	Wed, 23 Oct 2024 18:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sdx/bt6PJOEJstPldXkgqJQx0q6plWR/NY5/L1mrPEY=; b=M4DNjJjXmR5M8Wg3
	YCWES9BsqHqHh2vLn1/BQnTjoYiqB8LWeEeERUS0KZ/1Y37XbzCzm3Dt1kG4aspJ
	7It7AlfKW2BZaZDc4uxOFSvrJ6ANUYBsgR7DUJNfCJDbWJyARC3tobQDWUpoZb6e
	UJerkgjDb3aKf75yUrDOrlWHu+VbfYJTbkHHXAghdTkIdtOSWNF0DL4N1D48Hdj2
	35ZvPLmqU0bM2ycFq4GRXruhu4FTLenfh4uLSg6nhnNj2sR6ko81gVm0AnGd7QfG
	rWMcj4XPC7io4sJgoTjY8hsIs6WrgICrWVjORtL2t7rKapRbTPpBi+JuODQi4gU6
	DGLIDg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41u7d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:52:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NIqqRr012105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 18:52:52 GMT
Received: from [10.71.108.63] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 11:52:52 -0700
Message-ID: <3862bfc6-c2f9-4aef-98fd-1f2b5318a2a7@quicinc.com>
Date: Wed, 23 Oct 2024 11:52:51 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document sm8750 SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg
 Roedel" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241021230449.2632493-1-quic_molvera@quicinc.com>
 <tf7zt3ytxdzgeop2n5ard2kivbjtcqun5jahgqvejynj2ttyon@eg2yd4ulouw4>
Content-Language: en-US
From: Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <tf7zt3ytxdzgeop2n5ard2kivbjtcqun5jahgqvejynj2ttyon@eg2yd4ulouw4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cgifw-p_grS7sf9Iv9UNMCLAxMh3Xh0l
X-Proofpoint-ORIG-GUID: Cgifw-p_grS7sf9Iv9UNMCLAxMh3Xh0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=739 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230120



On 10/23/2024 1:25 AM, Krzysztof Kozlowski wrote:
> On Mon, Oct 21, 2024 at 04:04:49PM -0700, Melody Olvera wrote:
>> Document the sm8750 SMMU block.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
> This is incomplete, what about clocks?

I agree, but I don't have the dt changes for the additional smmu node yet.
Should I update the bindings regardless?

>

