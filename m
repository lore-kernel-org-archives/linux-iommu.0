Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F311EC433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 14:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5886417D4;
	Mon, 16 May 2022 14:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EiHI_gJR52tk; Mon, 16 May 2022 14:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4DE8441803;
	Mon, 16 May 2022 14:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 226D1C0032;
	Mon, 16 May 2022 14:23:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7864C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96FAE61088
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ztXvgLL6tfif for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B354A61085
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:23:22 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21cN4Q2Zz67NY6;
 Mon, 16 May 2022 22:20:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:23:20 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:23:18 +0100
Date: Mon, 16 May 2022 15:23:17 +0100
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v8 6/8] perf tool: Add support for parsing HiSilicon
 PCIe Trace packet
Message-ID: <20220516152317.000029d8@Huawei.com>
In-Reply-To: <20220516125223.32012-7-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-7-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, james.clark@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, suzuki.poulose@arm.com, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org, robin.murphy@arm.com
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

On Mon, 16 May 2022 20:52:21 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> Add support for using 'perf report --dump-raw-trace' to parse PTT packet.
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

From point of view of a reviewer who doesn't know this code well, this
all looks sensible.  One trivial comment inline.

Thanks,

Jonathan

> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> new file mode 100644
> index 000000000000..2afc1a663c2a
> --- /dev/null
> +
> +static void hisi_ptt_free(struct perf_session *session)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +
> +	session->auxtrace = NULL;
> +	free(ptt);
> +}
> +
> +static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
> +				       struct evsel *evsel)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);

Check for consistent wrapping of lines like this. This doesn't match the one just above.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
