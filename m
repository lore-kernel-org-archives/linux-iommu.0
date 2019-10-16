Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0034FA372A
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 18:34:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0FC21D7A
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 18:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LrvFbN0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0FC21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F09A5C74;
	Wed, 16 Oct 2019 18:34:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 85622BA4
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 18:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 247BB7D2
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 18:34:00 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x9GIJ6cJ128782; Wed, 16 Oct 2019 18:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : mime-version : content-type; s=corp-2019-08-05;
	bh=txsVBU78ojg1jqvMCuUzB/UqscjHi7ocJoDIdNFcWVE=;
	b=LrvFbN0ILW9dYpqKw7Kw1crNjy5KYX3o9sfQT1uE2+YbDoelbGeaL1CUDKmItZVpziTh
	TNreywcsIs/WoAV0cl+RNHcM2kXCe/OFavhh/KmFQpFFd8+7I83Xz2IeDn37d38yU2tG
	FxhhR1hVTJw48Je5n1F4e9VC0M4I4nKheb5/AvnqM7JVhdLq4nw/uR8s/Js386vfBu5R
	3lgxnmlGd7oUJwWh79YHFurzQMHJa6w5BFZNiq/ZGh8L0Eu5rP5zL+zkufEJ7x/nTpEk
	WNAyJYVgzQOWDwUp0Z/EvfYRCO7/D+f8CMMLQukoVP1INzEUVtcV6oBb9tE7x9CDZLmC
	TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 2vk6sqs0th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2019 18:33:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x9GII9YD121520; Wed, 16 Oct 2019 18:33:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 2vnxva927x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2019 18:33:59 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GIXvM2003194;
	Wed, 16 Oct 2019 18:33:58 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Oct 2019 18:33:57 +0000
Date: Wed, 16 Oct 2019 21:33:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jroedel@suse.de
Subject: [bug report] iommu/amd: Pass gfp-flags to iommu_map_page()
Message-ID: <20191016183350.GA16377@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412
	signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=408
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1908290000 definitions=main-1910160151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412
	signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=486
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
	definitions=main-1910160151
Cc: iommu@lists.linux-foundation.org
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

Hello Joerg Roedel,

The patch b911b89b6d01: "iommu/amd: Pass gfp-flags to
iommu_map_page()" from Jul 5, 2016, leads to the following static
checker warning:

	drivers/iommu/amd_iommu.c:2545 amd_iommu_map()
	warn: use 'gfp' here instead of GFP_XXX?

drivers/iommu/amd_iommu.c
  2529  static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
  2530                           phys_addr_t paddr, size_t page_size, int iommu_prot,
  2531                           gfp_t gfp)
                                 ^^^^^^^^^
I don't know why I'm suddenly getting this warning even though the code
is three years old...

  2532  {
  2533          struct protection_domain *domain = to_pdomain(dom);
  2534          int prot = 0;
  2535          int ret;
  2536  
  2537          if (domain->mode == PAGE_MODE_NONE)
  2538                  return -EINVAL;
  2539  
  2540          if (iommu_prot & IOMMU_READ)
  2541                  prot |= IOMMU_PROT_IR;
  2542          if (iommu_prot & IOMMU_WRITE)
  2543                  prot |= IOMMU_PROT_IW;
  2544  
  2545          ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
                                                                           ^^^^^^^^^^
But it does seem like maybe gfp was intended here?

  2546  
  2547          domain_flush_np_cache(domain, iova, page_size);
  2548  
  2549          return ret;
  2550  }

See also:
drivers/iommu/dma-iommu.c:625 iommu_dma_alloc_remap() warn: use 'gfp' here instead of GFP_XXX?


regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
