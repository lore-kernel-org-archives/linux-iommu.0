Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F1C432C3
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:47:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32DB2071C
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UKE+8Fub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32DB2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA0C887449;
	Fri, 22 Nov 2019 16:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLokorWElscR; Fri, 22 Nov 2019 16:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39717873AD;
	Fri, 22 Nov 2019 16:47:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 081A0C1D74;
	Fri, 22 Nov 2019 16:47:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F301AC18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E19788832E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKwZ6XZkRHyM for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 16:47:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B92D8831D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 16:47:02 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id r20so8455785qtp.13
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CsTJuTqF11V5Xau/fBV0ClzYOEHSzNeSG3ODcuTcgzk=;
 b=UKE+8FubEUdwrmMGQCVs7KfNO6ELGuJ2MiqMQQsgNPgCqPfL8Eqm4ts5CiivSlPm6l
 i+XKKMSbpfvdnqK5XwSzzmeLbfg8ZrmbE+gre4SdgpKqpBK4LRlD/yx4AxNX+PqR3QQ0
 1p+rotAmyz4ODuC9JejR/68hw/4fgViBJnoLYOr4qawwAM7xmtMawF/Q4u3FXtY5TXUV
 HwMJmtf7CCwgz7NsreHZaL5KRoAxsptgkhz+z843rOD2+PdWZEJXPncrGOx5uImlJoKG
 CvAw1OmybrAx7ugucnGHhC6MVFUn9KerlOieRko5bauQuczjnLAMxCtvsqh+mGUvr/gp
 Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CsTJuTqF11V5Xau/fBV0ClzYOEHSzNeSG3ODcuTcgzk=;
 b=T8V8MrIWC6qhT7sW0QrpUEpAPFOXP5zfGrJATheV9gdyyWz5qCwXeIoPMz6Znj/QLi
 hCMCGNItj4y93hPzgH7m+Vk9y6e40UsJ/J04KNaoEd0BrHaszrrGyQcQptAtJGv/7+nc
 vkX/YyBMgdgINJLsdoPkI0Hj5H8INlS0LbxOh08hBX39D9bVrp6X/MU8zRaQbQthrr+m
 xKjxuc66JVOKzjXbBoyXcUW+6qbTaas4I+YGtNUt6+3tIV/Hk1IGHi47edhUS34GuAsC
 OSZGN9+NtZOUEDCHSmg/Fm5Y5nLyZnupRzdD8gog6biuI6AgVhlpeDSKFeJ0Q4o54WZn
 35Dw==
X-Gm-Message-State: APjAAAW7pvIHdQIAZbBy0p2TSXbEMkmqRshkjD3AHvUawuRRZ9gSDz4d
 JAeNb2vvgXsjRTeO8oGnhWS/JA==
X-Google-Smtp-Source: APXvYqyxFPW/G2Gvt2o7A+CpxDAgcuTE3MRvzKe89NBeOH8qEb9tCk9eMhtu9fq3pEdoVRgg5aKagw==
X-Received: by 2002:ac8:6ec4:: with SMTP id f4mr15463482qtv.271.1574441221147; 
 Fri, 22 Nov 2019 08:47:01 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id q34sm3717314qte.50.2019.11.22.08.46.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 08:47:00 -0800 (PST)
Message-ID: <1574441218.9585.26.camel@lca.pw>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From: Qian Cai <cai@lca.pw>
To: Joe Perches <joe@perches.com>, jroedel@suse.de
Date: Fri, 22 Nov 2019 11:46:58 -0500
In-Reply-To: <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
References: <20191122025510.4319-1-cai@lca.pw>
 <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
 <1574434760.9585.18.camel@lca.pw>
 <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
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

On Fri, 2019-11-22 at 08:28 -0800, Joe Perches wrote:
> On Fri, 2019-11-22 at 09:59 -0500, Qian Cai wrote:
> > On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> > > On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > > > When running heavy memory pressure workloads, this 5+ old system is
> > > > throwing endless warnings below because disk IO is too slow to recover
> > > > from swapping. Since the volume from alloc_iova_fast() could be large,
> > > > once it calls printk(), it will trigger disk IO (writing to the log
> > > > files) and pending softirqs which could cause an infinite loop and make
> > > > no progress for days by the ongoimng memory reclaim. This is the counter
> > > > part for Intel where the AMD part has already been merged. See the
> > > > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > > > pressure"). Since the allocation failure will be reported in
> > > > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > > > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> > > 
> > > []
> > > > v2: use dev_err_ratelimited() and improve the commit messages.
> > > 
> > > []
> > > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > 
> > > []
> > > > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> > > >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> > > >  				   IOVA_PFN(dma_mask), true);
> > > >  	if (unlikely(!iova_pfn)) {
> > > > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > > > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > > > +				    nrpages);
> > > 
> > > Trivia:
> > > 
> > > This should really have a \n termination on the format string
> > > 
> > > 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> > > 
> > > 
> > 
> > Why do you say so? It is right now printing with a newline added anyway.
> > 
> >  hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
> 
> If another process uses pr_cont at the same time,
> it can be interleaved.

I lean towards fixing that in a separate patch if ever needed, as the origin
dev_err() has no "\n" enclosed either.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
