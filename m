Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4791BC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:13:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F137861418
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F137861418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B59164061A;
	Fri,  4 Jun 2021 12:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPQWOx8WInXf; Fri,  4 Jun 2021 12:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B34A4017B;
	Fri,  4 Jun 2021 12:13:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0330DC000E;
	Fri,  4 Jun 2021 12:13:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFF2AC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6E1D404E2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xTqc2gqABGe for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 12:13:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C039B404F2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3V1U7z3cRRpk6XUaIfxeycw6Y3NqwIQGIwwdo/+Lfxib6lK9kEPxsKHLeJ2UYoFLpvdO7TaNSRMUWIIj8TsIdOSD0HxagOLdei8WllzzFpYs2/6lFhW+onL0aoZt5i3bCR+D/DbXMyqovgSUN4zIFz28xGDNbxJKABdM6jgTpbnaRohVuCyXaS9J97Zb9CONrBzXsXA8zD9FOFrqHcr13zJlt3xi4R1x779RYBv5OyjCcF5WMF93rWFmwQEYoCbCbbw7eoqZKbj7GlYccdra/jRjDGxTu0bBfwiiIhQlyK/90md8zg5so9hg6C5cENzqyfVcjC/Sb6HB7WAubUehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NE4CihnEdBLKxqgP3DOZBhV1ifgiN0nh0W8pwUu17E=;
 b=ZfcX66BbtT3E+XVwbJ+xsMFKNiYizZDkbp3ZHBhdeT0q7zVT42p+QHopf8rcGzaAeePLaaDAMCksm6NVIBkvm4FsceYOubyuXvIKaPCt38E2fnx2fisxZwcQI5Yzhvf25MV5tQO4x9hWcs+QCJUtclz9Q4rB5PpvRW/qO9dCW/VJF3Vbs+oBI9YWdj9MJB1RH90LFVvNkqZ0pVozj0trpLqSm6ApNcOo26qfGRw4beek/w5UTdHbRrnpycWNmFthLTUtvqkIU0Sb4yxEitaNQ5sHRQZ7SeQo044h854i59z1ewNzIJZS1dh9liTYxghBDB1BXV3WZccX5ezyGfVIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NE4CihnEdBLKxqgP3DOZBhV1ifgiN0nh0W8pwUu17E=;
 b=E5R1/vcEucC/o/dnQvaAxURGyxjI/yOe4aqOnQTBvdW3dh81DtgzwcU1HbNPEXjCSjMS3KHLG2gwDlx1AwJ55pbVpQUR0PEd6tXmderXW+UOpuhE3MwGfxWeXTIIk3LYrv1aJUD3osBeo3nznsbnSv00a7X2JfsB3UzhnH+0Np1O4wTnZmV94IVhnyEfDBoRLcaWjMSVQyE0gTd31/KOEMUIYA3KGOwlCcY3J9yhcQrbiKtVbKMcZJ4rFn5seTJviRn5VXrfOfdi2qJQ3exiTiPZ7whPmYl6/BsczfYSDOijyzOe5wCQv65MWwVI7A743st9jLnpdqZhRUFEFgBdMQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 12:13:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 12:13:38 +0000
Date: Fri, 4 Jun 2021 09:13:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604121337.GJ1002214@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603124036.GU1002214@nvidia.com>
 <20210603144136.2b68c5c5.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210603144136.2b68c5c5.alex.williamson@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.11 via Frontend Transport; Fri, 4 Jun 2021 12:13:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lp8hl-001dIN-Rh; Fri, 04 Jun 2021 09:13:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a294eda-15ff-4dc4-32f5-08d927522f83
X-MS-TrafficTypeDiagnostic: BL1PR12MB5093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5093C405A2F8EEBDCA726EF7C23B9@BL1PR12MB5093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha5FTFsSpZit8DvUGNKV981Ra126ZT+dixvFlDcMzQcnj7wr+pkW4W6lnoyiyGfOczybwnP2D+Z+WV8oIsOcA29NHAOva0Sjk/n7lRoLPJY6Mm840PMVxHTjVS0yjHGOYjkqELCOfn2/2Qv7FEa676MtZzv0biT7zw9MTCQ+neYVG9V401Q//BUArWlaMCkL16YtYbhj2382EeAkinmSbFoZdTy9imAgw6Z+9Mmap94U0UmoLcNaOQW0OvgJNV6JGMazJ4OaWiJW9MuN+ZUG24HkPrYLmmm4+7gZl32Lvesn3tKhsNk706uapWF2FNILg09kbqedQLbU/ZksN3VqAhgYF4fg6hKY/ka62XADLo3E1DtlA4dXR85VHHcxSie2/MFfKJFIACsb7GaqZT/zZ9rHlKhTE0lXTU7Kv3QotpCAwMrI88yiMBd5pG0hGXL/bnVumxeFIZ8WXQUOeEhV1lZVvyEzI56I+/M7u9vUzBJLB+bDZXHEp0KDTExMisSs3drZfrHUxAfXVPGjIAoOCOrkvoAprbq8lFUOIzrAlrTfzFWdncmiCtG3k8NffJSYk8AFlkunhO7NDLbS9R+QYMZ590bTJJeRB6Gy2chVST8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(66946007)(66476007)(66556008)(33656002)(4744005)(1076003)(5660300002)(7416002)(2906002)(6916009)(86362001)(426003)(2616005)(478600001)(8936002)(186003)(26005)(4326008)(9786002)(36756003)(9746002)(54906003)(316002)(8676002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/NAmOWHQbGYPasTQREseRXAK3INa58CdBte4oLTfq/etAnkIB1zB85qwzwxk?=
 =?us-ascii?Q?PSHFyXo/3gFo4Ibrf2LRTUW/sxskQHgqI76juRnbWBqd2+soIZoFfbMv/hGU?=
 =?us-ascii?Q?hqrNhO4UnrWlIBz04SQjofzvjkcmS193ZZ/oLj95mrZEHVlEI2QKIenp8hGR?=
 =?us-ascii?Q?VMtLQ12kMXz3hbmHoy7iU58RcxmH7rPOEBxTFID1N9/8xyTCQ/RTefrDDXZZ?=
 =?us-ascii?Q?4yK3pLetNfItqndE2j34MMAc0G3RV27/V3kUjYBKUJvlmq3p768Zl1XyXBoZ?=
 =?us-ascii?Q?n3d2aOfeno1orOLGPJpLr7/5W1QQY5wdb+9Fc1Z0cHj0aIiFe+XRctoq0Sij?=
 =?us-ascii?Q?D1bIGcyONggu+JKHgQNgvdpc+jnYfD10GFxjP7kwQTTpoJo7G752/rl0fRQq?=
 =?us-ascii?Q?kjOiOC/zQPFeI/f/SG+XNJFFkPB6hSAXnYCMQ9FTFgy1wX1gFKhRMZ8emojL?=
 =?us-ascii?Q?Ka5dOikIwhz1iK3bwUs9Rm/XReaqA7rCq/NbZZ4lCsmXf546k+ge5A2saYTb?=
 =?us-ascii?Q?D5qXl1OUAmDfX5uevBFBRCkcyeO0r7o8ECvqsgxH9KZQ2p9McxwrN9rY0Efj?=
 =?us-ascii?Q?/DiDtH8djqvFGDmjuCTDNgs88TbSa+yh2tSERvZmUP3qL828VG8rcKhj51E1?=
 =?us-ascii?Q?XdATrl13SPmBv/WEzOfdo3a8kdFmyRSUUBReNVlqg5fDWUf6DL9xK/i+qWwg?=
 =?us-ascii?Q?OkCq/U1Dgt6CO0ntjx+/wCaJLK2WyQjeGXNwpDWUfrW0ccwsYHMZdadoQPxV?=
 =?us-ascii?Q?vrvpIrDWqLNJ5WOt2iBPZ3IaO/9Cz+Hv6h2S6DF8iTrVq+jTShx1wfxC3kSt?=
 =?us-ascii?Q?xoleGi/RvEciQTXUEeQlFy1YQt0/bnQskP/KVRpNGfrCVYDNDdGWzX8TE1/1?=
 =?us-ascii?Q?wrvXURXpHt1SaWcl0coiaeO3Zo93DMlbZrw4ivLOcasUgDhetEJnIZKbsuQy?=
 =?us-ascii?Q?ji69m3LmEgGkPk8LZoaeRqR+q6nts6ku+RNO/+OQ1cDKfin5SSOcrF4fbv7q?=
 =?us-ascii?Q?xfaY1nrN4XA4cF+5yw6ZnUrctcSzZV12iuo3+eId/YKwxLBEnCXiZCmmCdbv?=
 =?us-ascii?Q?E/z4rR7qi5YD1uCHxgY6dlab7GkZ6iy4ayB5vrq98G6orTWtB91SjifmfExS?=
 =?us-ascii?Q?R842swUMky+2Cn+yKJQ59e/6jZIlT+GqacjwQYZ1JVLRWwxZrUskYmaKeV4y?=
 =?us-ascii?Q?rfPQfdV1XmHlrfbJi19ilkrI99Iq8seDLLioitM0GlcfKctI/aiubtSgmp6Z?=
 =?us-ascii?Q?JhaPWNQNIqqHtOsepgMOnusDTFtzeJgAYVHpFKJuQlE7Czg3Jl9vTjdmEp8n?=
 =?us-ascii?Q?5BjhWAqWEXqmLMPs5OuQeRUb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a294eda-15ff-4dc4-32f5-08d927522f83
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:13:38.8869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8K8k1aOvwIVIFiub8/xBtKGwCB8YsXKikcd1I+aq74YS/QS6xawy+9Z7ZJTpCU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
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

On Thu, Jun 03, 2021 at 02:41:36PM -0600, Alex Williamson wrote:

> Could you clarify "vfio_driver"?  

This is the thing providing the vfio_device_ops function pointers.

So vfio-pci can't know anything about this (although your no-snoop
control probing idea makes sense to me)

But vfio_mlx5_pci can know

So can mdev_idxd

And kvmgt

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
