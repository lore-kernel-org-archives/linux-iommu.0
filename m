Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAFCC4363D
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:05:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3917822249
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 14:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FbYIu8qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3917822249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE19E86ACB;
	Tue, 20 Oct 2020 14:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDnod6urJunJ; Tue, 20 Oct 2020 14:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7916086B1D;
	Tue, 20 Oct 2020 14:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B213C0052;
	Tue, 20 Oct 2020 14:05:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F116AC0052
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E1D5986CEB
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwpqUduwZPRL for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 14:05:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B715C86CE9
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 14:05:12 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8eee690000>; Tue, 20 Oct 2020 07:04:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 14:05:09 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 14:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIRCc24qLbOGyy4hD+iyfa0W7Fj8S5wQOKF4KVK0t+Crruj1mgeUfFXT1ErFAbcL3yT61Cz+EzGsUGrxPUfM/Fuxm2iAt2JJ1veBsAcSSHLqRb9gct3+WnRNNUkU2jFrmeLUsZeYlr6O+8Wp5ksxZHkxIal6K0U5cNvwnItuYhUYvlD7eNFHHDTpS7mqf0X7X72Tsyy1n6ovZvjfLDwL2qAAMXMqY9e9oQh/r6Zs7vzjtlwKtY3wtd3OSC6ihroYA6l8yfya2ZZwEPSdNdSz7fT4hPKYOlaNSGPTRN1T/NeRt9rskHLRCcCuAUmU+3nr5jmRH8X0JB7W7OqABTYiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEW8D0/o+7K7YrbY2tkFoHb2jEAToYpLgb9CmfJwM8U=;
 b=IGIXZdzUUSY6gmfGvc9Cvp9V+7WeR5QVTXMgHPqpI7ztawq4fbJprFDwk4KwmR11bb56DfVoqpXpXVzzOcVrMSTReF1osMvZlTK2603ZyIdkiTvyt3DjEGajw3b4eSGA24zupMs+VwzYGEyCWPOfx10JrKpVpvOPY4smpJ78q0gWsrxIAf3x5DzOCdMc29ZourOO/spKNi/xzRbt4LYJiKY+Y0LwjcsOd4Zo+9HPCrktA3zICRDKogTiCwRSbzoB+IcN1ClbxY6yLl0m3JhU1g2pfWHg7YwB/obaTLImdzneuJypnbb7w4jQ7RgLJczKTtcP/jbOSjqCQQKP14dG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 14:05:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 14:05:05 +0000
Date: Tue, 20 Oct 2020 11:05:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020140504.GJ6219@nvidia.com>
References: <9c10b681-dd7e-2e66-d501-7fcc3ff1207a@redhat.com>
 <MWHPR11MB164501E77BDB0D5AABA8487F8C020@MWHPR11MB1645.namprd11.prod.outlook.com>
 <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
 <DM5PR11MB143531293E4D65028801FDA1C3020@DM5PR11MB1435.namprd11.prod.outlook.com>
 <a43d47f5-320b-ef60-e2be-a797942ea9f2@redhat.com>
 <DM5PR11MB1435D55CAE858CC8EC2AFA47C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6e478a9e-2051-c0cd-b6fd-624ff5ef0f53@redhat.com>
 <DM5PR11MB143545475500159AD958F006C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020135439.GH6219@nvidia.com>
 <DM5PR11MB143591B85490D675F0628890C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM5PR11MB143591B85490D675F0628890C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:208:2be::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL1PR13CA0185.namprd13.prod.outlook.com (2603:10b6:208:2be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.10 via Frontend
 Transport; Tue, 20 Oct 2020 14:05:05 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUsG8-002wfN-Dg; Tue, 20 Oct 2020 11:05:04 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603202665; bh=MEW8D0/o+7K7YrbY2tkFoHb2jEAToYpLgb9CmfJwM8U=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=FbYIu8qNblFZjUMLRuiQnmCWTtOg848La+o8HZNiO+ygsBLHJJm5erGRFU1sGWnZx
 HSwWs9g6znlJl0ftqhoNwEQLunhwZhmMpO1IxuYAg9rwf6GbDcZe7fZ1Ym3sWNVZfX
 BVyJKpNdnH98fCKeLaZLkwpr4xPwLvUjrAmm+9f0xh7a5+DxYheLXGW4U69RrG/wlj
 ZoEWmqmhE6NFRNBNWmWctgxmM0Qvcv4G4a3W/Eg2Tzi/9lZTqg9oFWea3qk6PGbZ+a
 zH7FMEPgcW2lGGXGRGNqId5igPrBdwG5Pm+MpD8fQvwX+DDNPCTdL+LOhS24J3ZPNQ
 Fre/bdLakRYww==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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

On Tue, Oct 20, 2020 at 02:00:31PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, October 20, 2020 9:55 PM
> > 
> > On Tue, Oct 20, 2020 at 09:40:14AM +0000, Liu, Yi L wrote:
> > 
> > > > See previous discussion with Kevin. If I understand correctly, you expect a
> > shared
> > > > L2 table if vDPA and VFIO device are using the same PASID.
> > >
> > > L2 table sharing is not mandatory. The mapping is the same, but no need to
> > > assume L2 tables are shared. Especially for VFIO/vDPA devices. Even within
> > > a passthru framework, like VFIO, if the attributes of backend IOMMU are not
> > > the same, the L2 page table are not shared, but the mapping is the same.
> > 
> > I think not being able to share the PASID shows exactly why this VFIO
> > centric approach is bad.
> 
> no, I didn't say PASID is not sharable. My point is sharing L2 page table is
> not mandatory.

IMHO a PASID should be 1:1 with a page table, what does it even mean
to share a PASID but have different page tables?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
