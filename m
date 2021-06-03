Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60EC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:32:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F8F613E7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F8F613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D06440110;
	Thu,  3 Jun 2021 12:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KK9aIouHB9Rp; Thu,  3 Jun 2021 12:32:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14612400ED;
	Thu,  3 Jun 2021 12:32:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8789C000D;
	Thu,  3 Jun 2021 12:32:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E33C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:32:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E33EB82664
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id slMAnGZFemm2 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 12:32:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A066082779
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:32:47 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id u13so3055641qvt.7
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dgzzzAH8mID5IX+kM+X46gD1kQssopr2KLjMaxfwAfQ=;
 b=pivw5khZunEhLNkShvJxudcY5u34StFUUUuBQ4dT2YRtoGk+ZajKR6j+GJC4EGvAjz
 GAFuhlfNMqLusSqUyju0h8thafVT7d3i/I9E+KmKBU5swJgPoufqlzG0KUset1zUCkHD
 fFlThKEJzjf/01c7z3kYemTUQq6xHkqXdEyIMg7+wGWO+1HbX8jcHdOrUKMmj3nVYO3b
 VswcQIfZ3bGibSi+Ck9fb8LVZF4gREFNaGZedkI6w5m6MCuG9yhnJ41e/Z3AcaulbdXy
 oKU1vlZpULNhX3sbH891/zGeSCGGPouyxdNkzVVXeIKop2MPowv87e+vBJxmdc/eCQjm
 l6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dgzzzAH8mID5IX+kM+X46gD1kQssopr2KLjMaxfwAfQ=;
 b=FUrDrj/J7Og+awFhxTNJiFJXcYuvjQatKhkqvue9c008/MIxXn2Trk/jhncJIQpqz9
 Uq7zCFnNtI2OivOZWuHRiDmDHlfIXnOrmaycoWbES9jDtfGDfZke7eWtlWftjl+pMi+e
 zCuoPOhrbTHvrLXf2bVJaLq7uSiCYBYGn6ouYkXC+cE90dTgLUULOYqXlNkVYaUZkIoc
 TpKOuXjYpISEBVlMiYdwFinqrYGsfhbGsTVzYLZtTW3glRtEgK0ePoTTpKhgU7nHIhlL
 t+Im5xZxTSclLJImJydVklzuQMf6fWa9Rh7G18AVq5xeqxSgKTJLi/6o8AJrX9Wsx4pq
 4P3g==
X-Gm-Message-State: AOAM532FKQ76k3fNies6uq/vIl3XeG5GSwQCz5koduoGEd4VMy6ZR91k
 nZZwgTmZokfVHyDDDpgFWwu4+n9goFAXvaU/Kw==
X-Google-Smtp-Source: ABdhPJwNPJrUuNg7AlPQ4HrNyA2pu83VdMWudd/dH0QdVuFb1BEOS/aHVdnAQMIz+r5TiO7abKEezeHlgQGJO327vXw=
X-Received: by 2002:a0c:fe6c:: with SMTP id b12mr33815218qvv.32.1622723566330; 
 Thu, 03 Jun 2021 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
 <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
 <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
 <705f90c3-b933-8863-2124-3fea7fdbd81a@arm.com>
In-Reply-To: <705f90c3-b933-8863-2124-3fea7fdbd81a@arm.com>
From: Jussi Maki <joamaki@gmail.com>
Date: Thu, 3 Jun 2021 14:32:35 +0200
Message-ID: <CAHn8xc=1g8bzV-uxaJAYpJ114rR7MLzth=4jyDG329ZwEG+kpg@mail.gmail.com>
Subject: Re: Regression 5.12.0-rc4 net: ice: significant throughput drop
To: Robin Murphy <robin.murphy@arm.com>
Cc: jroedel@suse.de, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, jesse.brandeburg@intel.com, hch@lst.de,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 gregkh@linuxfoundation.org, anthony.l.nguyen@intel.com,
 bpf <bpf@vger.kernel.org>, davem@davemloft.net
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

On Wed, Jun 2, 2021 at 2:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> Thanks for the quick response & patch. I tried it out and indeed it
> >> does solve the issue:
>
> Cool, thanks Jussi. May I infer a Tested-by tag from that?

Of course!

> Given that the race looks to have been pretty theoretical until now, I'm
> not convinced it's worth the bother of digging through the long history
> of default domain and DMA ops movement to figure where it started, much
> less attempt invasive backports. The flush queue change which made it
> apparent only landed in 5.13-rc1, so as long as we can get this in as a
> fix in the current cycle we should be golden - in the meantime, note
> that booting with "iommu.strict=0" should also restore the expected
> behaviour.
>
> FWIW I do still plan to resend the patch "properly" soon (in all honesty
> it wasn't even compile-tested!)

BTW, even with the patch there's quite a bit of spin lock contention
coming from ice_xmit_xdp_ring->dma_map_page_attrs->...->alloc_iova.
CPU load drops from 85% to 20% (~80Mpps, 64b UDP) when iommu is
disabled. Is this type of overhead to be expected?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
