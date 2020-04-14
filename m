Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E010C2BB85
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 19:23:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AB22078A
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cBSDD4vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AB22078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B927B848F0;
	Tue, 14 Apr 2020 19:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id potxYP7pWpIh; Tue, 14 Apr 2020 19:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02FA984042;
	Tue, 14 Apr 2020 19:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF5B3C1D7D;
	Tue, 14 Apr 2020 19:23:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66570C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4E330816D2
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7gbqq9GriuL for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 19:23:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9996581138
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 19:23:31 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id v23so397077pfm.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=uh/180abQgmQ6BQ7TjempJNClKOaOSf5CJ7rtROtEkE=;
 b=cBSDD4vrRu2upc6r3gqJwDFaQSWjr+17rSaxPc9/xT79CnR00LWsE6Ow6sJurp1BA5
 po/AGG98n8lFdQkAWQi+CDtNlbASVECECHMr16HNxN9EVzyN5lct4/KaV7JhTeAhmfNT
 CKC8vf8rOhffLDtmFRV+XGP/WKpHS7KYBhA2LK/IE5BCOMeA2Ghn6uO2g403g5XEb8Td
 Uve+jkNURH8epjGee6h9MMB6pIfcQF3E87ZvJhDA4xKu1VYlkBUjJCrZpS2hmnejTScy
 1uswIyb9bK+TkRw9Y86yKCQWXYLICDOT4HYWtWHkkmGoZls7DTUZxI1i4bRJFzx8C59w
 fcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=uh/180abQgmQ6BQ7TjempJNClKOaOSf5CJ7rtROtEkE=;
 b=kffq2K/m2JRwgoBlOiyvrk48i3223M2oOXNlJuWTdEd0oZ1M2LgVjjdTzx0yGA35in
 Z1SzahSuBLHAA1pYNR+8wlexK9zrgAoqdctQoO8AC+s/R2+dbkB14Sq+jrJR4MJeoP/a
 rG7X1G6XAwH8blb4Uhmt0uj7yRocWoOXuVFUB/R7Sjk36v2LzyM2i7DVsV+93+DURvVt
 tl5eBnVLvj3LdP64wk7MaFDef3/T6e6XJph728reWXSkJja6L5RrJpxONEJCb0H7fG3h
 PkS2iIdMhzj6RmLNcL/ik3wWhDWMerd66EE9LW82zCYfqv4n0guz3lLiJ/Rp1eELbVZj
 jmwA==
X-Gm-Message-State: AGi0PubekB3HQdgL7Ciz6xHzqxEPQsaMnTi7HB0yWi68P/WVkLBTyAFA
 FUODSxhKLufi0Y/w1fdbphr0Bw==
X-Google-Smtp-Source: APiQypIh8dv6EhpHtZfx/oK6c8hvmtzPrPegZc68gIU5zluDsBPHkcGRRKdcXzhMGJ8v56855PjPYw==
X-Received: by 2002:a63:ca41:: with SMTP id o1mr24177997pgi.419.1586892210952; 
 Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 3sm1147978pgh.75.2020.04.14.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Date: Tue, 14 Apr 2020 12:23:29 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <20200414064441.GC23359@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004141222260.2583@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
 <20200410145520.17864-1-hdanton@sina.com>
 <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
 <20200414064441.GC23359@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Hillf Danton <hdanton@sina.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 linux <linux-kernel@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>
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

On Tue, 14 Apr 2020, Christoph Hellwig wrote:

> > I'll rely on Christoph to determine whether it makes sense to add some 
> > periodic scavening of the atomic pools, whether that's needed for this to 
> > be merged, or wheter we should enforce some maximum pool size.
> 
> I don't really see the point.  In fact the only part of the series
> I feel uneasy about is the growing of the pools, because it already
> adds a fair amount of complexity that we might not need for simple
> things, but shrinking really doesn't make any sense.  So I'm tempted
> to not ever support shrinking, and even make growing optional code under
> a new config variable.  We'll also need a way to query the current size
> through e.g. a debugfs file.
> 

New debugfs file sounds good, I'll add it.  If we want to disable dynamic 
expansion when the pool is depleted under a new config option, let me 
know.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
