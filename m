Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6C3C2D
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 12:45:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id v7so9596388wmn.0
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 04:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IV6joo5swjIJ7Qz4dnFwthREitc1EDnaiNatMyucR3o=;
        b=lbXDZukmc95YXe3tijSl/lIlK7YT2yqLg0vLpXJrHn8RnBag6eC4NOcYjP/dIbHHZ7
         a/TSYcwOXsT0n2mVJ/h7YlnFlaJ3KSmHvETqnMwKqXhoojha9joQDOiClWbJuAF0WvlY
         H3Fs/Pd2gzXfJmDi/vkhi41PP1qJt+pAr1QhJL33QhFDIhiF1EeZYskLV3LdbFRD6LJD
         dEieLynRWU1Ho8qMeK3UqQyHtqpS6YYK3BJYf3APc4Y7Qwqik7QNdWdIgbQkMLNwKZnq
         sOC+HTYLEHLSNdZLNv922lT5RUWiEE+B4yrQajExJjk2H6it7rULl+U3a6itTDlUfpcL
         wKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV6joo5swjIJ7Qz4dnFwthREitc1EDnaiNatMyucR3o=;
        b=FBCDtoYcDEX+l9ogRm9BAsovXh+vokj275FC8g4JFTchdAWM80sNLGUxdTEPSR19hh
         zVAHK/HZv6iyPvFAP57G+HDTUXoKnhqwEstAsvCYvOXjQVmd5oisphIM/j5c57ACoLT9
         lpA7R9dtk2fvJSWEwMQu6/WE1H0UJvWJlAVZLN/YRcTCipToNHrO0siClJ5Bz2MDdXqu
         Q06SR0alp5kkl4QUzq77QSWaPsvdp6QT5qX9M/CJkVGmogUiWaPbToyVVShf79DRZIDN
         oMnpLjrJK14/otNA/nUQoaV4sWe++NTrd7L9cNRUJZdasDSv2dDc3XpXRNpVnlRVES4L
         tzMQ==
X-Gm-Message-State: ANoB5plagp1Byqk+p1DICoOo4UOx1R+M0q84fqRdwh707oDpFESp60Ey
	Tj/GkRDU2pA2i7xviNWNhCI=
X-Google-Smtp-Source: AA0mqf4HWInMzJzxeHF0TK7a1v387boolNlig/Uk+g0dbIcX4OoT9mkm3+108jPbEuXpMT3L1xmzqg==
X-Received: by 2002:a05:600c:2190:b0:3cf:8b23:549c with SMTP id e16-20020a05600c219000b003cf8b23549cmr1314941wme.174.1668516303746;
        Tue, 15 Nov 2022 04:45:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d550b000000b0023659925b2asm12094074wrv.51.2022.11.15.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:45:03 -0800 (PST)
Date: Tue, 15 Nov 2022 15:45:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: jgg@ziepe.ca
Cc: iommu@lists.linux.dev
Subject: [bug report] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2Nhj0mIjrSJwO7W@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Resending two weeks of email because mutt + msmtp has been silently
  eating my outgoing mail instead of delivering it.  *sigh* -dan ]

Hello Jason Gunthorpe,

The patch 32c328dc9b73: "iommufd: vfio container FD ioctl
compatibility" from Dec 15, 2021, leads to the following Smatch
static checker warning:

	drivers/iommu/iommufd/vfio_compat.c:174 iommufd_vfio_unmap_dma()
	warn: potential integer overflow from user (local copy) 'unmap.iova + unmap.size'

drivers/iommu/iommufd/vfio_compat.c
    140 static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
    141                                   void __user *arg)
    142 {
    143         size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
    144         /*
    145          * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
    146          * dirty tracking direction:
    147          *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
    148          *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
    149          */
    150         u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
    151         struct vfio_iommu_type1_dma_unmap unmap;
    152         struct iommufd_ioas *ioas;
    153         unsigned long unmapped;
    154         int rc;
    155 
    156         if (copy_from_user(&unmap, arg, minsz))
    157                 return -EFAULT;
    158 
    159         if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
    160                 return -EINVAL;
    161 
    162         ioas = get_compat_ioas(ictx);
    163         if (IS_ERR(ioas))
    164                 return PTR_ERR(ioas);
    165 
    166         if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
    167                 if (unmap.iova != 0 || unmap.size != 0) {
    168                         rc = -EINVAL;
    169                         goto err_put;
    170                 }
    171                 rc = iopt_unmap_all(&ioas->iopt, &unmapped);
    172         } else {
    173                 if (READ_ONCE(ioas->iopt.disable_large_pages)) {
--> 174                         unsigned long iovas[] = { unmap.iova + unmap.size - 1,

The unmap.iova + unmap.size addition can have an integer overflow.  It's
unclear to me if this is caught later or if it has any negative
implications.

What I remeber from looking at similar code is that because of the - 1,
it's supposed to be allowed to overflow to 0 but not further than that.
In other words the highest allowed value it ULONG_MAX and not
"ULONG_MAX - 1".

    175                                                   unmap.iova - 1 };
    176 
    177                         rc = iopt_cut_iova(&ioas->iopt, iovas,
    178                                            unmap.iova ? 2 : 1);
    179                         if (rc)
    180                                 goto err_put;
    181                 }
    182                 rc = iopt_unmap_iova(&ioas->iopt, unmap.iova, unmap.size,
    183                                      &unmapped);
    184         }
    185         unmap.size = unmapped;
    186         if (copy_to_user(arg, &unmap, minsz))
    187                 rc = -EFAULT;
    188 
    189 err_put:
    190         iommufd_put_object(&ioas->obj);
    191         return rc;
    192 }

regards,
dan carpenter

