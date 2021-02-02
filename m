Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA507C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:57:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DD564EC5
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DD564EC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2923867BB;
	Tue,  2 Feb 2021 13:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExubKXcMCt5k; Tue,  2 Feb 2021 13:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5CC44867C6;
	Tue,  2 Feb 2021 13:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 457E7C0174;
	Tue,  2 Feb 2021 13:57:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F389C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5328820372
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NHdyFEVvp3O2 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 13:57:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id A909820370
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:57:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 354083D4; Tue,  2 Feb 2021 14:57:52 +0100 (CET)
Date: Tue, 2 Feb 2021 14:57:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.12
Message-ID: <20210202135750.GY32671@8bytes.org>
References: <20210201154633.GC15263@willie-the-truck>
 <20210202133456.GT32671@8bytes.org>
 <20210202135339.GC17070@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202135339.GC17070@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Feb 02, 2021 at 01:53:41PM +0000, Will Deacon wrote:
> On Tue, Feb 02, 2021 at 02:34:56PM +0100, Joerg Roedel wrote:
> > On Mon, Feb 01, 2021 at 03:46:33PM +0000, Will Deacon wrote:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> > 
> > Pulled, thanks Will.
> 
> Cheers, Joerg. Doug spotted a thinko in one of the patches, so you'll want
> to apply this guy on top:
> 
> https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid

Yes, applied on-top of your pull-request.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
