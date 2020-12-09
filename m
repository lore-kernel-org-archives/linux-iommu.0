Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B9DC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 10:07:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAC423444
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 10:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAC423444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B87C870BD;
	Wed,  9 Dec 2020 10:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RMcBAWcMAHz; Wed,  9 Dec 2020 10:06:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB2568701E;
	Wed,  9 Dec 2020 10:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6CA0C0893;
	Wed,  9 Dec 2020 10:06:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9D0BC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A50CC86B1A
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vq5RtBChPx-A for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 10:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D063D86D54
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 10:06:56 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B99xKQq101658;
 Wed, 9 Dec 2020 10:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=M7qjw2C75Ov4gcxa7058ZSju4WDFDIejhKPdQP0ooLc=;
 b=ZlXhlFI7u6J7i5Kk7xuSTME0J07BVGGdR2CDaj6VGsVL62U5fsX+TQ0wKbH+J4WtTr/g
 CLIXRoO/rETryaMC7vfcYT8BjDB2nOohWeTuw4+uU2lgaIlwGOsh6FD3V9q8EASRi6MD
 F1f+CuKM6Nd+7IrO6d63G9QqKBI5uoHFNxSpwobZxH09BnZx4jU97wMd5DVfu6kWBdXl
 EKhK1kJHZYgOA+ZosDNyRbrzXOgnE0VyFupkYVjv02aJABRfDvGLvDOYhDL0ofzb9FYB
 iiUWnkxrtzNrtC5a9lL3LsGRRauD4LhVviUlHSjveEsBpZkZpEXi0KcZWUMSosBMqOcB +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 35825m7bum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 09 Dec 2020 10:06:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9A5ldF165797;
 Wed, 9 Dec 2020 10:06:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 358m50add7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Dec 2020 10:06:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9A6jvl011851;
 Wed, 9 Dec 2020 10:06:47 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 09 Dec 2020 02:06:45 -0800
Date: Wed, 9 Dec 2020 13:06:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [bug report] dma-mapping: add benchmark support for streaming
 DMA APIs
Message-ID: <20201209100638.GF2789@kadam>
References: <X9B2B4zgzFwpqVcM@mwanda>
 <7fb15705e0bd40cca7aee930dd6674d3@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7fb15705e0bd40cca7aee930dd6674d3@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090068
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

On Wed, Dec 09, 2020 at 10:01:49AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Wednesday, December 9, 2020 8:00 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: iommu@lists.linux-foundation.org
> > Subject: [bug report] dma-mapping: add benchmark support for streaming DMA APIs
> > 
> > Hello Barry Song,
> > 
> > The patch 65789daa8087: "dma-mapping: add benchmark support for
> > streaming DMA APIs" from Nov 16, 2020, leads to the following static
> > checker warning:
> > 
> > 	kernel/dma/map_benchmark.c:241 map_benchmark_ioctl()
> > 	error: undefined (user controlled) shift '1 << (map->bparam.dma_bits)'
> > 
> > kernel/dma/map_benchmark.c
> >    191  static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
> >    192                  unsigned long arg)
> >    193  {
> >    194          struct map_benchmark_data *map = file->private_data;
> >    195          void __user *argp = (void __user *)arg;
> >    196          u64 old_dma_mask;
> >    197
> >    198          int ret;
> >    199
> >    200          if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
> >                                    ^^^^^^^^^^^^^
> > Comes from the user
> > 
> >    201                  return -EFAULT;
> >    202
> >    203          switch (cmd) {
> >    204          case DMA_MAP_BENCHMARK:
> >    205                  if (map->bparam.threads == 0 ||
> >    206                      map->bparam.threads > DMA_MAP_MAX_THREADS) {
> >    207                          pr_err("invalid thread number\n");
> >    208                          return -EINVAL;
> >    209                  }
> >    210
> >    211                  if (map->bparam.seconds == 0 ||
> >    212                      map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
> >    213                          pr_err("invalid duration seconds\n");
> >    214                          return -EINVAL;
> >    215                  }
> >    216
> >    217                  if (map->bparam.node != NUMA_NO_NODE &&
> >    218                      !node_possible(map->bparam.node)) {
> >    219                          pr_err("invalid numa node\n");
> >    220                          return -EINVAL;
> >    221                  }
> >    222
> >    223                  switch (map->bparam.dma_dir) {
> >    224                  case DMA_MAP_BIDIRECTIONAL:
> >    225                          map->dir = DMA_BIDIRECTIONAL;
> >    226                          break;
> >    227                  case DMA_MAP_FROM_DEVICE:
> >    228                          map->dir = DMA_FROM_DEVICE;
> >    229                          break;
> >    230                  case DMA_MAP_TO_DEVICE:
> >    231                          map->dir = DMA_TO_DEVICE;
> >    232                          break;
> >    233                  default:
> >    234                          pr_err("invalid DMA direction\n");
> >    235                          return -EINVAL;
> >    236                  }
> >    237
> >    238                  old_dma_mask = dma_get_mask(map->dev);
> >    239
> >    240                  ret = dma_set_mask(map->dev,
> >    241                                     DMA_BIT_MASK(map->bparam.dma_bits));
> >                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > If this is more than 31 then the behavior is undefined (but in real life
> > it will shift wrap).
> 
> Guess it should be less than 64?
> For 64, it would be ~0ULL, otherwise, it will be 1ULL<<n-1

Yeah.  You're right > 64 is undefined, not 31 as I said.

> 
> In test app,
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7679325702 
> 
> I have some code like:
> +	/* suppose the mininum DMA zone is 1MB in the world */
> +	if (bits < 20 || bits > 64) {
> +		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
> +		exit(1);
> +	}
> 
> Maybe I should do the same thing in kernel as well.

Sounds good!

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
