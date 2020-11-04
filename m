Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29BC2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 19:29:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B95C205ED
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 19:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HdmRXl6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B95C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5D7CD87010;
	Wed,  4 Nov 2020 19:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUJX8eIAclcM; Wed,  4 Nov 2020 19:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCA4884E1C;
	Wed,  4 Nov 2020 19:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 940FEC0889;
	Wed,  4 Nov 2020 19:29:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 629B7C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 19:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 511B58584F
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 19:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwfn-YYVl7wR for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 19:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3E03F85ADB
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 19:29:24 +0000 (UTC)
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa301120000>; Thu, 05 Nov 2020 03:29:22 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 19:29:20 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 4 Nov 2020 19:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLGEYBtm0Y2yv/0z7+BtLa5Yf+aVTF/vAGrn9KrN+ijEFScF0w30YLbVwRNBZ0pYRWjp1QtDWKul0uZUuN7FcvOBZsZAa77g0rDE6YYuzlTj8auuWRQm9Suu02wnJz/3dYxWqlrMBKSiB+x7qaJyBgJIByItzGeIAUpmZkG9DOVFiLtveT4k/aBAoM1aOgC8vx8PZ209J5MP7cLWoG+f/zPfchoPZ6MY/ko2rNN90yUe1zbsvSc5I8JLq1De11uvDTZUCsu6BnC1ynZG+HVacM0DSHg+FAh8xE0PkaVS91qctvk07mBMhsLjO3cMAAY8SZWJ+c43SmiRxGJha1KRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdxZRNQhQlxGudrAcPA0I9RD12/9fB2ddJQAbN4pwhA=;
 b=U4AT4MqnYh5ewQ3vRSgc/bxqtjTWfGYvpod+7QkAubAhs31j4HtQy5PNLSNziK6JqCIZyok8emYx/oi+6F+XdTmarlGVeqthfXKCBgv6+WOAySvn0PCxZ1+AhVtD0g7wVbzUQ/kvm1UEDqFf5QlthMRa6ts+a/UJ0GcGn1cIeTuaVLJ9SEi6fVo6UpIpQRgyhzMoMNaUjqEduMx2ilJy0rMfNQiqIkplVtE4ZrILk42e4F6sMCby/AHY7BYjM4yo8PPYZAe4LuJcGpaK7PVYMEpCZqVjykmDC08m46xzgC3wNond8dP7yO67HvN+vJq2PrZ7W8WDJNrhZdrgcGhH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 4 Nov
 2020 19:29:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 19:29:18 +0000
Date: Wed, 4 Nov 2020 15:29:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201104192916.GA2620339@nvidia.com>
References: <20201103125643.GN2620339@nvidia.com>
 <20201103131852.GE22888@8bytes.org> <20201103132335.GO2620339@nvidia.com>
 <20201103140318.GL22888@8bytes.org> <20201103140642.GQ2620339@nvidia.com>
 <20201103143532.GM22888@8bytes.org> <20201103152223.GR2620339@nvidia.com>
 <20201103165539.GN22888@8bytes.org> <20201103174851.GS2620339@nvidia.com>
 <20201103191429.GO22888@8bytes.org>
Content-Disposition: inline
In-Reply-To: <20201103191429.GO22888@8bytes.org>
X-ClientProxiedBy: BL0PR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:207:3d::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 19:29:17 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kaOT6-00Gc7u-N1; Wed, 04 Nov 2020 15:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604518162; bh=JdxZRNQhQlxGudrAcPA0I9RD12/9fB2ddJQAbN4pwhA=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=HdmRXl6JdBphMAbaFSoGIrKDLSjKvXeUzi6bCwTNDjrDtRdwNu6nFl3IcmiD81NFo
 +aBiKdc9j+fzoj1ooeiaUIdNkw3UgqoQ1PwOriDo5XxcQiVsAC7XYBEUe6HhPOh4ZQ
 F8UbKY5Vs2n5vJja/S0r6vOsxSfGbxdPr6qutr0Rg+fo/7P6/qf9L709VIMn5H5qWQ
 VWkNGOTIe0/Qc/dtE6AvUuHHvdKi4wqxAoAZ4b4OP7zMKLWuZ5FVB/mUnssUgmAfvc
 tqnQ5c8vRcMFRyFqyvscj07R53H2MkJnwSJUc+sSqs0QPvU3FlZaFFX8U+rX8Wb1yP
 3qL2eSC3Z3lvA==
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>
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

On Tue, Nov 03, 2020 at 08:14:29PM +0100, joro@8bytes.org wrote:
> On Tue, Nov 03, 2020 at 01:48:51PM -0400, Jason Gunthorpe wrote:
> > I think the same PCI driver with a small flag to support the PF or
> > VF is not the same as two completely different drivers in different
> > subsystems
> 
> There are counter-examples: ixgbe vs. ixgbevf.
>
> Note that also a single driver can support both, an SVA device and an
> mdev device, sharing code for accessing parts of the device like queues
> and handling interrupts.

Needing a mdev device at all is the larger issue, mdev means the
kernel must carry a lot of emulation code depending on how the SVA
device is designed. Eg creating queues may require an emulated BAR.

Shifting that code to userspace and having a single clean 'SVA'
interface from the kernel for the device makes a lot more sense,
esepcially from a security perspective.

Forcing all vIOMMU stuff to only use VFIO permanently closes this as
an option.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
