Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB7C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 17:01:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF2E615E3
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 17:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FF2E615E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD1CC60F2B;
	Thu, 21 Oct 2021 17:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u_JMOaLVoTB1; Thu, 21 Oct 2021 17:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A92AD606ED;
	Thu, 21 Oct 2021 17:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF2EC0033;
	Thu, 21 Oct 2021 17:01:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF55DC0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 17:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEB3783C50
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 17:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zWfQqrsP7U8v for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 17:01:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3AD383C4E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 17:01:47 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id f21so867996plb.3
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
 b=kbtKqp869IvvyYrIFZ+BH/Q0al7dwwzh5cM6+zpyBkF7KGxb3RdZG6AjqL12NXrkvj
 i8TwIJqIVmoMIBKGrwILTA3CQO+qDER/xHXw3nm0xh43UVeuwQ5oTRs40LK7OHGWTEpH
 JrpCjJhrhkPbXr4Kp1cbU+RO3L2iBO/XAW84g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ROWLVcA3zbx0a2s7WZ6YTOzMe5htCzY/r3YEXiuLx4o=;
 b=kRGISX/piGGRcUBiS+OUYqxkmPpW8LAB3HBTxYyO8sa+CVcm+isPR4pf676qfsf9C1
 rmaDnQhRLIqmgISAtBMSRr1ipBQhN736EiY7s+z7JZo7w+TsRw0mDVemp/rVUb/ZXI50
 /86ltlKwk4NvwlTJ4SN3sOZvno2MpEYbGsBWrlh1u6ketABOD/IhT4UUc7lFTSH9VEB6
 FmqokEYehTARiaAK3m33qN5VhIIUtHVUs5WHmK2I0IvXAP4Q9HyznUh9xZWTsvjJsx29
 lf3Yk4dMsiz53+oEH34OPJwWbXSp50MMRthsVjxdEONPh2qmFxqFhps2Zx4OI4ar1Jc6
 gHag==
X-Gm-Message-State: AOAM532WPma23mdRqyG6fsicwmjV9oAZ+wulRKFeaLrXxQf3s+KoUzFC
 E3WxSj7X3RhzNM6No5s4GBaLkw==
X-Google-Smtp-Source: ABdhPJxkAyOwGvHc7ivx7LjrapCTdkqnEb6o93YA/TplTcs4cE/vfWTTgvplAtmr9P2ANXp/IgvLCw==
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr8130252pjd.81.1634835707409; 
 Thu, 21 Oct 2021 10:01:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id l29sm5899803pgc.47.2021.10.21.10.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 10:01:46 -0700 (PDT)
Date: Thu, 21 Oct 2021 10:01:45 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] iommu/dma: Use kvcalloc() instead of kvzalloc()
Message-ID: <202110211001.F9F26D90@keescook>
References: <20210928222229.GA280355@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210928222229.GA280355@embeddedor>
Cc: linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 28, 2021 at 05:22:29PM -0500, Gustavo A. R. Silva wrote:
> Use 2-factor argument form kvcalloc() instead of kvzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
