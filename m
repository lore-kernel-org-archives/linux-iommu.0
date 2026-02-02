Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC643659FD
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033656; cv=none; b=BVG5qOmkTAPZOkKDaXQeuf4cYQO2+pOG6XvCKgBOpqhkNTwGfaTUQ/276miO9YHF5LBY+yk1wProSvJes/mtFDOx0O93OlsPx0c1Gb3iJilMlupUhkMBKcrVt7XBWlsZQrq2q9CKPRxNVFw//Kf4vwL4+BbtcEMUioUFLxEkRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033656; c=relaxed/simple;
	bh=qA+QitnzbLE/kSSBV3KG8t7nRKD750eX4GqJ/cBqYGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7hy/O3V0OF0DwF3bSwRBA7xhyXV4Z3YJKO0rNookAGArLKw6+49d0qcKmPZA0tHuLm9MNsDejpYxeGzVPWN7Q4UPCY8UzCIPyEGDdVEtYBmt3C7JwkPOnbGW7jdMDn36Gb44L+rdeRWlJI0MxmLR0SJ8UK/IHNYoScF33UKEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YjDvOiRu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LrhG5jA0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjDvOiRu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrhG5jA0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6127TnHe4111460
	for <iommu@lists.linux.dev>; Mon, 2 Feb 2026 12:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5bjwTruAGT4usAWtLVsTQrDjs5AyqKQr8KVA8EJfRI=; b=YjDvOiRu4X38E5XJ
	q/k3vxN8oA9LwMiQeoNepcuulBK2lx9I+r7P7A086KCEtm7aIT5xA+9QQ2zI78UE
	fXeQ4XhXM6ZckWTrcb0YPSgqtGtXJxOzRjUJF6WhjOkAUGjXAX5H4o7G8irJE6vN
	YcxI3YKjKH4NpEsHe0RQn7J6q77LHiiPzfRkZlPfQ/AmzwrAFlmiwiH1Qufv29B4
	+Q4oV+3Xtxyz0eefnuxFf6NWe8oA7R+htapfEimiP42ihmbfeLZ6J+ObJ/rENXIr
	q0xud4fetn699bGN+jXzaV9k0anlD8WlQVEwkVKBh0UePmusr0N3aCM6CVn/XlHc
	Ebm8HA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ared7xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 12:00:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso4601009a91.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 04:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770033653; x=1770638453; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5bjwTruAGT4usAWtLVsTQrDjs5AyqKQr8KVA8EJfRI=;
        b=LrhG5jA03g0HsSE1EEw5CbM+iagbYD6B/UPRrR9OiDtjzR1pPwQGczNUFqKJ8w+74p
         gCvrr0khV3fHc9Wrw/76UG87qXKzOnc4De4SYiB+Lsn5eXZVzvkniGfBAz61qHUJe4c6
         GwzC39ZUukuQDfFRjZWIQNyVymlcgzrdxVGwGWhjbX1rDwv1aV3ManpCJq7BUMVAJn6r
         v73LxWrLvAzlbNiQTzoXRbeHp9ImtaA4QGCECmpdwvYPXYMzDl5u8Mls1Tsdznl5lWgz
         xUBMmsoYTGZI5cJ/BCWDLjhBhhlc31q8H/tQyP0pjk4iFWuXWwO08BA/AagmcgWCqrOn
         bWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033653; x=1770638453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5bjwTruAGT4usAWtLVsTQrDjs5AyqKQr8KVA8EJfRI=;
        b=bVrCZbR6rUgyVHzWtDkyG0lLxKF5uZStOseZ/IU781cZWcLcNj9Aefg/2xwwUMG5OO
         95DhkQ+5YwCvXegXtW2ayK/LTibDx+DnSL+ziv2EPeXnHLfaPhxVsZ8OnnaGCHFSznc7
         xtEBKzpMKWAJdZQXlQMLl9+WUcUYEXptEpCxUKxrbEPbZkaj+jUo5Eazp6hLNDpXEQFi
         rezlRLbKOXmCUo8eBux+MoqsHzGbO1qgp9BNZlhOnzgJo6ZUmgK50hd4Wlkd+4SDz6Fl
         oAGGx/f0vPKvIDO/2+vFpgUQhMGTzhCBnuNln5chFZvJoUnGmRBmYcGw34uPO9ou1Zf/
         0lTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxia27cv58eOkmqNZaS/1Z4VEXsx8tFCuNkw26z2lUGwpEHcxhtYjTzxeHKNhUibVRPeZQjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4Z87yHOD+9hGK5a2fCQ0XF3O2VkB4ivnvYA75R26k8SqxmZ0T
	YeB4Nm3PLJ7jo9WmX4WZOYbUAUuyhryzp7VEgz+Y+pgE3uGXi6mX9YsVST96tdfiXs2yCdyxqZf
	0gPPujhUnXqWK2WunaIj9WnZBF+E5VuWJ5m98BQke18w9DCkz9J7Hemeqzw==
X-Gm-Gg: AZuq6aI1oQPnAtGQeQj6ksqjI6fbU8LUkykQ4i2Cg9CaMqvZS3MBlSyTdZFhkFWHwZW
	NveHBrknnJTfir1sUBW4XBev7I5yoTOsTh1So49jTILN0ozD5xrYBk2gyVN2DuQBesFL53fVbr9
	davtFic0ewCxllsWGexHP62WOH19ghj8XzUaatLzl6MTz/62aOSqJqHfduSOI55cg8Y6KZvq3da
	9p5eT+6dcd90eifuzI2xrjhv1NsNCIUgQX16YvtTPzmI/+zb5t0fy2z8dN5bf9vm8mAF/NdzC70
	bjv2+/mCwGo9EH94J/a97XopRs3mJ/9z5YjbKrzR5N6gHa2GoChNHWXXSvVYnLbN0IIAjVpRQwU
	sFhR6RH0TOmZqLoit/mJSgY7aOMNoY5qoRqGr3k1hBQ==
X-Received: by 2002:a17:90b:268b:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-3543b2e003fmr9436106a91.8.1770033652502;
        Mon, 02 Feb 2026 04:00:52 -0800 (PST)
X-Received: by 2002:a17:90b:268b:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-3543b2e003fmr9436072a91.8.1770033651918;
        Mon, 02 Feb 2026 04:00:51 -0800 (PST)
Received: from [10.204.100.98] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24ccsm20194527a91.8.2026.02.02.04.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 04:00:51 -0800 (PST)
Message-ID: <74150529-9ace-443a-aa00-2490b0897574@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 17:30:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] media: iris: add context bank devices using iommu-map
To: Robin Murphy <robin.murphy@arm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-5-e2646246bfc1@oss.qualcomm.com>
 <02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=698091f5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=8ZOrhM5FIgLh972jGGIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2E9Qhvf3KdGEAk7lWgXAQXGSa06OVujI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MyBTYWx0ZWRfX50KgvewuyEyv
 DEIVFunPsDL3lzeFJw6oI7/amps4igx+uKAbj9w4Gh/jrMjrAbHRw1LL1gM3PJSjkiK4DpNBWuZ
 9mDZJZsN9AQwsySSdDdtfMHVjcCLlxLNwZu5ZIJ4/Et855RHYhZB3GXFFu/tX1PIGExt/w2oXE1
 +mPZljEJis2giWu5fFPosvw2Ra3f982JWTo7vF2ptD1HiMTS0delWrPV1dTpAqpR+ybmK0+q0rh
 4yfBcsqDFWfC09q4Yjrek7ZNTsV3aO8bMlWPxvvOopPCTLZUBlEEvy9zHDUFh6oEmymztlxt2Ma
 NQXKZQ2oi9tOYKAC8eUJwZs5YT7K8BhZWwRAtI/PUBQGERyih6D/l61mF4uDOYf8d91dNAVjyFI
 q4bihKnU2LKVss/JuR6y2xYBLlmSB6wnmr33x6oPvdH4/qNPVBOV0F1euUWUUhiomAsCjuMQhxp
 q06ajX+oyhFuZssP90Q==
X-Proofpoint-ORIG-GUID: 2E9Qhvf3KdGEAk7lWgXAQXGSa06OVujI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020093



On 1/27/2026 8:19 PM, Robin Murphy wrote:
> On 2026-01-26 12:25 pm, Vikash Garodia wrote:
>> Introduce different context banks(CB) and the associated buffer region.
>> Different stream IDs from VPU would be associated to one of these CB.
>> The patch ensures to handle CBs which are described as iommu-map in DT.
>> Multiple CBs are needed to increase the IOVA for the video usecases like
>> higher concurrent sessions.
>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../platform/qcom/iris/iris_platform_common.h      | 29 ++++++++++++
>>   drivers/media/platform/qcom/iris/iris_probe.c      | 55 ++++++++++++ 
>> ++++++++--
>>   drivers/media/platform/qcom/iris/iris_resources.c  | 35 ++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
>>   4 files changed, 116 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h 
>> b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 
>> 5a489917580eb10022fdcb52f7321a915e8b239d..d2d7c898fc8ef0de1b16aebd72681ea3c5b736ae 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -204,6 +204,33 @@ struct icc_vote_data {
>>       u32 fps;
>>   };
>> +enum iris_iommu_map_function_id {
>> +    IRIS_CB_NON_SECURE_NON_PIXEL    = 0x100,
>> +    IRIS_CB_NON_SECURE_PIXEL    = 0x101,
>> +    IRIS_CB_NON_SECURE_BITSTREAM    = 0x102,
>> +    IRIS_CB_SECURE_NON_PIXEL    = 0x200,
>> +    IRIS_CB_SECURE_PIXEL        = 0x201,
>> +    IRIS_CB_SECURE_BITSTREAM    = 0x202,
>> +    IRIS_CB_FIRMWARE        = 0x300,
>> +};
>> +
>> +enum iris_buffer_region {
>> +    IRIS_NON_SECURE_NON_PIXEL    = BIT(0),
>> +    IRIS_NON_SECURE_PIXEL        = BIT(1),
>> +    IRIS_NON_SECURE_BITSTREAM    = BIT(2),
>> +    IRIS_SECURE_NON_PIXEL        = BIT(3),
>> +    IRIS_SECURE_PIXEL        = BIT(4),
>> +    IRIS_SECURE_BITSTREAM        = BIT(5),
>> +};
>> +
>> +struct iris_context_bank {
>> +    struct device *dev;
>> +    const char *name;
>> +    const enum iris_iommu_map_function_id f_id;
>> +    const enum iris_buffer_region region;
>> +    const u64 dma_mask;
>> +};
>> +
>>   enum platform_pm_domain_type {
>>       IRIS_CTRL_POWER_DOMAIN,
>>       IRIS_HW_POWER_DOMAIN,
>> @@ -246,6 +273,8 @@ struct iris_platform_data {
>>       u32 inst_fw_caps_enc_size;
>>       const struct tz_cp_config *tz_cp_config_data;
>>       u32 tz_cp_config_data_size;
>> +    struct iris_context_bank *cb_data;
>> +    u32 cb_data_size;
>>       u32 core_arch;
>>       u32 hw_response_timeout;
>>       struct ubwc_config_data *ubwc_config;
>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/ 
>> media/platform/qcom/iris/iris_probe.c
>> index 
>> ddaacda523ecb9990af0dd0640196223fbcc2cab..c1a6aac5a3d65d980c5a34ba5fa1c1dbcf790ec5 100644
>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>> @@ -123,6 +123,37 @@ static int iris_init_resets(struct iris_core *core)
>>                        core->iris_platform_data- 
>> >controller_rst_tbl_size);
>>   }
>> +static int iris_init_context_bank_devices(struct iris_core *core)
>> +{
>> +    struct iris_context_bank *cb;
>> +    const __be32 *map_data;
>> +    int tupple_size = 5;
>> +    int i, j, ret, len;
>> +    u32 fid;
>> +
>> +    map_data = of_get_property(core->dev->of_node, "iommu-map", &len);
> 
> If despite proposing all this hackery in the common OF code you're then 
> _still_ going to open-code your own parsing of the property, with hard- 
> coded assumptions to boot, then clearly this is not the appropriate 
> approach at all...
> 

Ack, we should avoid parsing this in video driver.


>> +    if (!map_data)
>> +        return 0;
>> +
>> +    len /= sizeof(__be32);
>> +
>> +    for (i = 0; i < len; i += tupple_size) {
>> +        fid = be32_to_cpu(map_data[i]);
>> +
>> +        for (j = 0; j < core->iris_platform_data->cb_data_size; j++) {
>> +            cb = &core->iris_platform_data->cb_data[j];
>> +
>> +            if (fid == cb->f_id && !cb->dev) {
>> +                ret = iris_create_child_device_and_map(core, cb);
>> +                if (ret)
>> +                    return ret;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int iris_init_resources(struct iris_core *core)
>>   {
>>       int ret;
>> @@ -139,7 +170,11 @@ static int iris_init_resources(struct iris_core 
>> *core)
>>       if (ret)
>>           return ret;
>> -    return iris_init_resets(core);
>> +    ret = iris_init_resets(core);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return iris_init_context_bank_devices(core);
>>   }
>>   static int iris_register_video_device(struct iris_core *core, enum 
>> domain_type type)
>> @@ -187,6 +222,8 @@ static int iris_register_video_device(struct 
>> iris_core *core, enum domain_type t
>>   static void iris_remove(struct platform_device *pdev)
>>   {
>>       struct iris_core *core;
>> +    struct device *dev;
>> +    int i;
>>       core = platform_get_drvdata(pdev);
>>       if (!core)
>> @@ -194,6 +231,14 @@ static void iris_remove(struct platform_device 
>> *pdev)
>>       iris_core_deinit(core);
>> +    for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
>> +        dev = core->iris_platform_data->cb_data[i].dev;
>> +        if (dev) {
>> +            platform_device_unregister(to_platform_device(dev));
>> +            core->iris_platform_data->cb_data[i].dev = NULL;
>> +        }
>> +    }
>> +
>>       video_unregister_device(core->vdev_dec);
>>       video_unregister_device(core->vdev_enc);
>> @@ -277,9 +322,11 @@ static int iris_probe(struct platform_device *pdev)
>>       dma_mask = core->iris_platform_data->dma_mask;
>> -    ret = dma_set_mask_and_coherent(dev, dma_mask);
>> -    if (ret)
>> -        goto err_vdev_unreg_enc;
>> +    if (device_iommu_mapped(core->dev)) {
>> +        ret = dma_set_mask_and_coherent(core->dev, dma_mask);
> 
> Huh? Why would this be conditional? If it's a DMA device then it's a DMA 
> device, regardless of whether an IOMMU driver happens to be present or not.

added to support existing DTS which have iommus property. For parent 
node, not having the iommus property and dma_set_mask_and_coherent is 
called for parent device, it errors.

> 
>> +        if (ret)
>> +            goto err_vdev_unreg_enc;
>> +    }
>>       dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>>       dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/ 
>> drivers/media/platform/qcom/iris/iris_resources.c
>> index 
>> 773f6548370a257b8ae7332242544266cbbd61a9..647f6760f2b7a6bab8a585a13eb03cf60a9c047e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.c
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/devfreq.h>
>>   #include <linux/interconnect.h>
>> +#include <linux/of_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>> @@ -141,3 +142,37 @@ int iris_disable_unprepare_clock(struct iris_core 
>> *core, enum platform_clk_type
>>       return 0;
>>   }
>> +
>> +int iris_create_child_device_and_map(struct iris_core *core, struct 
>> iris_context_bank *cb)
>> +{
>> +    struct platform_device *pdev;
>> +    int ret;
>> +
>> +    pdev = platform_device_alloc(cb->name, 0);
>> +    if (!pdev)
>> +        return -ENOMEM;
>> +
>> +    ret = platform_device_add(pdev);
>> +    if (ret) {
>> +        platform_device_put(pdev);
>> +        return ret;
>> +    }
>> +
>> +    ret = of_dma_configure_id(&pdev->dev, core->dev->of_node, true,
>> +                  (const u32 *)&cb->f_id);
> 
> No. As I already said before, of_dma_configure() is for bus drivers; if 
> you want to act like a bus, implement a proper bus_type with 
> a .dma_configure callback. If you don't want to do that then describe 
> the individual functional blocks of the codec appropriately as distinct 
> devices with distinct hardware properties so the platform bus code can 
> handle them correctly. It is not reasonable to advertise physical 
> hardware to Linux as a single monolithic device, but then have a driver 
> try to pull a "well actually..." by abusing all the internal 
> abstractions. The fact that you might happen to avoid the warning from 
> iommu_probe_device() because you're not binding drivers to these fake 
> platform devices doesn't make this design any less wrong.
>

VPU would have _only_ distinct stream-ids for distinct hardware sub 
blocks, would that classify them as distinct devices with distinct 
hardware properties so as to use platform bus ?

Here is what i posted earlier with "iris_non_pixel" as one of sub-block,

https://lore.kernel.org/linux-media/20250627-video_cb-v3-1-51e18c0ffbce@quicinc.com/

Regards,
Vikash

> Thanks,
> Robin.
> 
>> +    if (ret)
>> +        goto error_unregister;
>> +
>> +    ret = dma_set_mask_and_coherent(&pdev->dev, cb->dma_mask);
>> +    if (ret)
>> +        goto error_unregister;
>> +
>> +    cb->dev = &pdev->dev;
>> +
>> +    return 0;
>> +
>> +error_unregister:
>> +    platform_device_unregister(to_platform_device(&pdev->dev));
>> +
>> +    return ret;
>> +}
>> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/ 
>> drivers/media/platform/qcom/iris/iris_resources.h
>> index 
>> 6bfbd2dc6db095ec05e53c894e048285f82446c6..b7efe15facb203eea9ae13d5f0abdcc2ea718b4d 100644
>> --- a/drivers/media/platform/qcom/iris/iris_resources.h
>> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
>> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
>>   int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>>   int iris_disable_unprepare_clock(struct iris_core *core, enum 
>> platform_clk_type clk_type);
>>   int iris_prepare_enable_clock(struct iris_core *core, enum 
>> platform_clk_type clk_type);
>> +int iris_create_child_device_and_map(struct iris_core *core, struct 
>> iris_context_bank *cb);
>>   #endif
>>
> 

