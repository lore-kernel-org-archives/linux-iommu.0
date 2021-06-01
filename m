Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6EC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:31:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EC761263
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 04:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EC761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D05383BBE;
	Tue,  1 Jun 2021 04:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjCCmXOa8HC5; Tue,  1 Jun 2021 04:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0040C83BAA;
	Tue,  1 Jun 2021 04:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5319C000E;
	Tue,  1 Jun 2021 04:31:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BBAEC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F280283BBE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ndkrp7qvss60 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 04:31:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D90C683BAA
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 04:31:50 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvJyx5fcLzWqK0;
 Tue,  1 Jun 2021 12:27:05 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:31:47 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 12:31:46 +0800
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Alex Williamson
 (alex.williamson@redhat.com)" <alex.williamson@redhat.com>, Jason Wang
 <jasowang@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
Date: Tue, 1 Jun 2021 12:31:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2021/5/27 15:58, Tian, Kevin wrote:
> /dev/ioasid provides an unified interface for managing I/O page tables for 
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA, 
> etc.) are expected to use this interface instead of creating their own logic to 
> isolate untrusted device DMAs initiated by userspace. 
> 
> This proposal describes the uAPI of /dev/ioasid and also sample sequences 
> with VFIO as example in typical usages. The driver-facing kernel API provided 
> by the iommu layer is still TBD, which can be discussed after consensus is 
> made on this uAPI.
> 
> It's based on a lengthy discussion starting from here:
> 	https://lore.kernel.org/linux-iommu/20210330132830.GO2356281@nvidia.com/ 
> 
> It ends up to be a long writing due to many things to be summarized and
> non-trivial effort required to connect them into a complete proposal.
> Hope it provides a clean base to converge.
> 

[..]

> 
> /*
>   * Page fault report and response
>   *
>   * This is TBD. Can be added after other parts are cleared up. Likely it 
>   * will be a ring buffer shared between user/kernel, an eventfd to notify 
>   * the user and an ioctl to complete the fault.
>   *
>   * The fault data is per I/O address space, i.e.: IOASID + faulting_addr
>   */

Hi,

It seems that the ioasid has different usage in different situation, it could
be directly used in the physical routing, or just a virtual handle that indicates
a page table or a vPASID table (such as the GPA address space, in the simple
passthrough case, the DMA input to IOMMU will just contain a Stream ID, no
Substream ID), right?

And Baolu suggested that since one device might consume multiple page tables,
it's more reasonable to have one fault handler per page table. By this, do we
have to maintain such an ioasid info list in the IOMMU layer?

Then if we add host IOPF support (for the GPA address space) in the future
(I have sent a series for this but it aimed for VFIO, I will convert it for
IOASID later [1] :-)), how could we find the handler for the received fault
event which only contains a Stream ID... Do we also have to maintain a
dev(vPASID)->ioasid mapping in the IOMMU layer?

[1] https://lore.kernel.org/patchwork/cover/1410223/

Thanks,
Shenming
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
