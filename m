Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592BC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 04:46:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2870206C1
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 04:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2870206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 62FC4C2A;
	Fri, 16 Aug 2019 04:46:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 18A05C21
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 04:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A53B8E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 04:46:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F247F68AFE; Fri, 16 Aug 2019 06:46:13 +0200 (CEST)
Date: Fri, 16 Aug 2019 06:46:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
Message-ID: <20190816044613.GC4093@lst.de>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
	<20190730045229.3826-6-baolu.lu@linux.intel.com>
	<20190814083842.GB22669@8bytes.org>
	<445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
	<20190815154845.GA18327@8bytes.org>
	<ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Alan Cox <alan@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@intel.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 16, 2019 at 10:45:13AM +0800, Lu Baolu wrote:
> Okay. I understand that adding these APIs in iommu.c is not a good idea.
> And, I also don't think merging the bounce buffer implementation into
> iommu_map() is feasible since iommu_map() is not DMA API centric.
>
> The bounce buffer implementation will eventually be part of DMA APIs
> defined in dma-iommu.c, but currently those APIs are not ready for x86
> use yet. So I will put them in iommu/vt-d driver for this time being and
> will move them to dma-iommu.c later.

I think they are more or less ready actually, we just need more people
reviewing the conversions.  Tom just reposted the AMD one which will need
a few more reviews, and he has an older patchset for intel-iommu as well
that could use a some more eyes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
