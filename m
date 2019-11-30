Return-Path: <SRS0=OkX6=ZW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1DC432C0
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 06:03:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5AE2082E
	for <iommu@archiver.kernel.org>; Sat, 30 Nov 2019 06:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itp6mkD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5AE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 433E52046A;
	Sat, 30 Nov 2019 06:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLPCMYMWh9Ik; Sat, 30 Nov 2019 06:03:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 78E852041A;
	Sat, 30 Nov 2019 06:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E6DFC1DD9;
	Sat, 30 Nov 2019 06:03:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1AA2C0881
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C5A4D85F43
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21ypIm6ezbCk for <iommu@lists.linux-foundation.org>;
 Sat, 30 Nov 2019 06:03:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3923E85EC0
 for <iommu@lists.linux-foundation.org>; Sat, 30 Nov 2019 06:03:57 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id w8so14301335pjh.11
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 22:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ec0nFTYvaYnyk/8sDq3u071ZfoJJIOH3vX8mQ8EjYTU=;
 b=itp6mkD1SRHUUM3dzkGUrTGZzeeghUrRVdwLIS+sv8ByFdjtSolJb+2ptNl3ZpxOaa
 qQ9F5atiSWznAvMIl3Hw3JceCA1xSO1eu6s403schCBBQ0CT5cNxiDdUmnQDgTFGWUVs
 M578TrlCLWiNC5vIDgGZ/1cG6hw02MAiNfAufnYJIO556KE5x4xNLf14iyBNqlB5wNF7
 PgGRDhnPLaWul1v9YnWxVL7RuflGc3f1raBaQZjRScfzFGB5GnlbFjJYLNpf2ZrNdx2l
 +2fJgWEXIjPDkLB151Y3BMALbCdyeqfadyCZXQ/UdJe8ShKGjCdOyyucDqwtFFkIgx2C
 fx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ec0nFTYvaYnyk/8sDq3u071ZfoJJIOH3vX8mQ8EjYTU=;
 b=Y96PJHc6JPmpp0FVSA6oOmlkukiUUktShiAPhpIZjuDChRCLjmyNijPuQBGJfsvdn4
 r7xL41B7lhsZl0FNjv+7UHUUCwuC0/Fo7MNzD2kL3oesCJ4mS3B7bv4zlbPNfeiIjlUM
 /Wwcu/d19S3UAcB3isawwdHnj8QqOoZ7OB48RDIghCcrXvrekc/0ER8oIGn60VbAQTez
 fsXROabgPD2A8NgyJLRQKhc+6cMOimrLbKUjdMJ8ZOS8biMWSdAjx9jXWcAZpR0j82aa
 F6Mz8IuazcsFZBX6O1aOCl83MaAUiG6epirtK2eN72i8YL0Ip4aVkqphyKC7V+bffrDH
 QS4w==
X-Gm-Message-State: APjAAAWlgb7sLasuNjbdYpgoEUtebjylNvXxdo1evz6uamiV13HSQqIx
 B7FHD9D1cyxSxbXfQQ/qppfJ9QFEZkuNNCD84h0=
X-Google-Smtp-Source: APXvYqx2nNvpp3u1ft6zY2DBl10NREssYrBkm84da2QSyHGCXrj7U45ZHl6Wj4R2eUiIL9Vykmwj2WerfPtLQkzMYao=
X-Received: by 2002:a17:902:9a03:: with SMTP id
 v3mr17750785plp.61.1575093836764; 
 Fri, 29 Nov 2019 22:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-4-xiyou.wangcong@gmail.com>
 <dea0de02-cedc-7817-5b04-3888e0e86812@huawei.com>
In-Reply-To: <dea0de02-cedc-7817-5b04-3888e0e86812@huawei.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 29 Nov 2019 22:03:45 -0800
Message-ID: <CAM_iQpXznBnh+bVMu4Ad-doPfr7en9CnWiG8C8mEXmYu6yTgxg@mail.gmail.com>
Subject: Re: [Patch v2 3/3] iommu: avoid taking iova_rbtree_lock twice
To: John Garry <john.garry@huawei.com>
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

On Fri, Nov 29, 2019 at 5:34 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > Both find_iova() and __free_iova() take iova_rbtree_lock,
> > there is no reason to take and release it twice inside
> > free_iova().
> >
> > Fold them into the critical section by calling the unlock
> > versions instead.
>
> Since generally the iova would be non-NULL, this seems a reasonable
> change (which could be mentioned in the commit log)

I think it is too obvious to mention it. There are many things we can
mention but we should only mention what's necessary, right?

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
