Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08EEC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 18:17:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96B76124B
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 18:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B76124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70C4340546;
	Thu,  3 Jun 2021 18:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P8jQdskDMhhA; Thu,  3 Jun 2021 18:17:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D3254020C;
	Thu,  3 Jun 2021 18:17:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4231FC000D;
	Thu,  3 Jun 2021 18:17:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30414C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 18:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A3B5405E6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 18:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-IwQnHT6Hsp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 18:16:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EBD6405C7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 18:16:56 +0000 (UTC)
IronPort-SDR: eaDKGkeB8bcOYY92W5QnxGJ1M6B9PZ8TXDp6yL69CXdhh9JYULSol9vimZWR6XHwB16v0J29cd
 mviBfsi9Fa3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202256218"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="202256218"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 11:16:38 -0700
IronPort-SDR: 9pBvENtfWuBMbET//Z1zc0S1vJhEpeu/skYlOjWVxtlNDyqkMly957fa7Ne228wAOY12hp6yte
 ueK+lCzlzh/A==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="417479645"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 11:16:37 -0700
Date: Thu, 3 Jun 2021 11:19:14 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603111914.653c4f61@jacob-builder>
In-Reply-To: <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
 <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
 <20210601173323.GN1002214@nvidia.com>
 <23a482f9-b88a-da98-3800-f3fd9ea85fbd@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

Hi Shenming,

On Wed, 2 Jun 2021 12:50:26 +0800, Shenming Lu <lushenming@huawei.com>
wrote:

> On 2021/6/2 1:33, Jason Gunthorpe wrote:
> > On Tue, Jun 01, 2021 at 08:30:35PM +0800, Lu Baolu wrote:
> >   
> >> The drivers register per page table fault handlers to /dev/ioasid which
> >> will then register itself to iommu core to listen and route the per-
> >> device I/O page faults.   
> > 
> > I'm still confused why drivers need fault handlers at all?  
> 
> Essentially it is the userspace that needs the fault handlers,
> one case is to deliver the faults to the vIOMMU, and another
> case is to enable IOPF on the GPA address space for on-demand
> paging, it seems that both could be specified in/through the
> IOASID_ALLOC ioctl?
> 
I would think IOASID_BIND_PGTABLE is where fault handler should be
registered. There wouldn't be any IO page fault without the binding anyway.

I also don't understand why device drivers should register the fault
handler, the fault is detected by the pIOMMU and injected to the vIOMMU. So
I think it should be the IOASID itself register the handler.

> Thanks,
> Shenming
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
