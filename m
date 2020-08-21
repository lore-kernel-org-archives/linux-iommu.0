Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC6C433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 17:57:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E4620702
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xjD0YNa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A2338849B;
	Fri, 21 Aug 2020 17:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTQ9gaEAn1kY; Fri, 21 Aug 2020 17:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA68E88484;
	Fri, 21 Aug 2020 17:57:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC79C0889;
	Fri, 21 Aug 2020 17:57:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52D0CC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 17:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3AA0E88484
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 17:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IEjOT2nwW8Lm for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 17:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 87C0D88483
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 17:53:31 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHpnhR122754;
 Fri, 21 Aug 2020 17:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QXawLVP6mU6d0n9H5D3i3kKivyf++OjS6AL4G5gYPVg=;
 b=xjD0YNa5YhxJPt0WJTpjk+LadbNo2d7FMenSTrPuETPZd7f/r/IrdEUTYMB6zjBoZPR2
 u0Gbt5dQsnBGRBHppUYMOtOLiNoG5diikc8EI5niRU5dGlMPhvjziRQpZSNErz1u9upU
 Wq8p7dpX4CoNxOvIx21kuNKLBAOOwPNcMzi2bnjJZQwzbDNznyPiT3oL2BAOfgaMMIN6
 Wll2kJGkWltQLjboVupRBBbXpcwJ/nVPH25WgFpRlaPV/q6tC1ok7TspzzN6qWnRrg5U
 6veJeGoLX+90LLkoIxl7SKSYaWcB3CZgDSGo8/2z5d5760+HuElRQHW99SZq6AH74yMQ Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 3322bjkud5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Aug 2020 17:52:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHluAE016656;
 Fri, 21 Aug 2020 17:52:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 330pvsa5cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2020 17:52:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LHqp6b011145;
 Fri, 21 Aug 2020 17:52:51 GMT
Received: from [192.168.2.112] (/50.38.35.18)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Aug 2020 17:52:51 +0000
Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
To: Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
 ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com,
 akpm@linux-foundation.org
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
Date: Fri, 21 Aug 2020 10:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210169
X-Mailman-Approved-At: Fri, 21 Aug 2020 17:57:56 +0000
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 huangdaode@huawei.com, linux-arm-kernel@lists.infradead.org
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

Hi Barry,
Sorry for jumping in so late.

On 8/21/20 4:33 AM, Barry Song wrote:
> 
> with per-numa CMA, smmu will get memory from local numa node to save command
> queues and page tables. that means dma_unmap latency will be shrunk much.

Since per-node CMA areas for hugetlb was introduced, I have been thinking
about the limited number of CMA areas.  In most configurations, I believe
it is limited to 7.  And, IIRC it is not something that can be changed at
runtime, you need to reconfig and rebuild to increase the number.  In contrast
some configs have NODES_SHIFT set to 10.  I wasn't too worried because of
the limited hugetlb use case.  However, this series is adding another user
of per-node CMA areas.

With more users, should try to sync up number of CMA areas and number of
nodes?  Or, perhaps I am worrying about nothing?
-- 
Mike Kravetz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
