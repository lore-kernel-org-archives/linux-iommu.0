Return-Path: <SRS0=jhW9=O6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE4C433FE
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 06:16:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA5E610C7
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 06:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BA5E610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C39C840190;
	Sun, 10 Oct 2021 06:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENzdpVi4Rczp; Sun, 10 Oct 2021 06:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A053B40164;
	Sun, 10 Oct 2021 06:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75E69C0011;
	Sun, 10 Oct 2021 06:16:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8087EC000D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 06:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61CC560783
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 06:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 67GdkertDBuR for <iommu@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 06:16:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5231460782
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 06:16:03 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id o204so11610703oih.13
 for <iommu@lists.linux-foundation.org>; Sat, 09 Oct 2021 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=daGz2AT73lBTk8Kwa51aEbShQGQTIG56i4A/DTDNGls=;
 b=NkoxlVp2Rqq5UujnoattJyVeQp2F1MUegHUfmIvgsFN+40WFpv4prdvKoA04A1n/ey
 XQb/slzFfy1RUGI+/YACt7ZzVratNKCbKVJEBK96IYTK5JhkIo+lv5Lfj0nBdLKaU6Dx
 71pwMD0x5iFlsDujAyRGEEuf1CcGjEQdjnICWDjuNpQRTWGh7WtJYoJGC0BTJnREsErB
 iwqZGoTezVVCXv5sB/zQGIbhX3vMTLm2/OS5BvJxlp4AuW7Am/D2L5dZ+phOebm9nfl/
 InGp4ths5vXQhdStstgiMRDXXS+WTMq4/Mu7QpLjSH4oVQLLNPi7b8FpCn+aizM2PzOA
 pj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=daGz2AT73lBTk8Kwa51aEbShQGQTIG56i4A/DTDNGls=;
 b=lHgaPD7vKf/zN4cu/aU5UFJHUg6uct4UjiaE0IfYool3oY27zksZrKAYhLlj8jH35S
 lylSbBXetJQ4gAGMNYJs8XUONck5iTwUfvLsQggn7vhRCuLVFbLttIgutu2wus62mqDN
 LK5cmTc/gdPi3vs7d/oaL4L7UgutQ31+quGbfNhZ5ILzYNVsOjOkYQO1wl1kBZcWrwwv
 +gAoD8yjeqKxBUDu1mb2XTx16nTrTpcc9nx71vrEoNgJrYOHlbr7lfGB0be4DeOFkQ50
 SIIre0a6x2W2vDLSU0N8zOg//VjOv9A+WaGVrxPgeLhwMjlhecJgpz3pL/aOeMTzt+5B
 sX/Q==
X-Gm-Message-State: AOAM533KzKOetpJAup15WTR/ztUOkDoUV+E/VZZRAau9ZHiAwbRRVbyd
 /YvAuyUJMHC2YFhQc25xaeVCck5jouT6qVE3TmU=
X-Google-Smtp-Source: ABdhPJyox2l8PWkPoFePfCgzA59pr9CmTFfHHRqaIWZGx+rM7po4EY/EvcI/dNlmGXfXn73zQ+sECUXJg+jObwtS4HY=
X-Received: by 2002:a05:6808:1912:: with SMTP id
 bf18mr14334736oib.118.1633846562381; 
 Sat, 09 Oct 2021 23:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
 <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
In-Reply-To: <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sun, 10 Oct 2021 11:45:50 +0530
Message-ID: <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
Subject: Re: [PATCH] iommu: intel: remove flooding of non-error logs, when
 new-DMA-PTE is the same as old-DMA-PTE.
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
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

> I'll try and backtrack to the userspace process that is sending these ioctls.
>

The userspace process is qemu.

I compiled qemu from latest source, installed via "sudo make install"
on host-machine, rebooted the host-machine, and booted up the
guest-machine on the host-machine. Now, no kernel-flooding is seen on
the host-machine.

For me, the issue is thus closed-invalid; admins may take the
necessary action to officially mark ;)


Thanks and Regards,
Ajay
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
