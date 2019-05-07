Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57AC004C9
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:19:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B71E20825
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B71E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8DD7130F;
	Tue,  7 May 2019 11:19:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E445130E
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 11:19:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6354989E
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 07:39:05 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 92B9EAEC6;
	Tue,  7 May 2019 07:39:03 +0000 (UTC)
Date: Tue, 7 May 2019 09:39:01 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
Message-ID: <20190507073901.GC3486@suse.de>
References: <20190506164440.37399-1-cai@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190506164440.37399-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tmurphy@arista.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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

Hi Qian,

On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> iommu_map_page") added domain_flush_np_cache() in map_sg() which
> triggered a crash below during boot. sg_next() could return NULL if
> sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
> could be NULL which ends up deferencing a NULL pointer later here,
> 
> domain_flush_np_cache(domain, s->dma_address, s->dma_length);
> 
> so move domain_flush_np_cache() call inside for_each_sg() to loop over
> each sg element.

Thanks for the fix, but it is too late to merge it into the tree. I am
going to revert commit 1a1079011da3 for now and we can try again in the
next cycle.


Thanks,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
