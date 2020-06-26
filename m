Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A7C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA3B2076E
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 08:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA3B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 745E9864D6;
	Fri, 26 Jun 2020 08:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCoNOEBJY-ng; Fri, 26 Jun 2020 08:05:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88A3186447;
	Fri, 26 Jun 2020 08:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73DDCC088C;
	Fri, 26 Jun 2020 08:05:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 311B2C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 29EDA87678
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l5BYFDD67YnJ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 08:05:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DB91A875D4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 08:05:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DBB1F3FA; Fri, 26 Jun 2020 10:05:41 +0200 (CEST)
Date: Fri, 26 Jun 2020 10:05:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 2/2] iommu/amd: Use 'unsigned long' for domain->pt_root
Message-ID: <20200626080539.GP3701@8bytes.org>
References: <20200625145227.4159-1-joro@8bytes.org>
 <20200625145227.4159-3-joro@8bytes.org>
 <20200625153720.GA1127@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625153720.GA1127@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org
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

Hi Qian,

On Thu, Jun 25, 2020 at 11:37:20AM -0400, Qian Cai wrote:
> On Thu, Jun 25, 2020 at 04:52:27PM +0200, Joerg Roedel wrote:
> > -	u64 pt_root = atomic64_read(&domain->pt_root);
> > +	unsigned long pt_root = domain->pt_root;
> 
> The pt_root might be reload later in case of register pressure where the
> compiler decides to not store it as a stack variable, so it needs
> smp_rmb() here to match to the smp_wmb() in
> amd_iommu_domain_set_pt_root() to make the load visiable to all CPUs.
> 
> Then, smp_rmb/wmb() wouldn't be able to deal with data races, so it
> needs,
> 
> unsigned long pt_root = READ_ONCE(domain->pt_root);
> 
> >  
> >  	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
> >  	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
> > @@ -164,7 +164,13 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
> >  
> >  static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
> >  {
> > -	atomic64_set(&domain->pt_root, root);
> > +	domain->pt_root = root;
> 
> WRITE_ONCE(domain->pt_root, root);

Thanks for your review. I addressed your comments and will send an
updated version shortly.


Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
