Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F7AC2BB86
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521620732
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XelkJSeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521620732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50CC6862BC;
	Fri, 10 Apr 2020 19:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5_1BQq0E9z1; Fri, 10 Apr 2020 19:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E859A855F6;
	Fri, 10 Apr 2020 19:37:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D513BC089F;
	Fri, 10 Apr 2020 19:37:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF2FC0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 19:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 766FA88183
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 19:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dv+xfwOtrelv for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 19:37:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BF95088177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 19:37:22 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id k5so1383248pga.2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=eY+CI9YUMAjOh4YqmN7BSzI+LQc+sWyi0ugJbjXN5uQ=;
 b=XelkJSeZVTY87SNnF2pKDT8Yg39E+gB8zoKeQ8MPaxZqUDd978lszegCGThMWc7fTW
 JhoatwplKpp+4hzFROpAZlqL/SeW9RSGw0hdpiKlmNOix5QRrvezLXVzSqQI3lxWwETC
 IQ1pPPDJiF3e5GyK3vOcz7UlNAW/bZK1jPyCe0P1hmWuYt5fj7fKHdtaJ0hpXf0PZKIf
 9p7CEOtWTub3VLD4phzxv1Ut1/kfFoMI+NPHc7YztpEGULG6rXcGbU0pDNs/bisWZqqM
 OFxDfNir4pgu8QctwGDEynFvUJY3BlVHvoKe3SHiz4sqzSEAm3vQYzPG7jWNsF68C9VI
 3Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=eY+CI9YUMAjOh4YqmN7BSzI+LQc+sWyi0ugJbjXN5uQ=;
 b=bg68zch9mVv5ss/alcJPyLzjVx1Q00QOk6wmKre95M/u7QjSdcMkTdqQaWkIZ1WvAu
 Jkv4qVehSaMAMycgDEly8i4P5fgzlwEip77Ibma1lapkqHNcIVuYLoXpXD5H6tFCaYwf
 X5E9mCmoPN9ApwlQd7Lf1ouTlmbXx80N9x8se6M2v9CKSxyY/dZg0EeiRQ1vG9ev0WeP
 +KhCFs1gtzpNKAc2KP44LAxfE5vWisi82qljQvMsQAgPcIu47Oopd1fiqJaKVOauaR3a
 YnaHEPGLgigNh6Hh9VgmKpHmMxxJfU8iBpcfueJggoU0x3+ty3liappln0X8ayYkLyA+
 FTBw==
X-Gm-Message-State: AGi0PuZM2cqxXKzFKg901Y4lDY1I2c3poaDLLfwVyiqZkeZ5az1smt7D
 BhyeZhkflV6nU5sazEMfRBAukw==
X-Google-Smtp-Source: APiQypJap4XYb6OLfN6N3dmdOCNtdz9IVqLUzAY0Gi5Syeddt2+rDTEaLZ+aoQkdrBGcOUnmAt+dkg==
X-Received: by 2002:a62:5cc2:: with SMTP id q185mr6421328pfb.125.1586547441997; 
 Fri, 10 Apr 2020 12:37:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id n21sm2282025pgf.36.2020.04.10.12.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 12:37:21 -0700 (PDT)
Date: Fri, 10 Apr 2020 12:37:20 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Hillf Danton <hdanton@sina.com>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <20200410145520.17864-1-hdanton@sina.com>
Message-ID: <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
 <20200410145520.17864-1-hdanton@sina.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 linux <linux-kernel@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, 10 Apr 2020, Hillf Danton wrote:

> 
> On Wed, 8 Apr 2020 14:21:06 -0700 (PDT) David Rientjes wrote:
> > 
> > When an atomic pool becomes fully depleted because it is now relied upon
> > for all non-blocking allocations through the DMA API, allow background
> > expansion of each pool by a kworker.
> > 
> > When an atomic pool has less than the default size of memory left, kick
> > off a kworker to dynamically expand the pool in the background.  The pool
> > is doubled in size, up to MAX_ORDER-1.  If memory cannot be allocated at
> > the requested order, smaller allocation(s) are attempted.
> > 
> What is proposed looks like a path of single lane without how to
> dynamically shrink the pool taken into account. Thus the risk may
> rise in corner cases where pools are over-expanded in long run
> after one-off peak allocation requests.
> 

To us, this is actually a benefit: we prefer the peak size to be 
maintained so that we do not need to dynamic resize the pool later at the 
cost of throughput.  Genpool also does not have great support for 
scavenging and freeing unused chunks.

Perhaps we could enforce a maximum size on the pools just as we allow the 
default size to be defined by coherent_size= on the command line.  Our use 
case would not set this, however, since we have not seen egregious genpool 
sizes as the result of non-blockable DMA allocations (perhaps the drivers 
we use just play friendlier and you have seen excessive usage?).

I'll rely on Christoph to determine whether it makes sense to add some 
periodic scavening of the atomic pools, whether that's needed for this to 
be merged, or wheter we should enforce some maximum pool size.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
