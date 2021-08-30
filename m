Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF19C432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 07:57:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6D96101C
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 07:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C6D96101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469D56068B;
	Mon, 30 Aug 2021 07:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lypz1JG_oj3k; Mon, 30 Aug 2021 07:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22296605EF;
	Mon, 30 Aug 2021 07:57:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD2BAC0010;
	Mon, 30 Aug 2021 07:57:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A524C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 372D780E64
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFnknk8cZFtX for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 07:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21C2880E63
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 07:57:20 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GyjMC0MjLz1DF2w;
 Mon, 30 Aug 2021 15:56:39 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 15:57:09 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 30 Aug 2021 15:57:09 +0800
Subject: Re: [PATCH -next v4 2/2] iommu/arm-smmu-v3: Add suspend and resume
 support
From: Bixuan Cui <cuibixuan@huawei.com>
To: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210830073858.47084-1-cuibixuan@huawei.com>
 <20210830073858.47084-2-cuibixuan@huawei.com>
Message-ID: <7087f98c-a59e-00a3-2eae-958c25c1ac3c@huawei.com>
Date: Mon, 30 Aug 2021 15:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210830073858.47084-2-cuibixuan@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, maz@kernel.org, rafael@kernel.org,
 gregkh@linuxfoundation.org, robin.murphy@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/8/30 15:38, Bixuan Cui wrote:
> Changes in v4:
> * Restore the arm_smmu_suspend() function code to the v2 version(Directly return 0 in it).
Hello,
I looked up the code of smmu.c and the manual of smmu v3. For the suspend is implemented
by the external clock-gating, it is not clear what the SMMUv3 needs to do. Is it the same
as that in smmu.c?
I roll back the code here, and hope to get some advice.

Thanks,
Bixuan Cui
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
