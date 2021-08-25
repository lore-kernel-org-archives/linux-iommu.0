Return-Path: <SRS0=FkPa=NQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA09C4338F
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 12:18:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3211610FD
	for <iommu@archiver.kernel.org>; Wed, 25 Aug 2021 12:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3211610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A071E42553;
	Wed, 25 Aug 2021 12:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycNlNaufJ0ak; Wed, 25 Aug 2021 12:18:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E97B42548;
	Wed, 25 Aug 2021 12:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD09DC0010;
	Wed, 25 Aug 2021 12:18:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A17C000E
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 12:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FA2C42548
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 12:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9tJZoz_XFJiR for <iommu@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 12:18:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4456D42530
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 12:18:09 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id g22so6206604edy.12
 for <iommu@lists.linux-foundation.org>; Wed, 25 Aug 2021 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tFbYUBxT5F02ETxWPNYnDT/IzVXwtvTQ/hB2M/j5I40=;
 b=S1Gv6G7NlFrvneSYqnBSOeyE66l/w2OvgLtQGyc2ete205Cc/K9titvobBEHOkV7Jd
 LF+IGAbQBYCZgtY/Oc+VQjeSILHfyY0qY86cKKFbFI9eKSjibGyEMQbH+ejgmKSjcgC5
 7Ky78pwYl3ckT1x+pt8+vBGkO34Qu9FkKuJyYOZHJxs8JFezX8A9akOzr4r+RFN6WG3I
 Ku/K/lCbctjWFcI5f456bKKJQs0YE9FPfHmoAitDy6E/v21XOApT6h0Cwzr8rwCnMRdX
 GH00tomNPmmrq5p2YIaWuULxkUShxdgVCD8W5xkwuXFKP/V/+9cDwXz5fK1Dz7KM8amN
 GWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tFbYUBxT5F02ETxWPNYnDT/IzVXwtvTQ/hB2M/j5I40=;
 b=CosdJu+xYdIi2WZBg8zNuWU7lOxNyOnLZJ0Elg1ZWzY5E3+jAHVk0LLNHhFhqB2msl
 ZnzNFZIMbh7/58ipf/NCrC1wFouPQroL6hj2M/6B+2nFE2ej0GRo54RYLhhMHMStISj4
 QQnrWsR3kMQME18L1utIUFvk6+vBHyEislsfp21cu8j7CP6lwEeeQzQ5w9cCEgwQo5S3
 RE8dSl4DMLVnqvwJ/BNC+BlYnU7N/etqeOBq3fSTyo8gMGlSXYnbJSa5QjLevPSz4ORq
 Ki6qY77aWu4gjZEfJS++SlAHyctmkTuTE0K5UWf/nfZuCefvKL7W2rzg431/nsrr8XsE
 8OXQ==
X-Gm-Message-State: AOAM532TJkRYfe0ghch3ZiqYrZLDquUYCZFaivgYfCWJ628fOunCHuUu
 FFoVK4inh+4TgQLNI0JZyGS4D5rB5b4d/c2N6hZW
X-Google-Smtp-Source: ABdhPJxiDpOcq8C+5T5VQdj2MSQ986LjNwq+2D/7Hfzk3BtSiet2580JVQtXlr3OiUAX1rd9+hgAp9kuHH1qjNotBK4=
X-Received: by 2002:a05:6402:705:: with SMTP id
 w5mr15141991edx.344.1629893888145; 
 Wed, 25 Aug 2021 05:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-2-xieyongji@bytedance.com>
 <20210824140758-mutt-send-email-mst@kernel.org>
 <20210825095540.GA24546@willie-the-truck>
 <5f4eadda-5500-9bac-4368-48cfca6d0a4d@huawei.com>
In-Reply-To: <5f4eadda-5500-9bac-4368-48cfca6d0a4d@huawei.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 25 Aug 2021 20:17:57 +0800
Message-ID: <CACycT3uWyhNNK_YbfEAEhTk-V9CoxFg1tzVjJnXeKBFpkndnfg@mail.gmail.com>
Subject: Re: [PATCH v11 01/12] iova: Export alloc_iova_fast() and
 free_iova_fast()
To: John Garry <john.garry@huawei.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, Joe Perches <joe@perches.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Aug 25, 2021 at 6:35 PM John Garry <john.garry@huawei.com> wrote:
>
> On 25/08/2021 10:55, Will Deacon wrote:
> > On Tue, Aug 24, 2021 at 02:08:33PM -0400, Michael S. Tsirkin wrote:
> >> On Wed, Aug 18, 2021 at 08:06:31PM +0800, Xie Yongji wrote:
> >>> Export alloc_iova_fast() and free_iova_fast() so that
> >>> some modules can make use of the per-CPU cache to get
> >>> rid of rbtree spinlock in alloc_iova() and free_iova()
> >>> during IOVA allocation.
> >>>
> >>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >>
> >>
> >> This needs ack from iommu maintainers. Guys?
> >
> > Looks fine to me:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Will
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > .
> >
>
> JFYI, There was a preliminary discussion to move the iova rcache code
> (which the iova fast alloc and free functions are based on) out of the
> iova code and maybe into dma-iommu (being the only user). There was
> other motivation.
>

Would it be better to move the code into ./lib as a general library?

> https://lore.kernel.org/linux-iommu/83de3911-145d-77c8-17c1-981e4ff825d3@arm.com/
>
> Having more users complicates that...
>

Do we have some plan for this work? From our test [1],
iova_alloc_fast() is much better than iova_alloc(). So I'd like to use
it as much as possible

[1] https://lore.kernel.org/kvm/CACycT3steXFeg7NRbWpo2J59dpYcumzcvM2zcPJAVe40-EvvEg@mail.gmail.com/

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
