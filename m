Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC478C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 11:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62C3481916;
	Mon,  7 Feb 2022 11:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFqbBS8uT_Py; Mon,  7 Feb 2022 11:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43E9F81934;
	Mon,  7 Feb 2022 11:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A997C001A;
	Mon,  7 Feb 2022 11:55:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D00E4C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A921760B49
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OW5vqRjWHW6y for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 11:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 797B560B2C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 11:55:37 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jskxw4YZZz67lbv;
 Mon,  7 Feb 2022 19:51:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:55:34 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:55:32 +0000
Date: Mon, 7 Feb 2022 11:55:31 +0000
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v3 5/8] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
Message-ID: <20220207115531.0000392f@Huawei.com>
In-Reply-To: <20220124131118.17887-6-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-6-yangyicong@hisilicon.com>
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

On Mon, 24 Jan 2022 21:11:15 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> 'perf record' and 'perf report --dump-raw-trace' supported in this
> patch.
> 
> Example usage:
> 
> Output will contain raw PTT data and its textual representation, such
> as:
> 
> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
> .
> . ... HISI PTT data: size 4194304 bytes
> .  00000000: 00 00 00 00                                 Prefix
> .  00000004: 08 20 00 60                                 Header DW0
> .  00000008: ff 02 00 01                                 Header DW1
> .  0000000c: 20 08 00 00                                 Header DW2
> .  00000010: 10 e7 44 ab                                 Header DW3
> .  00000014: 2a a8 1e 01                                 Time
> .  00000020: 00 00 00 00                                 Prefix
> .  00000024: 01 00 00 60                                 Header DW0
> .  00000028: 0f 1e 00 01                                 Header DW1
> .  0000002c: 04 00 00 00                                 Header DW2
> .  00000030: 40 00 81 02                                 Header DW3
> .  00000034: ee 02 00 00                                 Time
> ....
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Hi. This is unfortunately out of my areas of expertise, so I just
took a quick glance and noticed one generic c thing that could be
tidied up.

> diff --git a/tools/perf/util/hisi_ptt.c b/tools/perf/util/hisi_ptt.c
> new file mode 100644
> index 000000000000..75fa89f3fae3
> --- /dev/null
> +++ b/tools/perf/util/hisi_ptt.c

...

> +
> +static void hisi_ptt_free_queue(void *priv)
> +{
> +	struct hisi_ptt_queue *pttq = priv;
> +
> +	if (!pttq)
> +		return;
> +
> +	free(pttq);

free() is safe against a null ptr, so you don't need the 
if (!pttq) return;

See free(3) man page.

> +}
> +
> +static void hisi_ptt_free_events(struct perf_session *session)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +	struct auxtrace_queues *queues = &ptt->queues;
> +	unsigned int i;
> +
> +	for (i = 0; i < queues->nr_queues; i++) {
> +		hisi_ptt_free_queue(queues->queue_array[i].priv);
> +		queues->queue_array[i].priv = NULL;
> +	}
> +	auxtrace_queues__free(queues);
> +}
> +
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
