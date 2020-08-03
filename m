Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C6C433DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 04:14:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5492075B
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 04:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uaKDHMyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5492075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 00C2E87BC8;
	Mon,  3 Aug 2020 04:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q+yHkXWHLr0M; Mon,  3 Aug 2020 04:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3359187BB1;
	Mon,  3 Aug 2020 04:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24A8CC0051;
	Mon,  3 Aug 2020 04:14:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32A19C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 04:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 14662203BA
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 04:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16+dGGscQDUj for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 04:14:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id E76F42035D
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 04:14:42 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id ha11so10670114pjb.1
 for <iommu@lists.linux-foundation.org>; Sun, 02 Aug 2020 21:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=awtrX0rFxmtE7rnp7ijkNRLGiarYo62mFqhE0DOdZ5I=;
 b=uaKDHMyWiMX0s9KBh7EWWkTpxnEJyQezYei5n+WjF28WfxK1cO4tBwsFl99Jf7f39b
 Xo3sQB+PADniybIppU2e2NUHO9LUWfjZTOcQIDSmohzuTy8bPxsgHrUw90K6UpJ4fq9j
 aHIGQ7CarpN0ExykuNzC8TP7AkM/HFDIc3Y1JbksY6vxaxpG1UB1Xz7YYu6LAps2a0zk
 c3jXzpjxzf8/AlYJG2olLsSm+LuoN4aYA4oBghS+vHNR4Dze/1yEJJ7JZ78/fGPzq0Iz
 umnYoX9JfXCZ9faMluAooOPjtAGmE5uOx+sqrQt9znmlH9tZDcaHgnwvg5gVfDKRo7SI
 oW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=awtrX0rFxmtE7rnp7ijkNRLGiarYo62mFqhE0DOdZ5I=;
 b=lyV0dnTkVckAlniyTp8ipDolqaKxN2AF5I3S6N4BpByBXqaASRcECY2R1oG+fw59J9
 tq+epuSw/BNhOUYmC1Q4EjSelgzbCL14SYjxBeAsfO+rANYWgd5gi0KqnrM7QOfbu8sw
 4ZnSQdLsgjKxIqfVDvKOChihA8/p/iF9dsx63+VD2T1PHlnnMx41yrykAFbygEclgTJu
 Ch/yHIZnP6o6dBwEjh7P59HYMHDqJEhxuWUoIl6qS011GdFypVDf0wd6ECUKzahza4gV
 dxF+rPwocyBd/ljFGn+gabL+z0vFzHAoFp9ItwKKNKiEgORh3tUq5ofXb/sQUUc2RNi/
 2/5A==
X-Gm-Message-State: AOAM5312bmT8iBpG3N9D7YaxRWeJJnTciP30W50Mn8QlL8OqBF5HZcrv
 AbMXMkEROvwvHVDaNwXlIfLZbw==
X-Google-Smtp-Source: ABdhPJxsGJSBQ2juzjj+x9QJZh+nnXfq5NVkVZleKhTDtENeCoZsqPPvLeMcTJsUyLzlsc4tNEl13g==
X-Received: by 2002:a17:90a:e508:: with SMTP id
 t8mr15439924pjy.32.1596428082344; 
 Sun, 02 Aug 2020 21:14:42 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667]
 ([2620:15c:17:3:4a0f:cfff:fe51:6667])
 by smtp.gmail.com with ESMTPSA id z19sm18754426pfa.9.2020.08.02.21.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 21:14:41 -0700 (PDT)
Date: Sun, 2 Aug 2020 21:14:41 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Amit Pundir <amit.pundir@linaro.org>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
In-Reply-To: <CAMi1Hd2MLYx_NkXug+Ow7qFn+tzkMFQy_u0iF_-J6amnXZhckA@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2008022109280.483838@chino.kir.corp.google.com>
References: <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
 <20200801085706.GA2991@lst.de>
 <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
 <20200801173952.GA15542@lst.de>
 <CAMi1Hd3wU3pH4dfxcxqKfWmLWxPXD--4hkYC+VQywwQn1mokMg@mail.gmail.com>
 <CAMi1Hd2MLYx_NkXug+Ow7qFn+tzkMFQy_u0iF_-J6amnXZhckA@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 iommu <iommu@lists.linux-foundation.org>, jeremy.linton@arm.com,
 Caleb Connolly <caleb@connolly.tech>, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Sun, 2 Aug 2020, Amit Pundir wrote:

> > > > Hi, I found the problematic memory region. It was a memory
> > > > chunk reserved/removed in the downstream tree but was
> > > > seemingly reserved upstream for different drivers. I failed to
> > > > calculate the length of the total region reserved downstream
> > > > correctly. And there was still a portion of memory left unmarked,
> > > > which I should have marked as reserved in my testing earlier
> > > > today.
> > > >
> > > > Sorry for all the noise and thanks Nicolas, Christoph and David
> > > > for your patience.
> > >
> > > So you'll need to patch the upstream DTS to fix this up?  Do you also
> > > need my two fixes?  What about the Oneplus phones?  Can you send a
> > > mail with a summary of the status?
> >
> > Poco's DTS is not upstreamed yet. I have updated it for this fix
> > and sent out a newer version for review.
> > https://lkml.org/lkml/2020/8/1/184
> >
> > I didn't need to try your two add-on fixes. I'll give them a spin
> > later today.
> 
> Hi Christoph,
> 
> I see no obvious regressions with your twin dma-pool fixes on my
> PocoF1 phone.
> 
> Caleb also confirmed that a similar reserved-memory region fix in his
> One Plus 6 device-tree worked for him too.
> 

Thanks very much for the update, Amit.

Christoph: since we have atomic DMA coherent pools in 5.8 now, recall our 
previous discussions, including Greg KH, regarding backports to stable 
trees (we are interested in 5.4 and 5.6) of this support for the purposes 
of confidential VM users who wish to run their own SEV-enabled guests in 
cloud.

Would you have any objections to backports being offered for this support 
now?  We can prepare them immediately.  Or, if you would prefer we hold 
off for a while, please let me know and we can delay it until you are more 
comfortable.  (For confidential VM users, the ability to run your own 
unmodified stable kernel is a much different security story than a guest 
modified by the cloud provider.)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
