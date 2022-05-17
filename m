Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F14C433FE
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 10:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90203419A1;
	Tue, 17 May 2022 10:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-pwn3LjdgTY; Tue, 17 May 2022 10:17:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29B9E4199D;
	Tue, 17 May 2022 10:17:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083D0C0039;
	Tue, 17 May 2022 10:17:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA3BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E200240BD8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pI93igtlZN9q for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 10:17:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49C46400FD
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:17:44 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H8tk6O017920;
 Tue, 17 May 2022 10:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c/4EKALUn6ciriFQdTtpqBM9BWeoPsASPG0BiB5ElA8=;
 b=qVk0u2h+mOYfY5RqhHv7QNoA8Sew+rKAfiWPuK9NRrwUF06TuQAT8JR/PTviHlPNzVOB
 X7PApzBdZrGrJAJ9rQDS3hnKhGKTflNJVUMEIGTVQmyDGRt+MPTgkU2pPUoZsOl+BEbp
 BohHbli1jT0QKg8cfXVWBpVr8s6cwWmKAbxD3j7dGSeeUD8ZzDOQwmmfGbnANQsfPBJA
 HdrSxoE+5eI/EN/kUGw0yIJFTnzuRHfHJpVNfRDK0MtpvB2m3UQ5ZGqq2dr3r7lxqtsU
 XnUVfhWXyKXbsvmPPC6lMDHzvqDb9+rXZIOfi/KPAzz1xgSLMYdbEZ1uu5OlS9kUjuwr Mw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g48mkhs93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 10:17:34 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HAAQX6020280;
 Tue, 17 May 2022 10:17:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3g23pjc178-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 10:17:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 24HA3eJG43057556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 10:03:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72484A4054;
 Tue, 17 May 2022 10:17:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E982A405B;
 Tue, 17 May 2022 10:17:30 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 May 2022 10:17:30 +0000 (GMT)
Message-ID: <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 17 May 2022 12:17:29 +0200
In-Reply-To: <20220517083657.GA16377@lst.de>
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
 <20220517083657.GA16377@lst.de>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: daMTbgWliszemDDXT8VuhG2UlOwD9Wve
X-Proofpoint-ORIG-GUID: daMTbgWliszemDDXT8VuhG2UlOwD9Wve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=679 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170060
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, 2022-05-17 at 10:36 +0200, Christoph Hellwig wrote:
> On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
> > In __iommu_dma_alloc_noncontiguous() the value returned by
> > iommu_map_sg_atomic() is checked for being smaller than size. Before
> > commit ad8f36e4b6b1 ("iommu: return full error code from
> > iommu_map_sg[_atomic]()") this simply checked if the requested size was
> > successfully mapped.
> > 
> > After that commit iommu_map_sg_atomic() may also return a negative
> > error value. In principle this too would be covered by the existing
> > check. There is one problem however, as size is of type size_t while the
> > return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
> > converted to size_t and negative error values end up as very large
> > positive values making the check succeed. Fix this by making the return
> > type visible with a local variable and add an explicit cast to ssize_t.
> > 
> > Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> I don't see what the point of the newly added local variable is here.
> Just casting size should be all that is needed as far as I can tell.

No technical reason just found it easier to read and more descriptive.
I'll sent a v2 with just the cast, it does simplify the commit message.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
