Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798DAC11D25
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 01:18:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3F4206E2
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 01:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3F4206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 22FA087E72;
	Fri, 21 Feb 2020 01:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id knWvKYLik0Th; Fri, 21 Feb 2020 01:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A109987DB2;
	Fri, 21 Feb 2020 01:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A185C1D84;
	Fri, 21 Feb 2020 01:18:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A87FC013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 01:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0349C869D3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 01:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbzLtvs+3tjM for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 01:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C1CA28699B
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 01:18:03 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01L13fW6089355
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:18:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y93kgj9ga-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:18:02 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <linuxram@us.ibm.com>;
 Fri, 21 Feb 2020 01:18:01 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Feb 2020 01:17:57 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01L1HtsE41419040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2020 01:17:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C748D4203F;
 Fri, 21 Feb 2020 01:17:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C2A642045;
 Fri, 21 Feb 2020 01:17:51 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.188.83])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 21 Feb 2020 01:17:51 +0000 (GMT)
Date: Thu, 20 Feb 2020 17:17:48 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220154904-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20022101-0016-0000-0000-000002E8C975
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022101-0017-0000-0000-0000334BE816
Message-Id: <20200221011748.GE5713@oc0525413822.ibm.com>
Subject: RE: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_19:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 mlxlogscore=972 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210006
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Feb 20, 2020 at 03:55:14PM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > Currently the advanced guest memory protection technologies (AMD SEV,
> > powerpc secure guest technology and s390 Protected VMs) abuse the
> > VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> > is in turn necessary, to make IO work with guest memory protection.
> > 
> > But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> > different beast: with virtio devices whose implementation runs on an SMP
> > CPU we are still fine with doing all the usual optimizations, it is just
> > that we need to make sure that the memory protection mechanism does not
> > get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> > side of the guest (and possibly he host side as well) than we actually
> > need.
> > 
> > An additional benefit of teaching the guest to make the right decision
> > (and use DMA API) on it's own is: removing the need, to mandate special
> > VM configuration for guests that may run with protection. This is
> > especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> > the virtio control structures into the first 2G of guest memory:
> > something we don't necessarily want to do per-default.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Ram Pai <linuxram@us.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> 
> This might work for you but it's fragile, since without
> VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
> GPA's, not DMA addresses.
> 
> 
> 
> IOW this looks like another iteration of:
> 
> 	virtio: Support encrypted memory on powerpc secure guests
> 
> which I was under the impression was abandoned as unnecessary.

It has been abondoned on powerpc. We enabled VIRTIO_F_ACCESS_PLATFORM;
by default, flag on powerpc.

We would like to enable secure guests on powerpc without this flag
aswell enabled, but past experience has educated us that its not a easy
path.  However if Halil makes some inroads in this path for s390, we
will like to support him.


RP

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
