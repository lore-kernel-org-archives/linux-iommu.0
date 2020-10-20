Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31B9C4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 13:54:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6C722240
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HjA8o6ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6C722240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4F05D21519;
	Tue, 20 Oct 2020 13:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IxUgkDqPRGr; Tue, 20 Oct 2020 13:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A5D3203F1;
	Tue, 20 Oct 2020 13:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11F78C0052;
	Tue, 20 Oct 2020 13:54:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A75ADC0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 13:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8E9AE86C65
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 13:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4Wcb7PPkwl6 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 13:54:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D6FA7868E1
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 13:54:47 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8eebf80000>; Tue, 20 Oct 2020 06:54:00 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 13:54:43 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 13:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VftBuSV2zOc0xroRdU0UVkUBWaT2U/HcJrjTROlGS1m6F8m4P3ZSN3BK87FWgS3+GGND4xf+/txEtjjCAzEKpUq2yr+rpmfB5WlEMqqVLDndwxVc98j8wD+Na3y82mJokAgZUED/uLspC2Fh9prVe7JrNeaALptfOPLb+AldAjhKMHGB/SHU+GzVi1z9iO1efoKPEMtEkm7ROOCFUHzFUdAxBKzJEjINF6AaXFoyLB5CUqHIPRqRNr7F9k2t/OpyVpdkqAPJXjFln60KOJH5uiXwElZZCPgfvhT6dBGci3DuqojIpZ2XyDfRoFbyyHM0d8GXerxkQ9Y6O3nncjaBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TZbn2JcSVbUPRrPZk+3GYnABpXmYy8TuRJjUol5GoA=;
 b=g+QC7F7ALtLw0VH6UC6jVDnUMZZ8kJ1zo3HgV/A1ILv0wuuCVrw1oZeHirulrWOYHqNVh4MUQYdo9/NkDuNnbzQFvpmClMNPM0qmLgN2Ep9PkFtqjCjPMrXBFPVj9RAmWS79KLMsfAMdRAxSGOe8gPh4vp5ibb6MPhnrqOJDgokk+XC9EoZA1pBRaJ9uF5HVDyEYhs8B63v5dIPuSMAnoYx4vzEFflUBYRSxJe1UvQrL2emhqqyuvI/S6nyBu33SaYNRbZIzSM1ZhqJEUeUCeSZFdrS+eRzQeXc/pieoSrp+PGd3Wi5Clrqdr0JZOd0a6KKtv1i6ZzRw5OhR99geYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:54:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 13:54:41 +0000
Date: Tue, 20 Oct 2020 10:54:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020135439.GH6219@nvidia.com>
References: <45faf89a-0a40-2a7a-0a76-d7ba76d0813b@redhat.com>
 <MWHPR11MB1645CF252CF3493F4A9487508C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <9c10b681-dd7e-2e66-d501-7fcc3ff1207a@redhat.com>
 <MWHPR11MB164501E77BDB0D5AABA8487F8C020@MWHPR11MB1645.namprd11.prod.outlook.com>
 <21a66a96-4263-7df2-3bec-320e6f38a9de@redhat.com>
 <DM5PR11MB143531293E4D65028801FDA1C3020@DM5PR11MB1435.namprd11.prod.outlook.com>
 <a43d47f5-320b-ef60-e2be-a797942ea9f2@redhat.com>
 <DM5PR11MB1435D55CAE858CC8EC2AFA47C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6e478a9e-2051-c0cd-b6fd-624ff5ef0f53@redhat.com>
 <DM5PR11MB143545475500159AD958F006C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM5PR11MB143545475500159AD958F006C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Tue, 20 Oct 2020 13:54:41 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUs63-002wSV-Dd; Tue, 20 Oct 2020 10:54:39 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603202040; bh=3TZbn2JcSVbUPRrPZk+3GYnABpXmYy8TuRJjUol5GoA=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=HjA8o6ag3lVsL97vT98FxH+z3of6yqbNiCSge3H5/U/JmpYigOzEyXQVPOrjvWuiU
 BrrbVgFY+8YWHG8kKzZr2Ojr5+Nvr9uG6DgVaJGuiW86dklAlTI0B6Ct/85idkT2jB
 DSIyKJhemFiZ2WBl9ZSBk+8r4GUexkH9F72qsOStk6MUpJFLbyYLjc98rAWhh9mEmH
 AtfU9xFT+XzQs0GCBfJTULsH6w/qhGJaNs4bMp4BfVDC/pBtqydZ3upkrEeHbUUW+A
 w7exj7ritiv5FsFe6vwDCVzZc2s9pPB3+SWy98Dgwym/Rz9T78lYKso7Aq+ZhdaHyy
 JqZHjhjMReutw==
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

On Tue, Oct 20, 2020 at 09:40:14AM +0000, Liu, Yi L wrote:

> > See previous discussion with Kevin. If I understand correctly, you expect a shared
> > L2 table if vDPA and VFIO device are using the same PASID.
> 
> L2 table sharing is not mandatory. The mapping is the same, but no need to
> assume L2 tables are shared. Especially for VFIO/vDPA devices. Even within
> a passthru framework, like VFIO, if the attributes of backend IOMMU are not
> the same, the L2 page table are not shared, but the mapping is the same.

I think not being able to share the PASID shows exactly why this VFIO
centric approach is bad.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
