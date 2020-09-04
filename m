Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC2C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:55:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B8820791
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 09:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B8820791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DAF248751B;
	Fri,  4 Sep 2020 09:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcyNmELZNF9C; Fri,  4 Sep 2020 09:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C5AE874F6;
	Fri,  4 Sep 2020 09:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41947C0052;
	Fri,  4 Sep 2020 09:55:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D37DEC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CF63486DB6
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W68tOuNBBHLj for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 09:55:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3D63A86DB2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 09:55:31 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D8B8F9CE; Fri,  4 Sep 2020 11:55:29 +0200 (CEST)
Date: Fri, 4 Sep 2020 11:55:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Remove broken huge page handling
Message-ID: <20200904095528.GS6714@8bytes.org>
References: <e287dbe69aa0933abafd97c80631940fd188ddd1.1599132844.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e287dbe69aa0933abafd97c80631940fd188ddd1.1599132844.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Roman Gushchin <guro@fb.com>
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

On Thu, Sep 03, 2020 at 12:34:04PM +0100, Robin Murphy wrote:
> The attempt to handle huge page allocations was originally added since
> the comments around stripping __GFP_COMP in other implementations were
> nonsensical, and we naively assumed that split_huge_page() could simply
> be called equivalently to split_page(). It turns out that this doesn't
> actually work correctly, so just get rid of it - there's little point
> going to the effort of allocating huge pages if we're only going to
> split them anyway.
> 
> Reported-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
