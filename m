Return-Path: <SRS0=kesm=FP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B9C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 20:40:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EF82404C
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 20:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EF82404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A13418760D;
	Fri, 11 Dec 2020 20:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKbKQgepXFyi; Fri, 11 Dec 2020 20:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB9DB875FF;
	Fri, 11 Dec 2020 20:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81C11C0FA7;
	Fri, 11 Dec 2020 20:40:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFB6EC013B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 20:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A6CE22041B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 20:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KVpvLgCSukte for <iommu@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 20:40:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by silver.osuosl.org (Postfix) with ESMTPS id 53FD4203F7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 20:40:02 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBKddHG009641;
 Fri, 11 Dec 2020 20:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VJbiclNNRWf5xTx/cOG6L27Mu0uBf4+urMq60QMEkZQ=;
 b=EhOUs7gvrNa7q1zY28PdvyObjpDx8qFhEnpy2F605x0pZuZtUv+42KWiJtC6ZMKWv9a0
 Xr/nOmQpZQvZo/sWi0tgNYeJeIwcpPDwvyD6wOafFilC3nMaiNCdxiEiNV6wQLxIo0X9
 BbU4u9pMbDM384jdixZPCf49MBVF8gdHprFGbWSBLjeDpGVtry/JLgse83r1szQHNSkb
 Ve3zB63J1/Il4cbGcfsH4IwrFraBJl2TqYJa7NpQxumNKExcPVBkv7pIOd30PpP2Zlxa
 yeaQeoR+7n2TxaZozPONQTWyz3NZa5ELk2J30zFH4YLj+O2RhSiCgP45pdrPxQwzedTl NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 357yqccqcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Dec 2020 20:39:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBKFt9q027268;
 Fri, 11 Dec 2020 20:37:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 358m54hysd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Dec 2020 20:37:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BBKbZ4E006505;
 Fri, 11 Dec 2020 20:37:36 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 11 Dec 2020 12:37:35 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 309196A0121; Fri, 11 Dec 2020 15:39:38 -0500 (EST)
Date: Fri, 11 Dec 2020 15:39:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
Message-ID: <20201211203938.GA16598@char.us.oracle.com>
References: <20201207214204.1839028-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207214204.1839028-1-jxgao@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110136
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
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

This breaks DHCP with upstream kernel (applied this on top v5.10-rc7)
and used swiotlb=262144,force and now the dhclient is not working:

[  119.300502] bnxt_en 0000:3b:00.0 eno2np0: NIC Link is Up, 25000 Mbps full duplex, Flow control: ON - receive & transmit
[  119.437573] bnxt_en 0000:3b:00.0 eno2np0: FEC autoneg off encoding: None
[   90.064220] dracut-initqueue[1477]: Warning: dhcp for interface eno2np0 failed
[  101.155295] dracut-initqueue[1477]: Warning: dhcp for interfa[  142.361359] bnxt_en 0000:3b:00.1 eno3np1: NIC Link is Up, 25000 Mbps full duplex, Flow control: ON - receive & transmit
ce eno2np0 faile[  142.501860] bnxt_en 0000:3b:00.1 eno3np1: FEC autoneg off encoding: None
d
[  113.054108] dracut-initqueue[1477]: Warning: dhcp for interface eno3np1 failed
[  123.867108] dracut-initqueue[1477]: Warning: dhcp for interface eno3np1 failed
[  251.888002] dracut-initqueue[1477]: Warning: dracut-initqueue timeout - starting timeout scripts

Dropping from linux-next.

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
