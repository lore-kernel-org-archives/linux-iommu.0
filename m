Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EC0C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 08:22:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A675620861
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HoOGFZ6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A675620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54287C37;
	Mon, 17 Jun 2019 08:22:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2BADDBDC
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 08:22:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B430C828
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 08:22:47 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5H8EDPq036975; Mon, 17 Jun 2019 08:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=FGXkU7eOmJXcfpTdOS3rFhVnp4//dWioBuU5JvbAozk=;
	b=HoOGFZ6IDRsf/WaCfXo2ZTPgY5pwDJWXjo1xX+qTvLOMlZocWpKu1Sf00Bmkx3VFzyma
	10WCt0cIJkIFz7mHW+wD9GUOEQ0ivHG8jDJ0t4TRvpEWC+TsmSyquhiRY045QRVvKMqd
	BIDabSi8xq4vX0L9MhRibAwTnUvf3DfPIk//8VY7MahBLoeLEZ2KraHUQ39ijiOHMNDT
	8ndBBvPX7iRqpB2l3z33gYX+RiPyyzfIf8yD1/MNNifpDFIZvAldxXl3FHTYVYXdGTMe
	/6jx2aoi8UlUxIMQRg+jUh/JipGQ+5QpEWrsTOM8x9vyDm7cYa5WG5PQ0L40CVIPJPpn
	iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2t4r3td2pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2019 08:22:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5H8LV8W126648; Mon, 17 Jun 2019 08:22:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2t59gd3q66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2019 08:22:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5H8M5I4026605;
	Mon, 17 Jun 2019 08:22:05 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 17 Jun 2019 01:22:05 -0700
Date: Mon, 17 Jun 2019 11:21:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190617082148.GF28859@kadam>
References: <20190614134726.3827-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614134726.3827-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=782
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906170078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9290
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=820
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906170078
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, David Airlie <airlied@linux.ie>,
	linux-media@vger.kernel.org, Intel Linux Wireless <linuxwifi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>, Ian Abbott <abbotti@mev.co.uk>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

I once wrote a Smatch check based on a commit message that said we can't
pass dma_alloc_coherent() pointers to virt_to_phys().  But then I never
felt like I understood the rules enough to actually report the warnings
as bugs.

drivers/platform/x86/dcdbas.c:108 smi_data_buf_realloc() error: 'buf' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/net/caif/caif_virtio.c:414 cfv_create_genpool() error: 'cfv->alloc_addr' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:135 alloc_host_sq() error: 'sq->queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:272 create_qp() error: 'wq->rq.queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/cxgb4/qp.c:2628 alloc_srq_queue() error: 'wq->queue' came from dma_alloc_coherent() so we can't do virt_to_phys()
drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:494 ocrdma_alloc_ucontext() error: 'ctx->ah_tbl.va' came from dma_alloc_coherent() so we can't do virt_to_phys()

drivers/infiniband/hw/cxgb4/qp.c
   129  static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
   130  {
   131          sq->queue = dma_alloc_coherent(&(rdev->lldi.pdev->dev), sq->memsize,
   132                                         &(sq->dma_addr), GFP_KERNEL);
   133          if (!sq->queue)
   134                  return -ENOMEM;
   135          sq->phys_addr = virt_to_phys(sq->queue);
   136          dma_unmap_addr_set(sq, mapping, sq->dma_addr);
   137          return 0;
   138  }

Is this a bug?

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
