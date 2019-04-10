Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BIGNUM_EMAILS,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA3C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 10:03:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77866217D6
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z/f3m+nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77866217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4D8B41703;
	Wed, 10 Apr 2019 10:03:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3268116FC
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 10:02:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C4B1B17E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 10:02:54 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3A9rknu062842; Wed, 10 Apr 2019 10:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=Y8bWGW03G4sGwsf1DK+mK3Dp0edG8wYNJ92rQXGQu1s=;
	b=Z/f3m+ndWx+cbUAQ0iMiwgevGfWahtSSMaVxBX+yDeaLNbnu/1KeahhBlqLn4tlsPkGC
	Wc8M1tFvsqC5Vu0rm+35PXcHRtbmxhjpZb3V7cz2HGFLWxdldWhyCU2Coa7BJXiOsU5u
	GNcbxqldBygMxr7H2h3nuURqvnbHxsdbBE+ko0F18fRJYxyNk0PQ++/7nIcm6ylaPt/m
	WdNujWnIEIQ3mVqtH/LYkismT9OM2qFntxp3PU6l6a0HjPnGZlc4TEjxwmhgGt5YXQqQ
	ABT17tOy4vWVg2jQzZYJeUzREjNqOaBYFBSQoz/5qoSFno3JyQrz3y7iIhLnr88N4VGf
	7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 2rphmej91w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 10:02:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AA2nQt047777; Wed, 10 Apr 2019 10:02:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2rpytc593k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 10:02:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AA2jXD025816;
	Wed, 10 Apr 2019 10:02:45 GMT
Received: from kadam (/197.157.0.42) by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 10 Apr 2019 03:02:44 -0700
Date: Wed, 10 Apr 2019 13:02:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [bug report] iommu/io-pgtable-arm: Fix pgtable allocation in
	selftest
Message-ID: <20190410100237.GA31633@kadam>
References: <20190410093405.GA9889@kadam>
	<782a999e-ce70-bd8e-5a7b-cd320ce98144@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <782a999e-ce70-bd8e-5a7b-cd320ce98144@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904100073
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904100072
Cc: jean-philippe.brucker@arm.com, iommu@lists.linux-foundation.org
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
Message-ID: <20190410100237.L6ko-in_piwkfBOaxniLC_fumAtdyZA5tMAOQpETG8Q@z>

On Wed, Apr 10, 2019 at 10:44:03AM +0100, Robin Murphy wrote:
> Hi Dan,
> 
> On 10/04/2019 10:34, Dan Carpenter wrote:
> > Hello Jean-Philippe Brucker,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch fac83d29d954: "iommu/io-pgtable-arm: Fix pgtable allocation
> > in selftest" from Jun 18, 2018, leads to the following Smatch
> > complaint:
> > 
> >      drivers/iommu/io-pgtable-arm.c:246 __arm_lpae_alloc_pages()
> >      error: we previously assumed 'dev' could be null (see line 239)
> > 
> > drivers/iommu/io-pgtable-arm.c
> >     238		VM_BUG_ON((gfp & __GFP_HIGHMEM));
> >     239		p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
> >                                       ^^^
> > We added a NULL check here
> > 
> >     240				     gfp | __GFP_ZERO, order);
> >     241		if (!p)
> >     242			return NULL;
> >     243	
> >     244		pages = page_address(p);
> >     245		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
> 
> The selftests *should* always set this quirk such that they never get to the
> DMA mapping calls (that was one of the reasons for implementing things that
> way) - I guess that might be a bit too sneaky for Smatch, but I can take a
> look to double-check that the flow is working correctly such that this
> really is a false-positive.

Ah, thanks.

I have a plan for fixing these false positives caused by not tracking
bit masks.  It's not that complicated to fix, it just takes time to
write the code.

regards,
dan carpenter

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
