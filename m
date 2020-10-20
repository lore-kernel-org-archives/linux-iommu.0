Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB525C4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 20:14:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225E12225D
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 20:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BHzdHWkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225E12225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7823887404;
	Tue, 20 Oct 2020 20:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 98y-f3qxmUWE; Tue, 20 Oct 2020 20:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BFF5987400;
	Tue, 20 Oct 2020 20:14:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98A46C088B;
	Tue, 20 Oct 2020 20:14:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DFD7C0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 20:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3BEED86DD9
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 20:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75BpIya1KoEg for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 20:14:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 688E086DAB
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 20:14:09 +0000 (UTC)
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8f450f0000>; Wed, 21 Oct 2020 04:14:07 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 20:14:07 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 20:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3EO8F0CcDqjBwQQBd+1aLM1gpj7MK5+kF4qFt2JA1YsNUgWHhosV/XKgXO7pSuuRKdONDK7WOsgExZ19Wz6KQgMNDidHY3j/T3IaznU6A0bC/aDaY9i3iyru4XPi3gRWBUxn8e4Mr5tVsPT76XSrJDXvU2So2gHFkH1aQYXQN9+57R4VmY9YJzgGC3IZjV9xQsTQw0lR0u9U5pGx2lAyHOJwtLByvqiWn1BT+lGtqQb0+ini/L347yid3hU/NzWIv/7zKCIoidvK+PbuZoKYul1HjyUrI8EGnlaKRgxrhoamxn1LBfzh9OLNGd6RPsUgITpje8qU6Kszf1Y8a2Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5Ba6dg+i1RCKO5FPV8FqnHKDVsrkcmDOGp/cxLR0tY=;
 b=OgnjWnxIbyoE0ViV5J2kpP3cFZqToT5SLbURoGJLo3HBI/vy2Ym84HCj9WLjtoi6PJzzPfwESagt0WbL8uG15Bk4RCUH+16vDDYSoHwMEYPupLpOTyFY3GplXbKoinE8uXUPYk15gWJ59Yxm5oG8wlxoLrdybJnGW1T1f+n7O0KLFqKqU6+ZgLMdDTQb2QLhJwrisn3MA178+Jffs/lQTUXG4ov3VkJW7nL1I92yQXQiWHiyQcI6SeMGwRtGG/GS4oeR6lapnrQe6UfpVxAnfRXSzkyWU4wfEprFLoOqA0k8NAhr8r/Dc7noaqRUkaTezMcb/WepZ6xu+g0daTQcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Tue, 20 Oct
 2020 20:14:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 20:14:04 +0000
Date: Tue, 20 Oct 2020 17:14:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020201403.GP6219@nvidia.com>
References: <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com> <20201020200844.GC86371@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20201020200844.GC86371@otc-nc-03>
X-ClientProxiedBy: MN2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:208:178::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:208:178::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 20 Oct 2020 20:14:04 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUy1D-00385i-4W; Tue, 20 Oct 2020 17:14:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603224847; bh=p5Ba6dg+i1RCKO5FPV8FqnHKDVsrkcmDOGp/cxLR0tY=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=BHzdHWkEYXKVk+mjkQpgYQBuv7JMnpMQsDTz0Do82+7jaBP7ATFQug7YFBpzMG0ny
 Ce9XSbX7OlgNDurktyXei/5kIVPvS3dqlmDcf43+4TwOcZL4/DmpDmP52gN6wG70jG
 KGZYPJi54qKwBJ4PXA29/7oqPO2CJ/eQzKH/wVrML0/oCZzunYFBjWZ4aVvDXCO5zq
 0WM1ky8YP4Tt6But+Zl7FMjidvdLpojHbDeAeKzBhus6H/i/0NbXaFf+umWskQBgrF
 dvuaY+vJDORQs44wx52d8Qct8FH5KA9AmwmXA1BqlqIqOsnu94WC7y8jFJ5qdL+FKa
 ZHCdY9WzqAW2A==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Tue, Oct 20, 2020 at 01:08:44PM -0700, Raj, Ashok wrote:
> On Tue, Oct 20, 2020 at 04:55:57PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 20, 2020 at 12:51:46PM -0700, Raj, Ashok wrote:
> > > I think we agreed (or agree to disagree and commit) for device types that 
> > > we have for SIOV, VFIO based approach works well without having to re-invent 
> > > another way to do the same things. Not looking for a shortcut by any means, 
> > > but we need to plan around existing hardware though. Looks like vDPA took 
> > > some shortcuts then to not abstract iommu uAPI instead :-)? When all
> > > necessary hardware was available.. This would be a solved puzzle. 
> > 
> > I think it is the opposite, vIOMMU and related has outgrown VFIO as
> > the "home" and needs to stand alone.
> > 
> > Apparently the HW that will need PASID for vDPA is Intel HW, so if
> 
> So just to make this clear, I did check internally if there are any plans
> for vDPA + SVM. There are none at the moment. 

Not SVM, SIOV.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
