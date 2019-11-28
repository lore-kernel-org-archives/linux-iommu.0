Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20365C432C0
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 06:41:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68C1215A5
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 06:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68C1215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 72BB9868C9;
	Thu, 28 Nov 2019 06:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18SdRMLpIZJ7; Thu, 28 Nov 2019 06:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A26BD86880;
	Thu, 28 Nov 2019 06:41:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8701AC1DD5;
	Thu, 28 Nov 2019 06:41:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08D9CC0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 06:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E69D487798
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 06:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id deyyFFRRK2TE for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 06:41:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 759AC87797
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 06:41:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E117D68B05; Thu, 28 Nov 2019 07:40:56 +0100 (CET)
Date: Thu, 28 Nov 2019 07:40:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Message-ID: <20191128064056.GA19822@lst.de>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
 <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
 <20190918132242.GA16133@lst.de>
 <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jens Axboe <axboe@kernel.dk>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Peter Gonda <pgonda@google.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jianxiong Gao <jxgao@google.com>
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

On Wed, Nov 27, 2019 at 02:11:28PM -0800, David Rientjes wrote:
> So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
> even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
> was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
> to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
> can we do it within the DMA API itself so it's transparent to the driver?

It needs to be transparent to the driver.  Lots of drivers use GFP_ATOMIC
dma allocations, and all of them are broken on SEV setups currently.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
