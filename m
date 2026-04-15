Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405E3E8675
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273388; cv=none; b=puEpFAp+HZ/r5RBUIumvYGAwt6BW180nvHVhy5tO00x3miDxg7SmgCiYfbQWKWGnXTuq1E6/HuAAh2CvclQa/irNSNrsXE5j8jMKJk+K6xekoCpZsbHWMR4/LXMYsGuX+ucKgDa/jIgUE7Q3MlQJQyYJk4kg2CuhZV66G3g9RlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273388; c=relaxed/simple;
	bh=S0EDPJ9l+fvj9T5naoPwWY+Enw0gjv+15LBTelh/VlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3wnj8aHs+2zc8XSk89ELfmHNk2r3Ivs43jPysVyWhnpwSAH/9pGn1oE7aqeUTCq1oK068OrI7Elh5hL8OFoiMNUcarDjF8IOuxXmQoLRQVsTpQA+GLzm7Tc+1WXz4NNNSsDqny+kGrXSXIzsWF/BSsI/Lw5lb0HcRPKVPOtgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJlDCc+P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dHXqwZDW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJlDCc+P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dHXqwZDW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FGExGO506999
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=; b=DJlDCc+P7kvAcR3W
	1i9+1MbX2YXxQYZ/Z48HaSJr9AdMUgXqCSWSChH6RoDXEE2xBPyKp9anBuYiWgxS
	bqS9J0ixRzZwbUaxsx6M9EtAnU0bUKxa17zlMssX+JUzW/RcLm9LWjHcfmH6Hagj
	q073QblXiX5Zec20+sZ/rKek5Wv46TrczYvsEH9l6hs1TPcj89bGrALmS14g7u4/
	lk+qWOq7Q3Ynwx/jB7RAcRVSRPd2vUaqjZa70JGyLcS8pJeuJUisDox8hLY3aeFR
	WmtZvKh4MTnzwgQjNEtyazblgy3ItIlwsOrJn3pbrBF9nDkIKHcxdDXZr+RYjJqv
	k9VjJw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dje1e07s2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:16:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b241be0126so139407055ad.3
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776273384; x=1776878184; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=;
        b=dHXqwZDWA+F7pMPd5csWNV4H8/L6brIs36+kF03jhp8IlL2psbUsUbWQsvLawrr4cl
         vp4IT5mCMYy97P61loxIPlmJT80lKVpqGSlvpKD85r/87yvJ196n0niLXWx9cIVAEZj1
         P/PuHRHTLCnGDDAk29Z3wid2P/898NGNNbXMmxRjQbd8eqkbX0LYd6g7VOHNq4922DvR
         H17dM5Chyl1u+e+DVfESaCXBbFVl5h/lC8Lou/VymSOgZFwIt8o3f3x4Z3EdP3SS/ubP
         2CX3R8mfykxEoFIob2dnSL6UUFXcyW7nOnvSuWsICLnq8S0E2k+sIUn4QfH8o8J47xWv
         VwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273384; x=1776878184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=;
        b=RwB0QOHIML1Ad5mjrxW+1jC2CznOzPmQZmf2YJSfJXjfiBqlC2v1sczrlGwXbPzfAP
         7UdXFETackaS43pIA3efvtZs/wMylu+ikQ4DpwskvtjHzRA+ENUYSTQGi4az2VkpxUAa
         GewLQ1PbhumPmx0hqMtPCu7RFdlnRdmcTrjA/Zwr/e44EfJGBQnCBMro+5bGJbXKviZl
         JBQaZk9BZxcKkBNghrdNB9/q4j3PIBG7VqJbYfqVIhfQCZrN/fc48XPiFeNAzz09yA7R
         Sy71qDYWO44Hjdhb9xo9J4eIj3qBqJfvBl/TC3BopT3TiWCFvDS91hhBeLAPc5BsXq5v
         2zlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TfyL2FNJpNFJdIyGTmERP7EGeocfat+ns5VNHIRvQcloVuH7wPydcEgYatKOHUmy689eS4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzR6g99OP2IPpv8sBQd3QTfm5isZ/RcrmcJ1uzOPYPG9JMocmk
	Taoo5tPylwZfjkxFoZ1IImts2s/JyJd5Mht7mwPB+H6SNU3xhPdgqNsswALG4idw17LIULdGRck
	W+ar5Zmcsn6l484vGmyyLeDmW3eQPsuIrnoRkJkhOdf6zAi0siBUELlk71Q==
X-Gm-Gg: AeBDiet8qVIEL3F85ZLgNi0GKSEfd4vpyngigfZUUL4xQR9yanJLFEOMa5BmAmAQxwD
	c61rqskT7dgMcu+z3uGexi3JjumZwrBM1cfX6wsi9zMhBTwMNY19U6BbPEyjhxThmhC5Wy9ceYc
	22NyGFCDSulQUDDTM5HCrzZ0SXo8MMi0WkTxEgJKJSEAtQnZ2fp9JnOuCswOGCtY5MWIGo+I4f8
	vms/nK7fqhSeJrPzmRAvQYdnzgN1N4GCVerVIDyc7VX51C8PACorH6eu4R03R2ryfg9GTjGz144
	pUbydlh7tIrnldKu96wP41z06CpFbVh1sccX0AXLtWYPtg6LppyO2ZamWG4yAUPju7Zkec4cCTb
	zxXJeV/eLfBYhcV97pmPO4Rm1mU2K9QF8P0vrcnqy62pUw+xqwgeA+w==
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b2d59adee5mr234505705ad.14.1776273384144;
        Wed, 15 Apr 2026 10:16:24 -0700 (PDT)
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b2d59adee5mr234505285ad.14.1776273383593;
        Wed, 15 Apr 2026 10:16:23 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e306sm27292945ad.46.2026.04.15.10.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 10:16:22 -0700 (PDT)
Message-ID: <75191131-2eb5-a7d3-0222-8c03a5ded45a@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 22:46:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Content-Language: en-US
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZwkiCE8 c=1 sm=1 tr=0 ts=69dfc7e9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=m666xMD4OwuZyzqZ95sA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE2MSBTYWx0ZWRfX8yZ8LSV3w8k4
 2pNClQ5xpmzhuBHJW77e8hE0sJbZNDJ0z2MDQkJv/ZmNI3k5sjGBjzQldI+xxpdlUM8ZhsyZTpb
 LS6WWgMZGgJeZWpE01+E1EAa/HLyGlsOihbV7tb2p/ubQHVmqLvLm7I6Yzka0HOdId9gS423Nfn
 Xigb/WgWYkqRZTtGQMR/X1GPtKIV6HRdyIZwo8HgUrDd2DoB1N21CUwnqQey+twqLLeycQyY60u
 gOLf9i0g+byjeIUZsVNSJKCsQv6u3WvK5g0/LXAYERpBwWdeQqxWZjMSKLLf2Mtz5eAK29hfmQ3
 zV8hSz6gZjOyteYR4J2e8IGhqr9IRBfj1nkjUSQsBz0OIkA/fEpKfvGuO/Qq3zt8LML0N1De0HE
 4yNB69LcgibAj+BJfoTZYz5EFgJXwkfSYMFlJrTF13WYZNh65fYVjCV82FGs3TGnqhxDT1SbGnG
 oByacE1JusGFwjW2qSg==
X-Proofpoint-ORIG-GUID: MSHXRqYWZFx4PSc_uJhrFY22rTUka4FM
X-Proofpoint-GUID: MSHXRqYWZFx4PSc_uJhrFY22rTUka4FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150161



On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> Introduce a new generic bus type for synthetic context bank devices
> that require IOMMU context isolation. This bus provides a shared
> infrastructure for accelerator and GPU drivers that create virtual
> devices representing IOMMU context banks.
> 
> Currently, drivers like host1x implement their own bus types for
> context devices. This generic implementation allows multiple drivers
> to share the same bus infrastructure, simplifying the IOMMU subsystem
> integration and reducing code duplication.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>   drivers/base/Kconfig        |  3 +++
>   drivers/base/Makefile       |  1 +
>   drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
>   include/linux/context_bus.h | 15 +++++++++++++++
>   4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index f7d385cbd3ba..479bc4bb442b 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -4,6 +4,9 @@ menu "Generic Driver Options"
>   config AUXILIARY_BUS
>   	bool
>   
> +config CONTEXT_DEVICE_BUS
> +	bool
> +
>   config UEVENT_HELPER
>   	bool "Support for uevent helper"
>   	help
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..ab9a0b2dc73b 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
>   			   topology.o container.o property.o cacheinfo.o \
>   			   swnode.o faux.o
>   obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
> +obj-$(CONFIG_CONTEXT_DEVICE_BUS) += context_bus.o
>   obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
>   obj-y			+= power/
>   obj-$(CONFIG_ISA_BUS_API)	+= isa.o
> diff --git a/drivers/base/context_bus.c b/drivers/base/context_bus.c
> new file mode 100644
> index 000000000000..6ddb6c27bf69
> --- /dev/null
> +++ b/drivers/base/context_bus.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +#include <linux/context_bus.h>
> +#include <linux/init.h>
> +
> +const struct bus_type context_device_bus_type = {
> +	.name = "context-device",

add the .dma_configure callback instead of calling from the client driver.

> +};
> +EXPORT_SYMBOL_GPL(context_device_bus_type);
> +
> +static int __init context_device_bus_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&context_device_bus_type);
> +	if (err < 0) {
> +		pr_err("context-device bus registration failed: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(context_device_bus_init);
> diff --git a/include/linux/context_bus.h b/include/linux/context_bus.h
> new file mode 100644
> index 000000000000..0cd44cb5b147
> --- /dev/null
> +++ b/include/linux/context_bus.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __LINUX_CONTEXT_BUS_H
> +#define __LINUX_CONTEXT_BUS_H
> +
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_CONTEXT_DEVICE_BUS
> +extern const struct bus_type context_device_bus_type;
> +#endif
> +
> +#endif /* __LINUX_CONTEXT_BUS_H */
> 
