Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83236C43214
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:13:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F6360F0F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04F6360F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97E5F40464;
	Mon, 26 Jul 2021 08:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrjGIJx1gSIq; Mon, 26 Jul 2021 08:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5383A403CD;
	Mon, 26 Jul 2021 08:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 352AFC001A;
	Mon, 26 Jul 2021 08:13:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97770C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77992402A1
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGxVnw8B0HnX for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 08:13:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E393540293
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:13:30 +0000 (UTC)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYCBC66hNz6DHcW;
 Mon, 26 Jul 2021 16:04:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 10:13:26 +0200
Received: from [10.47.94.42] (10.47.94.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 26 Jul
 2021 09:13:25 +0100
Subject: Re: [PATCH 00/23] iommu: Refactor DMA domain strictness
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <8e9da41e-4e3a-7098-bece-7f6cba89a2aa@huawei.com>
Date: Mon, 26 Jul 2021 09:13:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.94.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dianders@chromium.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 21/07/2021 19:20, Robin Murphy wrote:
> Hi all,
> 
> First off, yes, this conflicts with just about everything else
> currently in-flight. Sorry about that. If it stands up to initial review
> then I'll start giving some thought to how to fit everything together
> (particularly John's cleanup of strictness defaults, which I'd be
> inclined to fold into a v2 of this series).

It seems to me that patch #20 is the only real conflict, and that is 
just a different form of mine in that passthrough, strict, and lazy are 
under a single choice, as opposed to passthrough being a separate config 
(for mine). And on that point, I did assume that we would have a 
different sysfs file for strict vs lazy in this series, and not a new 
domain type. But I assume that there is a good reason for that.

Anyway, I'd really like to see my series just merged now.

Thanks,
John


> 
> Anyway, this is my take on promoting the strict vs. non-strict DMA
> domain choice to distinct domain types, so that it can fit logically
> into the existing sysfs and Kconfig controls. The first 13 patches are
> effectively preparatory cleanup to reduce churn in the later changes,
> but could be merged in their own right even if the rest is too
> contentious. I ended up splitting patches #2-#11 by driver for ease of
> review, since some of them are more than just trivial deletions, but
> they could readily be squashed (even as far as with #1 and #12 too).
> 
> I'm slightly surprised at how straightforward it's turned out, but it
> has survived some very basic smoke testing for arm-smmu using dmatest
> on my Arm Juno board. Branch here for convenience:

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
