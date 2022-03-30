Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13ADC433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 12:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E2D7404F9;
	Wed, 30 Mar 2022 12:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIbipedHEI3G; Wed, 30 Mar 2022 12:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 174D84049A;
	Wed, 30 Mar 2022 12:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF730C002C;
	Wed, 30 Mar 2022 12:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4753CC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 12:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CFE841B91
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 12:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mk1aO4RPB5E9 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 12:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6630A41B93
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 12:12:16 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UBQkFs026930; 
 Wed, 30 Mar 2022 12:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MUFVyysUdoPdz+GQhkqKxHsF7V7+5wuBxTvpNCjkBHQ=;
 b=PDYKOx3wxUFSnsD7R97b2PQoJ5lgQO2Md4e0CiPdZD5viSXuSelavKL/RHn/pev1mZMH
 X+45fRDnJWiU4Qwo/fKAPjsdCoZ/VKMrp/JR1/KOFB2Pb5dEnpCoVy64Jvp1P2uOcbij
 SG9lrdCnuQptxKFW27X/W35PEO1VeyKsE+XlP9Jyzg/jauief+Y4ho64RNXzfY2O6zgY
 2AEFumF8FepOXwntvvmfbjvntAzpC0MRBoMQuSQ/tFcZ5N9L8SzBoHzHd5X22uq+6/JM
 dze6ewWnew8a1HgX6CceO7eXHRpAK+bGgDEAtxNNIOPO97XPzanjTM4fs8hZ1IA/y/gT yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f4pbcgxdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Mar 2022 12:12:02 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UBdOnf017794;
 Wed, 30 Mar 2022 12:12:02 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f4pbcgxcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Mar 2022 12:12:01 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UBwVWc018090;
 Wed, 30 Mar 2022 12:11:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 3f1t3hy9rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Mar 2022 12:11:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22UCBub229622756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Mar 2022 12:11:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F3E4C050;
 Wed, 30 Mar 2022 12:11:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 071474C040;
 Wed, 30 Mar 2022 12:11:56 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.15.152])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed, 30 Mar 2022 12:11:55 +0000 (GMT)
Date: Wed, 30 Mar 2022 14:11:54 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220330141154.2ed284f1.pasic@linux.ibm.com>
In-Reply-To: <20220328063723.GA29405@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
 <20220325163204.GB16426@lst.de> <87y20x7vaz.fsf@toke.dk>
 <e077b229-c92b-c9a6-3581-61329c4b4a4b@arm.com>
 <CAHk-=wgKF5GfLXyVGDQDifh0MpMccDdmBvJBG3dt2+idCa5DzQ@mail.gmail.com>
 <20220328063723.GA29405@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ul5-ww-qQk8Gw2JXhdzZFG5qKYbo_d91
X-Proofpoint-ORIG-GUID: CV3YK3L41YQ9qvUgMuQRgvjVjUTto1XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_04,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300062
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, 28 Mar 2022 08:37:23 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Mar 25, 2022 at 11:46:09AM -0700, Linus Torvalds wrote:
> > I think my list of three different sync cases (not just two! It's not
> > just about whether to sync for the CPU or the device, it's also about
> > what direction the data itself is taking) is correct.
> > 
> > But maybe I'm wrong.  
> 
> At the high level you are correct.  It is all about which direction
> the data is taking.  That is the direction argument that all the
> map/unmap/sync call take.  The sync calls then just toggle the ownership.
> You seem to hate that ownership concept, but I don't see how things
> could work without that ownership concept as we're going to be in
> trouble without having that.  And yes, a peek operation could work in
> some cases, but it would have to be at the cache line granularity.
> 
> arch/arc/mm/dma.c has a really good comment how these transfers relate
> to actual cache operations btw>
> 
>  *
>  *          |   map          ==  for_device     |   unmap     ==  for_cpu
>  *          |----------------------------------------------------------------
>  * TO_DEV   |   writeback        writeback      |   none          none
>  * FROM_DEV |   invalidate       invalidate     |   invalidate*	  invalidate*

Very interesting! Does that mean that

memset(buf, 0, size);
dma_map(buf, size, FROM_DEVICE)
device does a partial write
dma_unmap(buf, size, FROM_DEVICE)

may boil down to being the same as without the memset(), because the
effect of the memset() may get thrown away by the cache invalidate?

That is in this scenario we could actually leak the original content of
the buffer if we have a non-dma-coherent cache?

Regards,
Halil 

>  * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invalidate
>  *
>  *     [*] needed for CPU speculative prefetches

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
