Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD7C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 23:41:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326B56137D
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 23:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326B56137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9003400A7;
	Tue, 15 Jun 2021 23:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fkn66-J1Nqnj; Tue, 15 Jun 2021 23:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E17F240202;
	Tue, 15 Jun 2021 23:41:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B30C000E;
	Tue, 15 Jun 2021 23:41:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09CBEC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF67740202
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y_jFUEpXaBgj for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 23:41:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3EB8400A7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBEydQY8JqitjBx302VHzfr1X5KXnml7YayNmIv5DQUJtuzLSffWW6JMFbF6b3GQFjEt6xpA/9AGZXInJqDyWfwFmzyRzZohRQ6gbR+CGnKdOgo5aSN+q5wnlh2jfyOPTr6rGs337FENBcT56ZCqYOXrz6a53BLs2Zl7uaPW5vJFwmDvfuFOkBZL0Uc6fe0F4fhCddGACk5+3bfppohW8zHNH7DYFYvmXRkJGFNT2rTS5MmQsTxUfP002UzyGxPi9KtIzWrB+WFplMT7NZjNm+QQYh4c4F7PpLxekKUMNoq/IS894iyLRVNQaA2vhRRVxvjTfFkWOFtbu8BmZHCFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgVg8AkRPI2AaozuMK1kD6UfVmueKqWmvABDpDe23DI=;
 b=i18dU4wBpnAEc3CrK9D+Fw9PhgQqOOAefwC63S5jDg6UQHou58gwhx6YdDv7JmnTMS3cTHsuVAqGNL5We/WYBP0GxSy0aeYroeyW9NA4Jh+l4up5isgEIY+x404GY/X32ObAjymRtyuz3Igzj2WiksrTEVciQ0qHZAMAlHjrj5czVxPAq9rotdPGVpNuCnyEXCkb2uW3MgpePVH5yutr3gi43rD6pT2+/YC1ceI2JBgcc9pkF2ybZokCLR9EKWzYqe1PBIlQ6vtV+WCYCORbb5pNZwQWa7ZYInIxgfM+La1qgypz7cbZn4bJj52rN2cV6KY0ttn0P8Qy1AjaNY181Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgVg8AkRPI2AaozuMK1kD6UfVmueKqWmvABDpDe23DI=;
 b=dZ9bRkyqsSYAuIh7glWWr/GJRHH802DjyiSYO47ohG1lqRB0bj7t8amH1ny92TU1iwJRtWZ7w/wnyb54hMswk+5YVTGqvZ8N67TxJKFsKgHIGbvsj9mIUTwQXatOpZE4wvq6m905JvHkEWhTpYM9uYJs4QsjDa5jI/ZaDH0BFsXZyQeytigGtpSeh7Ix2kHHjG3vj00RSj4E+lVNRwwfU1PbZCdS6ij/gdkgbjL1u3BRakSfoE8XDQVBsJE6s/eR2Yl8WYz6FlddxZH8tgtBbG4YEs7lCrvjT/RsoXPpR6KbOyQIxs79UEyVT8brcTgQqTbbwZj4WjnHq1d9G2UUJw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 23:41:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 23:41:00 +0000
Date: Tue, 15 Jun 2021 20:40:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210615234057.GC1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886BA2258AFD92D5249AC488C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615150630.GS1002214@nvidia.com>
 <MWHPR11MB1886E9553A5054DF7D51F27D8C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615230215.GA1002214@nvidia.com>
 <MWHPR11MB1886A0CAB3AFF424A4A090038C309@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886A0CAB3AFF424A4A090038C309@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 BY3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:254::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Tue, 15 Jun 2021 23:41:00 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ltIfx-007Ghg-JY; Tue, 15 Jun 2021 20:40:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b277e8-5c6a-4530-6266-08d930570820
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51113059A86CD8EA469C385BC2309@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKp/S3C4agh19S63gTziyjUyoiZc9IVp2PuH0iBXw8sUKtcSEG2hOgqOHCw7X63+WcyehGpFMuBQJPFpek7fpIFim8xc0PNfw0ndLYgTm+Qey9H7TCLM+PJTUHIcJX6PzzDOIhGoSCXTEP0y3ULe1fvz1yxbt5d+sd4pEfaTwykcAGjjcBwUp8kO+giHhlh71SJHNvxeHTgJZAW5GKf2/O6el5xlPLMwpCW4Yh8/SBFxyzf181x2lnfB/Zsz8IKe+XccgxbYHJxr9fkXy6TrN6FwhQ/blJhtlz1jzE1XNzo9h6zlAy/Vj/QXOpws1SHpeDInEKRS4y5i/176DCTysOoTcR30KzJqsxWeyWTdgEn6YnOH5KcxzdaabafVWf7ANh0vm6FkhTWhU3V9rLKW6PNRIag+bhdT7mDLz+1WIrPwOkRs4CtpDAA7R6FUFhG8rPcLgrL4Vp2yKc7VsIwEPKq8ysxoAVGFweEMmIXFdxzcWEAOkPWRpMm4ewGRJ+ckVaT8dz6yeViQU131z2hGepS4iUM0xeLmAi5JXFcNlmRRmUpIHAA+t7x9ShUZ5Clki5DMomurKGBgyrhLSRJt04G40duh0mMBJxt9x9p1vGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(4326008)(4744005)(426003)(186003)(478600001)(2906002)(8936002)(26005)(86362001)(9786002)(8676002)(9746002)(33656002)(54906003)(66946007)(66556008)(6916009)(36756003)(38100700002)(7416002)(5660300002)(1076003)(316002)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtsLVhZJcnrtvUvPhwBxJKHeh7kHtwMFvqawfWyUhZNNXadwZPtRnVoQdrdS?=
 =?us-ascii?Q?WYMg+cDodKfcZM45nze13f6qc3uzBYxBGzeX6VQAEZTDpa9MhNO/e230boRp?=
 =?us-ascii?Q?8oJP+WWarSQV2fBXvKuUcdeTAAxSgpijhulS4c+CIKUIBTthoBP8eXX6wO+i?=
 =?us-ascii?Q?1AZ4y1feML1yFE3xFvSVYqaF26E79zFnsloTlnRY9eS2i1egVaYhmCTUCGrY?=
 =?us-ascii?Q?tYVcVt5viYJRTdpqmFq5O3wuuA5Bo3Zj2ZQFrjjWg7kiMHrQhjwHfu94I93T?=
 =?us-ascii?Q?6E2I1AGfXw8YK0AxyHyMjtU6MtqsBtY70D3hlIhCnhf3QPT8Bx0DBwdqCcNi?=
 =?us-ascii?Q?aBVHfqTOwGO2itZhMtuPJBn94jwAEVyaZ1cqhr4fdQHkunalMBKT8KG6qaf5?=
 =?us-ascii?Q?gLgUEjRXY/bYXIVnFOGgEGfha9/KTDWf9FtV+l/4ErOzVpkQxmahZiV9w7tp?=
 =?us-ascii?Q?eAyLVF93Kc1tzgC4t/sUXPbXafleEA2eDP6Pt9X1CAHjERFQTFHpQ+y1hvhS?=
 =?us-ascii?Q?bkhRk+qgSf/OJKIdlld0dA9P0SODH4Hp0aERmQari9TAR08JT3R9X485+vxA?=
 =?us-ascii?Q?Vb6KUu0GESRgkMgI3ppHa1fhxYNtmPcAQan+12UCIztDT5ooJfFOLVgzvF1n?=
 =?us-ascii?Q?gdBzwhl2unQaX3lyMCKHeFbg/+xus6LwMNVJTg1wCgtYmAQHtppgl/6jiPoH?=
 =?us-ascii?Q?3sbAOZmQi2pgwIbSNSrMSDkbjN3jdDD1MsrBVmD3EQFwsHpr8K4Qwcb3m84+?=
 =?us-ascii?Q?Qq03IAlcmMF1BgeCz+RUw8Tq1QLx+OFS7z6ZXxezr4kAzU2rvdVMi0p325wI?=
 =?us-ascii?Q?hAvSkKIBihWAY4fuAUS1nj080GBKtwPKCnbt9nfRp7EftxFle0YqGMfHRKu9?=
 =?us-ascii?Q?VUpGlA4WLi7FCUmPRRmp7Ju484BCVQxAhQOyfVjKMq7Z8Sd7zYimkQpAbNOI?=
 =?us-ascii?Q?U3EVQYk3TGqe5BpTxzNvPP2bQ99J72FFzMbRvYJ+e2g6VSxSXD4EGHjGKcYn?=
 =?us-ascii?Q?bzIwqhacFzEufRJGxNOYvFecbdn9LD1/JIePL8mWacVf2wsq+ipnGgkw2nr0?=
 =?us-ascii?Q?UP0KyWnrjrawD5l/B2P9eOUZR0H8lKY+mKMq3d0nkmTZBfW4zmZPMwIT/288?=
 =?us-ascii?Q?7e5B/rd6knMsGvf0UStGky4o8M47fhsjJLq3FHDWARoA4N5ONt/9AyIFWz9g?=
 =?us-ascii?Q?Bk7LsPYuk6aXrsmpu2DbvwO2SFrYT40J6ORb6Sx3q0mVdwVznfWYknYwVxRi?=
 =?us-ascii?Q?Q6YbllPMPUH0/gLVTTN/tBUxGPCfEb7Oy0PKklnoIc//mW8s85Ylsv1ru5tt?=
 =?us-ascii?Q?ZSNEHclfngbFgRbPAmvzZsQ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b277e8-5c6a-4530-6266-08d930570820
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 23:41:00.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TWGKcbx/l5ATG8V8PPlAJ69pA2y33wIHfZDK6+Q+TJ2MOXz4Wg9TE9U487x3NIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Tue, Jun 15, 2021 at 11:09:37PM +0000, Tian, Kevin wrote:

> which information can you elaborate? This is the area which I'm not
> familiar with thus would appreciate if you can help explain how this
> bus specific information is utilized within the attach function or 
> sometime later.

This is the idea that the device driver needs to specify which bus
specific protocol it uses to issue DMA's when it attaches itself to an
IOASID. For PCI:

- Normal RID DMA
- PASID DMA
- ENQCMD triggered PASID DMA
- ATS/PRI enabled or not

And maybe more. Eg CXL has some other operating modes, I think

The device knows what it is going to do, we need to convey that to the
IOMMU layer so it is prepared properly.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
