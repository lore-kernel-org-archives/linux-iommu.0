Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20A3C433F5
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 10:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E5C58462F;
	Fri, 20 May 2022 10:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUUePaQj-jWw; Fri, 20 May 2022 10:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DD8D84651;
	Fri, 20 May 2022 10:30:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A1AC0032;
	Fri, 20 May 2022 10:30:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03071C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5F9B84651
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:30:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y0cBJhrAfmVL for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 10:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 628038462F
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:30:52 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K7nGjP022845;
 Fri, 20 May 2022 10:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SAwEXgmn+ug7Ywtt15h7zATBYWFQXhVY/ziQbb8IdbE=;
 b=aWFvuz5UYZbLHdI1qm3nNpf2gi025MZH+E5FQFSiseGJMXeKsQX4CLWdafs7ppXNpCeT
 7bWRbQOK3BalA0fidpGCl+Bi5Y5vW88B8+PH3ZjgEU+Ivwfi3skAijjZAjQJrellzhSZ
 +y02UW2VF7VaSj4sM7gQHRDmIEa4cCRKAjx7cTsFV4lMoG9VuvvL4wv278c/7wSOXYc2
 ot9JUs19fFgaJik3Aop8hXyCUbBNFmWeRFdrmN0r/kDYqXBypZLx04GoxEHL+dmRo+oX
 W9GG3mfvv15FJal6P7KL+PPL1cQ/DU5wmuIYmLDQRXmvXXAsfbshxGUAlmMUu/Cmel22 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g63a96wyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 May 2022 10:30:41 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KAQHKP010615;
 Fri, 20 May 2022 10:30:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g63a96wy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 May 2022 10:30:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KASk1w031045;
 Fri, 20 May 2022 10:30:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 3g2429gmh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 May 2022 10:30:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 24KAGcts50201020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 May 2022 10:16:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A497A405F;
 Fri, 20 May 2022 10:30:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52DDAA4054;
 Fri, 20 May 2022 10:30:34 +0000 (GMT)
Received: from sig-9-145-82-10.uk.ibm.com (unknown [9.145.82.10])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 20 May 2022 10:30:34 +0000 (GMT)
Message-ID: <41dd3f695c57a12fc5e68a3ed818940252cdb69f.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: tolerate repeat attach_dev calls
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, jgg@nvidia.com, joro@8bytes.org
Date: Fri, 20 May 2022 12:30:33 +0200
In-Reply-To: <20220519182929.581898-1-mjrosato@linux.ibm.com>
References: <20220519182929.581898-1-mjrosato@linux.ibm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UPQNWYGYN2jfEEnpr0kh6tsiw-ImLUir
X-Proofpoint-ORIG-GUID: lZwqxU0pyHDPdiisXyarqcrrM_OytcKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=768 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200073
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 cohuck@redhat.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, will@kernel.org
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

On Thu, 2022-05-19 at 14:29 -0400, Matthew Rosato wrote:
> Since commit 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must
> always assign a domain") s390-iommu will get called to allocate multiple
> unmanaged iommu domains for a vfio-pci device -- however the current
> s390-iommu logic tolerates only one.  Recognize that multiple domains can
> be allocated and handle switching between DMA or different iommu domain
> tables during attach_dev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---

I know it's applied already and no need to add my R-b but:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
