Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A9C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:50:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FD923C44
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FD923C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 666AE87626;
	Wed,  9 Dec 2020 18:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yC1RwptHQxn4; Wed,  9 Dec 2020 18:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D05C48751E;
	Wed,  9 Dec 2020 18:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB854C0FA7;
	Wed,  9 Dec 2020 18:50:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F6CAC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4A49B87ACE
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RfqbsOyY4Wd for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:50:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0A1EF87A61
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:50:26 +0000 (UTC)
Date: Wed, 9 Dec 2020 18:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607539825;
 bh=SmGD0Wngs0iUrS/PQuc7mTBZo1p0nDrXrdnb6+e6Q8c=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=h514HCk5J29VZl6jAzdiaTmwdyhtAwB4Efnqyjv0E9sWa6jSVwwpeEPdOChE15rDt
 EyFwPWhGW160CrgbIKrD6eZWty4qYvBEIgOgNbweHYTIZyf0wBHumOmMfxShsgtDS+
 QtDnSjmM4+HYYK/sPYDLh+DSXvxU9aWpoNlziEZhgWbO4wpPo2fmYWlpSJ/6V/ItVP
 t7MxYJioTGYWd7Ynq/eA+SW2X7DIJhIuIngVnMWEJ4mB1AdKQUr7BaHrOZskK2bbra
 JUWvs2RVNBrWFfpR5AO7TE5yszlzeF9G7ShZW7zyH14dzX+syRLZrkbsxrcc0IDwDF
 nOd6FHcGNHrWQ==
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
Message-ID: <20201209185020.GC8778@willie-the-truck>
References: <20201209141237.GA8092@willie-the-truck>
 <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Dec 09, 2020 at 10:07:46AM -0800, Linus Torvalds wrote:
> On Wed, Dec 9, 2020 at 6:12 AM Will Deacon <will@kernel.org> wrote:
> >
> > Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
> > for a fix, where the size of the interrupt remapping table was increased
> > but a related constant for the size of the interrupt table was forgotten.
> 
> Pulled.

Thanks.

> However, why didn't this then add some sanity checking for the two
> different #defines to be in sync?
> 
> IOW, something like
> 
>    #define AMD_IOMMU_IRQ_TABLE_SHIFT 9
> 
>    #define MAX_IRQS_PER_TABLE (1 << AMD_IOMMU_IRQ_TABLE_SHIFT)
>    #define DTE_IRQ_TABLE_LEN ((u64)AMD_IOMMU_IRQ_TABLE_SHIFT << 1)
> 
> or whatever. Hmm?

This looks like a worthwhile change to me, but I don't have any hardware
so I've been very reluctant to make even "obvious" driver changes here.

Suravee -- please can you post a patch implementing the above?

> That way this won't happen again, but perhaps equally importantly the
> linkage will be more clear, and there won't be those random constants.
> 
> Naming above is probably garbage - I assume there's some actual
> architectural name for that irq table length field in the DTE?

The one in the spec is even better: "IntTabLen".

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
