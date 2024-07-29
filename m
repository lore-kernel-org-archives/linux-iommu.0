Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B174055;
	Mon, 29 Jul 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248645; cv=none; b=EBwvicqhckNK6xPJMfDtm50ZittBZns/6fME1pR5iGTHqWL8F3yluqQnd3etre9tbxziBMx39jbOrpfzCIBXDlAmTQumKjCvfgiEim17Q8zrx0Hz+ZWmADWdPhzZUEW3hUVB2EbqDjpZBl6QJqvnxnKuEkMnaV4WXi/mT/Yxo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248645; c=relaxed/simple;
	bh=MBWUVvnqQuJw85YIVqNjuFsWDpP//lzX8e6jri2lLLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DZlpNhhV9XL9KTjWQ82IDqWxNOUriFw+T+rNLyfJg7x6sPkyXarzvEE8KrHu5FCn6usv7MmD083QDHLBWrUIvBUBuzr9406+A8uUyBRgndAIWpR08Q95VDRTX5gwYUeC6X3l24f1CQge6rfHSxujFl395NmJKqQEov3+QnrlUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wud92s/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wud92s/i"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SMlA4g024373;
	Mon, 29 Jul 2024 10:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YN1PGbGk4upJynx+2eC15wv8JF51Em/bJD4CIx8DzRk=; b=Wud92s/iB4RfDb7a
	KXvT48iwsOkByDxhfhVy4UUSGtk7FHWSAJjL6S3MUbDBLeWImJV/uhlKyi1OuCfp
	rTuDqJtSI8XX5X6EjzJwYwPeP+rsCEiXvMho9MEXjX01hk2j7LN32JNjHRlZi7Ha
	H9ZRo38ScKSt0VCUFmU9axNYpg3k9LwKpBU3VIjGwtUBS5sNfPz9pdgaVscGKwo4
	yHcqGiLEq0iqTbjAK/qnl5AWgAvFGwjQAaVnNwcgQEc0vjokz8M0l7ZGdu8/kP2C
	1ZN1YKXCw1GiKF4R7/kEi59XBTOyMoX3OIhnXcRxlT0mrPc5e3vu82WARKZ5uy4h
	XVvEJQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mt2kksk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:23:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TANrEK018924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 10:23:53 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 03:23:48 -0700
Message-ID: <d2cba039-f85b-485c-8c3e-bffc047652fa@quicinc.com>
Date: Mon, 29 Jul 2024 18:23:46 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document QCS9100 SMMU
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, <kernel@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240709-document_qcs9100_smmu_compatible-v2-1-599161b7d5c8@quicinc.com>
 <20240711105450.GA15335@willie-the-truck>
 <c7a7eb9d-b6fa-4145-b444-2f10ead48e62@quicinc.com>
In-Reply-To: <c7a7eb9d-b6fa-4145-b444-2f10ead48e62@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5OU3WqrF-JcMZjFXfCZYJ246s4XcLtZ_
X-Proofpoint-GUID: 5OU3WqrF-JcMZjFXfCZYJ246s4XcLtZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_08,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290070



On 7/15/2024 10:40 AM, Tengfei Fan wrote:
> 
> 
> On 7/11/2024 6:54 PM, Will Deacon wrote:
>> On Tue, Jul 09, 2024 at 09:39:29PM +0800, Tengfei Fan wrote:
>>> Document the SMMU on the QCS9100 platform.
>>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>>> platform use non-SCMI resource. In the future, the SA8775p platform will
>>> move to use SCMI resources and it will have new sa8775p-related device
>>> tree. Consequently, introduce "qcom,qcs9100-smmu-500" to describe
>>> non-SCMI based SMMU.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>>> While the QCS9100 platform is still in the early design stage, the
>>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>>> mounts the QCS9100 SoC instead of the SA8775p SoC.
>>>
>>> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
>>> all the compatible strings will be updated from "SA8775p" to "QCS9100".
>>> The QCS9100 device tree patches will be pushed after all the device tree
>>> bindings and device driver patches are reviewed.
>>>
>>> The final dtsi will like:
>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
>>>
>>> The detailed cover letter reference:
>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>> ---
>>> Changes in v2:
>>>    - Split huge patch series into different patch series according to
>>>      subsytems
>>>    - Update patch commit message
>>>
>>> prevous disscussion here:
>>> [1] v1: 
>>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>>> ---
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>
>> Sorry, but this doesn't apply against my bindings branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings
>>
>> Will
> 
> Sorry, I think there is something wrong with sending this patch through 
> b4 tool. I will correct this issue in the next version patch series.
> 

After considering the feedback provided on the subject, We have decided
to keep current SA8775p compatible and ABI compatibility in drivers.
Let's close this session and ignore the current patche here.
Thank you for your input.

-- 
Thx and BRs,
Tengfei Fan
