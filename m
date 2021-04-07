Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE2C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 11:34:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981886138B
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 11:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981886138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33A83405D0;
	Wed,  7 Apr 2021 11:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gVD_DHANU1T; Wed,  7 Apr 2021 11:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FD07405D5;
	Wed,  7 Apr 2021 11:34:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3267C000C;
	Wed,  7 Apr 2021 11:34:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4405EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F184405DA
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPhK826GaAQP for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 11:34:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::624])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8127405D5
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 11:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSnkXUtSoqUMazR92SPaQNtqS4sLgJHKmVlXpvDxLrsGm5IBZMF9KA+EH23+d5WkYKMO6mMUno+LXvFArni8tp4OfZlxqJYie980JQesEiM23TdG8xY8GL6Xw4DrxBZRy/XdST2B4txbf31j2+gpsOAadIG2KAIIoUt6iYXgM8TNZwlC/JbFGsm5WI5tz0bZagnArzVWbwO/rB3qG9gu4Ge4JLbmbC4gbLlNCymq44xtT1jD4quFvLjFmW1pM3qW6FK1V5Mmae3h6LFmRM6iyhu7kT+Mt/1gQH4iTTuq+Erqdzyf6NXcNB7N+EQEBebjbVslJekYndNkZPcINsFlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTE/I1FoqNFwGgf2GMebSWF7jMj8jQ/k763okdShQGM=;
 b=iPk2J6hkEHATyBs7lqMiB4StlcGcj+x/6QtVEcajOZMqFW/LUGJYOZ6iAQNS0JeDgubFfhU5tcljqtwd+LVyJ258wts5KT7poTrZgX40013FRiy5aO/pIzdhWVUEw5Nls5uvuZnU++T29lTMKEZ39OCXnuuJ5tuKmnWcqjCcl5HhlNyo4BhY40gdkbfuOhb55+69MrJYgmdClubXDuFkDQKMuFuhceoLiaZohu8IrLWXxiVyXBbbtgaubBbhEj91wM2XkZn5437q10qkfyTmWlrc/CFPdP5xiiJSci1UMxAN7BEMJ/7aaL8zAfKfC2pkc5VkpjeIeVc+xSOY189PlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTE/I1FoqNFwGgf2GMebSWF7jMj8jQ/k763okdShQGM=;
 b=di0RshBPmjpMbgTNJyxCe44dW4GNvm0SAYmWXWnP1x0PqNn381wdbwL9BRQiMaG2FlF1FKEgg1HmcR3oG6kUt8sUBtj9o53ktYaZF6UtvVKAnK+zuBW/7eCe/KG5PAPJWQ4vn6cfUS6/M1zfBholghpl8Bq8u3GfjxWkbuAxem/xFCJzVdBMlpsvHi6YvU9KGdaKf9A+brN/5nj3ZvrN+hNx2HMgXMV+B2r7XO/1dl+0ew9c+lRqU6P3BiqcCygS3eWQRNH5LI5vFo+s3zRXK0xX7jOyLpYjaEyG56goJnFFYyI0DF+q7xxUkq9LQ4ufiDk3HjEVl28s3tv/cFvX+g==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 11:34:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 11:34:38 +0000
Date: Wed, 7 Apr 2021 08:34:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
Message-ID: <20210407113436.GD7405@nvidia.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-8-baolu.lu@linux.intel.com>
 <20210406200030.GA425310@nvidia.com>
 <1cbe97fb-5595-8cf5-9e0c-1a2edf8c5d9a@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <1cbe97fb-5595-8cf5-9e0c-1a2edf8c5d9a@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 11:34:37 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lU6SC-001zjj-8v; Wed, 07 Apr 2021 08:34:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817c05ba-8fe0-43c8-00f4-08d8f9b92026
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1339D4A85AC920E9579B1052C2759@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CrrcKOkFD7TewxUs9YE9kMREI+olBm04yYyGxL1lhBZYJcIh1aPzRkVKDC3RNNExCVvI7UdMHCoQNC5FVjY6MZwYmknQtFRj7rgM/WklBkHIlqUeVgMPdsF8/g4FG1BU2EZ99RQaQPj4ch+pPBp/7R4oOyIBgkFLWP/AVOCU5hCPthJreJDWS7u+n5YhWBZOS61rsPNp17+Y8Tr+BkKjDv1SjIUshtGpsV+MlpbcW2g9/2J6anVVlBuRBJtN5RnSVXIotttxOWeRPLuOh+zB/OtvuuHxFK/iozdEQ665NZNYrt2uBooH8NQjfigQ7lKjVMFgvkLAT3OvLSO4XdMPn788VOCeIYVLKsfta4znYkDSPXM06IAGh8fK8UF67WDdRn1N6UBUKkyFy5Mu2gbsNwsaRB5JnYTRpeT6A71zd3Rb+0Efm73JdvYXDSVdhnuPS+JOBPBidJpDqkVArE0fO8gQbfdC2026P8puYzfnGRwIcX4kT/0w0jfGJ9bV10zyQXvh64XF9+9Mpy9kpQokWWx9GBPDmPNU3kf8skIs4qMorUM7RnqLBbSfgjf16YQ21pTq7KmKPz278BLeomiRoPgP5yfAyTnJPqqXyK37sKFD4+7aqw77MjKQ3i04X76qmy3kpn4co84SGd/qrNwBctrBPOON3CAWNYHvs1yBSGaXjVIuquxJKqoUwlSkeP7KEYyx56Q3SCeRwGAOk//zGekj7LiNEduTqA581rgofW3i6kdiCoVqFxF+ZskNA18
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(33656002)(426003)(2616005)(7416002)(86362001)(2906002)(66946007)(8936002)(38100700001)(966005)(66476007)(26005)(186003)(66556008)(9786002)(8676002)(5660300002)(1076003)(54906003)(478600001)(4744005)(6916009)(316002)(9746002)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+kY+NIFRyas285mA+wO2KmJcEZ7yGWL4+pYKi39x5g+GLAC2zlgG0IzO7c1p?=
 =?us-ascii?Q?CjUHDjxnZywWaMuJuM8KvUWW9ESo6ZhV3fqoXsCEqWkVsFUWy6mplysnJUJq?=
 =?us-ascii?Q?EcVAEn+Xi09YkVzWRzMVZQ7lgTb4F2B/HUR1CJkrzxL+T+Sm5LdS1JXJcBaU?=
 =?us-ascii?Q?5JMStS9BfPIzxYXWAIkN8bYw6VOBe3IYy//GwhktZQcw5G7tcoM7/VX1pAlb?=
 =?us-ascii?Q?0mPld9OXd2AF8FpOVulm1FgMw90EjeWButtpZaqMIrSUDAOWxcAmor3GViAu?=
 =?us-ascii?Q?KwuXJAP8nCkhKIy09fO5KN4qeackrnblDQBapDrMItqUVcM6W0P3rfsarBF1?=
 =?us-ascii?Q?nQ5nHhMZ/cwFJdkMCQEraOmBjDwHVYwkBa+ZF3ZLd3aZaKj/bAYETTfhkOE8?=
 =?us-ascii?Q?j1e71Kem6Yu9VirP6b9bQChVzmDbQhYiw79Pd/0dZey1f0nRCUtnNiMXbNZk?=
 =?us-ascii?Q?yG773pZSrOB4CbPofADB2FjGQuQChdwg2uaCyiTg4LZQrPJYz02AwPI3NXkX?=
 =?us-ascii?Q?1VqnnnqjgYcgD+fLOMoUpu1cdHfGdZk7MKXlyWfy76u+1+G65xj7vWdMhpyo?=
 =?us-ascii?Q?+Y7/LFv8gqkMV/txeEt0BSrAahakReFmG3Gx+tP/rP3HJfZ8/S2EIEOG9WAv?=
 =?us-ascii?Q?3eFDqFNZkLCDIo4QwTFfxpjkWOxJQfbv47BrFSgRzq7xbrZsHTNKEXh6tHYH?=
 =?us-ascii?Q?JGZMP6D++HlVbLXlU2M80ZMa4m9UaUZhAKr6ut0Qw1yKFACvvkS+RWLOp0ha?=
 =?us-ascii?Q?tsmt6fAtRpOf3ZzrKaTiFceAyyLHRSIus9w5QMLRzOwwOU8j+6UJq5X8jnUN?=
 =?us-ascii?Q?7FpczQN7X3RO0RMiyu1aLJ2KRtQbn4bs1ymgti2AvtGWAbV8VTORkc3GMb9/?=
 =?us-ascii?Q?Ed71chD3y97DQy/PUIKwGzWJF8uO+StuwaFpQ4RjIJpHvLBv+CRpwhD8RmrJ?=
 =?us-ascii?Q?S21pKNFft4yIzFtgcnLFig7VOfsZypjFnQGPX/8ILVulpkiapfa1prDuCSni?=
 =?us-ascii?Q?koFXWNO9OUMyn6qO3ARKeZh5xdm8qH50ghqmXUCGJvj3ZngYvf2UchZmc7J9?=
 =?us-ascii?Q?vvQNBXSABCb9mtenDgoWuzKOgynEckx8xsfjw9VLvZwf+nQHOfvvj7Cw6B5+?=
 =?us-ascii?Q?qBy+edC21vL+fQ0DH7TDBOpbB5/VVqpswAH9cNCdvsytd6KO3D8+vl2GAZEW?=
 =?us-ascii?Q?ac4abPniQ+gZtAoYGesJx7DC9Qr2lqZnfIqa2mYerD5YpW1xUuoj3bersRKO?=
 =?us-ascii?Q?B2B7mFapgOsCOrzaMkB6m0lWiO7VpTzjr8llsnCdj0DLsD0b+WEmB4gW6AWa?=
 =?us-ascii?Q?K3bcRSDQhMeh4XkMnck6n0xW8CO1ycvWEFkDP8vyAdQdgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817c05ba-8fe0-43c8-00f4-08d8f9b92026
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 11:34:37.9690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRmIyPBbLyHWEW4YLbgUhxDs3jpN0KS+vjIjb3Bv50vjNllQqvpPdBg6SJF33NE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
Cc: yi.y.sun@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 tiwei.bie@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 sanjay.k.kumar@intel.com, Kirti Wankhede <kwankhede@nvidia.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, kvm@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Wed, Apr 07, 2021 at 09:58:05AM +0800, Lu Baolu wrote:

> I've ever tried to implement a bus iommu_ops for mdev devices.
> 
> https://lore.kernel.org/lkml/20201030045809.957927-1-baolu.lu@linux.intel.com/
> 
> Any comments?

You still have the symbol_get, so something continues to be wrong with
that series:

+	mdev_bus = symbol_get(mdev_bus_type);
+	if (mdev_bus) {
+		if (bus == mdev_bus && !iommu_present(bus)) {
+			symbol_put(mdev_bus_type);

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
