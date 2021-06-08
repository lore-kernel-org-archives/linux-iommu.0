Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A2C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:09:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431DB61073
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DB61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09BE7402AB;
	Tue,  8 Jun 2021 01:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0Mksy6gmOqD; Tue,  8 Jun 2021 01:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6F85400E0;
	Tue,  8 Jun 2021 01:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CEE3C000D;
	Tue,  8 Jun 2021 01:09:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3A3AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB124403C7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KeERV46NmDgo for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:09:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65456403C0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:09:31 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzXBQ5JNHzYrPB;
 Tue,  8 Jun 2021 09:06:38 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:09:22 +0800
Received: from [10.174.185.220] (10.174.185.220) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:09:21 +0800
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
 <20210603111914.653c4f61@jacob-builder>
 <eebe5926-efa0-8bab-e8d4-bd327669637f@huawei.com>
 <BN6PR11MB4068FDFFF36C1F15046E0A0EC3389@BN6PR11MB4068.namprd11.prod.outlook.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <9653f2a9-b6a0-86e8-19d4-53ab9079c49c@huawei.com>
Date: Tue, 8 Jun 2021 09:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB4068FDFFF36C1F15046E0A0EC3389@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.220]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin
 Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On 2021/6/7 20:19, Liu, Yi L wrote:
>> From: Shenming Lu <lushenming@huawei.com>
>> Sent: Friday, June 4, 2021 10:03 AM
>>
>> On 2021/6/4 2:19, Jacob Pan wrote:
>>> Hi Shenming,
>>>
>>> On Wed, 2 Jun 2021 12:50:26 +0800, Shenming Lu
>> <lushenming@huawei.com>
>>> wrote:
>>>
>>>> On 2021/6/2 1:33, Jason Gunthorpe wrote:
>>>>> On Tue, Jun 01, 2021 at 08:30:35PM +0800, Lu Baolu wrote:
>>>>>
>>>>>> The drivers register per page table fault handlers to /dev/ioasid which
>>>>>> will then register itself to iommu core to listen and route the per-
>>>>>> device I/O page faults.
>>>>>
>>>>> I'm still confused why drivers need fault handlers at all?
>>>>
>>>> Essentially it is the userspace that needs the fault handlers,
>>>> one case is to deliver the faults to the vIOMMU, and another
>>>> case is to enable IOPF on the GPA address space for on-demand
>>>> paging, it seems that both could be specified in/through the
>>>> IOASID_ALLOC ioctl?
>>>>
>>> I would think IOASID_BIND_PGTABLE is where fault handler should be
>>> registered. There wouldn't be any IO page fault without the binding
>> anyway.
>>
>> Yeah, I also proposed this before, registering the handler in the
>> BIND_PGTABLE
>> ioctl does make sense for the guest page faults. :-)
>>
>> But how about the page faults from the GPA address space (it's page table is
>> mapped through the MAP_DMA ioctl)? From your point of view, it seems
>> that we should register the handler for the GPA address space in the (first)
>> MAP_DMA ioctl.
> 
> under new proposal, I think the page fault handler is also registered
> per ioasid object. The difference compared with guest page table case
> is there is no need to inject the fault to VM.

Yeah.  And there are some issues specific to the GPA address space case
which have been discussed with Alex..  Thanks,

Shenming
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
