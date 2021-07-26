Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489C0C4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 15:26:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87A460F55
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 15:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E87A460F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B933A830C0;
	Mon, 26 Jul 2021 15:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGq50xwYe14h; Mon, 26 Jul 2021 15:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 881E083103;
	Mon, 26 Jul 2021 15:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69EA1C001A;
	Mon, 26 Jul 2021 15:26:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB5EC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 15:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F23082F6C
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 15:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FScf7e5zGapY for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 15:26:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3CF882E5F
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 15:26:01 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16QFHfwD021448; Mon, 26 Jul 2021 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1sFHS5zJLlrMstVK/2aj2Ztpod8AixmHr4YcumEDeN8=;
 b=BLmHJHHKVeJ7IJsLfOxF1ztyHIpconmdEn6Den5lhv5f7Wd/SedRdfhl8N/HqQRBpzL9
 MOa9TSLrqg0eFmhuN4/UIldU7Rbw2oe9ghBBcsTF7KF/yw565cG33i1cPx8afVByHptr
 R07pPJFwrWAFEIta1m8rcnY3RKOK5wS9ZmCIzt01gT/G2ZPtgkftjUuNb0jeXfrEi24X
 /kOZCVbBT+wYJHH8saytxY7CIPsgSGhvFgH+M0XstdcNSr2YfIzT0w/jfYYVW7IOmG+D
 mqm3Vt2sDbkYX/02hf2EoXReJCwPMoibHNNfZDAY+j0/wNQD+Xz+48fYG4WMm91yxsqw Zg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3a1y2hsgp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jul 2021 11:25:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QFNrV8027759;
 Mon, 26 Jul 2021 15:25:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 3a0ag8rrmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jul 2021 15:25:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 16QFMxFQ27984156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jul 2021 15:22:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BD1BA405F;
 Mon, 26 Jul 2021 15:25:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D80B2A4062;
 Mon, 26 Jul 2021 15:25:32 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.33.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 26 Jul 2021 15:25:32 +0000 (GMT)
Date: Mon, 26 Jul 2021 17:25:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2 1/1] s390/pv: fix the forcing of the swiotlb
Message-ID: <20210726172523.0fbdda60.pasic@linux.ibm.com>
In-Reply-To: <YPtejB62iu+iNrM+@fedora>
References: <20210723231746.3964989-1-pasic@linux.ibm.com>
 <YPtejB62iu+iNrM+@fedora>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ldcOjuF41nHbAb-Cj17FjrUVXmxMMXk9
X-Proofpoint-ORIG-GUID: ldcOjuF41nHbAb-Cj17FjrUVXmxMMXk9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-26_10:2021-07-26,
 2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260086
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Will Deacon <will@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Fri, 23 Jul 2021 20:27:56 -0400
Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:

> On Sat, Jul 24, 2021 at 01:17:46AM +0200, Halil Pasic wrote:
> > Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> > swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> > before the swiotlb is initialised. Otherwise
> > io_tlb_default_mem->force_bounce will not get set to true, and devices
> > that use (the default) swiotlb will not bounce despite switolb_force
> > having the value of SWIOTLB_FORCE.
> > 
> > Let us restore swiotlb functionality for PV by fulfilling this new
> > requirement.
> > 
> > This change addresses what turned out to be a fragility in
> > commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected
> > virtualization"), which ain't exactly broken in its original context,
> > but could give us some more headache if people backport the broken
> > change and forget this fix.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> > Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> > Cc: stable@vger.kernel.org #5.3+
> > 
> > ---  
> 
> Picked it up and stuck it in linux-next with the other set of patches (Will's fixes).

Thanks!

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
