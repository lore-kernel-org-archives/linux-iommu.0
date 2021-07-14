Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE4C11F68
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:55:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA38613B5
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA38613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61BFF83BA0;
	Wed, 14 Jul 2021 05:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbjXEd72aS5F; Wed, 14 Jul 2021 05:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44A2B83B98;
	Wed, 14 Jul 2021 05:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD5B5C0020;
	Wed, 14 Jul 2021 05:55:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 341D0C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15B1140695
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6oZIma_f5iGC for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 05:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA77E40691
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626242106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vuixl4fC2c2rDMK0JnG+CP570kUeJWSiqn18LVKWU/A=;
 b=ZHrCj9J5MiywYvEk8JK/z4/yFpt1l+XKqoY6dGbaLpa+fSnC7apgZseNeUrYmm2i05eAWD
 7tOWoNXlPf+2tsY42Rl2sdt6vtj6SSVl6Gslc7363MqC3JxJHTDcYYUJAnG6twGCcdKfHZ
 a3AeLSCnXI4XsIYY2BrHTHE2XKeXIjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-LFJ2nWAkPou3yCGvhIOrQw-1; Wed, 14 Jul 2021 01:55:05 -0400
X-MC-Unique: LFJ2nWAkPou3yCGvhIOrQw-1
Received: by mail-wr1-f72.google.com with SMTP id
 m4-20020adffa040000b02901404c442853so896400wrr.12
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 22:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vuixl4fC2c2rDMK0JnG+CP570kUeJWSiqn18LVKWU/A=;
 b=pjdTxM+JHFrpEKQXlab3WD4Bb7gvAxcWHl5snvoY+AfDgZOBAVVQe//r2VjI8CcBON
 fHWzzD6L9oplZibFRgBi4FYO0WVDA3FMBbSy7Xon2RQr58fHAovg63dLBh+XOayAU87p
 KChiYgE0d/UBXH7gz20iiN24P2ee3mNCsJ00D0U/HWQBdJPSIecv8MkYvVc9T5x+Uxch
 zR9l7Xxe0Mztwlsut8vZd3gXea/Ft+3frGy+WizZslQszOuhxTYwwPQlNYtimn40sB33
 p4Imp8Ig2n/a1EGVR/JGX8MpsYI0yjsL45YyTJmrM17nPOacHYvhdOp7tWkweFsyEWuo
 5MJQ==
X-Gm-Message-State: AOAM531r10Nost2C7ziRN5YXMC8Q5piAL1RXPj/QGENa8DaJCs49VdhM
 kYs/RgipHAf0YAGfZcExEvhbT5UmxCPi89QfXJXFrSuxnF4JJrgySwpzSIqozdbUf9ebb0TKBw0
 9wzbxiZvxFjzu4yx1whWoB68F5iSNMg==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr8958259wmj.25.1626242104076;
 Tue, 13 Jul 2021 22:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/S4q9eTkg2SYhF6yFeKAyfrn1SBCErVUzbnkOz4rD7u4lWIEWYF5U7IkZ57PnxEN5PdQimQ==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr8958222wmj.25.1626242103823;
 Tue, 13 Jul 2021 22:55:03 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
 by smtp.gmail.com with ESMTPSA id i15sm1182300wro.3.2021.07.13.22.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 22:55:03 -0700 (PDT)
Date: Wed, 14 Jul 2021 01:54:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20210714014817-mutt-send-email-mst@kernel.org>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 christian.brauner@canonical.com, corbet@lwn.net, willy@infradead.org,
 hch@infradead.org, Xie Yongji <xieyongji@bytedance.com>,
 dan.carpenter@oracle.com, sgarzare@redhat.com, xiaodong.liu@intel.com,
 viro@zeniv.linux.org.uk, stefanha@redhat.com, songmuchun@bytedance.com,
 axboe@kernel.dk, zhe.he@windriver.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

On Wed, Jul 14, 2021 at 01:45:39PM +0800, Jason Wang wrote:
> > +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> > +			      struct vduse_dev_msg *msg)
> > +{
> > +	int ret;
> > +
> > +	init_waitqueue_head(&msg->waitq);
> > +	spin_lock(&dev->msg_lock);
> > +	msg->req.request_id = dev->msg_unique++;
> > +	vduse_enqueue_msg(&dev->send_list, msg);
> > +	wake_up(&dev->waitq);
> > +	spin_unlock(&dev->msg_lock);
> > +
> > +	wait_event_killable_timeout(msg->waitq, msg->completed,
> > +				    VDUSE_REQUEST_TIMEOUT * HZ);
> > +	spin_lock(&dev->msg_lock);
> > +	if (!msg->completed) {
> > +		list_del(&msg->list);
> > +		msg->resp.result = VDUSE_REQ_RESULT_FAILED;
> > +	}
> > +	ret = (msg->resp.result == VDUSE_REQ_RESULT_OK) ? 0 : -EIO;
> 
> 
> I think we should mark the device as malfunction when there is a timeout and
> forbid any userspace operations except for the destroy aftwards for safety.

This looks like if one tried to run gdb on the program the behaviour
will change completely because kernel wants it to respond within
specific time. Looks like a receipe for heisenbugs.

Let's not build interfaces with arbitrary timeouts like that.
Interruptible wait exists for this very reason. Let userspace have its
own code to set and use timers. This does mean that userspace will
likely have to change a bit to support this driver, such is life.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
