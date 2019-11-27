Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CBAC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 22:19:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0212158A
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 22:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rk3/E/zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0212158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 262B187CD6;
	Wed, 27 Nov 2019 22:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j+d7hHL2ujmm; Wed, 27 Nov 2019 22:19:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0BBAA877AE;
	Wed, 27 Nov 2019 22:19:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0832C1DD5;
	Wed, 27 Nov 2019 22:19:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D66EC0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 22:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 86D32859E3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 22:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wfzq1TbYeHHY for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 22:19:38 +0000 (UTC)
X-Greylist: delayed 00:08:07 by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DCF1B858D2
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 22:19:38 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id a16so10764324pjs.13
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=B5LqWF3rYDR89Yh3BXrMDS+UXYNZjHzn7pTz6vzOHlY=;
 b=rk3/E/zffHsy8rz63sYN92yC6wWOr9BEwOQrb0DBNMRIVHSNUsagH6qMud3IIp3iBQ
 K81EH++9mhuZaeBiaC566bAbrNPfSUxK4HznlqvK6p/q6NhRjHuV3kTmszjaPq8aS78y
 Zq5lNx9maFh2os9tmgXOznf+4ilhdWlIYpXfp+gc2SHTX2ShpNuvz3EsWJd/LcMnqX5Q
 63L5SiWS7u+Z0xF578Q9n1Z/Vq0Z8gI81DovTK8aVPhOPg6ZiiRvkjERrdrguTixDRbE
 iXIO0BjOVgIlRFgSqFIYxlwj3nGD5BpCnxEXw5e7wqwshBBCrKCoBc99XgU6uPl8RLP6
 EHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=B5LqWF3rYDR89Yh3BXrMDS+UXYNZjHzn7pTz6vzOHlY=;
 b=t2dokX7IwOYDBSDcy00ckeEzNfnPshnF+xf/pfo2BD9yBpoVjLLPfcD+NEQrVNIkZb
 K+zQA4mhU46dtiss7CBFV7YPIMzSg0I6JC+r9Mrn3RVfFETPPylRkFkKgdEx9vPLfyc/
 cEZsPnIh8KM08E1pPWnBUd8piBtQ8q0sEC8ust0N+Up5Hh9+L8z2EKhfuh1qJdFpm8Gp
 WjrJVHIPw+r+M76yXt0cHPHWF/3FU3s3WDbDfypL9PfC/HyInW9/mJ2hLNp6SNHA0g9E
 EXx4hzoOmThtCAkEv4XVo4WeTLGBHnaMF4lZn7LXBGlriKvqnyfx1fazdDsNuuxGKP/j
 6DkQ==
X-Gm-Message-State: APjAAAX5Jv6JK1VG5O/AFcvkV0StZN3p4f+5HNycJIG2j/wxIjAQoMh3
 ECkWsz0GwZwBe2EQJy9y4mi9aHriy3w=
X-Google-Smtp-Source: APXvYqy8/zn33Ofgd+uyq7QIQadaZYFdnkrUQTrzDDCOnkS+RZCfAzYTFN3HsvKXPHxBVLC+LLRdig==
X-Received: by 2002:a17:902:7089:: with SMTP id
 z9mr6367022plk.292.1574892691057; 
 Wed, 27 Nov 2019 14:11:31 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id a21sm7818948pjv.20.2019.11.27.14.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 14:11:29 -0800 (PST)
Date: Wed, 27 Nov 2019 14:11:28 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20190918132242.GA16133@lst.de>
Message-ID: <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
 <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
 <20190918132242.GA16133@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Peter Gonda <pgonda@google.com>, Keith Busch <kbusch@kernel.org>,
 Jianxiong Gao <jxgao@google.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 18 Sep 2019, Christoph Hellwig wrote:

> On Tue, Sep 17, 2019 at 06:41:02PM +0000, Lendacky, Thomas wrote:
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
> > >  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
> > >  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> > >  		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
> > > -		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
> > > +		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
> > > +					  BLK_MQ_F_BLOCKING;
> > 
> > I think you want to only set the BLK_MQ_F_BLOCKING if the DMA is required
> > to be unencrypted. Unfortunately, force_dma_unencrypted() can't be called
> > from a module. Is there a DMA API that could be called to get that info?
> 
> The DMA API must support non-blocking calls, and various drivers rely
> on that.  So we need to provide that even for the SEV case.  If the
> actual blocking can't be made to work we'll need to wire up the DMA
> pool in kernel/dma/remap.c for it (and probably move it to separate
> file).
> 

Resurrecting this thread from a couple months ago because it appears that 
this is still an issue with 5.4 guests.

dma_pool_alloc(), regardless of whether mem_flags allows blocking or not, 
can always sleep if the device's DMA must be unencrypted and 
mem_encrypt_active() == true.  We know this because vm_unmap_aliases() can 
always block.

NVMe's setup of PRPs and SGLs uses dma_pool_alloc(GFP_ATOMIC) but when 
this is a SEV-enabled guest this allocation may block due to the 
possibility of allocating DMA coherent memory through dma_direct_alloc().

It seems like one solution would be to add significant latency by doing 
BLK_MQ_F_BLOCKING if force_dma_unencrypted() is true for the device but 
this comes with significant downsides.

So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
can we do it within the DMA API itself so it's transparent to the driver?

Thomas/Brijesh: separately, it seems the use of set_memory_encrypted() or 
set_memory_decrypted() must be possible without blocking; is this only an 
issue from the DMA API point of view or can it be done elsewhere?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
