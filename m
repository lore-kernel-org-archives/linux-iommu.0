Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D665EC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:15:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A63613C4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A63613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 113DE6066F;
	Tue,  6 Apr 2021 12:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guVtfH7kpHpy; Tue,  6 Apr 2021 12:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id F372960621;
	Tue,  6 Apr 2021 12:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D9DC000C;
	Tue,  6 Apr 2021 12:15:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C49C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 013CA404FF
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R03NMx3rEER9 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 12:15:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::600])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F44C401F7
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7WQ5udZNya7hWn9+I7V7BTXaJzKM3JxPRlUIzAh5GRq+dI9RNggrIecYj38TOTCbf6wktXC/9lU6rRxuFT42uuOqzRxp7YRDbOuqCrk78fzMJmVUNBpAn7eDc3IudACKFX/+dWINi5JzHyX4+988G7NlCmIjvzFi+1F2fsZyHt21WBjkobOnimU4QxZr4zsiCco0oNDbq2Z4lo+G5oIn3bB15fzjy2bTzhf8MATZ1CJOI6dsUoaxyAQfFx/zYDBYqaE5EInc/GE2HVCTKT4UZU8cl0UaQk8hRn4L9JCYqZ0RmsVK7W5Ah9hFVLlU03gVwQpDB7axCx020/ttPnS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAyWTpAGiBmIhJeujMEDNxR36LohagizGI7BWUhzgCo=;
 b=jhYmcAKGFQ4O10PXKXZQ8kXkHUikloTBHIIdUK8lM4g/eNgz1IqW2rwEExAiHk9h6xYKVfftoxEe1AXUHSzX0fLVBsV5n69QZbHkNrQdfydD29hspsCuFvNaZY0352MMiJLEVNkMKoxEGykYDn61LS4LQxjM08YCqNw/ZLenU7h9hVkkJgqjmYIOUnPzk8r72TCnLsavn19BtR4w2RTwls/dD9G+2chX76yn3lEL/kIP0nkSr9oQelAE5lDey4KpYWZ1MQiD9Rzk1ODHe0Jll6maxko5majVBCHl1X57UBjY4xXDKxuJ7Xnc71qRbNEAfqaJ+BM5Rhm7wb0cu84vxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAyWTpAGiBmIhJeujMEDNxR36LohagizGI7BWUhzgCo=;
 b=qIlL15XsQ02PtaeaYyl+7oAuoH8i6ae1nr+6e25M6efcJHloboiqE7XKI5lVX+zAVFYtkrlCcD/NJXseo84obNTzS3sgR7EVEKXO5y7O3tCVnV2F7KCRTR61/QgIGoxExqKu91OasfecrniCDqhXzZ6lAuOLNr89jxpZ0OEIcDg1gOjjVlCb35zp7ic+u2mvaj5z0Hy/fqtFqw4VF4apSCQG2AL02JxsTcYnfMRzCmiC3I1sgvoaBbaP0EFa9ngG3fMQuwHQhAcp6OKCqdDXQT8U5O+z7wuWFFr2O7xLpp2/C2bP64HwDBDD19JbqYOSaYOQjI7WyWQlQHK4SBFS6A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 12:15:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 12:15:47 +0000
Date: Tue, 6 Apr 2021 09:15:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210406121546.GL7405@nvidia.com>
References: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <MWHPR11MB18866AB35A13A139262347FD8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233526.GD7405@nvidia.com>
 <MWHPR11MB18862BF4EA4DC0CFDE6CD2238C769@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18862BF4EA4DC0CFDE6CD2238C769@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 12:15:47 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lTkcU-0016p2-0k; Tue, 06 Apr 2021 09:15:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2278bd09-006d-466d-6660-08d8f8f5b5a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301987F31C6BF7041264CC71C2769@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1wj8SVuSsyPYrorTKCTOwVBzELm4/qL5I93qwVWV8kvOjXDML71rw05+P8opOF9AAtZjHPQLe8zGrwgYyXz1a/XIr3ZBZ9azQvvkiylxdUefWLdEd4aopvqHEZaP0uDsCKrp0+chSYMvNumMb86Ip67Dtd5dyzAsJSMWwkImK81xWPzRSUj5XSxQNY2XyXyqNNtUmF+StJgaOWAZk7RIKEPcAMMQDwIYVPW8UzvfIy8pVXBIo2jVPPBzUQGdgKeuRLHmjQKOpxTl4vHHjWLJe3G7HpuLwfHVVkASSgxsKMrf3PL4yrX34ef0V+xm26Oesfhfrp8YyTnlckKwJKqG5fUneKUniTnQohjRAXuEiOlggLhgO2H8Dcao1GOdVoozoImFJrrnHEGAk1Z/XfV9+lKr8fpYms2iDgSir5njyaBMQ9O2gX6vJWe61k+iRUj2dVGsiKYWrdSmKrLgs3+FUAMaS1ZtOf/GTgD+v4z5oZjTlnjMKsGcn6jKIp9Qvfa7tRuVoH3fSaiIglPkCm7jPqDeMjWpzQcJ1clNSUnViW72wsQFf96UaNPzinuO4nyk1ESN2mpM9zV8Wng5MwWx/3naoTKEVW2slDcg/nkdrZeAvqj9KP8bIhC0itrhJ0Xn+qwwnwXukf3Ew0wKLL44BLVr8rBLTb+WUfogW8kDfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(54906003)(478600001)(316002)(66946007)(66476007)(9746002)(1076003)(9786002)(33656002)(66556008)(8936002)(5660300002)(4326008)(6916009)(7416002)(186003)(36756003)(2616005)(38100700001)(426003)(2906002)(86362001)(8676002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?taf4w8TRYhi7+MEkiAo6hMhMiAyhqqAfQ2CldLuvuKwiFHzjrSiKbmhPThzJ?=
 =?us-ascii?Q?YfdVicbBjTSnApLW0mzLv2VM/pWWd1Xs2gXzYzJTvF4jXVp+alENqDknlde9?=
 =?us-ascii?Q?a2X7u85J2aMNUvZZaPiF45C7fUUzvgT/iSwleBT9M+0QRuyLIT+D9UxuyyBn?=
 =?us-ascii?Q?/dTuZ+R1RjqITawBaIgPyLJfJ/LQCi5KcyV3igfVYWXpBzYEk9KtT9w5po+p?=
 =?us-ascii?Q?t9Z183aHbGlyDiHBGLKf9a96CBaqvmLagMh1zMNlZ3wKYlt4MuB1uhGm25PR?=
 =?us-ascii?Q?CyUKXHc5o1BsZ1EwZOmEJPv8WiTZlpQjht/lqw53e34Z/Bj0gQAXdp9K8IkO?=
 =?us-ascii?Q?u+uwktJwvMRbQS0c9Kk8DTx+ezIDuFcmHQN2d+AvNx3Z7Q/WKlA+QCPqhx52?=
 =?us-ascii?Q?N8wCB6yEMjdE9ZhkwdsgZwvkKl6sH1xqRBvqTrOsgOwfZ1yrp4B6zOMTssHe?=
 =?us-ascii?Q?ktUKvMyxO27zqzcO6fkJfzu5d1Fli1BQ7HWcyS7K1ic/Hiz1aAkzvaXgQIz7?=
 =?us-ascii?Q?iqqUme5kjogZAyBf7Wh/zALRz9pq6GUBbScDVx3BR8u2IwU3OwJokCocZUqu?=
 =?us-ascii?Q?yqUk3SLu14KkDH3UOrqMLxTJ6INgDPiK3J56VTUSFEPfJXLQ+tUDsv+Usea8?=
 =?us-ascii?Q?+4TZFVrvt+b8qRf10GeiaPzHYGDBUcb+SbkeUm+xd85l97IB7O/3ycdP8iBJ?=
 =?us-ascii?Q?TP08rQYpub+iaPwg/dUD+ss5/q9KlQ2C9tsngOK0o68GQ8/+NqBaMEDPSmai?=
 =?us-ascii?Q?GtccUDqqIobIka8c9aYXAJp6MREiy+4V5k9j2tpWT19OKQRsZ77ULoFwUnu6?=
 =?us-ascii?Q?HTh3XR7mr7lwi7LUWi3aqBX5wLc6/Ac7zZBoVsV6t4vChpCHbAy6Md49GOwc?=
 =?us-ascii?Q?ihawShlCHvi0TVIHIy/ApX//nJ/XuiqrBVtO9lsXJvaeKuzytcXUZuUaDDhT?=
 =?us-ascii?Q?+CrqCCBVbJaQ2AqwvGu/FOgxVMWQfOCuPJusBrWZReSQwe5afAeG9EeU/L1B?=
 =?us-ascii?Q?DNxVgvfuvbcUw5uXZdORqY1BRTQvsyH9DFMdR3VFVTnMUM2YRZ4344AJ/HuK?=
 =?us-ascii?Q?sAK0mt/h+jRWAaWe7bm66+XzbC1ne0aK/UtU2s6uIvSa45KKv95pofiF83WH?=
 =?us-ascii?Q?G+KGk8V082UCS0NV/Q0f4+oi2t/u1ZwrPJ9howf/CAN2q2xcwuvvhVU2Z/2Y?=
 =?us-ascii?Q?4ULvoLwCAWzBkdorKrw2wmM5dncC5s2xtMc0DQT+O1jATVL0ZlaZGEge3MSD?=
 =?us-ascii?Q?boNfanU84J2lS93TY20U71YahzJ1HbIuORiRZxp94lh6YAXIC78Vec/fvtSB?=
 =?us-ascii?Q?D4FlQD0XO8+BEBySLAzoyPZvIeVB+1XoSETqhvM6lOaXmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2278bd09-006d-466d-6660-08d8f8f5b5a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:15:47.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Jprj6pIADsWKI9Ao7+bfKiHftdz3DXf0iP+BpAT0cFuWb864AnZXXcRYzRoiBBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Apr 06, 2021 at 12:37:35AM +0000, Tian, Kevin wrote:

> With nested translation it is GVA->GPA->HPA. The kernel needs to
> fix fault related to GPA->HPA (managed by VFIO/VDPA) while 
> handle_mm_fault only handles HVA->HPA. In this case, the 2nd-level
> page fault is expected to be delivered to VFIO/VDPA first which then
> find HVA related to GPA, call handle_mm_fault to fix HVA->HPA,
> and then call iommu_map to fix GPA->HPA in the IOMMU page table.
> This is exactly like how CPU EPT violation is handled.

No, it should all be in the /dev/ioasid layer not duplicated into
every user.

> > If the fault needs to be fixed in the guest, then it needs to be
> > delivered over /dev/ioasid in some way and injected into the
> > vIOMMU. VFIO and VDPA have nothing to do with vIOMMU driver in quemu.
> > 
> > You need to have an interface under /dev/ioasid to create both page
> > table levels and part of that will be to tell the kernel what VA is
> > mapped and how to handle faults.
> 
> VFIO/VDPA already have their own interface to manage GPA->HPA
> mappings. Why do we want to duplicate it in /dev/ioasid? 

They have their own interface to manage other types of HW, we should
not duplicate PASID programming into there too.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
