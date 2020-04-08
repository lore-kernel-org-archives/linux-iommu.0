Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2962C2BA1A
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:16:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DAD2072F
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 19:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DAD2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82D8188362;
	Wed,  8 Apr 2020 19:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eP94CsIpAk7; Wed,  8 Apr 2020 19:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 094BB88263;
	Wed,  8 Apr 2020 19:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E44E2C1AE8;
	Wed,  8 Apr 2020 19:16:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62779C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 59DE386ACE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DU-BIhPLCGkp for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 19:16:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1DD94868F9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 19:16:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B967C68C4E; Wed,  8 Apr 2020 21:16:44 +0200 (CEST)
Date: Wed, 8 Apr 2020 21:16:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] dma-debug: fix displaying of dma allocation type
Message-ID: <20200408191644.GA12239@lst.de>
References: <20200408184804.30522-1-grygorii.strashko@ti.com>
 <20200408184958.GA9945@lst.de> <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 08, 2020 at 10:13:55PM +0300, Grygorii Strashko wrote:
>>>   -static const char *type2name[5] = { "single", "page",
>>> +static const char *type2name[5] = { "single",
>>>   				    "scather-gather", "coherent",
>>>   				    "resource" };
>>
>> To make sure this doesn't happen anymore, can you switch to
>> named initializers?
>>
>
> Just to clarify.
> Do you mean
> [dma_debug_coherent] = "coherent",
> ?

Yes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
