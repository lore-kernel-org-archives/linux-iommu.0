Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BCC4167B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 10:02:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F623B6B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 10:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F623B6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA4D886FEC;
	Wed,  9 Dec 2020 10:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GWG2nhNLacu; Wed,  9 Dec 2020 10:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F23BA86FBA;
	Wed,  9 Dec 2020 10:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB75AC0893;
	Wed,  9 Dec 2020 10:01:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DFBDC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EEFC86D58
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TwH9bo5g9idb for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 10:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B56D586D53
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:01:53 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CrXcR2NCWzVmpM;
 Wed,  9 Dec 2020 18:00:55 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 9 Dec 2020 18:01:49 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 9 Dec 2020 18:01:49 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 9 Dec 2020 18:01:49 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [bug report] dma-mapping: add benchmark support for streaming DMA
 APIs
Thread-Topic: [bug report] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWzfkFu54k2VgTDEiECE3C/mcTl6nuhSsQ
Date: Wed, 9 Dec 2020 10:01:49 +0000
Message-ID: <7fb15705e0bd40cca7aee930dd6674d3@hisilicon.com>
References: <X9B2B4zgzFwpqVcM@mwanda>
In-Reply-To: <X9B2B4zgzFwpqVcM@mwanda>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.110]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, December 9, 2020 8:00 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org
> Subject: [bug report] dma-mapping: add benchmark support for streaming DMA APIs
> 
> Hello Barry Song,
> 
> The patch 65789daa8087: "dma-mapping: add benchmark support for
> streaming DMA APIs" from Nov 16, 2020, leads to the following static
> checker warning:
> 
> 	kernel/dma/map_benchmark.c:241 map_benchmark_ioctl()
> 	error: undefined (user controlled) shift '1 << (map->bparam.dma_bits)'
> 
> kernel/dma/map_benchmark.c
>    191  static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>    192                  unsigned long arg)
>    193  {
>    194          struct map_benchmark_data *map = file->private_data;
>    195          void __user *argp = (void __user *)arg;
>    196          u64 old_dma_mask;
>    197
>    198          int ret;
>    199
>    200          if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
>                                    ^^^^^^^^^^^^^
> Comes from the user
> 
>    201                  return -EFAULT;
>    202
>    203          switch (cmd) {
>    204          case DMA_MAP_BENCHMARK:
>    205                  if (map->bparam.threads == 0 ||
>    206                      map->bparam.threads > DMA_MAP_MAX_THREADS) {
>    207                          pr_err("invalid thread number\n");
>    208                          return -EINVAL;
>    209                  }
>    210
>    211                  if (map->bparam.seconds == 0 ||
>    212                      map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
>    213                          pr_err("invalid duration seconds\n");
>    214                          return -EINVAL;
>    215                  }
>    216
>    217                  if (map->bparam.node != NUMA_NO_NODE &&
>    218                      !node_possible(map->bparam.node)) {
>    219                          pr_err("invalid numa node\n");
>    220                          return -EINVAL;
>    221                  }
>    222
>    223                  switch (map->bparam.dma_dir) {
>    224                  case DMA_MAP_BIDIRECTIONAL:
>    225                          map->dir = DMA_BIDIRECTIONAL;
>    226                          break;
>    227                  case DMA_MAP_FROM_DEVICE:
>    228                          map->dir = DMA_FROM_DEVICE;
>    229                          break;
>    230                  case DMA_MAP_TO_DEVICE:
>    231                          map->dir = DMA_TO_DEVICE;
>    232                          break;
>    233                  default:
>    234                          pr_err("invalid DMA direction\n");
>    235                          return -EINVAL;
>    236                  }
>    237
>    238                  old_dma_mask = dma_get_mask(map->dev);
>    239
>    240                  ret = dma_set_mask(map->dev,
>    241                                     DMA_BIT_MASK(map->bparam.dma_bits));
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> If this is more than 31 then the behavior is undefined (but in real life
> it will shift wrap).

Guess it should be less than 64?
For 64, it would be ~0ULL, otherwise, it will be 1ULL<<n-1

In test app,
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7679325702

I have some code like:
+	/* suppose the mininum DMA zone is 1MB in the world */
+	if (bits < 20 || bits > 64) {
+		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
+		exit(1);
+	}

Maybe I should do the same thing in kernel as well.

> 
>    242                  if (ret) {
>    243                          pr_err("failed to set dma_mask on device %s\n",
>    244                                  dev_name(map->dev));
>    245                          return -EINVAL;
>    246                  }
>    247
>    248                  ret = do_map_benchmark(map);
>    249
>    250                  /*
>    251                   * restore the original dma_mask as many devices' dma_mask
> are
>    252                   * set by architectures, acpi, busses. When we bind them
> back
>    253                   * to their original drivers, those drivers shouldn't see
>    254                   * dma_mask changed by benchmark
>    255                   */
>    256                  dma_set_mask(map->dev, old_dma_mask);
>    257                  break;
>    258          default:
>    259                  return -EINVAL;
>    260          }
>    261
>    262          if (copy_to_user(argp, &map->bparam, sizeof(map->bparam)))
>    263                  return -EFAULT;
>    264
>    265          return ret;
>    266  }
> 
> regards,
> dan carpenter

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
