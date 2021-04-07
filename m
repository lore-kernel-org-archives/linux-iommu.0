Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF0C433ED
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 09:54:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6C261394
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 09:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6C261394
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57096847F1;
	Wed,  7 Apr 2021 09:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ce5umQ5VHoqP; Wed,  7 Apr 2021 09:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 205E984494;
	Wed,  7 Apr 2021 09:54:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00930C000C;
	Wed,  7 Apr 2021 09:54:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F324EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D572083A8C
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6YMUTyKb3xK for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:54:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FABB83A7E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 09:54:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE12661382;
 Wed,  7 Apr 2021 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617789270;
 bh=IDtrPHkJJOYZTWgUxwdWXTJZs4VaWPqqNPI5cyUO7jQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FQ87ilWdr6b99mYNAwtdjO8sUVMD7/lvflLODf9ymnMJ8mjw5hZtDrjkYFdBiw8q7
 KMmekW5H0hW62Ult2Ajp5jqdTm75ZwRoj9qGipIoAMwsVA6g46Z7L9G2KT79XUyN2p
 bhnfAFK0KiY1tCyYlGF+hI5jwvmezshFkQgKqhIhNHxdS4J/HRX5iOVRzRn99tr3si
 mYRZzJXH3UJE+CFhwq3ZsxRQw+cG33PK7rTKVsL5/EqPPTWBPn5I1eyIICNCuZTlBg
 wuVG5EJ4wjP9pXAdRfbCPNTATGhtFKqVUCNgWd9PsPfaoTdDXBHf6wz+3a9qxvZrSS
 a6p00b2NJeOtw==
Date: Wed, 7 Apr 2021 10:54:26 +0100
From: Will Deacon <will@kernel.org>
To: isaacm@codeaurora.org
Subject: Re: [RFC PATCH v3 03/12] iommu/io-pgtable: Introduce map_pages() as
 a page table op
Message-ID: <20210407095425.GA15057@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-4-isaacm@codeaurora.org>
 <20210406115739.GD13747@willie-the-truck>
 <75a5d309498b8b41b5e24a2d9d36e78f@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75a5d309498b8b41b5e24a2d9d36e78f@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 06, 2021 at 02:07:41PM -0700, isaacm@codeaurora.org wrote:
> On 2021-04-06 04:57, Will Deacon wrote:
> > On Mon, Apr 05, 2021 at 12:11:03PM -0700, Isaac J. Manjarres wrote:
> > > Mapping memory into io-pgtables follows the same semantics
> > > that unmapping memory used to follow (i.e. a buffer will be
> > > mapped one page block per call to the io-pgtable code). This
> > > means that it can be optimized in the same way that unmapping
> > > memory was, so add a map_pages() callback to the io-pgtable
> > > ops structure, so that a range of pages of the same size
> > > can be mapped within the same call.
> > > 
> > > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > > Suggested-by: Will Deacon <will@kernel.org>
> > > ---
> > >  include/linux/io-pgtable.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > > index 2ed0c057d9e7..019149b204b8 100644
> > > --- a/include/linux/io-pgtable.h
> > > +++ b/include/linux/io-pgtable.h
> > > @@ -143,6 +143,7 @@ struct io_pgtable_cfg {
> > >   * struct io_pgtable_ops - Page table manipulation API for IOMMU
> > > drivers.
> > >   *
> > >   * @map:          Map a physically contiguous memory region.
> > > + * @map_pages:    Map a physically contiguous range of pages of the
> > > same size.
> > >   * @unmap:        Unmap a physically contiguous memory region.
> > >   * @unmap_pages:  Unmap a range of virtually contiguous pages of
> > > the same size.
> > >   * @iova_to_phys: Translate iova to physical address.
> > > @@ -153,6 +154,9 @@ struct io_pgtable_cfg {
> > >  struct io_pgtable_ops {
> > >  	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
> > >  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> > > +	int (*map_pages)(struct io_pgtable_ops *ops, unsigned long iova,
> > > +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> > > +			 int prot, gfp_t gfp, size_t *mapped);
> > 
> > How about returning 'size_t' and using IS_ERR_VALUE() instead of adding
> > the extra 'mapped' argument (i.e. return the size of the region mapped
> > or an error code)? I don't think we realistically need to care about map
> > sizes that overlap with the error region.
> > 
> I'd given that a shot before, but the problem that I kept running into was
> that
> in case of an error, if I return an error code, I don't know how much memory
> was mapped, so that I can invoke iommu_unmap from __iommu_map with that size
> to
> undo the partial mappings from a map_pages() call.

Ah yes, sorry, I see it now. So keep this as you've got it. Pushing the
cleanup path deeper doesn't feel like the right thing to do.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
