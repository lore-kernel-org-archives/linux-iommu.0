Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946623E0220
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794533; cv=none; b=HPlP3hb8c3+kJAX4+16LfKdEmT7/11WjzBjzXlU54v+oFMjg5VNlx4efkwmv/oI27BsSC/MRAoUQc1zy352WpnAtwQLejYCAv6pP6KekZRnOuiCFFFxwblfej4nRkWJfrfZtMQDo1M57PKZ9lVBbLGN9GIe1lTHD+U4Ic76rSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794533; c=relaxed/simple;
	bh=HPoC6rJteLMphgQNQ0wiQJqIp3sHCF1ZNTePGRjNoQg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WxLXPdEaMO3iT7E6wOIiXJ9VY88c9BdpzdK/yNWHKud0BpqqgCwOnY+8dWxkuclZtvLut2Er2yRE7JmRYYzavAHtLOeIX6vA3il2eQ5lndwWXPzc7u5VpUSX4Ba/Hf5EGejlJRtiBjkDxKvVpwTvx3rn8h25jLixZ3ad+MTAt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mo7nAypP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gG/ZdPvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mo7nAypP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gG/ZdPvZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q94H163658095
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C2vpU+djMgOS/HeGKfY8kZwd/xIc9o8k0Mae6RkgkY=; b=Mo7nAypPes/lIvzv
	xVR7JEO73naddGGHYfHcC7+NItksSdRYHLiTWENtSdhaPPrRmgpfJpg0Gio8H9zt
	cERv4XL7qM1im4bZEHhVx+nZje9XpWmPS6MCVnYZn7XCdOG2BKPu2ancoPKZxyaZ
	A06CMPWJLOCw5WjpJaTMPbgHamf35EpLlKbUYBZUEsSDGqNBpgl/ymClPxaQv3jt
	c+Vf/OoGaF/3mKtXcPyvS4gsRxUwlhKkyNyoumwfCdo/QOrrnhxMxCedcxsUlWeP
	etB92piqhdoM5AE+1SEu03IHOMqPpxNQG5ypXR7ZehpDZpb+gFZIeZHXMb4HD1cG
	VRYCog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqynbhx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-366344513a3so21167806a91.3
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779794529; x=1780399329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4C2vpU+djMgOS/HeGKfY8kZwd/xIc9o8k0Mae6RkgkY=;
        b=gG/ZdPvZfi1V6yWSEA6kBWsIKWsTirafkgDb+MDUxS4aVAahbrtZlIOfsVqieU+poP
         zZoE6myCiJQZJUWDKxD+NImX2nU+JcsPk6qH/k6YWZVmMjEGDO83SRzOUKHtTv5OFL7L
         VGFf99kYHvVGr61yMJ6VB45Lhsnb+AdNUVt1d864+DixAVq2Urg/Zj3xlXb/4mS6x0ws
         PtZwe+hUXL+5sF7LmIfWy6lwqsiD8K70cKyLC7kFxVacGStq/B1QTs8lMtUm9id3u4Sv
         ob1xhs7wZknIKF2LD4GahHfc6Ez8v1oiVBynvTc/bleoU9WIzZ6qx/no+ItRYBLDgfjA
         U0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794529; x=1780399329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4C2vpU+djMgOS/HeGKfY8kZwd/xIc9o8k0Mae6RkgkY=;
        b=DBkDKJ/JvdUYuuBRD3fWsHzwYRYHdCc5OYZCw1/3M1XluaXjgBPBNwm1FbnL5x0Rkh
         DkWHyvCNlcY0RRKRBDqFuGZtNoQVB4TUz8eyJszmAMjfqUPlFnh06BcaoDReUQT6crjr
         ZKBb5ccQEE2xDDu5VQxyO9om+kWh3H4FPMTnRHAjJKwVsMrVixnedTMkkhBJWtaet3ef
         sFLpl8QG1/KBylk4rkzuRM0gcnCJ1neD6QSpE7rTF0uun/nEhvdk0YjEb9XbotmLmmaX
         c5y5J61NSO+VCtgQTlptF+Q2JhnEMMzrwoIx3xVj7/pm24OcoXv4e7qmGWPxwMCvMtxx
         /J9g==
X-Forwarded-Encrypted: i=1; AFNElJ+VH3vAa6Okjx2PHo7igRW4qOCfzmLhzNpVg03WC7kMuMds3zJSW0Tr0ViJ1b1/g3C6R/FE6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/UA8ROml1rdvZhp7ZJVMERNqyzSR1MVrGvx0jjfE4yZlsZAT1
	bc28NU/zpKDSjU8NGMUUS+IDTNSJhs3lFhptD9Ly1QMV6uJt4cdV0eibKhX89I1DRSgjWvOCRUo
	op471msI7FKQBAyD/Up830Jki6i7loRfKNNvTw3p6jEt+FsIb8IqUW4AJGA==
X-Gm-Gg: Acq92OECs3fyuBFcjiIfu6BHv77BgwIh3bGb12yYApZbzVwmJI1HicdQ7WBhcDGJVMu
	BbSim8HOTl/toi63cqlzBhoX9lxsfpqO+v6aoqytSV3tfJEX4ZYXPR5Sn/UNRy8X2DLg+Gq731W
	QmNZFgdajnZfcb5miyzywZqjkV0sqOhHo/L6m5UgBR5R7XNN/gE9kfmjp5aVDLBHCrhCjSItZtH
	zjr+E2FOs1oCn346dLOU8NQTqXl5a2SdgGQDJ291n3Xizvy8YKdoNU8QJOWYqM4LMD0XfYu5HSd
	U3LxJE6pcVR8qphH/tmkDMgQDokvEatBIb/swi5YNol7/M6vqnZiqbMh5vZMv/6ZcQ/31EgJQ71
	4VUklXM2Ysv5RvCbFRQlgii8yO25lvrvTexDn9CMqQ3w+FbYV3UIA6Q==
X-Received: by 2002:a17:90b:3c92:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-36a67626883mr17354826a91.18.1779794529221;
        Tue, 26 May 2026 04:22:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3c92:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-36a67626883mr17354800a91.18.1779794528749;
        Tue, 26 May 2026 04:22:08 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4cd92sm12727620a91.10.2026.05.26.04.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:22:07 -0700 (PDT)
Message-ID: <b863942f-9c3d-ed28-aaae-542f230f8d2a@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:52:00 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v6 14/14] arm64: dts: qcom: glymur-crd: Enable iris video
 codec node
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
 <20260515-glymur-v6-14-f6a99cb43a24@oss.qualcomm.com>
 <pockc2vpoobmhk6pwy5wluekbdgon5ndtltbs7lmq2s2hxwhxs@qp6bhwl5de7w>
Content-Language: en-US
In-Reply-To: <pockc2vpoobmhk6pwy5wluekbdgon5ndtltbs7lmq2s2hxwhxs@qp6bhwl5de7w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Wpwb99fv c=1 sm=1 tr=0 ts=6a158262 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=SF19eQfGBgBI_wA4TrIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: N3VEdo9HlYWmI-X0oF4McT8SxTo1ZBKD
X-Proofpoint-ORIG-GUID: N3VEdo9HlYWmI-X0oF4McT8SxTo1ZBKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5OSBTYWx0ZWRfX/8sP4GdEvR/8
 SWLLy3LJrHJvCLCRuZImWAbRZMxcDLMib6OU8eMRDjlQuGezQbD4VY+BxbbXsdhUgjWblNvqWDj
 nRxuQYXruj5mwrnXCEtmWWBDmJ7nBTFSnpPf2qCX3PiIQ+oP1S3t3VvPXxZXrGPzuzy8V3m2N+H
 1c5ny5w8kh6eBq2gmy6uXdT5lQrl48KKHOXLLUh8ST80sq14ogeaMNuhX+rAArJzk6y6yTgFQ7v
 K8vQFU9upgnvRyn0E9HCDENeqbH+2iiq41O71BfcAbm0CHTUsdfy7DAQlmAkc4B2IwVyp5Ggrzz
 nuw3FH85IMMaBIEfsnxoIVK7BO9YFqZN4g3W8BZoLcKQV2MahBsf13iZNnVhwv9x08bjyvjUGbg
 Iqas9KzlgCEJEz9xPNT8/9rKBP9pT5PgJ3iaelSi8GA/5UcaqvorCNAnG/LJx2GJkVBqL6O2Lft
 1Wk5oS2XpxemsH6GKSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260099


On 5/17/2026 11:42 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:29PM +0530, Vishnu Reddy wrote:
>> The iris hardware block is described in the glymur SoC DTSI, and enabling
>> it here allows the media iris driver to probe and use the video codec
>> functionality.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> index 35aaf09e4e2b..8d6ea857634b 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> @@ -198,6 +198,10 @@ ptn3222_1: redriver@47 {
>>  	};
>>  };
>>  
>> +&iris {
>> +	status = "okay";
> Could you please make life of distributions easier and include
> firmware-name here?

Ack.

>> +};
>> +
>>  &mdss {
>>  	status = "okay";
>>  };
>>
>> -- 
>> 2.34.1
>>
