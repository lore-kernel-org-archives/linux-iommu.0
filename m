Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F750C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 14:02:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0107D60E54
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 14:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0107D60E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C520040360;
	Tue, 12 Oct 2021 14:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSJ3aBjYgbKr; Tue, 12 Oct 2021 14:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9CDA540245;
	Tue, 12 Oct 2021 14:02:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C22DC0011;
	Tue, 12 Oct 2021 14:02:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9A75C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 14:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D670080F8D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 14:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1BSSsK0sDWdd for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:02:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BA3680F88
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 14:02:34 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 g62-20020a9d2dc4000000b0054752cfbc59so26071397otb.1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Q0Hb9oHK4KcWY8R31erb4VAXs7l6Pn0D6RYKuAbMqo=;
 b=Yq0ybx5oUO6KRl2BgdyTUebTMHE0V1N6SUlOeLzmooYLbULfQ5zR20IIY87NnYijQh
 X5EqrMG7H0ofNUv6kbg1+DfDEBeQr+h4fZX7umN12dSHqHbgLcDiJBXbA9gFGY3ZD9s/
 JAhYNYBygHFReTI2G1t3CqAbsy4WMjGQQ6IkftLfOOYT5Wcq6mXFhczS+NuXJH8SZqiM
 gyNOefmWCD19W3LLPgZl0A+ya1Mn9YvSVRAA5aphUWTgIKFiURHSZ+Lx95W/ACie4pP+
 91Bm8NyOFOZNQX7gSNNWShqXCKWRfB12NaxsTeySZCzgNwwelb1mj4hZNk7AX7BYxe0g
 TrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Q0Hb9oHK4KcWY8R31erb4VAXs7l6Pn0D6RYKuAbMqo=;
 b=KBEDl++j/FeiF7f4yy5jGpPaynzdLFEL3QITn5IP67Ffh6GYUhK7tMKyKuUOEZZjJd
 Q4Tvpsi9G5kB0OmhyVXywzLXPq5Q3HZf+dDPMGkU/7fVYdNDaln6UfWJAGlc/fRWvgcl
 NmL4NCOqLMmToBYIlGFW+ffVpQCUzRzbILypRVmXjb8OXPv7sN7nEatmqZi1dn+SvXBu
 P+wdT1+hmDP4ksn1V+H/TkepCnHb4kv5t8ZvzJX4KAT5pvzgG+qmLmhR9rSY9r85oasQ
 N021BVO9wnM2jOypfwchYvRvoCOyUlIy/xbp06O4rwb7Yu2qagFtO9cSnCg0vrS1L2yD
 VFTQ==
X-Gm-Message-State: AOAM5319wxKPX6vi5/cQkRR9iV3cLMMhxUmp7rjHFVyE+hzR+o9VviQT
 UZi26b/7eMqdAsoerMJqQAyqKoADIgOSenAnCIg=
X-Google-Smtp-Source: ABdhPJzCeultU29FTm/JBZilW5VAVm32j0fgdcu8Mvi1xP1XUxDRD2qYdD/eLWbeM65K6kc+s7uW063PChXvmPzgNW0=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr27310330otr.162.1634047354154; 
 Tue, 12 Oct 2021 07:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211002124012.18186-1-ajaygargnsit@gmail.com>
 <b9afdade-b121-cc9e-ce85-6e4ff3724ed9@linux.intel.com>
 <CAHP4M8Us753hAeoXL7E-4d29rD9+FzUwAqU6gKNmgd8G0CaQQw@mail.gmail.com>
 <20211004163146.6b34936b.alex.williamson@redhat.com>
 <CAHP4M8UeGRSqHBV+wDPZ=TMYzio0wYzHPzq2Y+JCY0uzZgBkmA@mail.gmail.com>
 <CAHP4M8UD-k76cg0JmeZAwaWh1deSP82RCE=VC1zHQEYQmX6N9A@mail.gmail.com>
 <CAHP4M8VPem7xEtx3vQPm3bzCQif7JZFiXgiUGZVErTt5vhOF8A@mail.gmail.com>
 <20211011085247.7f887b12.alex.williamson@redhat.com>
 <CAHP4M8UmnBH58H3qqba1p3kyEiPUk9xTp063yJr8RFduUNjgbg@mail.gmail.com>
In-Reply-To: <CAHP4M8UmnBH58H3qqba1p3kyEiPUk9xTp063yJr8RFduUNjgbg@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Tue, 12 Oct 2021 19:32:21 +0530
Message-ID: <CAHP4M8Wyh92T3KBkpknkY+3gnN_ir-dfnLLf=D3_yUN0jj6Qxw@mail.gmail.com>
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

Hi Alex, Lu.

Posted v2 patch, as per
https://lists.linuxfoundation.org/pipermail/iommu/2021-October/059955.html


Kindly review, and let's continue on that thread now.


Thanks and Regards,
Ajay

On Mon, Oct 11, 2021 at 11:43 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Thanks Alex for your time.
>
> I think I may have found the issue. Right now, when doing a
> dma-unmapping, we do a "soft-unmapping" only, as the pte-values
> themselves are not cleared in the unlinked pagetable-frame.
>
> I have made the (simple) changes, and things are looking good as of
> now (almost an hour now).
> However, this time I will give it a day ;)
>
> If there is not a single-flooding observed in the next 24 hours, I
> would float the v2 patch for review.
>
>
> Thanks again for your time and patience.
>
>
> Thanks and Regards,
> Ajay
>
>
> >
> > Even this QEMU explanation doesn't make a lot of sense, vfio tracks
> > userspace mappings and will return an -EEXIST error for duplicate or
> > overlapping IOVA entries.  We expect to have an entirely empty IOMMU
> > domain when a device is assigned, but it seems the only way userspace
> > can trigger duplicate PTEs would be if mappings already exist, or we
> > have a bug somewhere.
> >
> > If the most recent instance is purely on bare metal, then it seems the
> > host itself has conflicting mappings.  I can only speculate with the
> > limited data presented, but I'm suspicious there's something happening
> > with RMRRs here (but that should also entirely preclude assignment).
> > dmesg, lspci -vvv, and VM configuration would be useful.  Thanks,
> >
> > Alex
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
