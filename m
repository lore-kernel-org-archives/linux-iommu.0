Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47340C11F64
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:15:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6A461D1F
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 03:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6A461D1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FA42402C4;
	Tue, 29 Jun 2021 03:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-kWW3g-BfMf; Tue, 29 Jun 2021 03:15:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5EE4A4029B;
	Tue, 29 Jun 2021 03:15:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC66C001D;
	Tue, 29 Jun 2021 03:15:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFCE3C000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8491540290
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPpy5zs9wWMj for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:15:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A5E140276
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 03:15:22 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id l24so4390170ejq.11
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KSP9MnxtnkwaBaqFffC1/G5CwF9yGzg9W9Q6U/eCMio=;
 b=trz9EZjpzzDlN+qvVOvq7umsssDF2IXsOdePgArPhNfrFD+HeoNYw9g9xzyAhb8MKk
 mmpCQPnoQeSyx8U2dU/uHBBXJuxYujR+dpmYpf3Zajl9fTas6kctAJkBbjgRzfivg2OB
 yj1qDXf69FF6HUXTycchd0vTemH3qRAeHyMtHGpVClkd54HdkzVoehXk+f8vp1TZ2hPu
 9dQqlEUIafRa41+2OmLox/HCo9ezTTkzCk0hQDZRSKY6n10tM+7jdPeJBHXWWcYvV132
 Wwywql7RSG4MI6Ib23cSV71szhrFJRImsg2bQDJXmui0IrqcBxD8391lxzBVfzYZTccD
 E6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KSP9MnxtnkwaBaqFffC1/G5CwF9yGzg9W9Q6U/eCMio=;
 b=mbxOxD0i5qLwIbh9vL3aPNLhO4JNo+itOfyFsH3PR87q8XEik3/sqrGQ9TvTmjJA8K
 /dOfNuoF9Eo4woSvi6QNiT4ypofhwxNM6WJ63VsgG+5U4/f7d5ARSyLiPEIXJiPP8bdx
 HxwJunnciteRt2OR9ZqyQM6K94Y5vKPNyYXBubAzMF/4mAL9sp1f0XTQcqoCthcvgpMq
 HXMGhmEhckNXbDOi93Z1DycvEanerriY7izAPgb7cxVM0ThkcZiMgTwqZVm50TjEuFh3
 85a6TftGkoPw4Oku853mWp0im1LqFwU48oDKF1oCmlvCIR2cs3+nM5Qk/dwNOsvpNLgc
 Ph2g==
X-Gm-Message-State: AOAM5331Y3ur0jyTZCgpJstXhyDwJSTbWL1dk7hWZ0LPqjlUMCqGyIuu
 /HHyBa9dfcc2mAb3ZkwNa0XgfkxmmFHC9paqbwxP
X-Google-Smtp-Source: ABdhPJygNTq8Wi5J8lQUEA69a0KDIXQbdUPLuUv1X7DgdTJUivR6hqFwxAoue0nTaAaGcU1j++UWvcm4NWY1mqaUomU=
X-Received: by 2002:a17:906:3c4a:: with SMTP id
 i10mr26893189ejg.372.1624936520374; 
 Mon, 28 Jun 2021 20:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <YNSgyTHpNjxdKLLR@stefanha-x1.localdomain>
In-Reply-To: <YNSgyTHpNjxdKLLR@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 11:15:09 +0800
Message-ID: <CACycT3tDpK+eHatDKRkvt1qyA5cO6g4qGN+0nfm3EhFA1OwPww@mail.gmail.com>
Subject: Re: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
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

On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 10:13:21PM +0800, Xie Yongji wrote:
> > This series introduces a framework that makes it possible to implement
> > software-emulated vDPA devices in userspace. And to make it simple, the
> > emulated vDPA device's control path is handled in the kernel and only the
> > data path is implemented in the userspace.
>
> This looks interesting. Unfortunately I don't have enough time to do a
> full review, but I looked at the documentation and uapi header file to
> give feedback on the userspace ABI.
>

OK. Thanks for your comments. It's helpful!

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
