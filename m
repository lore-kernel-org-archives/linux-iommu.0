Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D83C432C3
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:24:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAC620640
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7MRCPKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAC620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 478E587994;
	Tue,  3 Dec 2019 19:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ojsYAh3Q5oy2; Tue,  3 Dec 2019 19:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADFCB878D1;
	Tue,  3 Dec 2019 19:24:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE1CC1799;
	Tue,  3 Dec 2019 19:24:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55B9FC087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5169C86948
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmP--VPbi9_T for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 19:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E8576864EA
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:24:19 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id i5so2086994pgj.9
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=btOlldos8WFYdKaeewOwOdI3rq74DAS7pkARWxi9A5s=;
 b=k7MRCPKuhValFSnpnJFhr3qxrS4tnqIqWHOQ5RBtDLudcXFqWXGOA2FJn5qJkXA2+3
 YOsUwf2rpDBAa9QfQbKOs6+Zi8Vp5aNKF0mNFFJHgL77UWWR0iiB+6qbq+ybFcfarbWi
 eZwLXaberoiLcpOtSjXLjeZEOViITcAa8P7g9BXU0H6zyvRCcfp/jyvjvEdKjkBLvuA+
 qTvZN5A4jhNYXPs0DJxSo8Zcf/62EC2E36907QRQ72X4t2bLJFWFKtJXqbkLnLMnnIiV
 uMHsc6uJMxltaY7+e4zHUDI0U6yszNzkhNl2Fssa3Q1E2eX6zxxrwYxVw3+lNN5Mri5U
 8REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=btOlldos8WFYdKaeewOwOdI3rq74DAS7pkARWxi9A5s=;
 b=TqQwcyn2WuqrA8ZR9OxMaxW7oOVrIto2ds3vVcyhla7lQGIFvBp2v38oNiYaoFtAlz
 zzvkyCCMRtisMd8m27frlt0/MFtYSWAavB5/ADEkeslT87TY44icd7WUrXL5GAP3wL+q
 yaPKD6Q2mSYkTthFtUYd7pslHB9YFhhHFkeuX3yjFBEnh18gvlbEfInHNTe6zBowaDrc
 sZ+ib0yjaAGlbUehHZeqeU1EYnatSpTwqEeArXkjls7QPluZXyZNTTTAde40Mmy4jv1I
 J8jytVeVd/8FZyRmlh291Y2SrvU+Y4eSDVe/ROvKofgHVDHbKqiZOgTrtDiaKAKhRNK0
 /vHg==
X-Gm-Message-State: APjAAAWjxYURjy0tWIeqJGsWeVkrQrTZ9mHbFvEtytoBOIagVJ8RkfQp
 /eqxhjDQPeaI62EhuogaS0o5Hx2KxBwq+eSm7fI=
X-Google-Smtp-Source: APXvYqwwZ2d7i2kNu+/p5vwWPP71Po5t2EgQq5w9abaP14dGPYXXOmoABPJJNdR17gRnOO5ObNzkP+sOadAT6LHnKB0=
X-Received: by 2002:a62:d415:: with SMTP id a21mr6405803pfh.242.1575401059282; 
 Tue, 03 Dec 2019 11:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
 <20191202165847.GA30032@infradead.org>
In-Reply-To: <20191202165847.GA30032@infradead.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 3 Dec 2019 11:24:08 -0800
Message-ID: <CAM_iQpUy2t5zUBpyrMV8rSgVpeKSqheGG_yNOF15dKxBcRiFwg@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On Mon, Dec 2, 2019 at 8:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> I think a subject line better describes what you change, no that
> it matches an original algorithm.  The fact that the fix matches
> the original algorithm can go somewhere towards the commit log,
> preferably with a reference to the actual paper.

Ok, I will change subject to "iommu: avoid unnecessary magazine allocations".

And I will put the title of the paper in the commit log even though
it is already in the code comment.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
