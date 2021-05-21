Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62FC433B4
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:39:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D01611AB
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D01611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A9D41858;
	Fri, 21 May 2021 06:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLcJ7ex-RnHa; Fri, 21 May 2021 06:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F9544185B;
	Fri, 21 May 2021 06:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A58C000D;
	Fri, 21 May 2021 06:39:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB79BC0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABB7A4048F
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsMpv4a1OrI5 for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 06:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE6EA40418
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:39:16 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FmcLQ2VNVzQpjW;
 Fri, 21 May 2021 14:35:42 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:39:14 +0800
Received: from [10.174.187.155] (10.174.187.155) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:39:13 +0800
Subject: Re: [RFC PATCH v3 7/8] vfio/type1: Add selective DMA faulting support
To: Alex Williamson <alex.williamson@redhat.com>, Kevin Tian
 <kevin.tian@intel.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-8-lushenming@huawei.com>
 <20210518125813.7b8a78f1.alex.williamson@redhat.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <ee41159c-7adf-6e96-1bb2-9c735512080a@huawei.com>
Date: Fri, 21 May 2021 14:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210518125813.7b8a78f1.alex.williamson@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.187.155]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Robin
 Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2021/5/19 2:58, Alex Williamson wrote:
> On Fri, 9 Apr 2021 11:44:19 +0800
> Shenming Lu <lushenming@huawei.com> wrote:
> 
>> Some devices only allow selective DMA faulting. Similar to the selective
>> dirty page tracking, the vendor driver can call vfio_pin_pages() to
>> indicate the non-faultable scope, we add a new struct vfio_range to
>> record it, then when the IOPF handler receives any page request out
>> of the scope, we can directly return with an invalid response.
> 
> Seems like this highlights a deficiency in the design, that the user
> can't specify mappings as iopf enabled or disabled.  Also, if the
> vendor driver has pinned pages within the range, shouldn't that prevent
> them from faulting in the first place?  Why do we need yet more
> tracking structures?  Pages pinned by the vendor driver need to count
> against the user's locked memory limits regardless of iopf.  Thanks,

Currently we only have a vfio_pfn struct to track the external pinned pages
(single page granularity), so I add a vfio_range struct for efficient lookup.

Yeah, by this patch, for the non-pinned scope, we can directly return INVALID,
but for the pinned(non-faultable) scope, tracking the pinned range doesn't seem
to help more...

Thanks,
Shenming

> 
> Alex
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
