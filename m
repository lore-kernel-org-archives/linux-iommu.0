Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B7C3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 10:30:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBE321670
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBE321670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A5F05DBF;
	Fri, 30 Aug 2019 10:30:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 780C25D16
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 10:29:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E4B05E6
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 10:29:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id B382B1D5; Fri, 30 Aug 2019 12:29:39 +0200 (CEST)
Date: Fri, 30 Aug 2019 12:29:39 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Big batch of updates for 5.4
Message-ID: <20190830102939.GA29382@8bytes.org>
References: <20190823145440.2b7ejsnglz2bju5k@willie-the-truck>
	<20190828214229.cuqme6acfqxpgvqk@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190828214229.cuqme6acfqxpgvqk@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com
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

On Wed, Aug 28, 2019 at 10:42:30PM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> On Fri, Aug 23, 2019 at 03:54:40PM +0100, Will Deacon wrote:
> > Please pull these ARM SMMU updates for 5.4. The branch is based on the
> > for-joerg/batched-unmap branch that you pulled into iommu/core already
> > because I didn't want to rebase everything onto -rc3. The pull request
> > was generated against iommu/core.
> 
> Just a gentle nudge on this pull request, since it would be nice to have
> it sit in -next for a bit before the merge window opens.
> 
> Please let me know if you need anything more from me.

It is pulled and pushed out now, thanks Will.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
