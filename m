Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597AC433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 04:54:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A99E23A58
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 04:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A99E23A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40B4087A70;
	Tue,  8 Dec 2020 04:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JqAJpVfnKaM; Tue,  8 Dec 2020 04:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3BE587A7D;
	Tue,  8 Dec 2020 04:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90238C0FA7;
	Tue,  8 Dec 2020 04:54:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2B8C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 04:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1AD5B872D0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 04:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4D4manbuyffA for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 04:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D718C8729A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 04:54:16 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id ga15so22807450ejb.4
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 20:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8/HsXaIACwTyoNaST+7tlYLda7+69QnFbCYHF3SGybM=;
 b=NHsKtZ9ZOwK+YAUpwafqbwPyEYnaQlamxFuqZ5sx2/0AONSSemfZtgg6vaRYU7xMnz
 77hLn6qr8fZNf18KjA10NS1l9fT9uZjhO5l20wU8SjXk6PeV+cqAxSBJQCDlYwdIqnKx
 YIKIJbr2H7A/xU0s4wwnhf/QpGitRIJ5AI3KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8/HsXaIACwTyoNaST+7tlYLda7+69QnFbCYHF3SGybM=;
 b=glV4o+V7XwCiiX7Jgbfzg5oEUe2CzGimgmNj65PPk9tYdYJ5uBFiRd/MFsZ8i3x/nS
 628xLk4RzyXgGnyQ0H+kYjAp2gQATRfL/G+oX+Q9011qkgi8ge29Wz3+SpqWGVN3+vr1
 0SSzWA3ZlBcelpjuVTpe4c4y3HhLofux17PzclYw+ZEyFajQb59//4uR+IWI5c6tUxhW
 CV+5KgUTx3HpxwixiiTX547dRPQbLBzkC6Z/D2Kdic9cgKeD9zscSnz4F930hi+nupUY
 ko0yQ9q/YmnL6b6qWNw//koI0BwluFc2jGJmVckZ5a2bU3jQfTSyOi4IIt+GxQi/3b33
 iv6g==
X-Gm-Message-State: AOAM531smGcuH8zoydIocitWBQuyXJONVnOy1+OUTJgwKWnWqIY6oMut
 6UJh4HAoXDih8pCVkve0uRbh1UnsBvjhKw==
X-Google-Smtp-Source: ABdhPJy7WudDwZ/ZCY8yMciM1CTeSOrHOstZJjq1peWvXTSEmn/MNFf3jBqbCm6351gWTWW5iI3WQw==
X-Received: by 2002:a17:906:7090:: with SMTP id
 b16mr11637564ejk.76.1607403255052; 
 Mon, 07 Dec 2020 20:54:15 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id 65sm16057144edj.83.2020.12.07.20.54.12
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Dec 2020 20:54:13 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id z7so14918964wrn.3
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 20:54:12 -0800 (PST)
X-Received: by 2002:adf:f881:: with SMTP id u1mr22668227wrp.103.1607403252411; 
 Mon, 07 Dec 2020 20:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
In-Reply-To: <20201201144916.GA14682@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 8 Dec 2020 13:54:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Message-ID: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Christoph,

On Tue, Dec 1, 2020 at 11:49 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 01, 2020 at 12:36:58PM +0900, Sergey Senozhatsky wrote:
> > Not that I have any sound experience in this area, but the helper
> > probably won't hurt. Do you also plan to add vmap() to that helper
> > or dma_alloc_noncontiguous()/sg_alloc_table_from_pages() only?
>
> Yes, I think adding the vmap is useful, and it probably makes sense
> to do that unconditionally.  I'd also include the fallback to
> dma_alloc_pages when the noncontig version isn't supported in the
> helper.

From the media perspective, it would be good to have the vmap
optional, similarly to the DMA_ATTR_NO_KERNEL_MAPPING attribute for
coherent allocations. Actually, in the media drivers, the need to have
a kernel mapping of the DMA buffers corresponds to a minority of the
drivers. Most of them only need to map them to the userspace.

Nevertheless, that minority actually happens to be quite widely used,
e.g. the uvcvideo driver, so we can't go to the other extreme and just
drop the vmap at all.

In any case, Sergey is going to share a preliminary patch on how the
current API would be used in the V4L2 videobuf2 framework. That should
give us more input on how such a helper could look.

Other than that, again, thanks a lot for helping with this.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
