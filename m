Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA8C4741F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 11:52:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FF221481
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 11:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmajexn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FF221481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10E5B86A50;
	Thu,  1 Oct 2020 11:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZ9fg9Ro08dW; Thu,  1 Oct 2020 11:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 60DAE869DA;
	Thu,  1 Oct 2020 11:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F814C016F;
	Thu,  1 Oct 2020 11:52:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B38EFC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 97E4B86BA5
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hn7csXtQZdTf for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 11:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 43FB886B84
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 11:52:04 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B43321481;
 Thu,  1 Oct 2020 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601553123;
 bh=jqZ3p8GBPPZmtbp66FihdHwotuZ0yu+zF8O8+xsMAMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pmajexn4JCnBBAQWL8xuneRcIx/PSu52qsXa7Z0uNGEdAMQiokkA7jP6lPMKzMvje
 c30NbFTsZNnCw64BUg2JuD69MzdYVNopBtSpJFYjKPsVUams3H1qmM1uDBgBTOA1E8
 C7Cfk5b7lb2mnB5MqbRXAh3lWzVOPs7xktz1MmK0=
Date: Thu, 1 Oct 2020 12:51:59 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.10
Message-ID: <20201001115158.GA18755@willie-the-truck>
References: <20200930080523.GA15805@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930080523.GA15805@willie-the-truck>
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

On Wed, Sep 30, 2020 at 09:05:23AM +0100, Will Deacon wrote:
> Please pull these arm-smmu updates for 5.10. Summary in the tag, but the
> big thing here is the long-awaited SVM enablement from Jean-Philippe.
> We're not quite done yet, but this pull extends the SMMUv3 driver so that
> we're very close to being able to share page-tables directly with the CPU.
> 
> Other than that, there are a couple of things to note:
> 
>   1. My PGP subkeys expired. I've updated them here:
> 
> 	https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/3E542FD9.asc
> 
>      and I've also mailed an updated copy for inclusion in the pgpkeys
>      repository on kernel.org, but it hasn't landed yet:

Just to say that my updated key has now landed in the pgpkeys repo.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
