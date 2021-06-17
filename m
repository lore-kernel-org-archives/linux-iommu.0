Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A4C48BE8
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 00:39:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6EE613CB
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 00:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6EE613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91E2A415F0;
	Thu, 17 Jun 2021 00:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Z-_xQpYVnwg; Thu, 17 Jun 2021 00:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 537A0415EE;
	Thu, 17 Jun 2021 00:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D3AEC000E;
	Thu, 17 Jun 2021 00:39:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34710C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A0C7415EE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZiK8bHS36Qg for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 00:39:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3804415EB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 00:39:30 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by gw.atmark-techno.com (Postfix) with ESMTPS id 5BEA58045F
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 09:39:29 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id
 w10-20020aa7954a0000b02902eac51f8aa5so2601202pfq.20
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kzwC23yl7EiPEJTyDQAXknKKdn4AQMgQSpCxCXmT79o=;
 b=aeXOAKWFoqLdq3VoBHKKCEIO92NggRoI1q3nOYmRy770mOZ3/uApZdB7G2uKCDs35n
 08LtSBhPHPdBbBXk+86mUmEjdX22miKXL8qHdMXTKDjgaqmLKfYTKp/b5wm3SmzDgwaK
 ndxkdARILi8Pw5MeiRYoounBHFyzdtPFqUTu2xUnU0CC7W12unsg6qdhMtokPtRQ+Uup
 A4BQh0MvP68nTN8yuY1ok22tEymDA++W5ehTp22JFPQ32lcuPTyJ5YU4zYwxm7dyvBhG
 eL31rOJ9OZG8MCKKowdbuKIiEc398Fo6bT457B9vJSJgpZowS+9cKeH8d0pWBtpsOtZK
 mYjQ==
X-Gm-Message-State: AOAM531k2BBehOPcM3Inz5Z54L5Luu+A2IGeXSOtku3EBdKsPMXtUzjY
 wprk7qLt8Yg/++SQtfW0hsuxfk7PZcXb44zcp/f85akN8kZ2j5jTgfKY+xO+TM2k83ttqOdZLNw
 FeMxtvJsT5XEms2FfGx6ehM27dXnddEdHHA==
X-Received: by 2002:a17:902:bb90:b029:11a:cf7c:997c with SMTP id
 m16-20020a170902bb90b029011acf7c997cmr2127481pls.80.1623890368374; 
 Wed, 16 Jun 2021 17:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS51UkDeEgbZVQN8Wk1n9noziQk43W9FAfw9kVNO3t3j63+6pTaR8t/Y11gTIfZgQLKda96A==
X-Received: by 2002:a17:902:bb90:b029:11a:cf7c:997c with SMTP id
 m16-20020a170902bb90b029011acf7c997cmr2127467pls.80.1623890368156; 
 Wed, 16 Jun 2021 17:39:28 -0700 (PDT)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com.
 [104.198.112.35])
 by smtp.gmail.com with ESMTPSA id mg22sm3149090pjb.26.2021.06.16.17.39.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jun 2021 17:39:27 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1ltg45-00FKxj-UT; Thu, 17 Jun 2021 09:39:25 +0900
Date: Thu, 17 Jun 2021 09:39:15 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YMqZswFnSNKk4Z7B@atmark-techno.com>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de> <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMqW+/gQvM+uWUTw@fedora>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Peter Gonda <pgonda@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Jianxiong Gao <jxgao@google.com>
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

Konrad Rzeszutek Wilk wrote on Wed, Jun 16, 2021 at 08:27:39PM -0400:
> Thank you for testing that - and this is a bummer indeed.

Hm, actually not that surprising if it was working without the offset
adjustments and doing non-aligned mappings -- perhaps the nvme code just
needs to round the offsets down instead of expecting swiotlb to do it?

Note I didn't look at that part of the code at all, so I might be
stating the obvious in a way that's difficult to adjust...


> Dominique, Horia,
> 
> Are those crypto devices somehow easily available to test out the
> patches?

The one I have is included in the iMX8MP and iMX8MQ socs, the later is
included in the mnt reform and librem 5 and both have evaluation
toolkits but I wouldn't quite say they are easy to get...

I'm happy to test different patch variants if Horia doesn't beat me to
it though, it's not as practical as having the device but don't hesitate
to ask if I can run with extra debugs or something.

-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
