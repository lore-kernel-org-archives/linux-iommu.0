Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE79C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 12:40:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6183A223DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6183A223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB8C78702A;
	Mon, 18 Jan 2021 12:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5bTlZ8lOtH95; Mon, 18 Jan 2021 12:40:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7023487013;
	Mon, 18 Jan 2021 12:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64638C088B;
	Mon, 18 Jan 2021 12:40:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6123C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 12:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BF2638701F
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 12:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1dDfEBQGr+o4 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 12:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 40F3E87013
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 12:40:50 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id 6so9023451wri.3
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 04:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pUBLkn8FySf4zUY7MqtXXjbLm3L09Eo0TSDMqMBMKfM=;
 b=s+BO5FOhDlp/nvtnTNCkYC6pw9spNOEnIrmM8K3dL6rIqWMqrHTs4ctKLMPxUWh9bn
 V/XtJhkA7/T7NtgDrwnotnjn6IDm7cM3jHVSatn8EtA2s2bXb+SloN4taNrAVY/gCHKq
 53Imgctex7mIxH2wd4piVk7A9h1ryVXK/B385VKK7GeUPFCaPscNRS0aKmudUQpjzjKu
 QuPWa9k+leDRdYbTtL53a/O74tP8BaOZuCz8s1LKKjCIinLJ9CDexduuXltbfdf8a+Tc
 O3Vys75aAG+nHFnw52+45/6WJqkIiXlTLiyczkt7RSz4QAZ4xuRs5gf0fvtwKJ6pbuMG
 e/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pUBLkn8FySf4zUY7MqtXXjbLm3L09Eo0TSDMqMBMKfM=;
 b=uWRBWLK8PYm/i0p2RW9+QESCohZ4RfFMtzxEgHQG7gIfnkTzzmpr37c5YWTRZxZS8g
 Zh2VCKeEnpAWjS46YR+POkYrjRMCHIMHW2zkyO60SXJszgoYGFUwQQRQ1dObKZ6emPsM
 9aW8j4YuMrZYrPX9+ij2uVHh633fsT9ngXOw5/kYXP62ugu+z5//qAPbpMKyLJ+pVr+d
 q10w6cpCrYr+kP36Sk8G+jIndW0G+PRqY7pSJzXlvClKgvvMjRHK40qSJnt8i68tS07Y
 yFsau7tu+ur757N4tF6dgZsqDe6UmCvUb14v30GitcueWzubIImaCNXBSxd4UqicC53D
 g11Q==
X-Gm-Message-State: AOAM533OmNn5u54OtV/ZRtI67GkqPGI7T33mC9gS5NeMoo9SVKoaAmKE
 25TQgHv6+aBwbR45rmk/6SBxKQ==
X-Google-Smtp-Source: ABdhPJyTQTZCstJ7L8ysfkZ8fDJGZ+Lqupod6BQqyMC/JgHxJ1RmnMf/6HdQOfp86UHm3doCUXOy3Q==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr25320885wrq.47.1610973648680; 
 Mon, 18 Jan 2021 04:40:48 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u5sm9394625wmg.9.2021.01.18.04.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 04:40:48 -0800 (PST)
Date: Mon, 18 Jan 2021 13:40:29 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
Message-ID: <YAWBvVPESMsRvacj@myrica>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
 <YAVeDOiKBEKZ2Tdq@myrica>
 <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
Cc: will@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Mon, Jan 18, 2021 at 10:55:52AM +0000, John Garry wrote:
> On 18/01/2021 10:08, Jean-Philippe Brucker wrote:
> > > > Any idea why that's happening?  This fix seems ok but if we're expecting
> > > > allocation failures for the loaded magazine then we could easily get it
> > > > for cpu_rcaches too, and get a similar abort at runtime.
> > > It's not specifically that we expect them (allocation failures for the
> > > loaded magazine), rather we should make safe against it.
> > > 
> > > So could you be more specific in your concern for the cpu_rcache failure?
> > > cpu_rcache magazine assignment comes from this logic.
> > If this fails:
> > 
> > drivers/iommu/iova.c:847: rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> > 
> > then we'll get an Oops in __iova_rcache_get(). So if we're making the
> > module safer against magazine allocation failure, shouldn't we also
> > protect against cpu_rcaches allocation failure?
> 
> Ah, gotcha. So we have the WARN there, but that's not much use as this would
> still crash, as you say.
> 
> So maybe we can embed the cpu rcaches in iova_domain struct, to avoid the
> separate (failable) cpu rcache allocation.
> 
> Alternatively, we could add NULL checks __iova_rcache_get() et al for this
> allocation failure but that's not preferable as it's fastpath.
> 
> Finally so we could pass back an error code from init_iova_rcache() to its
> only caller, init_iova_domain(); but that has multiple callers and would
> need to be fixed up.
> 
> Not sure which is best or on other options.

I would have initially gone with option 2 which seems the simplest, but I
don't have a setup to measure that overhead

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
