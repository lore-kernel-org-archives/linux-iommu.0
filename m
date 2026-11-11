Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381772;
	b=hqzorZOCLYE1vqUWCfiK9j2+3eDJYZcUOUPfrEVNgNzF5nEqvzhp30oW3BLrEZIDu7EY
	 zMhVfa4jlSWxH3cZVQT4VzwFk8FKsGtqB4LQ/yngKVDsnaQedrwe2Gd5aummlu6dmz2Cf
	 W2m8wqYa01KRfVce/fBmZLcA5dxiqcnEGZF2W8/et/cPqWCoEn75UHv10nqOokO74rJOJ
	 vOMh/Y6ttdfpbOx3MhPOOir+SIX5cD4ac1Bwscm2MxxMTDdAsYoeNRqbfZpu/QOhHQ4lt
	 xyh1wRQ9uhOXATXTfm9aTrE8qcjCv1b5fMco1JUliCCu4nhw35k2HWOjXFd35qLekFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381772;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DUUqgzMDZU6jkGklSFHfQKm3XqkkFiKlJqKfaf5+tiY=;
	b=H3c9U70ehZTUOcmEkgbC7eFNa/2pbOLjyEgx/iXT925IfYyuiEuUe044enYmpnRfRCcW
	 0mRy+bL7iK2K+GX02yWgb8gaTUY+lL84xtqmv8WkaZK6qvienp7EnRodqTHefjsVoRO1m
	 H3yWyQSUHJJuf1Tr8clipuIc7Y0be0C+vLPxMr0t9vw34ykVou7jGuRe3YsKfgtyJ8reJ
	 DA74tIFYJsl4m+p//S4/AUW7HXFhL6aPlKThXEIV2vzDKrUgFNiIYcmgn/a5iAFHbojiN
	 F5F/7CljC/OHwdd5fj2w2wcHQdIMALl0t7hqzqdIGSNl9bm9htxI0fFs9FT0SDr5c2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TRHYywpM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bj892ZYm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6C606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TRHYywpM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bj892ZYm
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KosU3959384
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DUUqgzMDZU6jkGklSFHfQKm3XqkkFiKlJqKfaf5+tiY=; b=TRHYywpMfVoRVoTk
	+SqcWAWoUnNuinI2QxHGx5253PijHCo/AdCB8tkC3NH2BO9EDwk4dJIcjtDHnRM6
	NGet+Log20I8LeprwlvsncnnEDNSpYv0Jmsnbd1mMd8cJt8VHNnWe51NKA5FahgV
	awqDPMbgIvED2rduQx2H1XsGs0dNcvqLmUjm5CfULpTrrFgbUv33pRm4Poy8JVn3
	tD24PjtpBFq7tRI69S8D03h4qIPgtmobfwiwYfSv8/HaYZKbY+EcbPOJVK6MrfyS
	x1BhZ22cViDoO3ApFRkqWCP6SgEa6Eh27lAVMIiswGuD92qHFfdTBdVH32HB1kce
	vJ2LsQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b32dbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:22:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so4071783a91.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 23:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794381770; x=1794986570; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DUUqgzMDZU6jkGklSFHfQKm3XqkkFiKlJqKfaf5+tiY=;
        b=Bj892ZYml7DM3Qmx7o8Kyhh2bqT0OoQ4AyBJHzRJSeRM+3nGV78Bt+4gDmTQ6lWNG0
         jOfTnxNFDDHLROV6CNNG7StupCYjG1T5Ckpd6SHX54LaR0sBg+utOuFT5QoF+cB2K6ix
         MEDYEhG9K1vq0eipr8houbnBTkmRglS1BUdzm2/gGUgBl9maJAL0QwnrE6/fYTWog1er
         ZnHeKFr/xVG7iGi2NP6uKS/Xq/DE34WEvQRa1hgE9WT4rwN3bk54aMmgJr6wg+w5n1M2
         EU25zQE8I2aOreZUptTEjaXZf+tloaALUcrb/HSg0iE9Y7/8N+Afu1cnfB0asan7cTsq
         9SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381770; x=1794986570;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DUUqgzMDZU6jkGklSFHfQKm3XqkkFiKlJqKfaf5+tiY=;
        b=c6RXTEy+w3nL7KaOGEs9AKtTduJIfXFlIzxb0+QHvROV4M2Dyqwq75lBbcDJRIKexk
         VGoErPDYfbG2t7uzOYCT6+4saB0+bDT2zHGCljyYPfF3MIhQF4A1QRKJFreK+6RDBuku
         +cXCA3cW6eYx6a60y75+7V8+iqLfMGfOCrTFrQNrTT+mAOtdWudUxlElu5/B4eq+y5M6
         0DsGXocOmIvi0XWNJxhEY9YWgl7xg51jULSkG2VGRF/ZP8Bx3bwrg6bEYH+b2Bj9ZBUu
         1ZKtpfsrNWMwQjGxOSqsppG0QvMBHE3EB66NVOvUq+785fx9v85wFHJ2DKH5S3F/nQhJ
         HV8w==
X-Forwarded-Encrypted: i=1; AL+hErEt9tKVE5UZI+IHtxbhfy/Eg3/3bGoO3rLJ/YxZIkwUWbNl+6W8lgwiknZnJk4mRlfVHHBBnw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8yAXkTKIBVCMQvtQqvv6f/mJ7WztWps7GKU7Ju+CIzPDHQeDDz
	5Ls7BvF9sB+ItdqXg4nPwrrI61EQsfKoVM47TbQ0UlP9I5ocMlIO1v83z8x+qBfWjFwDaZpwZGV
	gJE+wRYXRaO/plOZy9T9YLOfBXlny5j38eHzTtD0i7+UOBA1d9SyxhZKgYg==
X-Gm-Gg: AYBFou2fHAOd6Mh852MDu4Nxa39uFZ10LryiESGM9w2O7czV7IRfH0W9JDW2T1yAsef
	rLyrUHlQeNKoX9PHhwA8HZ+wOJpvNQwyMBWLHLZ30HnBf3kbVi37YoswLXm2JMP1sXArokhbRuF
	kOejJzy62I9L22fahf1wXuSTcKvaDv4xOy3M5jLKjNNKcm2B88/EJiYZK2pADqXjlaFWgCBaAXK
	FyCEbRq88ki+SZDK/5PEMBO6sTi0Hm44JDomPBON5Wx/MRrx3BpTvDxgRvPhPOCBZ1z2FAc/sVo
	DUW28/fcuGEWGp+9oSpWIOfAthVLtCjryjFrPfhN71BLl54S6Ty3j4OOI+7Jr0yeZXBcXR49c/k
	q+/ztdtSS2ntyeCV8XltV4HKH0QqQIvqDbwnL8vkJTBUxCT9I6ZiLUFla1HY+Bl2SZOrZicggOC
	7oeRO0HjI=
X-Received: by 2002:a17:90b:2246:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b182e94574mr1699823a91.10.1794381769475;
        Tue, 10 Nov 2026 23:22:49 -0800 (PST)
X-Received: by 2002:a17:90b:2246:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3b182e94574mr1699775a91.10.1794381768897;
        Tue, 10 Nov 2026 23:22:48 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dfb7a84sm3100788a91.2.2026.11.10.23.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:22:48 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <284e530a-2c66-4cd2-a09b-983c93b5e200@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:52:36 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/23] drm/msm/dcp: Add Qualcomm VirtIO transport
 wrapper
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-19-7cf014efdee1@oss.qualcomm.com>
 <ib5ts37i4f7qx4wqoscawrwnpeld3pcnarb4w7y3z4b3kolgkf@5avoy2fyp22l>
Content-Language: en-US
In-Reply-To: <ib5ts37i4f7qx4wqoscawrwnpeld3pcnarb4w7y3z4b3kolgkf@5avoy2fyp22l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af417ca cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CjK5iXD0z7442N0G1AIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfXwe0hu/8bEPCy
 bVgMduLJVAvq2vzcs8uVaPqqEhgXXwq1HkXAvHgyMpt4YfXJDNRbodQTW93j0DsnUGe+wHiLFiw
 nmep2NwbfTqOIxbZErqIpnCla0BzK2rrjegDnQJ+VP5utOKSe3aoQpKc3tIVQSa2ajnvvPViPl1
 Z6BOxx1flw0ZN1aTqwSTPumhpO/L4lDiAwHqx1oHUq+/zfr1gVfcPtlFUjyEkXQJwr1/wGSc2gx
 hETw5JfA0xfSyWYLgc4sc2z6YyL3+qrckTBIWncm4WTdm8yV5O8wGK386YgYjG4sLcHJPYlDKHb
 xOHax3L3HNzoL6VAmjvvq+AlIyF9UqN+7QXtR16dcq1SdRg7tAGc74ohImdMr9F/9tXb9A0NrI+
 Ty12UUUYHL5MGN7pKd19cxCUNkIlIk3VmBn69jSdbxMOvw+6yqTRMrLdQ7T8wxw3dCE1W2Kyeh6
 4En1hpljFAqOakwgB7g==
X-Proofpoint-GUID: LVJPwx8KEwE0iifNgTDfPo42s6dUmzEb
X-Proofpoint-ORIG-GUID: LVJPwx8KEwE0iifNgTDfPo42s6dUmzEb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfX/muRvFmDKFRT
 yDbJWBejqe1zGRdefnryoanpEc3CNce4F7JbjppCeYGzYdXUIKVQI0UVgKjjfkZ6dLcDRuoHcFJ
 HdueIR3d53xb31wid21zqxfWsD8FHXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110029


On 26-10-2026 15:37, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 11:51:29AM +0530, Jayant Shekhar wrote:
>> Add the Qualcomm-specific VirtIO transport required by DCP firmware.
>>
>> The transport sends an IPCC power notification before accessing the
>> VirtIO MMIO registers, then registers a VirtIO device directly.
>>
>> Implement MMIO configuration access, feature negotiation, virtqueue
>> setup, interrupt handling, reset, DMA setup, and suspend/resume
>> sequencing in the transport. Keep power-management ordering in the
>> transport so VirtIO queues are quiesced before DCP power changes.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/Makefile                   |   1 +
>>   drivers/gpu/drm/msm/dcp/dcp_virtio.h           |  23 +
>>   drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c | 643 +++++++++++++++++++++++++
> This is a separate VirtIO host driver. Please move it to drivers/virtio
> like the rest of the VirtIO hosts. It has nothing to do with the drm
> subsystem now.
>

Will be moving this into drivers/virtio in v3.


>>   3 files changed, 667 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>> index 9f0a9bfeb2a7..e1a995a8c980 100644
>> --- a/drivers/gpu/drm/msm/Makefile
>> +++ b/drivers/gpu/drm/msm/Makefile
>> @@ -85,6 +85,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>>   	dcp/dcp_hfi_plane.o \
>>   	dcp/dcp_ipcc.o \
>>   	dcp/dcp_encoder.o \
>> +	dcp/dcp_virtio_transport.o \
>>   	dcp/hfi/hfi_packer.o \
>>   	dcp/hfi/hfi_unpacker.o \
>>   	dcp/hfi/hfi_utils.o
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
>> new file mode 100644
>> index 000000000000..a9c3b9aff61d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __DCP_VIRTIO_H__
>> +#define __DCP_VIRTIO_H__
>> +
>> +#include <linux/device.h>
>> +#include <linux/virtio.h>
>> +
>> +struct dcp_drv;
>> +struct dcp_ipcc;
>> +
>> +struct dcp_ipcc *dcp_virtio_get_ipcc(struct virtio_device *vdev);
> What is the use for it? The DCP driver should not communicate to the
> IPCC, it's a part of the underlying VirtIO mechanism. If we export DCP
> to the VM there will be no IPCC anymore.
>
>> +
>> +int dcp_virtio_transport_register(void);
>> +void dcp_virtio_transport_unregister(void);
>> +
>> +int dcp_virtio_register(void);
>> +void dcp_virtio_unregister(void);
> Unused, remove these two.
>
>> +
>> +#endif /* __DCP_VIRTIO_H__ */
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c b/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c
>> new file mode 100644
>> index 000000000000..02c0e2a9fafe
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c
>> @@ -0,0 +1,643 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * Qualcomm DCP VirtIO transport.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/highmem.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/slab.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <uapi/linux/virtio_mmio.h>
>> +#include <linux/virtio_ring.h>
>> +
>> +#include "dcp_ipcc.h"
>> +#include "dcp_virtio.h"
>> +
>> +#define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
>> +
>> +#define to_dcp_virtio_transport(_plat_dev) \
>> +	container_of(_plat_dev, struct dcp_virtio_transport, vdev)
>> +
>> +struct dcp_virtio_transport {
>> +	struct virtio_device vdev;
>> +	struct platform_device *pdev;
>> +
>> +	void __iomem *base;
>> +	unsigned long version;
>> +
>> +	bool wake_irq_enabled;
>> +	struct dcp_ipcc ipcc;
>> +};
>> +
>> +static u64 dcp_virtio_get_features(struct virtio_device *vdev)
>> +{
>> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(vdev);
>> +	u64 features;
>> +
>> +	writel(1, transport->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
>> +	features = readl(transport->base + VIRTIO_MMIO_DEVICE_FEATURES);
>> +	features <<= 32;
>> +
>> +	writel(0, transport->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
>> +	features |= readl(transport->base + VIRTIO_MMIO_DEVICE_FEATURES);
> Can we turn virtio-mmio into the library code instead of copy-pasting
> everything here?
>
>> +
>> +	return features;
>> +}
>> +
> [...]
>
>> +
>> +	magic = readl(transport->base + VIRTIO_MMIO_MAGIC_VALUE);
>> +	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
> Is it really a correct magic here? should it be a different magic as you
> are not just a virtio-mmio?
>
>> +		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
>> +		ret = -ENODEV;
>> +		goto err_node;
>> +	}
>> +
>> +	transport->version = readl(transport->base + VIRTIO_MMIO_VERSION);
>> +	if (transport->version < 1 || transport->version > 3) {
> Isn't transport version fixed for the DCP purposes? Why do we need to
> determine it again at the runtime?
>
>> +		dev_err(&pdev->dev, "Version %ld not supported!\n",
>> +			transport->version);
>> +		ret = -ENXIO;
>> +		goto err_node;
>> +	}
>> +
>> +	transport->vdev.id.device =
>> +		readl(transport->base + VIRTIO_MMIO_DEVICE_ID);
>> +	if (!transport->vdev.id.device) {
>> +		ret = -ENODEV;
>> +		goto err_node;
>> +	}
>> +	transport->vdev.id.vendor =
>> +		readl(transport->base + VIRTIO_MMIO_VENDOR_ID);
>> +
>> +	if (transport->version == 1) {
>> +		writel(PAGE_SIZE,
>> +		       transport->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>> +		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +		if (!ret)
>> +			ret = dma_set_coherent_mask(&pdev->dev,
>> +						    DMA_BIT_MASK(32 + PAGE_SHIFT));
>> +	} else {
>> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +	}
>> +	if (ret)
>> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		dev_warn(&pdev->dev,
>> +			 "Failed to enable 64-bit or 32-bit DMA. Trying to continue, but this might not work.\n");
>> +
>> +	ret = register_virtio_device(&transport->vdev);
>> +	if (ret) {
>> +		put_device(&transport->vdev.dev);
>> +		dcp_ipcc_deinit(&transport->ipcc);
>> +		platform_set_drvdata(pdev, NULL);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_node:
>> +err_ipcc:
>> +	dcp_ipcc_deinit(&transport->ipcc);
>> +err_free:
>> +	platform_set_drvdata(pdev, NULL);
>> +	return ret;
>> +}
>> +
>> +static void dcp_virtio_transport_remove(struct platform_device *pdev)
>> +{
>> +	struct dcp_virtio_transport *transport = platform_get_drvdata(pdev);
>> +
>> +	unregister_virtio_device(&transport->vdev);
>> +	platform_set_drvdata(pdev, NULL);
>> +	dcp_ipcc_deinit(&transport->ipcc);
>> +}
>> +
>> +static int dcp_virtio_transport_suspend(struct device *dev)
>> +{
>> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = virtio_device_freeze(&transport->vdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = dcp_ipcc_enable_irq_wake(&transport->ipcc);
>> +	if (ret)
>> +		goto err_restore;
>> +
>> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
>> +	if (ret) {
>> +		dcp_ipcc_disable_irq_wake(&transport->ipcc);
>> +		goto err_restore;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_restore:
>> +	virtio_device_restore(&transport->vdev);
>> +	return ret;
>> +}
>> +
>> +static int dcp_virtio_transport_resume(struct device *dev)
>> +{
>> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dcp_ipcc_disable_irq_wake(&transport->ipcc);
>> +	if (transport->version == 1)
>> +		writel(PAGE_SIZE,
>> +		       transport->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>> +
>> +	return virtio_device_restore(&transport->vdev);
>> +}
>> +
>> +static const struct dev_pm_ops dcp_virtio_transport_pm_ops = {
>> +	.suspend = dcp_virtio_transport_suspend,
>> +	.resume = dcp_virtio_transport_resume,
>> +};
>> +
>> +static const struct of_device_id dcp_virtio_transport_of_match[] = {
>> +	{ .compatible = "qcom,dcp-virtio" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, dcp_virtio_transport_of_match);
>> +
>> +static struct platform_driver dcp_virtio_transport_driver = {
>> +	.probe = dcp_virtio_transport_probe,
>> +	.remove = dcp_virtio_transport_remove,
>> +	.driver = {
>> +		.name = "qcom-dcp-virtio",
>> +		.of_match_table = dcp_virtio_transport_of_match,
>> +		.pm = &dcp_virtio_transport_pm_ops,
>> +	},
>> +};
>> +
>> +int dcp_virtio_transport_register(void)
>> +{
>> +	return platform_driver_register(&dcp_virtio_transport_driver);
>> +}
>> +
>> +void dcp_virtio_transport_unregister(void)
>> +{
>> +	platform_driver_unregister(&dcp_virtio_transport_driver);
>> +}
> Turn it into a separate driver, use module_platform_driver().
>
