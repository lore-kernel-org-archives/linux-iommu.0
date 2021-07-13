Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD4CC11F66
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 11:25:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CE5611C1
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CE5611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9F0260A66;
	Tue, 13 Jul 2021 11:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmoHrzFrEpo5; Tue, 13 Jul 2021 11:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C773460A60;
	Tue, 13 Jul 2021 11:25:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8A2C0010;
	Tue, 13 Jul 2021 11:25:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7246C0010
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 11:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D47C5405F5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 11:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlMPbllNn2XD for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 11:25:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87FAC404FE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 11:25:46 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id hd33so12129737ejc.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V8C4AR1JulD0IJ4qJZ289RJQRxJBo+SCCExitFLHqJk=;
 b=wtJXjCEWs9J3rL4DSbhsQAMH3vsFxI36IhkimPxEp2z4B5KWy98HTgCthwKoCh00MH
 +Cw8MMZs162i1bbwc0H61Fw5Ddld5ixxj9xUkmvXXZrUQ8YV5rCYkVT5n/hIFcFZvbG5
 UGUIKGFHSwYgIS/J+U3XRlILf+pCFDWnBeWFuxoS92ixmz4Ka5l+fJkUYsgiqEz8I8/Q
 1OBeJRTT2X4sFe8UvVyTYuBfz2DBXBRafijnzoDQZ9rYwg7QbMci3cjSlkUfbdcDpKUW
 mrzXomF0nVPSBmTfOX3T/h4LolCD841RkQpBBmtak+CUXtvU4hKRPg/aN6BgjFAqGdri
 H8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V8C4AR1JulD0IJ4qJZ289RJQRxJBo+SCCExitFLHqJk=;
 b=AoQPqsd6XFCtceejP/0TS7yX1TVDEpICH1Vh5UwlzMR9koT5+NEfGxBC/jlNKmP/Q8
 SGE1qmjICCVu6Xkins/HTzm8kv0Lx9uhoTJuXamWIAdBEbGJJwQOV+afuLdlF/gsHgdS
 p6rKRUvUsY+HxcuHpcJJLG74R8Gy6lSW3D2bUQQfmTa1DHbniT9FotCOMfNyvOaS3V6V
 cA8vj9cb6+OguIsuqSIJ5jS8Zdf495uuwBS3ZXe6xuBjI9m/GywUOA+s2qf6tnebIRTY
 Bx/tzhRvHIFNNGnoGPVDVxw4H8wB7YyJMGqCQZndAr96WOqAHhaBjXRuAF+QymhwMIRI
 GitA==
X-Gm-Message-State: AOAM532wHESIR0QB9DO1l0AwvCkah4dEgqPEOGnvxwxuodZ0IZSnBtrE
 B78n2xnl4eiPFnA+vxrxBzNdzyOuMfgVHWL1zz9b
X-Google-Smtp-Source: ABdhPJwEjj4lrSamVi9duSpQV4fbH1XcdO8oLpStHQXALyLK5+815GxTksXcYRUer+qlnlDcQeYitChfiKeAXWFWuFI=
X-Received: by 2002:a17:906:d10c:: with SMTP id
 b12mr4908301ejz.395.1626175544482; 
 Tue, 13 Jul 2021 04:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-8-xieyongji@bytedance.com>
 <20210713110211.GK1954@kadam>
In-Reply-To: <20210713110211.GK1954@kadam>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 13 Jul 2021 19:25:33 +0800
Message-ID: <CACycT3sJpAqQ1JkO2kekSf=wya1TJSK5hj+Z0zejVbCTU4eG0g@mail.gmail.com>
Subject: Re: [PATCH v9 07/17] virtio: Don't set FAILED status bit on device
 index allocation failure
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, He Zhe <zhe.he@windriver.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

On Tue, Jul 13, 2021 at 7:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jul 13, 2021 at 04:46:46PM +0800, Xie Yongji wrote:
> > We don't need to set FAILED status bit on device index allocation
> > failure since the device initialization hasn't been started yet.
>
> The commit message should say what the effect of this change is to the
> user.  Is this a bugfix?  Will it have any effect on runtime at all?
>

Thanks for the reminder. Will update the commit message.

> To me, hearing your thoughts on this is valuable even if you have to
> guess.  "I noticed this mistake during review and I don't think it will
> affect runtime."
>

Yes, that's what I thought.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
