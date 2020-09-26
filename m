Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E184AC2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 13:56:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0742168B
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="stYoAHM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0742168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F6C886979;
	Sat, 26 Sep 2020 13:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2mmZvJdoMQ6; Sat, 26 Sep 2020 13:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B3E186963;
	Sat, 26 Sep 2020 13:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA18BC0891;
	Sat, 26 Sep 2020 13:56:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5525BC0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 12:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3ED7786500
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 12:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wSUVCKJ3HkS for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 12:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E4058526D
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 12:39:34 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08QCWRe0111727; Sat, 26 Sep 2020 08:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3MYKY040lEuw5jDKzV3PF147mCVYwbqY92Kcs2d9pHM=;
 b=stYoAHM4Idv9dsIru0fmgGg81Du4QTVpzAy3h7TyNOJeQLokKMLrJqIE4dCviuU9KwBb
 IsZSYnrpNZ+wsMMBawyZaunEhq0onbMYGNEe3hcH/FWrMyy7MwDtDDOGWflQ+m9zqGz8
 SsbpFbkp1/Tpa5IRfDPQPQ7KG60pXTMaQXHCKb/xbK9mrXkL4uqw+1nFonDjSDncarcQ
 Is+gIoez8CG1++CbuoWEy2GgeDRN8bzXXmZFe5+IyxB5C1JmLB1TjPvIbd2hJGmhxXuy
 1EErU5N4KtdBp5+VG58W6XUpLKMHS7LRSJzpbkuYAontzSSvj8OuNtPZc3DTB00JxD2Z iA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33t5er8cv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 26 Sep 2020 08:39:04 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08QCWWxS111972;
 Sat, 26 Sep 2020 08:39:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33t5er8cuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 26 Sep 2020 08:39:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08QCRuOI023314;
 Sat, 26 Sep 2020 12:39:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 33sw980bk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 26 Sep 2020 12:39:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08QCcva320513094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 26 Sep 2020 12:38:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57D25A4040;
 Sat, 26 Sep 2020 12:38:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36400A4057;
 Sat, 26 Sep 2020 12:38:55 +0000 (GMT)
Received: from localhost (unknown [9.145.18.16])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sat, 26 Sep 2020 12:38:55 +0000 (GMT)
Date: Sat, 26 Sep 2020 14:38:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@redhat.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <your-ad-here.call-01601123933-ext-6476@work.hours>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.992429909@linutronix.de>
 <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-26_10:2020-09-24,
 2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=948
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260111
X-Mailman-Approved-At: Sat, 26 Sep 2020 13:56:49 +0000
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-next@vger.kernel.org,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Sep 25, 2020 at 09:54:52AM -0400, Qian Cai wrote:
> On Wed, 2020-08-26 at 13:17 +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> > requires them or not. Architectures which are fully utilizing hierarchical
> > irq domains should never call into that code.
> > 
> > It's not only architectures which depend on that by implementing one or
> > more of the weak functions, there is also a bunch of drivers which relies
> > on the weak functions which invoke msi_controller::setup_irq[s] and
> > msi_controller::teardown_irq.
> > 
> > Make the architectures and drivers which rely on them select them in Kconfig
> > and if not selected replace them by stub functions which emit a warning and
> > fail the PCI/MSI interrupt allocation.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Today's linux-next will have some warnings on s390x:
> 
> .config: https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
>

Yes, as well as on mips and sparc which also don't FORCE_PCI.
This seems to work for s390:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b0b7acf07eb8..41136fbe909b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -192,3 +192,3 @@ config S390
        select PCI_MSI                  if PCI
-       select PCI_MSI_ARCH_FALLBACKS
+       select PCI_MSI_ARCH_FALLBACKS   if PCI
        select SET_FS
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
