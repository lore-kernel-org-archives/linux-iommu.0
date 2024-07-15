Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100128F0;
	Mon, 15 Jul 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011248; cv=none; b=jXWewpWXrJaG+PHM2+99Ggxw07IwPmAgz0BQ/VXxI2uqV11UvWjS01Knz1gFu4Mkiwbk9bl5YgAyqFAUK5jqo0rJLjLAjOVscOnIGUvlM5jZmbJlS4Sw5fUcIGzdzTi4TGeYL7gDX0dEV66BNMmd7p4QGBWwcP9Da7H0Hs8MkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011248; c=relaxed/simple;
	bh=Tu3x/Z7VTub/wLyKTzuR2TkjZXRA3Ve/wgNA8e/tQVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i1e45cWzoFGQ2pCuiRd0nbu723h1QGnuEApYEIUqVTFkM+EBjLeoABLtMQFBTCOBVPZr3+48fyB6uArf3jRvuy9RG3bM7R8aM+xZWOUQxUaHnRm8cxMxtr9C8nepwlvHCHxUgFaCdzqiOKzRZoGXWdFhmbCp6Cwl3ScY96tR3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FM754vbh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FM754vbh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F2dQ48000566;
	Mon, 15 Jul 2024 02:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aofU5TUVZ+fTctCVlBueSj88U+Uu6XtYPTxrv7Klaos=; b=FM754vbhKJiPrQFn
	96TZAKXbma12imSBidaWav4QpR+J37vmyfcLbDq3TkwAWEt7B6WLYUMYrF5zrnqx
	Qj/qNRS4V5FSEdTu+QsCmICYNjBKlGjekKEkQKI5fvcD2csz6xCjpepN2lTEuGT4
	BCfAoKxg5D2mL3woQTQ0fV66VLHYpJffKSaTn05XGcXTR17IJemq4oqjifECtSUz
	MNUzz3IpsLNAvUI563pQteIhftke12+Uu+zTbSud87tPXvtNyQvcJCEcapY5R7ds
	TgFNT0iGiYWJ7bjSFOMZhrfyIdOqb6elHv2QP87iI2skaFujmsThtjQPY1tWMzqc
	owAjUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bht2jjy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 02:40:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46F2eZIi032216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 02:40:35 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Jul
 2024 19:40:30 -0700
Message-ID: <c7a7eb9d-b6fa-4145-b444-2f10ead48e62@quicinc.com>
Date: Mon, 15 Jul 2024 10:40:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document QCS9100 SMMU
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
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240711105450.GA15335@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2K__6S-3yHCN32DSlCRMg8vTl65wjv9y
X-Proofpoint-ORIG-GUID: 2K__6S-3yHCN32DSlCRMg8vTl65wjv9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=996 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150020



On 7/11/2024 6:54 PM, Will Deacon wrote:
> On Tue, Jul 09, 2024 at 09:39:29PM +0800, Tengfei Fan wrote:
>> Document the SMMU on the QCS9100 platform.
>> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
>> platform use non-SCMI resource. In the future, the SA8775p platform will
>> move to use SCMI resources and it will have new sa8775p-related device
>> tree. Consequently, introduce "qcom,qcs9100-smmu-500" to describe
>> non-SCMI based SMMU.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>> While the QCS9100 platform is still in the early design stage, the
>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>> mounts the QCS9100 SoC instead of the SA8775p SoC.
>>
>> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
>> all the compatible strings will be updated from "SA8775p" to "QCS9100".
>> The QCS9100 device tree patches will be pushed after all the device tree
>> bindings and device driver patches are reviewed.
>>
>> The final dtsi will like:
>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
>>
>> The detailed cover letter reference:
>> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>> ---
>> Changes in v2:
>>    - Split huge patch series into different patch series according to
>>      subsytems
>>    - Update patch commit message
>>
>> prevous disscussion here:
>> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> Sorry, but this doesn't apply against my bindings branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings
> 
> Will

Sorry, I think there is something wrong with sending this patch through 
b4 tool. I will correct this issue in the next version patch series.

-- 
Thx and BRs,
Tengfei Fan
