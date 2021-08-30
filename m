Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51FC4320E
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 12:00:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B69611CE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 12:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29B69611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED3A460785;
	Mon, 30 Aug 2021 12:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BTZdsotWfa4y; Mon, 30 Aug 2021 12:00:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E6CD60636;
	Mon, 30 Aug 2021 12:00:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA98C0010;
	Mon, 30 Aug 2021 12:00:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3912C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 12:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95A1A60636
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 12:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRDBEzMtY2uR for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 12:00:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8838D60785
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 12:00:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 25CFD68B05; Mon, 30 Aug 2021 14:00:37 +0200 (CEST)
Date: Mon, 30 Aug 2021 14:00:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
Message-ID: <20210830120036.GA22005@lst.de>
References: <20210827172114.414281-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827172114.414281-1-ltykernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 dave.hansen@intel.com, netdev@vger.kernel.org, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com,
 martin.petersen@oracle.com, saravanand@fb.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, ardb@kernel.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
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

Sorry for the delayed answer, but I look at the vmap_pfn usage in the
previous version and tried to come up with a better version.  This
mostly untested branch:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hyperv-vmap

get us there for swiotlb and the channel infrastructure  I've started
looking at the network driver and didn't get anywhere due to other work.

As far as I can tell the network driver does gigantic multi-megabyte
vmalloc allocation for the send and receive buffers, which are then
passed to the hardware, but always copied to/from when interacting
with the networking stack.  Did I see that right?  Are these big
buffers actually required unlike the normal buffer management schemes
in other Linux network drivers?

If so I suspect the best way to allocate them is by not using vmalloc
but just discontiguous pages, and then use kmap_local_pfn where the
PFN includes the share_gpa offset when actually copying from/to the
skbs.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
