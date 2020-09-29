Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75AC4727D
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:08:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B936220C09
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUgGRg0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B936220C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C5D485C4A;
	Tue, 29 Sep 2020 06:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvo2jJx8LlXz; Tue, 29 Sep 2020 06:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 027628455D;
	Tue, 29 Sep 2020 06:08:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D94D9C016F;
	Tue, 29 Sep 2020 06:08:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2213C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5942860BE
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mf4IAUNBjk8W for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:08:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 274DC85AB3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:08:01 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id 7so2973437pgm.11
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/P/yp1OEyu3c80ckdO9uP2rdLAyI1tAzR48P50ZSsbs=;
 b=dUgGRg0F2EiJq8j/GyKL53Xz23EA1+tlZEGuIOLEyoyK0Oa4zv5h0k42ekp8k+mJjn
 BrqMixaMhi3j+s8nXSTUiUcP67JR6+3iwPEO2lCIGIAsypGuhC4s8KDHtMV6hD2pogXh
 NPSsqnMZNKaamvYLQLoYBCihXSV4jqvRYz8rsclO8EMqjKONGtcmyWp/zVi0Uw+Iim2x
 pYe0nTIa8nz4IxuvOGg5szLwY4JIfjVfdWIU5eL8qa+SLmcwTD8o/5Qsl/b9l0/iFqsF
 8d1CIKUrsAouOiiLr3fgMYfn/IoPVVVtK5xfYZMGADBcy7r377Ve1IgUGPg22ft5U5oe
 Djlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/P/yp1OEyu3c80ckdO9uP2rdLAyI1tAzR48P50ZSsbs=;
 b=L7wYLakbNS1EWuKJXWI46kuuW9To0TAnt+fRuEKNKtpLdFg4GXBQ/kXz4TrGCyF52+
 qq/3srwliyw2LoKlEKZHFphcAGa/hsM3D8o6t6IF9HJTz+8WXIG2K1LP6AvyWJdaVpAO
 HyHjHjlSMuU8sHlvVjwXJkO4D6mfF/SrSTjgwz6XtLYEDXuwQ6Th9HngQ9rs+6vIGZNH
 0VpWpZjQcUsVVBgbKTtlg2WAYLGORJQH7B9PbETBeIMNDQ4brmMcmTXas+GR5Esm47WV
 vx0OZZFNG4veLU4FD5alqkoCwVWx6HpNUcLh6glbEUL/WJy4pk5aEDr43wsFjmSUE7jI
 EX4Q==
X-Gm-Message-State: AOAM5331liKtXAp5ZsFu7aKtB18hqWSElgoa4Tjt/SVOH658q8FI74Pc
 X7RhKl4dDb3LRURSYgL/69c=
X-Google-Smtp-Source: ABdhPJxKFuyXyknFTFHwvRCgLnO4Ta05aP10J7TScmLJ9+Xxb5PcC5Pm/eXa3mu9/709Qa8qyXh9bA==
X-Received: by 2002:a17:902:d695:b029:d2:89b9:f4a0 with SMTP id
 v21-20020a170902d695b02900d289b9f4a0mr3101170ply.10.1601359680524; 
 Mon, 28 Sep 2020 23:08:00 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i17sm3718854pfa.2.2020.09.28.23.08.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 23:08:00 -0700 (PDT)
Date: Mon, 28 Sep 2020 23:02:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/2] iommu/tegra-smmu: Expend mutex protection range
Message-ID: <20200929060238.GA26785@Asurada-Nvidia>
References: <20200929045247.15596-1-nicoleotsuka@gmail.com>
 <20200929045247.15596-3-nicoleotsuka@gmail.com>
 <20200929060336.GB6564@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929060336.GB6564@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Tue, Sep 29, 2020 at 07:03:36AM +0100, Christoph Hellwig wrote:
> On Mon, Sep 28, 2020 at 09:52:47PM -0700, Nicolin Chen wrote:
> > This is used to protect potential race condition at use_count.
> > since probes of client drivers, calling attach_dev(), may run
> > concurrently.
> 
> Shouldn't this read "expand" instead of "expend"?

Oops...my poor English :)

Fixing....

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
