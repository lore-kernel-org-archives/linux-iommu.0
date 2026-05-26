Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEC3DE450
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794524; cv=none; b=CoLunLrdw5Y9JpmjNAvXh9JtSZhsg7DK0OKML0Q6E7i45FdtQTfav7Qo77SGOpI8tpPGFQpDlNscRxkFSjDGc2OAwH1ntviAp4q+QY6SS3e0mAE8spBUXPss3Jm4kKBzSsoXtDoJSQpAJhVf+MSHpHKN49eVFhs0UKpdsnDXvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794524; c=relaxed/simple;
	bh=XJ2u4rAlFKqf3bCwOxTrOirn6TiVORyvCT7JY+6a+I8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YtzlKgzVnH4Xu8LrknKgd18U6ElQWLzvHB8lwvAQCyhuko8O686aaPoA7E9+rgLgUv/0ZjoXONmUu3aap2SBzDkrcni3wpzJrO0G1epmzAJixTiDAiRffTGqp+gPY1udpdTzRhEoeyYBRLWM7pJRE+tjSGvecY831G/l8r5gUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhvaZp1o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AzDIOWKU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhvaZp1o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AzDIOWKU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q601Y31605273
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqsxV/xGmwV1+pwo9CefvjlaBlQyBYs9ZVzmmhLZlaI=; b=ZhvaZp1oPmCOLsQv
	wXGFKPi1dhW8ElBOcdPs7ThevrfynYs898JSbA2082a5FJdxfPj46sJEWKlRKBlZ
	rcw9pnpTo13ZU2zklATcUV3BbSnk4FtdnXI6Xoa/F5UPLFGybmlIh4uLBJZjXTCp
	M0ITFUgjW4IHCKAYUrTDI9ODwZ+1hMywyPTLjsiPnaTCwiwRoe2aOx1qoHawsiKv
	Y4GeEmxpDHiGRpnX+WUjm5NOq7nGhjK1OrRDScnwCqEE+bb6Yv6jPV5LvADIf9+v
	+Ck/4PT/pDZ0sPwLG1JR0EMLF5n5zoP69kfknea3BZ1L/cTtRkV2SvvJrQBZvZI2
	QDEvAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5v3s8f9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 11:22:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c82751074c8so15325041a12.0
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779794521; x=1780399321; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqsxV/xGmwV1+pwo9CefvjlaBlQyBYs9ZVzmmhLZlaI=;
        b=AzDIOWKUX45Lhw2LJkiTtqTgtQvM+jHnVeBbQ8vRfaZaRidmwRFoRseUN4whdDRoyk
         NtDWqXJ4d5F2tbbVn86N18tlBhLgW4BUrM91OGvz8bw7CNu7XCQUbYuyWpbZKd+XCLy/
         8oTwdUgw6c0PLWPkXErQ5f+Ww7g8MGW7dLK+CRQInsRZxerjQXrexsQQDLxAjac73rJm
         xrurR9zj9Z1IFBR6JuanzJouFl2uB523d+CwYl/YE1k4Hb4o2QWb8uViy0pAT1nl+uMn
         kFn5md89+EvWv3ZEysYfaUCEITABqSg8uAXThryEhowUggyIYiNo/S7JLE8C4i+yZwnI
         E1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794521; x=1780399321;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqsxV/xGmwV1+pwo9CefvjlaBlQyBYs9ZVzmmhLZlaI=;
        b=NcjiPdhIVcNbSGcDc4XS+ezmimmLa2GwL2mtyKznF0MrUoFDlV+Nj6ZwQ34c6Jup5d
         iHksNfyP45x0LoszNy9OBZhUgzC3FZagaGS+T3DHj8p+jHjDW73XlIT1P09AHOMaavxY
         XIJS9IrbUMDhmAnilIwJgv+q1i9HFV87Y+2nGNwSpd50HLAbzZsoFv0vdQEuTpguF0Lp
         cCS4R2DyX00iMJtkBT6gLNji+HyNwE2RyZAyF2YxBLCijSmS1KzoR/SR5+Ta76zWSBbM
         0eWrGrZ0QPGtXgu39ut+HLwWYpGTneAjlJl1D4ncxvFFIqNuWze/Y2Kv6n23OQ5vjGCW
         U+tQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NPBNIkzmVsVTqzSNBohi4RFTAYNUuopVOtEGdIUKcF4v1O14wZb5mmZBBG1+0DWJr93stFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4cHBwWlElO7ibVdcAlMqJS2JJ9WQdkKwDMJnszf8P9YK1GBOI
	jghgfOplVVM4o0m+fVcplkAljSf6gX6MsupQkOLlSgvBXSmweYeByKhe1KxfqIQJPOoNxfgzSpI
	pm7HMNrwrnrkotesp0a6ZnalX3W2dLCQVZRTJjnDWRBlgILDVQt4YYvmmbg==
X-Gm-Gg: Acq92OFg4IBUsn06Rh7yNajo+NwUnZKh12palSLy8TOG7WPyq4TB1WD7sDHbjSVb95m
	oTC6bHZoc4XcEE9ieUYcqfsSUpWPyYVC+ccXpXBvnj8keDQJZrJqjeD4kF+PHI5SVR4uK3C1vwc
	h8XdD+f8zCohlw1yCtrRbZOjhDrD5l1p94Vlsi7jayfKqvTX6b5HPyxN/L5E5G6u2Vs5qkq6iqP
	okx/yYJZ3bxW/qGJH1YsvIVbqsQTbR/CwwGPrFRne7QNA1G4Cmpdd0+rh/kG5VjbRHxGss70OdS
	t7vgFR900mCgDtYCZmg/NyvBlbgmrgTG726nwOIx1GOjLEH2sXTtC8dcl0paxcVVC9ZT+3bHA7p
	a5VGcTlJ/qt+5J5AT1b+6gjop4Wa2r4m4aAJWYQ5WI8dO+jCyiElS0V3zieOZYFqp
X-Received: by 2002:a05:6a21:68f:b0:3b1:a9ce:5095 with SMTP id adf61e73a8af0-3b328d940ebmr18161088637.22.1779794521413;
        Tue, 26 May 2026 04:22:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:68f:b0:3b1:a9ce:5095 with SMTP id adf61e73a8af0-3b328d940ebmr18161060637.22.1779794520961;
        Tue, 26 May 2026 04:22:00 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852057f9cdsm10331123a12.32.2026.05.26.04.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:22:00 -0700 (PDT)
Message-ID: <b1888f5c-2613-99ca-ee12-fb4717a40731@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:51:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v6 06/14] media: iris: Add context bank hooks for platform
 specific initialization
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
 <20260515-glymur-v6-6-f6a99cb43a24@oss.qualcomm.com>
 <sqjbcmcy3wohzdiftb36i7ztfyt2k7mnxkrzxk5yuocpe7kfy6@ev2ouxxnf6cc>
Content-Language: en-US
In-Reply-To: <sqjbcmcy3wohzdiftb36i7ztfyt2k7mnxkrzxk5yuocpe7kfy6@ev2ouxxnf6cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5OSBTYWx0ZWRfX2Gi5Xic4vhd5
 j8FsBfT83Lyh4TgpiYsc+FqPU9ohgo61rOpow1moKKrnhLE13mqEWpPQa9VMPhWLrXMFrCgdaVM
 j5QZ/sgAIXsPvNR6pvqaN8vzqSqeyJTbMcvJWTL+0CX1PCPLDrBMYoxnXne8hBol5w87bwzKBEM
 96E+HZ+zD9/+jvA7msfjZ4jlkYUyfOOKcalmeJqBmZ7K30hIXmvr5eKG67HCW2ApUeKigy94OTh
 wnsyBKSIryN/XCTr+yOlDcOh48OCwjPfavhjModmE6VmbwM3aeXhQ7MmOCR28w9pcBjno88b45v
 +DrJj0J3VRXn9XkpYQs1mrqiEFtdnVTD1gHRE/e2LtyyJZUwVC/oTWEzR6rrX6B+/vlmU3HlTRK
 ZtHKrpoe9vp7EITsNyzQND3CQJJPSkQihfgMuN76rQFkI9DXmooZ3mH82zFSZ6rJzSrmKWxZ33+
 j+vjv55HkBN/8CsIF6g==
X-Authority-Analysis: v=2.4 cv=Zc4t8MVA c=1 sm=1 tr=0 ts=6a15825a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=93t1r52Nw9wdlAKC5OAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: wxduUmWEFlPfvkWLlo7Anp6qxJFJ82Rc
X-Proofpoint-GUID: wxduUmWEFlPfvkWLlo7Anp6qxJFJ82Rc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260099


On 5/17/2026 11:05 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:21PM +0530, Vishnu Reddy wrote:
>> The Glymur platform requires a dedicated firmware context bank device
>> which is mapped to the firmware stream ID to load the firmware.
> Why is it required on Glymur? Is it _only_ on Glymur?

It is required for firmware booting on platforms where Linux runs as the
hypervisor (KVM/EL2), where the driver needs to manually manage the firmware
IOMMU mapping via a dedicated context bank device. This is currently specific
to Glymur.

>> Add init and deinit hooks in the platform data for context bank setup.
>> These hooks allow platform specific code to initialize and tear down
>> context banks.
>>
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>>  drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 6a108173be35..84fc68128c70 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -263,6 +263,8 @@ struct iris_platform_data {
>>  	 */
>>  	const struct iris_firmware_desc *firmware_desc;
>>  
>> +	int (*init_cb_devs)(struct iris_core *core);
>> +	void (*deinit_cb_devs)(struct iris_core *core);
> Why are they being added directly to iris_platform_data? Why not the
> vpu_ops?

Some vpu_ops are shared across more than one platform because of same
power sequence.

>>  	const struct vpu_ops *vpu_ops;
>>  	const struct icc_info *icc_tbl;
>>  	unsigned int icc_tbl_size;
