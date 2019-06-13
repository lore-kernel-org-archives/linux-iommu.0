Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B62C31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B7020665
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JM/zm087"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B7020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 111E9110B;
	Thu, 13 Jun 2019 16:59:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C31D2E18
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:59:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 24D5576D
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:59:27 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5DGrg6a146672; Thu, 13 Jun 2019 16:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=to : cc : subject :
	from : references : date : in-reply-to : message-id : mime-version :
	content-type; s=corp-2018-07-02;
	bh=VB7BbCcx5CDFsG6/AylvYiYZjuNghhK4GPV3gIX6IgY=;
	b=JM/zm087RQdix9tjZYqwsKtsL1r4oeg4m549rL34vFP7V7snV+V6jkMW32K6cszyFqwA
	4LAwbnYI7oNx6Cder0IYcyRig+6l/D5XoXA1WNj3W3i4BZ6SS9JNcU2+U4sz9Ilx21RF
	m9yWqSzUQgzoMdBE7yH3XIoto5guc4o8ijARvGbDVEAkV33NZnSKZyPhcunGnyQZOg6D
	gntIMHlm0W9RMbH9YcXv5nmx02cXJu4f8UcMUE/CPLCoFNupiHRYByCja362NG3+UA64
	L3pcrl3it7g9J2N2cGoPCK+Lkrsj/lr1/Q03zQibiuskhzmeOuF3NAuinosmwPYef5Ov
	hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2t05nr2uea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2019 16:59:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x5DGuroV168293; Thu, 13 Jun 2019 16:57:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2t1jpjnsf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2019 16:57:26 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DGvOZm008225;
	Thu, 13 Jun 2019 16:57:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 13 Jun 2019 09:57:23 -0700
To: Christoph Hellwig <hch@lst.de>
Subject: Re: How to resolve an issue in swiotlb environment?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190612120653.GA25285@lst.de>
	<Pine.LNX.4.44L0.1906121038210.1557-100000@iolanthe.rowland.org>
	<20190613073900.GC12093@lst.de>
Date: Thu, 13 Jun 2019 12:57:21 -0400
In-Reply-To: <20190613073900.GC12093@lst.de> (Christoph Hellwig's message of
	"Thu, 13 Jun 2019 09:39:00 +0200")
Message-ID: <yq14l4ttocu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=655
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1906130122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=707
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1906130123
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Alan Stern <stern@rowland.harvard.edu>
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


Christoph,

> sd.c only supports a few specific sector size, and none of them is
> < 512 bytes:

Yep, while sd.c in theory supported 256-byte logical blocks a while
back, that code was removed since the block layer always operates on
units of 512 bytes.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
