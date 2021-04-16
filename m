Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE9C433ED
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 17:54:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BB861090
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 17:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB861090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B448440E7D;
	Fri, 16 Apr 2021 17:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hu9VqzYHLdz; Fri, 16 Apr 2021 17:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2C00401D6;
	Fri, 16 Apr 2021 17:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 432E6C000C;
	Fri, 16 Apr 2021 17:54:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55D18C000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 17:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48312418C3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 17:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8F4L-Dr2ddPa for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 17:54:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::620])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 027F4418C1
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 17:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPToqQIc9h3ctfxOVtzWiqIgpXAvTqcgMFZen3kmg/J0zc1FgEXerHa3UeDuM51dTyYRJYyFqJ77qHzqbcJ3WvGxHqzkx8PAc5jSil3nzgcTn2DAFNkZzKWlpGKjpZpNbTAV6n727pFtdV/i3WK5Pw+sDqhwja3Npmcw7PMenAjjOL76OkxZoaCEzYLOvqXNB2KU9LbE/FaXGq+VmCMaD+iW6UmnrLldHAklUTbpAUlR4JsBcS5azMvXEbtHsZ86uKUefWo6/va/mDMvtY5DvKLEGqeE3psKzZsLaA674JLCWi3cRklDj39AS7ggpjZJLsILUVUeYzwRbK/U1b2s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exTf1vmaA8iWNEXKuEBLaKxFXzU0i9L1AHzrVzENucU=;
 b=jA/BtFwQhK81hmhbnF4E7Muvo9u7fPdkwx+/HAt3wJWM+MJboXwzG6HQTRhSmQGlm/LoK6hTrGc/tLJHfeKWqJqaUxg6Ttw11W/G6pI7Ny/PJMYOsl57d2htTkf9zMKtStC9J6mJ+9rJRohvYhpTdr75gfz7tKfi7VvjNtUlPsdtXOt0iB73WUtiNkdFfW/oxzwR6Ktc4ZXZA0McCNj7Wn7DB1yu3yi+B2Q0INEwFVv7zrNINWS6SE7AZbLTD9tBTBYHxxR8hP5QkCBo3Pt4iEsWppBbc3Wh8UeisMgyYnQrcIRFJ9X249utG2Gx+332W7OaM06Li5ElG3K/kQa2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exTf1vmaA8iWNEXKuEBLaKxFXzU0i9L1AHzrVzENucU=;
 b=c5fyxwl8tyabtzGMB5jd6JiH2EV0FZbkdK+blNGm/AsdtNnOZttMkve3d0fV/kiCyIy5Prz0lSLdBR49U60IE1SGZPdwUKHe4AKwuMSYeGuOMPkAxvWJ4XI2rQOmAzKvIU0ykx5mLZiOMgydL3HlBFORhjNwA6qxcfdqbvlHLjWvnXaQte0bVbOYJxIoCvCwl3LLOIAIp2YmkTeNou6iV1ATP2DR6MQNjqdg4E9gcmTShbeo7yO3p0cIZ7oBZy/T06sBqlstFp8fqwL0cQgyWsjYFZ3S6Ge+KSUqy2lz/6XB60IBv6EpslaC75O0/GfqBjVU+u7bai57vwFk5n9SmQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 17:54:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Fri, 16 Apr 2021
 17:54:40 +0000
Date: Fri, 16 Apr 2021 14:54:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210416175438.GM1370958@nvidia.com>
References: <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <20210416102332.6f71e53e@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210416102332.6f71e53e@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0281.namprd13.prod.outlook.com (2603:10b6:208:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend
 Transport; Fri, 16 Apr 2021 17:54:39 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lXSfu-007NlT-R3; Fri, 16 Apr 2021 14:54:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8962f20e-72eb-473d-c7f2-08d90100b51a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4842C4262219E1A8260090BCC24C9@DM6PR12MB4842.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TwyFifkj3mQMqAAVrHElNYoTpXqoaKkh12tiM2J3WjHTDcn0cIae+7IxIUxC0zXaQw6Lao6vywjC4ID1cZDUkV1jPjT0OiUl4EoUn3PbeHR6l/PMgpkLX7LS7NV0pn341+tSioeKawHvev9beBpBcETByAg3bMjfDm1IN+9qvy5h6VGEEtJpZawYNMJmhpGPwAuBtwpz66TkasAXgAUwyWH2xarh3qcDjTfWqwWgV7dtbdPR6RghBao5d/R8W7iWjVJLboVh4ABXuphwWEQJqQRljjVVyLXZSyFMECvFty2HE/cacPb+KniG1dhYkn/SkxNhmo+n43MO0/7sVUHO7iLhl12rLun8Dc5tDspP874wz0YCbcxZep8lr0ESVFURzyeQDYvmNz2aqsVI4yaLJgqWy+XeM1MFqj3x1HgqeeGNSmgo5euCe7ZBcmHMyoyvsf37k2BJO8j1U+5I41IR8iCXcoDSggMpVccyR1rHQZWnXh7AYi50kZLmILMOmL82aABRVffUrQTJHIfvlffQVFF11e0fHX/DMDMwz/OJZjLWnEOzMlF6g+IGjUGlOe6XG2WiRrG4+hpra0aKuD504Aphea6R7pUHVZ+kdjKy2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(5660300002)(38100700002)(1076003)(6916009)(4744005)(8676002)(54906003)(478600001)(66946007)(316002)(426003)(2616005)(8936002)(7416002)(66476007)(86362001)(33656002)(186003)(4326008)(83380400001)(36756003)(2906002)(66556008)(9746002)(9786002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CZwHdFmklKQN874JiSQFzgc6QV9CEQh/jd6ZjZZG3S9DhZjtLo2n8WJqFJsF?=
 =?us-ascii?Q?MBZUF6q9C0RpkqmrmZ7O8iZyrl0rkY470xXq9mve7imhr47QojonZdRgOcBv?=
 =?us-ascii?Q?/9ztHzQ2Oqg4hJkM3R8SE1pOr52o9BUMCXY9JRkKOFPy+rFpB4NhKHOcbFJW?=
 =?us-ascii?Q?CeYhCYy9eAgi9TuqBtB5txT3/czi2Xv6/rv3X7Lr2GMCNdLzdvoAsowP5Hiy?=
 =?us-ascii?Q?PwhJERtLJIci7teMDEK8lh4ItMiQD+XTe2cTRJphHeoylj3k+hrOEL+/YFx7?=
 =?us-ascii?Q?AlC5KqGZpCdRrLhQ0viNTAGfbJHffPe09L4GqGj6+FFmERWt3GsIzLpPqJTR?=
 =?us-ascii?Q?PDeoM3ZQ6PZr3fkEKFQMRTqQ03+qkRQk8mGlxnaID+V718JmqvLIWTkamluo?=
 =?us-ascii?Q?IHPwfonswxZHl8V9/yVgpr6qszoB60+XrV5rDUTBAA355YBxWHlGsF/YKofx?=
 =?us-ascii?Q?7b7myQDRBmH2r52hvUtPOl6LoGqE40/PAYT7J+jrkhHquU9rbwEWQBLhGYJQ?=
 =?us-ascii?Q?yZFUOShrucCSOMUTUQ/nqa2oP/d8LokbFm5j8ywN4rUOoBXqbziJGhb258xs?=
 =?us-ascii?Q?pjRRzJCTRt9BLGCxi39rZ/p84eJK1tSRiYC8fjc93SHSEB3EC/ziUQrJdN91?=
 =?us-ascii?Q?cl7Drg7gfjpxbLSaMJuubF1T4YXn5/INcE0h9Liw3NSlJvPlzHtNJrOHYZBG?=
 =?us-ascii?Q?89e4Roe8uGztXxpggxoGN4ivYjseSsJYIviGaeXA9cxaiomoHR+QZqNzw+50?=
 =?us-ascii?Q?wQM150Xqq2yL4q2wV1B2ZuEXppVa+J4pntqOF5/bB/FgkO40IhA9yHXYI945?=
 =?us-ascii?Q?bEVAsD/JhkIXiJHV99NnfuYD/xfs6PXLWMGw9LC4OkIa4qNn2VgHlUYaMsdk?=
 =?us-ascii?Q?Nhuo0Ocu9+/mOBYFwtDLccqn57LlgZf0vMA1irKnheFQ03e01SHxo+lduX9m?=
 =?us-ascii?Q?0ptexfcMbvEG87DQP2/+iIgK18tTCZcxTIHiNGlKB5Y0w5hmSZ1d+YCOqbkA?=
 =?us-ascii?Q?FqxNMQs7WUzN3kq0oYsQd3WWwA1J5BBNo7e93fBkHhjp/H8d8KtOXE1eaFay?=
 =?us-ascii?Q?HEtH9S40Iju5Y+UJvNTbGvNPZSiqJp5yVVtEeASVNXJgn/t5bVJ200BAFi6q?=
 =?us-ascii?Q?ekK9axIHsAj97QOf4nQKCE1BGNRDSfzJSyG8lbL7F+xMnW6ZKeQeOP7CjAl/?=
 =?us-ascii?Q?M4OjBVdMAKmCfCpUmROu1OHn/7nLCuxlvpWl892x6pF+bWNjFpX8D2TjKmhJ?=
 =?us-ascii?Q?eGDe4Livdihq6AaTFXI5If8cf+fQlzsIpzQOKS/KQ4XClv+M26MAYGhBe3Fr?=
 =?us-ascii?Q?MkyhrF9gkXiDrJ3OkR4cMui9Mo/0mx7lLdv/day7pCHWLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8962f20e-72eb-473d-c7f2-08d90100b51a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 17:54:40.1423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VM1URiudA+/RO80pFxTB2PYik65LjVMWEPb35ShU83jHkRALLEqs9Q1JE/sRmvC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
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

On Fri, Apr 16, 2021 at 10:23:32AM -0700, Jacob Pan wrote:

> Perhaps similar to cgroup v1 vs v2, it took a long time and with known
> limitations in v1.

cgroup v2 is still having transition problems, if anything it is a
cautionary tale to think really hard about uAPI because transitioning
can be really hard.

It might be very wise to make /dev/ioasid and /dev/vfio ioctl
compatible in some way so existing software has a smoother upgrade
path.

For instance by defining a default IOASID

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
