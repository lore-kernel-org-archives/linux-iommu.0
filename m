Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F0C4338F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 14:07:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFB160F58
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 14:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BFB160F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE78440567;
	Wed,  4 Aug 2021 14:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YTxWyOSBcCIZ; Wed,  4 Aug 2021 14:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3775405F0;
	Wed,  4 Aug 2021 14:07:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5CE8C001A;
	Wed,  4 Aug 2021 14:07:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2E0C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12CE083CCE
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uudXCt0tgb3W for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 14:07:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8E7B83CCC
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 14:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt4EfXRVLpMUV2z4FAey22mvEaPU/MxgB2B+RjKscSHW/QgYt7lG5dv3Mg5gXJ10znmby7+V+Nzg8/WMhTrXytY87sLHGVJLNvlj3u0oMq3kDRZ9xy6IxJGAV3BRs2V3MSob/VxT9ChE+LGug5gxLluPjNzkV9B5PL8pmOTgrSWgW75oLgYrwsqrgU/Ez4RNCjRsKcqCgFe0UgAePX7FGBC+VYdYP+L6pRq08d7q6uR5YMVFAaXXgnCHKzGdHiMKx4r8kdPBNGWjak+RInqoa9MRog/MYSok3rTLWd7Crdp3eHrHq54VQzf+CBWSI2G6OBTmNK71ZvmtVB8rMM32Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhZB/s86kU5FCtqSktiqHXGf5HkVqblO0W988md5dUY=;
 b=nQjrlTuQXgQRWchU6DufNBRNE6sI26njelBoHMu2umB1oy+VXs6Rqj6hGcqQ8XLmKcWawIGQxd5swkNk/b7AprsTL8R1UlzOUgdCX3r/K+L+Y3NoTbjH7PSRiJ9I0bSA9i5owuaQfZA6HMzSmdDrlNShdwjCYwVpOk4XDaW0SufHx8LC7LDr+KJdluEa1YCJdOpP5sV/Gor7/GduXzu4MnF+d7ZIsR7T84KpOCOUbD/dJrzhgxl5f5WgynBUFWHEPeR8ZKnLohtrtHTgLx1l0Lbx4qzpsfvErL3ODTLMcXRZSsGKB+1b0uADALfQG9kUlAGoEKtB2wqszwe7tYpS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhZB/s86kU5FCtqSktiqHXGf5HkVqblO0W988md5dUY=;
 b=N6CTaAkbuzmZWORFNkCH656jTHncA7NwmmsK5lsczJXfXKl2hifXu+qE0HzfG/R8hr8eFQt503fY4wMWH7HUktFkVaJKFRMXERTZ3o1yHNAK8irOaWUPbPkGqlXTRg3SDJPwxGuJaU/EZlGsL+UAMwNytYuNkRjpEP419+mWqsSICSv8hvaE/nInPcF6hSZwGbBEc/aDSJOhnRvQYUOCsju7yjZeQ+hvb41aqaWOUJXrfAqehawScTKeuWw/WDp6XCcyrQqmMRyvenWoHqzQBN7nNqwL1/jVQeI6BNkutJwzHJEx4tu+4/ZxFjNzkkLw0v8tMR1qVjChwJH5TlAmWg==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 4 Aug 2021 14:07:43 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 14:07:43 +0000
Date: Wed, 4 Aug 2021 11:07:42 -0300
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210804140742.GI1721383@nvidia.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko> <20210730145123.GW1721383@nvidia.com>
 <YQii3g3plte4gT5Z@yekko>
Content-Disposition: inline
In-Reply-To: <YQii3g3plte4gT5Z@yekko>
X-ClientProxiedBy: YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::28) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0119.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Wed, 4 Aug 2021 14:07:43 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mBHYc-00Cbeb-8p; Wed, 04 Aug 2021 11:07:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f517d78f-8317-4717-5adc-08d957513a9b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51199A01D73251CE91D1D443C2F19@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx79FUnO170epGbKFNocENWz1pKRZkjbIFfZVw7hXlK1xu72XH24I0hMTQoe0rWrl4Henk7mx6SKWoYte+j88r+9PE2oxfShhCQ/qYzxVJL5oLI7ZHv1uAp9CiEc9JmsEuw3iw2k+olCXz05bC3tB2uwn3dMQ4v0Ax5O5twQvpNMG5LupsU/ELUT6bKgs6OCWUv66KyaJTH21sE9wNpKi/2TT4Mbr9lh8FpaO8ER2pwmyisVt3CB2uoNLBcfi3wshewTQo2aYEdtbqasCluJviUYmDBN5fg1CjE0eqwqEN9tVhJxd+1t+F5vMwgbELfQWU+UVtTxxCBwXpjTxWN+Xam5J+oeHBDTAYGmbZiQHF+MHvULltXngLpFFWPvfgPzjyhR9XybKtyLpyNKa3Wf1WH/HMkQlGIxuakcwvirbYQuLeTo8ZCJXehA6ysrForeN+IQazrR3tLclSG/upCa6yVeIy1B+onIkYXkaygtIeAvktVc8bL61Yp9N8zpoRJVnldzKLrdzjOFj+uQKQ4l78wDNYur4Kzkxa7uobRvgJ5lYsX09fSAfb7mDss8BJQez7jK3HFL7wcEjM5QjCvbgShr9ZHVl0tLIyNcY7fFUx4CJrCEt8fGKux07npnLtOTKopf+sF5xIku1PmOcu+oTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5520.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(2906002)(4326008)(7416002)(8676002)(6916009)(2616005)(316002)(36756003)(426003)(1076003)(4744005)(66946007)(5660300002)(33656002)(9746002)(26005)(86362001)(38100700002)(8936002)(186003)(54906003)(66476007)(66556008)(9786002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWF8xF/FDYjfB19lyA/rpvjLtcdidwOuaJPgYHXab4KDS8QYo6WWy6pUfID7?=
 =?us-ascii?Q?bN55Jx1m/cmMOfvCazFQFepNRHdnup1HVbHbj6zwjIcUCp7ZCdACvA0s1ZZ0?=
 =?us-ascii?Q?kj2RAXows1GaFM71LBRtdv6pqFiodbHPutWUOp7HWDnQeSsxMen3LXnM7fbg?=
 =?us-ascii?Q?B21k/IYI04rY0k4VwYd+szUINQ+xhOtNGgMrSFfzJ5B6WOPqRWOji8edb8zc?=
 =?us-ascii?Q?CoG1AyHywHcHtkck1Y9SmWj7ccFMikPGrajzHmZTfB5zWCe2yyhd7q+MWvWI?=
 =?us-ascii?Q?80Icb4fgtcLE/euPo5jlr4wNj17e7uNwVppbiyiqiv8SxL9ZDlfe1CCaWCWB?=
 =?us-ascii?Q?BCs0cIHw/SPY/Jz4T8TEJYAq3819vjuB9j0eK5qbMnIOaisjj+mkwKQFhX1K?=
 =?us-ascii?Q?1TraoCK4GiwGRrTdAmFJWUcEp3LiUKCdcLdBIlG14HbjjbeTmZBoEOrUrDaH?=
 =?us-ascii?Q?VrInpDSaRoUHkTf12Ef9eDWVrgKF0rzrMqIwNeqzNOlyipAutKEHPXqiRvIP?=
 =?us-ascii?Q?Dd4KYXqGTO9u68zZnspIdlTbWi74+3yyQ26ZS+h/ZicS4rs97tQir3S4/Y4X?=
 =?us-ascii?Q?10cNSLqsIGRFPHxfHFxYe0P2ln9g0mzqSF/cLVclHmpDNFBPA8rrWFrt4Or1?=
 =?us-ascii?Q?QuQL4dWRgUQTHw6opvPw8MZgJXfoTjYYU/v4/aRoQMWt1RpbuP+oKZ7T9Svd?=
 =?us-ascii?Q?237d7uKko5KjvR3pkTMaHQCpPErRyvYaABtDrnpx/xzOItDAfqYCl28Cz4qx?=
 =?us-ascii?Q?xSHDIeW/nrA4/dcOjR09EhTQIwkUOHtu/kEBWxvd7Yl5YoQfe0pF5sU+DgA1?=
 =?us-ascii?Q?rPj3XYfat7eL+iWs5Qk5/H/nMCRoDE31eMHe11w323kWLaxHGN1f54e5cjdX?=
 =?us-ascii?Q?j2pm4/HqIHttGiWPQ3CO/ygPpU5V/PLoejVW05++WObt+59bbgHH4xkIwf8h?=
 =?us-ascii?Q?oI0XtJcZJxvAzapXA8Bw+jkvs9PJfaPh6bbVmCeiHjF7fr5B0e+XR1s4RajQ?=
 =?us-ascii?Q?isMQfFL9uiwbjJ6wvzud2i1H+nwKvY+TZ1JKrCkcMBpnQH3LwCNkAzMLD0Ov?=
 =?us-ascii?Q?k8uUIWQZ8p0CV/dbGViko8jfIiwd83uWCsRDExZ4xF5QupAx3VQ91nCNyhCm?=
 =?us-ascii?Q?46KzfHB80PVb32jPrK0nkCHsAcni59CeMQWyUIq5wcx50BzYyPw8anD/TUrD?=
 =?us-ascii?Q?XVZsAGU3c2dKf98KSy3dlRzlC10j6db9HpAmWGbUByd6ATZDu+rhSDacJt0g?=
 =?us-ascii?Q?14Itf5AMPH8CidIStylOQbhiGiDVpk7WyyLaODhhDsFtCkNCtM1US7yvaSQ3?=
 =?us-ascii?Q?dOZ2YoWazWAxx9SCAFtGQHkH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f517d78f-8317-4717-5adc-08d957513a9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 14:07:43.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBcMy25Tk2z8R03VTfvGYB+TSw53ZV3DY0cyCm81LtRC2g1Bv1gswei+E40+FZTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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

On Tue, Aug 03, 2021 at 11:58:54AM +1000, David Gibson wrote:
> > I'd rather deduce the endpoint from a collection of devices than the
> > other way around...
> 
> Which I think is confusing, and in any case doesn't cover the case of
> one "device" with multiple endpoints.

Well they are both confusing, and I'd prefer to focus on the common
case without extra mandatory steps. Exposing optional endpoint sharing
information seems more in line with where everything is going than
making endpoint sharing a first class object.

AFAIK a device with multiple endpoints where those endpoints are
shared with other devices doesn't really exist/or is useful? Eg PASID
has multiple RIDs by they are not shared.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
