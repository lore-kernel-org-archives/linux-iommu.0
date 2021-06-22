Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA6C48BDF
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 22:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0DA6134F
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 22:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0DA6134F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47EF8402B7;
	Tue, 22 Jun 2021 22:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TiF87ovvZCzK; Tue, 22 Jun 2021 22:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B504402B1;
	Tue, 22 Jun 2021 22:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC60C0010;
	Tue, 22 Jun 2021 22:03:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B3DCC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FB37401DF
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALcqm9pCHnDi for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 22:03:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A90D401DE
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 22:03:38 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id 17so637688qtt.6
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=wkAr8aOuO1gqCpd3kuOd4aOsjsXn3orrM4lykm5kRRg=;
 b=k9sbw7UQKZqwqLvfcyT9h2n90eADsv5f+9xzfFVaan7PRpVp15NSetJiykfVkB4JNg
 hvBZppmrT/oYJzeCrcGNo8L02swCm1zQXq4eR7ZmZ4ul+mWpNrmy08v0+2Ub8hnqN1SY
 4vtXbW+8DVS+DpjxxO7tp9VEIrXcKQj1IgRB96zbuK84qj4r4JcWM34vt2+Hn1h6a2Si
 6exmdWvEUmRqbO0RHDCyG10IEHIXx+KaHu4sXisl2WmF5x8m0uoNxkKtDV7OQpIGBrwU
 mpsDQaFp+LKpFkeS7GmgZWQToLTInOKHPvwiet9AwMWyay0OGZ2Rve8APqCHgxyCHLW2
 EvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition;
 bh=wkAr8aOuO1gqCpd3kuOd4aOsjsXn3orrM4lykm5kRRg=;
 b=omZNXgqCYYcCCbqjNjwdxqp2vc+Da+8yGDqrLpia05I+TcuYCUVAmcxXG0g2vzMYOI
 uaV6L1IiVbN11bQ4libEZCGMoqnlxmWg6pSS0woWQIq8R0y7YiCcTo+acTKaEBhovhIw
 h5hU2nVABe61Kz6TqUVN6+zmPSQD28A7qhPHOzUhIfGBCU3dNdSpEmJhdTrxhddsFwaT
 7aWl6twBRgiB1MyCeWeHsIJZm7n7VL6eOys0XXwg4VcEyM4XqtyLLEgJ47HkNsfpgY33
 X2B/RfZBtkcP/h473yiSPJifU1bLo15Ajy1CQLSIPuehj/JOe1YARfoxf6m22UvH4vGl
 qKzA==
X-Gm-Message-State: AOAM530Uidxz0p9NVmw4NktoX57jF9akSbKe4wyxPZenEVhm5pqLtj3A
 uMFgVN/sa6DfnxOouXyMlsA=
X-Google-Smtp-Source: ABdhPJw5wlgNzHs51lnfgoAS8VpgiYGVphCz1eWTvbl4nkSpSbrgoC/PAM2gW85QBDR/QE++QYnu9w==
X-Received: by 2002:ac8:4984:: with SMTP id f4mr909028qtq.106.1624399417307;
 Tue, 22 Jun 2021 15:03:37 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id q14sm565362qtw.24.2021.06.22.15.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 15:03:36 -0700 (PDT)
Date: Tue, 22 Jun 2021 18:03:34 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (stable) stable/for-linus-5.14
Message-ID: <YNJeNrBOwTkCoLmd@fedora>
MIME-Version: 1.0
Content-Disposition: inline
Cc: dominique.martinet@atmark-techno.com, aymen.sghaier@nxp.com,
 herbert@gondor.apana.org.au, marcorr@google.com, lukas@mntmn.com,
 davem@davemloft.net, iommu@lists.linux-foundation.org, pgonda@google.com,
 chanho61.park@samsung.com, hch@lst.de, jxgao@google.com
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

Hey Linus,

Please git pull the following branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.14

which has the regression for the DMA operations where the offset was
ignored and corruptions would appear.

Going forward there will be a cleanups to make the offset and alignment
logic more clearer and better test-cases to help with this.

Bumyong Lee (1):
      swiotlb: manipulate orig_addr when tlb_addr has offset

 kernel/dma/swiotlb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
