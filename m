Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53054C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 11:43:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ADC20709
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kXLhM/c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ADC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A40A85F8B;
	Wed, 30 Sep 2020 11:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJCg8kL98iNN; Wed, 30 Sep 2020 11:43:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FC2585F45;
	Wed, 30 Sep 2020 11:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D086C016F;
	Wed, 30 Sep 2020 11:43:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A28FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 11:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 77F948528B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 11:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mWHDSZXelYoP for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 11:43:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1365E8452A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 11:43:20 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f746f550000>; Wed, 30 Sep 2020 19:43:17 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 11:43:05 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 11:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAHVpach2WYpBrX7bBNfX2SGGy1+cnUCSq0QPfO8RqEJnTo2B6aBwe+MSQ57TGv/981kRQojIBOoMt7yuMguw2Kp5woH1njWSncI8oDfknTIJwdqH2jRA7+wTCkP2+AQVZFwNCFDvCEj1IRJK7vP/GDgwCBNJnVdSdASsdxzPcB8HCqDxR+SLRetk5qcZiPK1nhaTg67XQO/dnLp1eUj8A8ErX0r8Z1kMGv0rd26MZZnTe1hl1UwuTpVA0Tvr23leGuf19KOjyx4ZsaJcJ2DT13mzmLSkXOc1Wkv2vOcA/qNFoGKrFBVmybOi4hngZMvkglRI8qybsbWfn2RFsHGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifDjfXqbQdEToOzcs0qsNuogLb2HLWyKHTQc87/3Ewc=;
 b=GeC4vJWbfjTvUobe+GD7bOGykQaBOHH9lRECgxQuxmBz12RecnpK0daGWL/nq+UA1YjrfFHbvdi+geu9xiLDM2UFIseLWBWZYeg7EYre4CKvrFEJc/Jk0id23iLCbkpwZYjdydGccgoFaSWHhmQZekjrIUnXC6eA0yjnt5fIBL44pomxvYhSNTjTaU3GfCsB/VE3U6YoQ8JWlrPiQ9QxZC0NPmH308QDm1m2EkXgszZiBEFC/nbVG6lDlrUsipDlyAsmxlgi8wPzaI3NKn5QcGELBMWyX+7KDU2Xp7Jjn9IQWbfhb+rrutv5oJ0DZpRhhjf6na7Yl8Tjoo0tYcpwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 11:43:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 11:43:02 +0000
Date: Wed, 30 Sep 2020 08:43:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
Message-ID: <20200930114301.GD816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
 <87v9fvix5f.fsf@nanos.tec.linutronix.de>
Content-Disposition: inline
In-Reply-To: <87v9fvix5f.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Wed, 30 Sep 2020 11:43:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kNaVh-003vDf-1s; Wed, 30 Sep 2020 08:43:01 -0300
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601466197; bh=ifDjfXqbQdEToOzcs0qsNuogLb2HLWyKHTQc87/3Ewc=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
 b=kXLhM/c+6HLgKm+6ble3lfNqOcCNe2qhFpXxYQ9VNpltIzypeid1VYh+BMxlOLlye
 0+6VDWOyOvDf07+xZGAec4Wvn8k5WI3aiZoShq7j1qgKIq7qgusR0iXtwcLQk/xdjz
 +v2330h6r9nb93xOefwM7I/qvuhlV7upcanj1FwilxBqKMT7QRH5pMZ7ET2aXWd8p8
 pK/mYHKsauGX6pIvk6Q2HPDPYGpXdDmMnGHCOc+5/StKJ5sjO489/p+d/uJSwbbRw0
 QSJd7JK+1Rwde8F4fsYoj/S1iGRvpbBC/PZ0KlECf5FCeVBwjrsxHssfpqgfmeqxU4
 fyKeGy0g3j+zQ==
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Dan Williams <dan.j.williams@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 "Dey, Megha" <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 ravi.v.shankar@intel.com, Kevin Tian <kevin.tian@intel.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave
 Jiang <dave.jiang@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ
 Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Sep 30, 2020 at 08:41:48AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
> > On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
> >> #9	is obviously just for the folks interested in IMS
> >>
> >
> > I see that the tip tree (as of 9/29) has most of these patches but 
> > notice that the DEV_MSI related patches
> >
> > haven't made it. I have tested the tip tree(x86/irq branch) with your
> > DEV_MSI infra patches and our IMS patches with the IDXD driver and was
> 
> Your IMS patches? Why do you need something special again?
> 
> > wondering if we should push out those patches as part of our patchset?
> 
> As I don't have any hardware to test that, I was waiting for you and
> Jason to confirm that this actually works for the two different IMS
> implementations.

How urgently do you need this? The code looked good from what I
understood. It will be a while before we have all the parts to send an
actual patch though.

We might be able to put together a mockup just to prove it

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
