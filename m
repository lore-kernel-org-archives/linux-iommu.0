Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F6BC4742A
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD65214D8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjEwovmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD65214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 29BE0203E0;
	Mon, 28 Sep 2020 16:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DIxmxxfrGpeI; Mon, 28 Sep 2020 16:47:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6307220130;
	Mon, 28 Sep 2020 16:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53307C016F;
	Mon, 28 Sep 2020 16:47:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD95DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 16:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B300786FC9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 16:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-SkBoqrHv8E for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 16:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02A3C86FAC
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 16:47:51 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id x14so2076960wrl.12
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+/wfCzHsTNUdsB/Cn52MFlbO1GfXEKz6coRCEhiu6Ww=;
 b=gjEwovmqn37JiQPL1XzykM04wRj2kiGYYgWpaqqQiRU3rcIKQgAxs1WJz/nixOHI53
 +yCjyfBmLej3IqifRpu8vyYl4d1UIqCTIaiB7dDP0lb/ZunnytH2EUrQelCNW3kdXs0k
 HI3sTSXBu0Q4TxBWZTEoik8IEVL4XYMu3WgGdt8wj6mKSOSWBlOXap5jTK7kr+P+NGYS
 WDDaVy2D26zxQPUNaZELtq4zZbJg75c0DDaUMrjXFfGvCcLrQ0C3yqGNgAzGSbC6ET3h
 rI39GX73pev3CaKhTweHneHtiSOisJ0k3sbxPpLWTk5a2eukGMk64IvQKNB2uL9iB8FG
 HK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+/wfCzHsTNUdsB/Cn52MFlbO1GfXEKz6coRCEhiu6Ww=;
 b=HI5TuxTKT0osQG4fyL4Bg40pLl92ktzwAwz18v4BqKAJJGnlAu2d8Ft5fancXeophn
 ly5LerinlcHjlZpTM9AaTdoCQkODjubm2BvYmiBY1NIK6WGJRXAsHyQYsZUGxZwSd0U0
 sHbPEFR1lmYsC/x2Lcvd5dr9rjARJGA6CASBkmzO5X+UGZnGcefBCG2VYbR7k0re5bJy
 jqBXXFJjlCzEo4XJK8Sxd0VZHoy1cKW3JZy7jgxF1DfcmiqJPeH66wpGi/Frmaa5lDQk
 Dwvo1UwJo7PPFHbz/5NIG/UqsFwWky4Fnt8eeBByDYBrVdUdFR0tyEjksO4mTjf9qA29
 MkIg==
X-Gm-Message-State: AOAM530IRxeaTBXgynZAAWvgFhJw6pswU9aLt4ZvQtA8JrPEfLEffYL5
 2SGZPQ7PqtXBjYerrQnIWwvP3g==
X-Google-Smtp-Source: ABdhPJxmN2NAMhfO1j3PeXTGNuRNn7IRTty7b3bcOgQJ4bJvURoOshcj/9js9la4JzEHwpZzGvyZyg==
X-Received: by 2002:adf:f707:: with SMTP id r7mr2677561wrp.413.1601311670348; 
 Mon, 28 Sep 2020 09:47:50 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b8sm1919374wmb.4.2020.09.28.09.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 09:47:49 -0700 (PDT)
Date: Mon, 28 Sep 2020 18:47:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org
Subject: Re: [PATCH v10 00/13] iommu: Shared Virtual Addressing for SMMUv3
 (PT sharing part)
Message-ID: <20200928164731.GB1459218@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
Cc: fenghua.yu@intel.com, linux-mm@kvack.org, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Will,

On Fri, Sep 18, 2020 at 12:18:40PM +0200, Jean-Philippe Brucker wrote:
> This is version 10 of the page table sharing support for Arm SMMUv3.
> Patch 1 still needs an Ack from mm maintainers. However patches 4-11 do
> not depend on it, and could get merged for v5.10 regardless.

Are you OK with taking patches 4-11 for v5.10?

The rest depends on patch 1 which hasn't been acked yet. It's
uncontroversial and I'm sure it will eventually make it. In case it
doesn't, we'll keep track of mm->pasid within the IOMMU subsystem instead.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
