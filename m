Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC2C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:51:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2762261421
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2762261421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C64B740529;
	Tue, 11 May 2021 16:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id II7ZKzAlF9uB; Tue, 11 May 2021 16:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 910BC40417;
	Tue, 11 May 2021 16:51:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70AB7C000E;
	Tue, 11 May 2021 16:51:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98646C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7907240529
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGzUa-klO6-t for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5004240418
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:51:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 091D2613C6;
 Tue, 11 May 2021 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620751881;
 bh=36FOm/vubAEI0n2qxF3dc7ltKmZVubRWdCsf6LaDk8s=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=gO6+6kWfZzUSTxw2kbO6cTxuKglMDkF/V6jBMXaPjqGwC1vBJlt8oRXf2y22D/D/f
 h3ec4bZ36ZUQLYx/+rueldWcwYZZpjBrrmxaP1NLduZWCtgnykKt6u3Tq8Gm1NXu6Q
 IwjAhx5NWHNz/FkO71dMPx57gAvY1vNnR9hCwcTuaKoclxxteV1TOIbesBucfqhIMl
 1z6IZRpACDIot0Pg/Rth55+IITCQvd3xDbZdxucxGL2+3QSYBhPzAbTfiSYoRb5nTE
 1BwXhe9J4XZND5YgTRauuZ4YronUvWPzodXuoWixRNBKwHhMpiAhANdOcQhps6tn8Z
 Qa6gavxx/4WYA==
Date: Tue, 11 May 2021 09:51:20 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)]
In-Reply-To: <20210511164933.GA19775@lst.de>
Message-ID: <alpine.DEB.2.21.2105110950580.5018@sstabellini-ThinkPad-T480s>
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
 <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
 <20210511063558.GA7605@lst.de>
 <alpine.DEB.2.21.2105110925430.5018@sstabellini-ThinkPad-T480s>
 <20210511164933.GA19775@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: f.fainelli@gmail.com, Julien Grall <julien@xen.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 osstest service owner <osstest-admin@xenproject.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

On Tue, 11 May 2021, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 09:47:33AM -0700, Stefano Stabellini wrote:
> > That's a much better plan. It is also not super urgent, so maybe for now
> > we could add an explicit check for io_tlb_default_mem != NULL at the
> > beginning of xen_swiotlb_init? So that at least we can fail explicitly
> > or ignore it explicitly rather than by accident.
> 
> Fine with me.  Do you want to take over from here and test and submit
> your version?

I can do that. Can I add your signed-off-by for your original fix?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
