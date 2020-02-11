Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DEC352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:42:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01E220714
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mEVX9xq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01E220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C4DB7204FF;
	Tue, 11 Feb 2020 16:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rGbcwnXw95jw; Tue, 11 Feb 2020 16:42:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E9E30204EC;
	Tue, 11 Feb 2020 16:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3432C1D88;
	Tue, 11 Feb 2020 16:42:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9962EC07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8705B85C28
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIsvc06uQ05H for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 16:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A36A485C1D
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:42:36 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BGcN4Z081966;
 Tue, 11 Feb 2020 16:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=8hVBVLr4EdzkraEAbmtvzBnWFaTaku7CFVgBBHyHQ98=;
 b=mEVX9xq6MzIbvEXKyQYqV28LyqlqVRRHT1IETc+aBGbI9n7zzIn+UPV+6jGxHF+VNDxE
 0DnfBqQdSkajfUhZ1Ml68yRJjLI/8MOqQrmFngQGi5QyufD5T+MBzvzDXaCePJiAF24c
 5EriOk05zX49oo+CbWzwT2b9Ah7zbnHY1Kj6ABPH8ZNZusQgpbwuLmHkbh/A6TIN93kr
 pA7xB6BhO/iHfW67HmymxsK9FJIXi7qpJgCP9TNaeisd1IZ2M4EpHdIF4QKwFr1B4aFy
 JjX9QhXQesAj47dtmWilAb1f8EIcTRQy3gIOIxja4pHhGUl6LIy5bQ0KXiGU2jzCTUBH eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2y2k884m7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2020 16:42:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BGabLk034285;
 Tue, 11 Feb 2020 16:42:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2y26srt9ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2020 16:42:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01BGgTV4027130;
 Tue, 11 Feb 2020 16:42:29 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Feb 2020 08:42:28 -0800
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
Date: Tue, 11 Feb 2020 11:42:27 -0500
Message-Id: <ACDC4DF0-6B82-4487-A794-582113F10A4B@oracle.com>
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
 <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
 <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
 <A411A8A6-ECEF-4EAD-84A1-99A30A213D8E@oracle.com>
 <35961bac-2f1e-3fbc-9661-031b9d5acee3@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110120
Cc: Tom Murphy <tmurphy@arista.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Andre Tomt <andre@tomt.net>,
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



> On Feb 11, 2020, at 11:36 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 11/02/2020 4:03 pm, Chuck Lever wrote:
>>> On Feb 11, 2020, at 10:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> 
>>> On 11/02/2020 3:24 pm, Chuck Lever wrote:
>>>>> On Feb 11, 2020, at 10:12 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>> 
>>>>> On 11/02/2020 1:48 pm, Chuck Lever wrote:
>>>>>> Andre-
>>>>>> Thank you for the detailed report!
>>>>>> Tom-
>>>>>> There is a rich set of trace points available in the RPC/RDMA implementation in 5.4/5.5, fwiw.
>>>>>> Please keep me in the loop, let me know if there is anything I can do to help.
>>>>> 
>>>>> One aspect that may be worth checking is whether there's anywhere that assumes a successful return value from dma_map_sg() is always the same as the number of entries passed in - that's the most obvious way the iommu-dma code differs (legitimately) from the previous amd-iommu implementation.
>>>> net/sunrpc/xprtrdma/frwr_ops.c: frwr_map()
>>>> 317         mr->mr_nents =
>>>> 318                 ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
>>>> 319         if (!mr->mr_nents)
>>>> 320                 goto out_dmamap_err;
>>>> Should that rather be "if (mr->mr_nents != i)" ?
>>> 
>>> No, that much is OK - the point is that dma_map_sg() may pack the DMA addresses such that sg_dma_len(sg) > sg->length - however, subsequently passing that mr->nents to dma_unmap_sg() in frwr_mr_recycle() (rather than the original value of i) looks at a glance like an example of how things may start to get out-of-whack.
>> Robin, your explanation makes sense to me. I can post a fix for this imbalance later today for Andre to try.
> 
> FWIW here's a quick hack which *should* suppress the concatenation behaviour - if it makes Andre's system any happier then that would indeed point towards dma_map_sg() handling being the culprit.

Even so, 1f541895dae9 ("xprtrdma: Don't defer MR recovery if ro_map fails")
looks like it introduced this problem.


> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a2e96a5fd9a7..a6b71bad518e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> 		 * - but doesn't fall at a segment boundary
> 		 * - and wouldn't make the resulting output segment too long
> 		 */
> -		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> +		if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> 		    (max_len - cur_len >= s_length)) {
> 			/* ...then concatenate it with the previous one */
> 			cur_len += s_length;
> @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> 		if (s_length + s_iova_off < s_iova_len)
> 			cur_len = 0;
> 	}
> +	WARN_ON(count < nents);
> 	return count;
> }

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
