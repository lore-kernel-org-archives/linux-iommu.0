Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D1367B82
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465609; cv=none; b=mQ+cXKDFs7ogabRohrOztnWaQbQL/ZconHl0VXGeXfj6/TikjTWx7Wv0anDkbtwxM3dkBiwMlDi2641BTt8r3sfMi/ueqNW1d8Tz5MqzBFMdCGOzEfTpuS13o6KnZVQeZG2nNLaFRBFG5bEOseZPckS6wVsfKDVoz+bsJz3gJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465609; c=relaxed/simple;
	bh=0YcqXif0Sc0+zfmEVlu6cC7JsndqG3qCjJYzOwNGScc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g13xyRChFoOGNZlTdZJ9xfayJep9heajF8gkuxQDIfJveUhfCXr1mQUmipEAZjOSS/oryEIq3Tk/b38MYgcZM9TPM/0bDJiYdiSBmKhvd5HO/JJlqIS+RDkkMMiHv9GK5OkH4nVzcGEy8KDmhKQHlPl9JXStNCelWtu0pmseOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8j4zNtb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gS6eWUTc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8j4zNtb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gS6eWUTc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535WH8m1826869
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=; b=l8j4zNtbaNo9Nw2A
	dI861FKta50sP94zsAFz9s/HbxVQJGYtbZTU2VKRrawcVwcmjArJCbq0vLiB7uko
	TqsWqSXPjhAYWSPF5mi1LZCU65HiO7bA10vMCnENN5ctlYxx742kBHkKvrWgFODQ
	X5Xw8JTjr/cBAoH7UvLA1+rBgO2rLZEQFrVs/NTqTgbLtYeXyEGSwvdywLjO90QK
	rUZBHOjPcSqFNwUow8/nseSuP41yZlhym007DBINCXH8wwdLwLK+IlmzKZFXcDYy
	LvqTBWpN4jSXiXqGARQS11F5LpoA+bicR5UPgRXZ7kF47zWEJkUo0G+erkD7mDGJ
	QqVu7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabggupn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:46:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso4383316a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780465605; x=1781070405; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=;
        b=gS6eWUTcMHyOmB1n5kZPB0ounVy/F5r/0tJHVeYK8HvdSHtBsYH0szGESCWdjREDF3
         YF7da42Au4QG6opFRUWKrcnZn4rnWEddcluJS+KBqF+rZbNSVOa5yRR/iq5I/qlgfhXp
         O2v8R2OB68bGTUJI2jQCdmV20TzjJ3L+003Bt7+4CF7S/t1ZpBi8rkrqLCb6FbauLdYk
         ily5o0CYV2Yvwy5q2a1RiiGLHW09JPMZAQ9eDKKL5uej1iySbL4BUJ8n87uVDP2nc3IK
         DBqkaDieL2rjd3arAhYfcPmDMbZnBwe9ov0iKyyww1ujeuhm1PHML3x0JizR8sEstnAJ
         LOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780465605; x=1781070405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ3nOU6oOP2wb3RgvzWm2gp1FwA+8QQfS/PIwJ4FYWA=;
        b=EAsdk9LvHB9rK7AEXAh5koxF8vaTQnCPg+0BLve8p4mNYmMMhQLyeOxvxzfg+4jfrf
         +h23UYHOzZ5azftiBYpV/zxs+zfBhfAQzGXpZAW0TyEq8ad2Bx+UadVbqBngtNzL5d7a
         qxRJo5xBpB+KGE8Amuylme2xCaVh0VVGIPd/gh0dqt7dpqaCHZshAh5PH4BaES/8setg
         thGaUUnyrblTqSVHJNnZ2EGkvQ+eH7yPjnMhYbIrE90rBQN6KVV+W2he/SouMSg08jn3
         Tjl3kikYJEsW0FgiaHEzGL3roHwDpUAj+jb5oZPhyejJcLXlepgBcl24GNBNQKJ7jIh+
         sVTA==
X-Forwarded-Encrypted: i=1; AFNElJ8mr4wSh0k2n5dwo/iBzbQwKg8HGfse+rh+oJxdlBnBipS/cbNNgyzzKcbQ5fg3dZrPvykeqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyye8NcMEQQylmXIBle5fmp2i92/qRes8qupYxVeA+IrQ9i18QB
	waZ8L6VZWEtksLvIchXZMy5XHMQyF7HNf2mqB59IE/sXPWBDsgKyP1pgSmEoS2dL34ejxHeEc3O
	Obk3xIjDVGI6UpWnJq+voRCx4dv8zP89Im0RiMGVQAWquqLiOdzz2vu7EOA==
X-Gm-Gg: Acq92OHQN3cCGCz6KNhRaKlWnIaRH7FXJELz1zknF4ao8YnaSFv7kQjGc5LjpjPwDuL
	Hqa+t8DpOsyA/4ZyrGzqGCYN+VQ7jrlvyvrqwhG35jCef3K8BAV8DuqBD4lUV0AImm6c7NefzHl
	Qdc6mq86cuJjaEVN37pw+5fFQTiDSoFVIEbSqSMuQfesjd0racTfY3RsJ2FgmhQKDHpwLcqOcP7
	PMSWmEU4KYqRhtNA34+KZtlnYQOKNbKbY/HWnHKdMM0owg8Tag1pXhkprM7WxHCHbCFwKOLhh8H
	6s0cFdPU9hSuYzmoPQho6L8M59eBDbkwSyUI3QqxO67ftsnTYdbW08YP+CFhjmfOObRUJ6sCBGE
	SEANDaz7rYURZJWYPpLDU97+stHbcACsXHQJueGTx/hkd+H5nHnEYGrN8Z72N
X-Received: by 2002:a17:90b:3a90:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-36e33bb9354mr1974868a91.18.1780465604763;
        Tue, 02 Jun 2026 22:46:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3a90:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-36e33bb9354mr1974830a91.18.1780465604223;
        Tue, 02 Jun 2026 22:46:44 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ca4dsm10999325ad.76.2026.06.02.22.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:46:43 -0700 (PDT)
Message-ID: <f146f972-6508-4147-86f1-2b88c80e1c89@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:16:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
 <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a1fbfc5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LzV4jstc-Az_XmsxRYMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: ymskrupil5tVhUI0HO1MFixExuTuEYQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MyBTYWx0ZWRfX08prTboMJfHS
 bWfs1f71K9nvoN3zAMM0uIYLZEw7q4YcZhrQpZ5ltqptSHYFRF8+oYWZ2RTySGTHnCQ1kswlOUY
 9rKX+02JXac/a6SEJdvCguVpCujYRHczZS/TeHWjWG0z9BCbRygCp4o2FzZlv/lnQwlSXwSHZRA
 otjibxFZqd4wYtPxPxkJujgsr6ClaVCYbRIittaQbFLdYRKUK0YWzutvDeCXckWd2oqWF8+tE2Q
 8677lor5dtm0iC3AtCLG+rbeDi+EcTteg7PJEsag/Y4/uLXNyxgkSG74YIJgEL3UwAGAJSoX3Ah
 IBr6yS+a1RdH2KftX7mGXf6gBOykTh2Bspe22czc+Tncgk33lP9HuEqi4ouWFaXLPafisk0iWv3
 5OaVaof9TQ9e7tmAA2lVZPv3zPnSktpK7Tt7Wnk+huawbyMPCmAb4/58bWi4RcEXnum6sEZvGeU
 2TCFyXULDpCKCaU0XyA==
X-Proofpoint-ORIG-GUID: ymskrupil5tVhUI0HO1MFixExuTuEYQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030053

On 20-05-2026 19:57, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the QDA memory manager (qda_memory_manager) to track and
>> manage the IOMMU devices that back each compute context bank (CB).
>>
>> Each CB device registered on the qda-compute-cb bus is assigned a
>> unique ID via an XArray and wrapped in a qda_iommu_device descriptor
>> that records the device pointer and its stream ID. This registry
>> allows the driver to look up the correct IOMMU domain for a given
>> session when mapping DSP buffers.
>>
>> The memory manager is initialised in qda_init_device() before CB
>> devices are populated and torn down in qda_deinit_device() after they
>> are destroyed, ensuring no dangling references remain in the XArray.
>>
>> qda_cb.c is extended with qda_cb_setup_device(), which is called
>> immediately after a CB device is registered on the bus. It allocates
>> a qda_iommu_device, registers it with the memory manager, and stores
>> it as the CB device's driver data so that qda_destroy_cb_device() can
>> retrieve and unregister it during teardown.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>>  drivers/accel/qda/qda_drv.h            |   5 ++
>>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>>  7 files changed, 254 insertions(+)
>>
>> @@ -61,14 +62,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	}
>>  	qdev->dsp_name = label;
>>  
>> +	ret = qda_init_device(qdev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>>  	if (ret) {
>>  		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
>> +		qda_deinit_device(qdev);
>>  		return ret;
>>  	}
>>  
>>  	ret = qda_register_device(qdev);
>>  	if (ret) {
>> +		qda_deinit_device(qdev);
>>  		qda_cb_unpopulate(qdev);
> 
> No, this is not how you unwind in the error case in the kernel. Follow
> the established patterns.
Okay, I see your point and the same you highlighted on previous patch.
I'll update this.>
>>  		return ret;
>>  	}
>>
>> -- 
>> 2.34.1
>>
>>
> 

