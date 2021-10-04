Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31073C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 18:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19E261360
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 18:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A19E261360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D9434046E;
	Mon,  4 Oct 2021 18:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBtbxiqNibVW; Mon,  4 Oct 2021 18:19:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1ECAA40466;
	Mon,  4 Oct 2021 18:19:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D80DFC001C;
	Mon,  4 Oct 2021 18:18:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6819FC000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55F5E40466
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U341Ehns5dXm for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 18:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89B7740018
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 18:18:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206344021"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="206344021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 09:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="558600272"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 09:36:21 -0700
Date: Mon, 4 Oct 2021 09:40:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Barry Song <21cnbao@gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211004094003.527222e5@jacob-builder>
In-Reply-To: <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, mike.campin@intel.com
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

Hi Barry,

On Sat, 2 Oct 2021 01:45:59 +1300, Barry Song <21cnbao@gmail.com> wrote:

> >  
> > > I assume KVA mode can avoid this iotlb flush as the device is using
> > > the page table of the kernel and sharing the whole kernel space. But
> > > will users be glad to accept this mode?  
> >
> > You can avoid the lock be identity mapping the physical address space
> > of the kernel and maping map/unmap a NOP.
> >
> > KVA is just a different way to achive this identity map with slightly
> > different security properties than the normal way, but it doesn't
> > reach to the same security level as proper map/unmap.
> >
> > I'm not sure anyone who cares about DMA security would see value in
> > the slight difference between KVA and a normal identity map.  
> 
> yes. This is an important question. if users want a high security level,
> kva might not their choice; if users don't want the security, they are
> using iommu passthrough. So when will users choose KVA?
Right, KVAs sit in the middle in terms of performance and security.
Performance is better than IOVA due to IOTLB flush as you mentioned. Also
not too far behind of pass-through.

Security-wise, KVA respects kernel mapping. So permissions are better
enforced than pass-through and identity mapping.
To balance performance and security, we are proposing KVA is only supported
on trusted devices. On an Intel platform, it would be based on ACPI SATC
(SoC Integrated Address Translation Cache (SATC) reporting structure, VT-d
spec. 8.2). I am also adding a kernel iommu parameter to allow user
override.


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
