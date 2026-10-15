Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F84C67F9
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068166; cv=none; b=bLNRFqRxY0EZ4R54WfwRNDvU/TdlnbC8uj/DG9HsrabYlB34rKkgxntQoRfpqZhm/OY/BDkua7+VqDFaD9+sMBs6rGqJHotoIytmFlfZZ3wM4Gd9y+Iau/XG6lt5wCMhyXsQcVXFCc3245dhtCCEixwf+Jj2eqR9sQqPAQh3jww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068166; c=relaxed/simple;
	bh=iue/25EugCeiP+JlUAe0+14oDJOn0PTFfLPEqbW/HRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8gE61YjB8w4Hk7RBU8tGM5HI87JfovCkKhcEczZbWlWZKFcG/yVxTD87rilvpvPUpQB4jdLKKGt2pqIemV723pDuXCOyNjcpf+kOoCEqB8FF0Vf600qZxDiaAVr6B0XP8VKlk7aZ55g/IZaLqEyODeOLUIOoeJPC0l0osra+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R25y7Euu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dkdVytCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R25y7Euu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkdVytCf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jhVJ3510305
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KgCkbIqj+Xltp5HS/aMjiyIa
	do5whRz2Y+pFV9bEePY=; b=R25y7EuuLXCZtzDPvFdgieK2SbIvfbN1jRnQW+Qg
	Fl/7uNZi5zwoZ+YKQLCsVdTrDJsRk17T3DAN2EwcwCUKO/LlT8TQqVhK9UDPK0U2
	TJ3d3+MRlCI/G8R7oYHaGKlRVl0MOyBheA1VVxEi/SP6hqGYhweHPCrFvwREJwTp
	2dmXH0GtBhjZoAbTmWS6AXpvfkcckuC/C0JSfK+kM2OsVtXaoTG5oAOfbKngdpF5
	glNu6K8EZSka/gEgk8RWDFzCZXU3bLT3j+Y0bhiJlKXH/u2WG9s5Iajflm0fiAQZ
	joM1dWehim2el4uVZ9WnKB1NayqHPCRZkzRaKslfkNM3RQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdsa1wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:42:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso912524185a.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792068163; x=1792672963; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgCkbIqj+Xltp5HS/aMjiyIado5whRz2Y+pFV9bEePY=;
        b=dkdVytCfa9YXr47qokd+yqKWMiZMT1l3WCwBT+sYrnxI7Sm2WnHGbpuSytF3HhA9Tv
         eoAJ+GtI7IJt6/t+Rlb37qlEI0QAFZDQfg371USRKNUkPRbgfoowoLcY/hMPfhWT+2AH
         v9gm4ZRwo/0lhf0kugmzYs+q3UXy3WpfTl1T8MYX7vkjLubcnxb2buSe7/F94mC25LhM
         46oY5zUG1c+bfsswIs2VbUjx9ND6HDHlp7Z04xBJFDiWugIp0zp2Fwh3iPI7+CzSTiJe
         dkzEyi/9HjUlJTrojht4DLSVEIE8ahmJdbYx+9ymCBhmeK6vjQg/MCMO2UpYj83Q16R3
         Vobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068163; x=1792672963;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgCkbIqj+Xltp5HS/aMjiyIado5whRz2Y+pFV9bEePY=;
        b=hYmOdMPkm7Z/Eu83/bckjFrertANpKgvivPk58G3N2KRd+tb0VAEfTnrWc7rUcH3yr
         q40eBa+hbodN4YrAnLlSOl84nNI1p8ibNS7y9s6gCK6+zdonSpv1Z1c92IjdUKDrHPO1
         0BrAqEB/GbYMF6wK7Mr0bRgOiho0ymjzySTqljxpD+Drhsu4H+43Rjisx44HgWYef36T
         uQ1OLPRC4Qhg1wVQT/WeIVo+na14X5CiwyvpgJKtu5gfj5HmQOGgQMCBQ99I/LPsh4lc
         tLt0M/ytQJHmfs0KR8KxwQn+6pzf8ZZeGqGd0bK3vM8DLonuJSwQezwlzqedib/pX6gl
         dhYQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1xCcRagYDFhdp1swgi+ibyLM0JIqXLhHXI38YhdP/s5Bt8I57es7j7OTvDFCm3IeHxRKBjw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9pKd3gNc8aWuKapbbp9utC47uRI00TLR8AgagEl9WFlw05ICr
	noeA3ZP2Ciq/k95WGCfIHZNqMSh+K7bKr5Y++LmtYqQV9akoGd7akWcn+VBc/rDcUPbrKZtOLF2
	j762xOWt2omMhRb7NgVJ3Kd5ZF7pl4XVpXe2yVE63eU0PlDHyYlJ/0hD1jw==
X-Gm-Gg: AYBFou1GyLeDDCj0gwz0NL4MS1gpwLjNBJskIO9XYncyWxcMyuImlvtuu17gCTE8xGB
	RG42+EoUaeimXkqXiPivJpfgxokfhbGt9mZQv1ZKO+rRLjP9bSqn7HIBgZBJDBK4JfrPWbg1RtI
	ODLg6RHLRhLrJvvCpBkTJLPC5hOGBTlUub8XtscewUfVGptjwa5K8QL/OPGo5wuAI4W/sirr4I9
	37yh3s4s+lUf2LvxwUpaHn557+0zBYfEARLx0KQ7mw/2uPVgPWZ5e/hRjVkEn2tdAYRZrT9/XXj
	tcuMeD+ohie5ZvxZYwN8HsR7VtrymLsFgJfir0wQKzMl5y+ZUv6Be0LxVghZZedv14cxsjCNuQU
	LwAxy416zwW12XENhdILO4DR1shpoQcJxEThpT7jLR6h26CJzUQVsI4ROVWUEgpXZjrgiUX6YaY
	BI3PKzH4Hl6Qpw
X-Received: by 2002:a05:620a:4407:b0:93e:942f:b8b1 with SMTP id af79cd13be357-93ebd292a3fmr3061150685a.64.1792068163084;
        Thu, 15 Oct 2026 05:42:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4407:b0:93e:942f:b8b1 with SMTP id af79cd13be357-93ebd292a3fmr3061145985a.64.1792068162454;
        Thu, 15 Oct 2026 05:42:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3aafdf4e5ebsm6660281fa.40.2026.10.15.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:42:41 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:42:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 04/13] drm/msm/dcp: Add IPCC power notification
Message-ID: <u7pcn75yh435vuuwqezml37bqfzdztvrywggbmkydkilwe5yzp@myijo4wd2bob>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XZ0I7p1uz-NichmovArRKaraYpkmDunQ
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0ca43 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=CLenjPMy3891WX9YFLIA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXzbSOSxghP1Bh
 vd5trdEZ9xlj1+ZrsXYev09X/q3BcsRZXmXbhj+r/LkefCpSOTRcmY63QO6E/7ms0VaKZoYYAhu
 5RWSnY7FmQbTWuDp4ex8fqhdhqZ0pvU5ktDvgx8Gba2DmbZJg/vO/U1WdiSfqoY2JINcSwKgU98
 /N8/Lzzptr/JCGKT/X5bWWOBE9SuWI4Ds79aNyWN/7KheOINgh76BC7K2ab/fTpLMuqBsuE825f
 cbPyP9YykE5Stx9CS7stHGl982oV0bedrbLsvOyP1xCPFIthL5yd+cHdCps034pcpFhlb1kx7u1
 P90NcgzW6GVOwumB2CQ9rn/hjb2Cs8sGK+F7T546VZqiWBZF6g09CyJc9zOcoyFSw5wkQVjjVX8
 oaX/lieMCUjLJMPzFNsGxYFs917DENr7EtGTFD3xNwS9SGvYl7StBXuxhEo8VmOqLUGDh1GMGGU
 232qrGHNaHgGMIa+uAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX7BFF3hDE+uK8
 YXaaXhKT5Udwp8E06FPbePgtKMPyq520ZEQvFP78y5ksgVZLBHpqM+1uguxbK1K6uVKmacDs0uv
 ULy5Oy3cZxrVmDIrCajHWNauvmcwAHA=
X-Proofpoint-GUID: XZ0I7p1uz-NichmovArRKaraYpkmDunQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150050

On Thu, Oct 15, 2026 at 01:08:24PM +0530, Jayant Shekhar wrote:
> DCP may be power-collapsed while the VirtIO transport remains available.
> The host therefore needs the platform IPCC channel to wake the firmware and
> to receive notification that it can service HFI queues.

Is it allowed per the VirtIO spec?

> 
> Add the IPCC mailbox client and power-notify interrupt handling. Wake DCP
> before VirtIO queue activity, wait for the firmware acknowledgment, and
> notify the response queue when the IPCC receive path completes.

Don't describe patch contents. Describe your design decisions. The
reasons for the flags, init/deinit functions, etc.

> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile       |   1 +
>  drivers/gpu/drm/msm/dcp/dcp_drv.h  |   1 +
>  drivers/gpu/drm/msm/dcp/dcp_ipcc.c | 212 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_ipcc.h |  56 ++++++++++
>  4 files changed, 270 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index bdc34babfc21..4195bc0e1fc9 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -71,6 +71,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>  
>  msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_core.o \
> +	dcp/dcp_ipcc.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> index bf6c34af43a0..af2db3cf9066 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> @@ -13,6 +13,7 @@
>  #include <linux/virtio.h>
>  
>  #include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
>  
>  struct dcp_dpu_kms;
>  
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.c b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
> new file mode 100644
> index 000000000000..e60a3ecbe3d8
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP IPCC power-notify mailbox client.
> + *
> + * The APSS-to-DCP channel must be signaled before a VirtIO queue kick.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/jiffies.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/of_irq.h>
> +#include <linux/string.h>
> +#include <linux/virtio.h>
> +
> +#include "dcp_ipcc.h"
> +
> +#define DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS	10000
> +
> +static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		return;
> +	}
> +
> +	if (atomic_xchg(&ipcc->power_notify_pending, 0))
> +		complete(&ipcc->power_notify_done);

Can there be more than one power notification pending? Can't we just
call complete() here?

> +
> +	if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
> +		virtqueue_notify(ipcc->resp_vq);
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}
> +
> +static irqreturn_t dcp_ipcc_power_notify_irq(int irq, void *data)
> +{
> +	struct dcp_ipcc *ipcc = data;
> +
> +	dcp_ipcc_handle_rx(ipcc);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void dcp_ipcc_rx_callback(struct mbox_client *cl, void *data)
> +{
> +	struct dcp_ipcc *ipcc = container_of(cl, struct dcp_ipcc, client);
> +
> +	dcp_ipcc_handle_rx(ipcc);
> +}
> +
> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev)
> +{
> +	int irq, ret;
> +
> +	if (!ipcc || !dev)
> +		return -EINVAL;
> +
> +	memset(ipcc, 0, sizeof(*ipcc));
> +	init_completion(&ipcc->power_notify_done);
> +	mutex_init(&ipcc->power_notify_lock);
> +	spin_lock_init(&ipcc->state_lock);
> +	atomic_set(&ipcc->power_notify_pending, 0);
> +
> +	ipcc->client.dev          = dev;
> +	ipcc->client.tx_block     = false;
> +	ipcc->client.tx_tout      = 0;
> +	ipcc->client.knows_txdone = true;
> +	ipcc->client.rx_callback  = dcp_ipcc_rx_callback;
> +
> +	ipcc->power_chan = mbox_request_channel_byname(&ipcc->client,
> +						       "dcp-power-tx");
> +	if (IS_ERR(ipcc->power_chan)) {
> +		ret = PTR_ERR(ipcc->power_chan);
> +		ipcc->power_chan = NULL;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "IPCC: failed to get 'dcp-power-tx': %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq = of_irq_get_byname(dev->of_node, "dcp_power_notify_irq");
> +	if (irq <= 0) {
> +		ret = irq ? irq : -EINVAL;
> +		ret = dev_err_probe(dev, ret,
> +				    "failed to get required power notify IRQ\n");
> +		goto err_free_channel;
> +	}
> +
> +	ret = request_irq(irq, dcp_ipcc_power_notify_irq,
> +			  0, "dcp-power-notify", ipcc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret,
> +				    "failed to request power notify IRQ %d\n", irq);
> +		goto err_free_channel;
> +	}
> +	ipcc->power_notify_irq = irq;
> +
> +	ret = enable_irq_wake(irq);

This is typically called from the suspend callback. Why are you calling
it in init path?

> +	if (ret) {
> +		dev_err(dev, "failed to enable power notify IRQ wake: %d\n", ret);
> +		goto err_free_irq;
> +	}
> +	ipcc->power_notify_irq_wake = true;
> +
> +	return 0;
> +
> +err_free_irq:
> +	free_irq(irq, ipcc);
> +	ipcc->power_notify_irq = 0;
> +err_free_channel:
> +	mbox_free_channel(ipcc->power_chan);
> +	ipcc->power_chan = NULL;
> +	return ret;
> +}
> +
> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq)
> +{
> +	unsigned long flags;
> +
> +	if (!ipcc)
> +		return;
> +
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (!ipcc->shutting_down)
> +		ipcc->resp_vq = resp_vq;
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +}
> +
> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc)
> +{
> +	struct mbox_chan *power_chan;
> +	int irq;
> +	bool irq_wake;
> +	unsigned long flags;
> +
> +	if (!ipcc)
> +		return;

Oh, you again ignored the feedback. Can ipcc be NULL here? What would
that mean?

> +
> +	mutex_lock(&ipcc->power_notify_lock);
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	ipcc->shutting_down = true;
> +	ipcc->resp_vq = NULL;
> +	irq = ipcc->power_notify_irq;
> +	ipcc->power_notify_irq = 0;
> +	irq_wake = ipcc->power_notify_irq_wake;
> +	ipcc->power_notify_irq_wake = false;
> +	power_chan = ipcc->power_chan;
> +	ipcc->power_chan = NULL;
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);

Ugh. No.

> +
> +	if (irq > 0) {

Can it be 0 here?

> +		disable_irq(irq);

What for?

> +		if (irq_wake)
> +			disable_irq_wake(irq);

It is enabled at this point. Drop the useless flags.

> +		free_irq(irq, ipcc);

We have devm_foo() functions to simplify the teardown. Can we use them
here?

> +	}
> +	if (power_chan)
> +		mbox_free_channel(power_chan);
> +	mutex_unlock(&ipcc->power_notify_lock);
> +}
> +
> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc)
> +{
> +	unsigned long flags, timeout;
> +	int ret;
> +
> +	if (!ipcc)
> +		return -ENODEV;
> +
> +	/* Wait for the doorbell acknowledgment before returning to VirtIO. */
> +	mutex_lock(&ipcc->power_notify_lock);
> +	spin_lock_irqsave(&ipcc->state_lock, flags);
> +	if (ipcc->shutting_down || !ipcc->power_chan) {
> +		spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +	spin_unlock_irqrestore(&ipcc->state_lock, flags);
> +
> +	reinit_completion(&ipcc->power_notify_done);
> +	atomic_set(&ipcc->power_notify_pending, 1);
> +
> +	ret = mbox_send_message(ipcc->power_chan, NULL);
> +	mbox_client_txdone(ipcc->power_chan, ret);
> +	if (ret < 0) {
> +		atomic_set(&ipcc->power_notify_pending, 0);
> +		dev_err(ipcc->client.dev,
> +			"IPCC TX: power notify failed: %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	timeout = wait_for_completion_timeout(&ipcc->power_notify_done,
> +					      msecs_to_jiffies(DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS));
> +	atomic_set(&ipcc->power_notify_pending, 0);
> +	if (!timeout) {
> +		dev_err(ipcc->client.dev,
> +			"IPCC power notify acknowledgment timed out\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&ipcc->power_notify_lock);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.h b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
> new file mode 100644
> index 000000000000..a3430e5cbe72
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * IPCC power-notify mailbox interface for DCP firmware.
> + *
> + * Channel 5 carries APSS-to-DCP wake notifications; responses arrive through
> + * the mailbox client's RX callback.
> + */
> +
> +#ifndef __DCP_IPCC_H__
> +#define __DCP_IPCC_H__
> +
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +
> +struct device;
> +struct virtqueue;
> +
> +/**
> + * struct dcp_ipcc - DCP IPCC power-notification state
> + * @client: Mailbox client used for APSS-to-DCP notifications.
> + * @power_chan: Mailbox channel carrying power notifications.
> + * @resp_vq: VirtIO response queue notified by the IPCC receive path.
> + * @power_notify_done: Completion for the firmware acknowledgment.
> + * @power_notify_lock: Serializes power notifications and teardown.
> + * @power_notify_pending: Indicates an outstanding acknowledgment.
> + * @state_lock: Protects shutdown state and response queue access.
> + * @shutting_down: Prevents callbacks from accessing teardown state.

What is going to access it during teardown? Can we shutdown in a logical
way, so that there are no accessors after starting the teardown?

> + * @power_notify_irq_wake: Whether IRQ wake was enabled.
> + * @power_notify_irq: Power-notify acknowledgment IRQ number.
> + */
> +struct dcp_ipcc {
> +	struct mbox_client client;
> +	struct mbox_chan *power_chan;
> +	struct virtqueue *resp_vq;
> +	struct completion power_notify_done;
> +	/* Serializes power notifications and teardown. */
> +	struct mutex power_notify_lock;
> +	atomic_t power_notify_pending;
> +	/* Protects shutdown state and response queue access. */
> +	spinlock_t state_lock;
> +	bool shutting_down;
> +	bool power_notify_irq_wake;
> +	int power_notify_irq;
> +};
> +
> +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev);
> +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
> +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
> +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
> +
> +#endif /* __DCP_IPCC_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
