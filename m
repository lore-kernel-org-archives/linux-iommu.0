Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A80C43462
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:37:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8A7613BB
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8A7613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C849884578;
	Fri, 21 May 2021 06:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ARqo4d5sEQYj; Fri, 21 May 2021 06:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2DA484560;
	Fri, 21 May 2021 06:37:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA04C000D;
	Fri, 21 May 2021 06:37:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE9E0C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4F5740318
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27OO6CJzi_8S for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 06:37:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D3D641858
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:37:33 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmcKG17ZbzCvPY;
 Fri, 21 May 2021 14:34:42 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:37:30 +0800
Received: from [10.174.187.155] (10.174.187.155) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:37:29 +0800
Subject: Re: [RFC PATCH v3 1/8] iommu: Evolve the device fault reporting
 framework
To: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-2-lushenming@huawei.com>
 <20210518125843.68552b67.alex.williamson@redhat.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <e929e47d-4d41-52e6-8702-d9a61321c2b0@huawei.com>
Date: Fri, 21 May 2021 14:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210518125843.68552b67.alex.williamson@redhat.com>
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
> On Fri, 9 Apr 2021 11:44:13 +0800
> Shenming Lu <lushenming@huawei.com> wrote:
> 
>> This patch follows the discussion here:
>>
>> https://lore.kernel.org/linux-acpi/YAaxjmJW+ZMvrhac@myrica/
>>
>> Besides SVA/vSVA, such as VFIO may also enable (2nd level) IOPF to remove
>> pinning restriction. In order to better support more scenarios of using
>> device faults, we extend iommu_register_fault_handler() with flags and
>> introduce FAULT_REPORT_ to describe the device fault reporting capability
>> under a specific configuration.
>>
>> Note that we don't further distinguish recoverable and unrecoverable faults
>> by flags in the fault reporting cap, having PAGE_FAULT_REPORT_ +
>> UNRECOV_FAULT_REPORT_ seems not a clean way.
>>
>> In addition, still take VFIO as an example, in nested mode, the 1st level
>> and 2nd level fault reporting may be configured separately and currently
>> each device can only register one iommu dev fault handler, so we add a
>> handler update interface for this.
> 
> 
> IIUC, you're introducing flags for the fault handler callout, which
> essentially allows the IOMMU layer to filter which types of faults the
> handler can receive.  You then need an update function to modify those
> flags.  Why can't the handler itself perform this filtering?  For
> instance in your vfio example, the handler registered by the type1
> backend could itself return fault until the fault transfer path to the
> device driver is established.  Thanks,

As discussed in [1]:

In nested IOPF, we have to figure out whether a fault comes from L1 or L2.
A SMMU stall event comes with this information, but a PRI page request doesn't.
The IOMMU driver can walk the page tables to find out the level information.
If the walk terminates at L1, further inject to the guest. Otherwise fix the
fault at L2 in VFIO. It's not efficient compared to hardware-provided info.

And in pinned case, if VFIO can tell the IOMMU driver that no L2 fault is
expected, there is no need to walk the page tables in the IOMMU driver?

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210108145217.2254447-4-jean-philippe@linaro.org/

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
