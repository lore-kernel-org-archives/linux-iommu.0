Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16C3E0220
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794538; cv=none; b=EWfInaWbdexjo4rITLAh6iTPAGdDLaF5win0m+sjG1cey6i6G9TFSfRplvxJjZJf6nqbcfvUiwgb8T1sz5i73tFdgg2DsaIy4uP8jNgw5sjVeWmq7luhkkbokUR/0VnljES3QqnkpIjHkvLOdWh73asaDZcZlbUfTq7/vRCWRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794538; c=relaxed/simple;
	bh=tRGGCO71eDtxTc4WzeqTKxldH+vPmJ0nK7h+b1NqrEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HJFU6z1E90/xq4vIhqcHpTCmP6EuIlz89E7LgEwyrDDEv8bKelBKhqYlhXBcyS9hyiC0mGBBc+CDXvbd2IbamP+wjWiJDqr0gyBLDXsicq7wKzHyfp8QafISty/hpeEfIrJgYwOv0LArv0wMOSShTA2cPa+Ift4gh6e4+kFKP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb3n/hA3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N20jNAcj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb3n/hA3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N20jNAcj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q7DqHu912458
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WnpyHJs1NmxwCEAJIlKsYN64HQCUrUukJsbFW1tZEk=; b=hb3n/hA3sWQtchUa
	2xujjhW8UFehd/jQIvqNS4Onx5vfZ0Fg3WtxZ7hV5HOGt7xdXh7nUTbiBm+YNYMe
	gQtinOyNO2/Yq0XJ2SKoBdbTiFJujZ/SgmMpLngi3pWKVGq1w/h8VyML2VqiXOac
	87YQ+M7pJmuitSQF/YO4zUFd5xD5n4uksLNJ7U6JGrW5EQ6PU93pzMwhDCU3smsa
	w5sPvbbq6y3YY6wcEJ0T1ePLvBYY2DHNNSa8+Oof61vpNNHAwJILd6hXannEpLe1
	zf/tVRz4/b6Wu32plhVZVYohcdn5fCOuMRPhnNEer04wjwl5gY4w3oU58SlnSxDu
	1eFnwQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm036qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82ba4715b6so11327582a12.2
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779794536; x=1780399336; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3WnpyHJs1NmxwCEAJIlKsYN64HQCUrUukJsbFW1tZEk=;
        b=N20jNAcjP5lAHMHOcjtTkBz/VfX8kCELp9luN6h9jHGFdfi7UapjmoCzwXh7fMuEqK
         77nZuN+iAEMtqxaewYy9PXXi1SXwxVpC7fk/mg0Jp0s2wbmKz7G7PIxSNlPd4vkdNLEH
         6bgoE7yibFWRA9+JxSYsxDkQ+fx7HlwcU1rj46TLZ8PrNc4FXJOwVJGdM3RWIE6X4vKm
         uyIcqwT8OdfqDaxoNIBpuxX1TDeiWdamT0eFTfv1WznqRVnaoRvSE7OkNHQIWyPe+Bw0
         k4BVuU3ETQUnAz3UGSK89pR/wTvW1iP3KIRFsN8gpW7fIBvGwmdwl50LOSydzo/XNoFF
         Zwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794536; x=1780399336;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WnpyHJs1NmxwCEAJIlKsYN64HQCUrUukJsbFW1tZEk=;
        b=DVeZyY/v1IImqWOpvWyxaHr4NTcIAw/Y0n/GekSp14SYyFZd/qxlKoezSeef1E219/
         Q+9SyHEHF5bsI0exmZ0M/3lW5lwkuVJ3EJknwvhyaZcAjE84TNzfk+wtNYGhICO7zcxJ
         Wpr1sZ2aoQrf9lT59nl13NdcXJi+0wIt3CDMNd/DFheaHz3bIiGDOQfxxr/DNZNwc6JW
         N7uxUXhmFNsXBSOn3zSHzdQNJweHLo38XBplGLex4uPUch+/OyUTVS/IUQuJTJSRZN8f
         b3RkZVQ/G8JNw3N/lyazwGaGDZIHhxtTnH65YAHiSJwRS5xd22x9TRcikH3BHvmY2Y1q
         w2ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u86+0oYKo2PP0B8Rxf4YFSK2Tu5cqXj1QfJSCD6fptX6UDp5UPRm9wEP2l33rWePXTMqh8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfNvkhY7Za6AdKv1vudVsvOe3aCjOV9SdXD1F5Tl2tAia7ISlP
	MKcL8YmAE3/n6eNmursUHmM2V5fHB3dPrqXNbZLfr14ErX94joX2T6N9HaZy+BDFQwjfUB1Ujy0
	dHwU5o4RfT0pHUkq7YcT5a0P3AGr/APRE+TlL5RJQI+l1lPkrrB+9YkAPrQ==
X-Gm-Gg: Acq92OHgri8dCmq4RDNuUmc1848UEpFc7nc1tRyIO7qdv19LA2e1M2Nn49kvvNaLy5G
	OYPcCeutfh7ddnUJzuWOGekLEmTlTiNLLeRa85mMWne8I7NX6hI8D0fDefx/ROa1sJ2dVcG/hUY
	r9nkH0mI8sCxQTZZtP+QcnaV16WFvyib9MeH936q3mqwn1uUCeCsisSRg3Pgh1KysC1Rt0bt9i2
	z3cDcitPe11v4J15uLKoRiTWFujhbKu+TkhnfAGnvrOpoaFEOB3cJCumZ+1mlBo6OQLOKJaIx/3
	M0I48d8r/akGjsdhRQO8J90VHM2cPUSHbynyioXNVBbb0ajhQkd7Uhd/jey2GyIV7eqpV4f9trg
	PWw0DOl0BmW1hKApqz0JaBHUMi+KwZNjgWTrclklpcRqO7ITPDi/uk6VxZkyhIQwr
X-Received: by 2002:a05:6300:6d8f:20b0:3b3:62be:3241 with SMTP id adf61e73a8af0-3b362be384bmr6464397637.8.1779794535876;
        Tue, 26 May 2026 04:22:15 -0700 (PDT)
X-Received: by 2002:a05:6300:6d8f:20b0:3b3:62be:3241 with SMTP id adf61e73a8af0-3b362be384bmr6464354637.8.1779794535248;
        Tue, 26 May 2026 04:22:15 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm14725994b3a.10.2026.05.26.04.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:22:14 -0700 (PDT)
Message-ID: <63056c1d-a191-996e-b556-e636ca88637c@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:52:06 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v6 13/14] arm64: dts: qcom: glymur: Add iris video node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-13-f6a99cb43a24@oss.qualcomm.com>
 <fc2wiqf6vxob2lzp4fypekcdeuf7mcmn7znszzm5drmlkrdndh@ph5mgjaezdzo>
Content-Language: en-US
In-Reply-To: <fc2wiqf6vxob2lzp4fypekcdeuf7mcmn7znszzm5drmlkrdndh@ph5mgjaezdzo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a158268 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=y5j-N_kvQXTMkCsvIs8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: UOGpZ5Wujk8UFNrC8TPEwZg54MQ5vkJW
X-Proofpoint-ORIG-GUID: UOGpZ5Wujk8UFNrC8TPEwZg54MQ5vkJW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5OSBTYWx0ZWRfX44JpMvFluG8Y
 4nEz1nMaBqe89hrryyH5rrJhmM7vZ1z5lAgx9rTeqWawzxiK2gYIlmfVF7dkrdOKLlVVa6JuPlr
 EucalD1gvu5DhKIHLFbBvOepFfdtoFwYqE4q+rxK9TjSDEKQgbyBpUW3jmcW/W4W6k9Oe4mi2at
 z9S9h/m9kbjMFpCNRai9QRqyNGjsgJr1y1B1Y1i/bPFFCfGfMELehjK2iQqEagjp91lMYg0T7Mb
 2dfMutgFkmXXVECyDg94fIL5oAq3uOOoNan/d04TO+GNQwYbX59Cx5DQsRVHCLqhSI9IvOHQUYM
 aQsOEBw8Y+Rcmu3mDE17Ks2G1PdxIHUMQ/B9naOUvMki3zyO6bKB2i6YYASv3os1YS9+5Y1YBip
 bPpKxcIyHWX8vf1gJ0jws4mMGPK+ZTU7wa2e9idfuf/JmpiZ0VU2hRc6YXxB1AgKtIMIip+ncej
 xih6VU+Rsvs9EK62oww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260099


On 5/17/2026 11:41 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:28PM +0530, Vishnu Reddy wrote:
>> Add iris video codec to glymur SoC, which comes with significantly
>> different powering up sequence than previous platforms, thus different
>> clocks and resets.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> index f23cf81ddb77..c47443174f97 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +#include <dt-bindings/media/qcom,glymur-iris.h>
>>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -4163,6 +4164,123 @@ usb_mp: usb@a400000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		iris: video-codec@aa00000 {
>> +			compatible = "qcom,glymur-iris";
>> +			reg = <0x0 0xaa00000 0x0 0xf0000>;
>> +
>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_CLK>,
>> +				 <&gcc GCC_VIDEO_AXI0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>,
>> +				 <&gcc GCC_VIDEO_AXI1_CLK>,
>> +				 <&videocc VIDEO_CC_MVS1_CLK>,
>> +				 <&videocc VIDEO_CC_MVS1_FREERUN_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "vcodec0_core",
>> +				      "iface1",
>> +				      "core_freerun",
>> +				      "vcodec0_core_freerun",
>> +				      "iface2",
> I can only assume that it is "vcode0_iface", "core_iface" and
> "vcodec1_iface".

Agreed, the names are not self-explanatory.

Krzysztof, do you have any input on renaming these — It would break the legacy
naming convention followed on earlier platforms?

>> +				      "vcodec1_core",
>> +				      "vcodec1_core_freerun";
>> +
>> +			dma-coherent;
>> +
