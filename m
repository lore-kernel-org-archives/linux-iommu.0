Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91814C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 11:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 396428126A;
	Mon,  7 Feb 2022 11:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40CQVAuEZ9Ql; Mon,  7 Feb 2022 11:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C36F81374;
	Mon,  7 Feb 2022 11:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CFB0C001A;
	Mon,  7 Feb 2022 11:49:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21F24C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10FF340274
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IiaokqSyC6pk for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 11:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3755F4022C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:49:16 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsknY4wy6z67Y0C;
 Mon,  7 Feb 2022 19:44:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:49:13 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:49:12 +0000
Date: Mon, 7 Feb 2022 11:49:11 +0000
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v3 4/8] hisi_ptt: Add tune function support for
 HiSilicon PCIe Tune and Trace device
Message-ID: <20220207114911.0000127e@Huawei.com>
In-Reply-To: <20220124131118.17887-5-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-5-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, will@kernel.org, daniel.thompson@linaro.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 coresight@lists.linaro.org, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jonathan Cameron via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 24 Jan 2022 21:11:14 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Add tune function for the HiSilicon Tune and Trace device. The interface
> of tune is exposed through sysfs attributes of PTT PMU device.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

A few trivial things inline, but looks good in general to me.
With those tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 154 +++++++++++++++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h |  19 ++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 2994354e690b..b11e702eb506 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -21,6 +21,159 @@
>  
>  #include "hisi_ptt.h"
>  
> +static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
> +				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +				  HISI_PTT_WAIT_TIMEOUT_US);
> +}
> +
> +static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 *data)
> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	/* Write all 1 to indicates it's the read process */
> +	writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);

Just to check, this is includes the bits above the DATA_VAL_MASK?
Fine if so, just seems odd to define a field but then write 
parts of the register that aren't part of that field.

> +
> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
> +	*data = (u16)reg;

As below, prefer a FIELD_GET() for this.

> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
> +				  u32 event, u16 data)
> +{
> +	u32 reg;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
> +			  event);
> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	reg = data;
Given you defined HISI_PTT_TUNING_DATA_VAL_MASK why not use it here

writel(FIELD_PREP(..), ...)? 

> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +
> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
