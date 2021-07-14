Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62761C11F66
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:48:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0768B613B7
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 05:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0768B613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6AB54027A;
	Wed, 14 Jul 2021 05:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KuD1eZ0hFEdP; Wed, 14 Jul 2021 05:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 828A840104;
	Wed, 14 Jul 2021 05:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50B2EC001A;
	Wed, 14 Jul 2021 05:48:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B10C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAB7A83B87
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ADc39QPllO3 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 05:48:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF32583B88
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 05:48:24 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id l1so1440849edr.11
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ISPhdRd7kgRF131of+I49P7OQzeT4zgllEAZ6yc66Cw=;
 b=CRCCf/8GTFicMvq9b/39MqKOLA4VR5W/ygtwaJLI0t2FCj5mbGw+0F5fvOpYhQBlrp
 mnWkMFmm1NRwvDJrruNdW/yFacogODt3bCpAldP7YRcTEBrB9r1iBC2NjEl0kUTRdDqQ
 1LDJkNtefZh3Inp027Damv068boUObxXQE1Pm1ikQNRrKOn0QiMcT+UqofXREN+wn0AY
 Qwlp4lF5HnpBmLE3ay7KGuePAPoflcJyMWHPJ6Bnc8lPzXEAzgnhzHTc+Z5cugll/6CO
 prP+98aaVF7nhR72k5BdnaouBNhEtSUaq/qfnkjt1V52oVKY2JDemFXyTzCt7m8WNALL
 Fl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ISPhdRd7kgRF131of+I49P7OQzeT4zgllEAZ6yc66Cw=;
 b=W4J949q44ekUgOqabzy48zyXdgfRfwNqYWVFEKUy9uFr48SAqeEbJG00MsRw3wsn3l
 toxxOfY2n3JND8qhso8lvB5Qbr27Hp/xlKDAit03biCxwwraPQlnQFjBvbU51thh7U81
 nRVpCMMBAS7YMfeSN9xBHHulZSwHJgdcuQ0MnJjHoermMaYxEXyTxvRNF6uf0vCtig6+
 HwrhiyZsIgtLZy2fUdqm0flcyc/R4SIEaSJ2+pvr8/kcF3HN/J01oOUkvm1LkByj6U5i
 aU96FDMYyRffYs/bROBdWcPlyPmcAquXjvpaNsgKwokbsClNQ5OsyVYkSIm+Klu27Fei
 J+Iw==
X-Gm-Message-State: AOAM533CwLY28A6CcsQwW/5rNA2u6UzNH63m60f4EA1+qUFmZPyBRJtm
 Z7j8tmMBasYB2R1EyeWo569zCJSyISqKe8rF3xfD
X-Google-Smtp-Source: ABdhPJxXeEP7t8zpZ7c72shHdFobOH14/MjRGIjC6cNWOwN1I+LFplaCEgLfUWMkJbOdheWG/GEx1jYGgqe4NN7VDzo=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr10892387edu.253.1626241703073; 
 Tue, 13 Jul 2021 22:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-4-xieyongji@bytedance.com>
 <8aa028a0117ecb51d209861f926a84ce74fe0c46.camel@perches.com>
In-Reply-To: <8aa028a0117ecb51d209861f926a84ce74fe0c46.camel@perches.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 14 Jul 2021 13:48:12 +0800
Message-ID: <CACycT3t99LoN86KH2Hz38ZnqdgsV4tt4UGNB4QqOvX40Xji5vA@mail.gmail.com>
Subject: Re: [PATCH v9 03/17] vdpa: Fix code indentation
To: Joe Perches <joe@perches.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
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

On Wed, Jul 14, 2021 at 12:20 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-07-13 at 16:46 +0800, Xie Yongji wrote:
> > Use tabs to indent the code instead of spaces.
>
> There are a lot more of these in this file.
>
> $ ./scripts/checkpatch.pl --fix-inplace --strict include/linux/vdpa.h
>
> and a little typing gives:
> ---
>  include/linux/vdpa.h | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3357ac98878d4..14cd4248e59fd 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
>   * @last_used_idx: used index
>   */
>  struct vdpa_vq_state_packed {
> -        u16    last_avail_counter:1;
> -        u16    last_avail_idx:15;
> -        u16    last_used_counter:1;
> -        u16    last_used_idx:15;
> +       u16     last_avail_counter:1;
> +       u16     last_avail_idx:15;
> +       u16     last_used_counter:1;
> +       u16     last_used_idx:15;
>  };
>
>  struct vdpa_vq_state {
> -     union {
> -          struct vdpa_vq_state_split split;
> -          struct vdpa_vq_state_packed packed;
> -     };
> +       union {
> +               struct vdpa_vq_state_split split;
> +               struct vdpa_vq_state_packed packed;
> +       };
>  };
>
>  struct vdpa_mgmt_dev;
> @@ -131,7 +131,7 @@ struct vdpa_iova_range {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             @state: pointer to returned state (last_avail_idx)
> - * @get_vq_notification:       Get the notification area for a virtqueue
> + * @get_vq_notification:       Get the notification area for a virtqueue
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the notifcation area
> @@ -277,13 +277,13 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>                                         const struct vdpa_config_ops *config,
>                                         size_t size, const char *name);
>
> -#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
> -                         container_of(__vdpa_alloc_device( \
> -                                      parent, config, \
> -                                      sizeof(dev_struct) + \
> -                                      BUILD_BUG_ON_ZERO(offsetof( \
> -                                      dev_struct, member)), name), \
> -                                      dev_struct, member)
> +#define vdpa_alloc_device(dev_struct, member, parent, config, name)    \
> +       container_of(__vdpa_alloc_device(parent, config,                \
> +                                        sizeof(dev_struct) +           \
> +                                        BUILD_BUG_ON_ZERO(offsetof(dev_struct, \
> +                                                                   member)), \
> +                                        name),                         \
> +                    dev_struct, member)
>
>  int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
>  void vdpa_unregister_device(struct vdpa_device *vdev);
> @@ -308,8 +308,8 @@ struct vdpa_driver {
>  int __vdpa_register_driver(struct vdpa_driver *drv, struct module *owner);
>  void vdpa_unregister_driver(struct vdpa_driver *drv);
>
> -#define module_vdpa_driver(__vdpa_driver) \
> -       module_driver(__vdpa_driver, vdpa_register_driver,      \
> +#define module_vdpa_driver(__vdpa_driver)                              \
> +       module_driver(__vdpa_driver, vdpa_register_driver,              \
>                       vdpa_unregister_driver)
>
>  static inline struct vdpa_driver *drv_to_vdpa(struct device_driver *driver)
> @@ -339,25 +339,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>
>  static inline void vdpa_reset(struct vdpa_device *vdev)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         vdev->features_valid = false;
> -        ops->set_status(vdev, 0);
> +       ops->set_status(vdev, 0);
>  }
>
>  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         vdev->features_valid = true;
> -        return ops->set_features(vdev, features);
> +       return ops->set_features(vdev, features);
>  }
>
> -
> -static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
> +static inline void vdpa_get_config(struct vdpa_device *vdev,
> +                                  unsigned int offset,
>                                    void *buf, unsigned int len)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         /*
>          * Config accesses aren't supposed to trigger before features are set.
>
>

Oh, yes. I miss that. Thanks for the reminder!

Will fix it in the next version.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
