Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E340C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:34:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CDC6141A
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CDC6141A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1E6839A4;
	Fri,  4 Jun 2021 12:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Xh5pCCm6_q8; Fri,  4 Jun 2021 12:34:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BAA182E9D;
	Fri,  4 Jun 2021 12:34:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B8EBC000E;
	Fri,  4 Jun 2021 12:34:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3865C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8F8D41ED5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YttQRywk5qQh for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 12:33:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C38BC41ED4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL1375dPqtA3PQvlz2zT/KZp2YlrkTI1Rrpgc2/ZZkMLHo7qFtDFq3N8l4dAutdDsOjksmcktnp2da2ivVrKNjqDLiNDqV7oqZpXG1e9uIKnCUNaiE132Xkpbe4YK2m5xdngrhKe2r2LIuj9dTt7MyQDFQfaN9YFKbMhyQmXsYyKN+bKOPcray54dCE3zag/aBlnVndCEnvy5ltl7kizqmrVP4Om4wT3WtZU4b9GMEJlqsNU2pmIQtnUbC3zkWorZ5DGQIe6gPwcrGkPGoYXNT/9UCLguDMDId6iFkQZKKPlbTINDCb7ytd7jVvFGbXltu0uRAR+DxUzOtaP1r10MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyhPveebRlld6+RW4gtT261xWM2fTLM1RG/kyIW7xJA=;
 b=Y7s1Z28DzRSgwgY+CQC9ZXhIQV0LLaKV0gV0gGw5SFwW6rCx8Hp6h4z4Hlpyc3s6sJ4bZ9r0h5xXnonRZtF3nP5rP6ZKi6a9l9FBaa+yUv4p7VJ6LCp0tjz03WIcwN9oF2wuhnZ2JjtaPigqmIM+ITSY636z0d6fvIooabuNX9bh9ouW5l9qZjPXlzOU8/LETE9Sa81Gco2vcWgnscaRADVuoHIArBjYwL6PzaicKapugCfwvgqiDHTJeVdcYQLtvYDD/9GtcRpnRgqMGEkFLolnTrmgxgmhnG0MI0iMYXbp3yDKgox0hYKH9zKYt98zWpwiMk3/y9FOR9zPaR4QGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyhPveebRlld6+RW4gtT261xWM2fTLM1RG/kyIW7xJA=;
 b=nC3aFQOE+y0CdK0idrnZYQE7eM1HZE944FB+TvLLR+aMxRn0efGp3VhMC/jPJtaKV4c5Xrt5Cmp8DOAeFoXDgmy1M64VRP5l6FGZlUVYQB+16WpwHpq3wQeTkadJjk6D9GtP9Z3jkVuxsogA3m7DHiMwnOCWs9Uh8CEyp+GFLqGWYatFdysxiRADXHO4GyWNrZbMk1PUVkeMQWB4Kdjt13j80mKSjPQVRVPiCYjKOzoqK/Bj69OChopBSEaGkGPdfJd2quCtInHRaKuyfXtWdGQTfR2kXg3wcQbhnvIvheyP4JLLVYsIroUHjnM5qpCHCYVZAl+Vr5vBpSz7Dpqsyw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 12:33:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 12:33:53 +0000
Date: Fri, 4 Jun 2021 09:33:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604123352.GM1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <20210603121105.GR1002214@nvidia.com>
 <MWHPR11MB18860FD2BA740E11B3A6B2B58C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18860FD2BA740E11B3A6B2B58C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24 via Frontend Transport; Fri, 4 Jun 2021 12:33:52 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lp91M-001dcF-4f; Fri, 04 Jun 2021 09:33:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 052ac075-8225-427c-5f84-08d927550330
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110F008FF6A69E1BA59BAA2C23B9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFYUeW0r2id7OAUQQe0qfy5cQ99B8eWi1QFtPfsqVZlTmoRhN3nlwL+wc+nHKlQu9BS1uHraxEiA28ZcitG4rXtYnW8pJV1eCAvrSrACGhReuMc7jpJbfiWTeP8RjGU108EBVE+oicV5c241m6SkqxxZZjhylbZSYxsV8bn/i7dAdBmwNoDQKlCYZPX4hPItRLsZyy9tb6kFKDZFCwLufG/7KFCwjibt9sI7kRv5EkeNcFc+BmodEp0REgkFRFuuOWLyfAuqx+Q98AbhunxKmYkyHKiFj6uFtp4P2gVzETspW9Esiccua+qhEKUkLMMot5w0w9Z5MURNOxfChtngJrETxGfGjxjmucg8Edo860GlGTLsrN9Oa+/6oxSnRFWxI5L8sZYU+aab3d+npw3E+jQQRU2SPsIeWP+VLZ2Q5NSeu0pAdztmANpyc89FzifPXrpXY9uT88MMFomueJ5aCNv+ETRSqv2xPzgNTuYx9BYXAkKP3Mct0PApCa0Nxg+9S2dQ7uQ8Q4EldDY9xS2hnnWT0/ePYglYfk7t6bMRuIsSETv7udDphchoIt/2r3aCkSjquuqfZsbqELlH1Ke+vjOHAcVU2mVSr7ri7VvY8/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(8676002)(4326008)(54906003)(5660300002)(8936002)(478600001)(83380400001)(316002)(1076003)(26005)(2616005)(426003)(66946007)(33656002)(66556008)(9746002)(66476007)(4744005)(2906002)(6916009)(38100700002)(7416002)(186003)(86362001)(9786002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AkzmKtgyWwAPNESOOzcD418XzLZ7uocEOXnYirucpZD73iPFK7ZnENaV8RNk?=
 =?us-ascii?Q?8Tfq7TrTbgb09CuZ7tYWRdgAzziv8wkspCaJfQ75RfP7WPVo10O6NRNBXvM7?=
 =?us-ascii?Q?8A44ZcgZzDVsDmMr+wOeuCU88OI6rXsGz2TdGIHB0pPBPD4BHmDApPJ8puIY?=
 =?us-ascii?Q?QRwOhj6ExNkcB1bN2Ve/Hex3ZLpdaXG6RqOt2Xxp/8aHvejhPP6FGIqw5Xk2?=
 =?us-ascii?Q?Wgt14kT5olCe5wR7kxCmqnATLO4DDh7pAQJeMzewtdLhdGfMTTXKrAFUArt3?=
 =?us-ascii?Q?OP7xuEX01mtnmw3PQ6JeSc1ZzLu6Wz1V9aCeNQo1PJQqlsmnyEgIXm17FX2L?=
 =?us-ascii?Q?zufPLLbOCJOeZR42g88NDsAgy7v3bhZ9OH8TwhZ1CKKyP/6vaT2Qy6HU0c1b?=
 =?us-ascii?Q?ue9N8NEOosOGkk8kTqQtv2z0LETWJNveSPfAtPtSVINNfXygIEoWx4vPiXda?=
 =?us-ascii?Q?k1+NqZhcX6F5hVE3g9INCDzThUhwGxhzr5tufsKV6IzAy6asUKT+G+sSQ4Nr?=
 =?us-ascii?Q?cXLwGYk53vhaSArvhlkbw+YCDw/EkrA4Bkmpf+UA4VZO6rdzQ4CLHgToNg9Z?=
 =?us-ascii?Q?0ziXAmx2+UOcxSccF9digKQAvUQW8uaqvgsGl81i0wjezrM0+AsJJCvsFbKE?=
 =?us-ascii?Q?QawAX8UWfwXsf1JlLzEGMh9dzd+LYvOVvJgUBan9HEVXj9x8rgg3AXUct0dI?=
 =?us-ascii?Q?4a0ExPxn0mx/0ucMWh65DJNSnc6Xq/naCnaCCm4Phl8fl9kyCUoTIyP8yAOF?=
 =?us-ascii?Q?d0btc+3tKnMFkS02iSeIyaeEYkOOe23dqTsmG6q2JHg8I6uCzK90Q+YCc5Zk?=
 =?us-ascii?Q?IwQp3yNTVxeylWnDkqT8CbRrsjIavxgskrgYDntAJoc3Pytvc2SS2B7DGBO3?=
 =?us-ascii?Q?vVPWMNot6tCUxKHol5VHOZ4RGjoQXKLMt9lXv+09RlTX5yBHBMalAGuIoolo?=
 =?us-ascii?Q?9efCpJ073chokguieBGejVmrnj24Hu4mjBvRkUK25WnJWdFzaGeuqy4N/SK3?=
 =?us-ascii?Q?beyWyybodJI8n0CY1xKSQElu1Ie/YTzGMf7iZGFx87DlpzdDrrDcen1l5sj9?=
 =?us-ascii?Q?ojucCwWd6Lp4GR1rjou7LzTBl1GAAj9VocH0M/Mn5he7fIcSekrQpcFiOZEz?=
 =?us-ascii?Q?nlBrOyC3ByNDqdoSkZsOcsCv+WbRvC5W2gqVIXYW5cUgeOyQusl0uI7cx6bp?=
 =?us-ascii?Q?zlgjXC7v7bt5drH6n7TYcP0X8oMneLQNRszjHiEcwVn6B8CKOV/JrZwZVbDs?=
 =?us-ascii?Q?rysw8hYggx1zNHaPC6RlU+uGJXBi9bZTNI0PMbgT0cx/dVA0B4nwOCB02nxg?=
 =?us-ascii?Q?JxBzg7bPHQgTgoNFlQxZpoRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052ac075-8225-427c-5f84-08d927550330
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:33:53.0533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Np+BgI34ycW7iwDyrQHpjH0tAkHHBUJyW/WyRoqdCWYmMHFBmqvpLbY4SWgSS9SJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Fri, Jun 04, 2021 at 06:08:28AM +0000, Tian, Kevin wrote:

> In Qemu case the problem is that it doesn't know the list of devices
> that will be attached to an IOASID when it's created. This is a guest-
> side knowledge which is conveyed one device at a time to Qemu 
> though vIOMMU.

At least for the guest side it is alot simpler because the vIOMMU
being emulated will define nearly everything. 

qemu will just have to ask the kernel for whatever it is the guest is
doing. If the kernel can't do it then qemu has to SW emulate.

The no-snoop block may be the only thing that is under qemu's control
because it is transparent to the guest.

This will probably become clearer as people start to define what the
get_info should return.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
