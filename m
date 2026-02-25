Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027F3D3487
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029229; cv=none; b=D5467gAd4NqvLOHs5bEw/sb6+4JgCT1MFWTQ+cYq2/NzcEK/apn6BAyjGgwd3XwTYvEpDu1S3g/cIQtDasOsCu75uiqenhl2YGKcNO3ZK8V4qWD68Drmtk/xjSDyrCYL8Aj71FYSwFGLpOiX1D4EYLYCQ/+r7nUcM3Pz+84Hk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029229; c=relaxed/simple;
	bh=HoX+77Ou1KVRWuj52NLOpoMqo5t3Lt0ZrveaYtMn2MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqGYWFMP9KU0fcnYwnk4Mz72Js4PLFR6S01ciUVnyHH4zJwplGbMChn1+R6KbFS9rfMag+AZ4fFp43p0YYfFHouqwlYqIYJXuYrlxMx1nlSBjGHZAsTIcU1yEGLGRz16Km1nqO67414Guu2V+p1x2/bbVZ+NM0nULownFhsrF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lCLZuHlf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+SbBRtZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lCLZuHlf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+SbBRtZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SCcA806692
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EtyOE2hUVljy+kbFE5PibxyFcc/R7aXCK4PQrjUFn2o=; b=lCLZuHlf8TyAjJm3
	u3rme9fFAEMEi7u536FDPUL5nlAy5jiQp4VpF1GwY2/RJhELgyk1DwwPJRciUo9f
	G6UtslgOw5RylV8+vIzZxzMkscSgIcWthwhfKep4VCv3qiZH2jlFNOMtWoa46lcX
	6KcSkfDa2N+ZoxRrbkVfKOoXzCQaocEd0HhJDFA+sXLsHChPj9nrDPFepT1nqWVI
	IZ36rErEHBHfnY7GWhBi1tYt4FOiBTs7/fvZPcQLxGXvO1vVknuj6NlwUVlasWB5
	3wFujOQ6K2RIpoDNlYCvW7z0Q1Es0jss86QZ/6e/PluRBy/m1UvZ3r/40OqsZ3/M
	2XHL/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chr5p9vgp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:20:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so87051085ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772029226; x=1772634026; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtyOE2hUVljy+kbFE5PibxyFcc/R7aXCK4PQrjUFn2o=;
        b=W+SbBRtZlS46EyL2BlB6VyuKlGnlG5R8tICF5xjp9cUZLwGCDremLAAw7aeaQAdWbx
         vxhf3ja+OzbL/7rwI0LKcoysK2kAJprAR4OAKAv3iQ97pDl0705LWi6JEFZ9+L6KbCej
         ojLk8sGYVQkeq3XD5WtfV84Cg1V7n7NggYxsZWxPEcstnKHrRucclPNcYTs4oUFJEupJ
         mUUcbpVFn08jp7ptLJuBYZqYESlIeHIuiABoziSVQ9CUcKcePZmpGBC/U2uUX01lY7C1
         YybWXPl5/SRMrxBfDQFBQk5RpxXyWkYGGCYw5i3poaU/fxTcN4sOoefDgLfQzHWie+Nx
         0BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772029226; x=1772634026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtyOE2hUVljy+kbFE5PibxyFcc/R7aXCK4PQrjUFn2o=;
        b=TjTXyBMGkTm24BgQhCYZTVAi2MpWIR9b3WLhlqNLVvhvFJQnbMhmo0UyI/9hoXpogf
         tIFdkoc+DazolKM0EjhngKfhs9m/AbmsHTHv2qT2xlt4Xmp79y6XZsKGL6s9lgi0k/w1
         mEqqqxCe/3xn4kkaMGCHfw1LiGV3rXdAYsyl1BcSvk2D4MFzYLU6qY7OiQIzA/iCB7NX
         A3ZUelvreKn3pRvHuN9un6LQGaER7nsLmxPxSWXazJlxGx+Ujm4A27vp40RA0TpGU04U
         AsOh5n8qvQKGflVAlMSUv/26rCcn6QuCtPPlq212mA4NPEJdc443wO1RpVZGqnD0T3N/
         gxfw==
X-Forwarded-Encrypted: i=1; AJvYcCX6lXno+loCUf3qSGYiXAxjbLNR+ez2qeB+kZ42F/O/fUgMXdz2xRezhBRVbz2xMeRLeMA/Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9L+qe8QKVUFAU97V9UHqsRdpYa5wiIacKMWFjIS2Zv58QjMPK
	8ZHkthVOiJ2WJJcMLLpOz409IhYXSV+rA+io2IuAj0v5nKF2JH/P2jLU+h/lSV9rPoWJUyxjkV0
	+H9jx0Oqo0jw0vL9onwuaACeROhsvfyYiZW8NXpRo6BL4YwmpbPekuMlhBQ==
X-Gm-Gg: ATEYQzwTir+70aSeK7zTT+pHQihSFwM0FYmJLoK8Xesb+yAvdSEnmSF/P6ttF5qGK1l
	xixfFmBPB042RW5D0m1E8iW6hys7JyhemAg4gE8+ayvKYMbO/kGwXQ//2Q0jgjcpkLj+HDapjS0
	F6N+Mmim47QIJhe48rv58S+5CMU86mkXxG2jYFYDxqDSohpVLe/41kqlSbBeSEvX4pPuBpHrQDY
	YFe1B2l4RdwcazwnSnLCNAVOKRUAp/pU3JDjutSl2MCS/cx0/WBKCBIByELs/6bHDnEiMMYOz0r
	fzhRHjSOSIu17Tdn6W7pOd0vMX/GJ1QKfNuQirhT+7G/NzJGdeeFgWeg8mUVIBv3yhTeUI00Ekk
	r4/ulbqy/UvTfN3zmq9+E8FTbsb4HI9lJQdyjSQgHdUrTA6MdfsM=
X-Received: by 2002:a17:902:d485:b0:2a9:2ab2:e50d with SMTP id d9443c01a7336-2ade9aa21a7mr3608435ad.51.1772029226464;
        Wed, 25 Feb 2026 06:20:26 -0800 (PST)
X-Received: by 2002:a17:902:d485:b0:2a9:2ab2:e50d with SMTP id d9443c01a7336-2ade9aa21a7mr3608015ad.51.1772029225935;
        Wed, 25 Feb 2026 06:20:25 -0800 (PST)
Received: from [192.168.1.5] ([171.61.227.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5e55dsm142051345ad.30.2026.02.25.06.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:20:25 -0800 (PST)
Message-ID: <b6519bfc-7931-4985-aaf1-1aaf1fe5aa88@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 19:50:17 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/18] accel/qda: Add Qualcomm DSP accelerator driver
 skeleton
To: Bjorn Andersson <andersson@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-2-fe46a9c1a046@oss.qualcomm.com>
 <elu44euja7d7nnnhdmdqgof76646b3m3isjmws5pr274gqhy2a@dbeq4hk74ebo>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <elu44euja7d7nnnhdmdqgof76646b3m3isjmws5pr274gqhy2a@dbeq4hk74ebo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzNyBTYWx0ZWRfXwJEmglslOmz4
 cwxvc8ont6/SMyFbduOYFfCvdys8FK/lVnKy28tpXliMgzyUxczmFbGiiRogD/fcVfSQTLyxb9d
 UjXZSTUCjU0kInZ5Ajy5e2gfn/tjfAMuPzS5+WLe4666WzfA4pxEv2GCUNJq9r3dtzOmKg/a9Ef
 EiAzsquLzwul0vvg8+iyotPotzCW1PetrRLGC4evXatIhgcvMcw9Ijtw3Ku/tGAZywRitUl2eEc
 uX8TSIykb1TXhU0XfOb6X5CN2zB4cCMX5zpFj8ncMyQdw8sjJlEqSprqDBy7Ogm7z65l8rEntJH
 bV40daJNnNxjum0Zkknf/32PegHDv6eLKnD0o0FtNGmoqkRzG395CugPEPmmnvcgfg1KbSYEQxy
 gsXpaKV6yrI4ajMxkNmfJ0AjhI+GyDx2/L3FR7LnwHRd1f6+tdRyIuQmbi9XhKzJb5WzsjN34DL
 wmT4WzZKoi4UHfacUDw==
X-Authority-Analysis: v=2.4 cv=GstPO01C c=1 sm=1 tr=0 ts=699f052b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=CLJ8B99oKJtQbdnoKiLypA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=tV0izz4fD985yFSgC6wA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: v4qSkzdMaCUMiq-JHmxcJ3u2_w53vLPy
X-Proofpoint-ORIG-GUID: v4qSkzdMaCUMiq-JHmxcJ3u2_w53vLPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250137



On 2/24/2026 3:22 AM, Bjorn Andersson wrote:
> On Tue, Feb 24, 2026 at 12:38:56AM +0530, Ekansh Gupta wrote:
> [..]
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> new file mode 100644
>> index 000000000000..18b0d3fb1598
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +
>> +static int __init qda_core_init(void)
>> +{
>> +	pr_info("QDA: driver initialization complete\n");
> This print is useless as soon as you make the driver do anything, please
> don't include developmental debug logs.
>
>
> In fact, this patch doesn't actually do anything, please squash things a
> bit to give it some meat.
>
> Regards,
> Bjorn
Ack, will squash the next commit with this one.
>
>> +	return 0;
>> +}
>> +
>> +static void __exit qda_core_exit(void)
>> +{
>> +	pr_info("QDA: driver exit complete\n");
>> +}
>> +
>> +module_init(qda_core_init);
>> +module_exit(qda_core_exit);
>> +
>> +MODULE_AUTHOR("Qualcomm AI Infra Team");
>> +MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.34.1
>>
>>

