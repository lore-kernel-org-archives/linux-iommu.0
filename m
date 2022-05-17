Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A02BC433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 10:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4079B60D57;
	Tue, 17 May 2022 10:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pccm6KB30xQQ; Tue, 17 May 2022 10:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 792B560BAC;
	Tue, 17 May 2022 10:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21696C0039;
	Tue, 17 May 2022 10:32:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D3DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8AF540474
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:32:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJL-YyVNEIOR for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 10:32:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D68C44025F
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 10:32:42 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAT5KK025732;
 Tue, 17 May 2022 10:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PcjdGuEDm0Uy4HFqQ0oqMFsTEP1sBNNpNA4Jw/4K3jU=;
 b=fTpv0TYcDKvlTsPgq1SqVjMEYam0Ij4F3ZMWc/qsCapdaNP+QZm5HKxOl5nGFvL50AvY
 zyCIp/DzWjcT97aih2gLMGE30/PoP3qYO115LWXgGijt1PJGPSwsA4yEGHTcmgUEy+Ge
 MRtzpuOCqaX2I72/Y5PwkHXp8XJusKy6BjmhHUy6k4l78EXK7HVu15iyN3EDmGBUD+V4
 S8X/4QvH7Ll1YnHsqNR70qfb9rpalGRBmXI3nhgOytMz7NP7sjBGU+8UpdB1CbmbxktT
 GTr0RjsbpcrUWeq5Erb38Pe7eoXhx035Vc8oTSz/JCNLFnbsjJyyKTbsbWPxyFY61UIv uQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g49yy02c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 10:32:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HANhIs002035;
 Tue, 17 May 2022 10:32:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3g2429c1yy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 10:32:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 24HAVw7W33292600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 10:31:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51B99A4062;
 Tue, 17 May 2022 10:32:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FBA4A4060;
 Tue, 17 May 2022 10:32:31 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 May 2022 10:32:31 +0000 (GMT)
Message-ID: <8183a172d9e13d5b69f00ce4382dcaeb5ecdb4f7.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/dma: Fix check for error return from
 iommu_map_sg_atomic()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Date: Tue, 17 May 2022 12:32:30 +0200
In-Reply-To: <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
References: <20220513153948.310119-1-schnelle@linux.ibm.com>
 <20220517083657.GA16377@lst.de>
 <27ae8b9f8e61dce4b31a37622e98b1c57b21b104.camel@linux.ibm.com>
 <0e9356ee-9ae0-fd6d-b4ba-b1f05d8ba144@arm.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cF-ugdLpC8p-7Qri5jsKNfrToZVf2fJL
X-Proofpoint-ORIG-GUID: cF-ugdLpC8p-7Qri5jsKNfrToZVf2fJL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 mlxlogscore=815 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170064
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Tue, 2022-05-17 at 11:18 +0100, Robin Murphy wrote:
> On 2022-05-17 11:17, Niklas Schnelle wrote:
> > On Tue, 2022-05-17 at 10:36 +0200, Christoph Hellwig wrote:
> > > On Fri, May 13, 2022 at 05:39:48PM +0200, Niklas Schnelle wrote:
> > > > In __iommu_dma_alloc_noncontiguous() the value returned by
> > > > iommu_map_sg_atomic() is checked for being smaller than size. Before
> > > > commit ad8f36e4b6b1 ("iommu: return full error code from
> > > > iommu_map_sg[_atomic]()") this simply checked if the requested size was
> > > > successfully mapped.
> > > > 
> > > > After that commit iommu_map_sg_atomic() may also return a negative
> > > > error value. In principle this too would be covered by the existing
> > > > check. There is one problem however, as size is of type size_t while the
> > > > return type of iommu_map_sg_atomic() is now of type ssize_t the latter gets
> > > > converted to size_t and negative error values end up as very large
> > > > positive values making the check succeed. Fix this by making the return
> > > > type visible with a local variable and add an explicit cast to ssize_t.
> > > > 
> > > > Fixes: ad8f36e4b6b1 ("iommu: return full error code from iommu_map_sg[_atomic]()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > 
> > > I don't see what the point of the newly added local variable is here.
> > > Just casting size should be all that is needed as far as I can tell.
> > 
> > No technical reason just found it easier to read and more descriptive.
> > I'll sent a v2 with just the cast, it does simplify the commit message.
> 
> Note that this is already fixed upstream, though:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core&id=a3884774d731f03d3a3dd4fb70ec2d9341ceb39d
> 
> Robin.

Ah oh well then nevermind and you can of course also ignore the v2 I
sent out a minute ago.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
