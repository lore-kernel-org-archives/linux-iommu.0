Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF1AC433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 20:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBCF941923;
	Fri, 25 Mar 2022 20:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XjX2qSAvRcD; Fri, 25 Mar 2022 20:21:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E32FF41921;
	Fri, 25 Mar 2022 20:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1A2DC002C;
	Fri, 25 Mar 2022 20:21:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCD2FC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D22960B6F
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XuQBxJnvcATT for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 20:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91E4D60B00
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:45 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PHhYtN022151
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : reply-to : mime-version : content-type; s=pp1;
 bh=9ZJq0fu/agTNFC4TkzFFqIrgDHxSyLKCU5xKg5Foa80=;
 b=mnUy4jI01jw24Nq7+0nVdHt4v4LhVoHOXqKl37MNomQkXH9kKRC0WcVpC5BGuwiAsP5s
 y2LQt5dtE5Mnd48CYUTbJaBnmSh+tYuLJjwzn3r99+Nu4LwJsJFjMTGVf7qRjrSKLJLL
 q/pi2J+O3f3td5ZTBlsx7smZA0sGracu5oyPDOYpAHDqIqckgCXQA16gPiT9AU0nTNbx
 m6IJS8dYZVw3fWIrVTyJr005qlSEdfkJrFaJX9MlpgoQZ5/6h1WT976wixXJ4AQo65Bb
 8cy3+tVv/PTTMAgv56BzqEZkvbEyZ6zH/Af7p3CSjtbPLkpBOodHTNxMYYqyWKI8TnQO 0A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3f0c708w5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:44 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22PK3MkX003816
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:43 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 3ew6tb18n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 20:06:43 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22PK6fBI47645084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Mar 2022 20:06:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14303AC065;
 Fri, 25 Mar 2022 20:06:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBE60AC05B;
 Fri, 25 Mar 2022 20:06:40 +0000 (GMT)
Received: from porter (unknown [9.1.104.123])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Mar 2022 20:06:40 +0000 (GMT)
Received: from dfsmith by porter with local (Exim 4.92)
 (envelope-from <dfsmith@porter.almaden.ibm.com>)
 id 1nXqCm-0007qT-4q; Fri, 25 Mar 2022 13:06:40 -0700
Date: Fri, 25 Mar 2022 13:06:40 -0700
From: "Daniel F. Smith" <dfsmith@us.ibm.com>
To: iommu@lists.linux-foundation.org
Subject: Bug report: VFIO map/unmep mem subject to race and DMA data goes to
 incorrect page (4.18.0)
Message-ID: <20220325200640.GA29990@porter.almaden.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k-5Z9wBwaUn8t2K1iLFEPsav_y9HcBu0
X-Proofpoint-ORIG-GUID: k-5Z9wBwaUn8t2K1iLFEPsav_y9HcBu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_06,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250111
X-Mailman-Approved-At: Fri, 25 Mar 2022 20:21:31 +0000
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
Reply-To: dfsmith@us.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This email is to document an insidious (incorrect data, no error or warning)
VFIO bug found when using the Intel IOMMU to perform DMA transfers; and the
associated workaround.

There may be security implications (unsure).

/sys/devices/virtual/iommu/dmar0/intel-iommu/version: 1:0
/sys/devices/virtual/iommu/dmar0/intel-iommu/cap: d2008c40660462
Linux xxxxx.ibm.com 4.18.0-348.20.1.el8_5.x86_64 #1 SMP Tue Mar 8 12:56:54 EST 2022 x86_64 x86_64 x86_64 GNU/Linux
Red Hat Enterprise Linux release 8.5 (Ootpa)

In our testing of VFIO DMA to an FPGA card in rootless mode, we discovered a
glitch where DMA data are transferred to/from the incorrect page.  It
appears timing based.  Under some specific conditions the test could trigger
the bug every loop.  Sometimes the bug would only emerge after 20+ minutes
of testing.

Basics of test:
	Get memory with mmap(anonymous): size can change.
	VFIO_IOMMU_MAP_DMA with a block of memory, fixed IOVA.
	Fill memory with pattern.
	Do DMA transfer to FPGA from memory at IOVA.
	Do DMA transfer from FPGA to memory at IOVA+offset.
	Compare memory to ensure match.  Miscompare is bug.
	VFIO_IOMMU_UNMAP_DMA 
	unmap()
	Repeat.

Using the fixed IOVA address* caused sporadic memory miscompares.  The
nature of the miscompares is that the received data was mixed with pages
that had been returned by mmap in a *previous* loop.

Workaround: Randomizing the IOVA eliminated the memory miscompares.

Hypothesis/conjecture: Possible race condition in UNMAP_DMA such that pages
can be released/munlocked *after* the MAP_DMA with the same IOVA has
occurred.

Suggestion: Document issue when using fixed IOVA, or fix if security is a
concern.

Daniel F. Smith
dfsmith@us.ibm.com

* We cannot use physical page address for the IOVA since we are running
  without root, so /proc/pagemap is blanked out.  We also cannot use the VMA
  as the IOVA since MAP_DMA only permits us up to bit 39 in the IOVA.

VMA = virtual memory address (process space)
IOVA = IOV / IOMMU address
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
