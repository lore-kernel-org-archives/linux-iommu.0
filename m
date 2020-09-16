Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B621C43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:01:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FCB224B2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JI0hdWdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FCB224B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 01C5B2035B;
	Wed, 16 Sep 2020 17:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfKCv9assqfX; Wed, 16 Sep 2020 17:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 767AC2034C;
	Wed, 16 Sep 2020 17:01:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 495EFC0859;
	Wed, 16 Sep 2020 17:01:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 828BBC0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6641287065
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UsrDfB6Fqd3w for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 17:01:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5C7B487002
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:01:24 +0000 (UTC)
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f6244e10000>; Thu, 17 Sep 2020 01:01:21 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 16 Sep 2020 10:01:21 -0700
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 16 Sep 2020 10:01:21 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:01:18 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 17:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnEZQfph1Ric44gtOnrJ2etsNiljKb/hAjYZrF4mzYkjxpeo3x3NeS9OwSli3cYvfzGRqXf4y+C9rySNpmSoOPMaf/TME5bGUyi9zo0XFlD3CqpDHBG4T+IYDepX+kMif8qwN1zsLgQdYChV4n2bY/kGejYwgCY+vEdRJQShicfaVOcPLV5Oc/cl+Lm8YL77PI8mPf93EynsXgHrF009xhuBlJwxNgfivHSs2riRaMveLqnAfILDzmmf4SCCO0RNEGPrU5MIY0n2ogUK7Cg+YZNQp1BhZVnpE+i5cqGRm3JcW+mQZqs58jYVntH99jgwAt7kiSJpkNrwd4qRLsNbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9G4PdIR083fCvHwAGLb6VZlGgUIwACiebagwkVRK14=;
 b=ccHVsN7oGUwJL3H3To34gRNiiayZpzzl4F7VB6g7FgJF7CVMIJJXpVn1BRzlgqJmIW9/GhXZ/E6VsK4M3xHM57+YbuZLaradIIleNBlelNMs8FvlAku1ik8AR5JCLYtsjR6wn5eb5hm98IuAWbVGITu3oMWU0wq5yHqDRAGAxekWAaIow+0kwy6i8t2mars/uqrBGb7LqUJxx2+mOH33gb7blZqe4K7I7OQrM2+xkNjIYOtZb4BJQea2I8aztpUcrgmUOco0AfNoxobEoT8PpWo4/kOBTEYd1wYflh7ZxUkhqMHTvq4Qu7uzjvn2sh+iIVa81JfR7knzDYOpO4vczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 17:01:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 17:01:15 +0000
Date: Wed, 16 Sep 2020 14:01:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200916170113.GD3699@nvidia.com>
References: <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03> <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03> <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder> <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com> <20200916150754.GE6199@nvidia.com>
 <20200916163343.GA76252@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20200916163343.GA76252@otc-nc-03>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 17:01:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kIanx-0005OX-JS; Wed, 16 Sep 2020 14:01:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e010862a-6f5e-4ed7-01ef-08d85a621f64
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB260136F4919DDC9E467D5062C2210@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF7AROpDTfM+mb6CTaAo7c1lw/2uT3GPvB/DtJDX5xFLyYad4QQPMvoZjujhOceHt9mvd6l/hIdtZuy5irTryJe/pbaAS3ERJPzOKSJMpJWxEKQUclMh4GrV3shA6L1sCMJGP4VgmI5e3vCX4XoaV3h7xWq4u8bZtGK7iVRocJVjbtCtO4xMWrT4d69vkqsRSrmOYgq9mJ8kcWknoQzEwongEJ5vOpSfOAWJ8N8N4KEOZ9gHTXzM8MVt8kngdnZtLeBDTw8fh4KisqeEaNw2vFtIon4ad5UPsZt+D5jcafeksKy9aukNiaCEj4lfDezVNHQirzlRo7EX91rsKIrakxEygi9W7JMxQlWX6oGh63KF0yfHweFRrBadlKNwQejU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(186003)(66476007)(66556008)(36756003)(5660300002)(66946007)(7416002)(86362001)(8676002)(1076003)(33656002)(2906002)(26005)(478600001)(83380400001)(2616005)(6916009)(8936002)(4326008)(9786002)(316002)(54906003)(426003)(9746002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1vUUlMQAebyfnEuUL5K8QL2qvJ8OLux0bjRlM+mO43EfpNRAlo7YRfqO06WCMw5MZcVi6i7l4JbeBT3jiEapMxWPPHnmySrWQWy86qmQQdfVQx9lr0G0UKhRw0OdJzTnzg5pg0AOvaA7BDePQNhYAC4pvADRk1MHUI5FK3MNwijV8Z8pRXlWOkx01c94oXeI5h0/BA3brIVmWlEdy4DgvENddGdAgHhyDbP5NFoZBUDIbcPZuP5WdZ0zUe9BTAgDdjoNBnbcraVBl/IuJmVULJ4OPDtNjlDghNKtKoyKNiWWKBKPXxy84WrxxT/jDouB5+vg60V/zJtKl9GyRehj0ezmce3E3/gPeigbgv+Gb/2TgheR6m7q9IfZOoEiaTJJamqYxRP1/aoqEOyfASr9+hVKDctPjx7Bcr9YSbD6XFqfwMbQ9g5iOxC7zA5bq4b5cxr5I+AytQ1LjD0XkOVDHAMTA34Iklh9B/Z1fhA2ox0lrPe+a/SNvN0wttGdoaUqhJLrPv2ihJWkv1W2vsYAxDDWBP5J/wll6i/CmbKM35lfM0Fy8r9twVi6ITWmT7ao7KHq6mWkM442Fv1dAWc6W9h3gPgDSxysbG5kI8iUIHQox1fhCAqbRp1QSDg7N14kZMGHLPIXYzjfVtdQjgcqrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e010862a-6f5e-4ed7-01ef-08d85a621f64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:01:15.4766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v46Z38eh2mUweR6pn95K73DIWkxZ+5t1kKD4jaPOGfZaS42J6DsfU5vJwwy+Y4br
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600275681; bh=J9G4PdIR083fCvHwAGLb6VZlGgUIwACiebagwkVRK14=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
 X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=JI0hdWdb8OnggqXxXCsMB8UMX/57npbNhiTmvN4FAMK6mLfAYJxXrc0dfYZaIxuG1
 lsF2FvSN0bmYT2QJOvjH0CkBqnMI18lsNP0eFpD9dzOyqxl5nz+LZO2ULVhYyQoQW1
 7z54xBmwtwkO18SI6MZd1gnPtKVMCltzFiZuF9TNbM793iKdiu83aRog0A2+WQiRo9
 iivPoEQ6pMOZjwpn5Ey/X48JAhiGI11/XX3wGBtRfGzB1lLJW4bwx7uUb+UFnKlz6C
 HywfzdIycge95jF9ukkdp/Kj61T+tZWoP8hSsTVlFUE5yC9FXpaZel5kBZvNRaMMKV
 VNRGXSQDWa2Qg==
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, jun.j.tian@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 "Jacob Pan \(Jun\)" <jacob.jun.pan@intel.com>, hao.wu@intel.com
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

On Wed, Sep 16, 2020 at 09:33:43AM -0700, Raj, Ashok wrote:
> On Wed, Sep 16, 2020 at 12:07:54PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 15, 2020 at 05:22:26PM -0700, Jacob Pan (Jun) wrote:
> > > > If user space wants to bind page tables, create the PASID with
> > > > /dev/sva, use ioctls there to setup the page table the way it wants,
> > > > then pass the now configured PASID to a driver that can use it. 
> > > 
> > > Are we talking about bare metal SVA? 
> > 
> > What a weird term.
> 
> Glad you noticed it at v7 :-) 
> 
> Any suggestions on something less weird than 
> Shared Virtual Addressing? There is a reason why we moved from SVM
> to SVA.

SVA is fine, what is "bare metal" supposed to mean?

PASID is about constructing an arbitary DMA IOVA map for PCI-E
devices, being able to intercept device DMA faults, etc.

SVA is doing DMA IOVA 1:1 with the mm_struct CPU VA. DMA faults
trigger the same thing as CPU page faults. If is it not 1:1 then there
is no "shared". When SVA is done using PCI-E PASID it is "PASID for
SVA". Lots of existing devices already have SVA without PASID or
IOMMU, so lets not muddy the terminology.

vPASID/vIOMMU is allowing a guest to control the DMA IOVA map and
manipulate the PASIDs.

vSVA is when a guest uses a vPASID to provide SVA, not sure this is
an informative term.

This particular patch series seems to be about vPASID/vIOMMU for vfio-mdev
vs the other vPASID/vIOMMU patch which was about vPASID for vfio-pci.

> > > If so, I don't see the need for userspace to know there is a
> > > PASID. All user space need is that my current mm is bound to a
> > > device by the driver. So it can be a one-step process for user
> > > instead of two.
> > 
> > You've missed the entire point of the conversation, VDPA already needs
> > more than "my current mm is bound to a device"
> 
> You mean current version of vDPA? or a potential future version of vDPA?

Future VDPA drivers, it was made clear this was important to Intel
during the argument about VDPA as a mdev.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
