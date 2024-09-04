Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67451D9345
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454227; cv=none; b=faxejNmmtMAJvVg4xLmgxDk8gMSor3pOsrO1qsnyBcSeirPirAf3OKe9YwCZbUHsu9oB3tzoRRYGHg7tFnN5xnq+BjEnDyJQATDE8Fo1k4sYpY3SpDLPiOZz8bE4/i/RVo+aCTk48grmfoRFW/OTCpLxl/gAz+2IRxBCMqF9yaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454227; c=relaxed/simple;
	bh=NGsk9HjDdwWbfmDFZSljaWFdrwyn8d+b1UZ2pv16U8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EkZn3qKA5fE007AsH9Ra/Xss0dV9qXseA67908jX/d+9HFewnHfWR2DOZVDTC7yf2aKZgVj60//kc4CJ6L5Vc01Sq+UfuvQ5ZR0wdt1tfDJAPun5HlB4USBw5kmzGwDVatHHTdcSECNcVF3+Yg0RA4Gwcgtp7bsC1rLBnZXXTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D2OW5DpV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D2OW5DpV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849ufAH006343;
	Wed, 4 Sep 2024 12:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NGsk9HjDdwWbfmDFZSljaWFdrwyn8d+b1UZ2pv16U8M=; b=D2OW5DpVfbEaJ094
	ETUOdiw0H045qT3yCJtZl4VQgd8WtN2zdTlf9umMuQmWir0hDeu19baKcGP7ay/C
	GXNKoEz9S/o/13nc1Pu6XV/+b+QMbn2yxJwZkWlq/swMMso8+N+BmVbUhm5iCfSh
	iKCJIuvfgA0k9SmMXDRuHX4rV5eubkRfMPI0J6LpKbtBVr6jIzS6vjStYnAOfQE8
	N36UYQIAZ2sGcLbHHFJtBUOIhVhv6GQHR4sh6h4RFBBUvHrJ6qFMC2D3wzQQUfT0
	WE8EzhOr2HpHxGtI3AdYE+zaJsTCFq9LrCdlODpo0Cq9T+ea2IWrXkOiH2Fr6p4T
	Ec3UfQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41enbwgexu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 12:49:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484CniDE022770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 12:49:44 GMT
Received: from [10.110.120.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 05:49:40 -0700
Message-ID: <9394ce8b-9a43-485b-8d7f-33930251ccac@quicinc.com>
Date: Wed, 4 Sep 2024 05:49:40 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/21] dt-bindings: spi: document support for SA8255p
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <sudeep.holla@arm.com>, <andi.shyti@kernel.org>,
        <tglx@linutronix.de>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jassisinghbrar@gmail.com>, <lee@kernel.org>,
        <linus.walleij@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <broonie@kernel.org>,
        <cristian.marussi@arm.com>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-gpio@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>, Praveen Talari <quic_ptalari@quicinc.com>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-17-quic_nkela@quicinc.com>
 <66458a5c-5054-44ac-914f-e66281ee43a9@kernel.org>
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <66458a5c-5054-44ac-914f-e66281ee43a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mX611lOsfEMvUihLFExO-7E5SK19-aeb
X-Proofpoint-GUID: mX611lOsfEMvUihLFExO-7E5SK19-aeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040096


On 9/4/2024 12:48 AM, Krzysztof Kozlowski wrote:
> On 04/09/2024 00:02, Nikunj Kela wrote:
>> Add compatible representing spi support on SA8255p.
>>
>> Clocks and interconnects are being configured in firmware VM
>> on SA8255p platform, therefore making them optional.
>>
>> CC: Praveen Talari <quic_ptalari@quicinc.com>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Also this is incomplete - adding compatible without driver change is not
> expected. It cannot even work.
>
> Best regards,
> Krzysztof

Link for CLO branch is provided in I2C patch series. The driver changes
will soon follow.


