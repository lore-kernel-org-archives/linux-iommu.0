Return-Path: <SRS0=x0pP=PB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246DDC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 11:03:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B8F60F23
	for <iommu@archiver.kernel.org>; Wed, 13 Oct 2021 11:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7B8F60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74DF5404CB;
	Wed, 13 Oct 2021 11:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhhWm0Fte3bb; Wed, 13 Oct 2021 11:03:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0241840229;
	Wed, 13 Oct 2021 11:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC25C000F;
	Wed, 13 Oct 2021 11:03:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A4BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 11:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21A51404A9
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 11:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UNrtiLJQ-1yN for <iommu@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:03:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15BCD40229
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634123032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pm2HFBolkPmIutQKtnGVo/TAfScR5edRGy4d25/SdeA=;
 b=KD+D5y+PkswhupKI4VOQaOnKEuL0aMqNbVXb4jdTD/yk8hDkQZlx+7FHmnoJ+lbV37WTzE
 xEQc2FfXE1X0Q4auQ9u3G4Ba2FfjdP8q0Z5E22PxfYNzjaF8ppbeZkvzCaDBUfyJhJGVZH
 yfr9txkvaxa/rd4zUSbTP5m+ZyV9MCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-iYFil7sTPbmSly33frCUng-1; Wed, 13 Oct 2021 07:03:51 -0400
X-MC-Unique: iYFil7sTPbmSly33frCUng-1
Received: by mail-wr1-f70.google.com with SMTP id
 h11-20020adfa4cb000000b00160c791a550so1686725wrb.6
 for <iommu@lists.linux-foundation.org>; Wed, 13 Oct 2021 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pm2HFBolkPmIutQKtnGVo/TAfScR5edRGy4d25/SdeA=;
 b=q5vhlVenuBpETCkJ2hqprFo+QdjTgM+K9IDA4RQg50y1NQYtI2eOPF5tq+w0IsXnRU
 8DYIFMqzXlJ1K+2/4moiarN4uxT0aX27LfYTB8e0aHVCJXNL0rD7baF5zH8uZLBphg2h
 7oJTF6GUF5CrYPdPK2QnoO37IKw6Vs1u5zj8HFKY482Ig/7PCD2r3R6hu1VjK1fMlCxI
 gvchRCJtnYhQ9Oncymz3UIIKgCGjO3QKO/nZRQBnE1Jo1YR87KmBDiTEIdt7CBdfWoD9
 GhaPPNQsvYVNaicSt35ZOfDhbYEBJg1PJyzwj5w5PNS1z3Xo5LI09l3r1DbXK6QrJtou
 jHOg==
X-Gm-Message-State: AOAM531AdaVrdqlTF9JCyROo9ZfN8qUipGi3Uu5dxCUlHvZ004Bk1mNB
 KRKeStTwWboJDdYyvzPrg8oWNzA4RUC10BW2gmVw3Qu1cX+lEygJJmfaapKsuqbedIosi3HqDEH
 Gh8Aiu59uEZoxLvWPlfapRdwy0xnorQ==
X-Received: by 2002:adf:a194:: with SMTP id u20mr39899227wru.275.1634123030390; 
 Wed, 13 Oct 2021 04:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxsxhU5d6LZPZIfUUDegUVRR2UQLEo64TMqEnAh5Ix5FGAFA1VDGCfrTQu99KLNCm64Sq/Q==
X-Received: by 2002:adf:a194:: with SMTP id u20mr39899137wru.275.1634123030054; 
 Wed, 13 Oct 2021 04:03:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6774.dip0.t-ipconnect.de. [91.12.103.116])
 by smtp.gmail.com with ESMTPSA id m4sm5183560wrz.45.2021.10.13.04.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 04:03:49 -0700 (PDT)
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20211013105226.20225-1-mst@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
Date: Wed, 13 Oct 2021 13:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Latchesar Ionkov <lucho@ionkov.net>, nvdimm@lists.linux.dev,
 v9fs-developer@lists.sourceforge.net, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>,
 David Airlie <airlied@linux.ie>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 linux-scsi@vger.kernel.org, Will Deacon <will@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Gonglei <arei.gonglei@huawei.com>, Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Marcel Holtmann <marcel@holtmann.org>, Vivek Goyal <vgoyal@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Eric Van Hensbergen <ericvh@gmail.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Jie Deng <jie.deng@intel.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Wang <jasowang@redhat.com>, linux-wireless@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-i2c@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, iommu@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 13.10.21 12:55, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   arch/um/drivers/virt-pci.c                 | 2 +-
>   drivers/block/virtio_blk.c                 | 4 ++--
>   drivers/bluetooth/virtio_bt.c              | 2 +-
>   drivers/char/hw_random/virtio-rng.c        | 2 +-
>   drivers/char/virtio_console.c              | 4 ++--
>   drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
>   drivers/firmware/arm_scmi/virtio.c         | 2 +-
>   drivers/gpio/gpio-virtio.c                 | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
>   drivers/i2c/busses/i2c-virtio.c            | 2 +-
>   drivers/iommu/virtio-iommu.c               | 2 +-
>   drivers/net/caif/caif_virtio.c             | 2 +-
>   drivers/net/virtio_net.c                   | 4 ++--
>   drivers/net/wireless/mac80211_hwsim.c      | 2 +-
>   drivers/nvdimm/virtio_pmem.c               | 2 +-
>   drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
>   drivers/scsi/virtio_scsi.c                 | 2 +-
>   drivers/virtio/virtio.c                    | 5 +++++
>   drivers/virtio/virtio_balloon.c            | 2 +-
>   drivers/virtio/virtio_input.c              | 2 +-
>   drivers/virtio/virtio_mem.c                | 2 +-
>   fs/fuse/virtio_fs.c                        | 4 ++--
>   include/linux/virtio.h                     | 1 +
>   net/9p/trans_virtio.c                      | 2 +-
>   net/vmw_vsock/virtio_transport.c           | 4 ++--
>   sound/virtio/virtio_card.c                 | 4 ++--
>   26 files changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index c08066633023..22c4d87c9c15 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
>   	int i;
>   
>           /* Stop all virtqueues */
> -        vdev->config->reset(vdev);
> +        virtio_reset_device(vdev);
>           vdev->config->del_vqs(vdev);

Nit: virtio_device_reset()?

Because I see:

int virtio_device_freeze(struct virtio_device *dev);
int virtio_device_restore(struct virtio_device *dev);
void virtio_device_ready(struct virtio_device *dev)

But well, there is:
void virtio_break_device(struct virtio_device *dev);

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
