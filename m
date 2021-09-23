Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE30C433FE
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:01:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F35B60F11
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F35B60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7DFB40192;
	Thu, 23 Sep 2021 12:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUkyUbJpdSW5; Thu, 23 Sep 2021 12:01:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 663B34063B;
	Thu, 23 Sep 2021 12:01:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 417B5C0011;
	Thu, 23 Sep 2021 12:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53998C0011
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AFF1414BA
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNQZkZxYN1e4 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:01:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D74440650
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:01:29 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NAdUcU003364; 
 Thu, 23 Sep 2021 08:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=pXzEf65A4Oe5+XzfRr8terVnfyIyuO6PQs0+F8aXgGc=;
 b=ZCv5VVg5Axl96NC4/j5oW2leA+TyRu7PTszC85LX7OnyuvdR/QPrxFJvHee6+ph9/1Ah
 rUd/1Dr4tZ5yXYAiKoNA4l0g4riJzCer09eV4KmKCsnovao7Ujg6/MQzQ6IVb2C5LRSL
 6WitPRreJzNPlii4WW55mXNNAxhzlImWjS7TBI5y3E9CuYqxTL+hR1eRpZFENX5WHVgo
 3bzeScRRqqA6eAdFzB/5aWdZYhNxC/HkliRolmuo1Xv4pKsUbXkIzU8GEpyYBQunYUKJ
 0M08Qqduz9x2e5o+taGQrQG0ce7A7g963Zzijz3wHvEhl/y43e2FXQI9OwpYg11CHmgU 9g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3b8p4dcmbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Sep 2021 08:01:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18NBvwov029624;
 Thu, 23 Sep 2021 12:01:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06fra.de.ibm.com with ESMTP id 3b7q6ps42c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Sep 2021 12:01:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 18NC18Jk56885734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Sep 2021 12:01:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 810B04C08B;
 Thu, 23 Sep 2021 12:01:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64DD54C089;
 Thu, 23 Sep 2021 12:01:06 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.159.121])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Sep 2021 12:01:06 +0000 (GMT)
Date: Thu, 23 Sep 2021 15:01:04 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
Message-ID: <YUxsgN/uolhn1Ok+@linux.ibm.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fe2SFaLdoxw706nrVmE8bleSLkHdGrzC
X-Proofpoint-ORIG-GUID: fe2SFaLdoxw706nrVmE8bleSLkHdGrzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_04,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxlogscore=613 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230076
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kasan-dev@googlegroups.com, xen-devel@lists.xenproject.org,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Sep 23, 2021 at 11:47:48AM +0200, Christophe Leroy wrote:
> =

> =

> Le 23/09/2021 =E0 09:43, Mike Rapoport a =E9crit=A0:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > =

> > For ages memblock_free() interface dealt with physical addresses even
> > despite the existence of memblock_alloc_xx() functions that return a
> > virtual pointer.
> > =

> > Introduce memblock_phys_free() for freeing physical ranges and repurpose
> > memblock_free() to free virtual pointers to make the following pairing
> > abundantly clear:
> > =

> > 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> > 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);
> > =

> > 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
> > 	void memblock_free(void *ptr, size_t size);
> > =

> > Replace intermediate memblock_free_ptr() with memblock_free() and drop
> > unnecessary aliases memblock_free_early() and memblock_free_early_nid().
> > =

> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> =

> > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> > index 1a04e5bdf655..37826d8c4f74 100644
> > --- a/arch/s390/kernel/smp.c
> > +++ b/arch/s390/kernel/smp.c
> > @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
> >   			/* Get the CPU registers */
> >   			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
> >   	}
> > -	memblock_free(page, PAGE_SIZE);
> > +	memblock_phys_free(page, PAGE_SIZE);
> >   	diag_amode31_ops.diag308_reset();
> >   	pcpu_set_smt(0);
> >   }
> > @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
> >   	/* Add CPUs present at boot */
> >   	__smp_rescan_cpus(info, true);
> > -	memblock_free_early((unsigned long)info, sizeof(*info));
> > +	memblock_free(info, sizeof(*info));
> >   }
> >   /*
> =

> I'm a bit lost. IIUC memblock_free_early() and memblock_free() where
> identical.

Yes, they were, but all calls to memblock_free_early() were using
__pa(vaddr) because they had a virtual address at hand.

> In the first hunk memblock_free() gets replaced by memblock_phys_free()
> In the second hunk memblock_free_early() gets replaced by memblock_free()

In the first hunk the memory is allocated with memblock_phys_alloc() and we
have a physical range to free. In the second hunk the memory is allocated
with memblock_alloc() and we are freeing a virtual pointer.
 =

> I think it would be easier to follow if you could split it in several
> patches:

It was an explicit request from Linus to make it a single commit:

  but the actual commit can and should be just a single commit that just
  fixes 'memblock_free()' to have sane interfaces.

I don't feel strongly about splitting it (except my laziness really
objects), but I don't think doing the conversion in several steps worth the
churn.

> - First patch: Create memblock_phys_free() and change all relevant
> memblock_free() to memblock_phys_free() - Or change memblock_free() to
> memblock_phys_free() and make memblock_free() an alias of it.
> - Second patch: Make memblock_free_ptr() become memblock_free() and change
> all remaining callers to the new semantics (IIUC memblock_free(__pa(ptr))
> becomes memblock_free(ptr) and make memblock_free_ptr() an alias of
> memblock_free()
> - Fourth patch: Replace and drop memblock_free_ptr()
> - Fifth patch: Drop memblock_free_early() and memblock_free_early_nid() (=
All
> users should have been upgraded to memblock_free_phys() in patch 1 or
> memblock_free() in patch 2)
> =

> Christophe

-- =

Sincerely yours,
Mike.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
