Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739EC433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 07:47:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF67820775
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 07:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF67820775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FA658837C;
	Fri, 26 Jun 2020 07:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5atVtFNcrHu9; Fri, 26 Jun 2020 07:47:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9E9888305;
	Fri, 26 Jun 2020 07:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F42C088C;
	Fri, 26 Jun 2020 07:47:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E6D3C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0DA1A85BD0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GQgzy1DiFX5L for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 07:47:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BB78D85B0A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9C65868B02; Fri, 26 Jun 2020 09:47:25 +0200 (CEST)
Date: Fri, 26 Jun 2020 09:47:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: the XSK buffer pool needs be to reverted
Message-ID: <20200626074725.GA21790@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Hi Bj=F6rn,

you addition of the xsk_buff_pool.c APIs in commit 2b43470add8c
("xsk: Introduce AF_XDP buffer allocation API") is unfortunately rather
broken by making lots of assumptions and poking into dma-direct and
swiotlb internals that are of no business to outside users and clearly
marked as such.   I'd be glad to work with your doing something proper
for pools, but that needs proper APIs and probably live in the dma
mapping core, but for that you'd actually need to contact the relevant
maintainers before poking into internals.

The commit seems to have a long dove tail of commits depending on it
despite only being a month old, so maybe you can do the revert for now?

Note that this is somewhat urgent, as various of the APIs that the code
is abusing are slated to go away for Linux 5.9, so this addition comes
at a really bad time.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
