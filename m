Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D8DC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 11:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C57CE40603;
	Tue,  8 Mar 2022 11:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l-1Mr_VS2PD2; Tue,  8 Mar 2022 11:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1712B404D7;
	Tue,  8 Mar 2022 11:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBC32C0012;
	Tue,  8 Mar 2022 11:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA41C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 11:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9119415B9
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 11:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngijo1rqApHF for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8872415A8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 11:49:19 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCYQP3GvGz1GBw6;
 Tue,  8 Mar 2022 19:44:29 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:49:16 +0800
Subject: Re: [PATCH v5 8/8] MAINTAINERS: Add maintainer for HiSilicon PTT
 driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-9-yangyicong@hisilicon.com>
 <20220308103232.000039cf@Huawei.com>
Message-ID: <cfb0292e-244e-97f5-4a00-9bd5fd27251c@huawei.com>
Date: Tue, 8 Mar 2022 19:49:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220308103232.000039cf@Huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, will@kernel.org, daniel.thompson@linaro.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 coresight@lists.linaro.org, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, song.bao.hua@hisilicon.com,
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/3/8 18:32, Jonathan Cameron wrote:
> On Tue, 8 Mar 2022 16:49:30 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Add maintainer for driver and documentation of HiSilicon PTT device.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I've left the perf tool and iommu patches without tags from me
> as I don't have the background to do a thorough review.
> 
> Thanks,
> 
> Jonathan
> 

Thanks for the comments and for the help to improve this driver!

Regards,
Yicong
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
