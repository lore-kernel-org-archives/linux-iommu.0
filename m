Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19C1419B5
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397007; cv=fail; b=YC/AhmY1egonD4fjOnCFMqKUyY8LTZPxa/ZA1dnoZ0pX9O6bbNcZuvCYxrQhoIkz/hbErAat3N4Wkqrd25NPClYkGMJYmoPrEPFAvs3SkCeATjld2OW04Eh0JIWIM54INs17f6i+2jljT2qfMQ8AP5EkEtttLXHD0BQ2BrBo09c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397007; c=relaxed/simple;
	bh=cyIo6hbRIfT8R1fA1ewOpd5NLxKjmWWXF/U+tj+w4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ossQiHQBFQE5AUQDIznydDh/ft1+s8cMtNaozmfyIP/BBihXDe9e6GEvDBmrWAuYlWK14tx93QK7XBsA5OrzvIHYogc/AsF0EXMgRLiKzgJSArx+fRqjMs8GkCwEebJs2TtIojmyZsbkJNHusM3L1U9Z+UBSW4KK5LaMQTJ5O2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tKu78E6O; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tKu78E6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfzLyPV98VV1hTzNxl7ENA0wx6FZU2UPd+AW+jkvSvWO/MbkHW5jOVF+cIOCHglRfk1+n+lfnOdYis29e4DBXpfEctai8ZBuSiLOD0lFCl7YCRly0nLfNsqKKcTyDP1bF5axno8IkrDdt6jxuiuQnZNybnqFP5uIdqZqciHoK9WpXKTKOqzRnsIqXYYwOis2qkLWyJl9UxcJZngVgKEXjZUliTaQeWGR7H84SKSZIiiQXNW74VVsdgrX9Bd7rhkwgfkgom2dza7O9z+SPeJM3gICTyw39vHH5pCIkp0syeQ4pgpv923NA0UJZlgl397s6Mf8UTPa6qH5EZAa5hxgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A1oYaplqhrprDKxRtT2BPu+FUZEUbDbOI8ab50Dc3s=;
 b=Lh+QzrpNjqNhPNQLHTj9TCAoYboXkfaqpyqu4LoWsgwE99AipQbkG0jCNWisvKgIrsNpH9rszKmlrCd1zhqAKd3qSIm2MChqrU4GaEsE5SFgXzcUjFdZhdQbn3RGJsdXNJf0zznO49nqoPAowAkBjVuPGid9LSy47z3m5DjligLHU2ZAzF2Yovdc6bLUjyPxiYC/Sgaj3rQxuSjdA1snJivEibPAP+sO3pil3tqqgagDoLBsOKpZIWQGd6n68CD98nSDn/Ldv3qU71QAHr+3xk/7PFgrdU4VJ7CUqnDVpJo+djOyBQP/NMaL1ldOF+93/OT4KFk8dXlo36QZVsv2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A1oYaplqhrprDKxRtT2BPu+FUZEUbDbOI8ab50Dc3s=;
 b=tKu78E6OsAV6Z79P1OlUM4pyiP+uVlue5XFd9jNvP7BjMSo74wxc3thKy3e92Q1MUS6BOVC/mS2ZfE9piJEFOUSgCqbsfxUedhVUTS9SRjZtQFYaYj+DQJND1o7lhb2QQlJbwX/A1I+aLaGQgo5ZcTLtnFTj7BIjcB38WTKKnAmt87xgwzmw5Y7lw/9bRNO/lLSLpc8EuUBDD/S97hTJjTk9mV3xSQwq2A4b9ghXBiyqF52/0vkWoiJy6mlxT0b8KF2o9uAckLhnluSYjYIZ1rI39SkyByoRWKifxeMudedJxdEzM8X4TNr94UcLr4MOiP2jsEaQNE9JfFZp+tcBnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 16:56:42 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:56:42 +0000
Date: Wed, 22 May 2024 13:56:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <20240522165640.GD20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a90c79-f50e-488c-8186-08dc7a8027df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2nj2cLsfOCK/iDqdqWhdFcI9AiHGkHNm7KYnXlVRW03xCM0abQmeHZB+Acz?=
 =?us-ascii?Q?dLPYP4A7XkCHUlqlInN1X/omt60t48BBEUYS5vQQEaY78EVXIKaz3WljPJ/x?=
 =?us-ascii?Q?jgvF2M3Pxvcij2Jtt4ZU++0iI/PZ/bgdauhJBa8IiRpNlcmhIFAUesOu3X/Z?=
 =?us-ascii?Q?Wi8cRESWdb10BQ9AzhyLS1D/0viV4Tf58hIlT0A/Fkt3//kUM9unIknV2rex?=
 =?us-ascii?Q?uXNov0yBSMy4c3hiOl4n4GT9m2Y7X1yboDeMw2uOwRf9zm8zaOKHO7tdr5hb?=
 =?us-ascii?Q?QnwiANRc5QvIYt59OjdgiEADDrXdjQv3TFaF00v8IAjTOJhtlfnlDk8WBmVk?=
 =?us-ascii?Q?ZXB3k+NfxC6Q3Kthqn9Ar3Jw5bRAuusePGB3LoKZAUNPUa6seA9fc0bxdmxK?=
 =?us-ascii?Q?AQIXpaLVbBNffLRKKmfOppx2nMvNb/CZLY1gQz5Br5QhnzVl0vZl8C60Q9nI?=
 =?us-ascii?Q?dDbNWRy2LnALZ7Y5/Gijeju4s8BfYDlLF6INa90tETMoRf5CLiCuULcl9sR6?=
 =?us-ascii?Q?Q6HtrVZo1cHT1JL2OZLpUs8r9HfsTNLt7mjJe4pA5icNyUhAc/pSkDO90COA?=
 =?us-ascii?Q?W/eGC0VLJnfxxpiaowRzyQfrQWlVHBGrrf/ZVxGg1tuF0PLIq4bx6c4fcVwf?=
 =?us-ascii?Q?jWkLH+352sGfaylX1SEug/rWK9x3qFvbaiYelEmcAIQDZaCkXfU9CawNCT86?=
 =?us-ascii?Q?wMUzRBOSd9SN9x9B8dxX5RmyaxVLqkdRdCqLg+ikytLGXi5cQGPL9/bJNh+R?=
 =?us-ascii?Q?RLAQSk7785LKglWBB0QQzYoyLChgaXk1yXceU2yosLoUD2rdVqp/VulwYsLA?=
 =?us-ascii?Q?yA0wv6aOi4sSG5kOeX2n9A1eyW0cw/TFKOMnItN1dV7i1XToZDT5PAi8IyjP?=
 =?us-ascii?Q?EtC0RLL6E5YidXqhgbl0e9cqv7aFck+PYnRzYDr5dCMRJKZroP32HvSh7dI+?=
 =?us-ascii?Q?/GDsnClXfbDQy79YwinVWhsfF46xKu64jM0O6QRfloqKtQV5hsWYUnVNRvJX?=
 =?us-ascii?Q?eZ3RGC3Z1l5+lvIbG4/CBrSHSBa/aZMURUdO2DvzZne8BkISsbDUPWa6Dzl/?=
 =?us-ascii?Q?fLmB78PwhA3OEKL5YofIwK5rfK9TIWlvbjJxy1o5qcUcSdFNG+30PJeF4r3f?=
 =?us-ascii?Q?PauQCgafBi3hPjdmhCRsgcJOtGk6NYBUjBB2bnu3UviI4nS5YZdob3nsTvVu?=
 =?us-ascii?Q?uusqp4u574NaaVY5nyTpvKGohM86+IeNj1NF4Ct4RQO3qQDYe5xyHSOe7weF?=
 =?us-ascii?Q?R1xpnasjH+ZnNMPQhjUVIbwyDtV2ZaOtEnUr7a0INQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OOSruGizFSMxB5RpzKEpQI5rjolCgjLPy5XNzFGkZs3Q88KaXNfSFQqf3cR?=
 =?us-ascii?Q?Rc4JDtysR/ZwGE1TfQ3XEtRaTClpa2ext3XdivbRP0Yf7hWvYGX+srsjvk4+?=
 =?us-ascii?Q?5H3Sxi3MoB5ZmEtKJtc7qCxbxeSqxhjXgytyI/13E3/0Z1bWy+Q2mQ8t6gMW?=
 =?us-ascii?Q?gX6lqZnv4SFA4RgXFRQb0dZ5+4TwSSPzGyF5hFGYXQIa4z/tmt35dMOTLTk7?=
 =?us-ascii?Q?oGV33aVwqxU4BziSYJAA9EHg+L9pUatxEmrSVFwr7YyEphcKOoEfFYL6ooER?=
 =?us-ascii?Q?6jvFx6/7sGS2tVBXy00Rph1Edn7QXSW2dcVPTHP1ZgHNPwx/Aao9Fra9xY5g?=
 =?us-ascii?Q?rsD4/C9XO/kazFfI8axp6PlHKaaF9TcFjHP641GmB6duWQhLn1HGDpYe0Dw8?=
 =?us-ascii?Q?jNTxDG3zH1OBYORhHigMZx4/y7bPZhqALsQm3Y5nq+fuOrp0m8usLUruYBv9?=
 =?us-ascii?Q?qqCxJDHgCX7fJnoXMKRxxK3oyqfjMDFuEKkKu3Yz0NAzbWc+ooAtrzgnYK82?=
 =?us-ascii?Q?JUlHHDd/jMG6yRt+kq9DCZMYuvSaOeCqTilM3u+tj90Jw+6o8xhsANHr70wG?=
 =?us-ascii?Q?aVzDAK/tP8P8UHTMEoDwt93sOhXAww4/QOENl+JWbX5cvh2hh1yXPHwcnZha?=
 =?us-ascii?Q?rjhpWWt4dbSE0abKfhWJC7aLdnnrQTreo6bkJk1/2iTo4GVR7Haux9Ihi4sX?=
 =?us-ascii?Q?RbTC2m/GL5uESg+/RsQBPC45hLoRaL8cZH+0dJUopTVT+J2EcJ5Q6uMGjr3d?=
 =?us-ascii?Q?cEEMjpCqraHOtpQ2/on7qZsm/oeJIEN+WYu7ZNf+o3O//oQSXH3mb7789AqF?=
 =?us-ascii?Q?fN6xUKxlgkM6XWDOJePp4eJVCPY6qHBGVxK/xeiDyfda8bRJDd0NCr4vxWDZ?=
 =?us-ascii?Q?81qU7DPYms96kn5FA+RNziu6rl6loaYFQYnWzAGm1aK5bCNnVyTPb2bdWWlm?=
 =?us-ascii?Q?M9gQT0tBzuO7ONhich17gYjYlrwnshzLMRd+7dcFhUvzhuKnpLQaXBcZ3owN?=
 =?us-ascii?Q?QHtkLDA1MU+UPAoSsNdtgcblwHTmh0pGiE9QgI9LoFDwqNkv8i1p15B4ijxB?=
 =?us-ascii?Q?J9MRGYhXm9xLVBNSe1WlybHktiv1qu0/vdawhM16us76P3wHvzXk4NGg2cnw?=
 =?us-ascii?Q?ufYm+s5XNie0jQX9ftOGzi6m+txsowe4IDiglj5+Ymq+TM49zu53OJzdzLnb?=
 =?us-ascii?Q?Eq3UnS8FlA2Z9U4GvkczJCsphk8NClJaAWHIvgMpV1/gUwHWREtJbKq9FStk?=
 =?us-ascii?Q?YYr9FRRVgkOcHY7JzvsEdRJb7vdWK0vufb/6glVNBEaIzeEPSQVCr09O3EOR?=
 =?us-ascii?Q?eM1sPBuWpASTVkQySbAYot0gpxQwp3U+zOiY8XIzWqZ3jRWTpjx3qrlXAnYE?=
 =?us-ascii?Q?/99yfzskOmpMYoZY54i4CMVrhHKXM5OL7oKrh4ZqRpaeXtxKJmbZRUA9F++K?=
 =?us-ascii?Q?MoR9CX0JM+cLLe2TjoS81fnNmbLmexg5/5n8LMF3s++p4bNACuUmU0RCWbEF?=
 =?us-ascii?Q?Jh7ELCAATSFLK81vEzsyokGxq7gmHwGSR+x/ADuD+qM3cFPmnUD1SHX1BZj5?=
 =?us-ascii?Q?jQpgIDKWYpH+VFrrPcY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a90c79-f50e-488c-8186-08dc7a8027df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:56:42.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR6eNDP8OqqkSxxpzsYCCQe4zQmoCucJ7J8Bb7+MXjXBrl6kXAqarnAdEEFyl+BL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On Wed, May 22, 2024 at 03:37:57PM +0100, Joao Martins wrote:
 
> This is just to catch the case where IOMMUFD can call into read_and_clear()
> without dirty tracking enabled and without a bitmap structure to clear dirty
> bits -- in order to ensure a clean PTE data snapshot after start(). 

Is that broken then?

iopt_clear_dirty_data() sets the NULL:

	iommu_dirty_bitmap_init(&dirty, NULL, &gather);
		ret = ops->read_and_clear_dirty(domain, iopt_area_iova(area),
						iopt_area_length(area), 0,
						&dirty);

But AMD, for instance, does nothing:

	spin_lock_irqsave(&pdomain->lock, lflags);
	if (!pdomain->dirty_tracking && dirty->bitmap) {
		spin_unlock_irqrestore(&pdomain->lock, lflags);
		return -EINVAL;
	}
	spin_unlock_irqrestore(&pdomain->lock, lflags);

	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);

It certainly didn't clear the IOPTEs.

AFAIK the NULL should be ignored here:

static inline void iommu_dirty_bitmap_record(struct iommu_dirty_bitmap *dirty,
					     unsigned long iova,
					     unsigned long length)
{
	if (dirty->bitmap)
		iova_bitmap_set(dirty->bitmap, iova, length);

Not above. That looks like a bug. Yes?

Thanks,
Jason
