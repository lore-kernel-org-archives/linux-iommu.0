Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101EC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 18:02:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D826F610CD
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D826F610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C1C860B4B;
	Fri, 18 Jun 2021 18:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5V6vVGXoSHYI; Fri, 18 Jun 2021 18:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B43A60B47;
	Fri, 18 Jun 2021 18:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5C5C000D;
	Fri, 18 Jun 2021 18:02:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12404C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A872840283
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YR92UmY1WG5z for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 18:02:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF74D40519
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 18:02:13 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so10485597oth.9
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gm6MYYB9NnNxdkRuQyLBTfy2a1l9+kymVbo6dLCaxp8=;
 b=IX/TeFICHe0M9eY2FgHiWrn+tdb/q5XFgD8uXsgjTWA8ccYLhwkhmj5LVksZqDuyP/
 WO98d4+EqUEGVeNVRkwGXvDR2KFUUsjHgWYsSZNspeMbY0pyo5tCDjX5g3a0S5zJVn5J
 VVQVThsNKNWwgywn+UIOieUM+TDA8ZHnfFAZ0UJx9g4jXc4QSs4THTGKFETKMbtCQOhC
 oohAmV/ouLnwljoWkk30lA1Ew7AeSHyL7YWAUXHRppPW6exwVxxl6v4oWTx8GoKtepVU
 0FuNut9qWjAnX/+VsjdAfRTl/lf12Qwyt/IudALVfQNQswOIeBJ2fnVR25hgKkqCacht
 +gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gm6MYYB9NnNxdkRuQyLBTfy2a1l9+kymVbo6dLCaxp8=;
 b=lSETeCFWJ8Ti6hKES6aGFKMCG7NViMMQupX1JXsqwkZi93lpDjQcTqsQFF6BIcW2Fx
 GjKNMr0DcdBI3rx2h2Fff4rL+FaA38VSfUSkn+5lGf3p5h27Vsc8bZirvdDKBroT0nYD
 XFZkM9LFpD5towW2LTRxwLETF9DPmszrd8uPBl5LmjlkA+HtwSkLdotP2CmXiaIY0buR
 ALNyvt1Qaz6hZ/oKZkHPsTYhfPeQSJgumwAc+9LbJaB1RDfSLdGNxdwWVGt7QwSJspKB
 JTjsOKszBC0FR6L/tOFlSpjldERBtg0Q/V3IRRDiwnVkmyh1n8mv8kih40crzbiMFjBi
 L73g==
X-Gm-Message-State: AOAM532Y4NOvoJO4wlF0SfbrsCZvsEaaJki9f8LXO61RLDnvdFDEacv8
 brYNhOeppupoZtDJJSSclfWXfbVK0ulFUUraNcwxWw==
X-Google-Smtp-Source: ABdhPJzDjg2IGcepCwb5aVYpL0iyoVlRw7VwKmnVSWke5phSkT/PVMVrc8WMy+XMkfj6Q5UajD7a40VUOZZuPPBY+Tc=
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr10406630otl.8.1624039332635; 
 Fri, 18 Jun 2021 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de> <YMrfWBLsJxCRhX5U@atmark-techno.com>
In-Reply-To: <YMrfWBLsJxCRhX5U@atmark-techno.com>
Date: Fri, 18 Jun 2021 11:01:59 -0700
Message-ID: <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Jianxiong Gao, before spending more time on this, could you also try
> Chanho Park's patch?
> https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f
>
I have tested Chanho Parks's patch and it works for us.
The NVMe driver performs correctly with the patch.

I have teste the patch on 06af8679449d

-- 
Jianxiong Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
