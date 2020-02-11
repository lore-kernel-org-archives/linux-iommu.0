Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB6C3B186
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4E620714
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFQPZJEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4E620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66EA685B2F;
	Tue, 11 Feb 2020 16:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewspMVSjdJNq; Tue, 11 Feb 2020 16:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C242585A60;
	Tue, 11 Feb 2020 16:03:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0BA4C1D80;
	Tue, 11 Feb 2020 16:03:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D8DC07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D210086BDB
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cu-iwttRAdxb for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 16:03:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 30F4386914
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 16:03:55 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BG30l5068500;
 Tue, 11 Feb 2020 16:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=EjhqxFmpxu5cbuu2+GJVtqQbUKVZLIV/cYgnq3tgYFE=;
 b=rFQPZJEtILKMRWt/ihoG9ZfuxsI6OCqC2PyltGSwd4uiPD00oOLDe7MHb9ZovOfE8Z0+
 qzYqn6/r+UK5GRQfDtiSWAJEJP9PQw9Mz3aJhM2b0+Z6Xq4TRqXwbe1sH+21yu/UD75O
 rxcPVa4qiaDtx2zXD7wOYzKKOzhoPL9SE4Pz3yNmiWetkedmUVScQr+Oz/5MOObG2LHR
 7pvSuxgTTp4Bt/nyZ1YEjTedbVIKo6mFE/9UEhxCY75bjg/8VI5/i2BtZma5TwoknVeK
 B90NhEEmpM8iP+qVSzyjOJmAiHzeMxdNwgqhAzLVj/s6wSy4f5PKgln2lOA8FlEZ2Wxh Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2y2p3sc6ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2020 16:03:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BG2VID187331;
 Tue, 11 Feb 2020 16:03:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2y26srn7ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2020 16:03:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01BG3hXg026016;
 Tue, 11 Feb 2020 16:03:45 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Feb 2020 08:03:42 -0800
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
Date: Tue, 11 Feb 2020 11:03:39 -0500
Message-Id: <A411A8A6-ECEF-4EAD-84A1-99A30A213D8E@oracle.com>
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
 <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
 <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110115
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



> On Feb 11, 2020, at 10:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 11/02/2020 3:24 pm, Chuck Lever wrote:
>>> On Feb 11, 2020, at 10:12 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> 
>>> On 11/02/2020 1:48 pm, Chuck Lever wrote:
>>>> Andre-
>>>> Thank you for the detailed report!
>>>> Tom-
>>>> There is a rich set of trace points available in the RPC/RDMA implementation in 5.4/5.5, fwiw.
>>>> Please keep me in the loop, let me know if there is anything I can do to help.
>>> 
>>> One aspect that may be worth checking is whether there's anywhere that assumes a successful return value from dma_map_sg() is always the same as the number of entries passed in - that's the most obvious way the iommu-dma code differs (legitimately) from the previous amd-iommu implementation.
>> net/sunrpc/xprtrdma/frwr_ops.c: frwr_map()
>> 317         mr->mr_nents =
>> 318                 ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
>> 319         if (!mr->mr_nents)
>> 320                 goto out_dmamap_err;
>> Should that rather be "if (mr->mr_nents != i)" ?
> 
> No, that much is OK - the point is that dma_map_sg() may pack the DMA addresses such that sg_dma_len(sg) > sg->length - however, subsequently passing that mr->nents to dma_unmap_sg() in frwr_mr_recycle() (rather than the original value of i) looks at a glance like an example of how things may start to get out-of-whack.

Robin, your explanation makes sense to me. I can post a fix for this imbalance later today for Andre to try.


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
