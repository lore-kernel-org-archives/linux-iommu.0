Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E8C4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 12:54:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0457061A81
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 12:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0457061A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2A1882CD4;
	Tue, 27 Jul 2021 12:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4g6sHh0A1Mo3; Tue, 27 Jul 2021 12:54:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA84382C3E;
	Tue, 27 Jul 2021 12:54:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91ECEC001A;
	Tue, 27 Jul 2021 12:54:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A703FC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A29526061E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2-zWhPBEe5X for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 12:54:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDDFD60617
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:54:46 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16RCfO9H099539; Tue, 27 Jul 2021 08:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rW1zEUuKvDuL0Ee74R7Cv0tiXi3AGSCkEJMUa6cnGaw=;
 b=I5wY3Og6UlCtTShbC40RyfI0gg2xjyMFCI6qcvq1stGYAxUOCkU3L/bH/kY1SXZfHjdt
 sOepC0QG9OJEX0IQzH/B5ALqWoobawSNV1xcV1PkJDQeZYRambUzX49qGJKXCKENV7WM
 zbdIoeJ87IYf6kT+DkbeCZfRF3opCQWe8n9ZeJ2gqkZDNUPk7u/gbIUyA8KqlGSa4A0F
 2fufPpkH5/I6GYuH4WhcDgbp7O3n/ot9lc+/6ffSHowgsTJch5fmsRJqC13r/J0tkixt
 49BasgayhL/p0cNHQwp6wx3X6wE0PUXNtCQHM8g0uYwiqQKsbYBJQnnFv4yZckQ9UuOj jA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3a2j2u0unp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jul 2021 08:54:24 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RCsBCA003378;
 Tue, 27 Jul 2021 12:54:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma01fra.de.ibm.com with ESMTP id 3a235kr951-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jul 2021 12:54:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16RCsJre26280240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jul 2021 12:54:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6150F42049;
 Tue, 27 Jul 2021 12:54:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D510042042;
 Tue, 27 Jul 2021 12:54:15 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.165.137])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jul 2021 12:54:15 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] s390/pv: fix the forcing of the swiotlb
To: Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20210723231746.3964989-1-pasic@linux.ibm.com>
 <YPtejB62iu+iNrM+@fedora>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <a89f1add-b0fb-1069-cb30-78864e399b19@de.ibm.com>
Date: Tue, 27 Jul 2021 14:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPtejB62iu+iNrM+@fedora>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i9Zr-lv1wBkQV6w9MJeAAPuwGQc_9CBR
X-Proofpoint-ORIG-GUID: i9Zr-lv1wBkQV6w9MJeAAPuwGQc_9CBR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-27_07:2021-07-27,
 2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270073
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Will Deacon <will@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 24.07.21 02:27, Konrad Rzeszutek Wilk wrote:
> On Sat, Jul 24, 2021 at 01:17:46AM +0200, Halil Pasic wrote:
>> Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
>> swiotlb data bouncing") if code sets swiotlb_force it needs to do so
>> before the swiotlb is initialised. Otherwise
>> io_tlb_default_mem->force_bounce will not get set to true, and devices
>> that use (the default) swiotlb will not bounce despite switolb_force
>> having the value of SWIOTLB_FORCE.
>>
>> Let us restore swiotlb functionality for PV by fulfilling this new
>> requirement.
>>
>> This change addresses what turned out to be a fragility in
>> commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected
>> virtualization"), which ain't exactly broken in its original context,
>> but could give us some more headache if people backport the broken
>> change and forget this fix.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
>> Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
>> Cc: stable@vger.kernel.org #5.3+
>>
>> ---
> 
> Picked it up and stuck it in linux-next with the other set of patches (Will's fixes).

Can you push out to kernel.org?
  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
