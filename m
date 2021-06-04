Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BAC4709A
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 11:58:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BA56140F
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 11:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BA56140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 647864061A;
	Fri,  4 Jun 2021 11:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 388ElfcK4vlS; Fri,  4 Jun 2021 11:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D83FF404A3;
	Fri,  4 Jun 2021 11:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C3A2C000D;
	Fri,  4 Jun 2021 11:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 377DCC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 11:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17D10404A3
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 11:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2juoILQHE8R9 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 11:58:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0420C4016D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 11:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeAVc7/0HN0peOJlxpsjk2qjBbAXsi7guScLdJyKr4XilOs4TBA/husus/8To6zrkC67zIW/xi7wqvI/AvlR2Gq8HnAgJk4ei1IeVtG2+3kNSicvy3tUzI7PoVrC58IJD4pgcXDMRJfsqm8pIxwqpVdB6bWEvcj5JL+1olp0EDOazMCeBpDx+puuqDR/NKaPHQ68CFna9OhGPTLMjpenL2XXhqcsJI5wHJK1Y+gzimbBYmx1HF4SEpc5dS0Jg5CVgmqjMRyUBYhmrfNfTO6CHTjkfHqOlmaLd54A7zaR5Xb9ZQ4m5FtZ3bDUBddxyapJXSR15w9qypV5NrNDN3Xb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Xg+/AnYOUviJzaYaH7QgXrYZzx30O8/kSb7B18maY=;
 b=GvZuRhGm/5G54qmYqjN/Mf5xgPXZ8GWwPIfVdJmgWJNK9CMMvOJtuBTah7o235sJbUQlcd7Fx3oI73GuYWumHLUf7TMUceL3/9E1wfvxvdX7UGjRV/VBcv6c+yqlc84R/5pNB7JPYG4JYc/efBExWCKWbsWmMraKkNoGju62aKDTE0dYiPZsuo6lerSGL5afLhjqfuiIP4Fh7uJq7q3rysxNin6ZnR0+1IuF3JNcWn6Ka2Mz85aZAUeR2dWQi+LQhSb8nfI7ELTUSlnDdIX9t2K5Ukw1TuHzcpyXmLi9DE7L+sS0BrmNDv2AAD/p0s9/LtpkFiy7r1/QLUK0aSW2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Xg+/AnYOUviJzaYaH7QgXrYZzx30O8/kSb7B18maY=;
 b=UkEpYHqQHMYWzimnQpz9fMjIuBdiak1NtzkZ6+E+tnEndF1XZ2D8as1TrxaeeKsX0MqM6EqkCy+YhA/apjDCMXTa/cBjX9NSle5WBDyt/EhEqUimyxG1h7PGC8yoN3kyObkzhFialrcZHeaEAoNlXC+Ktof0komNkCSFSXIRNJrxf4/Yq2NJcraXdScgpdpl5Y5i0onW7dgEHeKobER/z/Jt1dsd2Br3z9nZgfHhevUjZ7wRe7MKULIxkJznViivY7yDWtMYsa+sVvjkxH+Z1fNjWixo/H+LsI//ZO3Ix+YYm1f/LRPoVqdWKqVm3grO3xd7utKum2EereJBYoPuZg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 11:58:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 11:58:07 +0000
Date: Fri, 4 Jun 2021 08:58:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604115805.GG1002214@nvidia.com>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
Content-Disposition: inline
In-Reply-To: <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0421.namprd13.prod.outlook.com (2603:10b6:208:2c3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.12 via Frontend Transport; Fri, 4 Jun 2021 11:58:06 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lp8Sk-001d1T-0A; Fri, 04 Jun 2021 08:58:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a499b51-c25d-413b-52c2-08d927500401
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53178147482F6ABAA59BB51EC23B9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FGEa9ZcNBh1kkuJ2BNoZsdlqe8YcKJaj19kzTbLtfbx1ENdhQizQBqdPEclzXxqaiPDx5sD1OZ84Kw5HmjPFz6+gW/CuOovpiAaSlHcQRJAl8d1qVfcOK6RaJ/uJ/aKLxF0D7YHZwhaENimoKSO9XhxvB/UbkwTl4/Wxrk40lnffOOxoUbrk2LS8stBdC3guptfxkReD0GH2iYwgpbG1EeDLUeycU/TppO+XeNJB+YuthePSQM/2QX8JEZChAzSCqz4cKp0uw9tidLP2DSXX2BKGhAkXAmxe0ptZZcX4JW+GotjJspl1eAAZBME7v6AKhq2iTVCCKJZW+b+PXKP6RXWtxiG3Bw23pBUssFsajvrDzLrxpGOWgAEIoUbMX08QDyi8aNXFZ6A8Ea/FxwUpBjVSuvr3wCyVl3T0adYxjGQxSVoPAGx2qHx8o+cjGctCHytAHeGKLzCRz3uZEtF5+rx3vMVAk5cO1/NYH7tp+H01weXU01wyqgczoQkI6cwQCQELJbFlVZN9bfGEyERfd91f8HpBpM8mq2auVr8wEdSpG7Krjhyvgw60Ez7drhDz2E5Yh/cBRB2b4r7CAJ4SYbGSNP8XeofcPlZjEHemig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(83380400001)(7416002)(33656002)(9786002)(9746002)(8676002)(8936002)(2616005)(2906002)(426003)(38100700002)(316002)(66946007)(66556008)(66476007)(5660300002)(186003)(54906003)(1076003)(4744005)(4326008)(478600001)(36756003)(6916009)(86362001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aK1rr0XiDdCDSAJC8t1h3H1htQlX+6EiojOC7hD+d3XZvMygpMsPszZ+VIJk?=
 =?us-ascii?Q?JTOiXAlbNN+I+HsTA35yqQb+G2KYFdOcxyOF+oFH3uPsHw7JXp8Mi1uoPyAu?=
 =?us-ascii?Q?EunLjlBZnt0rl7SbAavwgxtehiom/mFfpiXndYaNfxmY1kXEKOT/lSFGnUWb?=
 =?us-ascii?Q?M7tMKY5qv4UCdn8NnLCylMfXHRBk6XRqLUoJspNIBvTc5FHRAIzjy7ZoAOB+?=
 =?us-ascii?Q?EecHGslHafwx1BGteb4CCgE8kqniNtdIqQlqwISC5sKf+Pe2MiD24JKGMW6D?=
 =?us-ascii?Q?Qx2vw9VWp88vvmjiTnjjwRfVly5wxDC5/zuspmnxiCqzXsRZGe2wQxSAD1V7?=
 =?us-ascii?Q?iu4GEvNPZil6ZUErjmkOme8ddodda8Odmuut8h4rC9GFOyzqkNqkRCW47Otx?=
 =?us-ascii?Q?IhMu3wZLiE138jDLrpgG8bF1RvUFEuxabDenEiz6tc4t1mYreWZxnyS1iB+o?=
 =?us-ascii?Q?9qnLQln2nZYRtg9Skc3Fkyge/hW5Irf6COzG8HijO3LJ6+SFm896G19/4Cy3?=
 =?us-ascii?Q?QObp0ltHY8WKpKVe9s8GXweDQw/umQ3GKXZfVee14P4e8YFBfMOV4Enn+aaZ?=
 =?us-ascii?Q?MAjbEI841v2nmq0AElKwDJWPTOniiwu9m9lipwewOd1UA7uZBKsQ60eSfCVC?=
 =?us-ascii?Q?xW1zN7D1KsSCqKe0g2fDQPCQa0BLOAH1/eGMqceMglSH7i2kwGWBrKgsVr7d?=
 =?us-ascii?Q?0MPwKK2cNgK0VbMYckphPrUDGiK92hqA8ETdYOrKb0qI5Ha1YszclPwiEWsM?=
 =?us-ascii?Q?uyaDmrCTk7B7w8b5jRs7D7h1x/6w71JFtCDSAZR8IZvLmfdKZaAKnperC7TK?=
 =?us-ascii?Q?JZhqw9Ig64n/1M12+RJYKvftW0H1hoASFgOmIraJe5gyLgnNrB2CR1LMLkrJ?=
 =?us-ascii?Q?zsVMAvqa37laOxXQpiqDlvogqXyTiDSyBQMgwmjy4C2oMJ1h/xY+pCtXw4e4?=
 =?us-ascii?Q?xVvk33u7iXplzzMuR2QBTexu/eQtx8B29Um/1870RNx8ujK6K2tDIWw+dQtt?=
 =?us-ascii?Q?e8fkUBfixdo+3ocGENKBcO7wKe2VXGgytpHA9vT4+nUSOw7u6kOD/Tvcfvot?=
 =?us-ascii?Q?r8XuF4vycZ8lBihwqOt1Qv7oCKtpCS0zkcgl0YqcNy+ZZ6+RjdV9nF2cceIf?=
 =?us-ascii?Q?AdbjhHlNvD1PwMUhqVqkhAE6ClBJSxB9rGBm1sRDcfOev4OJfeJTVugvHJPx?=
 =?us-ascii?Q?SsnrJCKKmT1mY+spe9i+0pf4CjhVaLY2CSmKrSgAZsuFtXL2nkVh6v6zVlJ6?=
 =?us-ascii?Q?JXyKOGRLifkEci3Elr/mxzhoNzjBxSiL23nGaRXZyyK6G8g7T3YIBH9F5EwY?=
 =?us-ascii?Q?6a+UqzplYqATx5nmVY8cJfDv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a499b51-c25d-413b-52c2-08d927500401
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:58:06.9460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wC2qmIpa+nXfQbiQyEWed2MVbPRnqZD0ghaZQiASUVdb++x2GNSQ8ygxb9RnQ2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jun 04, 2021 at 09:11:03AM +0800, Jason Wang wrote:
> > nor do any virtio drivers implement the required platform specific
> > cache flushing to make no-snoop TLPs work.
> 
> I don't get why virtio drivers needs to do that. I think DMA API should hide
> those arch/platform specific stuffs from us.

It is not arch/platform stuff. If the device uses no-snoop then a
very platform specific recovery is required in the device driver.

It is not part of the normal DMA API, it is side APIs like
flush_agp_cache() or wbinvd() that are used by GPU drivers only.

If drivers/virtio doesn't explicitly call these things it doesn't
support no-snoop - hence no VDPA device can ever use no-snoop.

Since VIRTIO_F_ACCESS_PLATFORM doesn't trigger wbinvd on x86 it has
nothing to do with no-snoop.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
