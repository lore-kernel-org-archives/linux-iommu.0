Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B227AC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 11:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4628F60FA9;
	Wed, 22 Dec 2021 11:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAI6jcXFB5Cn; Wed, 22 Dec 2021 11:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C50D60EB9;
	Wed, 22 Dec 2021 11:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E99E5C001E;
	Wed, 22 Dec 2021 11:53:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DECAC0012;
 Wed, 22 Dec 2021 11:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B8C84156C;
 Wed, 22 Dec 2021 11:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WL6V5IRMY0su; Wed, 22 Dec 2021 11:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE9F041559;
 Wed, 22 Dec 2021 11:53:16 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJs9S1wfNz67s22;
 Wed, 22 Dec 2021 19:51:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:53:13 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 11:53:12 +0000
Subject: Re: [PATCH 4/5] iommu: Separate IOVA rcache memories from iova_domain
 structure
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <mst@redhat.com>, <jasowang@redhat.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-5-git-send-email-john.garry@huawei.com>
 <2c58036f-d9aa-61f9-ae4b-f6938a135de5@huawei.com>
 <85c60ef4-e1af-c947-a2ed-b63c4fef36c3@arm.com>
Message-ID: <045030ed-0151-6259-e336-4235d6456223@huawei.com>
Date: Wed, 22 Dec 2021 11:53:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <85c60ef4-e1af-c947-a2ed-b63c4fef36c3@arm.com>
Content-Language: en-US
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 20/12/2021 13:57, Robin Murphy wrote:
>> Do you have any thoughts on this patch? The decision is whether we 
>> stick with a single iova domain structure or support this super 
>> structure for iova domains which support the rcache. I did not try the 
>> former - it would be do-able but I am not sure on how it would look.
> 
> TBH I feel inclined to take the simpler approach of just splitting the 
> rcache array to a separate allocation, making init_iova_rcaches() public 
> (with a proper return value), and tweaking put_iova_domain() to make 
> rcache cleanup conditional. A residual overhead of 3 extra pointers in 
> iova_domain doesn't seem like *too* much for non-DMA-API users to bear. 

OK, fine. So I tried as you suggested and it looks ok to me.

I'll send something out at rc1.

> Unless you want to try generalising the rcache mechanism completely away 
> from IOVA API specifics, it doesn't seem like there's really enough to 
> justify the bother of having its own distinct abstraction layer.

Yeah, I don't see that as necessary.

However something which could be useful is to separate the magazine code 
out for other possible users.

Thanks!
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
