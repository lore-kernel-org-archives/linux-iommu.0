Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5433C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 22:14:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4298E23A1D
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 22:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4298E23A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7BBF86D50;
	Tue,  8 Dec 2020 22:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgH8eGPgorj1; Tue,  8 Dec 2020 22:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A8C886D4E;
	Tue,  8 Dec 2020 22:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A6CC0893;
	Tue,  8 Dec 2020 22:14:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A1E6C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 22:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5ABDA87591
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 22:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EcJc40BHf+jh for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:14:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 13E6987585
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 22:14:42 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8M9gcj079883;
 Tue, 8 Dec 2020 22:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FKx2Im4t9Wd8aF+D2tVt7Nq1tPyD+KE6DK+9XVHHFdg=;
 b=psR5Nh5i256gDK6BSLNfBCcMc2EKYXHkNCxOq0mTiDDnBobcCZ4j0P7do6N3wUEkhTy3
 X8kzOqaCfc1xdia/Ug9ACqLLRp5qAKFG5aFRAjnG1MK/TMHy/9V6VrTI5J5TPLY/LhHr
 /uQPY0fDpRgIZSRXFnuwdNTIQMGASwDJV7M23iw1a4NyVUfFKrzM5oMQXlVys59kMS6G
 W/xsFpBwJaMMJehDgY5OCFFPt4YIgy3HrvrVgZQvodjyyjEpXAPO71dI+JpFbEOOaDPd
 rBSNp6OMWKdJBwrs1p/Sm2O8+qmONb9B2rH4AAt2VtR4BTQ2IjlhcmhSjspVKa4o14Y+ hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 35825m59dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 08 Dec 2020 22:14:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8MAVEM048505;
 Tue, 8 Dec 2020 22:14:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 358m3ybgbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Dec 2020 22:14:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8MEHad030733;
 Tue, 8 Dec 2020 22:14:18 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 08 Dec 2020 14:14:17 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 542B86A0121; Tue,  8 Dec 2020 17:16:17 -0500 (EST)
Date: Tue, 8 Dec 2020 17:16:17 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
Message-ID: <20201208221617.GA27569@char.us.oracle.com>
References: <20201207214204.1839028-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207214204.1839028-1-jxgao@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080138
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, kbusch@kernel.org, robin.murphy@arm.com,
 hch@lst.de
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

On Mon, Dec 07, 2020 at 01:42:04PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
> booting with --swiotlb=force option and using NVMe as interface,
> running mkfs.xfs on Rhel fails because of the unalignment issue.
> This patch makes sure the mapped data preserves
> its offset of the orginal address. Tested on latest kernel that
> this patch fixes the issue.

Lets reword this comment a bit more since you are not providing
the RHEL Bug, and instead are focusing on the upstream kernel.

I can do that for you..

> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/swiotlb.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 781b9dca197c..56a35e71b3fd 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	max_slots = mask + 1
>  		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
>  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> + 
> +	/*
> +	 * We need to keep the offset when mapping, so adding the offset
> +	 * to the total set we need to allocate in SWIOTLB
> +	 */
> +	alloc_size += offset_in_page(orig_addr);
>  
>  	/*
>  	 * For mappings greater than or equal to a page, we limit the stride
> @@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>  	 */
>  	for (i = 0; i < nslots; i++)
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	/*
> +	 * When keeping the offset of the original data, we need to advance
> +	 * the tlb_addr by the offset of orig_addr.
> +	 */
> +	tlb_addr += orig_addr & (PAGE_SIZE - 1);
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> -- 
> 2.27.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
