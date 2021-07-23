Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D6C4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 01:13:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7233060E74
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 01:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7233060E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3516C400CE;
	Fri, 23 Jul 2021 01:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4WHJlEuMeGy; Fri, 23 Jul 2021 01:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 126BA4017B;
	Fri, 23 Jul 2021 01:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7062C0010;
	Fri, 23 Jul 2021 01:13:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55EC7C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 01:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30BE84017D
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 01:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id boxemDn_4TEv for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3734E4017B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 01:13:06 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16N14DRN130535; Thu, 22 Jul 2021 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0UDzfZxoUw+wVSJ5ie/85dFi0GdTXZ9QQbsSHQJNrSY=;
 b=gljmLXFpmqerbaBRcEqHgUqVFxtxombBxdPFtkhgg61Osmx8yelGw5vwDaMAOf2FyQxi
 SaJZvEWqW5aOb/gfMbU4bglFhCerBJidWPfswDtQYtGe8lnu6kJBnJP36jqu/1D0o79k
 MOpFY9ioXmwSm7HML3BwK8ipa/QXX9jA7iNSeantHl3esrFQiw0JW9yvlZnFGXGku84M
 1SJfUk3xsCreXDJJAhMWEvd2RYelB+DLxAnDaxoQxJ2qLmIz3mMQ64NyPo87M2LSh8pY
 ZoIhMG5FGuVGVPeWFZkpT+NcGNlpl+KWy6jF9ftjS+KRdBnWGUyjvK2anQUbqxgP1ewK qw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39yjfk1xcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jul 2021 21:13:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N1CxZm003767;
 Fri, 23 Jul 2021 01:12:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 39vng72ccp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jul 2021 01:12:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16N1CtsQ29229418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jul 2021 01:12:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FC365204E;
 Fri, 23 Jul 2021 01:12:55 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.93.118])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 89CCD5204F;
 Fri, 23 Jul 2021 01:12:54 +0000 (GMT)
Date: Fri, 23 Jul 2021 03:12:52 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <20210723031252.655d6a83.pasic@linux.ibm.com>
In-Reply-To: <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
 <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ae3eLa12W-x0ipkL-mPwp06xYhUcnGIf
X-Proofpoint-GUID: Ae3eLa12W-x0ipkL-mPwp06xYhUcnGIf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-22_16:2021-07-22,
 2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230005
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
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

On Thu, 22 Jul 2021 21:22:58 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 20.07.21 15:38, Will Deacon wrote:
> > Hi again, folks,
> > 
> > This is version two of the patch series I posted yesterday:
> > 
> >    https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> > 
> > The only changes since v1 are:
> > 
> >    * Squash patches 2 and 3, amending the commit message accordingly
> >    * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> > 
> > I'd usually leave it a bit longer between postings, but since this fixes
> > issues with patches in -next I thought I'd spin a new version immediately.
> > 
> > Cheers,  
> 
> FWIW, I just bisected virtio-errors with secure execution mode
> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
> 
> to
> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
> Author: Claire Chang <tientzu@chromium.org>
> Date:   Thu Jun 24 23:55:20 2021 +0800
> 
>       swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
> 
> Unfortunately this patch series does NOT fix this issue, so it seems that even more
> things are broken.
> 
> Any idea what else might be broken?

I've done some debugging, and I think I know what is going on. Since
that commit we need to set force_swiotlb before the swiotlb itself is
initialized. So the patch below should fix the problem.

--------------------8<-------------------------------------

From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 23 Jul 2021 02:57:06 +0200
Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb

Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
swiotlb data bouncing") if code sets swiotlb_force it needs to do so
before the swiotlb is initialised. Otherwise
io_tlb_default_mem->force_bounce will not get set to true, and devices
that use (the default) swiotlb will not bounce  despite switolb_force
having the value of SWIOTLB_FORCE.

Let us restore swiotlb functionality for PV by fulfilling this new
requirement.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8ac710de1ab1..07bbee9b7320 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -186,9 +186,9 @@ static void pv_init(void)
 		return;
 
 	/* make sure bounce buffers are shared */
+	swiotlb_force = SWIOTLB_FORCE;
 	swiotlb_init(1);
 	swiotlb_update_mem_attributes();
-	swiotlb_force = SWIOTLB_FORCE;
 }
 
 void __init mem_init(void)
-- 
2.29.2
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
