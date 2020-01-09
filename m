Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DBAC282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 18:58:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02EC20721
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UakHrUek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02EC20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DDD788393;
	Thu,  9 Jan 2020 18:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUCuAXMnbPeM; Thu,  9 Jan 2020 18:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C583D88391;
	Thu,  9 Jan 2020 18:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B697EC18DC;
	Thu,  9 Jan 2020 18:58:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAADC0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 18:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 23A70214E9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 18:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OebHHk96T-P9 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 18:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by silver.osuosl.org (Postfix) with ESMTPS id 607302038A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 18:58:16 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id g6so2912749plp.6
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jan 2020 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=8miCelK+kNkKyg1qAxJi49qKtsPH/zr98yoCqmNSeCw=;
 b=UakHrUekXPvlhCN2k/yNKWdf6usnysaDd+tYSh6J/VljjRWDx9a59SsyGmX96QhIFj
 OKSesuYx23CaVWYQTi31UZZzrSMkJaFKhlWeuhjwpvu2qv3eUaN9g6OJzd+0f0VyZCHh
 OLNGIXwlAh9IkzClpP2/N7U76W/HoyV6lpOs0Tw58/4/NDZ8Opr0wA0qZSR0Xeyf4gIw
 pwr03WAKyRciGBUPeHx3TAeZ3uC5UQm14YKab/y5VrSmPi8mleFB47ickO5eCoVVLfvi
 Bjzf24VswqWNJ/ih5GdLUGY5fATnjx18Y+Qt2oBpqgrtP4ARyC0LO4uSVoYEv1Be8oqJ
 4rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=8miCelK+kNkKyg1qAxJi49qKtsPH/zr98yoCqmNSeCw=;
 b=NXAZyJMfe18M9KHpw84fDm1qnXOJn7osb4ffMlhl+pVTQIUQZ5tMNyNWMDUiabRAzr
 9GU0vrCpepfWFVebwqOgWu3GM7Fu7DY6XeuJ+XvhuFTkghnDWr1QeSKZuo3XFnHOhJCw
 UB4itG44rpA8Z+RyqKZi47sPjDMJz+chaRFWZT25L/lqsRIaZfnBYodGUkr0DC9NWaZP
 cUL8rZUs1eXnm+u+5c9tFE0CLpqtrTIBfjkksubyyChAfrZgGZzRHWqxBTBALzXzKepL
 gWttXPzuclMlvF2wTloa4ujfckeebYGi8w524nBtT3HTX8ZBLZldUcmw+DzSOZCHnoAX
 hHPg==
X-Gm-Message-State: APjAAAUKiu08JBjDdK0LvlFRoNSmPXtNz0IoWyP2bG3mG/LOoKhX5R1s
 N4y1OGFKPsKljcn4ej5zaZCDBg==
X-Google-Smtp-Source: APXvYqwWn6ivHvumB6Z57+qSecJtCaKEtnrUN0AqGN8qOc5VMfrTeUW9687xwzPRUZBc8kk16zHu6w==
X-Received: by 2002:a17:902:47:: with SMTP id
 65mr13852948pla.130.1578596295719; 
 Thu, 09 Jan 2020 10:58:15 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id b185sm9152254pfa.102.2020.01.09.10.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 10:58:15 -0800 (PST)
Date: Thu, 9 Jan 2020 10:58:14 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
In-Reply-To: <20200109143108.GA22656@lst.de>
Message-ID: <alpine.DEB.2.21.2001091055460.57374@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com> <20200107105458.GA3139@lst.de>
 <alpine.DEB.2.21.2001071152020.183706@chino.kir.corp.google.com>
 <20200109143108.GA22656@lst.de>
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

On Thu, 9 Jan 2020, Christoph Hellwig wrote:

> > I'll rely on Thomas to chime in if this doesn't make sense for the SEV 
> > usecase.
> > 
> > I think the sizing of the single atomic pool needs to be determined.  Our 
> > peak usage that we have measured from NVMe is ~1.4MB and atomic_pool is 
> > currently sized to 256KB by default.  I'm unsure at this time if we need 
> > to be able to dynamically expand this pool with a kworker.
> >
> > Maybe when CONFIG_AMD_MEM_ENCRYPT is enabled this atomic pool should be 
> > sized to 2MB or so and then when it reaches half capacity we schedule some 
> > background work to dynamically increase it?  That wouldn't be hard unless 
> > the pool can be rapidly depleted.
> > 
> 
> Note that a non-coherent architecture with the same workload would need
> the same size.
> 
> > Do we want to increase the atomic pool size by default and then do 
> > background dynamic expansion?
> 
> For now I'd just scale with system memory size.
> 

Thanks Christoph and Robin for the help, we're running some additional 
stress tests to double check that our required amount of memory from this 
pool is accurate.  Once that's done, I'll refresh the patch with th 
suggestions and propose it formally.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
