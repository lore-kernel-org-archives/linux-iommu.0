Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE3C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 16:20:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF2161108
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 16:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BF2161108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF61A61BA8;
	Fri, 17 Sep 2021 16:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-7VqKQZE_As; Fri, 17 Sep 2021 16:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7F5A61B9C;
	Fri, 17 Sep 2021 16:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77FE6C0011;
	Fri, 17 Sep 2021 16:20:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54FBDC000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 352B7415DB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0gTIQ31u8Zc0 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 16:20:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74F0740670
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:20:03 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id p29so34287076lfa.11
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S+26Vsol/pLE3N2ZCeBR7S3rv3GmRM47x0Lj5a/+Z+4=;
 b=ZOrBVNAXGkcl3SRetFlgOpBW8k57TEz1htELHRMsY3cQ4RgsIlPi57MdJP4t8Bpliw
 qOFJAjljj8r3mmZf0xIyJ3eXTd8lf6Kkp5SQrpaKeABXfjdaX3xwJvEGmeTJdXVedy6A
 9RjIw/HW+4xZ2xVsHaC7TnLhx9T3X3VhIgKmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S+26Vsol/pLE3N2ZCeBR7S3rv3GmRM47x0Lj5a/+Z+4=;
 b=24tGsCBiKXwwOCM/1LPgMAR4FA1cKdU6CV2uHfc93YiazIJ6/bKlpyCNo1Gd7+7s/d
 F5s9Ku2j0YScNwXdaQGfzBpYC7XlWBDiisTzwiGFqDDz8YWVOU08cqQaoyc5dR1YF7L4
 /nh9uAoLojzLK60yqjnAcWgJ0Z6PcZ0nuGPH+ULEypadW0wRRxm+inEgAJvlffa1OqQd
 C/Nb5slmWkenDBd20gQ6dR4J9Pj0yeTfbdChX7Yaetht3JSZMK6eRffYKV6yCTH5DYTP
 Au2GOIz4/JTlts8mPzDMkWYSxOD80pD2oqZywgrRVsKNByLBVsSGA1g+idQz9ttRl35V
 dYKA==
X-Gm-Message-State: AOAM530GqBELi7SPiedtq2a0G3tuBtxYu7Tet2MEMKr/91sp5ME8mp6y
 Xgb6+JyvmVRtpCpBrvnJkr/So1wRU0aaLZoxrY9G+w==
X-Google-Smtp-Source: ABdhPJyjlCyJL60KXoXpEhKp9Ci3Q1DlxIiZkLGrHRL0gbCjjWe8CZUpibMfCFyrfP7IMOyN5s4AKg==
X-Received: by 2002:ac2:4896:: with SMTP id x22mr8970238lfc.257.1631895600843; 
 Fri, 17 Sep 2021 09:20:00 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id d19sm558516lfv.74.2021.09.17.09.20.00
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Sep 2021 09:20:00 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m3so32885145lfu.2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 09:20:00 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr10019984ljg.31.1631895599183; 
 Fri, 17 Sep 2021 09:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <YUR6gpm+mTWqdil6@infradead.org>
In-Reply-To: <YUR6gpm+mTWqdil6@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Sep 2021 09:19:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihcFU1mq1ksH9k2pTTziopDWm16nra0Ofw7aORGphJaA@mail.gmail.com>
Message-ID: <CAHk-=wihcFU1mq1ksH9k2pTTziopDWm16nra0Ofw7aORGphJaA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.15
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 17, 2021 at 4:23 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> nvme fixes for Linux 5.15

This presumably went to the wrong person for the same reason the
subject line was bogus.

I got these fixes through Jens, if you had an _actual_ dma-mapping
branch you wanted me to pull, you did the wrong pull request.

Please send that proper one instead.

Or, if it was just this nvme thing, it's all sorted out already.

          Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
