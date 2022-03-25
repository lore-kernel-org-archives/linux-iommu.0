Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B794C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 15:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5F9B84160;
	Fri, 25 Mar 2022 15:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dt8qJdYjw3EI; Fri, 25 Mar 2022 15:25:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA0968415D;
	Fri, 25 Mar 2022 15:25:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60497C001D;
	Fri, 25 Mar 2022 15:25:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9985C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 15:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0D1E401D5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 15:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8ckc1Zti2DD for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 15:25:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 619614011C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 15:25:25 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PEcQHe018886; 
 Fri, 25 Mar 2022 15:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=wtZ7yK/0CRnLGQyyfEq04PkrYcuVIqNGBRYNpsmm4LU=;
 b=EK9KlqWRtK9jemIaBWXPSfVTRv7USZwJCT2m7UkMY4Fbqu1mZPPCfOO3KX6LaME2tqtY
 SCJSJ99+VNvyQNplV6DpxQ8ZR6IWEGAAds16W1nmTaf8MqUbsID0FMXHhdGLi5Jses/0
 t9MFw6avPEyLFxSeXEGpjX7V3EtJ2RhHM/n9AgH49GMInB2hLRNZb0kSRe9EDnDYihtq
 16LcTVMK9lmYQLG6vKMqdFQ1h8vYzlN4bZgDET3/Pl1fXf+8A1cr8jP4/aesY+Yy1NnB
 RRmf1dUNIW2zY+kdFDM5Zd7T6okZbG7oohnxKAfHoS0VUC/Czwnuyv+DJKHhKmPuRZhc Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f0kax5t98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Mar 2022 15:25:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22PF4OYI008470;
 Fri, 25 Mar 2022 15:25:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f0kax5t8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Mar 2022 15:25:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22PFN9xa018376;
 Fri, 25 Mar 2022 15:25:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 3ew6ej3kf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Mar 2022 15:25:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 22PFDNU850856374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Mar 2022 15:13:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB1014C040;
 Fri, 25 Mar 2022 15:25:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B44944C044;
 Fri, 25 Mar 2022 15:25:10 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.85.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 25 Mar 2022 15:25:10 +0000 (GMT)
Date: Fri, 25 Mar 2022 16:25:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220325162508.3273e0db.pasic@linux.ibm.com>
In-Reply-To: <20220324190216.0efa067f.pasic@linux.ibm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xAmGyw1lgESr16IrNUtiGC-eJnDwcDex
X-Proofpoint-GUID: 71FqG_G0CuPRDUQFTyfziAzEYfbIJLzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_04,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 mlxlogscore=899 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250084
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, 24 Mar 2022 19:02:16 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> > I'll admit I still never quite grasped the reason for also adding the 
> > override to swiotlb_sync_single_for_device() in aa6f8dcbab47, but I 
> > think by that point we were increasingly tired and confused and starting 
> > to second-guess ourselves (well, I was, at least).  
> 
> I raised the question, do we need to do the same for
> swiotlb_sync_single_for_device(). Did that based on my understanding of the
> DMA API documentation. I had the following scenario in mind
> 
> SWIOTLB without the snyc_single:
>                                   Memory      Bounce buffer      Owner
> --------------------------------------------------------------------------
> start                             12345678    xxxxxxxx             C
> dma_map(DMA_FROM_DEVICE)          12345678 -> 12345678             C->D
> device writes partial data        12345678    12ABC678 <- ABC      D
> sync_for_cpu(DMA_FROM_DEVICE)     12ABC678 <- 12ABC678             D->C
> cpu modifies buffer               66666666    12ABC678             C
> sync_for_device(DMA_FROM_DEVICE)  66666666    12ABC678             C->D
> device writes partial data        66666666    1EFGC678 <-EFG       D
> dma_unmap(DMA_FROM_DEVICE)        1EFGC678 <- 1EFGC678             D->C
> 
> Legend: in Owner column C stands for cpu and D for device.
> 
> Without swiotlb, I believe we should have arrived at 6EFG6666. To get the
> same result, IMHO, we need to do a sync in sync_for_device().
> And aa6f8dcbab47 is an imperfect solution to that (because of size).
> 

@Robin, Christoph: Do we consider this a valid scenario?

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
