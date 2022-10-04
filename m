Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B4419
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 20:01:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JsAxX030412;
	Tue, 4 Oct 2022 20:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XGa92zz/DaeiQ6YRhnRH8R2eq1OnzKH5IeRMwTcroTg=;
 b=Oq7EUIhEUQUcfSIW4eJdfAjbJZzViiZTBXZt0ukiszP6/T4sFVqMs+8BwkF6YddAmjYy
 SUV9PydB3/U7k4fpPL4Jga+o2qhVYVtGNP+qEeoF6qxwg3HM+28VvrF668UpyBMjB4sz
 Yopi5v7x1AxDfPUQvSEqaFEfs/araZlgzZ3IG/cWB1BkHVneCSR0JJe+WbPGPye4istA
 40ILHX/8H6Nl5lITy8KJPirMjROcvvPEyL5LYo4Y2ESeS1nxexbqcIGR0lRVmDJbCIJI
 cuTWyNp0J53dZn5n0Df8goTFpMBftBCfQdd0lLWIgyofLPwH6jPc7AMOAgCGT3RpzPYc 6Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0escsqxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 20:01:32 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K1VoM010547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Oct 2022 20:01:31 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:01:30 -0700
Message-ID: <af44f9a2-a677-6c07-a0a7-74b6bbbab89b@quicinc.com>
Date: Tue, 4 Oct 2022 15:01:29 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030615.29135-1-quic_molvera@quicinc.com>
 <20221001030615.29135-2-quic_molvera@quicinc.com>
 <8e63f6a7-a133-1f20-403a-5b0965cee107@linaro.org>
From: Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <8e63f6a7-a133-1f20-403a-5b0965cee107@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IDz103nZHmL9s510BoQu1PM4jZ5soZjJ
X-Proofpoint-ORIG-GUID: IDz103nZHmL9s510BoQu1PM4jZ5soZjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=894
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040130



On 10/1/2022 4:31 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 9066e6df1ba1..681035b6e991 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -47,6 +47,8 @@ properties:
>>                - qcom,sm8250-smmu-500
>>                - qcom,sm8350-smmu-500
>>                - qcom,sm8450-smmu-500
>> +              - qcom,qdu1000-smmu-500
>> +              - qcom,qru1000-smmu-500
> Wrong order.
Will fix.
>
> Best regards,
> Krzysztof
Thanks,
Melody
