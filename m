Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D2EC2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FB9206B6
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8mQlTFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FB9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B6C322047F;
	Wed, 12 Feb 2020 13:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwufHBzF64mK; Wed, 12 Feb 2020 13:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C5376203D9;
	Wed, 12 Feb 2020 13:48:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1292C07FE;
	Wed, 12 Feb 2020 13:48:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A26C0177
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3EF012047F
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lArIDdzR8tCC for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 13:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id 380A0203D9
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:48:25 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CDWffm128144;
 Wed, 12 Feb 2020 13:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=XOBpNC2vaxv98JUwiiK/tuD55VV4tZ9KF2/KTnm016Q=;
 b=G8mQlTFUl3p1533mJpIYFiQcKIbuS7u/2VU193gjgxKUNqvqETvB1EuyrJIGJyaGUJp5
 kuQ+Ro6tGIbzcefVub3rjN1QdRp7YN561IcYs2zZnKL3GpmWrm/wBHQ+D+orJ5b1qpzU
 SDdHWe6H7r3HbbB4aAzTBIaPdwVBwJk96tM2GdkU7jQ90Egn6vdbntPjyxtlabIcYF62
 BnkpPV4yk0EZR9D2PuKhDM2mfoMCW8uUCZ67zUxnVHiC8cjT9PLzu1DnlMXNqVspzp1a
 2DuxQtbyjqSBg0sTIRm3yXOiS34/9MPcp4AmL/61AW4GQUsGcGZnFCeB9RSr/ZP78g4K Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2y2jx6aquk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Feb 2020 13:48:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CDWF87060435;
 Wed, 12 Feb 2020 13:48:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2y26hx022n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2020 13:48:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CDmLNF029403;
 Wed, 12 Feb 2020 13:48:21 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Feb 2020 05:48:21 -0800
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping imbalance
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
Date: Wed, 12 Feb 2020 08:48:20 -0500
Message-Id: <869DC73D-190E-46AB-B8F8-1A394F92AF41@oracle.com>
References: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
To: Andre Tomt <andre@tomt.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120108
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 iommu@lists.linux-foundation.org
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



> On Feb 12, 2020, at 8:43 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> The @nents value that was passed to ib_dma_map_sg() has to be passed
> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> concatenate sg entries, it will return a different nents value than
> it was passed.
> 
> The bug was exposed by recent changes to the AMD IOMMU driver, which
> enabled sg entry concatenation.
> 
> Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
> memory registration API") and reviewing other kernel ULPs, it's not
> clear that the frwr_map() logic was ever correct for this case.
> 
> Reported-by: Andre Tomt <andre@tomt.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/trace/events/rpcrdma.h |    6 ++++--
> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
> 2 files changed, 11 insertions(+), 8 deletions(-)
> 
> Hi Andre, here's take 2, based on the trace data you sent me.
> Please let me know if this one fares any better.
> 
> Changes since v1:
> - Ensure the correct nents value is passed to ib_map_mr_sg
> - Record the mr_nents value in the MR trace points
> 
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index c0e4c93324f5..023c5da45999 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -275,6 +275,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
> 
> 	TP_STRUCT__entry(
> 		__field(const void *, mr)
> +		__field(unsigned int, nents)
> 		__field(u32, handle)
> 		__field(u32, length)
> 		__field(u64, offset)
> @@ -283,14 +284,15 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
> 
> 	TP_fast_assign(
> 		__entry->mr = mr;
> +		__entry->nents = mr->mr_nents;
> 		__entry->handle = mr->mr_handle;
> 		__entry->length = mr->mr_length;
> 		__entry->offset = mr->mr_offset;
> 		__entry->dir    = mr->mr_dir;
> 	),
> 
> -	TP_printk("mr=%p %u@0x%016llx:0x%08x (%s)",
> -		__entry->mr, __entry->length,
> +	TP_printk("mr=%p %d %u@0x%016llx:0x%08x (%s)",
> +		__entry->mr, __entry->mr_nents, __entry->length,

This should be:
		__entry->mr, __entry->nents, __entry->length,

Sorry about that.


> 		(unsigned long long)__entry->offset, __entry->handle,
> 		xprtrdma_show_direction(__entry->dir)
> 	)
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 095be887753e..75617646702b 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -288,8 +288,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
> {
> 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
> 	struct ib_reg_wr *reg_wr;
> +	int i, n, dma_nents;
> 	struct ib_mr *ibmr;
> -	int i, n;
> 	u8 key;
> 
> 	if (nsegs > ia->ri_max_frwr_depth)
> @@ -313,15 +313,16 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
> 			break;
> 	}
> 	mr->mr_dir = rpcrdma_data_dir(writing);
> +	mr->mr_nents = i;
> 
> -	mr->mr_nents =
> -		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
> -	if (!mr->mr_nents)
> +	dma_nents = ib_dma_map_sg(ia->ri_id->device, mr->mr_sg,
> +				  mr->mr_nents, mr->mr_dir);
> +	if (!dma_nents)
> 		goto out_dmamap_err;
> 
> 	ibmr = mr->frwr.fr_mr;
> -	n = ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, PAGE_SIZE);
> -	if (unlikely(n != mr->mr_nents))
> +	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
> +	if (n != dma_nents)
> 		goto out_mapmr_err;
> 
> 	ibmr->iova &= 0x00000000ffffffff;
> 
> 

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
