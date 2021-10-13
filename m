Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CBC43219
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B53610F9
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76B53610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BDF8407A6;
	Wed, 13 Oct 2021 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M_aEr1qPYtgz; Wed, 13 Oct 2021 12:18:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C56640796;
	Wed, 13 Oct 2021 12:18:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0B7EC000F;
	Wed, 13 Oct 2021 12:18:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71A50C000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44512824DC
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGBlhUF4DIJF for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4A6E82861
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634127483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
 b=gcZphIhv1SUibhOpSsOSgz4m0cbJvHyEtd0kwtKyNGk7PlE0SU+JPX+FUmjzkGHkvuPJuI
 RYeShTXWeJ1jx+SFek2K1Tc6X4vwuEpu4Q3Rv6491+05hOgYMfee2etkukNn00qGLGJeMY
 ljgHBxDZGBTUGlUD8++dZn6sdjVlaG0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-uxP0iQKBOO2tjMzc7zwhkA-1; Wed, 13 Oct 2021 08:18:02 -0400
X-MC-Unique: uxP0iQKBOO2tjMzc7zwhkA-1
Received: by mail-wr1-f69.google.com with SMTP id
 c2-20020adfa302000000b0015e4260febdso1785897wrb.20
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
 b=PzSXRk7uAnKYpBcyVUb/gL5jDcBxplGmBDxcg+flWBETV89a0cMWDNUMhxAIItTmA/
 BfpQnAc2mJJcObPOW1GKRiA6orGZzJq6H4BnEhCE2Yzuaoi50DjL7yM0ABSrtwXeQeno
 WiH6TErX2sIN67imQulvxPLd6mH05HqEk6Uw1EgZ6uvgEnvb1cJ3wLVtymNN+4VQFqyh
 Xlj3e4wVg/29rmDudbuYERSgj3GIsfz29iNddC5kCaOnI4nPDap2yHC98kKOGERjFMBy
 HijMPby2E5+RQ6rkq7hU0ck/+QGTIlqW4hjaADwxcc4sFP4GDS85XTYVcxNHJuGQr0cv
 SeTw==
X-Gm-Message-State: AOAM5316r6JviP/roiyAV701r4XvrM6wr4JtgOWpdOCe5GLWsrxqko6o
 KEoBk7NeKOXjvpjlGeXpTr+qe4/c3oEcA5Hc8GvseL+duH7Y7r90rQeoUZ+XQZcclEIQSPeu6zO
 p2RqhxAVIhl1ECPBZjDGoooH89ieOXA==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535241wmj.38.1634127481371; 
 Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFEzPqFQ+1qHznC4euH1QtbfXrvr/+t46tCqHwjpC6aqk2B2gJ30j5Cm2I+Hz0oA4zGN44UQ==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535146wmj.38.1634127481076; 
 Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id z1sm4104369wrt.94.2021.10.13.05.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:00 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:17:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013081632-mutt-send-email-mst@kernel.org>
References: <20211013105226.20225-1-mst@redhat.com>
 <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Latchesar Ionkov <lucho@ionkov.net>, nvdimm@lists.linux.dev,
 v9fs-developer@lists.sourceforge.net, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>,
 David Airlie <airlied@linux.ie>, Viresh Kumar <vireshk@kernel.org>,
 Jason Wang <jasowang@redhat.com>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 linux-scsi@vger.kernel.org, Will Deacon <will@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Takashi Iwai <tiwai@suse.com>,
 Gonglei <arei.gonglei@huawei.com>, Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Jeff Dike <jdike@addtoit.com>, Vivek Goyal <vgoyal@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Eric Van Hensbergen <ericvh@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Jie Deng <jie.deng@intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Oct 13, 2021 at 01:03:46PM +0200, David Hildenbrand wrote:
> On 13.10.21 12:55, Michael S. Tsirkin wrote:
> > This will enable cleanups down the road.
> > The idea is to disable cbs, then add "flush_queued_cbs" callback
> > as a parameter, this way drivers can flush any work
> > queued after callbacks have been disabled.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   arch/um/drivers/virt-pci.c                 | 2 +-
> >   drivers/block/virtio_blk.c                 | 4 ++--
> >   drivers/bluetooth/virtio_bt.c              | 2 +-
> >   drivers/char/hw_random/virtio-rng.c        | 2 +-
> >   drivers/char/virtio_console.c              | 4 ++--
> >   drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
> >   drivers/firmware/arm_scmi/virtio.c         | 2 +-
> >   drivers/gpio/gpio-virtio.c                 | 2 +-
> >   drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
> >   drivers/i2c/busses/i2c-virtio.c            | 2 +-
> >   drivers/iommu/virtio-iommu.c               | 2 +-
> >   drivers/net/caif/caif_virtio.c             | 2 +-
> >   drivers/net/virtio_net.c                   | 4 ++--
> >   drivers/net/wireless/mac80211_hwsim.c      | 2 +-
> >   drivers/nvdimm/virtio_pmem.c               | 2 +-
> >   drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
> >   drivers/scsi/virtio_scsi.c                 | 2 +-
> >   drivers/virtio/virtio.c                    | 5 +++++
> >   drivers/virtio/virtio_balloon.c            | 2 +-
> >   drivers/virtio/virtio_input.c              | 2 +-
> >   drivers/virtio/virtio_mem.c                | 2 +-
> >   fs/fuse/virtio_fs.c                        | 4 ++--
> >   include/linux/virtio.h                     | 1 +
> >   net/9p/trans_virtio.c                      | 2 +-
> >   net/vmw_vsock/virtio_transport.c           | 4 ++--
> >   sound/virtio/virtio_card.c                 | 4 ++--
> >   26 files changed, 39 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index c08066633023..22c4d87c9c15 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
> >   	int i;
> >           /* Stop all virtqueues */
> > -        vdev->config->reset(vdev);
> > +        virtio_reset_device(vdev);
> >           vdev->config->del_vqs(vdev);
> 
> Nit: virtio_device_reset()?
> 
> Because I see:
> 
> int virtio_device_freeze(struct virtio_device *dev);
> int virtio_device_restore(struct virtio_device *dev);
> void virtio_device_ready(struct virtio_device *dev)
> 
> But well, there is:
> void virtio_break_device(struct virtio_device *dev);

Exactly. I don't know what's best, so I opted for plain english :)


> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
