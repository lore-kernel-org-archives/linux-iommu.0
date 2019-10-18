Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BACA9EA1
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F0D21897
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xm19njqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F0D21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44F8C1512;
	Fri, 18 Oct 2019 09:28:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 98B54E25
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 09:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 28BC4608
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 09:28:10 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x9I9O9ok079717; Fri, 18 Oct 2019 09:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2019-08-05;
	bh=yqAcSITwDl4ITklXkN8fnCXmwYAZHx33J2/ZPXlncVQ=;
	b=Xm19njqr5T2ptjMqUaRMLj/CUxIY8G4ObTCbomjdBJdBp/txMj8MEfL1dWVGVZDvDbxD
	qxAdjBJMdEkyzbQEUnQwxN1usz3V2+M8kUvHm5tnZTybkaunqpKklAa6g78a5ribp3JY
	tKWpf1dyUVhaRhLh2n2arOT7Z93pGVhB1vT18w5snXelcmwAd9R3U3ryLk5XosY4PemC
	BwvjsIA4C5lYzjaRTqUDCHJ3A5XP47RABWlZs/Secxaa/kL7803duVORbUglfQAN9lhk
	zQq1xMx6ZiKZnA/flPGKFMr5U1mUy8v6NnU14k5vZDDXAn/VKrTo3/YWJrJKtsKkG9yy
	pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2vq0q4aq2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2019 09:28:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x9I9MwhQ138435; Fri, 18 Oct 2019 09:28:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2vq0evy75d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2019 09:28:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I9Rv5u028440;
	Fri, 18 Oct 2019 09:28:00 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 18 Oct 2019 09:27:57 +0000
Date: Fri, 18 Oct 2019 12:27:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Pass gfp flags to iommu_map_page() in
	amd_iommu_map()
Message-ID: <20191018092750.GK21344@kadam>
References: <20191018090736.18819-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018090736.18819-1-joro@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413
	signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1908290000 definitions=main-1910180091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413
	signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
	definitions=main-1910180091
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	linux-kernel@vger.kernel.org
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

Did you get a chance to look at iommu_dma_alloc_remap() as well?

drivers/iommu/dma-iommu.c
   584  static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
   585                  dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
                                                ^^^^^^^^^
   586  {
   587          struct iommu_domain *domain = iommu_get_dma_domain(dev);
   588          struct iommu_dma_cookie *cookie = domain->iova_cookie;
   589          struct iova_domain *iovad = &cookie->iovad;
   590          bool coherent = dev_is_dma_coherent(dev);
   591          int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
   592          pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
   593          unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
   594          struct page **pages;
   595          struct sg_table sgt;
   596          dma_addr_t iova;
   597          void *vaddr;
   598  
   599          *dma_handle = DMA_MAPPING_ERROR;
   600  
   601          if (unlikely(iommu_dma_deferred_attach(dev, domain)))
   602                  return NULL;
   603  
   604          min_size = alloc_sizes & -alloc_sizes;
   605          if (min_size < PAGE_SIZE) {
   606                  min_size = PAGE_SIZE;
   607                  alloc_sizes |= PAGE_SIZE;
   608          } else {
   609                  size = ALIGN(size, min_size);
   610          }
   611          if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
   612                  alloc_sizes = min_size;
   613  
   614          count = PAGE_ALIGN(size) >> PAGE_SHIFT;
   615          pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
   616                                          gfp);
   617          if (!pages)
   618                  return NULL;
   619  
   620          size = iova_align(iovad, size);
   621          iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
   622          if (!iova)
   623                  goto out_free_pages;
   624  
   625          if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
                                                                           ^^^^^^^^^^
gfp here instead of GFP_KERNEL?

   626                  goto out_free_iova;
   627  
   628          if (!(ioprot & IOMMU_CACHE)) {

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
