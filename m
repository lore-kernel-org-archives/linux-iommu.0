Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21539C433F5
	for <iommu@archiver.kernel.org>; Sat,  5 Mar 2022 00:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF88C4030D;
	Sat,  5 Mar 2022 00:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGXVhCqRT0GF; Sat,  5 Mar 2022 00:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97E0E4030C;
	Sat,  5 Mar 2022 00:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A8ACC0012;
	Sat,  5 Mar 2022 00:43:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6746AC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4274D60B72
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AO0gm2h2ZP4 for <iommu@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 00:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 587646068F
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:43:17 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224KE5Zw019015; 
 Sat, 5 Mar 2022 00:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=unLmegORgTqQP18ephKn5ovwRrDAmzIrqKCM25UePpk=;
 b=qiKwIAM3pZLUfzV5zBxsjUEXnSubJ1GMdoJFImZ2IS/md9W8x/wx/NQ2ePIqqReEOQUs
 v980OG6jEPDyNHMrcaFQOJdAUMgR0JLqSePT2gD6dDxVlcsQEvGWI6h/eq18KBHYZeK0
 1xTPU64nUNzhrWW7uWx0X+tS6v+u7Ns3sBWEbE4T4CcAj3uNq6GKUd4DDZF0vhIr+j0E
 w1i7KX00qc2PgErG8WkA3O+Ni/vc6QHFx01KcrXCrq1b6kRfy3hm1BrA2iNjTvX50JxD
 GQxVU5ZC1WFtFFuzAqOcBhU9+QP/tIJJ+zQry0QeUI/r5RJiw1ZdZILoux3Stie5lWDp fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eksma3njx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 00:43:06 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2250h5vU019817;
 Sat, 5 Mar 2022 00:43:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3eksma3njj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 00:43:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2250S3GK007323;
 Sat, 5 Mar 2022 00:43:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 3ek4kgay5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Mar 2022 00:43:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2250gxsi20840924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 5 Mar 2022 00:42:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACCD6AE051;
 Sat,  5 Mar 2022 00:42:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA5B9AE04D;
 Sat,  5 Mar 2022 00:42:58 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.94.215])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Sat,  5 Mar 2022 00:42:58 +0000 (GMT)
Date: Sat, 5 Mar 2022 01:42:56 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Revert "swiotlb: fix info leak with DMA_FROM_DEVICE"
Message-ID: <20220305014256.687c77aa.pasic@linux.ibm.com>
In-Reply-To: <YiJEjLdpXoGxtJsO@kroah.com>
References: <20220304135859.3521513-1-pasic@linux.ibm.com>
 <20220304135859.3521513-2-pasic@linux.ibm.com>
 <YiIiHD7uA1o7Sj1X@kroah.com>
 <20220304173447.27dc0798.pasic@linux.ibm.com>
 <YiJEjLdpXoGxtJsO@kroah.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _KGvmWxgYA9bjO_iRD2EW5fQtLgEy9Or
X-Proofpoint-ORIG-GUID: P21Y3rHEKAzPfl_buFJc9ZSaEfiGpiU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203050000
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

On Fri, 4 Mar 2022 17:55:40 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 04, 2022 at 05:34:47PM +0100, Halil Pasic wrote:
> > On Fri, 4 Mar 2022 15:28:44 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Fri, Mar 04, 2022 at 02:58:58PM +0100, Halil Pasic wrote:  
> > > > This reverts commit ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e.    
> > > 
> > > Why???  
> > 
> > TLDR; We got v4 merged instead of v7  
> 
> That makes no sense at all to me, you need to describe it in detail.
> 
> You know better than this :(
> 

I have described the why in the cover letter of the series. Let me
copy-paste it here:

Unfortunately, we ended up with the wrong version of the patch "fix info
leak with DMA_FROM_DEVICE" getting merged. We got v4 merged, but the
version we want is v7 with some minor tweaks which were supposed to be
applied by Christoph (swiotlb maintainer). After pointing this out, I
was asked by Christoph to create an incremental fix. 

IMHO the cleanest way to do this is a reverting the incorrect version
of the patch and applying the correct one. I hope that qualifies as
an incremental fix.

The main differences between what we got and what we need are:
* swiotlb_sync_single_for_device is also required to do an extra bounce
* It was decided that we want to defer introducing DMA_ATTR_OVERWRITE,
  until we have exploiters 
* And anyway DMA_ATTR_OVERWRITE must take precedence over
  DMA_ATTR_SKIP_CPU_SYNC, so the v4 implementation of DMA_ATTR_OVERWRITE
  ain't even correct.

Describing it in the revert commit would have been a wiser choice, I
agree.

BTW the consensus seems to be, that a revert should be avoided, so I will
send a single-patch version of this fix soon(ish).

Sorry for the inconvenience!

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
