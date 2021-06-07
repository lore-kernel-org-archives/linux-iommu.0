Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823BC47095
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:44:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE77611C0
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE77611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9730C607F7;
	Mon,  7 Jun 2021 12:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wa9c6dXadEI; Mon,  7 Jun 2021 12:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7B6560804;
	Mon,  7 Jun 2021 12:44:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB05EC000D;
	Mon,  7 Jun 2021 12:44:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A16CC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E34B9401F0
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O0wOLGE_QMbH for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 12:44:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5E15400FB
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 12:43:59 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzCfC0LcLzYsVC;
 Mon,  7 Jun 2021 20:41:07 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:43:55 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:43:54 +0800
To: Joerg Roedel <joro@8bytes.org>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <YLpIcwdWDGKpw39s@8bytes.org>
From: Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <9054b39b-a73c-f5b4-cd61-9af4449a0649@huawei.com>
Date: Mon, 7 Jun 2021 20:43:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YLpIcwdWDGKpw39s@8bytes.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, robh@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, helgaas@kernel.org, linux-pci@vger.kernel.org,
 will@kernel.org
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

On 2021/6/4 23:36, Joerg Roedel wrote:
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/pci/of.c         | 8 +++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Should probably go through the PCI tree, so
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> .
> 

Thanks

.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
