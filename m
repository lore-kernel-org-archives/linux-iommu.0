Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB5C2D0C3
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 04:33:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9E621582
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 04:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwsxUf3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9E621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3EAF722846;
	Wed, 18 Dec 2019 04:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51MfhjVX4RTz; Wed, 18 Dec 2019 04:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B8D532050C;
	Wed, 18 Dec 2019 04:33:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACA7AC1797;
	Wed, 18 Dec 2019 04:33:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15E46C077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E77922283A
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhZdUhwP9Xqb for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 04:33:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by silver.osuosl.org (Postfix) with ESMTPS id 19A1A2050C
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 04:33:01 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id s94so744467pjc.1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RhWhhJRvas1fX646WnNBdCig25ysHcJ+tN6mdIOPt0s=;
 b=OwsxUf3j+WHDhf/lx/mcXYPECFgQNqJTOKGWSgjWY92F0l4lmrMfeClfU/8Moo+7rT
 BluGEDiqFgK5LbhLtSryyUErnSCuycEbGYFTT20x70BzHYbf41GRWCSRTprG7Lrso8PW
 wS49W4quNIgP1iHyjsN3NaaH6W/ZMcwTLXVEgRPMN4dBkHwn9sgrLAmjmuee0kPAt600
 uAKLwFSzfNoOAk5Da4IjRM2D6oFapj8EzSxX0+KcnWfhRvMWJh3/+y5Szc9H90OGaZPW
 kE2WN29zBE/5mFMuKeVbGj3NfDHBjZivrNj0g/FY4COFvtXC/r4UqsEZGsR8kb+cPDBp
 yWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RhWhhJRvas1fX646WnNBdCig25ysHcJ+tN6mdIOPt0s=;
 b=daojv1F60PoGoFwe2QL5cFPGaG/9+3oIOSXOQYhpFQj/tWX21uQFFkowE58OeeKWIZ
 8CUmWb9WZXFaeSgwd0ohRpkc/qzM/JROH77v87zp/M00bb0aGxXX7x6H4rJXhiBpxZ9/
 gaBlLUM238R+7+lO6HqPOxzy4QkWle4Ug7UDGWTcanUYJ3KgsulN4L/M7Ep+VOcdrt9e
 RM1ZF5toe6vt47AR8TdBz1dyY80gdTLygLrH8rKKHPbTmdo/pPY4yUiH85mQgTxhFKPF
 W1JJKlJrzpYi+tZ7/C1aUhqoZ2c5t5QbjypuphwaKn4wkyUlpUjLYsUgxW4gxV8tiAVq
 yKKg==
X-Gm-Message-State: APjAAAVaZS2jKqcegJ2Ejwd5vLk6HZYrMxR2VlE/dsKmzk21ingYZgLP
 uUk4dzGlkUqAbvHrjDaXYK3fSI1D9WANu5TP4Qo=
X-Google-Smtp-Source: APXvYqw8lz68SMylW0jxDOP6eWVeHHMSeZzt8gFyiu11XP1sXj1jCm2+RD4n/3QfpBnn58DskFF3h88vSdbt8VM7GJI=
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr439589pld.316.1576643580541; 
 Tue, 17 Dec 2019 20:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191217094304.GF8689@8bytes.org>
In-Reply-To: <20191217094304.GF8689@8bytes.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 17 Dec 2019 20:32:49 -0800
Message-ID: <CAM_iQpWGa55xuKV_4hMNNcktNt9MC2XvJU3E8pvFEqja53nmzg@mail.gmail.com>
Subject: Re: [Patch v2 0/3] iommu: reduce spinlock contention on fast path
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>
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

On Tue, Dec 17, 2019 at 1:43 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Thu, Nov 28, 2019 at 04:48:52PM -0800, Cong Wang wrote:
> > This patchset contains three small optimizations for the global spinlock
> > contention in IOVA cache. Our memcache perf test shows this reduced its
> > p999 latency down by 45% on AMD when IOMMU is enabled.
>
> Sounds nice. Can you please re-send with Robin Murphy on Cc? Robin, can
> you have a look at these IOVA changes please?

I will resend V3 with Robin Cc'ed.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
