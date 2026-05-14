Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B238F929
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741287; cv=none; b=WgOXD/BzZw9O5P2QHn10PDPW2U6WyoTbdaLz9cuCOM0IsohABMRRiccHjAKhpHUwPt0poIRCl2/udtITEtsUxhc3ve2bMu0vwz7mRVSWOJ3t4+gImqJfzHl5uWZyilAbAwUqbon94eGq6K6hPhziH9KV6YlIyYpn4Vmyw7DDRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741287; c=relaxed/simple;
	bh=qpYInB19+KWB5dpwoxZNhko/ryAESkSZ2TXgzDKRXSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GupMuR5KLtKKttd4J6ZfyG5bNinbXGZUnu+0fiPeJ6BXVkuiyMMfeDsmsznqMgczUcBl4+wbsZAs7TYQagdVeOwwL/wU7AIuDPXooIwQYYG4Z2IP2C+3yHYTYuMWtp6fKRr231/SbuSUErSZX9OelpwU9D+t1ic89cfUx0jqYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxFwvY9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DS5dLi8N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxFwvY9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DS5dLi8N"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E3Gcf43430119
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 06:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=; b=BxFwvY9dmeolgFNT
	rxtfCdlUKx0M67AilD/55CfJDr/7/jIa/LJgMnmnuiUC3HdG1PbTeFJVsq1ej0F4
	v0r6Joo67UxwLAsVyF9vrnBnwahlb4+QJ3a4T9UX9k0Jz4BhoB3Skk4UdGmNIaVm
	llflerEmcXADzX7fiTolPXIkHPmWE72n/uA9RtOzI66mcaP2lws9fTQEiDbsw2nH
	WjctpSSSDZ6x+gXfPJ0wS56FreTRM9USM4ZoGFnvhPn+qVQyr6ypsNaId1O/oIab
	Z8u2UpDSIqz9F8cIPRvIQaNrDu1ne316JJtUCP98BIqP5yRbhs1DW7FnNiLhhXsz
	EPQ41g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcm19s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 06:48:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8276c91addso3034116a12.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741285; x=1779346085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=;
        b=DS5dLi8NngYIPnQ001G1NW6MWXv2BS27Q01gOH/AU1pAKqzITdK8U5OyiIjvZJO0SH
         wz2qXfz/UWf8ic2c4JFOJJ8fL2stf5qKGRcTFrgvLEcG5DBbu8BUr3MfHpdBTBPs4J6s
         MGJtKNTN5zIhr2AsTMc2GGwBjtiCDgS7xk9vyBObU1o15NC8wvK/FEzmci2456vcRZOe
         TP9+aKaL4jrj6qvypTMRIpWzSFjeKfkPUt8bJSdbL/MsDWBmXUvseTbHQlY6W9ucLJVW
         UnlROAO/STZAKK7UXAsibDKOIRWZMVB81nXlKz1xcp2PG7uwp8tHTusB03PfXrwULg1O
         OF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741285; x=1779346085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=;
        b=amkmgndJAFwwWMIT6u6msUD6bbIWK5EgXxP65B2j1LkdiqNvEIDfTW5muJW+cynm/p
         XVKNqa5XateWuKOl434Q+9NNGW11wk4SURgNuK+nCeQBk25fPNmAOC0314QfuAbaq7KO
         op0F50Mg6lh6W6cQ2m4Dr+MLpVwJE7xWifw6h9X4UFTqciEuNIE4WXWkgi3TbjM5dbcJ
         IldAh5j9Z4Frmnf4D4eXdddz2SCX8opzfJYcCCr07RYZW6eSbr093cvBR/0jxeoZ+cY3
         O+SnEoDCkVAMcCLiW1LM34wMAejIweXzIcGW18X1SGLWUN3Gc7YkHiU7TU/nPUe5YT8S
         BDhw==
X-Forwarded-Encrypted: i=1; AFNElJ+e64WDRL2oTzZ7v1GvuWqrSGMvz5K1BBoYMiemhPrLC5I1UveSj2LQ+Ev9erCo6SAl8ZKvfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfecbnnQ+zC1KEv/354/K3R6X3aoaQ6erZSQrW3zTk0ikzQ/k+
	MBLDTagUH3XZ3vXfpCH1cfcPGuoZnkEq0ngJVr2CpXO9JES46IQcoHC2Z1A/vIzp3rKpjT0pWk5
	046uASItrVW5AOl0WDpFJU57pILXSzuDbpFtCmmy/Z/WgVszRVjvE/BEpiw==
X-Gm-Gg: Acq92OHZvdupbBv6g5wtvYOpXQDVeZVQwZqVq3VFZ+40b/V0jzyjA1tEjcSAX14SMx0
	uURHUbZ+LKGmO25dMbt2/GyAugOHoHQ6aiBzNZgfNqyp4KIQLXVpBA50AjDJX1MNIRBSrS5W6S2
	80YsRYejaI0c+BgrchCR+IzzAD9g0OUtY3ZY0HTP0hOeFxkPnF2BXkDbK1YESRGyEuYvtNBJ8MD
	P7N6uPolBXLmiNnN2UEmRgP3+5REkIUoBY2R77HAi63YUALbCerpKbbChv6XNtY2LPg8u/IFx5X
	yggyKLqRcjGUVNF83gftiAhMdD/djzeb1vf2Maq3H5qaWEyLT+WK6kxF849e8SbpDZY33sf8XNM
	paBpS/b0MTBYGjbarTPOrhWor34CHBtWfhaFHjqkoYqOvR81dORc=
X-Received: by 2002:a05:6a21:33a0:b0:39b:f12e:d53 with SMTP id adf61e73a8af0-3af80681dcdmr7390035637.18.1778741284455;
        Wed, 13 May 2026 23:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a0:b0:39b:f12e:d53 with SMTP id adf61e73a8af0-3af80681dcdmr7389962637.18.1778741283620;
        Wed, 13 May 2026 23:48:03 -0700 (PDT)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660f9sm1952912b3a.10.2026.05.13.23.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 23:48:03 -0700 (PDT)
Message-ID: <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:17:54 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
 <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ELYz0BN_XKjXGR0Y_I4UHOzR1H50HxHA
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a057025 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oeV5rHmN1k-fxemBOLwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfX1DP5fs88KwaM
 PGJGk6yNh0NRkaWHf87Tx0UWd29eJ1nmpl1DWvxejLu6mdgdjEK5ed59yiIVLL0Em0BVkgeKo6a
 fNwJ1nysxuJMfcIV0StyJNdgyr77MNglSkXVDfnXTr5su2VHKbOnE9owR+Rwm8KyqNzJNsAofYY
 wfw/jgdywhsscAEahXpQZBoHty35XD1oy5Tesamc9hluz6dDcpJhICtL4HKf9ehQsntlsELjH7Y
 8kwdVUbltmFqWV7aONG/+p7zfHYpS23SPuuge3H9r9AyAp1ZrTrrOih0uCOBrlTQN7O8S6AcTlC
 0qenJzS3h3F4sNEp3X6qEjIGbo+Omw4rZvfHEbgARqSQRZIUhqRgA6/j5TaKh0X0pn+bujvJB1g
 zaMNvy2q6xX5t0WhEcL3sIkWoZersD4FKdWJ6doRFNlDXMZi0FL/xxYw/AaTJO1JdrvAt6ryNPt
 H2FAMv+6xsPq0oZKr1A==
X-Proofpoint-ORIG-GUID: ELYz0BN_XKjXGR0Y_I4UHOzR1H50HxHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140065



On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
> On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
>> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed
>> when reaching 105°C.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>>   1 file changed, 135 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> index c57aea44218e..5089416ec32c 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> @@ -26,6 +26,7 @@
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>   
>>   #include "kaanapali-ipcc.h"
>>   
>> @@ -7045,13 +7046,15 @@ nsphmx-3-critical {
>>   		};
>>   
>>   		gpuss-0-thermal {
>> +			polling-delay-passive = <200>;
> 
> Other DT files use 10 for GPU thermal zones polling interval.
> 

Sure, let me update.

>> +
>>   			thermal-sensors = <&tsens5 0>;
>>   
>>   			trips {
>> -				gpuss-0-hot {
>> -					temperature = <120000>;
>> +				gpuss_0_alert0: gpuss-0-alert0 {
>> +					temperature = <105000>;
>>   					hysteresis = <5000>;
>> -					type = "hot";
>> +					type = "passive";
>>   				};
> 
> Why don't we keep both passive and hot trip points?
> 

Need guidance here, we are keeping passive at low temp so still hot trip 
is needed for such cases.

>>   
>>   				gpuss-0-critical {
>>
> 

