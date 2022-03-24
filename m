Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C2C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 18:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9548241C83;
	Thu, 24 Mar 2022 18:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uCUUAEqRsSDM; Thu, 24 Mar 2022 18:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 54F6A41C80;
	Thu, 24 Mar 2022 18:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 023B4C0012;
	Thu, 24 Mar 2022 18:32:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B53B7C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C4CE84456
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BI-548gwXZef for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 18:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4210842CE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 18:32:35 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OGIMG7018966; 
 Thu, 24 Mar 2022 18:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QPEoHxcEwKvYGqD5wCoP7vHQWU9iiR1gyHKaskx0ZaY=;
 b=YDBpcmCRe4ki6BgB0SzAPfHDpOgPtoKSUOAJ9H6C/9pX+LdL4n4BkLFoH63IckXnstJs
 NdRVabkXq6ZjY8MAGiNTH9gubWNuk5juaAZCsPKK/Fd0ld/mQxhtZziEWROez1mKQrxW
 bFZIf7hmf8bwtYZ4yZa/rpa82GBqUdi4rPE+KwqXoXYWmwipmv0u9lmQSSjiTPaYRdOI
 VcU/xsKboRIw0dBPQjCQ4PeM2FwRQU0a51BljHE/Ky1j0TqZMP6T9U148McERsplQV73
 0EUyJAxe190C98PHRB8DTNBgKRUMBNt5wTQqschIecSpuDDeUYQsArLo1ob2wAeP6s6k Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f0kawf7yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:32:24 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22OHq0IS007551;
 Thu, 24 Mar 2022 18:32:23 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f0kawf7y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:32:23 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22OIKRCQ015319;
 Thu, 24 Mar 2022 18:32:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma02fra.de.ibm.com with ESMTP id 3ew6t8sta4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Mar 2022 18:32:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22OIWJah41681174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Mar 2022 18:32:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F2F6A405B;
 Thu, 24 Mar 2022 18:32:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35D4DA4054;
 Thu, 24 Mar 2022 18:32:18 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.63.111])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Thu, 24 Mar 2022 18:32:18 +0000 (GMT)
Date: Thu, 24 Mar 2022 19:31:58 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220324193158.5fcae106.pasic@linux.ibm.com>
In-Reply-To: <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com>
 <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oKSb7ZJ3AqHPRcTREuBg4BsuIsetEW2S
X-Proofpoint-GUID: DxCDOKV1iW1_bko4dmsq5AdF-oH4bAFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_06,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240101
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
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

On Thu, 24 Mar 2022 16:52:31 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> > Creating a new mapping for the same buffer before unmapping the
> > previous one does looks rather bogus.  But it does not fit the
> > pattern where revering the sync_single changes make the driver
> > work again.  
> 
> OK, you made me look :)
> 
> Now that it's obvious what to look for, I can only conclude that during 
> the stanza in ath_edma_get_buffers(), the device is still writing to the 
> buffer while ownership has been transferred to the CPU, and whatever got 
> written while ath9k_hw_process_rxdesc_edma() was running then gets wiped 
> out by the subsequent sync_for_device, which currently resets the 
> SWIOTLB slot to the state that sync_for_cpu copied out. By the letter of 
> the DMA API that's not allowed, but on the other hand I'm not sure if we 
> even have a good idiom for "I can't tell if the device has finished with 
> this buffer or not unless I look at it" :/

I agree with your analysis. Especially with the latter part (were you
state that we don't have a good idiom for that use case). 

I believe, a stronger statement is also true: it is fundamentally
impossible to accommodate use cases where the device and the cpu need
concurrent access to a dma buffer, if the dma buffer isn't in dma
coherent memory.

If the dma buffer is in dma coherent memory, and we don't need swiotlb,
then we don't need the dma_sync functionality. 

Specifically for swiotlb, if the swiotlb buffer is in dma coherent
memory, the driver could peek the swiotlb buffer, but I have no idea if
we can provide a remotely sane API for that. The point is the device
would have peek not via a pointer to the original buffer, but get
suitable pointer to the bounce buffer, which would be probably be
considered valid, as long as the mapping is valid. Honestly IMHO quite
ugly but I see no other way. 

Regards,
Halil
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
