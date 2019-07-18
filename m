Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BDC7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AB721849
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 16:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AB721849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D78C19C8;
	Thu, 18 Jul 2019 16:43:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EECF0198C
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 16:43:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7436D8A8
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 16:43:41 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6IGgbET049742; Thu, 18 Jul 2019 12:43:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ttustsud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 18 Jul 2019 12:43:31 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6IGhVX0052246;
	Thu, 18 Jul 2019 12:43:31 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
	[169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ttustsucm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 18 Jul 2019 12:43:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x6IGeMfn002703; Thu, 18 Jul 2019 16:43:30 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
	(b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 2trtmrh27j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 18 Jul 2019 16:43:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x6IGhSeD59507006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Jul 2019 16:43:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6053EBE058;
	Thu, 18 Jul 2019 16:43:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED650BE053;
	Thu, 18 Jul 2019 16:43:23 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jul 2019 16:43:23 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<20190718032858.28744-7-bauerman@linux.ibm.com>
	<20190718084456.GE24562@lst.de>
	<20190718150123.4230a00c.pasic@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-reply-to: <20190718150123.4230a00c.pasic@linux.ibm.com>
Date: Thu, 18 Jul 2019 13:43:20 -0300
Message-ID: <87blxr47kn.fsf@morokweng.localdomain>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-18_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907180175
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	iommu@lists.linux-foundation.org, Ingo
	Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Lendacky <Thomas.Lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


Halil Pasic <pasic@linux.ibm.com> writes:

> On Thu, 18 Jul 2019 10:44:56 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>
>> > -/* are we a protected virtualization guest? */
>> > -bool sev_active(void)
>> > -{
>> > -	return is_prot_virt_guest();
>> > -}
>> > -
>> >  bool force_dma_unencrypted(struct device *dev)
>> >  {
>> > -	return sev_active();
>> > +	return is_prot_virt_guest();
>> >  }
>> 
>> Do we want to keep the comment for force_dma_unencrypted?
>
> Yes we do. With the comment transferred:
>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks for your review.

Here is the new version. Should I send a new patch series with this
patch and the Reviewed-by on the other ones?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


From 1726205c73fb9e29feaa3d8909c5a1b0f2054c04 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Mon, 15 Jul 2019 20:50:43 -0300
Subject: [PATCH v4] s390/mm: Remove sev_active() function

All references to sev_active() were moved to arch/x86 so we don't need to
define it for s390 anymore.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h | 1 -
 arch/s390/mm/init.c                 | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index ff813a56bc30..2542cbf7e2d1 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 static inline bool mem_encrypt_active(void) { return false; }
-extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 78c319c5ce48..6c43a1ed1beb 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -156,14 +156,9 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 }
 
 /* are we a protected virtualization guest? */
-bool sev_active(void)
-{
-	return is_prot_virt_guest();
-}
-
 bool force_dma_unencrypted(struct device *dev)
 {
-	return sev_active();
+	return is_prot_virt_guest();
 }
 
 /* protected virtualization */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
