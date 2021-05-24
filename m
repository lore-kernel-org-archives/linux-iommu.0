Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735AC2B9F8
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 22:11:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EDD61425
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 22:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EDD61425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9787400F3;
	Mon, 24 May 2021 22:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uR5pEH2k5sq2; Mon, 24 May 2021 22:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B3DE403DF;
	Mon, 24 May 2021 22:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE27C0025;
	Mon, 24 May 2021 22:11:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E223C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 22:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE9374031F
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 22:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4bZ6iw7nsYLR for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 22:11:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75E77404D0
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621894312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUla4T9MuJZxERVs6XqEyftaAb31ccR2xj+puFqVVW8=;
 b=HGEwMEp+0DkAXQFsCujkhtLz7YFitTSidWRDm+65XtKv2Xh08wZ6t2j/kfeTxR6fjrgEXy
 JBX+e5fI9jt6ZuFZ13Du7S8DBXYsdnoexvMCI9jCQ078f1tyIUxSVO03/f16mrMuF/sLjC
 8MeaUroHez2HBx0JHV66QgnOi+gMBCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-fIDzMO5AMui_CYToRjykfw-1; Mon, 24 May 2021 18:11:48 -0400
X-MC-Unique: fIDzMO5AMui_CYToRjykfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3220803622;
 Mon, 24 May 2021 22:11:45 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-113-225.phx2.redhat.com
 [10.3.113.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 366BD5C6AB;
 Mon, 24 May 2021 22:11:45 +0000 (UTC)
Date: Mon, 24 May 2021 16:11:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [RFC PATCH v3 0/8] Add IOPF support for VFIO passthrough
Message-ID: <20210524161136.03e9323d@x1.home.shazbot.org>
In-Reply-To: <accfb404-1d7b-8d73-6fb7-50011a3e546f@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210518125756.4c075300.alex.williamson@redhat.com>
 <accfb404-1d7b-8d73-6fb7-50011a3e546f@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
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

On Fri, 21 May 2021 14:37:21 +0800
Shenming Lu <lushenming@huawei.com> wrote:

> Hi Alex,
> 
> On 2021/5/19 2:57, Alex Williamson wrote:
> > On Fri, 9 Apr 2021 11:44:12 +0800
> > Shenming Lu <lushenming@huawei.com> wrote:
> >   
> >> Hi,
> >>
> >> Requesting for your comments and suggestions. :-)
> >>
> >> The static pinning and mapping problem in VFIO and possible solutions
> >> have been discussed a lot [1, 2]. One of the solutions is to add I/O
> >> Page Fault support for VFIO devices. Different from those relatively
> >> complicated software approaches such as presenting a vIOMMU that provides
> >> the DMA buffer information (might include para-virtualized optimizations),
> >> IOPF mainly depends on the hardware faulting capability, such as the PCIe
> >> PRI extension or Arm SMMU stall model. What's more, the IOPF support in
> >> the IOMMU driver has already been implemented in SVA [3]. So we add IOPF
> >> support for VFIO passthrough based on the IOPF part of SVA in this series.  
> > 
> > The SVA proposals are being reworked to make use of a new IOASID
> > object, it's not clear to me that this shouldn't also make use of that
> > work as it does a significant expansion of the type1 IOMMU with fault
> > handlers that would duplicate new work using that new model.  
> 
> It seems that the IOASID extension for guest SVA would not affect this series,
> will we do any host-guest IOASID translation in the VFIO fault handler?

Surely it will, we don't currently have any IOMMU fault handling or
forwarding of IOMMU faults through to the vfio bus driver, both of
those would be included in an IOASID implementation.  I think Jason's
vision is to use IOASID to deprecate type1 for all use cases, so even
if we were to choose to implement IOPF in type1 we should agree on
common interfaces with IOASID.
 
> >> We have measured its performance with UADK [4] (passthrough an accelerator
> >> to a VM(1U16G)) on Hisilicon Kunpeng920 board (and compared with host SVA):
> >>
> >> Run hisi_sec_test...
> >>  - with varying sending times and message lengths
> >>  - with/without IOPF enabled (speed slowdown)
> >>
> >> when msg_len = 1MB (and PREMAP_LEN (in Patch 4) = 1):
> >>             slowdown (num of faults)
> >>  times      VFIO IOPF      host SVA
> >>  1          63.4% (518)    82.8% (512)
> >>  100        22.9% (1058)   47.9% (1024)
> >>  1000       2.6% (1071)    8.5% (1024)
> >>
> >> when msg_len = 10MB (and PREMAP_LEN = 512):
> >>             slowdown (num of faults)
> >>  times      VFIO IOPF
> >>  1          32.6% (13)
> >>  100        3.5% (26)
> >>  1000       1.6% (26)  
> > 
> > It seems like this is only an example that you can make a benchmark
> > show anything you want.  The best results would be to pre-map
> > everything, which is what we have without this series.  What is an
> > acceptable overhead to incur to avoid page pinning?  What if userspace
> > had more fine grained control over which mappings were available for
> > faulting and which were statically mapped?  I don't really see what
> > sense the pre-mapping range makes.  If I assume the user is QEMU in a
> > non-vIOMMU configuration, pre-mapping the beginning of each RAM section
> > doesn't make any logical sense relative to device DMA.  
> 
> As you said in Patch 4, we can introduce full end-to-end functionality
> before trying to improve performance, and I will drop the pre-mapping patch
> in the current stage...
> 
> Is there a need that userspace wants more fine grained control over which
> mappings are available for faulting? If so, we may evolve the MAP ioctl
> to support for specifying the faulting range.

You're essentially enabling this for a vfio bus driver via patch 7/8,
pinning for selective DMA faulting.  How would a driver in userspace
make equivalent requests?  In the case of performance, the user could
mlock the page but they have no mechanism here to pre-fault it.  Should
they?

> As for the overhead of IOPF, it is unavoidable if enabling on-demand paging
> (and page faults occur almost only when first accessing), and it seems that
> there is a large optimization space compared to CPU page faulting.

Yes, there's of course going to be overhead in terms of latency for the
page faults.  My point was more that when a host is not under memory
pressure we should trend towards the performance of pinned, static
mappings and we should be able to create arbitrarily large pre-fault
behavior to show that.  But I think what we really want to enable via
IOPF is density, right?  Therefore how many more assigned device guests
can you run on a host with IOPF?  How does the slope, plateau, and
inflection point of their aggregate throughput compare to static
pinning?  VM startup time is probably also a useful metric, ie. trading
device latency for startup latency.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
