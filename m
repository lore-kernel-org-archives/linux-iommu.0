Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB525C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 04:22:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A6C20637
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 04:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A6C20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 44F0A87D09;
	Tue, 10 Dec 2019 04:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6AV8N7+w7cu; Tue, 10 Dec 2019 04:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35DEF87CC9;
	Tue, 10 Dec 2019 04:22:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19EAEC1796;
	Tue, 10 Dec 2019 04:22:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BAC4C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 04:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3491D861CD
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 04:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dqb7XoL0auMy for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 04:22:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 48F5B861A3
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 04:22:50 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
 [147.11.189.41])
 by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id xBA4MW2W014967
 (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
 Mon, 9 Dec 2019 20:22:32 -0800 (PST)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.163]) by
 ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0468.000; Mon, 9
 Dec 2019 20:22:13 -0800
From: "Yin, Xiaotao" <Xiaotao.Yin@windriver.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V2] iommu/iova: Init the struct iova to fix the possible
 memleak
Thread-Topic: [PATCH V2] iommu/iova: Init the struct iova to fix the
 possible memleak
Thread-Index: AQHVrmoGovkLG8aIW0SMwnqXs7DY26eyuH2AgAANI3A=
Date: Tue, 10 Dec 2019 04:22:12 +0000
Message-ID: <47B7036B26F82C43B9F7EAE984D54CB459DCF5@ALA-MBD.corp.ad.wrs.com>
References: <20191209082404.40166-1-xiaotao.yin@windriver.com>
 <977971ed-f77f-847a-89ab-0ddf45abf24d@arm.com>
In-Reply-To: <977971ed-f77f-847a-89ab-0ddf45abf24d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.162.224]
MIME-Version: 1.0
Cc: "Hao, Kexin" <Kexin.Hao@windriver.com>
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
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Tuesday, December 10, 2019 3:34 AM
> To: Yin, Xiaotao <Xiaotao.Yin@windriver.com>; joro@8bytes.org;
> iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org; Hao, Kexin <Kexin.Hao@windriver.com>
> Subject: Re: [PATCH V2] iommu/iova: Init the struct iova to fix the possible
> memleak
> 
> On 09/12/2019 8:24 am, Xiaotao Yin wrote:
> > During ethernet(Marvell octeontx2) set ring buffer test:
> > ethtool -G eth1 rx <rx ring size> tx <tx ring size> following kmemleak
> > will happen sometimes:
> >
> > unreferenced object 0xffff000b85421340 (size 64):
> >    comm "ethtool", pid 867, jiffies 4295323539 (age 550.500s)
> >    hex dump (first 64 bytes):
> >      80 13 42 85 0b 00 ff ff ff ff ff ff ff ff ff ff  ..B.............
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<000000001b204ddf>] kmem_cache_alloc+0x1b0/0x350
> >      [<00000000d9ef2e50>] alloc_iova+0x3c/0x168
> >      [<00000000ea30f99d>] alloc_iova_fast+0x7c/0x2d8
> >      [<00000000b8bb2f1f>] iommu_dma_alloc_iova.isra.0+0x12c/0x138
> >      [<000000002f1a43b5>] __iommu_dma_map+0x8c/0xf8
> >      [<00000000ecde7899>] iommu_dma_map_page+0x98/0xf8
> >      [<0000000082004e59>] otx2_alloc_rbuf+0xf4/0x158
> >      [<000000002b107f6b>] otx2_rq_aura_pool_init+0x110/0x270
> >      [<00000000c3d563c7>] otx2_open+0x15c/0x734
> >      [<00000000a2f5f3a8>] otx2_dev_open+0x3c/0x68
> >      [<00000000456a98b5>] otx2_set_ringparam+0x1ac/0x1d4
> >      [<00000000f2fbb819>] dev_ethtool+0xb84/0x2028
> >      [<0000000069b67c5a>] dev_ioctl+0x248/0x3a0
> >      [<00000000af38663a>] sock_ioctl+0x280/0x638
> >      [<000000002582384c>] do_vfs_ioctl+0x8b0/0xa80
> >      [<000000004e1a2c02>] ksys_ioctl+0x84/0xb8
> >
> > The reason:
> > When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will
> > equal to IOVA_ANCHOR by chance, so when return from
> > __alloc_and_insert_iova_range() with -ENOMEM(iova32_full), the
> new_iova will not be freed in free_iova_mem().
> 
> Ooh, subtle... nice catch!
> 
> I suppose we could also open-code the kmem_cache_free() call in
> alloc_iova() to bypass the check entirely because "we know what we're
> doing", but only if the zeroing proves to have a measurable overhead.
> 
> > Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
> > Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
> > ---
> >   drivers/iommu/iova.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index
> > 41c605b0058f..2c27a661632c 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -233,7 +233,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
> >
> >   struct iova *alloc_iova_mem(void)
> >   {
> > -	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
> > +	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_ZERO);
> 
> FWIW there is a kmem_cache_zalloc() helper, which seems fairly well-
> established. Either way, though,

Yes, zalloc seems neat than this change, I'd like use kmem_cache_zalloc() instead, thank you~
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> >   }
> >   EXPORT_SYMBOL(alloc_iova_mem);
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
