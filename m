Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A8EC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 07:44:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261DF20771
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 07:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261DF20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0145E879D7;
	Wed,  8 Jul 2020 07:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXInbhpf3sIr; Wed,  8 Jul 2020 07:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1516987931;
	Wed,  8 Jul 2020 07:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7784C0893;
	Wed,  8 Jul 2020 07:44:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C417DC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B9A55886D1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uz7OI1NuU3Q7 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 07:44:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 970F68861D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:44:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A6CD68AFE; Wed,  8 Jul 2020 09:44:18 +0200 (CEST)
Date: Wed, 8 Jul 2020 09:44:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Subject: Re: add an API to check if a streamming mapping needs sync calls
Message-ID: <20200708074418.GA6815@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
 <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b97104e1-433c-8e35-59c6-b4dad047464c@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 29, 2020 at 03:39:01PM +0200, Bj=F6rn T=F6pel wrote:
> On 2020-06-29 15:03, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series lifts the somewhat hacky checks in the XSK code if a DMA
>> streaming mapping needs dma_sync_single_for_{device,cpu} calls to the
>> DMA API.
>>
>
> Thanks a lot for working on, and fixing this, Christoph!
>
> I took the series for a spin, and there are (obviously) no performance
> regressions.
>
> Would the patches go through the net/bpf trees or somewhere else?

Where did this end up?  I still don't see it in Linus' tree and this
is getting urgent now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
