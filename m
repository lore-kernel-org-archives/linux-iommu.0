Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4140C433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:27:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A97C619C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A97C619C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 104F683E2B;
	Tue, 30 Mar 2021 13:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tovshblI5JvL; Tue, 30 Mar 2021 13:27:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E37B483D59;
	Tue, 30 Mar 2021 13:27:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9CAEC000C;
	Tue, 30 Mar 2021 13:27:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4D63C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 948CE4018E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iLhHXrMNiBNu for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:27:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B33240198
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJg5xAzeuYYxlb2IRkg90p3D9fSiG70Xm/lgCG4qGDS3MrMn6rh5sYppzolCb0Aw6+Lz6CtCYZIVFrYPRDLLmWmZXmSS279XW4ElurOfqCBUkOadSJt1vg3/tzMVQOdzM1rAVjvj5bZfzH0Tz9fjs1mWBPKxWzcbomyE5rfW3fYrXzm06L0rD/i/b/1GIxr+B1iJj+BekJ570ZUSMO+PbF8+iW9gjO2oBNXljWw8qViJ9SgHrD6vDwMqUggpCwRqj7274w/0NAhh9RUwbL3xFYMxtfhYCDQgBYKryKnYswADfUJEY/WE46FHoayCzH2I9NCz+jwOpPQnlyVFt02RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3G3sNaaTIF2ndmBFRetfRxBN8uTPCUmhpxZ/4yg7i4=;
 b=ZU888tTx+wdoakwO9wbSCr/eEcQUMxRwMUQWrsFDXE38d7ZDDnldMZh17O3iUHOnS6Mq1xQMBaQV9CpAfCTtuxHQgKlKQebRAw3lQux+tftsgjSyQAJzpOBV2dtBt8SpgdIdnyjl/38HziXYvkp8r4mTCrxYZpyLvGOwwds34u7HwsjHDREk0JEjG2sx0VmcCLpCvDm/YgzZ7pegq0R8pWF0o1ZRuLgcbA82HkhLCdzWkKCGKE2L1Yx6ig1k6Hffo83vuv2TGZKjjtxvMB1gRR9o3LrOWATOwx1epvpxSE8vBHiRbAq+lx1/Gdibpgeys0ZampKHuxJt5L9ecfrkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3G3sNaaTIF2ndmBFRetfRxBN8uTPCUmhpxZ/4yg7i4=;
 b=pyMitOg3Z6nVWFWVyCR0255dWUjhs18J7sxQLh9VxXOZO7rh+RpDJfQ+PkYTlUWA5kKviheCLbV37rL1t0DzM5lDzc5zJjqGoGeXdtnA6ESMCM6YynPJl6HQtFV2XLz35u65GnUWjLknhOnBOborDPUl/u3SL9/Bl61XLLTXNFOqXpxpJYZJnRz88IsznVT4rCNUUBR2gx9aVCplwpWtxcA7/HIssi+J1UYJbjMdXGvGhZaPVow3TlQuC3ipE0HtA00HIqyWJGdRe4118auD9PuAsAyYfQqIqwKjHmhXaN/Ejpu86ZaSgxDDz+X+6aK58GjAW66ogIRKw0lqXjznmQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 13:27:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:27:43 +0000
Date: Tue, 30 Mar 2021 10:27:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210330132740.GB1403691@nvidia.com>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 13:27:42 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lREPE-005tLG-Ql; Tue, 30 Mar 2021 10:27:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f7c937-3694-4258-d44e-08d8f37f98e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4012A90FD628AFE910699053C27D9@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V441TSv/TSgaKofORGieuKHhZzTccRJkOnRXZAuImnvGA1t5nWZJp+xFSGIYTBXXDyZ6UUgBOk0vNgst63mmtxXA6Q1PW8Of/EGC5C83A3xxAtF/4JcthSBOZHgAy3Z2SWQfhb40cmkghoBiqi5qqjrOw5V4x8yUFXgCztjIIX+EREUECYf3n/guet1XRDEjcX2ZgnlpIUQRlidtpJ+gmLrpD6ar7qu8V92XW4Tx7tSC5NDkblG/T7TohffnK6SeHN7UXp8zikNmbRh9+12CFi41Jnj//n0c0S+6kbqkYue0WedrFk9InRKGlFSYbaoYSNBnGOeQo5N6w3h1qV8OiHkEKWw2JxaXR9FDpffcc5WIJQYeRlV34mdxFi8c15FuUsNGNG9hM8Aqozhn43q0yTFYrGu5vAG1JsLZezpEVRMb3mcpmGOYLWv15BH9OUUzINRnwHPyyoY1BK3jt5KwNX2Y67E/VZIllunViJav7AOE4gq6xZ2o5LwICh57iejalkbLff8AB/LNqvM57BBivvTlYJ2ztMqIOEO5QeCE2FD22zWzctBraErdP6U0Nc6izxiqKQtA+VadP7cX3hwT5W/sLa5WFjhqvDytwTlma1KrMCjpQ7UiioL2XPkFGUVFs8wso02XYoG/jVdpgTLMic9lzc1E4YKF2rUPa8o/jqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(186003)(2616005)(7416002)(26005)(83380400001)(66476007)(66946007)(66556008)(8936002)(6916009)(2906002)(1076003)(8676002)(478600001)(54906003)(86362001)(5660300002)(33656002)(4326008)(9786002)(426003)(9746002)(36756003)(38100700001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ezf0b8UrLv5AJkREiWWnwnZexIrhILe2qVIr59N0675uLxcJ3+MAMJj5AWNy?=
 =?us-ascii?Q?21MXxqT3mIMJy/DevsbwfoXR2CSXR0hat4uG3Tj3wfWQIc+Yabzs5tbfnsRo?=
 =?us-ascii?Q?o7jH5eKo+wj2TX4409GnEBvqX6o+FkWS5s07IVQD5S/HYO/3JciVxXedGvK6?=
 =?us-ascii?Q?2UPoJHu6GZ6LkIeaehWZhHHKiYg65ewYPIi1N4zvIl67AnivIH0HPcMGywU6?=
 =?us-ascii?Q?sFbWcH1t1NWz+oUlhUJrg/jS1UeFuAEsSDNnYJzRGCSz5Eq2rpz1F/kYocl/?=
 =?us-ascii?Q?ZG7EcHN7IOBFSi/r1CVUX9MjWxaDV/I1CJ8tkoD265j/+zeZmP5YFJMk9Al7?=
 =?us-ascii?Q?TidmrVUwrqjbjocIfeBz/V4yEBQpfRTpmDmgNtSNHuRamqXIHQpYtQZop0sk?=
 =?us-ascii?Q?ivV52DfZ0MHM5WsoHBo3zeoFAdU8hS0RP1aqgrGwAkZjxELRbNOCJhr5Wfih?=
 =?us-ascii?Q?AdT6EV1DTbijNq3JcEkM4wq2gd1HZQzZdbb0WyntwZpQrwM/eH8j+3AdsWPM?=
 =?us-ascii?Q?40tjfvCDxCfA5KL5dqGeiaIn6V8XUTx8C4F+gB8N18BW/Szbwc6m5ATlQjut?=
 =?us-ascii?Q?MwD6TEf9Wy6rSCYgYMtTnzlbvW0fUarh252Inkw3i2IHtccvwz+5KpS9LNMB?=
 =?us-ascii?Q?52cVGIuISSbl/32qaDjM1ShJOC0gHD4EcICi1qDYwV8DsXgKj7yN8VG3SF8f?=
 =?us-ascii?Q?3LP1+7PKAYAmhSgHLc4mh/FFRUr9VcrrLZNPsp1ciVKK2SgYOuYO23oGR0sQ?=
 =?us-ascii?Q?aOZuhNx1dWqSyRPZALSf7gZ0K45qwQxcZlTaWS2MRrifuZpNTstrQpRyWMH1?=
 =?us-ascii?Q?q0/RX/W1/6mHQH7TrYWrFOeEbytVZdnv2yzH3nMek9oGmAfKJAWAUxnzPbeR?=
 =?us-ascii?Q?1FCd7zp8u88RFLTabdThHl8zTMX06p5h+m6CFqC40NH0IutZM/luJzBMNcyd?=
 =?us-ascii?Q?NpFKh1gQWH5+ILdAEtN/719oavk1I2oEBAzq+bY70/3a+yiP/ohSF3gzYo18?=
 =?us-ascii?Q?EGT1kaTor8Du8xhBKSmolwVkoHk05FiE312Szd44chFdpkRqlJn2Y4VXpjlR?=
 =?us-ascii?Q?H7r6Cfwt9MUet/bXSkmVncH6Z7pDtSGXQ69OPbNNxbwN1pibJvO1+DNOc/vd?=
 =?us-ascii?Q?1NmulpUyrObUChsFgtRteEqF2hSU9YdaOZHAIeFF26bZUulIi7qOgtDMuFDr?=
 =?us-ascii?Q?rXP+cGRRbv/FC7zZv2u+hPCnIWIrj2IVP9ILlCAHTVeV3C42DFUIbQnPhZ6C?=
 =?us-ascii?Q?pscWY4E/zWGD2030qLVBsWgcX+yfC2CRjOKeXGHo9j3fVIVjN7wpyfkbhoiE?=
 =?us-ascii?Q?62CKGvjjMzC33dIcfRrUnzkF1lxMhxSGEk2NdIQ2kjwftA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7c937-3694-4258-d44e-08d8f37f98e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:27:43.0898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQTXv8fBLqXslxLV+hS+dzjgEqM6rNUwg1+FO7357ldD8VsmfdWTHkePZt0F6iKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Tue, Mar 30, 2021 at 04:14:58AM +0000, Tian, Kevin wrote:

> One correction. The mdev should still construct the list of allowed PASID's as
> you said (by listening to IOASID_BIND/UNBIND event), in addition to the ioasid 
> set maintained per VM (updated when a PASID is allocated/freed). The per-VM
> set is required for inter-VM isolation (verified when a pgtable is bound to the 
> mdev/PASID), while the mdev's own list is necessary for intra-VM isolation when 
> multiple mdevs are assigned to the same VM (verified before loading a PASID 
> to the mdev). This series just handles the general part i.e. per-VM ioasid set and 
> leaves the mdev's own list to be managed by specific mdev driver which listens
> to various IOASID events).

This is better, but I don't understand why we need such a convoluted
design.

Get rid of the ioasid set.

Each driver has its own list of allowed ioasids.

Register a ioasid in the driver's list by passing the fd and ioasid #

No listening to events. A simple understandable security model.

Look - it took you three emails to even correctly explain the security
model you are striving for here, it is *obviously* too complicated for
anyone to understand or successfully implement. simplify smiplify
simplify.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
