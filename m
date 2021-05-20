Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69310C433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:33:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB8061184
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 06:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB8061184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99F544069E;
	Thu, 20 May 2021 06:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6yZWna9Mvaj; Thu, 20 May 2021 06:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F1F406A2;
	Thu, 20 May 2021 06:32:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 314D9C000D;
	Thu, 20 May 2021 06:32:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AECB7C000D
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AC596079C
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnOu7-79JWQv for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 06:32:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8109B60667
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 06:32:55 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id lg14so23435791ejb.9
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 23:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Men5rmBujePBODaPqTxdL7d5Hadu/ohxPE3843bVkM=;
 b=A7yY9vj41fmYGyDYrkBklpQ9dUGDZHKmyUG0IoLZvByGjHFG/UW2ZN1aqLORfLHnBx
 QqYKMTRtEi7Z9I16QUhEMhIryMW5cMGumf2bXTMpReFl4KvhBJ3IsB6RpkNcmCxlgSz9
 zt6OskmxaC4qYaDH8kQvnsFnMUNFKpFwJCeNoqGTrCLTLnN39ys3Gz96V3X6WIhj/Njj
 Peep5jzTFtVG5kL0RROyLmX/J8k4buO/vDp/GNp2LMt4Al8eRZqhCFBuCEywseyKvRzf
 qFl4sFlV+mKrMgjVfanq31xDK3tYoh7pWzsFiEb3w3btIjndenXixOANombxaU5ncyPv
 WbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Men5rmBujePBODaPqTxdL7d5Hadu/ohxPE3843bVkM=;
 b=Mn0HnVvdWtpwktGzpu1vS6S/QqRuE8Cq6DBcZVeFEsz2agi668kke0z3KkKgnFQ5Vh
 jC4wdc7qvTj6fY5j2+z8F03eSNK0OKMYY8i98kFz26Dv5pVpe7Go2S18R4gvu9IJItqS
 H9hJSa9/6bOJ+7FXI/W9dYAYh2Lvn4nVKfw/b+F0JSbfsAT/kSrg0HoAb2Xsda+eZ40J
 //C0uFCuO7swZE7kYWIXRvv5E/JXZFbCeUzc0cElH/blSkHMS9Y0od9wPNslFGRxT2h2
 Uhm3HyeH3x5xdwvleDhroQUprhr/IguIhsAJ8Zt3us2UAr0ADq2u8aJ3QSu5paDEsvYm
 dFdQ==
X-Gm-Message-State: AOAM533nybNpOy40o77rNxZJD8OYKJc8TjYscZmRCP2+wuLlf42cOG0r
 JbTfd90UbCGln7CXoYJA9DptG190915Lt+QYvrxg
X-Google-Smtp-Source: ABdhPJx6xRY71uAWPKVPYMZsfI1C2ZOby/JHxCV6UkDwez9y1Wuqisip7Dr7L+8aPN3fVQWQls2IuNvwZo9GmF/km/A=
X-Received: by 2002:a17:906:456:: with SMTP id
 e22mr3000572eja.427.1621492373326; 
 Wed, 19 May 2021 23:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-3-xieyongji@bytedance.com>
 <YKX/SUq53GDtq84t@zeniv-ca.linux.org.uk>
In-Reply-To: <YKX/SUq53GDtq84t@zeniv-ca.linux.org.uk>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 20 May 2021 14:32:42 +0800
Message-ID: <CACycT3uD-D78EXu+njGb5Wctb1qV4VzwyfcN1803x8SY65QSTA@mail.gmail.com>
Subject: Re: Re: [PATCH v7 02/12] file: Export receive_fd() to modules
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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

On Thu, May 20, 2021 at 2:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 17, 2021 at 05:55:03PM +0800, Xie Yongji wrote:
> > Export receive_fd() so that some modules can use
> > it to pass file descriptor between processes without
> > missing any security stuffs.
>
> Which tree is that against?  Because in mainline this won't even build, let
> alone work.
>

Oh, sorry for that. Now I'm based on vhost.git tree. But looks like I
miss Christoph's commit
42eb0d54c08 ("fs: split receive_fd_replace from __receive_fd"). Will
rebase on it in v8.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
