Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9583EC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 16:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B70A60758;
	Fri,  4 Mar 2022 16:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q6i6qR3BfbLa; Fri,  4 Mar 2022 16:35:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32E2D60810;
	Fri,  4 Mar 2022 16:35:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD6AC0012;
	Fri,  4 Mar 2022 16:35:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B89EAC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98E36841AC
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jtt5_xV3hDOb for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:35:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A65C3825FE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:35:45 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224FJMiI010242; 
 Fri, 4 Mar 2022 16:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H3dudtMuwKbsH6wAfNYatwF/cJcXUmht8HPeAcYhynE=;
 b=Swhm8zgFfwRiHl5jw0AJ7uT1d8ejcvmaKWkWRE/9UibSZ6pOHK5C3oe2m0JpTex3MDBV
 qozQscTBwhIJWPAuTES2u7UkF4ZB+FIZH5Ls66sFd2yh4LKDH7GTmuRvEnXol7lc7YzX
 AW9of1N2Tp7MXRtteZq0s5T91s21+ZdhZB7URfar5jWssawgadsj8bTNj5YHRC46AmtZ
 X88mhd0PiOa/by7t770WrDj4j6c8dsuUWLeLA94pSLzdidepges3SedR0NS4ZqmqUsyX
 eqRs+Hf4np9V9Q+miKsZm6T+Ft/1mQVJ7tZ1JGcL8+DRCtBJxazSEPIfeVUBIp2d6tPG 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eknae1h2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:35:35 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224GIXMe024747;
 Fri, 4 Mar 2022 16:35:35 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eknae1h1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:35:35 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224GHXLT015274;
 Fri, 4 Mar 2022 16:35:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3ek4kbt7b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 16:35:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 224GZTNk46924140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Mar 2022 16:35:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 361314203F;
 Fri,  4 Mar 2022 16:35:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AD624204F;
 Fri,  4 Mar 2022 16:35:28 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.94.215])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri,  4 Mar 2022 16:35:28 +0000 (GMT)
Date: Fri, 4 Mar 2022 17:34:47 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Revert "swiotlb: fix info leak with DMA_FROM_DEVICE"
Message-ID: <20220304173447.27dc0798.pasic@linux.ibm.com>
In-Reply-To: <YiIiHD7uA1o7Sj1X@kroah.com>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
 <20220304135859.3521513-2-pasic@linux.ibm.com>
 <YiIiHD7uA1o7Sj1X@kroah.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SCEWGgjRW7Y3T-d0fgKvv9UsmX4I2Eul
X-Proofpoint-ORIG-GUID: 1kFY5jWUO03jsvpt-ZhIMvmb-Sm7bp_o
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_07,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 mlxlogscore=683 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040085
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Halil Pasic <pasic@linux.ibm.com>,
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

On Fri, 4 Mar 2022 15:28:44 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 04, 2022 at 02:58:58PM +0100, Halil Pasic wrote:
> > This reverts commit ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e.  
> 
> Why???

TLDR; We got v4 merged instead of v7
> 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>  
> 
> You need a blank line before this one.

Sorry I wasn't careful enough and checkpatch.pl didn't complain about it.

Regards,
Halil

> 
> also:
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
