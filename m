Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32422C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 16:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ABCF60810;
	Fri,  4 Mar 2022 16:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abN1LnG6P4_Q; Fri,  4 Mar 2022 16:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2144260D61;
	Fri,  4 Mar 2022 16:29:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D58DEC0012;
	Fri,  4 Mar 2022 16:29:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6DCEC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A431040232
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id axYPhbLYLC7I for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE6FA40160
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:29:28 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224FJOLu010359; 
 Fri, 4 Mar 2022 16:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=IL+VWTIPQ3j6xGTOOsrsIIrVRc8PdvkQHCT9sWI1nk4=;
 b=C8gzfYV8fZEwexUhUq/lYkk/koIpnQPZWAELeS9bp75MBQuginOdpP2XRxJFP0FDGJxL
 2ywHZWNUSesKz6fd+dorgYmcEyx4LYAPu5DQYF/h5Bnixm4JkJgx0idNj4+pLYCps/7D
 rmNOkimVC21PkFMP7lB0xk7I0u7jDNJDbzBidU++8bv+ZoZAGcspOzWU4Z/BjuJSHsVr
 AlhFyKWSrLxviTjHK6dew3pKx3Vpfez3Z0D73YZNqZVhIEeE/SCVViHx/7IqGxqEgiCU
 snhBebj8a/hmAOiUaIhyhGQMd1KDgkyJ6M0YM5/KTCA+mlhgCvdC49xu+Wje2Q3W/PWF kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eknae1d5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:29:18 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224FZ2Z8002766;
 Fri, 4 Mar 2022 16:29:18 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eknae1d58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:29:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224GHCeu013271;
 Fri, 4 Mar 2022 16:29:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 3ek4k3hx27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:29:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 224GIBGd47776052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Mar 2022 16:18:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 050694203F;
 Fri,  4 Mar 2022 16:29:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2999342041;
 Fri,  4 Mar 2022 16:29:11 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.94.215])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri,  4 Mar 2022 16:29:11 +0000 (GMT)
Date: Fri, 4 Mar 2022 17:29:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/2] swiotlb: rework fix info leak with DMA_FROM_DEVICE
Message-ID: <20220304172908.43ab261d.pasic@linux.ibm.com>
In-Reply-To: <YiI2DPIrNLKwanZw@infradead.org>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
 <YiI2DPIrNLKwanZw@infradead.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tNfSGfEP4uLov8R8L2q7BvqqGLkldnZk
X-Proofpoint-ORIG-GUID: 3S84OGo6w6kSTSeKENgrp7gsrPLWKL8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_07,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040083
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Fri, 4 Mar 2022 07:53:48 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Mar 04, 2022 at 02:58:57PM +0100, Halil Pasic wrote:
> > Unfortunately, we ended up with the wrong version of the patch "fix info
> > leak with DMA_FROM_DEVICE" getting merged. We got v4 merged, but the
> > version we want is v7 with some minor tweaks which were supposed to be
> > applied by Christoph (swiotlb maintainer). After pointing this out, I
> > was asked by Christoph to create an incremental fix. 
> > 
> > IMHO the cleanest way to do this is a reverting the incorrect version
> > of the patch and applying the correct one. I hope that qualifies as
> > an incremental fix.  
> 
> I'd really do one patch to move to the expected state.  I'd volunteer
> to merge the two patches, but I've recently shown that I'm not
> exactly good at that..

No problem, I can do that. It isn't hard to squash things together, but
when I was about to write the commit message, I had the feeling doing
a revert is cleaner.

Any other opinions?

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
