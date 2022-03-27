Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582F6C433EF
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 03:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3D0240018;
	Sun, 27 Mar 2022 03:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiIjy2HLkBu6; Sun, 27 Mar 2022 03:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6926A4048C;
	Sun, 27 Mar 2022 03:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F52AC002C;
	Sun, 27 Mar 2022 03:49:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1846DC0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 03:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5F7A81A33
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 03:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10srnOQ3zLwg for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 03:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43E6481A30
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 03:49:15 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22QNHv8G010618; 
 Sun, 27 Mar 2022 03:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=+mfoRcCmFT0JS6zf2eRI3+Pi12WB0EBK81p1P9sU4gs=;
 b=Zbdrt0LI2EXiVBh5IRuPJS9IKj/qkBF+X7vXMaAYHvsx+9s536+scpooWYSil3E+pNf+
 vI98T8t6SBBkOsSdOnO1nqG8abatud3Z8aVbRynfYBK93q3ne50KDOopgDvRr83x1TVj
 3+g4vls3PiElzKU+HENeNpjU2X3wieLEnmxHg6+U9eynM1t6NWnGD5aGvj/kg6OhrXur
 91Wdcs7ceWvkdAbQoSVzjKIpil8d+3/nIJK94k0TkR+FeP5REEcv5CmmD82g0DV5hyRS
 FHp3/IwrQQKvaCs2R6JGTu/GnGkW5EqFy+admvvd9RHAzdW5Qs294jHf2VS7I3ahs6nc NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f2ccrjf5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Mar 2022 03:48:57 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22R3muqC030615;
 Sun, 27 Mar 2022 03:48:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f2ccrjf5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Mar 2022 03:48:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22R3mjgQ008417;
 Sun, 27 Mar 2022 03:48:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3f1tf99fpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Mar 2022 03:48:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 22R3mujE45089254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Mar 2022 03:48:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A40D8A404D;
 Sun, 27 Mar 2022 03:48:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B88A0A4040;
 Sun, 27 Mar 2022 03:48:50 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.73.54])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Sun, 27 Mar 2022 03:48:50 +0000 (GMT)
Date: Sun, 27 Mar 2022 05:48:48 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220327054848.1a545b12.pasic@linux.ibm.com>
In-Reply-To: <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
 <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aU2QkfNNjgUjQGcm0JFsF5Yd0bFRyEZx
X-Proofpoint-GUID: ewoGDMbOZ3Cbe29feLOTEoCrihOk2PUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-27_01,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=739
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203270020
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On Thu, 24 Mar 2022 12:26:53 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I don't think the dma_sync_single_for_device() is *wrong* per se,
> because the CPU didn't actually do any modifications.
> 
> But yes, I think it's unnecessary - because any later CPU accesses
> would need that dma_sync_single_for_cpu() anyway, which should
> invalidate any stale caches.
> 
> And it clearly doesn't work in a bounce-buffer situation, but honestly
> I don't think a "CPU modified buffers concurrently with DMA" can
> *ever* work in that situation, so I think it's wrong for a bounce
> buffer model to ever do anything in the dma_sync_single_for_device()
> situation.

I agree it CPU modified buffers *concurrently* with DMA can never work,
and I believe the ownership model was conceived to prevent this
situation. But a CPU can modify the buffer *after* DMA has written to
it, while the mapping is still alive. For example one could do one
partial read from the device, *after* the DMA is done,
sync_for_cpu(DMA_FROM_DEVICE), examine, then zero out the entire buffer,
sync_for_device(DMA_FROM_DEVICE), make the device do partial DMA, do
dma_unmap and expect no residue from the fist DMA. That is expect that
the zeroing out was effective.

The point I'm trying to make is: if concurrent is even permitted (it
isn't because of ownership) swiotlb woudn't know if we are dealing with
the *concurrent* case, which is completely bogous, or with the
*sequential* case, which at least in theory could work. And if we don't
do anyting on the sync_for_device(DMA_FROM_DEVICE) we render
that zeroing out the entire buffer form my example ineffective, because
it would not reach the bounce buffer, and on dma_unmap we would overwrite
the original buffer with the content of the bounce buffer.

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
