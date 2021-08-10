Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D51C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:35:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655BF60E78
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 655BF60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 303B2606A0;
	Tue, 10 Aug 2021 18:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id seAX5Ex6gPFF; Tue, 10 Aug 2021 18:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 051D3606CB;
	Tue, 10 Aug 2021 18:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3326C001A;
	Tue, 10 Aug 2021 18:35:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45807C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E69B4010E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wt7DzQaG_3Vh for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 18:35:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8310F400C6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:35:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF91760E09;
 Tue, 10 Aug 2021 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628620535;
 bh=Ml4HBc7HBEfIexLPEgG1MMBsjGmO0+Y5qNWSj4KGzcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fkm7yW6lRJB1FQ0aqqeK2ZiM9DHp0v0a+I3UCVNwRGRgumFxs5ZJ41y5ITGoJoYYU
 ORX371bNKwo7fiLCD7okXzruLK1VEsPaRqGsbxyPPE3/Wgx07zl9jrGOgCowLRaOcB
 fG69V3faVO8F0/ckJcWahrUUabRtq+9H9c2G8RwfBRK9scyh3EPKy1jbCl/MwhxsXo
 /iAlwvz8CeBe/H+L8RGbcrQgEfJGaQb2O/RYx5R4QgccUBOef5L4kFjN80dH9VC3py
 GozgiFgdNYptBv0yYqMZCkdLB++GBeT2xSsu/R9ONnnA/wbiN/1pKvVdqKj8nEtyAo
 kvYvruxP76MWQ==
Date: Tue, 10 Aug 2021 19:35:30 +0100
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH RFC 0/8] iommu/arm-smmu-v3: add support for ECMDQ
 register mode
Message-ID: <20210810183529.GC3296@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Jun 26, 2021 at 07:01:22PM +0800, Zhen Lei wrote:
> SMMU v3.3 added a new feature, which is Enhanced Command queue interface
> for reducing contention when submitting Commands to the SMMU, in this
> patch set, ECMDQ is the abbreviation of Enhanced Command Queue.
> 
> When the hardware supports ECMDQ and each core can exclusively use one ECMDQ,
> each core does not need to compete with other cores when using its own ECMDQ.
> This means that each core can insert commands in parallel. If each ECMDQ can
> execute commands in parallel, the overall performance may be better. However,
> our hardware currently does not support multiple ECMDQ execute commands in
> parallel.
> 
> In order to reuse existing code, I originally still call arm_smmu_cmdq_issue_cmdlist()
> to insert commands. Even so, however, there was a performance improvement of nearly 12%
> in strict mode.
> 
> The test environment is the EMU, which simulates the connection of the 200 Gbit/s NIC.
> Number of queues:    passthrough   lazy   strict(ECMDQ)  strict(CMDQ)
>       6                  188        180       162           145        --> 11.7% improvement
>       8                  188        188       184           183        --> 0.55% improvement

Sorry, I don't quite follow the numbers here. Why does the number of queues
affect the classic "CMDQ" mode? We only have one queue there, right?

> In recent days, I implemented a new function without competition with other
> cores to replace arm_smmu_cmdq_issue_cmdlist() when a core can have an ECMDQ.
> I'm guessing it might get better performance results. Because the EMU is too
> slow, it will take a while before the relevant data is available.

I'd certainly prefer to wait until we have something we know is
representative. However, I can take the first four prep patches now if you
respin the second one. At least that's then less for you to carry.

I'd also like review from the Arm side on this (and thank you for adopting
the architecture unlike others seem to have done judging by the patches
floating around).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
