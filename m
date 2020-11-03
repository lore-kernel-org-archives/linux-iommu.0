Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2EEC2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 15:22:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7DF20780
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lC7TQy6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7DF20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFC4786151;
	Tue,  3 Nov 2020 15:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GQ_c3o3fOrwa; Tue,  3 Nov 2020 15:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2334485F5A;
	Tue,  3 Nov 2020 15:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05760C088B;
	Tue,  3 Nov 2020 15:22:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D314C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 66AB386812
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hL-WTqOVvvmw for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 15:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E21A2867F8
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 15:22:34 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa175b50000>; Tue, 03 Nov 2020 23:22:32 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 15:22:28 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 3 Nov 2020 15:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBpw/9U7MxGWo1oEJuhzooogF1Psr5UmirKKADi7OtnQYHHaXdIO9PC7bQUOk2/iQzXiBFIV3rfTtnnBr4nqXkwaJzcwWS+larmIUZTbbxySVjaduW8YnFrfoiUfRB8c2uDZvJnNiJIQ71Ao/EciIvQz/0wk5ms8s1SGXMuOeIzQHAiNVjz2eAz1VU2SR9Eb45rY/uA2mUsYxp0+M4iFrpUH0bX2nwJJrIPDGJWzeJgZTLpcNzILQWcph9T77fZWEtFHYM+XypgwbNbbq3tys8BL5rVK/zyzWeoO7pgYdc9EiBENFHYM64JOoniuvVNpXGfbjOgN4dHvZbN/C07B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTB337qpENG6+Ub3MecN1tM4eUGLVriCkTyaDVGu/Nc=;
 b=V5NGjtdhtGPR93dDMRg9UZBG+dsHX3claSsaHdbp25ESz0VT8xAc5FPGEcWGhNszWGOfSNygLuW/FAMKBbwSe3pPcsKbbwoAI7qhVmvpBoeQt1uEjSfFVhe6TgIHFJyOFAGoSnj0cwRkN+PIx0HaCmILzz21PCPmfchr06AVEW9w8RtL54TxGiAQls8xjDk5+wfHImME6a/7glsIFs8KH9td3WmQnfu5X8ohUnDGrB763HQwnHWbMYyMnoCqpdUN3RUAquY8g83k5z+hyEyzQ0WF48EJCDD/CqSzpf8PNn5L3r1C8y+sX2h1ngHcg5mpXvYtoWM334HZGwasgPIv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB3700.namprd12.prod.outlook.com (2603:10b6:a03:1a5::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 15:22:25 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::2459:e095:ac09:34e5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::2459:e095:ac09:34e5%6]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 15:22:25 +0000
Date: Tue, 3 Nov 2020 11:22:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201103152223.GR2620339@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201103095208.GA22888@8bytes.org> <20201103125643.GN2620339@nvidia.com>
 <20201103131852.GE22888@8bytes.org> <20201103132335.GO2620339@nvidia.com>
 <20201103140318.GL22888@8bytes.org> <20201103140642.GQ2620339@nvidia.com>
 <20201103143532.GM22888@8bytes.org>
Content-Disposition: inline
In-Reply-To: <20201103143532.GM22888@8bytes.org>
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL1PR13CA0171.namprd13.prod.outlook.com (2603:10b6:208:2bd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Tue, 3 Nov 2020 15:22:25 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kZy8d-00Fw0D-OO; Tue, 03 Nov 2020 11:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604416952; bh=kTB337qpENG6+Ub3MecN1tM4eUGLVriCkTyaDVGu/Nc=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=lC7TQy6xEH/zdcCUP9nabNZtNzwHIE0KCgh2M6go3va8h+Z6Lf3mewBtT5CG24bTt
 75/tsIQfMaFd8VHDoOxStwNwya/i16S1rdI8X0pRNtxTopVg5PVIDkWPU2uUtbmoCr
 0s+bf8CfhFF+p9cX6dQEHaIbBcnorUo7F85QH5p8x6xNDt9jPV3rg6lBgfk4oTA7/n
 mTqSQi+SaOkym9uVp+Jb1BOeQ2xnS7Xdy0KPRuqlt1JZgTwJ5pPcN8weE6Sbt5hXg4
 L4TO5tFXCyGW7I8zLzeCyk+6tR5tnMIxKFgmLfwWOrzisi/MlJbfFbNrF9e8IPBCgc
 fIVMSpQrR81Zw==
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

On Tue, Nov 03, 2020 at 03:35:32PM +0100, joro@8bytes.org wrote:
> On Tue, Nov 03, 2020 at 10:06:42AM -0400, Jason Gunthorpe wrote:
> > The point is that other places beyond VFIO need this
> 
> Which and why?
>
> > Sure, but sometimes it is necessary, and in those cases the answer
> > can't be "rewrite a SVA driver to use vfio"
> 
> This is getting to abstract. Can you come up with an example where
> handling this in VFIO or an endpoint device kernel driver does not work?

This whole thread was brought up by IDXD which has a SVA driver and
now wants to add a vfio-mdev driver too. SVA devices that want to be
plugged into VMs are going to be common - this architecture that a SVA
driver cannot cover the kvm case seems problematic.

Yes, everything can have a SVA driver and a vfio-mdev, it works just
fine, but it is not very clean or simple.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
