Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD49FC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:05:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752D1233E2
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 12:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752D1233E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DCBA86CF4;
	Mon,  7 Dec 2020 12:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3YfgbOeGzOY; Mon,  7 Dec 2020 12:05:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B46D686CD2;
	Mon,  7 Dec 2020 12:05:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE05C0FA7;
	Mon,  7 Dec 2020 12:05:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E795C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 74CB087254
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQig5DfJQZaE for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 12:05:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ECE1D8710D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 12:05:33 +0000 (UTC)
Date: Mon, 7 Dec 2020 12:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607342733;
 bh=xYecpIocncYbomw151SJIMvBkPsNpdC8hHd472+icVw=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=m6pwNfChCGfEwJgZDaxOPHG38w9DWpq6iTj5WODngrXSZTnR/zZIR1ybJwAKOK96O
 eNVCDCdxh/MFbRkVEtl9g9AuV33pDZpktiuIyX5Us/43J7fpbreJ1InBv01aRopTjJ
 3c2mkN/qfPCqvrReEg4ZOB5vuhhP3EqknFaAkDQ21GTgGAzyQ93a5Fn+TD3uXsjSuu
 wpqNSqiDXWJb3l6nFlgGE1wpC9SlObbPJnBPfu5uNyKrMZw6hYKX1RN6DZ3nyr6fcZ
 uCZo08hhXvMqfzBV4JbKxQpO7GX0/2TBjDGrdG9X/GfDn5jV11ugt4hUQie1cQurUt
 AfkL/90K4KKkg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
Message-ID: <20201207120527.GA4474@willie-the-truck>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 jiangkunkun@huawei.com, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 Mark Brown <broonie@kernel.org>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com,
 Thomas Gleixner <tglx@linutronix.de>, Keqian Zhu <zhukeqian1@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
> On 2020-12-05 08:29, Keqian Zhu wrote:
> > ... then we have more chance to detect wrong code logic.
> 
> I don't follow that justification - it's still the same check with the same
> outcome, so how does moving it have any effect on the chance to detect
> errors?
> 
> AFAICS the only difference it would make is to make some errors *less*
> obvious - if a sufficiently broken caller passes an empty prot value
> alongside an invalid size or already-mapped address, this will now quietly
> hide the warnings from the more serious condition(s).
> 
> Yes, it will bail out a bit faster in the specific case where the prot value
> is the only thing wrong, but since when do we optimise for fundamentally
> incorrect API usage?

I thought it was the other way round -- doesn't this patch move the "empty
prot" check later, so we have a chance to check the size and addresses
first?

Will

> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index a7a9bc08dcd1..8ade72adab31 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
> >   	arm_lpae_iopte prot;
> >   	long iaext = (s64)iova >> cfg->ias;
> > -	/* If no access, then nothing to do */
> > -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > -		return 0;
> > -
> >   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
> >   		return -EINVAL;
> > @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
> >   	if (WARN_ON(iaext || paddr >> cfg->oas))
> >   		return -ERANGE;
> > +	/* If no access, then nothing to do */
> > +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > +		return 0;
> > +
> >   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> >   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
> >   	/*
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
