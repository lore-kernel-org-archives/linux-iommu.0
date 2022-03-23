Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2425EC433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 19:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA68F40A96;
	Wed, 23 Mar 2022 19:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3B-ij0NJMkD; Wed, 23 Mar 2022 19:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B52740120;
	Wed, 23 Mar 2022 19:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA419C001A;
	Wed, 23 Mar 2022 19:24:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 317C7C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BEE060A97
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xxRviVthH7P for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 19:24:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C2BB60807
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:24:32 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id pv16so4955356ejb.0
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FaXnwbXaSXbCX4JA5a0+pq4aaz2a8Xc9Ap8EekKfrJg=;
 b=P9ZcEpik6R5EPT4CggIUIW5sJuzMdcf8B0GMQ57M9+1WIls6aC+OjCSeLSGFKdwBgq
 gDZxv7j9z3xw9CvLBywUXZn41za0VVQ/9nq70BC0iyCUf/T9GlF7P+qvj0GM1CjFfk0Y
 40eaqcCqV0NJJlet/B4OqeaNkITYKUoe+Gn8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FaXnwbXaSXbCX4JA5a0+pq4aaz2a8Xc9Ap8EekKfrJg=;
 b=5E+tVR4/Q3kUAU6UF7jSfi9ocTONmSdxY3rTpg0+XvBCHWrE23Qj9JAx7VJ6E1rgAr
 mLQFZ1VfzmGwE/GeiALQHQ7xzgsSvuBWX/cYaz4HYGyqNL7OyO3M/MGWgNIaJDEnVm/y
 mAo2FO0DdhOHkFGTGfJsIEAeOjNpwSY44CRu5oB7yJasH5igVsJHoKlfl/QG12KTetHI
 prLnJlsgA0bn/Rt2YXplakA+EFQo0UjsIlg5Qm6e53oA6b2B5Ccis43M9YyzAYuf5C04
 xXVx/4DOitUZ4SFeuauLk9v7tFP5MvQhJMbi2ZqzIaKPauIrVFWRvF/ohi3FKeJPWERy
 C3Ww==
X-Gm-Message-State: AOAM531ePTECmhgn+13p4TS9KaAVHAhkyzocMUSg3N852jMh13rkI6hM
 1H2KODHhPZ2kzTZ1pJYsae0s9y4jHAvNW/BA6hap+w==
X-Google-Smtp-Source: ABdhPJwtotbTzWfxLG3n8xYN7e/AzkcskHuhqbi0XJCcuA8id2Eds2yzCClgVcYkFk8YQjuameKYhA==
X-Received: by 2002:a17:907:86a8:b0:6db:6c1c:d9c4 with SMTP id
 qa40-20020a17090786a800b006db6c1cd9c4mr1743167ejc.640.1648063469967; 
 Wed, 23 Mar 2022 12:24:29 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 gn33-20020a1709070d2100b006dfcce8be86sm268411ejc.225.2022.03.23.12.24.29
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 12:24:29 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id b24so3043137edu.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 12:24:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr987003lfu.531.1648063009559; Wed, 23
 Mar 2022 12:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
In-Reply-To: <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Mar 2022 12:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
Message-ID: <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: Robin Murphy <robin.murphy@arm.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Mar 23, 2022 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-23 17:27, Linus Torvalds wrote:
> >
> > I'm assuming that the ath9k issue is that it gives DMA mapping a big
> > enough area to handle any possible packet size, and just expects -
> > quite reasonably - smaller packets to only fill the part they need.
> >
> > Which that "info leak" patch obviously breaks entirely.
>
> Except that's the exact case which the new patch is addressing

Not "addressing". Breaking.

Which is why it will almost certainly get reverted.

Not doing DMA to the whole area seems to be quite the sane thing to do
for things like network packets, and overwriting the part that didn't
get DMA'd with zeroes seems to be exactly the wrong thing here.

So the SG_IO - and other random untrusted block command sources - data
leak will almost certainly have to be addressed differently. Possibly
by simply allocating the area with GFP_ZERO to begin with.

              Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
