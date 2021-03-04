Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC5DC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 12:52:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0864F2B
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 12:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B0864F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DF0084225;
	Thu,  4 Mar 2021 12:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_iqt4TXEPNz; Thu,  4 Mar 2021 12:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60EA8840E3;
	Thu,  4 Mar 2021 12:52:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5DAC000A;
	Thu,  4 Mar 2021 12:52:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79511C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7507584225
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DWnNMqKJ569 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 12:52:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC6C2840E3
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:52:17 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6040d8010000>; Thu, 04 Mar 2021 04:52:17 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 12:52:16 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 12:52:04 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 12:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3rvkD2htfyw2GGFofzfce8bBOxZUDFm7SU/d/ebOw1uMIvPAOZPsWuIrk4V44iDxyTdRr1iK01CLwCxP8kRC3tgzQo5DXjosN/gVCwU/a026fk8i4oUzB+SQLcVdR1YC1d5KN2ChelqSxfjj5oJ4pzBmeTKaVmYqByD0MXnWEPgk/d9smtF0RDo1P7Ga+ABwyBwJtNeXbcTCD3g24ViQ1eoJkzyqsE8d1cRdeqCUkx1mlY43/wEMP5UTZnmgFe5SNFlm2zq5zeSBbSz+Kvk4rKy9iTMLFQ4JHf4deyrvpBsIxx+n8B+cqPsL40eYfpSeInC1IEryWiSirPuSiowJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxxqEAnlNQ1w50HDAHhTXHasozbopSC2lFlIm5C4DOU=;
 b=JO4ZOJ2OpZmYmYJorLYvU83AVBAhVNEJ6vMS3tbNuqG13HqtPQQenR1eOjAjnQaGWHgVkTUV8g8uDpev4LzapOCIQ3ekX7KscSbE3WEKa7adL6HjEI3E7qo5YTOP3rDxA7Y/4Q7H7UXgg15UfJd1uAuDy9rqALL69X0KAQmwYyfSAGWc46wFlrfOuLRsLlnj7uug4+9+CWwGEZSTM+ytG3/RfnTxY1+ubvMRtZb8OBoMxECZK4HEu7tWhj8qOWUfbdQDWWd1thI/z2J55GVB+jkRZKtIWidjY/wIKsNRQuBL4jH1H0NcBJ9gkJUEttENXTeE4gEHT+8Osfm8rJ1vfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 12:52:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 12:52:02 +0000
Date: Thu, 4 Mar 2021 08:52:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [Patch v8 04/10] vfio/type1: Support binding guest page tables
 to PASID
Message-ID: <20210304125201.GA4247@nvidia.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-5-yi.l.liu@intel.com>
 <20210302125628.GI4247@nvidia.com> <20210302091319.1446a47b@jacob-builder>
 <20210302171551.GK4247@nvidia.com> <20210303114212.1cd86579@jacob-builder>
 <20210303194523.GX4247@nvidia.com>
 <BN6PR11MB4068D05B70842124234A7AF4C3979@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN6PR11MB4068D05B70842124234A7AF4C3979@BN6PR11MB4068.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0156.namprd13.prod.outlook.com (2603:10b6:208:2bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 4 Mar 2021 12:52:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lHnST-006atm-Fx; Thu, 04 Mar 2021 08:52:01 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614862337; bh=qxxqEAnlNQ1w50HDAHhTXHasozbopSC2lFlIm5C4DOU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Header;
 b=fCwQmhAsaFr4M6reM+Gp+1piwPVPgQBNO5lFK/AiNZDrE9aVJgpvZH+wctUULKkLW
 eeugqowh6vZ/WxhisMtkTnsz0hccDLDPt/mcKePhNcE2JOzR5QrgEKyE9sUCOtWItM
 a9I3ufd0dV5icoWKYqu3kdqaYgAjBsKb3aM+4UMlxtH2YFPJTtYp/ybZmcqXqvZhGe
 sBz4ejzAuCaC726flKN2JVgm844DQXSz9MS5uep8UexaH1fplCN8fQuxcAj+v1fYZW
 BnMOX5oGviS1/mSv/dmpQh7fHoCBV4nkuUmqeejG7Cvwrze+V4Pc6gWtIbow0+W4fO
 qfiUMilgHQeKQ==
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian, Jun
 J" <jun.j.tian@intel.com>
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

On Thu, Mar 04, 2021 at 07:20:22AM +0000, Liu, Yi L wrote:
> > > However, IOMMU is a system device which has little value to be exposed
> > to
> > > the userspace. Not to mention the device-IOMMU affinity/topology. VFIO
> > > nicely abstracts IOMMU from the userspace, why do we want to reverse
> > that?
> > 
> > The other patch was talking about a /dev/ioasid - why can't this stuff
> > be run over that?
> 
> The stuff in this patch are actually iommu domain operations, which are
> finally supported by iommu domain ops. While /dev/ioasid in another patch
> is created for IOASID allocation/free to fit the PASID allocation requirement
> from both vSVA and vDPA. It has no idea about iommu domain and neither the
> device information. Without such info, /dev/ioasid is unable to run this
> stuff.

Why can't it know? My point was that VFIO should interact with
/dev/ioasid to exchange the information both sides need and once
exchanged the control over IOMMU should be done through /dev/ioasid,
not inside VFIO.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
