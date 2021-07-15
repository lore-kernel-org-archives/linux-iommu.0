Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D12C636C8
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A98B61360
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A98B61360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B6FB8401C;
	Thu, 15 Jul 2021 17:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fH3FM-R8SNhD; Thu, 15 Jul 2021 17:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B1BF83ED3;
	Thu, 15 Jul 2021 17:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC36C001A;
	Thu, 15 Jul 2021 17:53:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB117C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAA8940363
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MIfh1WA1Syzw for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 17:53:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41DF140302
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ0EucaL9AkKe7pArIEQaBgCgOFABch7cPNFbJ/rvW4NGeY3oZpmWn1YS+179WUNLyF7idGy1hGfoxasANg/n6eMDvMPj/C2WLWhbT++syc5fsYXL2hHpyyUpIld61gvHqXFZtG+K4cGmDvYLFwwnP5FnrEGNe8sTZ26g/m5iuyZyA8+/TE75bpRcab7Jau6Jhs97B+1TMZ4CnNOlFi8MNTTU38niouT/8iyWd+XXQ8ZoQTmD1dY5tKbnXLCf5U6b6rD01wdgW5qsWKwFCguaIanDgmMzAKpkIQZdH/38oWCaL24h4G6TOYcgDMcgJFf+HTqgjcd8vhPW5tCBrd4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmV9zT6u80YCCP8B9PXO/s58ZFnj7eOfM7QMVbQRwfY=;
 b=L687BNyZpNSveQo6EabM/5iM2oqCeY1ZTdt+NRGcY1yqDFmqJUsFbTD4R2pi3LBqKvJ9AS+YaThgbxoiPgIsAOFpL+PE7dPfaJxBMpU/Kx7g1nwMpJD3bQ6w6l6Cuo/mzJoAUe4uuPQTi1Z8vPUuZ+NBwaBuuJlr3omMqYZKKwcqLEyyN/ZflkXUWtarxWGeKr2s/QQKjhG3EwKHRhjLZsq+LnRxjf9kOxIozitnk+AzzBQN/Khmhhn4svU+4q3utG5lKvAzUOd9CcYEKI/Z8Csvdi33vJ+o9evSEhO9SwNDwuVY+b7w4g6ELrU1vFQ5T7g6iAjurzd67BxiPLj6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmV9zT6u80YCCP8B9PXO/s58ZFnj7eOfM7QMVbQRwfY=;
 b=IGsT9ZJ7Yt3PVWdXVL2i38ubkoMi4ShXJ4X07E2WOC4NhD0c0Ywqkeytw4F9X0WoO2g4jGUDP8N7MvRAntgE3DF8TZQoQ6QZNKgDUrSCziT4NiyuEOrvmy+aRZj+LJeSTGlgpnLrTv+12uR2Eav/MhDIrjkkiCmckrPm5sn/xYpt0BUt4g5lBZ3X5TYM51RC4qaZ25NH1gjMnuqGxUnWaAG1yyVf8OfU6l+kTKbRp6Cw+oYX3XEoZZbJzM6e5BCdaZjCYkRDMVC0+1CWDGoV7fE40FFExCa5+9lFwz0B14M6ZE0Oe/cjypKD85u1bfcOuUAuRa0JLhW3YaCZNQRJYA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 17:53:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 17:53:38 +0000
Date: Thu, 15 Jul 2021 14:53:36 -0300
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210715175336.GH543781@nvidia.com>
References: <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
 <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com>
 <20210715174836.GB593686@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20210715174836.GB593686@otc-nc-03>
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 17:53:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1m45YG-002lUp-Tw; Thu, 15 Jul 2021 14:53:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dcd2400-e72c-4ee9-363f-08d947b979b8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080E230F438A553D9AB8FABC2129@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/8iNgriH7xmJY6JhKx6opdI3m2Re9+smQABBiuodUQA0LLa+SCAt+sxhJT82zWSUlfhHwo47fNkmMI/wbbDHaUixfXxWzjfxRgCURm7PBMQc11jiMWsGxzVKHlP3+f7qVSgwSWBSDmBjio2EGSpIOnjZNonBSFoShl6bXOmGQNOSGRL3xumTaigXIH8E46k+YjErXisxyxZF7R6Pg+aHWOT30OYUWQF3EHjUnZvNlU9q/JDc9oqsCfEjf41XFnnBzfkdsQCGHCS6s/ZHX/vYfaa0hyp+XA4bJXVkPJXfCoPSNfsUnD8oWLzwlYjaTVEVdUm1lOnUFxV61olLD7Q6G6qtJr1iGJf3gP8sLtubPAbFOy4z1JUJMXmZre4Q0q0MLfBQLX4VUgFTeE6TXeN7KORJRepe3P/MUEvK+RWBzdQ3qshP38k9zMeN44kZ1vZS0IF66yELju4Hn0eWXddlalyZP7fqVa/pTEkT38gibS7+ttu2OqcheAEW598P4LXGkVru9bxeYYhkSQK09iT9K+l0gU+cAr4O4wK+Fqz1YpLw0xAiByAWFxyeai6znX2uXniev1gVsnuV6M1nZ0HMdKsPSBMC+6C2/VU9i2u4p9PRCe+l5qLeNwqbMnZi9KXDCN530PwboXN/pi6ek6Ilvq1lkomITuXaXpo3OVOBDr5Jb92DeTeptT/QFSTK/jPH+pJkUINBUhZZ0pF+QZM1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(2906002)(316002)(54906003)(186003)(9786002)(38100700002)(9746002)(2616005)(36756003)(426003)(26005)(66946007)(86362001)(4744005)(478600001)(83380400001)(33656002)(4326008)(6916009)(66556008)(8676002)(8936002)(66476007)(7416002)(5660300002)(1076003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9yrwgJAoiR0veLWutXCMdTCKxShh5bT5TuFFH7FUKaAnTBWMRwjgLUzcddMu?=
 =?us-ascii?Q?8+rpbrL9KCIVoJN+p9vORE3oOgwWEzgvlq47jiAetB9fZrEE0gTggQ2bbg3f?=
 =?us-ascii?Q?4HvDQAgJXQ4ic6CTtp+eV+o7A1qmvZJwBpuadgKcZ7FDmDkPVrzDof+iZLmw?=
 =?us-ascii?Q?q2CzX2cMmj91G3w5BiRDiapWzeaARo//zU6vAOwdE1ckXPATFOwJXVRgBeYr?=
 =?us-ascii?Q?BjeFirzZeha6bl7YPaImKCHOgv1JwQa8YTGxJ7pGrJ4DKGUYSo+ThLRV4X8T?=
 =?us-ascii?Q?UNskj/FSQoNhogOkuRqCYpV0+m8favBs/DtKXMl3x4tEXJX2gJaOaKB7ejK+?=
 =?us-ascii?Q?OZB1WVSn4fmiG0EBL/RQBCyJxQpSuvhaqGj2VCfj6A4UWK7fyKhUrmb6IFZS?=
 =?us-ascii?Q?tuzLMDVpTNus2IO+TeOXGwpzxF7BqfijUL7bpoN0l9H7YmPdd4qE5iQmgAIX?=
 =?us-ascii?Q?zr4KzkmmFN58apnzE2IT8Si+xFGym7vGkuV9rwWxMXziSStUA4T6G5URiF4f?=
 =?us-ascii?Q?JqFvweCRJUwlhWMNwKVvF7eLZyRZbZ2XhtCToKuOvg9oVs4hlrZ4QQik82Se?=
 =?us-ascii?Q?cLa3eHIF2C5bmoqHOp7RsIGGJAo9uvdIZlYMZKDV7rm1WIjBd92U8BYhXN4j?=
 =?us-ascii?Q?wNZi4rwq57UTHhXwG5N+oDM0kwqc+nRir694d9/HyCAee67gQfitr1vrGKYp?=
 =?us-ascii?Q?cRKjCX0ji1Nm+VaAlpj5jtyr2p79kbkX5oCLDkdICr7JclnjqKosG87GoNf6?=
 =?us-ascii?Q?pBUDD4SnkRktTerzFKwLjvslXW798zMlXGGAZMFVrF1yxGb158dkIh6J9yRS?=
 =?us-ascii?Q?u9fPUcJ36b1TzjiifsM3tsayqVxwExenlvDaGoGJYDuW82UlZC6wIgv2l5YY?=
 =?us-ascii?Q?uRLOji5yE4Xpj2XU1nw1GpdL1WdLyQp/YvkoxE9xpcgEKR+3vhVeEycPMTFs?=
 =?us-ascii?Q?s1EnHsfpEyhvRKFSlDe4aZQKMsMq8Mz7jx5LVSXEELTeF9okxbR9J78ukkM0?=
 =?us-ascii?Q?HZQZbAy8WeXE5ymqH36zE2I4tOnlrvCUlzx4kSkMdUYGNCwNC2ftzQA+0HMW?=
 =?us-ascii?Q?EsU/skM6JOC3MCevCci7lhBwEfPutcxa5vj9lAMlSNTLx1VQ0C/NgopiCkTp?=
 =?us-ascii?Q?15f1nZfbvwPzV54PpuoVQKhs0IhVsYKQoUj3hY9YmAK07rR4VoT+76gZZfnc?=
 =?us-ascii?Q?7KlpSRE6bSa/MexnshpUAeSULd9yztl0wbcUDI5AwNQqkV+J5aoCClgKAs+Y?=
 =?us-ascii?Q?76cbU5of+gTFPxW9ozBx7adIl9qYj7cDteZyZ26ZjC0CkgVMvEq6ekrm9j9a?=
 =?us-ascii?Q?CIwqnOQEgmqecgXotYv6YgTR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcd2400-e72c-4ee9-363f-08d947b979b8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:53:38.7866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxvgb5EmDQz54joG/1Z/lnmbQSb9tpsylbtZ4hedWnHcJTcjFNg0dfn2Ldd0rjdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Jul 15, 2021 at 10:48:36AM -0700, Raj, Ashok wrote:

> > > Do we have any isolation requirements here? its the same process. So if the
> > > page-request it sent to guest and even if you report it for mdev1, after
> > > the PRQ is resolved by guest, the request from mdev2 from the same guest
> > > should simply work?
> > 
> > I think we already talked about this and said it should not be done.
> 
> I get the should not be done, I'm wondering where should that be
> implemented?

The iommu layer cannot have ambiguity. Every RID or RID,PASID slot
must have only one device attached to it. Attempting to connect two
devices to the same slot fails on the iommu layer.

So the 2nd mdev will fail during IOASID binding when it tries to bind
to the same PASID that the first mdev is already bound to.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
