Return-Path: <SRS0=yzib=O2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38DAC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 13:12:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5AD610A1
	for <iommu@archiver.kernel.org>; Wed,  6 Oct 2021 13:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C5AD610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7E70401D0;
	Wed,  6 Oct 2021 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsHcw9tvu0o7; Wed,  6 Oct 2021 13:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE47B40100;
	Wed,  6 Oct 2021 13:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A0DC0011;
	Wed,  6 Oct 2021 13:12:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98738C000D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 13:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DE1160E58
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 13:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id if3O7Kbpc9Bz for <iommu@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 13:12:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F4B360673
 for <iommu@lists.linux-foundation.org>; Wed,  6 Oct 2021 13:12:14 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196CmhMx021012; 
 Wed, 6 Oct 2021 09:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=s9K5Ipde3dftytgvZMayo8mNzgFKiuukbRQGJiKnxTM=;
 b=Udac3sgtIPThpqyE22P9xEAYP7BzyVVo1V0malK02beMpqEzpNO7eUefjSO9O4IiB5Qd
 Igeo8dcI+VKV+/oGQ73NKm5Hzq6Q+zHPH3Y+bBSixCSdEnTFyX0+vgdGOiut0w+/43H3
 A/8f4qxWDnwBC33n6t3xmf9cOxJAU48cSXahr9+huTaKT6Xr8ONRSU3srwMlyJMZEQGJ
 6zyy8tW91mjmsURp2m0z9pxWCWnMRsDLLNRcElwu1ELZWpxaTpGDwMqgJDE33+Zoj0Rm
 joxk17eK17FArTzz8Ma1X5o2Mk1tUbl8nco9TDKXSnM6ZinFi77Fd6Zm6v6BECEA02Xp nQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bh11u6a9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Oct 2021 09:10:53 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196D2ef1008269;
 Wed, 6 Oct 2021 13:10:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 3beepjwpse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Oct 2021 13:10:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 196DAk6t62652756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Oct 2021 13:10:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD9311C066;
 Wed,  6 Oct 2021 13:10:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B77F11C05E;
 Wed,  6 Oct 2021 13:10:45 +0000 (GMT)
Received: from thinkpad (unknown [9.171.8.189])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed,  6 Oct 2021 13:10:45 +0000 (GMT)
Date: Wed, 6 Oct 2021 15:10:43 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Hamza Mahfooz <someguy@effective-light.com>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
Message-ID: <20211006151043.61fe9613@thinkpad>
In-Reply-To: <20211001145256.0323957a@thinkpad>
References: <20210518125443.34148-1-someguy@effective-light.com>
 <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
 <20210914154504.z6vqxuh3byqwgfzx@skbuf>
 <185e7ee4-3749-4ccb-6d2e-da6bc8f30c04@linux.ibm.com>
 <20211001145256.0323957a@thinkpad>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dsDMR_TMvH-Qy8XSrAP_p36Qp2E3zSZi
X-Proofpoint-GUID: dsDMR_TMvH-Qy8XSrAP_p36Qp2E3zSZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_02,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060082
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Robin Murphy <robin.murphy@arm.com>,
 Karsten Graul <kgraul@linux.ibm.com>
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

On Fri, 1 Oct 2021 14:52:56 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Thu, 30 Sep 2021 15:37:33 +0200
> Karsten Graul <kgraul@linux.ibm.com> wrote:
> 
> > On 14/09/2021 17:45, Ioana Ciornei wrote:
> > > On Wed, Sep 08, 2021 at 10:33:26PM -0500, Jeremy Linton wrote:
> > >> +DPAA2, netdev maintainers
> > >> Hi,
> > >>
> > >> On 5/18/21 7:54 AM, Hamza Mahfooz wrote:
> > >>> Since, overlapping mappings are not supported by the DMA API we should
> > >>> report an error if active_cacheline_insert returns -EEXIST.
> > >>
> > >> It seems this patch found a victim. I was trying to run iperf3 on a
> > >> honeycomb (5.14.0, fedora 35) and the console is blasting this error message
> > >> at 100% cpu. So, I changed it to a WARN_ONCE() to get the call trace, which
> > >> is attached below.
> > >>
> > > 
> > > These frags are allocated by the stack, transformed into a scatterlist
> > > by skb_to_sgvec and then DMA mapped with dma_map_sg. It was not the
> > > dpaa2-eth's decision to use two fragments from the same page (that will
> > > also end un in the same cacheline) in two different in-flight skbs.
> > > 
> > > Is this behavior normal?
> > > 
> > 
> > We see the same problem here and it started with 5.15-rc2 in our nightly CI runs.
> > The CI has panic_on_warn enabled so we see the panic every day now.
> 
> Adding a WARN for a case that be detected false-positive seems not
> acceptable, exactly for this reason (kernel panic on unaffected
> systems).
> 
> So I guess it boils down to the question if the behavior that Ioana
> described is legit behavior, on a system that is dma coherent. We
> are apparently hitting the same scenario, although it could not yet be
> reproduced with debug printks for some reason.
> 
> If the answer is yes, than please remove at lease the WARN, so that
> it will not make systems crash that behave valid, and have
> panic_on_warn set. Even a normal printk feels wrong to me in that
> case, it really sounds rather like you want to fix / better refine
> the overlap check, if you want to report anything here.

Dan, Christoph, any opinion?

So far it all looks a lot like a false positive, so could you please
see that those patches get reverted? I do wonder a bit why this is
not an issue for others, we surely cannot be the only ones running
CI with panic_on_warn.

We would need to disable DEBUG_DMA if this WARN stays in, which
would be a shame. Of course, in theory, this might also indicate
some real bug, but there really is no sign of that so far.

Having multiple sg elements in the same page (or cacheline) is
valid, correct? And this is also not a decision of the driver
IIUC, so if it was bug, it should be addressed in common code,
correct?

> 
> BTW, there is already a WARN in the add_dma_entry() path, related
> to cachlline overlap and -EEXIST:
> 
> add_dma_entry() -> active_cacheline_insert() -> -EEXIST ->
> active_cacheline_inc_overlap()
> 
> That will only trigger when "overlap > ACTIVE_CACHELINE_MAX_OVERLAP".
> Not familiar with that code, but it seems that there are now two
> warnings for more or less the same, and the new warning is much more
> prone to false-positives.
> 
> How do these 2 warnings relate, are they both really necessary?
> I think the new warning was only introduced because of some old
> TODO comment in add_dma_entry(), see commit 2b4bbc6231d78
> ("dma-debug: report -EEXIST errors in add_dma_entry").
> 
> That comment was initially added by Dan long time ago, and he
> added several fix-ups for overlap detection after that, including
> the "overlap > ACTIVE_CACHELINE_MAX_OVERLAP" stuff in
> active_cacheline_inc_overlap(). So could it be that the TODO
> comment was simply not valid any more, and better be removed
> instead of adding new / double warnings, that also generate
> false-positives and kernel crashes?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
