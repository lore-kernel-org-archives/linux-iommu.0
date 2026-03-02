Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0689387572
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439324; cv=none; b=SMSPu8fhZMNSNXqWR/lkbR6e5cb9VqZCu7SVvx7QFeV5mOnVbB/qQJXwwBlysUFWXJGig4AYAl0kDB4lXe7Wd/n2lxUfTxIQnV1RwuDHC6KD/x2pC9Mza5xF+LG7eWI+/N1j219cFcWYf83RjJ1mbwpAKXYujZkmOB3Qjnt0hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439324; c=relaxed/simple;
	bh=z/OjeLU/BgW56NOv04DU8XYhWIRJ/b3uSHrxF7ye9+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXxYfIvAw8goMNdsIVyhl92AYtZHMjLLliybJxD2mrDshm4URccw0wOddZLqL2f7i47rPcGYDy56mTIySRwTFpo+icTnE4JKvu8QrZDqvWfIa+hreb7l3XszdtkeDhjAc1hnnR6r5xtJGOg7Kdyw8kKpyw62G6na2s5sxhcZB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipmP+1UO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ab/G+HH8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipmP+1UO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ab/G+HH8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227JGoa2358125
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1nxlvKtWHlixlnWM7lk5L+nk5CDxPToMPWa0ATJIt+U=; b=ipmP+1UOIkbkHrz5
	4Zh5zcejX0AEK4qWy0UQjcCFbrK7VJKAgWA2ZJ+yrMI1JZRb+MYGUxihgsBrJdvu
	dvEsH9Lyyh56EIP2l2/7mw5OHLnTHNZqC10WkhgzC74NlRMcT0BEoBinGtL5Dj9H
	eGrnwxMXT/K9CL7f6sG8CgdUghPuGyzXdkJMoFw04R/N2URMbdxQtDe9in8qrJ51
	tbqk52bdQkuOU+H9AxehKcQ/pjSxjsfc1xNC/DvenXdB2VqfLs3YaYnqy5eG5C/u
	wenPMG+sP7wp9rocb3lxPS5efhm3jHsVbc3cG9Lrok2jOZnioUctBTMXKlsf5411
	Q9pBtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbate4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:15:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3598518beceso1180867a91.2
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772439319; x=1773044119; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nxlvKtWHlixlnWM7lk5L+nk5CDxPToMPWa0ATJIt+U=;
        b=ab/G+HH8Y5OjeyJhP3MlczQ+w9pUkiE/TmNrhf9Ir83xGDkOooaI7sqA5hKUT8YvGD
         Oe4z1X7UgrGwbjw7rBSl6/aERMrDbh0eV6lAg4WnS3w9z3FqWjws9/nC2kD79Rt9/A+k
         YAeZp1kag58Ya5qHS1LB9GhpQgq5WmRhCvx0BURJqPFw4Cl5sNV4ftwFsWTh7y8pdEI0
         IpuIYrLSZ39IS323LxdW6ObHGBpWtGu2tuHwE2KPlc2UB5TBMsSrtec1QXkjOQ2a7p+W
         tjNOeVYdHFjjFeXVKdTNobTEXhg2R0XoKJyAXZXnTXv6gJUWvmpXy7W1Hn2/DX3F3VYv
         fdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772439319; x=1773044119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nxlvKtWHlixlnWM7lk5L+nk5CDxPToMPWa0ATJIt+U=;
        b=ECB3BRRJDRP+r+ur05m0iH7Kzx5FcJx0KDyRz9KP4AZ7jemgEc38qyg8HNPNtUgHoM
         2y3+a4or7Q5kbGdXPXaZxBXVJwWsrKAJHMW2acTzS3MGbOo04p/cieONIkFZcDIc+11L
         OScpHgnsbjt9ul1m4P4EZvs8P+48L5LE4TD53LVPfM0ODpR5SNEElvT1Tg+5HBtiH9fW
         EgpZpcvx0DKcb73GepojqSluL5tAERAZsI8Ucyl/qu/femcNbFsB7kx38lpPegNcVpHy
         V7K+HIzB48icq4QA9TkMIDvd0Z/HovtAhsXktwCX3i72UBLp6WFF7dj9areNDeyfMy3O
         2Clw==
X-Forwarded-Encrypted: i=1; AJvYcCVvKcSRgu1Z4kfOMPXKPADFhAyBvuN7rnLOphX6ICCJdogeOpmcZliR5O1cOnucGaHSdv7nRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRuARDr29ZnRUOA9bIoHf1pFkyijKWMPdQVFDb4G9qhnzOF8/8
	dwCBm2WBsTFOfI36jv0+cH2de6tRrwYzckuKJ4YJJpdYxv+3M5tfPakP2+GPYy2OV5ubsEhw+Sa
	nqMIRLRy5oNW5eMryM/NV7oMI5q1MFOaWcE0lrBKvCRHgUTCPinE3AoLlDw==
X-Gm-Gg: ATEYQzx+8QwPar6hbbLKeWdxfbOnB6ekr40wcZV+pEH7trZ3Vqr0halste2ZfzxsOkV
	Q7wOID2TnstHaZHcUdIsC0QsyjDLkwjbVF1SihmKeBCorjEwMrCcyubHUHj1H9R44A9+YQtwWy3
	OsM2L8Ld6+dI++qRK+7yH/dCaFVaFlg74XN5bPmpa6rpKXYkUyz6OXRLBN3Z4vONlzKt+XMSpVL
	yUJsnp23Y86Chws5RUcEf+WPVONL+KDfVtq3smvUXl+jCxTMl5LLOH+pJVJcwPGKnpUTtr/Wy3A
	P3XIp81fgEIC+V3uWwNZlVPP5HNahbMN6Lu8jwixjWLJ9cRDn3d4r1LF1kWoKm6m8329/ZtM3q6
	YLs2/IPfgQt9lLTVGTZpYGPtZcgIi/K/MImKqH7c/3+TawXp8RQ==
X-Received: by 2002:a05:6300:85:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-395c3b03cc5mr10176278637.35.1772439318615;
        Mon, 02 Mar 2026 00:15:18 -0800 (PST)
X-Received: by 2002:a05:6300:85:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-395c3b03cc5mr10176246637.35.1772439317962;
        Mon, 02 Mar 2026 00:15:17 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm11137313a12.16.2026.03.02.00.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:15:17 -0800 (PST)
Message-ID: <5448e807-2435-42f4-b98e-2beb6b66a6f4@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:45:09 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/18] accel/qda: Add memory manager for CB devices
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
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-6-fe46a9c1a046@oss.qualcomm.com>
 <d7s4e7xzfqfbcf5o3grc6xqm74dzwpck6ge7hyrwewmyacpuez@lcd6nhzyjr55>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <d7s4e7xzfqfbcf5o3grc6xqm74dzwpck6ge7hyrwewmyacpuez@lcd6nhzyjr55>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MiBTYWx0ZWRfX1Ly+noVrLLFI
 a2vVeShC6t1bAf0sRTNE0HdUX8yo0STacXoUvb4EyS6wNBbOlRBxhwO7GherxA7VRtTrHL5nSwU
 Fim7M7hDgxJ8BEAdc16H1+N3hXEIzSXnZOzlXSu/0BtuMpHFbTdeOWM1Hch3AJ0ILSEIbuBC/UW
 1YqHyEjUR4/ggOH2MelM7yUp7l4XP0FVQESVadTleJUUvTeUaHF5ogA8aEyW4jzzkuJ09igVQqy
 vBNfbklfPOPn8huluzCq/657/X6pEHMwezna4aI/d9PqqZSUcFc+FBCSx2EHOdv29LI6hSabh3R
 2mUJWbz8K3yFREbsM9GyJ5TSqNajBvOn/JY9n+BD1ttijjebbmUH7yScMsf5nx12VylVfxzVDvN
 wXt3gLrlzQMaMXcAE08tspl46/t3mkiZ1Iw/lz7r9mlzqpqkB60SPJwtzl4ovZRWWJqAYhNOuQO
 zQTQtLhLzVRntLUZ/bw==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a54717 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Dp_If50ftEsHmqaufPoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 2HX-m_6hi3M42-sgOmIRHvakWjCgQCpJ
X-Proofpoint-GUID: 2HX-m_6hi3M42-sgOmIRHvakWjCgQCpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020072



On 2/24/2026 4:20 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:39:00AM +0530, Ekansh Gupta wrote:
>> Introduce a per-device memory manager for the QDA driver that tracks
>> IOMMU-capable compute context-bank (CB) devices. Each CB device is
>> represented by a qda_iommu_device and registered with a central
>> qda_memory_manager instance owned by qda_dev.
>>
>> The memory manager maintains an xarray of devices and assigns a
>> unique ID to each CB. It also provides basic lifetime management
> Sounds like IDR.
I was planning to stick with xarray accross QDA as IDR gives checkpatch warnings.
>
>> and a workqueue for deferred device removal. qda_cb_setup_device()
> What is deferred device removal? Why do you need it?
This is not needed, I was trying some experiment in my initial design(CB aggregation),
but it's not needed now, I'll remove this.
>
>> now allocates a qda_iommu_device for each CB and registers it with
>> the memory manager after DMA configuration succeeds.
>>
>> qda_init_device() is extended to allocate and initialize the memory
>> manager, while qda_deinit_device() will tear it down in later
>> patches. This prepares the QDA driver for fine-grained memory and
>> IOMMU domain management tied to individual CB devices.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile             |   1 +
>>  drivers/accel/qda/qda_cb.c             |  32 +++++++
>>  drivers/accel/qda/qda_drv.c            |  46 ++++++++++
>>  drivers/accel/qda/qda_drv.h            |   3 +
>>  drivers/accel/qda/qda_memory_manager.c | 152 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_memory_manager.h | 101 ++++++++++++++++++++++
>>  6 files changed, 335 insertions(+)
>>

