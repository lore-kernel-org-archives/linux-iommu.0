Return-Path: <SRS0=/c0m=D3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2AC4363A
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 19:56:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A182225D
	for <iommu@archiver.kernel.org>; Tue, 20 Oct 2020 19:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ViubdjgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A182225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98DD386E64;
	Tue, 20 Oct 2020 19:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9UHgZ_PdTzE; Tue, 20 Oct 2020 19:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 37ACA86CDE;
	Tue, 20 Oct 2020 19:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12FBAC088B;
	Tue, 20 Oct 2020 19:56:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61C99C0051
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 19:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 452AF8670B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 19:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 97MYdOmNdmH3 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 19:56:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 69C2786722
 for <iommu@lists.linux-foundation.org>; Tue, 20 Oct 2020 19:56:06 +0000 (UTC)
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8f40d30000>; Wed, 21 Oct 2020 03:56:03 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 19:56:01 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 19:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+taRDna9QByTWCw5BRwnB/6RnltW8sR8CDpLUc4nn+ltjFUhvuzEhP2e1d5sWDCssr4llcJK+fIgyrz9W0EwQMjE1GYrfkipPaphogipyO+Kp85dxSZVmQFwAbJ6mMu3919yV5oarwLUqpPOkHyiLMniWH5R2gvd7M/BV+QwMk0HcJn/ZMQce3Syps6lVmtENIN7dGH09TsPxhhvx747U+pf3uVjTizfO3nsj2Rt5UR4nlFkRfh9VgKuLj/jqjDEL2pLyW1/TVdaRJyncmu0UtB9DMk2EygeV7qnQaJFcJ/Fk48dzrJuAuC8XL7an5bkbrxt9+be4KLB5Zu6f6Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLP8vj/EWcL74dSbxidrd9H1JF3eBmAw8Q+6c1+42A4=;
 b=RE1cP8SqztaZQlOqqcOweojMw+GraVmVH289uMWBXnevgPZVSwkWFYYOuzMHWVMcQqoVX8rcenG7chkweof6vTPVbnD8fftbv9MXAamU0MuB8tSHuWgna/lKinRSUqvuDJHvhukIiKMV4huXoUot77gp/4HjTPEE4m1kDxp3IT7Hya+RgR2/o/yF3WqmuSTEGVadmIaon7KlF1kP5lggZ7NzDnGz7u1pY/X/NF6Gsr2EYVNEUjt2fNyVYgQm/olidsA46aqsmu2E66oIuyj+6tuH25wVpmH+nbWYJQsusuk6hpkde/smanjMhZwXMzdH+FR/xSjZfIsrUof+YHPuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 19:55:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 19:55:58 +0000
Date: Tue, 20 Oct 2020 16:55:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201020195557.GO6219@nvidia.com>
References: <MWHPR11MB1645CFB0C594933E92A844AC8C070@MWHPR11MB1645.namprd11.prod.outlook.com>
 <MWHPR11MB1645AE971BD8DAF72CE3E1198C050@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201016153632.GM6219@nvidia.com>
 <DM5PR11MB1435A3AEC0637C4531F2FE92C31E0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201019142526.GJ6219@nvidia.com>
 <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20201020195146.GA86371@otc-nc-03>
X-ClientProxiedBy: MN2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:208:15e::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:208:15e::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 20 Oct 2020 19:55:58 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kUxjh-0034TE-1q; Tue, 20 Oct 2020 16:55:57 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603223763; bh=SLP8vj/EWcL74dSbxidrd9H1JF3eBmAw8Q+6c1+42A4=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=ViubdjgYnhDvH6EhxWAXHgjZhlSiLlTfaMAzKbqKAWLYasim5tAkd4AGKmRT0kgix
 yIOkten4m61q1A8YHSalKu2LzcsjMNKbN47yl684OlZszUZub9GDIQ/sqsMjWl2ySN
 VCzocR/wmatnErqiqQ5QCUvVkDEgYHdJuHY/O/xpP2J+buMikKJbNBh7RAqYSDbULE
 //A3ThtyxBNsVXf7OtYR/Cj66Lto5+HAbpcKQpFUbPInqtGWVGvbKVqvCZndsUio+l
 sd+MrGXhTUvK/leV3ysimjIG514f3Vnkas6yP0+Buk6ZljYm9RxzRkjlWRaESghZ79
 6dfqgceHtJMng==
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

On Tue, Oct 20, 2020 at 12:51:46PM -0700, Raj, Ashok wrote:
> I think we agreed (or agree to disagree and commit) for device types that 
> we have for SIOV, VFIO based approach works well without having to re-invent 
> another way to do the same things. Not looking for a shortcut by any means, 
> but we need to plan around existing hardware though. Looks like vDPA took 
> some shortcuts then to not abstract iommu uAPI instead :-)? When all
> necessary hardware was available.. This would be a solved puzzle. 

I think it is the opposite, vIOMMU and related has outgrown VFIO as
the "home" and needs to stand alone.

Apparently the HW that will need PASID for vDPA is Intel HW, so if
more is needed to do a good design you are probably the only one that
can get it/do it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
