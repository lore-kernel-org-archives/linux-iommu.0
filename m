Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C1C2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 13:23:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6424521534
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 13:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lipyw7vJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6424521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8027220534;
	Tue,  3 Nov 2020 13:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjqIykR9jNiR; Tue,  3 Nov 2020 13:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 37BA72051F;
	Tue,  3 Nov 2020 13:23:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1847FC088B;
	Tue,  3 Nov 2020 13:23:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E356CC0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CA9FA86C23
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tmn422rGRv8e for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:23:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E474586C22
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:23:43 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa159e30000>; Tue, 03 Nov 2020 05:23:47 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 13:23:39 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 3 Nov 2020 13:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baoh+3G0UOEFC0x0pRkAlELZ28LTEjAgwW6AcPK9wNDoPLFUHE5GHOEEJ38SI2rKlbk9umJSLh/7NlBq7yg3G8LvcBDBtWqthHxLmYhNBxYVT1X0qS0VBcsw+8XtMiajArTUzija4YVD5rEpGmTr9VAUkJ1l892B1XZi87gCphtdAZwFULpRUs2+1LsiIAVJTCj0T50PGlNFh07SA7aOIxpM1Be6GpGPuWV4DX8TXa6e+F4f0737WdFWAY+mba7qnFdVjYLK/rWwielN0dUzZxL4lmXIbjpTCCyqK1nxrNhSfJqi9fFosxJ/Tvp2j3L3UOufVgzsHjAxkPCwIT/org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPhr80/Zo4aBoI+9EqDjNUx3YiFdv6OFGK7F/cOYf78=;
 b=l8zf5SJhefDcEREGx3o7/BsuEsRpjFcKL330hvCAmXPNYvCUbFPGZiLvdrxnkYAMLpxXg97thYo0qy2YVwhSOrD+gVVc5KyqKtiA7K1tcxRhA9B/G+jU0Fl8Ovz9N6VHTuMbGPkNP0k8na0ZSttqyquPTVp9rF0L4lA5VcbylXVp0e3ulY0pbFXpAwS34CccRLXnuaPPs2MEMFMWG5+NjzOxNEs7wOW7+0QvW3gbB8CAHy+LbiUFzrMhz7n1XcA98L93llaWekerLpf357ZuNa+hqPhiOWQgtPi5z3CZva0q5eCHuOzlvei4RyRee+QIZJVVNtVNShu5U8pTKiIOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22; Tue, 3 Nov
 2020 13:23:38 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::2459:e095:ac09:34e5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::2459:e095:ac09:34e5%6]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 13:23:38 +0000
Date: Tue, 3 Nov 2020 09:23:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201103132335.GO2620339@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201103095208.GA22888@8bytes.org> <20201103125643.GN2620339@nvidia.com>
 <20201103131852.GE22888@8bytes.org>
Content-Disposition: inline
In-Reply-To: <20201103131852.GE22888@8bytes.org>
X-ClientProxiedBy: BL0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:2d::33) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 13:23:37 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kZwHf-00Fu34-VJ; Tue, 03 Nov 2020 09:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604409827; bh=EPhr80/Zo4aBoI+9EqDjNUx3YiFdv6OFGK7F/cOYf78=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=Lipyw7vJ9UAzFb4X6yTeVG8Nyr9WEonStZBjUJQ9CfpP9thKM8nnQ5vTL661CWTPr
 9rvI9Fob8SFI5KWKKaA+/7pTxXqs1I6x93Jz3gaoTaOnoHsgkgV9qQQqnzO2ZI8oOc
 uGKCx23uS094uYZZb3vrg6xrClyi4/80K+badZ5S5yrcn2caxC6/tS+FNFtF6mxZH1
 y+iPD2B9iJ6bZcn5eA2byggl4aXovCOVJ+JABlfkQd+s0+P7MSu075uYpzQmqS/pTr
 b85HrXiwGY9XWnMNozZgSx0mGed4+1Imnw9K18tlX7tSs7w8BmWAeEIk8Bj87FwcuQ
 kPz6X3jUEMDYQ==
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

On Tue, Nov 03, 2020 at 02:18:52PM +0100, joro@8bytes.org wrote:
> On Tue, Nov 03, 2020 at 08:56:43AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 03, 2020 at 10:52:09AM +0100, joro@8bytes.org wrote:
> > > So having said this, what is the benefit of exposing those SVA internals
> > > to user-space?
> > 
> > Only the device use of the PASID is device specific, the actual PASID
> > and everything on the IOMMU side is generic.
> > 
> > There is enough API there it doesn't make sense to duplicate it into
> > every single SVA driver.
> 
> What generic things have to be done by the drivers besides
> allocating/deallocating PASIDs and binding an address space to it?
> 
> Is there anything which isn't better handled in a kernel-internal
> library which drivers just use?

Userspace needs fine grained control over the composition of the page
table behind the PASID, 1:1 with the mm_struct is only one use case.

Userspace needs to be able to handle IOMMU faults, apparently

The Intel guys had a bunch of other stuff too, looking through the new
API they are proposing for vfio gives some flavour what they think is
needed..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
