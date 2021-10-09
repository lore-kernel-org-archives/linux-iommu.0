Return-Path: <SRS0=ijGq=O5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB486C433FE
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 03:12:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9A460F38
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 03:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E9A460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BCA460B24;
	Sat,  9 Oct 2021 03:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyRortP932gD; Sat,  9 Oct 2021 03:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 030B7607BA;
	Sat,  9 Oct 2021 03:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C53A0C0011;
	Sat,  9 Oct 2021 03:12:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E66C000D
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 03:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D90040117
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 03:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlmBU0TIGuB6 for <iommu@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 03:12:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3061F4016F
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 03:12:46 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id i20so26983262edj.10
 for <iommu@lists.linux-foundation.org>; Fri, 08 Oct 2021 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uZJSKNQy7a8ovN2pCX/SIRQeSc/Um892V8g+28sH3XA=;
 b=lT0XHcI0TpH/LmGXnyBS7lKQ0yndi6kYlSOIR9ohcRIAzMmzV4O7HFw6PRcyAFMJXV
 35ArbQiNBCejnBog+t7kKjHoNrpR9NijO6og5azj8BPmFZm0NWz3j7C/nXtz3AouncSK
 G4fzggKwjqvLs1yoJXXIp4fkMaQOrdwALv6soCcVS1OyJjfH+AF2BFHM26n+9+5sUp4N
 LynSO2PuCTmHyMYlgsTcUcLZCjuTnPVTq+hTyWMMKV2D5FXufSXJxbnjIkAMD3d3Sx4l
 vexDI+c2w4AUuh56kwhKnK7GJsZ29iFUsxr/7pXEExZYf+H/2IbwzQ0UGhTqkxdGi46T
 Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uZJSKNQy7a8ovN2pCX/SIRQeSc/Um892V8g+28sH3XA=;
 b=aSqY7mq6NpmJTrkHnyg6Fr2rAKt5QKJ428LilP6B0jaHCmaN0yfscp6on5714r5thr
 SFBJgfWakP5gD5nm/+PNWJE5dQ57rYiV7WT9Ge7ezR5r0DnW35WjjvFUeIHHr/OW9YWV
 sVOY2g10pw/Jw6vFy/916QX2ubJcAJt8NpVG1Wi/nnLZ/79kSo9OM6iFO3H/7Rlwx1uC
 y4aESDNhqe/kjIXb3/yk61fS7BOrwv+XsMpNpPTgFjKob32f9vOWd6iaMB+1bqP1c3y4
 NZJM8cefP8iOcjpQtbO2BoN18PLyiF+1Z9MV0NqxI0JmskLuABqrSzb6zjE3ufpYY8pr
 3w9g==
X-Gm-Message-State: AOAM532VJHkq2gtdlkz9IPrVHI34a2tkqc112EugqM4of1ltqdVI9/Rw
 ZgrQ1d9GwRjLPJY+BBrDwjVdUPxQ1zhEQfcN98Sv
X-Google-Smtp-Source: ABdhPJz7DRpOEmsUmPDseEn4n8CRah9ndGFAOopm2Qhj5gemkWNxyqyOpPzdRyPlctzBfS8c+Yv4FYyftovwZ39x7uc=
X-Received: by 2002:a17:906:5590:: with SMTP id
 y16mr8914091ejp.286.1633749165008; 
 Fri, 08 Oct 2021 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
 <20211004113121.GA27373@willie-the-truck>
 <b8b51f52-1a8d-46fe-69ca-0acaf8d399f2@huawei.com>
In-Reply-To: <b8b51f52-1a8d-46fe-69ca-0acaf8d399f2@huawei.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Sat, 9 Oct 2021 11:12:34 +0800
Message-ID: <CACycT3sMT7SxxS9qtZdwSENDk3fNgPHvy5X9iibaRs4na5fNzw@mail.gmail.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
To: John Garry <john.garry@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will@kernel.org>,
 linuxarm@huawei.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Jason Wang <jasowang@redhat.com>
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

On Sat, Oct 9, 2021 at 12:17 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/10/2021 12:31, Will Deacon wrote:
> > On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
> >> It really is a property of the IOVA rcache code that we need to alloc a
> >> power-of-2 size, so relocate the functionality to resize into
> >> alloc_iova_fast(), rather than the callsites.
> >>
> >> Signed-off-by: John Garry<john.garry@huawei.com>
> >> ---
> >>   drivers/iommu/dma-iommu.c            | 8 --------
> >>   drivers/iommu/iova.c                 | 9 +++++++++
> >>   drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
> >>   3 files changed, 9 insertions(+), 16 deletions(-)
> > Acked-by: Will Deacon<will@kernel.org>
>
> Cheers
>
>  >
>
> Any chance of an ack from the vdpa guys on the change to their code?
>

Looks good to me.

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
