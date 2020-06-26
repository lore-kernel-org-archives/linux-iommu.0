Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893AEC433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:41:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8DE2078D
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 12:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8DE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 180C0204B6;
	Fri, 26 Jun 2020 12:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6FzMvkO6NLp; Fri, 26 Jun 2020 12:41:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3168A2036B;
	Fri, 26 Jun 2020 12:41:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15C47C0863;
	Fri, 26 Jun 2020 12:41:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 249A1C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 099B5864AA
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Auf-SuV9o5AQ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 12:41:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B774986228
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:41:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E4C1A68B02; Fri, 26 Jun 2020 14:41:04 +0200 (CEST)
Date: Fri, 26 Jun 2020 14:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Subject: Re: the XSK buffer pool needs be to reverted
Message-ID: <20200626124104.GA8835@lst.de>
References: <20200626074725.GA21790@lst.de>
 <f1512c3e-79eb-ba75-6f38-ca09795973c1@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1512c3e-79eb-ba75-6f38-ca09795973c1@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 iommu@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, "Karlsson, Magnus" <magnus.karlsson@intel.com>
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

On Fri, Jun 26, 2020 at 02:22:41PM +0200, Bj=F6rn T=F6pel wrote:
> Thanks for clarifying that. Let's work on a solution that can reside in
> the dma mapping core.
>
>> The commit seems to have a long dove tail of commits depending on it
>> despite only being a month old, so maybe you can do the revert for now?
>>
>
> Reverting the whole series sounds a bit too much. Let's focus on the
> part that breaks the dma api abstraction. I'm assuming that you're
> referring to the
>
>   static bool xp_check_cheap_dma(struct xsk_buff_pool *pool)
>
> function (and related functions called from that)?

Yes.

>
>> Note that this is somewhat urgent, as various of the APIs that the code
>> is abusing are slated to go away for Linux 5.9, so this addition comes
>> at a really bad time.
>>
>
> Understood. Wdyt about something in the lines of the diff below? It's
> build tested only, but removes all non-dma API usage ("poking
> internals"). Would that be a way forward, and then as a next step work
> on a solution that would give similar benefits, but something that would
> live in the dma mapping core?

Yes, that would solve the immediate issues.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
