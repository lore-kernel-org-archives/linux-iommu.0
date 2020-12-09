Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75311C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 07:00:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D4923A5A
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 07:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D4923A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EA9A8777E;
	Wed,  9 Dec 2020 07:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWsL-e64ygUS; Wed,  9 Dec 2020 07:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D424387770;
	Wed,  9 Dec 2020 07:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7060C0FA7;
	Wed,  9 Dec 2020 07:00:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CE29C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 07:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2D7DD8777D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 07:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hKDaBRO1htgd for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 07:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 435CC87770
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 07:00:43 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96sh5k060236;
 Wed, 9 Dec 2020 07:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TIkNj/A5MlMYxQZGoSiFLVAsnvXQ9n2Hc4N8WiZ3ahk=;
 b=WR6ScYikqTBvXzoP0OLQjXtE1+L6qWdEKJaOy0TfsamtkvMYgN1b5rJ+CA9RpWn8UUUc
 XmHks4l0ZsFuB6xKq6Bc4LEJ2KlZ/7fRrT5ymUhYxb8ZMyjlpafYgr30VAOMnnzWQcpk
 j/5dJkpTRO7nskYCSFY46wWkubZY/DwMUMw0q7Lv+DVxjXHmSgJ3aN5nlApanX/nV10G
 6tJWdAZBkzc9IuXCFmJEb8OrggvGv6loIB3TlWMvFSPD+PNjnK6/sJWjsIg3iM0BanM5
 pZRLVzx97/ZFZjK1AJU7BB2QpzkWQz20fDN+JZChWsMnJYALEu+Bp1ZaOasCQe2RUoHR Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 3581mqxg6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Dec 2020 07:00:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96uWIk157820;
 Wed, 9 Dec 2020 07:00:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 358m3ytwgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Dec 2020 07:00:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B970Umo011922;
 Wed, 9 Dec 2020 07:00:32 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 08 Dec 2020 23:00:29 -0800
Date: Wed, 9 Dec 2020 10:00:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: song.bao.hua@hisilicon.com
Subject: [bug report] dma-mapping: add benchmark support for streaming DMA APIs
Message-ID: <X9B2B4zgzFwpqVcM@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090047
Cc: iommu@lists.linux-foundation.org
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

Hello Barry Song,

The patch 65789daa8087: "dma-mapping: add benchmark support for
streaming DMA APIs" from Nov 16, 2020, leads to the following static
checker warning:

	kernel/dma/map_benchmark.c:241 map_benchmark_ioctl()
	error: undefined (user controlled) shift '1 << (map->bparam.dma_bits)'

kernel/dma/map_benchmark.c
   191  static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
   192                  unsigned long arg)
   193  {
   194          struct map_benchmark_data *map = file->private_data;
   195          void __user *argp = (void __user *)arg;
   196          u64 old_dma_mask;
   197  
   198          int ret;
   199  
   200          if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
                                   ^^^^^^^^^^^^^
Comes from the user

   201                  return -EFAULT;
   202  
   203          switch (cmd) {
   204          case DMA_MAP_BENCHMARK:
   205                  if (map->bparam.threads == 0 ||
   206                      map->bparam.threads > DMA_MAP_MAX_THREADS) {
   207                          pr_err("invalid thread number\n");
   208                          return -EINVAL;
   209                  }
   210  
   211                  if (map->bparam.seconds == 0 ||
   212                      map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
   213                          pr_err("invalid duration seconds\n");
   214                          return -EINVAL;
   215                  }
   216  
   217                  if (map->bparam.node != NUMA_NO_NODE &&
   218                      !node_possible(map->bparam.node)) {
   219                          pr_err("invalid numa node\n");
   220                          return -EINVAL;
   221                  }
   222  
   223                  switch (map->bparam.dma_dir) {
   224                  case DMA_MAP_BIDIRECTIONAL:
   225                          map->dir = DMA_BIDIRECTIONAL;
   226                          break;
   227                  case DMA_MAP_FROM_DEVICE:
   228                          map->dir = DMA_FROM_DEVICE;
   229                          break;
   230                  case DMA_MAP_TO_DEVICE:
   231                          map->dir = DMA_TO_DEVICE;
   232                          break;
   233                  default:
   234                          pr_err("invalid DMA direction\n");
   235                          return -EINVAL;
   236                  }
   237  
   238                  old_dma_mask = dma_get_mask(map->dev);
   239  
   240                  ret = dma_set_mask(map->dev,
   241                                     DMA_BIT_MASK(map->bparam.dma_bits));
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If this is more than 31 then the behavior is undefined (but in real life
it will shift wrap).

   242                  if (ret) {
   243                          pr_err("failed to set dma_mask on device %s\n",
   244                                  dev_name(map->dev));
   245                          return -EINVAL;
   246                  }
   247  
   248                  ret = do_map_benchmark(map);
   249  
   250                  /*
   251                   * restore the original dma_mask as many devices' dma_mask are
   252                   * set by architectures, acpi, busses. When we bind them back
   253                   * to their original drivers, those drivers shouldn't see
   254                   * dma_mask changed by benchmark
   255                   */
   256                  dma_set_mask(map->dev, old_dma_mask);
   257                  break;
   258          default:
   259                  return -EINVAL;
   260          }
   261  
   262          if (copy_to_user(argp, &map->bparam, sizeof(map->bparam)))
   263                  return -EFAULT;
   264  
   265          return ret;
   266  }

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
