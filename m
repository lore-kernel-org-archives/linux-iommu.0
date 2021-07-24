Return-Path: <SRS0=sT52=MQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674DC4338F
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 00:28:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5665B60EB6
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 00:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5665B60EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D32E41480;
	Sat, 24 Jul 2021 00:28:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q--1xG4ALnj6; Sat, 24 Jul 2021 00:28:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A7EB9406B9;
	Sat, 24 Jul 2021 00:28:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ACB4C001A;
	Sat, 24 Jul 2021 00:28:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B8EC000E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7FD783B63
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wSwvL4SNjSfy for <iommu@lists.linux-foundation.org>;
 Sat, 24 Jul 2021 00:28:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C088683B60
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 00:28:00 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id l24so2851307qtj.4
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yUR9vJJVBZ++4KfjLkcZVAYSvkA3ayEGS4PyGfLalPM=;
 b=fEg7jmTITwuBlSObLCFYUgVdaZDKJo3E9aqB9Xs8g8wePAAwzjlXTfYPChZoE60gPy
 GxArM5zAYk22cjsHQiobsf4uDInsfcVjl6o5Uj7n/h3qAGesmatZS+tPp790DXpEsMCo
 Nw37ZtOfkWZiO+ROkp4UIZv3Yp69+x1iVegf1OsXbwvthf4sq/9icxsp+2UN6hE3ZMin
 YMmX6/Y0B8g+L6g0PSwp1SnwnkNTW41BYPWka4qE7h+0JpF9CzBwnomLzuopBGS0boXg
 EeNTihTE+EgswZv1sREROSkd4cCdE/PkKX4lrZ91gzjsgttwNV/D5Z9wfDsra7CxBEMW
 aMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=yUR9vJJVBZ++4KfjLkcZVAYSvkA3ayEGS4PyGfLalPM=;
 b=o7+sCs33it49cp3mUVRAuTsSVVppT++50v48Os4SR44V/GoP2Qz+WxOSGHScH9qVEi
 GokJgTAv+SsgQ+ECcuv2JSNn9r8W9ZO4Z7cRH4eM07lzxnvLE2yhxZ6fatCMi68QDyZ5
 ppRGcg1gBZFVD9ihjKe34tvdKCe3PVZwiYOKH21/n89njQZeWH2TRK+YaZI3G066vGTL
 EaoWo22Fu2/n+yMXgljHH/4av2o4v8thCjYw6PDQxrAiUQhNdLY9elkGi0ZDQFPSz30W
 GyMmpEzfcH7gKIRW7TRFhMKquwxzcJ0cjCbVQKRIsF5RRLTCP/5EoW9SAgWojmlXSW3w
 pX8g==
X-Gm-Message-State: AOAM531hIs33k7IlD5dbZrDfA2mM2jikCSTrc95XXTv4czpIV6UYmT5M
 Z5PKtQ6vv4uHt148/Y+JnT4=
X-Google-Smtp-Source: ABdhPJwrxhDAQ7ceVK5GvlpstNHsjFggcc2RjjEe4hnZLSCi08MSUUiNXVpC2HZ/36bcBUz5JS1Hhw==
X-Received: by 2002:ac8:584e:: with SMTP id h14mr6051271qth.339.1627086479562; 
 Fri, 23 Jul 2021 17:27:59 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id bl41sm4445922qkb.17.2021.07.23.17.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 17:27:58 -0700 (PDT)
Date: Fri, 23 Jul 2021 20:27:56 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/pv: fix the forcing of the swiotlb
Message-ID: <YPtejB62iu+iNrM+@fedora>
References: <20210723231746.3964989-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210723231746.3964989-1-pasic@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Will Deacon <will@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Sat, Jul 24, 2021 at 01:17:46AM +0200, Halil Pasic wrote:
> Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> before the swiotlb is initialised. Otherwise
> io_tlb_default_mem->force_bounce will not get set to true, and devices
> that use (the default) swiotlb will not bounce despite switolb_force
> having the value of SWIOTLB_FORCE.
> 
> Let us restore swiotlb functionality for PV by fulfilling this new
> requirement.
> 
> This change addresses what turned out to be a fragility in
> commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected
> virtualization"), which ain't exactly broken in its original context,
> but could give us some more headache if people backport the broken
> change and forget this fix.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> Cc: stable@vger.kernel.org #5.3+
> 
> ---

Picked it up and stuck it in linux-next with the other set of patches (Will's fixes).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
