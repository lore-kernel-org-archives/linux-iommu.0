Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B5ECE59D
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 07:36:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D550620659
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 07:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D550620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 92F179BA;
	Wed, 16 Oct 2019 07:36:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E309949
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 07:36:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
	[209.85.210.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 177C613A
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 07:36:22 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 41so19294707oti.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 00:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VKlKYK3Agmex6deuTVUQE83h0hGOdqjmBwzrY4fqhkw=;
	b=PKtRyXvXiv5r/j+1orMCQ22SN2gKR3E48g1wg1g/0kXAKfKpii89DAgDVpcRpiEHGt
	h7X1nB032LDJ+u/orkGfepV10nb6CePJz+lh16VihuiiBzUT0mmoUjXG02ikiD87mvQ8
	TNenGXD1/CAHPJZTkV//Jnyu4/3qGDb+qiZ37rIN4UWdtCz5ciuThLBhx/xj4qMBaM/k
	5qL6ZloT7OofyfF66eYgB6o0/1bE9qfMpuQ+gEL/y+yvoO0il+0KxjP7MTFvZDEayrqc
	8Yb3m22fPwsP//U6yM8WsawpY/IjAluyzR4q516pZWjxPDbTcp06Upj71/e1NV/k/qpe
	Cppg==
X-Gm-Message-State: APjAAAXzgaj4t4ZXlh9ktq4MLP6r7hOp4Rx3LVByBYJUo6RhMLx8z++v
	Rz1TEkAq5v8SL07zqrVLd2TGS3gey+8tHAWHHJU=
X-Google-Smtp-Source: APXvYqyyn5FBJqt67FRHYhBN2jsTn8BDc1bUJgGx284dUJ1pfQq3aX4htY8iyZow7JvzN9mlauSUGvyxLrINRvAYUyI=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr15675460otj.107.1571211381219;
	Wed, 16 Oct 2019 00:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <1571137920-15314-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1571137920-15314-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1571137920-15314-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Oct 2019 09:36:10 +0200
Message-ID: <CAMuHMdXCWcy_uX3-Z6Ao=ROTLM52Vxk=we-oKQ_H51hTem4n9Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iommu/ipmmu-vmsa: Add helper functions for MMU
	"context" registers
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Oct 15, 2019 at 2:10 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> This patch adds helper functions ipmmu_ctx_{reg,read,write}()
> for MMU "context" registers. No behavior change.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
