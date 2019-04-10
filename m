Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BIGNUM_EMAILS,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E71C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:34:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3502133D
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 09:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yE7lvbFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3502133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B74114C3;
	Wed, 10 Apr 2019 09:34:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4ACFEEE7
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:34:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E62D3174
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 09:34:20 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3A9YFtm052113; Wed, 10 Apr 2019 09:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : mime-version : content-type; s=corp-2018-07-02;
	bh=W2kyDEjMCPRrt9oKNEquTji2SIdhAFtqLlT5KxCrmMA=;
	b=yE7lvbFw5h8BuQElDQIjbjZWihhogI5ygchPno1IRL8MvcvU9YVe5grkBcfW2Ins5p30
	SrmJr21LcG4QmbOivRkxP2Hpmes4iGYOWp9taPh5iQpB9iU3MIZMaFCp7GJkOMJgtXSu
	nA7coIl7WXedU86GQOm8tVHTRb24UUXPxnsBKYsjJXUiJCRiTmaNsUMtGUxE7bbincEU
	GryLwOr2eEYqWVI7e543indlZWVZQdNOt/GMkRcPT+eLMTmUIbjm+VNMlP2WbBosqCKt
	lutd+zQw4BNkorGf3UOxS3PcWBvkvT6Sd8FQxdvCx9kXtmDli88UQjCuCfq/mqyqDgIC
	MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2rpmrq9wed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 09:34:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3A9Y6Af126096; Wed, 10 Apr 2019 09:34:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 2rpkejtauk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 09:34:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A9YDH3029763;
	Wed, 10 Apr 2019 09:34:13 GMT
Received: from kadam (/197.157.0.42) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 10 Apr 2019 02:34:12 -0700
Date: Wed, 10 Apr 2019 12:34:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jean-philippe.brucker@arm.com
Subject: [bug report] iommu/io-pgtable-arm: Fix pgtable allocation in selftest
Message-ID: <20190410093405.GA9889@kadam>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=742
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904100070
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=763
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904100070
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410093406.W4mGocrccrCScxrCwR3b7c3psBgFLFZraLaBjriqKiM@z>

Hello Jean-Philippe Brucker,

This is a semi-automatic email about new static checker warnings.

The patch fac83d29d954: "iommu/io-pgtable-arm: Fix pgtable allocation
in selftest" from Jun 18, 2018, leads to the following Smatch
complaint:

    drivers/iommu/io-pgtable-arm.c:246 __arm_lpae_alloc_pages()
    error: we previously assumed 'dev' could be null (see line 239)

drivers/iommu/io-pgtable-arm.c
   238		VM_BUG_ON((gfp & __GFP_HIGHMEM));
   239		p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
                                     ^^^
We added a NULL check here

   240				     gfp | __GFP_ZERO, order);
   241		if (!p)
   242			return NULL;
   243	
   244		pages = page_address(p);
   245		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
   246			dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
                                             ^^^
But dma_map_single() can't take a NULL argument either.

   247			if (dma_mapping_error(dev, dma))
   248				goto out_free;

I don't know why this warning is only showing up now, almost a year
later.  Sorry about that.

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
