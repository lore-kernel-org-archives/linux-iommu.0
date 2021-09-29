Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34008C433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:59:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD5F6140F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCD5F6140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9594180E7C;
	Wed, 29 Sep 2021 12:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKq9bGPW4Jrg; Wed, 29 Sep 2021 12:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8053580DBB;
	Wed, 29 Sep 2021 12:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 503D4C000F;
	Wed, 29 Sep 2021 12:59:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51F09C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E53C40012
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLRyqnd0ajij for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:59:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 475154021E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT391XmTUdr9kQybHSW4K/wOdjjmfQgnMO+XQTfBJjZxY66ta+NozqiWK/C1dM6snHyWPRhHGXt6nJIZU5DINQw3agNMlMtBTib/lmAWzzIBuj9ouvdsv8Xp5wIq9Bn4VcXEahfSu5ge0oJA1rdM/YX2N47QJKYBXCJeB08hU1E3/OVhy9NqnRBYobWtW1JJusENvgHtQ7dS/K8mVS/55PseR2+C+3Kvv7jTVMc3VKLBVVDVnLAcUzMJ6oSRchlfRHBFi8a+PiQkp1G3tGYIUGjStgky3URrx4AzugWqkUY4gJhkFp/GT5Id+Bgx8WTTCpn1g5szBvuLR44ntHRtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=17GPk4aExclJovP+BL0vbpe5G41X3YBpJVf89q9ID4w=;
 b=PSCKDR4RmN+nLM9z9F19YmaMU8ncrrgf6Btj9kszN0ag51XjfMcuPk1rP2L9HqDWAmrS6ey7DdORrJazC5pmuJHsGtFXtiL59ZyOX/2HE9qMq4Y5aml3tGxS5B1uqV14nwH+lddSknNRhPgoRLjDr+z2g6JIn7MaZNqTi0jMTPrltXHpJAtejf3GybYFBEg6B8tMohVQo3jVSdMAA3n/ISXEThAztI6h9tqMNhg7/Ki0dI4PD28TICKF/xVQ/pOMz3Vd8bXRr3r+Se/M5LYUJl5qE0Yfwp1+4UjrisGqPLTHVj2n35+Naac1asM6Uu9SW3GW5xifFjcuNQ6EsQ451A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17GPk4aExclJovP+BL0vbpe5G41X3YBpJVf89q9ID4w=;
 b=irVvhnhHpDuZzU6MNkybTH9flLE9oLsYrciUaaSmht99IglLk8dgO+JKv7V1wZwbx7aKGDJQSO4+2TPhz9tJCufbeQH0OY4k3O3F8KNnc30oRCMf3yN+IYNHXdOjbLKvlN+a5gZjdnJsEqGKxb0ZWprYYw9lVjyT69tV7UgnKvwMDH7rt4GR3m2mIDibhtOYviAQ3qJ1E3heZsxFGRDil6J9nBKBiIENekU8GmZNx/aNJ7zMzla9Cg1Rp3PZ7F+ojyoygau3r27vZ6GrCnxumrfQKOMaTpTYjELrG9IvyKEfuMBD14tEMaSwZu/iU6Wgea0t2jbp1Vl03w/3xk9dag==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 12:59:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 12:59:04 +0000
Date: Wed, 29 Sep 2021 09:59:02 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <20210929125902.GU964074@nvidia.com>
References: <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927150928.GA1517957@nvidia.com>
 <BN9PR11MB54337B7F65B98C2335B806938CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210928115751.GK964074@nvidia.com>
 <9a314095-3db9-30fc-2ed9-4e46d385036d@linux.intel.com>
 <20210928140712.GL964074@nvidia.com>
 <BN9PR11MB5433B8CB2F1EA1A2D06586588CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433B8CB2F1EA1A2D06586588CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:59:03 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mVZAs-007ZEz-SB; Wed, 29 Sep 2021 09:59:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acbdf931-b317-4e2b-dc8d-08d98348ea01
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB525330011B3ED4F1718A415DC2A99@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qj38hbwySUeBlZ8iQold2bIds/ovhZyUd5ImE+Opg8wzOHqXN0Zx/52XMLREKn/nwhNN7DSu361Uxr4sLt6vE/YQONmj3SOJq4+IHZhq+rkLxdwbox/he+i/vKPGsHFYR9m7noldOG7JCImGdficmD/n+ofzZW3fjcMUQaRDJXJ1zQwmkpthLcDbb+pbUPwsvM4ziUnOx1AYFB+fAi8aJIYzui5sPrIvIRjcqMS4w0L7UOnVvjkhdwgcVlaSFOIusNTiYUEiWfkYVFo5NnrlX61mLtfekU99sulOe2JrQCg+T0JoaL1YJQUDMcmgwp/j09tkr5z0sEaEgR0gp+SlbxBD4wjn9RgaPq5t8sMo/vLo9LuluT48GuuJYk2LIIk0MF9tPy2ElifrxibgSQ+g4BVpjAPzZyb5mm8ufaRURukIxzgW5TsSBxc0dACn6vdiT29X1sivCwFki4fiDU1aV6Zr+lbXu5jp/Fg9u8YwdJXB8jpJgwHXtsy4Puw9gxYbuwDwXtCY3ahLENiLp0TpC2eEu5ZHVsiqbFHRhpq/fOx9+KOLy3ZPPBFXAxCmI6wIEKOVH8h0Eco6thK5ByOv+4hEkKrIa0ZqyWuuWpDWjJ/xk0MBehNm1H0TLzu4FM2SJUr0OckJyaK05NysahZhjOShPSeDWUCpKtQSgFZdzmj23h21pgNuNYP9372CVGy50Xrw4fT0seIDQe1DkRKCjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(36756003)(1076003)(426003)(7416002)(66476007)(66556008)(4744005)(9746002)(9786002)(66946007)(2616005)(26005)(86362001)(2906002)(8676002)(5660300002)(33656002)(107886003)(8936002)(508600001)(6916009)(316002)(54906003)(186003)(38100700002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5raLo0W1Pd7fZRL4loGsBZq034LNiB/MKI9QQf+JnhonTiUodoHJC7za/8C2?=
 =?us-ascii?Q?aT/o9NQa4r5qdlMmiTH7N7dOBNJX8W3JALSFi2makB5GZqkwjND5gAyu+I0Q?=
 =?us-ascii?Q?ZOsMDsy3/XFvKRXsJ1dUjoN2YskV4lBYkXDGPUihm0oBFeSaj1W5Qdrsuu17?=
 =?us-ascii?Q?3+uodyUkIRVwTZ4fURZZmr6WtABy9rRtmxcGYZkb7lRhbSDQwemi/uuwFA7H?=
 =?us-ascii?Q?rr15jn1X9NxmWkP81MWw8qCvXD9i+rO5B6rJt8V9q3bk4XGzqkjhFC9owK1G?=
 =?us-ascii?Q?sdiAASHp9St+U65v2ytHOJu7t8f06gKupkYqxf1VxBDNPtMb1o3BxVdKXNVg?=
 =?us-ascii?Q?cfO7O3Hj+LdCPp+RZ19TkgX2qER/Ck3XamS5VAnFUjdz768UjXzNEe+8k0LF?=
 =?us-ascii?Q?agyZ1ZlkifzKhYcgYAJF6loE4lRBqkXz/3ddnsxdNJsr4J/CIx6ls5LjRUQ5?=
 =?us-ascii?Q?y+FGFe4qrQBK+eXNKcABmQfB5VBuOsSNcQP6RcaezHz09LugupDcQoIdMqQd?=
 =?us-ascii?Q?bAL7PMTq5uR50QOfP0ZIqYRDB8KZAsGiiBzcODpLVzZOadZ72jiBxNwwWM9c?=
 =?us-ascii?Q?Q/pxBTImKSmDsonT/tpFNA2sZPn7t0q80NEOlsj7jCmBnmHYujDeXkRMmY+J?=
 =?us-ascii?Q?WQ9Skre4rQa/RV2dyCQ+HyCKaLyhLvKfHRCmVFPY9VTywy+DZGIs7i/kCeqA?=
 =?us-ascii?Q?S/xbCyo9Rb4wGuP+rGy1pPAAyDkxHTYW7oBF2feBIYEIdubPxu0QWxH5Xjpm?=
 =?us-ascii?Q?UlMPctZ3NHsKsHtuCHn6Trb50TM0nYakLeZN9oi6bZhpcToAGtRvD9kTM/lM?=
 =?us-ascii?Q?MIghdIXROcAHAgvPsUzoZAJLy3FVFQT++CC8Rqlk1geT3RSsO8TUxXHkrZhf?=
 =?us-ascii?Q?4+OpULcchf4ugh2b/eIekbBSjACBzfWRNXCkpAamJ5BlByMzkvI+ykuzMuA4?=
 =?us-ascii?Q?oAcnNRTweQQ1umhLaWUIUsIFdWti6pen6J5guVeSFYxTvYige911fsBu35sY?=
 =?us-ascii?Q?/G2x2uUJAjFZb9tqu3Zogb3EnAPkI6CEtvgxVS3w47G0eoGh7B7woPLSLN9+?=
 =?us-ascii?Q?Kkh1ac3F0JAyACaEjB1TKa2TinnEYSFiumj2Y7BA6+viPogxgVEgZDkkDX2O?=
 =?us-ascii?Q?bydKAPvj+FSKc0lvvLCJgfXD+6nCkICosEuMf8Osgt6rBl1zzOC1YVhy1ibF?=
 =?us-ascii?Q?iN7gDlCMT2N6Zb3qF2vbUFTmmhTOn3OZe1Xobd/xU8XaHQg4pVV4yhaG+jDW?=
 =?us-ascii?Q?157Yc7wt1aiItM6iWKlIrdFvtNJtcObpt6BZoIXQt8X5mZU0zHgZjrDEXhYg?=
 =?us-ascii?Q?JxWvkElsNm1tyPzLVTeoFfbi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbdf931-b317-4e2b-dc8d-08d98348ea01
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:59:04.0413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNKYRU2S6iMdGYfvdF5RdjcprGiZKUeUgh3Otv+2entbqLqdlo1soOLY5fJBZ88D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Sep 29, 2021 at 12:38:35AM +0000, Tian, Kevin wrote:

> /* If set the driver must call iommu_XX as the first action in probe() or
>   * before it attempts to do DMA
>   */
>  bool suppress_dma_owner:1;

It is not "attempts to do DMA" but more "operates the physical device
in any away"

Not having ownership means another entity could be using user space
DMA to manipulate the device state and attack the integrity of the
kernel's programming of the device.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
