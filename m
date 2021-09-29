Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07254C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A415B613D1
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A415B613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A2E380EB5;
	Wed, 29 Sep 2021 12:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQGlJ_-7FfGr; Wed, 29 Sep 2021 12:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63B0C827DD;
	Wed, 29 Sep 2021 12:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38BB5C000F;
	Wed, 29 Sep 2021 12:25:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F3FBC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 152F1827DD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4tLPbRYuuriV for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:25:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4671A80EB5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOwD82EZzrTa8cqCgK/b5n1X/TDx6eW9/PRLPM/VWS0kNPzdn0WrUJ/TMQzE7VmgtCO8XG42YRg47kE9TDZ85Vr67e+p4b46W8Utz76Dj+nuyVcyJIphniu0IKsYSialB94WWUcEL1EiQKwGyN0B/+kuNa5owLSZ+dAdEEjuQLUbCz0ezB/S/R8KO+QEt7BS2LgZcnTFPuFrYflkJIVGl4jxo8GpZzG8FpJZgmmk/8Ml27bLgtaHZ75hEL9AGJBpY/EMj68pC0YtouGy9rnNVR7pq5y2nv4ctKaBkjf6w6t99+LM8D5O/hbp+yWNIe7qowv5GoP0UjvTqIM1m/L4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nXDfGQqIiEj2qC1+vwZ87u54zSwVmJ7sE6ErZEHzx/k=;
 b=MywE1WhMc4KiI+hpMQ839TpmzRbE69kN8nchTvbL3blKsCn+c+lW1ks1tt9zZtQoymUvmESOA/KEwiUeeXkka2JLJ7X4HMv5orAj2cn5e9mUXY4pJh0dJb6GVFiEoe32NVJqr9XyKNSNpxGQWr823PoFQdLiiqm6poTVZwb89tHPkXjuc7EGp/ibdHcwg9RnRKvi6q3XlAuJOlA7/mUWCMAotEiIfE8J90ksE67DGD2Z1242om1Bx4rkmpiQ0rpXi//FaNJXVtnEQsphrhwuPmfJbtKwvDCKIAC/NO3QC7Tqkm6ys9xYeYeoduAtZajrRktYddtNg3LK7glTdw2qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXDfGQqIiEj2qC1+vwZ87u54zSwVmJ7sE6ErZEHzx/k=;
 b=WLuy2+QXx1jgjKLVen0P5nlM4BWVHWq2ObvDgH3CIW1fFQCjNtvE+cd8hnBXGl12TpQraJSfoEHlplj4JPepW1uwfD6uZt4w/0lhY3hpmah/EnD5FcwadwXoBqd5SL0vc1MfpOPiNDftj5seSU8ZE0AwthvTBdZJ8xVN82VOURPDKgaxpKwZnPMMjmz+qC6hAqpr0eoCOHAocJFtaEusOUn0+BV7ESXxsJAhMeponxb4e3FERZ6Leb1FpvlK5+jzIojGx/BmtsURgfPVAbqfOWE3Juo6MUj/vrV04ELn058mAKb7G2jUiSrKJu39rvoT9Qcwf4fi0JpR2WKbVweHPA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 12:24:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 12:24:59 +0000
Date: Wed, 29 Sep 2021 09:24:57 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 07/20] iommu/iommufd: Add iommufd_[un]bind_device()
Message-ID: <20210929122457.GP964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-8-yi.l.liu@intel.com>
 <YVP44v4FVYJBSEEF@yekko>
Content-Disposition: inline
In-Reply-To: <YVP44v4FVYJBSEEF@yekko>
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Wed, 29 Sep 2021 12:24:58 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mVYdt-007YeH-R0; Wed, 29 Sep 2021 09:24:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2df6b05c-d311-4356-624d-08d983442723
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173145AD51EFB7B7ECB6D66C2A99@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtWmU6ATRPc60bTSU9qej6ZtzASyQTtW5Gb8CK82Oa1ZZ/yCKQYupgZw/Lv/U6+S9nRUeztnD5aWecIFKBurfhn1Xya+oiflPQCJLn5cYY33VBzOClU/OOP8hW85cMtucHEZuP2Is+fsEMbmxXPDSl/LgddIxWcQCdFcpRJtEMZ1HYg//tYgXdrq676cwR7FVkEhF8W04kO07rGGRWqTD8HloVB3HtDCSoekInHN+XxbqCHgQA5eEpK9O2ZD4MDW4K4ngi/47KbKrdgVQ4AO6JSajfZpSOdp6QcK+fhQawSevBSrC7sbre8nrXMJbj+mxUXnKYcPrDnbIeInb99Jf2zSaabEw8xy/BnU0UPIDOD5wsGE+tSOJreiiljTIMNgmnqDYfjB3OViamysJmPf+MnM0o4hgKYtvCn+UEa3EMMWZmHCr6xSTFILtlhj3A5vx/BQ2rGLD4mUcu9d+wxl0Eiwi6tOZwiirWB46UW0Z9cG2sQoMBnPWFxW5OM/xPTf79Du/sOA/dokSn1rDzCMvgPpbM4fkY6SBiQtNwAThOnqGeBP6Jh8h2OGhji30fyTcKsGqeIS3vZl+1HtI24Jyt25AreNhUHkFJt6xQojWJUiTm7PBMOAG8ERkRcTqNFwo+uQZlc6/Dl4jdXC7zr+3x8NtM6qtsnPkPLiH3N8O2E2rXo2zOZhZUXAYSEbfx9J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(1076003)(4326008)(426003)(2616005)(107886003)(316002)(86362001)(8936002)(8676002)(33656002)(2906002)(5660300002)(9746002)(9786002)(66476007)(66556008)(508600001)(36756003)(38100700002)(26005)(6916009)(4744005)(66946007)(7416002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E99KevviliFa87KkooUT6xWlCuukgD0tc6uNjcCuOkcrDDhE6Sbn47o5KTxw?=
 =?us-ascii?Q?mtWI5ObcNrxaHtVSXwymvYUgkymnjr44BtVQcKukPF7ywbiMbZMYyVokwpOG?=
 =?us-ascii?Q?HshN4j26WudqvuqNWJBQyFJzyPtYW8+blPhoZuRfzhTXTcLJleu9zYdO4jvL?=
 =?us-ascii?Q?BOw8XxFmOseWfXgo7PM2rfFfIbLYyHZ3jO79BGx1vwPNyvyj+oWtRE2JTdZQ?=
 =?us-ascii?Q?y3mScEVitJW3EWctNV99wHJXWyFydh/M0r4vZnd4QyPq7R5vxgPw8+sfKvrQ?=
 =?us-ascii?Q?oQLeXNcEo2uCv3tw5ANqdEh0CyRmHLvp7j0NLt22LHizTb3FHskd9RmsnKYo?=
 =?us-ascii?Q?w+4pPRrd+V3MTDfKw1nA6VxCmjJ2WttDbqezhxtOHUcGiuXc8863BTmpiAtw?=
 =?us-ascii?Q?qwqZ6SqlwKU7a40AgwqjkNvuKdB+GRZ67MfOEpfb2mV1hX+U99DjwXKKbpLq?=
 =?us-ascii?Q?GbkVo6T2CZiTK2Cws8B9UzM8IfeKz28oouNjjhRi1ZE58KUOUnhu5eKSXFgy?=
 =?us-ascii?Q?p6Zg7tqNkDUrKJuDFum3qSiGDMwL1LooGMR1wM++83QejIsrJsMfxp6GUQqv?=
 =?us-ascii?Q?0VKw23/EoesSGD3NubejFFmq3bQ2w6pralzmhFrifYWYwZFjyjgP5COgq78z?=
 =?us-ascii?Q?E6PnCJoXPvypOUyRZvzl+tkPlhFxq71fRujknIxo/xcHakm8nReQJhYZhy+g?=
 =?us-ascii?Q?pVHEpkcT8zwIvhsB6k4ejaUe2k3h1nFKhg86R2JCqhr2I7c3sZH5Z9mRPvu9?=
 =?us-ascii?Q?ddVtftNFx2uF6LmcNQYarcZx6rSgj9nr28xzYZDW+aaZwlVi1taGN4jCsDdq?=
 =?us-ascii?Q?ktj9nvsdcS8tnVt5fK+Ixo1fxBfMKucmcSNbWyW+WRWyaAodFE7zjCgA4HX4?=
 =?us-ascii?Q?Ch0SBtwVt/7F9a6w2qoC/vgRsicZUZY4WQtujaZ5l1RU0DeUe3EyIm8+29rZ?=
 =?us-ascii?Q?D/E88DiUPPERerkBK0SDm06FvNg1YaXrr1i/F2V9w6CS3UbjXBLo67+m7w1I?=
 =?us-ascii?Q?bbhBQb3Ve6V4PepbBP6e6cQgIbHtnpOyNsHlJVELbxmY/ENq7TpdACc8Daob?=
 =?us-ascii?Q?uflFH8ydsmEsIidVTgOlratwwbyAe/SdbPv8kmw5A3xvM3gwfwHJRtHsdO8g?=
 =?us-ascii?Q?1UfIiBeH1UNJ+2ysqp1gd/GbjjMfgt8tF3Z5REpCKUbsGgQfY9rOUYWkMVcZ?=
 =?us-ascii?Q?HWBppcvdrfQWwi/1LVjbTMjXZIc8ObJ7Zn7ecqaawzbaVSCZ6g3oTzz6LrB4?=
 =?us-ascii?Q?aEPEXkkk1+l1pbcnrgGhsMcHjACA9T/+fEG4JsoAQ/4UYKp2fZmManGwiCSY?=
 =?us-ascii?Q?hLxBNJY19IXVJEQbT8hTifoc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df6b05c-d311-4356-624d-08d983442723
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:24:58.9361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n4uLlGVMQp5IYCqPOLQvTgOJzgktscN2S9xdWmBzV3djxge1cvRcIcH63CjhXSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 29, 2021 at 03:25:54PM +1000, David Gibson wrote:

> > +struct iommufd_device {
> > +	unsigned int id;
> > +	struct iommufd_ctx *ictx;
> > +	struct device *dev; /* always be the physical device */
> > +	u64 dev_cookie;
> 
> Why do you need both an 'id' and a 'dev_cookie'?  Since they're both
> unique, couldn't you just use the cookie directly as the index into
> the xarray?

ID is the kernel value in the xarray - xarray is much more efficient &
safe with small kernel controlled values.

dev_cookie is a user assigned value that may not be unique. It's
purpose is to allow userspace to receive and event and go back to its
structure. Most likely userspace will store a pointer here, but it is
also possible userspace could not use it.

It is a pretty normal pattern

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
