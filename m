Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D1C432C0
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:26:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF5A20640
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsrIQQ4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF5A20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEE6186ADD;
	Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAysCbeWwIx4; Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BD51864EA;
	Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56883C1799;
	Tue,  3 Dec 2019 19:26:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9A9BC087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D66918659B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oX4AYoEzezvB for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 19:26:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 55A1A8633B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 19:26:26 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id k13so2104281pgh.3
 for <iommu@lists.linux-foundation.org>; Tue, 03 Dec 2019 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sqtioymHBr0uuCq5mwVAHI29Uwj8my7Exon8dNBMKKs=;
 b=SsrIQQ4tDtJEG1eE6i6xdWD0thA30XH+Iwb/cUfSpfMWvtserG/Z8P1Tu2BSn1L+vD
 47Ri1mKfNphnsCdlxFzcxgtcuc55HOMXnr4BCgCq4LZXPuGHdbA3lqtVcCQEGFWqeHvi
 95aeGnDhy6lv6qycnhK6woh9OfgoJcRpZTVF9wAByEiZc4Gq9YHkLEGWtzw+ebumyjPe
 CJyP8wo8JxCp0hncgXVY9JAZwWLDGgHlC0BuJvf3iQmLLLDT3mxzvm/fLLIjsDJvUeOV
 rrbId5rvL1Ls+4C1y40bEpk2rmGF3ISIHyxZLe+hBdEauBsyyXUDKbiZmTGtv+9sR4QB
 bBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sqtioymHBr0uuCq5mwVAHI29Uwj8my7Exon8dNBMKKs=;
 b=acK8nM6bOYkXRHaEOXGfhX9dXOIIKPshT2ENW3PIz8YlxM9M+qSyNmDnoBmWH2Et+E
 RNnQTC0D2kdyxqgd6nrvjRO02DPo8i2/xPsfCCWrAGAyyXjS7gTq//HVXWfDz9UZK+wl
 N2vMKLQOMFuGKvCsJb/D9stS7N90L2rN/+9ebb7rdUHtX/wVaOO/G1J703s9NlVPi7SG
 Tpa0ozzOX4stYhEhFUnnIiiTWMtMqnc9haSTYwGmIEHpRS1bADmBta/IRLKR2GzfyyiD
 1L7TXahmIsq/6qLGfZuXSczO36xYsSNfmFx/TS55TZJqNpwKMrjeLUc7xh1dwePvIdCX
 exug==
X-Gm-Message-State: APjAAAVR3ZrmYUwHCjOuRJw1oYlhWU4hrKHBYffiFsyQut/h6T3u0aig
 b2iZKnPDnR/Nx6kzwoFxgP8HY8nhpKoHBg9XS30=
X-Google-Smtp-Source: APXvYqys3iet5YGW1UKJyuKaxQYtYMh5kqZuPWHHzRf2oS9FTmDwnVsLMfAS5j5iGOhcUKZDs899N5Tqi5hgxGU355A=
X-Received: by 2002:a63:1953:: with SMTP id 19mr6938676pgz.157.1575401185710; 
 Tue, 03 Dec 2019 11:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-2-xiyou.wangcong@gmail.com>
 <d0f58734-0c1e-af9d-3437-31cf6c8a86f9@huawei.com>
 <CAM_iQpXAf8obF1-CRCGc3Fb_YmNBozcyoKQC5yuP6r9Akg6HBg@mail.gmail.com>
 <b27d0ba1-4f30-3e25-6898-26305a3d42db@huawei.com>
In-Reply-To: <b27d0ba1-4f30-3e25-6898-26305a3d42db@huawei.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 3 Dec 2019 11:26:13 -0800
Message-ID: <CAM_iQpWj2bW+WS37UabhejWwQw7GCYEsCw1hP6eRcuOTCBHiAw@mail.gmail.com>
Subject: Re: [Patch v2 1/3] iommu: match the original algorithm
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

On Mon, Dec 2, 2019 at 2:55 AM John Garry <john.garry@huawei.com> wrote:
> Apart from this change, did anyone ever consider kmem cache for the
> magazines?

You can always make any changes you want after this patch,
I can't do all optimizations in one single patch. :)

So, I will leave this to you.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
