Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64B3750C9
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464504; cv=none; b=FmWj9xoqm9H8F6vzqgnehK/d8mWdUTKSBFB8vtBbmYjB6olvQyKOkxxqM3BJ/JIzgIxsWUPdw3UpIgilkzy7juv2VTuSWfmbxEbHn6JnUU3MjurN0xjCAoobaIwVU/KYR41zJiPuy0gWY0wLAPy0xKvQY84n05UIcG9x6hUV46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464504; c=relaxed/simple;
	bh=M4LpOYY88rmRSVdai4s/uD/4i515n02fQjfIzJ4cFJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNuMRh8VpaXG28L1w/AvK4FQyqNQnn7A12Xw0LV1Olsk10MW37cHzKWddbUSlScWk58Abb/y3Lg1gv2+b+2eRLSzE+T4zgadVqTAimmlZrjpYLsmjo+2NPzXDkoaeFycPj6gxs/godMCxFwHD5Wr4s1hGJIBGXH+OC1m/brl/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1HVuScF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXvxtogE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1HVuScF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXvxtogE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652KjMbB2688188
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 05:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=; b=Y1HVuScF3MC8OaMd
	5TEcIIX7BNLmavVFc4+pBYhu5ujFcjxD20ZbENmoNIqDPk8KkAVWPrSOXgmCY1IB
	SwANjLXUXktvtjk1zO7BTaF8iMxeJ+tEkqf+cYkNufK+qEtzrXyPaxH7n3w9Mzdu
	6oY1Piv/HdG2i4bS9U9aPZh6X+lL+zEvQbFn9v4tWho7XbxyPbfsXLVcZBXV712Y
	l/uNR083CCin5IV0zKpoL6QFh5G7tvai3VbmiAfwNI7NfocCnyqBD4bmqisCdmnd
	jhgmgrhRfbLK9D7EcTMgvxEEdMa6yz5a6Qq1viwMcMjEuIsEvQs2Dhu1l/h/nVUE
	lG5/Qw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsjad9ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 05:28:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8596e4272aso4236597a12.2
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 22:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780464499; x=1781069299; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=;
        b=LXvxtogEiUlYhNHQ7wRcAWkJRDKoGyaVKf4j+tXZj0JdwRnuul2Ha89JPkXizefwR+
         euQQ/aKxiPW+qy05K1hlVIOaB1Gh62qJaP3GZKm5B4jhHsZ+MqTtiYEDfiLgjblpNyyJ
         GCOPV4v6ffneE50dZVqPc30P7ncLn7ihCaAZdSkL3dxr6JY7XF1dKRgkxwIHCfjmT/CO
         MnJMda4EgtD4UPiFF0QA4HEt7BzKtStbN+TbvDpj24Eff2k9/xcmEOFByE55Cr5bq5xK
         DSuHjqceK/ZHeQjtgvAwrPN8xpDrah5rp/W7NAYp8Zb07Ss2qJ1m07ewU/mhgm2vMunc
         Rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464499; x=1781069299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXGduTCF9StMe/W/R1Pp9AQqLYpxIS0I136uVj0AkSI=;
        b=Z6qAMLLOrAv/CVrg5nm+n7+73zu0lxXnL+M11ZSLZiSH5pS+FZmRp0jSFsOvrkCCKm
         oOtpOxoyJTJ4EaHszRV/+MChbCW8231wtmjA1TI4TqceYKGowaTAniaIuQmL4w6aPEwZ
         DzQqtWVEe2a5awUc9bmSdBoooufSTswa53XH/b6amcgSK8FWpskRk5/azjnO6mmtsQc3
         pgyCJ2+Ev44k50PDu5qBxopH+HNW56/g0rYeqrfaUEVQD+EdbtZSu88Q+BFwZcIDZFyU
         +/Iqlzrlrbsiy04mNm4rfjZ82hX13H1Ur+WLhwERHdVKRSPkHQIqo9PQUqmS0BbxCp5q
         9yIg==
X-Forwarded-Encrypted: i=1; AFNElJ/o00N7tDjXF3lqYDRGggw7WEnIkj/5DmXL40oGQ64bHDvn7xdp09YDslISVe7KM7HzC/Dk3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1f1F4T7v/v9wost5/3KFSlYR8La1AA9/TZelZJ80finfg9AsK
	stWaz5tC4deeutLR7vjpbDxVeraPWOQ+rrKx93Htt0qSrqwEvv9BztiZimKLHl8h0CtQs3nl7ii
	GsrEazgYmY9rXzbRDTJ022iZSCQ9POyOjjOup+S1K81K94+pYuwG4y2lZ9w==
X-Gm-Gg: Acq92OGaJshBjNwWLfVTW5ZfTnR+eo3hdF+7Rj0+QkH1atj0LDe3JKIq9ZVOIzZl3NR
	nM+0RH3okGrwcbyW1pLfhLdY2CS60SS56xu8lsrM+bfP0haeI6HdlisVGq68Bqvf29LjIheqWHU
	07TxEuht7Wu+DAB9ysGYKEhiJleisWSV1kx+HNx9jqTy23V/FDdb7qTMN9n05nbKWsZvRzrSEC8
	kdur6nJCq0VqL6iBa70bAkIa5hKza8siaWVkYx9qvdnGXL11vnj4wLiXj9JkIl+aiu35VxNSw32
	hUiLPDpOWPhcUvgxQcIPH2Az3whJIxChLvezX7iTzk3jFP0KxH1qzVtr4CDTaFZj4cJgTpMVChJ
	Mx8Y2VBWPWsM01UX6Uf+bxjfOZQqYorcvUy6wwws+o1wY03JXP+Z0ZJPea9YJ
X-Received: by 2002:a05:6a20:748a:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-3b49759433cmr2261521637.15.1780464499507;
        Tue, 02 Jun 2026 22:28:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:748a:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-3b49759433cmr2261470637.15.1780464498951;
        Tue, 02 Jun 2026 22:28:18 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm986006a12.18.2026.06.02.22.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 22:28:18 -0700 (PDT)
Message-ID: <587b450c-c527-4c6a-b48b-8a7a266bd673@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 10:58:09 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] accel/qda: Add compute bus for QDA context banks
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
 <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
 <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA0OSBTYWx0ZWRfXyzdIw09WIiDQ
 zN40X6redMX2RNnocblBgVNCraaWFV3JddelQgpUVcfpgTOpX34BkH8P+rVOOxr6/kemXTrwZUE
 ImuK3X2PJDMyDZZQC+f8PdXVKr4oM2a0Whsh4OK5XOzaASbnIkrloV6tMG25avdGrEXzp5K0z3y
 rMB+BWxoYfMowBhC0ctviSJYOpKbzFDJjX6QDGYFqvQ5DUccschj/zC7yXtvJT+CHDpU9sL2e53
 WZcL71EwrHBidUMXlWBrBAkHySiyPKhgkPaQPHvI9xQzDscEL26Hgi5SlOJaqOvJ+nZUlPBfT2T
 GkQN/fwYDP812NvTt/Nx0mVapICoHLYlwCZY6yErYi+1gPM2evs2aSw+d7ssSaSM7+4kM6COC78
 QttmzCbKVLsANLkeVJ35GQRrPH2NaKO6o8obDlC+5bOrTnly2H531OyQDwK48dCW9ortBeTvu2M
 wJn4izFYTV+6nSdmg5w==
X-Authority-Analysis: v=2.4 cv=Ld4MLDfi c=1 sm=1 tr=0 ts=6a1fbb74 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fSmyMkXI2XJwL8L7xYwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: yt5LpiO7qSbG5LA9nan08x0obLVBtXhg
X-Proofpoint-ORIG-GUID: yt5LpiO7qSbG5LA9nan08x0obLVBtXhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030049

On 20-05-2026 19:49, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:54AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce a custom virtual bus (qda-compute-cb) for managing IOMMU
>> context bank (CB) devices used by the QDA driver.
>>
>> IOMMU context banks are synthetic constructs — they are not real
>> platform devices and do not appear as children of a platform bus node
>> in the device tree. Using a platform driver to represent them was
>> therefore incorrect and introduced a probe-ordering race: device nodes
>> were created before the RPMsg channel resources were fully initialized,
>> and because probe runs asynchronously, user-space could open a CB
>> device and attempt to start a session before the underlying transport
>> was ready.
>>
>> The qda-compute-cb bus solves this by allowing the main QDA driver to
>> create CB devices explicitly and under its own control, making their
>> lifetime strictly subordinate to the parent qda_dev. The bus provides
>> a dma_configure callback that calls of_dma_configure() so that each CB
>> device gets its own IOMMU domain derived from its device-tree node,
>> enabling per-session memory isolation.
>>
>> The bus type and the CB device constructor (create_qda_cb_device) are
>> exported for use by the QDA memory manager.
>>
>> A hidden Kconfig symbol (DRM_ACCEL_QDA_COMPUTE_BUS) is introduced and
>> automatically selected by DRM_ACCEL_QDA so that the bus initialisation
>> runs via postcore_initcall before any QDA device probes.
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/Makefile              |  1 +
>>  drivers/accel/qda/Kconfig           |  4 +++
>>  drivers/accel/qda/Makefile          |  2 ++
>>  drivers/accel/qda/qda_compute_bus.c | 68 +++++++++++++++++++++++++++++++++++++
>>  include/linux/qda_compute_bus.h     | 32 +++++++++++++++++
>>  5 files changed, 107 insertions(+)
>>
>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
>> index 58c08dd5f389..9ed843cd293f 100644
>> --- a/drivers/accel/Makefile
>> +++ b/drivers/accel/Makefile
>> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
> 
> Ugh. The previous line should be enough (but don't trust me).
I was seeing build failures if I don't add this. Took it as a reference
from host1x driver and recent iris patch.>
>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
>> \ No newline at end of file
>> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
>> index 484d21ff1b55..2a61a4dda054 100644
>> --- a/drivers/accel/qda/Kconfig
>> +++ b/drivers/accel/qda/Kconfig
>> @@ -3,11 +3,15 @@
>>  # Qualcomm DSP accelerator driver
>>  #
>>  
>> +config DRM_ACCEL_QDA_COMPUTE_BUS
>> +	bool
>> +
>>  config DRM_ACCEL_QDA
>>  	tristate "Qualcomm DSP accelerator"
>>  	depends on DRM_ACCEL
>>  	depends on ARCH_QCOM || COMPILE_TEST
>>  	depends on RPMSG
>> +	select DRM_ACCEL_QDA_COMPUTE_BUS
>>  	help
>>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>>  	  This driver provides a standardized interface for offloading computational
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index dbe809067a8b..424176f652a5 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_drv.o \
>>  	qda_rpmsg.o
>> +
>> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
>> diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
>> new file mode 100644
>> index 000000000000..c59d977e924d
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_compute_bus.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/qda_compute_bus.h>
>> +#include <linux/slab.h>
>> +
>> +static int qda_cb_bus_dma_configure(struct device *dev)
>> +{
>> +	return of_dma_configure(dev, dev->of_node, true);
>> +}
>> +
>> +const struct bus_type qda_cb_bus_type = {
>> +	.name = "qda-compute-cb",
>> +	.dma_configure = qda_cb_bus_dma_configure,
>> +};
>> +EXPORT_SYMBOL_GPL(qda_cb_bus_type);
>> +
>> +static void release_qda_cb_device(struct device *dev)
>> +{
>> +	of_node_put(dev->of_node);
>> +	kfree(dev);
>> +}
>> +
>> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
>> +				    u64 dma_mask, struct device_node *of_node)
>> +{
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = kzalloc_obj(*dev);
>> +	if (!dev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	dev->release = release_qda_cb_device;
>> +	dev->bus = &qda_cb_bus_type;
>> +	dev->parent = parent_device;
>> +	dev->coherent_dma_mask = dma_mask;
>> +	dev->dma_mask = &dev->coherent_dma_mask;
>> +	dev->of_node = of_node_get(of_node);
>> +
>> +	dev_set_name(dev, "%s", name);
>> +
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		put_device(dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return dev;
>> +}
>> +EXPORT_SYMBOL_GPL(create_qda_cb_device);
>> +
>> +static int __init qda_cb_bus_init(void)
>> +{
>> +	int err;
>> +
>> +	err = bus_register(&qda_cb_bus_type);
>> +	if (err < 0) {
>> +		pr_err("qda-compute-cb bus registration failed: %d\n", err);
>> +		return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +postcore_initcall(qda_cb_bus_init);
>> diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
>> new file mode 100644
>> index 000000000000..90bf248c7285
>> --- /dev/null
>> +++ b/include/linux/qda_compute_bus.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_COMPUTE_BUS_H__
>> +#define __QDA_COMPUTE_BUS_H__
>> +
>> +#include <linux/device.h>
>> +
>> +/*
>> + * Custom bus type for QDA compute context bank (CB) devices
>> + *
>> + * This bus type is used for manually created CB devices that represent
>> + * IOMMU context banks. The custom bus allows proper IOMMU configuration
>> + * and device management for these virtual devices.
>> + */
>> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
>> +extern const struct bus_type qda_cb_bus_type;
>> +
>> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
>> +				    u64 dma_mask, struct device_node *of_node);
>> +#else
>> +static inline struct device *create_qda_cb_device(struct device *parent_device,
>> +						  const char *name, u64 dma_mask,
>> +						  struct device_node *of_node)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_COMPUTE_BUS_H__ */
>>
>> -- 
>> 2.34.1
>>
>>
> 

