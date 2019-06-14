Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE5C31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 12:22:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D021F20850
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 12:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3789E30;
	Fri, 14 Jun 2019 12:22:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 57931B6C
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 12:22:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 03042E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 12:22:13 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 7061168AFE; Fri, 14 Jun 2019 14:21:44 +0200 (CEST)
Date: Fri, 14 Jun 2019 14:21:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greentime Hu <green.hu@gmail.com>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
Message-ID: <20190614122143.GA26467@lst.de>
References: <20190614100928.9791-1-hch@lst.de>
	<CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Vincent Chen <deanbo422@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 14, 2019 at 07:35:29PM +0800, Greentime Hu wrote:
> It looks good to me. I just verified in nds32 platform and it works fine.
> Should I put it in my next-tree or you will pick it up in your tree? :)

Either way works for me, let me know what you prefer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
