Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82661C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 09:19:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C16961CBD
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 09:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C16961CBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9876402B6;
	Wed,  7 Jul 2021 09:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQaavHDx_F7g; Wed,  7 Jul 2021 09:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2E8740179;
	Wed,  7 Jul 2021 09:19:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB12C0010;
	Wed,  7 Jul 2021 09:19:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B72CC000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFC598376D
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ih7YKJE9qUOW for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 09:19:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 083EC83396
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 09:19:47 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id bu12so2259214ejb.0
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ntF5ShiMpxZzH3NgDCu0lj/qLit/wsTznB+iv/n6Jts=;
 b=EkUktZhVW6Hw0D3CwFrVu6SPtBCLkJYy2M7BJM1xaa8T71w3Am8UIGnGLzZ7sZjGBy
 oJPZFOsWMkQsg1Eor8GYHzrS0gvtg/qEnI+kjIYCFKEPoLzQIQX6UgYFrffMXB7uW8ud
 DAJeTUNRxqnYoE0JTnNDRQ4iWBS+hwKVMh6CzB8D/Nd7MUwmVBFXb/1DGoN5IcQxOlxA
 XEcMYCGgJ6/e1b9/F4uGKBE66Lafq27VxOH+bGLgnrQlIyePfFxmfVAzA2OsUgePTZRJ
 T3ukDS1lDG6sIQr7dau/XyarH0KZbl27sp8FmAm/INCn+Zavbu6Ds2cG23H+ZLiJNIkK
 nv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ntF5ShiMpxZzH3NgDCu0lj/qLit/wsTznB+iv/n6Jts=;
 b=Bahb9ZYin6K+jJ8h7kV4gBUjM2pfA5cD6CffqSnAHdZerRMI5IfcQKibEVtkd+2jGp
 SnapCRWH3UE89oUioC4+y0sbg0/PlDenersjoy5opmOU1yop2QnyUyWPsPo3hn/93glt
 rE3dV+H38GoTgjrPnzfRyrOukhvgQWULILMNcrqQ2b8RiHmkN6nFIi13ebk/B20+rwVc
 Wg5I+mZOjyZCD/0DwXeWrVCW1U4Z+NVGhbrqmwCxuLpwpsQk0b0B3YmpIAFCp9yD6UbQ
 aa9WMV8wURgtVifhB+2UKfITBIv0tsj9TiLd3TJy4cC9S6h/AxG4uOqOmOCvtpV34JBP
 npnA==
X-Gm-Message-State: AOAM533L0b/6RVyXSZcWk2YzZ1mDoxhy7m/V6JP+zuMlvXPAGDTKy6vg
 UqnbK8i4X3Fbv3H633L14ZMzKqobc3pfL85Pjbzp
X-Google-Smtp-Source: ABdhPJwfUSLvIX93bY45nGlunKheveZx2mGwfBnicH+p8nMulhsjVrxLC9+PoE5I/qwuA5U0XX93SwRw5wHXZDNyzBo=
X-Received: by 2002:a17:906:cb93:: with SMTP id
 mf19mr20870738ejb.427.1625649585892; 
 Wed, 07 Jul 2021 02:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YOVrZtGIEjZZSSoU@stefanha-x1.localdomain>
In-Reply-To: <YOVrZtGIEjZZSSoU@stefanha-x1.localdomain>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Jul 2021 17:19:35 +0800
Message-ID: <CACycT3tvvMpsjmJGhY5duNCXt5YyyWqQ2MpxRuMKQwmtpgF0Aw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
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

On Wed, Jul 7, 2021 at 4:53 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
> > +static bool vduse_validate_config(struct vduse_dev_config *config)
> > +{
>
> The name field needs to be NUL terminated?
>

I think so.

> > +     case VDUSE_CREATE_DEV: {
> > +             struct vduse_dev_config config;
> > +             unsigned long size = offsetof(struct vduse_dev_config, config);
> > +             void *buf;
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(&config, argp, size))
> > +                     break;
> > +
> > +             ret = -EINVAL;
> > +             if (vduse_validate_config(&config) == false)
> > +                     break;
> > +
> > +             buf = vmemdup_user(argp + size, config.config_size);
> > +             if (IS_ERR(buf)) {
> > +                     ret = PTR_ERR(buf);
> > +                     break;
> > +             }
> > +             ret = vduse_create_dev(&config, buf, control->api_version);
> > +             break;
> > +     }
> > +     case VDUSE_DESTROY_DEV: {
> > +             char name[VDUSE_NAME_MAX];
> > +
> > +             ret = -EFAULT;
> > +             if (copy_from_user(name, argp, VDUSE_NAME_MAX))
> > +                     break;
>
> Is this missing a NUL terminator?

Oh, yes. Looks like I need to set '\0' to name[VDUSE_VDUSE_NAME_MAX - 1] here.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
