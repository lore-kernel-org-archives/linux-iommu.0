Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78EEC282DD
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE68206DB
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PHyPQo+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE68206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7633F87823;
	Tue,  7 Jan 2020 19:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hE7hVjIQ3S-u; Tue,  7 Jan 2020 19:57:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E20E587812;
	Tue,  7 Jan 2020 19:57:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4368C1796;
	Tue,  7 Jan 2020 19:57:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC1BC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 88FB985516
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mN89m2rktA6N for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 19:57:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 08C4585495
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:57:26 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id q10so382095pfs.6
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jan 2020 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=Yxkh8StDu3vfVeGtFseg/gks40WP5yhSnsk2dLl/57E=;
 b=PHyPQo+yCzPgAyKjg4UI6suHI+/ilkeRBuy3mWhSA7DVXVKUcuiIVjWuDG0hXVodbp
 mcEUZ8yoRDIY3DPtWAuhFQ88QZR7soYmQyLQTqZEszF+yPWu2wMSk1CpA4LR0pAbrVDd
 q4LBK2ljorr++qqoPelhCd8t1EggBBdeX0WFOtKW4VJUvq6lJa/RNpWb1Q+6eNYfCjNr
 T9NWKpNAY1pnkoHSYx9wgQ+JL6d2py3WTMFS5HkJExIw+lWTzuUQDmzDKTyKEcA43Sv9
 oa3NoHBG3bOurQC3DwKeSF7NSDYXgga0LPUAg3n7pfsZ+UJCxf0vDwgnCF7ayUcKrSKK
 GNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=Yxkh8StDu3vfVeGtFseg/gks40WP5yhSnsk2dLl/57E=;
 b=GtDcKH/zfTwaL2zUfLjpVuvgStbGZyDORiz78VCc2t+0Zj2UGZYlaTgAwoF5JMDPFw
 MlwFretjn+sE3zy6U3x24AhddF7iLcO/zG5GUeqfSUbwn3+arVFDV1pfI5sL+4PcVK9g
 zpglnSurFd7qsxEx82Y2v/bAxQ9WAz1jLvmqerIoMECgeAOhRJDCBCOHMmTQgXASw0Tz
 ymFoj7BfnamLiLNlzjGhJEBBfhJ9RQG+KmdKC9u58bdsau+pqxgkLeAzQef2PKu2HZXr
 lU1B5Z7iRzOwBs03LpCWES4plaZ+RBI+WUXB5ZrDozsu4reN0dna5T5jgRoYN183AnN7
 ci8w==
X-Gm-Message-State: APjAAAVk+37ZDqBIu8MAnFmOj6K3EXbavn9wl9JGiXAv52r9/poutp+S
 K1JSUbRZSavEboaaSJvtE/ec1A==
X-Google-Smtp-Source: APXvYqxGdQcWNlWl+zmmQVooo+EnW/Y+CbADoGAw4kD88ujWmMJ3/b6XJYMmHmJAn2JPkQWEtaw04g==
X-Received: by 2002:a65:538b:: with SMTP id x11mr1139153pgq.395.1578427045338; 
 Tue, 07 Jan 2020 11:57:25 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 2sm373729pjh.19.2020.01.07.11.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 11:57:24 -0800 (PST)
Date: Tue, 7 Jan 2020 11:57:24 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
In-Reply-To: <20200107105458.GA3139@lst.de>
Message-ID: <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com> <20200107105458.GA3139@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 7 Jan 2020, Christoph Hellwig wrote:

> > On 01/01/2020 1:54 am, David Rientjes via iommu wrote:
> >> Christoph, Thomas, is something like this (without the diagnosic
> >> information included in this patch) acceptable for these allocations?
> >> Adding expansion support when the pool is half depleted wouldn't be *that*
> >> hard.
> >>
> >> Or are there alternatives we should consider?  Thanks!
> >
> > Are there any platforms which require both non-cacheable remapping *and* 
> > unencrypted remapping for distinct subsets of devices?
> >
> > If not (and I'm assuming there aren't, because otherwise this patch is 
> > incomplete in covering only 2 of the 3 possible combinations), then 
> > couldn't we keep things simpler by just attributing both properties to the 
> > single "atomic pool" on the basis that one or the other will always be a 
> > no-op? In other words, basically just tweaking the existing "!coherent" 
> > tests to "!coherent || force_dma_unencrypted()" and doing 
> > set_dma_unencrypted() unconditionally in atomic_pool_init().
> 
> I think that would make most sense.
> 

I'll rely on Thomas to chime in if this doesn't make sense for the SEV 
usecase.

I think the sizing of the single atomic pool needs to be determined.  Our 
peak usage that we have measured from NVMe is ~1.4MB and atomic_pool is 
currently sized to 256KB by default.  I'm unsure at this time if we need 
to be able to dynamically expand this pool with a kworker.

Maybe when CONFIG_AMD_MEM_ENCRYPT is enabled this atomic pool should be 
sized to 2MB or so and then when it reaches half capacity we schedule some 
background work to dynamically increase it?  That wouldn't be hard unless 
the pool can be rapidly depleted.

Do we want to increase the atomic pool size by default and then do 
background dynamic expansion?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
