Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105E6C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:55:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A922B613D3
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A922B613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 587D283FAA;
	Thu, 13 May 2021 13:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BuqrrA1ey2NH; Thu, 13 May 2021 13:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F99283EED;
	Thu, 13 May 2021 13:55:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36161C000E;
	Thu, 13 May 2021 13:55:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1581CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAACC608F3
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxs9QLsP_fmJ for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:55:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05C50608F5
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALuCGfBJdnhsrWZ7/gTEo0m3mrOHOZ79QpzY+1mL4up592MZM7XSUK++zER2Q7Zlavuox4/tdmusvSpSMJwk0Tec3BreAYrzX0vlm7dl5i7Rj0D0q5pT9bSJITp/7yZheQ6rW8naV8hC18SUAZ5kVgloH0YtJefJZpN5U0W+Jkhr+5gPAOSitMHRsK5rU/3zCAJEzsRu5ry0rjxIUaDMgMDxWasg84J9ZE0RGcH8Ms2hUO+n3lTe/5JNbhRmTcwOEnM1aIfHApJJ0k89SsMa4H07W2NLzEJCpGWCYJp0nlBUtxAw2mt/Cj1zL5tJNF1katr9TBLxVT900dDOciyAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV/70pglIClI+WWS32XYL5zD2ywvBpVyxovVe/GLPn4=;
 b=k+1ydnBIVURTGKWCALqVSAtTXvHpC/UndcMSRNfeE2sB3a7Myz+QJtIRalDXjNfsOVtSSihbMZTqRyZbTO71JyMacc01agfvC79Jggvu2erWgajAAILWGhx9FehHuR5t3bW5crQID4ZWmeurkABMoAoJA6JzJi5yCAXWgE8V0uMxVbJ7lsnMSENIcIyPp4MsXhQjpug4XSUYPfWTqRzNQBUjOL0FnJ5BM+eP0VggqUEySbBfYLtKgjp5hzO5p9FIWi3VShXfn9iBKPHrXoMhIbuok7pZ1RDNOcR0YJPmurscEtMlMcXt0J27RsP3e+4eKkbVArgeY6REYGIHzuwHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV/70pglIClI+WWS32XYL5zD2ywvBpVyxovVe/GLPn4=;
 b=k5lszGhPf/48Y/1ZUK5IeebOukgDOr8jqBxi9VJ552O9rbAaDEjH6fz0QYD3qPRnx+YFiT6EszrrONRVj0cG7knGU8AxhhXDGv/UyZqiVHRI1xfq8+AcyUmjXtsUDXZDcmWM1BejOktuZoqqbdqeqPnZdcMS9axFs7Ha0JY02Xc0dEVEhK7icJICvZBqLgfJ9riXK6bbh9rVYJrYTqWaC/xnSSLdWmJVh4OICdvW9/7pIpDQGsUmbqsQhc2JPKD28ZJ4gOBWkI1JowUNWhnTky+upc+desOwphLIkUZ/px6WrtJDrSOonvFccSyjJrBH2Bu08Bj71dEMzfZPVNdI3A==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 13:55:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 13:55:31 +0000
Date: Thu, 13 May 2021 10:50:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210513135030.GF1002214@nvidia.com>
References: <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
 <20210505163902.GG1370958@nvidia.com> <YJzCC18cQDdKMR6p@yekko>
Content-Disposition: inline
In-Reply-To: <YJzCC18cQDdKMR6p@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:91::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 13:55:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhBjS-006pSb-8v; Thu, 13 May 2021 10:50:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa6023ab-bbcb-46d0-82e1-08d91616c5f8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145C72C5478588971C506ECC2519@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PJyC12G9KQY/y4Y8XoNObvFr9bHry/RIAyKKhQ49/sctbyhG+XY2UuoUfnynx5XpYuXt+BTeXLfODAR5vXaSN+YRierP+BW4Gxzh1/x8WqK1uHEKuLmKKMFQoO9Vx+hyndUtXR5K9OehRkgGsncupTgtxSPKzGHdqRDzwuCOxLaOlTshuIdxkoQZUH+x7emnK/LPN+c006seHVx9qYZ11mmQlLfQOhlIUn2upImPsduOAHoEPCFnEUT6uMfFGpZhvncsgxzjgy7g4jUHh1yjrnvo5TMPxyXVUeWGVm09CaIS7u0GAzKDizlA98F9Mzi2G6AR5eVZ/3tctMBjaauva34If4+0H4+2cRbxLI5iFdldIsPFn1PWNtb5dVKuaXAMydogiaKdVX5uXWGYISeTWl1vhlYrrwGyQKyY4QGrNYzohG7SQtnvhBcObz9EW5AWoAtberCf2X5kYI+vaJzxR5cVSHJ/Z4ujsJ6BN0UBbaPU+E8FZ8blbv/IRsbp+52I69g+BUccHznXDF7Irjz/bSFVf44hY09mFFDzUVHF7QLqBnx0B5QTHbI6pXSFTgUaZ+sE+QGh41vv4gvskPlAy/38BA7fGrqXV88n0Yyil8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(346002)(136003)(396003)(366004)(9746002)(8936002)(8676002)(7416002)(4326008)(2906002)(9786002)(186003)(5660300002)(2616005)(26005)(6916009)(316002)(426003)(54906003)(1076003)(33656002)(36756003)(86362001)(83380400001)(66556008)(38100700002)(66946007)(478600001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u07FZ44YOKpfvDy5eXmhvS+eEBaD3hzodMOELAvYOtVsnG8l8jB/z3tt4Ll8?=
 =?us-ascii?Q?ooRF2p/bRxVU/o1gJoDmpiu0HXj1+Ne2CEQr7tLlTKk3s4yhaSh3hiF3jcap?=
 =?us-ascii?Q?1Q7PMnycm2ra8p9i4tc1e1RZrVjZxQA7u1pw7VQO1yK/3ZDzGwfJBWLtwW28?=
 =?us-ascii?Q?FnOR603pJ8EmDIQ8OYXCcTU5S497MeZ2To4Dq/0GaQdyyQHbF6QahqFyAAtd?=
 =?us-ascii?Q?KUKOoCZrwdseFHDloH+xelN2Hzpaw3edoBKEnkYbPzPRU2UbjwCxVEPNeJhC?=
 =?us-ascii?Q?5HzQVXLXr0SZn1xSKAnzLsilsqII+trje5E3soi7VyITamqPZHpgr8THZe72?=
 =?us-ascii?Q?3rD3WZsYyjoc6JCUcjK8jp4xvdL677NdJzZH+a171B2Kif9zJHnKEc4F4HYc?=
 =?us-ascii?Q?MdWbbB+chAQUlRSmMoMBo9+PlDvIZBJwLzm50xpaoj+6cDjlpXSZtUvk/kgV?=
 =?us-ascii?Q?0G4KshjGG2UfDSCNvYHcpvlLkATzupdHC3C8jAYlio+tfbBmRMt67qHvH/Vr?=
 =?us-ascii?Q?7NCahsq55hiIvy2e7kt2KFTCUCMGpCeUPMTErieKo7+/hdeDP2wXGDMGy9vC?=
 =?us-ascii?Q?jw2QcoGJuK8e/eE7mg3o6T26QACsIdTGuo36KeYviNyXE1suFhwHY6ozow6o?=
 =?us-ascii?Q?B3Is5AFlDaZ4Va0/vBIrtB5AXzP1w3hyVGSogVbzTDMKagAjWVxMjGVm4y1W?=
 =?us-ascii?Q?QIEIcC5+Cx/vcJmoUc+OhBkfWU6OreIE2WwxHA5O22Mn12HEiSstS+I1bMeA?=
 =?us-ascii?Q?PXbJYDI0s+/6rkhkrq9UJ1ddhW602rAeoJqjyCy5/q5a/NgSvCgVxe+UkbCf?=
 =?us-ascii?Q?+LaUoGqLFhH4LCLbhWI/Zd+1k3qoGJyy5S+ta3nTVHkdu6u1w9VfkcP5wC1A?=
 =?us-ascii?Q?zeh77IgwQh48ey1MWkICaUJ8tDENVo+oM7FSiBZ9MJHTX69FwgnDB/8XzFwI?=
 =?us-ascii?Q?+oZRM8AwVnIaQnU4TFpaHOqNHnQOEr00ymGyhhVzLlRt+EtaNsIf5kcGW/60?=
 =?us-ascii?Q?U+sv4mOI/lqBeqg69xN9ikud32WnR6ON+7zmKkXzVXoWRfnVMWa2A5pLvqgt?=
 =?us-ascii?Q?n374PJ2m4uKx893OpKO1epZZEkHMmGIFUo3oVDYaRES6y+RD4vSY6SfwEgfQ?=
 =?us-ascii?Q?4OYWiwcRFuG6tVZjdvQRLApVz47xPT00R1JzdGy+AtNePrXOqOzGW4tVO4vg?=
 =?us-ascii?Q?+42b73y998wE/bJLTJo8oBfXt7lXon6ClQ4Xy6FikB2ZaUYIrQn/YeRxxJZj?=
 =?us-ascii?Q?JpqUprYXKeAURiH6GJ/WMS0GN6sTscfZy5+py0CHlsoqrjcguX+ng/t2Jl6a?=
 =?us-ascii?Q?ORkR/fn1X641dOCgCYa8v4FZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6023ab-bbcb-46d0-82e1-08d91616c5f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:55:31.8184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy6v1YUOWq6tIlqx2MXMO5neZoe6oNLWiaEI8iDxzDqC9QkyHZo9LOFc57dzOWy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Thu, May 13, 2021 at 04:07:07PM +1000, David Gibson wrote:
> On Wed, May 05, 2021 at 01:39:02PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:
> > 
> > > This is a good feature in general when let's say there is a linux supported
> > > device which has a proprietary device firmware update tool which only exists
> > > as an x86 binary and your hardware is not x86 - running qemu + vfio in full
> > > emulation would provide a way to run the tool to update a physical device.
> > 
> > That specific use case doesn't really need a vIOMMU though, does it?
> 
> Possibly not, but the mechanics needed to do vIOMMU on different host
> IOMMU aren't really different from what you need for a no-vIOMMU
> guest.  

For very simple vIOMMUs this might be true, but this new features of nesting
PASID, migration, etc, etc all make the vIOMMU complicated and
emuluating it completely alot harder.

Stuffing a vfio-pci into a guest and creating a physical map using a
single IOASID is comparably trivial.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
