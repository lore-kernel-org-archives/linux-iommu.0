Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663DFC43219
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 18:57:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF20320678
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 18:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KNyM+2ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF20320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E087421F1;
	Thu, 25 Apr 2019 18:57:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1553D19F1
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 18:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AA46F74A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 18:56:49 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3PIrvW2042873; Thu, 25 Apr 2019 18:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2018-07-02;
	bh=eddxwpTbGvYlrDnZawfvlTYx6zkSVLalru6T1D4h8+A=;
	b=KNyM+2veTG+sc57FCXnJ1g5qMvps+C2JD5SppKWqEzXt2+K760LcP7UH55pnNzl2sCYj
	jTG4iSC4iVAG6Pcghixtx2a5k9kR0jSlfU5zUFvYpVecowzC3rQLMIue1V7VZgM4Bu1u
	pEyKBTHlQXyWI/FCCo4dsLxvZ19fOV2fOnrpVR0QX3hZkmpmNx0+ju/FKcP4pVOfLodx
	Oc6+f4/LhbSnq4QMo+m1b+Baz44c+o1fVjb3iLLTZIU7+9Evj6iONzbyR5uCmQRng8Do
	Tp1y4OZmVMN1ibpEKU7b9Y1MpaJsfF3t3HEC+cSQnxTIL5K0utrKYLlOvXYLHPKZHLi1
	AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 2ryrxdaft8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2019 18:56:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3PItNZP135993; Thu, 25 Apr 2019 18:56:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 2ryrhtee1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2019 18:56:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3PIuj8h028391;
	Thu, 25 Apr 2019 18:56:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 25 Apr 2019 11:55:46 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
	id EA7E06A00EF; Thu, 25 Apr 2019 14:55:46 -0400 (EDT)
Date: Thu, 25 Apr 2019 14:55:46 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: a few xen swiotlb cleanups
Message-ID: <20190425185546.GD30965@char.us.oracle.com>
References: <20190411072000.4306-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411072000.4306-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=864
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904250116
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9238
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=894
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904250116
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	iommu@lists.linux-foundation.org
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
Message-ID: <20190425185546.nNMxT80w8HILKrAdAnq_frH4au8BhxWRuQe7IsPcB5U@z>

On Thu, Apr 11, 2019 at 09:19:56AM +0200, Christoph Hellwig wrote:
> Hi all,

I will slurp these up.. right after I test them for correctness.

> 
> below are a couple of cleanups for swiotlb-xen.c.  They were done in
> preparation of eventually using the dma-noncoherent.h cache flushing
> hooks, but that final goal will need some major work to the arm32 code
> first.  Until then I think these patches might be better in mainline
> than in my local tree so that they don't bitrot.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
