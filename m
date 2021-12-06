Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A0C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 12:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA1B740331;
	Mon,  6 Dec 2021 12:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6pFj1hXg7zOr; Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32AA740297;
	Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1657FC001E;
	Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC9BEC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A75DE81CDC
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1YqgW7qOKV2z for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 12:40:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0792C81CD0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3PllvZyaRoTKh4Lk7xbtJhHgMdDM2MPWBbNySP+ushBlEqWw96wykPHHOlTnRkn24pbowf04+jMm6DzjK7AkM8h3/Ed0Gvt74n0GQA33bmdM+u/lsme3QLGN1RTdgPu8Ia/DePXXrOYeAPC5/RdoRRgVvfYsF/OFxokvB41b97p8vZgGFGqF26iTJoZUVlKqRG+zzIX9xi5iXOzXqi0rsm4NZ/BYcCoksBD3+VhNHZF+E40JG7CdioaUvZnEtX8SfQuinyJl8gi828W1xV5yP/NrgohEGVyNP3ncSHGiiAs7vAWVlJM4krTEiJrLJYEXuPRvwjoYo3MLUoMgfU4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xU7WBA+hRQB+iaFVgUAfHs0scPiN1XnKEo8uMk4PcA=;
 b=k8V4W9I2q6xOIT4DqryZrkOtwnZ3tUiagclo6x1gY7hszgvEYOxt2EOZMNQiNXwdiy99ruqGxbavmEVmDrRBHfFX4wnjXKaXESAiT/hyY2q52ztJi7zMWoLT/9D6N/7OXCTnzLWam8h4hxYbE8TYDvvAUFxd3BcDTZeQZfYQm2VYNHVUW+EQWYM8w+jN753jzM083GYQfx+l0bYssrsyNFRl0EYu1/7jRZxo0d7B2YFdnS+RgWLpf63HqaLSg9Lk5p4dSMmDFAsPPQHeXA+hbBbYYtbE5jWU4bRG7HnSyR2PeLDhlQ+GxRopCgV9/RZAhOKiIcUQCQ4HnEfDutkmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xU7WBA+hRQB+iaFVgUAfHs0scPiN1XnKEo8uMk4PcA=;
 b=j2NPRlVpwioi1Ur4Q+q1AzvHaoaelVJiYfQenwwXtW132Iy2EPc9zf81qr9Y4DnLDq4DusnZYWaQAH9QxSDa+JeegAw9gwUcTstpXFOzRFvP6m8xVolOOd6NumODEprBJhPyC/8lrYTz37U+ZgdW9PQjmMiHLK6z1h2Pne9o0CSfT8sRX6wabGty57XCfFWkUWDPfvV1gzgjEELug6HbFhZ7Akcxj08rq9SZ1IdXVMgDvVgagpueh/JWTzsn5+uXMvD3PKUXm8dKvCLgTH2XaVT6Ojb7562mUwutC/EmY/IdMQPqViokMLZ6h9wMYrn/LvKNUpSrdTGy3+MISgsvCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 12:40:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 12:40:35 +0000
Date: Mon, 6 Dec 2021 08:40:33 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 18/18] drm/tegra: Use the iommu dma_owner mechanism
Message-ID: <20211206124033.GY4670@nvidia.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-19-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20211206015903.88687-19-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:c0::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 6 Dec 2021 12:40:35 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1muDIH-008uVp-Po; Mon, 06 Dec 2021 08:40:33 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83efe14-9e30-4d8e-3948-08d9b8b59952
X-MS-TrafficTypeDiagnostic: BL1PR12MB5253:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5253B1B18B640EF8383AB392C26D9@BL1PR12MB5253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2Dc1CruVMQ3S+sakxr5j0K3G1GBbXGmSCgOBUUd/PZ3zDQpBe9D9zsxRvptu7kR8pv88qsIMCuBUJ0SJR1GaoGkOFxi7PXJCpdCduKp36cMUgT7b4rn29wbiroM4pfxaXZjc36IKCSoHNjzoJlsWk9OBrzu9MfL2mB8GMuAqtpeFV3g7hFk3Rgi3vBeuB4f3lRKYAoY2jnIAGyIUSavx5x/lPAmqZp1HtHkcytHVpveyvxnDl15zjTaAzuToODOzgmjXIqjd13xcA/cr8gGFu1n0kDCCwY6Q2+UtN6kuTeqJguWWixBbnCYULHd8ymqZzTOqzkq4QKNfmjd3T2d5RKJ1AmRgbCe72z84FSv2M4g5xCRzVtK9hyMKVJlUR7WIBtznJMw1JVS1l6590K51eGEVlYHEfntUeLPlDJdO8by5bhWW4VwOhACpe5Y4rbWvvQ3FX5wRCg14GKgRhE0BRj4hjMjKKorEqQO3Mvk9XclBpEzbBWybkb64Xzdc3CG1SYWT4afDP9xPgfh+0vyyOQpT53kueCfAWVtAG7LCmB7LFvyRK5bMCvOiTYecppunpz0UJPpRU6CTYxHYGNNCdyzZSGe0DGzLUcGT95u7q+wVyBHKpnInprU1YiNMo8jMVmNuWst1fk3yYW0ya/Qzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66946007)(9746002)(9786002)(4744005)(1076003)(66556008)(8676002)(426003)(7416002)(2616005)(2906002)(6916009)(86362001)(36756003)(4326008)(316002)(54906003)(26005)(186003)(33656002)(5660300002)(508600001)(38100700002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xtf88+u64J9uwBCLMNyLPICnPyQZz2MYd9YGlP2LClP8vVabAyCDKWwryLES?=
 =?us-ascii?Q?Zar3FDT+OmbmUuckTZl96JskFKaSkeNuELVsY6qf/e1nx/CefQ4ipdapd9t5?=
 =?us-ascii?Q?x0h+zaWyyVSqi8wrMS20oY//XsyR+H9LZ6z5eDmLt0uz5e3C9xCQ4VhBExm2?=
 =?us-ascii?Q?fMRVLxiP2IUHnOilfp1zaACGTp5mgdw9LTCczl9Y9DuYPpkQ20XS7ktPbb49?=
 =?us-ascii?Q?IWJpFe/cRIl2P/x3yj9OJqG52uNJPvPqZ/I2vvqs+s+bWRYgdZd6RCB5NVOz?=
 =?us-ascii?Q?PCPQROa5He4hlNk0SvcsmYDygs9jYkJTgXmObI0xtvv85PBs8CD0cIasQI2q?=
 =?us-ascii?Q?SlRuBABWijenvrGMgTIhW51P5Jw7M1N5jkSWvTj4qxS7vdAx0eRT2M5ua+Vi?=
 =?us-ascii?Q?q0vnugpWOdOQrOpmsG8rMeDRpqhb9ESv0hrrMYPqmXIs+nC+uz113RmeExmW?=
 =?us-ascii?Q?irwE0hDEDscvyRonOFUrbrixmdXrCWnEDBPO5fMVFJv+amCeY8i8+2Wmut07?=
 =?us-ascii?Q?aVQ749U3jyyVNjA2UfcQNKGat5xfpIUpx7j100yZHcq6AWlfpjO0TPmI/dED?=
 =?us-ascii?Q?jufF2QISWijQuS2Ksj59viVG1ZuhXwP4r92TXKrcVvqou2hOFcBEmVuWvxq0?=
 =?us-ascii?Q?WAZBsfBuDhBgguMHOMfkLyPdNJ0+22RTPiwE3o14E9rHCq30Dbm65H9eqekv?=
 =?us-ascii?Q?f2e0x2Q9Wt3ekUiD0V9i1+WY/TAxVJv8vl1vvuuQ74mcXi9cHrE6BbPCeGl9?=
 =?us-ascii?Q?+BR6ASuJE4vJRCCCo0QwqsvUTc0rwqmcIZtx1YPIW+OZwRwU5gIuklpSoC14?=
 =?us-ascii?Q?7NB/nb8M7grf5k5Xv3sm3ddWJkqkV3JIDUlav+/rI2UUmKkfp/JsHutaBTV2?=
 =?us-ascii?Q?UTRJFp19lVzHzbk8y9/HQRgJ7daoPfnasM9Y+TqavaXuCqlifYPwAJphH5mI?=
 =?us-ascii?Q?8pmiZdWqDutwFZZDROrG51hCP6kCIaZUgcYSjlbBOfbh9Z0suzVIkqTK08eN?=
 =?us-ascii?Q?Vg3mLr+jd256qLRjFHqNI1WK6wobqLbnyu0IJ6+/rjUrn/8697tvvAsvHLf9?=
 =?us-ascii?Q?ntHqA/0krbztHbJQ5jK+9iliFSw3EC2YJ+sdM8MHSLtvN638cOruova7HE0o?=
 =?us-ascii?Q?rMicjoPqyk1n84rdXHpK96DOKI7mXDSCjNqRVk9C3SoZDZspsZ1QScYRQbo1?=
 =?us-ascii?Q?jUw5Gb009K7fcefHFevlhSSpSK7oSV1ZTrPVT14W+h8z/veA7C+UNJ6nC3QP?=
 =?us-ascii?Q?8Xn21GsunGEMHRYdMwHK6jJdnDVtulRnSQlF7qoXkpkNPm9olfbbzO05JVba?=
 =?us-ascii?Q?8ADvvy8BCezxcggRFQX0dhhCZQ1ohj1K5hed4l2ZX3bvTxxczAjKUOf4wuX2?=
 =?us-ascii?Q?w9aQO3Cm+lcBA7dZkxSqGDZXcZNiI36bQ2KfHERazJ4T0eHH4ISRNhWOrD/r?=
 =?us-ascii?Q?QFIS9KPNTGy9utBqnbJYD6OGsAX1eSAc3Oty1piA+CZRcAFUW1IHa0FVklS+?=
 =?us-ascii?Q?FZrceF4fjUcyip/Oyfs7pCqxvmzZOet7xtVC8asOqdUeQPfdTrDO8uDbtBqJ?=
 =?us-ascii?Q?aT3F/P1XJRso5/bevsA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83efe14-9e30-4d8e-3948-08d9b8b59952
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 12:40:35.4747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQdfiAiojas7K0sEEZLFVaH4niwMHP4PeU4P1I2Ds2nkjnmkWx+JDEPJdiuKfULC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 09:59:03AM +0800, Lu Baolu wrote:

> @@ -941,48 +944,44 @@ int host1x_client_iommu_attach(struct host1x_client *client)
>  	 * not the shared IOMMU domain, don't try to attach it to a different
>  	 * domain. This allows using the IOMMU-backed DMA API.
>  	 */
> -	if (domain && domain != tegra->domain)
> +	client->group = NULL;
> +	if (!client->dev->iommu_group || (domain && domain != tegra->domain))
> +		return iommu_device_set_dma_owner(client->dev,
> +						  DMA_OWNER_DMA_API, NULL);
> +
> +	if (!tegra->domain)
>  		return 0;

This if should be removed completely now

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
