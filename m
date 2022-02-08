Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797A3C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 07:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1201F40112;
	Tue,  8 Feb 2022 07:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PaYyTAJp8yPU; Tue,  8 Feb 2022 07:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93C43400D1;
	Tue,  8 Feb 2022 07:09:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 770A4C001A;
	Tue,  8 Feb 2022 07:09:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE3DDC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 07:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EB6181A18
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 07:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQ1fZ1lZkuhV for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 07:09:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36E3981A5C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 07:09:05 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtDXX4dRZz1FD31;
 Tue,  8 Feb 2022 15:04:44 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:08:55 +0800
Subject: Re: [PATCH v3 4/8] hisi_ptt: Add tune function support for HiSilicon
 PCIe Tune and Trace device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-5-yangyicong@hisilicon.com>
 <20220207114911.0000127e@Huawei.com>
Message-ID: <15ebb616-bc5a-f589-a435-c8322202661a@huawei.com>
Date: Tue, 8 Feb 2022 15:08:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220207114911.0000127e@Huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/2/7 19:49, Jonathan Cameron wrote:
> On Mon, 24 Jan 2022 21:11:14 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Add tune function for the HiSilicon Tune and Trace device. The interface
>> of tune is exposed through sysfs attributes of PTT PMU device.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> A few trivial things inline, but looks good in general to me.
> With those tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks for the comments.

> 
>> ---
>>  drivers/hwtracing/ptt/hisi_ptt.c | 154 +++++++++++++++++++++++++++++++
>>  drivers/hwtracing/ptt/hisi_ptt.h |  19 ++++
>>  2 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 2994354e690b..b11e702eb506 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -21,6 +21,159 @@
>>  
>>  #include "hisi_ptt.h"
>>  
>> +static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u32 val;
>> +
>> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
>> +				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
>> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +				  HISI_PTT_WAIT_TIMEOUT_US);
>> +}
>> +
>> +static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
>> +				  u32 event, u16 *data)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>> +			  event);
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +
>> +	/* Write all 1 to indicates it's the read process */
>> +	writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> 
> Just to check, this is includes the bits above the DATA_VAL_MASK?
> Fine if so, just seems odd to define a field but then write 
> parts of the register that aren't part of that field.
> 

yes. The valid data field is [0,15]. But
all 1 is used here to indicate that it's a
read process rather than a write process.

>> +
>> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
>> +		return -ETIMEDOUT;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>> +	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
>> +	*data = (u16)reg;
> 
> As below, prefer a FIELD_GET() for this.
> 

sure. will use field ops here and below.

Thanks.

>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
>> +				  u32 event, u16 data)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>> +			  event);
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +
>> +	reg = data;
> Given you defined HISI_PTT_TUNING_DATA_VAL_MASK why not use it here
> 
> writel(FIELD_PREP(..), ...)? 
> 
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>> +
>> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>> +}
>> +
> 
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
