Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D0C433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CC1613DF
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC1613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55CD7608EC;
	Thu, 13 May 2021 19:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BraV1oYXRwgy; Thu, 13 May 2021 19:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3339A608FE;
	Thu, 13 May 2021 19:00:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08A5CC000D;
	Thu, 13 May 2021 19:00:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AEDFC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2ACD9402C2
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Go-zHM_IAx-z for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 19:00:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D235A400D6
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwNBgzvb5epnrfoKLSQQPVouVWWafhejMTxySSNe5EgAy/b9/iXxVq3GVpQjRtZ4PjqfowlFsQ11kpebeThZWzve+0nSL6DLlBN1h2sMZBOPYJYOjKXpGsczu1e5hKZ6EH4GGZ8pSicss2EK9VTS+a2Z1IVvZYjSibeowp2rffzPSVvJaG6QWbuoScMUnQuTJjtf2pEiAr7LyRezIia4xjzqKistH/7xZux3Gt8M78BIG1WYYh5EfjoeVDzy22LqrWSOZcD+JBkT4vxy993ABgEZdi7fW6NtooGXSkztmzhZemRCR2nT4MqjPSTt3TTtUVljQsu3/3IofKdotjby9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyHaMtzCSJ52GDmS3pGzAgMFEuBKd56PoPL5zAknI/E=;
 b=n2LpZrIF7Y+00bO9+2YAA6sHWCrJA+NPAIOW0VQc1xxfyWYfd9HM0E1HuGmdTMT5s4pVYya45/LUqoaQVMnXkhbhI4Bdwb4Q4jc8RXVUup1Yz9S/ynEGw/SsOIys+EMAMsZuq+9q13VGsnqYncv2q2v4kR2Ucp19bzaq9T3iTTD3GJmmxsggsSn6A0LyJDYEqwOd9A/YOkIJlB0OCmV9Hrq1Wv8FPT7YYh6CeJvHkLrpfZiiHWXfAQOZMP2DIEOfmgvAwKMmcj0CcSRlCmPheOrd5zNAMYuHJn3RVgT+2ZjbTaLXEyXapyEnUz4E4F8NupX+LdcMWzl3qV/4Uef/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyHaMtzCSJ52GDmS3pGzAgMFEuBKd56PoPL5zAknI/E=;
 b=YZs5oCdgyzaA96+XxCg9SZSoAAfZXODn430HozmueVguDJzhoxHyHXYpoUx14/+bPBwiKwLteJmdwQrtrHUsCFjgbM5/fK0lFWPOoZTXJOaexbXAgNWE3rMGP2/P4F4ikZ2j3KpnrciCd1ydIrXZmu8sizuvUCUinMA4RuJodsBqhSZVMmz4SvIoQ4H6y04Z7+UIAyq5Y2i1PI4pyj8GU7f5zhJXKxs7RIZNtJnv5rFXs6wgjRl+ThZ0vIlmGcKIowig6Mfj0wSdoaNp/7rF/+AaqoqTe1c5KEWRQ21uuJ1K1ZdsPYWCY3wTw4YrPAb2jfeHU16p+cW9Ak8oMb60Lw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 19:00:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 19:00:42 +0000
Date: Thu, 13 May 2021 16:00:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513190040.GR1002214@nvidia.com>
References: <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
Content-Disposition: inline
In-Reply-To: <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0431.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0431.namprd13.prod.outlook.com (2603:10b6:208:2c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Thu, 13 May 2021 19:00:41 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lhGZc-0079j8-Ox; Thu, 13 May 2021 16:00:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4effb25-11ef-4be0-41c5-08d9164167cf
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24881AB7F09A8380F779545CC2519@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHube+C/7Hn0/uTo9+CjFdGJICfTBdvM/c4jbGqzcUoH8cWP64hgsokOdkAjOqfMwBo6OzYZjgsPfs2J1OrOuxxOnWE/cgGjK1DdXnnk7u8gaLiplKv3zXpe7iywtk1EFLdA9te4aZBTD43cdqoLL+cbuUe0tiOUMmkjlsu3K6JyJ4+YvanDszW6pet/dz0w291ePjknOSVjFnRJ0u2LQ7wWr3HaAItO4wZw3d2zAss7Cf4Kt8WOCN0wtH/5qxM0f3iInoNf15wLfehu5vbo+AlnY40L9Zp6cWpKmMMZbpt/aDulXnklmO/JonE8rdM7aAegLMaFSDj1Rl59GVdq27GHC54MbXbHQ3cqQnuTEdCULXNSl9ka0RdcIhfh+LwayH32ZCl8zhB1sWU7G6TO8wrMY1O3XFUNOfxGVEYykic85YfU+HLXEMs9+MJbVM9mlIncYLP8mPyGtP266ppaz1Y/4/vzzgDw/md4izPylFzLYof9Z47MTC3787q58bcgAa9VXV+GreqD3s3YeDPLqkTFZxD5PeS9kFvg0bH0B9cgh2NsAB9lZWAFHIIbSmMIC0vUEgIfNFAnqfNoN8Wssmf4QmSaMT7BX3EhE3osd60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(5660300002)(7416002)(66556008)(66946007)(33656002)(26005)(186003)(54906003)(426003)(1076003)(8936002)(316002)(83380400001)(478600001)(86362001)(9786002)(2906002)(9746002)(38100700002)(36756003)(4326008)(8676002)(6916009)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y+NlvAe7he48+13ro2EG95DA+/9aMxfVtLloBRydC5Y9DY5PlzJUSw/+vNuY?=
 =?us-ascii?Q?b67NmUnDaWa3G9Y38M9sbGG8X0E7VygBN7Hu9Bp7Oy55fEkDNJHizNz1OGMV?=
 =?us-ascii?Q?Z3mMUjkDLIlWpQ0uNw09XxE6N0EAj5Tv4ld/2ki5zoDF6RXwEaPLbJpNnXBU?=
 =?us-ascii?Q?PYgHsPD777g/YngLNZ2ASg6ft+7KU0BMa4GouszpTdBcf91Hp2by1scZi18J?=
 =?us-ascii?Q?wHQB6QR0//BYLA4G90v27G5cLac/6WANvO3yd6v6n6tQQVZY3h1qF8llNNJ5?=
 =?us-ascii?Q?kw+D7U4TPa93ok6FQOh2VWMuHTMUFyRsyTi0LG0v1QRqXgBXdoufReIevnb+?=
 =?us-ascii?Q?BVT5IkO+ky+C9WFEx3JTZOGCl2X7kCenYwv+yIflXRLrwvohfu7OVbvissA7?=
 =?us-ascii?Q?wpNqsKkugrdGtyUhIQ0d9QJGFq80285a/XNzXfNKl/L6VcYaaWK6ZmnJHeXB?=
 =?us-ascii?Q?D1s0yZXRLCIFwqO1SewlGcgaXHc5Eh6lrRGdygtYb0pojLaah56wvouaaQ/z?=
 =?us-ascii?Q?DKvrJzeWn+Ced+VZLYw4L2rSzFdSRN4hfQcsqcefOrZOQSf6U6iMMjXtwo6t?=
 =?us-ascii?Q?Ol7VOgVaBRaRir/8FnkY1f6O8RMRXuI15ptcbZtyEHnZrnqt0y52aa24PThg?=
 =?us-ascii?Q?TD2U96Esqe1jmuxeMEHByKdzPrzUmzNF0nSGpbELdw9b4pV9rumhYFXfajRL?=
 =?us-ascii?Q?FNMgLS80V0W1cC7kbaVp6KGZMupM82hFAMSNKdEv5v7Gt1p9c1LIsMYbD5Ti?=
 =?us-ascii?Q?QLrl9RolHHtQ2zbUxWMcnXnwErsgfS9ZZeNumenu18u0Aq+biaMdrt2DN5zj?=
 =?us-ascii?Q?sBHac3TNJgX2uI5gTSYd6huYUpiq5slXbHBLTj/dWlp+XT9gz7QSCijUluGF?=
 =?us-ascii?Q?ZhM1CJbjq9oLiRnvoKQEyTwhb1FQP79Wya7f22IZ4W9vwTr29468nS1YTu+W?=
 =?us-ascii?Q?YSzMAOxNdnBzy7P4u36XHSm203lPhGUokLw69QX4HQK7i/Y5FinPbVlOIN2o?=
 =?us-ascii?Q?uN0kMjOjNIzP+W9JEFk9EvWZLIS7uXysj0DxMFStauA4lY9cK2Pf4LEc79MI?=
 =?us-ascii?Q?+6nnrdNN6uMKgpcbFHnKZwqpxG+0/K/dh6zo535Zsh59RCfZKct5d8iJL/vz?=
 =?us-ascii?Q?G3iZKmgPZM5AMq8PaAAFDuCkGYYqYwy68GCMpghRiZw+9jRoZJZ8if+NTYEv?=
 =?us-ascii?Q?325ao20RH5alx3GG601OZxp4XrtnUo2AHGDLq/lPsJRuYS0e6wrb75CoD5+F?=
 =?us-ascii?Q?CbSgVBoZTzuGapSoYoS5r88HNQ6qzlz5RuiBVhcoz7JennuHXhd/RfG68gw+?=
 =?us-ascii?Q?ITOb/mZrG3wU2kHtGTsD9imj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4effb25-11ef-4be0-41c5-08d9164167cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:00:42.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGelbPIbrHpAdq2VyrO3XbXVugdLjZATjEuWLfTC5PLtqTHPzKj0gum1JRHvkXeF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Thu, May 13, 2021 at 11:53:49AM -0700, Luck, Tony wrote:

> I'd like people to think of DSA as an extension to the instruction
> set. It implements asynchronous instructions like "MEMFILL" and
> "MEMCOPY". These can be limited in scope when executed in user
> processes or guests. But when executed by the host OS ring0 code
> they can have all the same access that ring0 code has when it
> dereferences a pointer.

If you want this then be explicit about what it is you are making when
building the API. Don't try to hide it under some generic idea of
"kernel PCI DMA SVA"

Add appropriately safe APIs that might have a chance of making it
secure, eg by confirming it is a physically trusted on-socket device.

It is not just Thunderbolt devices that could trigger this, many
devices with programmable firmware can spoof PCI DID/VID - having an
exploit chain that compromises a in-system FW device, chains it to
faking a IDXD HW, then accessing the all-memory PASID is pretty
alarming if the admin thought they had protection against DMA attacks.

I could easially see an admin option to "turn this off" entirely as
being too dangerous, especially if the users have no interest in IDXD.

Which is why being explicit of intent is really important.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
