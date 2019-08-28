Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA6C3A5A6
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A112C22DA7
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tle81jQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A112C22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6CA0D341A;
	Wed, 28 Aug 2019 21:42:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 24E4530FE
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 21:42:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E0DE713A
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 21:42:34 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 92B2522DA7;
	Wed, 28 Aug 2019 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567028554;
	bh=0fxkB2EVxb0e89eu1hEQWFByok0LrK47Zl63tENkPsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tle81jQx1V9C8tjd14wI81/u2dGsTxTogu6YbPmMD8UDwkZ0d/8Tx4+w6eRUGEiTO
	kBV9zpVfZk4/fgLXlAjnBzR31ONZF+H5X1WWdXEXjQjHPSArJb9Ghvv0xqi3g8PB2C
	P6/r/zhxaJXyOxT6Gf9NYtJHfiKab6sDV97ENZeg=
Date: Wed, 28 Aug 2019 22:42:30 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: Re: [GIT PULL] iommu/arm-smmu: Big batch of updates for 5.4
Message-ID: <20190828214229.cuqme6acfqxpgvqk@willie-the-truck>
References: <20190823145440.2b7ejsnglz2bju5k@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190823145440.2b7ejsnglz2bju5k@willie-the-truck>
User-Agent: NeoMutt/20170113 (1.7.2)
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

Hi Joerg,

On Fri, Aug 23, 2019 at 03:54:40PM +0100, Will Deacon wrote:
> Please pull these ARM SMMU updates for 5.4. The branch is based on the
> for-joerg/batched-unmap branch that you pulled into iommu/core already
> because I didn't want to rebase everything onto -rc3. The pull request
> was generated against iommu/core.

Just a gentle nudge on this pull request, since it would be nice to have
it sit in -next for a bit before the merge window opens.

Please let me know if you need anything more from me.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
