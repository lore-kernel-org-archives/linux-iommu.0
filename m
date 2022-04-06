Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BBC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 09:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21679417B6;
	Wed,  6 Apr 2022 09:27:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vvk9TaCKpGxg; Wed,  6 Apr 2022 09:27:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADE85408F3;
	Wed,  6 Apr 2022 09:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A40DC001D;
	Wed,  6 Apr 2022 09:27:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADAEEC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 09:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BEDE4151E
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 09:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2CNR-M5IkB-w for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 09:27:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F089408F3
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1t0nEOQkwLs7xW6ArjE7M/kMg+2GkTmYLzd2EW91/U=;
 b=2dzGAq/X5FaPqcRSkRFGfhHxBA1e9Wxd77y7O1J6XWfbF3fyu48pzvwYcTivncWbIham52Y6R2hs7UaojrqNUmwX2Azxx7kEL/zyzHnMqJP1yDm04AmN90+MeKCE/JZW+y/d83Z7aRGDocF+oqvbD7pSGheWO5aQpnM7XpyAj3U=
Received: from AS8PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:20b:311::7)
 by PA4PR08MB6176.eurprd08.prod.outlook.com (2603:10a6:102:ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:27:16 +0000
Received: from VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::66) by AS8PR05CA0002.outlook.office365.com
 (2603:10a6:20b:311::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Wed, 6 Apr 2022 09:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT018.mail.protection.outlook.com (10.152.18.135) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 6 Apr 2022 09:27:14 +0000
Received: ("Tessian outbound 2d401af10eb3:v118");
 Wed, 06 Apr 2022 09:27:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2121cf8f3e36a0a9
X-CR-MTA-TID: 64aa7808
Received: from d2c5bf162a18.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 8CBC6821-1B77-48C6-9AE6-51E68C370A4B.1; 
 Wed, 06 Apr 2022 09:27:04 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d2c5bf162a18.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 06 Apr 2022 09:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8SmK37msD1zbNWI1a1raSA2LltAxZwRodx5UsyyU8KQsyEE4wITWP0lv5/dOAnTs8Q/NHA92ntWf2ntR/P6SIM3YuGspiyv9Zp+fwViiuWuG5/lqFRDHzrLb2ZkttiWruLt8tLst5dKZvZOeNI3lJkrzI99tDF8Q9/k1aF77nib52D/oYrvUoDJb2aErv+F2SQ6F2/CqiwDOezg5UEttdw3LNVaPqTbGMVRgIO9Em6Z1fOpKjMWaDCLLKG6NcLzv+gs/5iB0RffHo2wyxG6oQ0+0myLNXI/xfnyfjGGlImSf+hgQHoNfu2YcRFsnPHGaaqzdDDf+38i+8ZeCkIF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1t0nEOQkwLs7xW6ArjE7M/kMg+2GkTmYLzd2EW91/U=;
 b=QgXXNhXQ7cM4FDPRA9vJNKOXXUb/J4JilwFoRPgB56A63de4FHKhD6QPHWi89LhrcDqRLCPLaBKgrGXxQ3FyDWR3FDfqOcts8GdiqaO3/uFTXXapdxGAME/tBWI46VGagc7fB8+9EUtDDyu7t7CPy3XgvHWr8CsnX8mWFtI6M9r/g0tH/OLJ6RDTTSOyq9CmZ7tX+tEyM77rKE2c+KGpPnKujUIUJoZrWntg7wrRSBSgkHlm4GMreLHSrfr/fbVVAKPT42WNLSLfFeb433xA4MW1R6d+LGLvg45w3FMhoT2HqCKiKANiy6dyFmx8V8PQD2azycerkvplAqobkOIZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1t0nEOQkwLs7xW6ArjE7M/kMg+2GkTmYLzd2EW91/U=;
 b=2dzGAq/X5FaPqcRSkRFGfhHxBA1e9Wxd77y7O1J6XWfbF3fyu48pzvwYcTivncWbIham52Y6R2hs7UaojrqNUmwX2Azxx7kEL/zyzHnMqJP1yDm04AmN90+MeKCE/JZW+y/d83Z7aRGDocF+oqvbD7pSGheWO5aQpnM7XpyAj3U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com (2603:10a6:10:2a2::15)
 by VE1PR08MB5789.eurprd08.prod.outlook.com (2603:10a6:800:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:27:01 +0000
Received: from DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::7d18:6735:d37c:23c4]) by DB9PR08MB6812.eurprd08.prod.outlook.com
 ([fe80::7d18:6735:d37c:23c4%8]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:27:01 +0000
Date: Wed, 6 Apr 2022 10:27:00 +0100
From: Brian Starkey <brian.starkey@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] drm/arm/malidp: Stop using iommu_present()
Message-ID: <20220406092700.t7o7ujk4eqn7ckgr@000377403353>
References: <5049994e6c2ba92c2f30d51850c8929136d0f8ca.1649167878.git.robin.murphy@arm.com>
Content-Disposition: inline
In-Reply-To: <5049994e6c2ba92c2f30d51850c8929136d0f8ca.1649167878.git.robin.murphy@arm.com>
X-ClientProxiedBy: LNXP265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::19) To DB9PR08MB6812.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::15)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 44db7e11-aaa1-4c2a-c72b-08da17afa32c
X-MS-TrafficTypeDiagnostic: VE1PR08MB5789:EE_|VE1EUR03FT018:EE_|PA4PR08MB6176:EE_
X-Microsoft-Antispam-PRVS: <PA4PR08MB617636543DB85DBE3A9776B0F0E79@PA4PR08MB6176.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rEjoPHpObQAzMcadS1OY3D4pBS8hnfT80z+In3PhGOVm0KFIFcIF48zlUiupPVQN30pLCk8WkUnDh428l3T8TcXjhrTIx+PUwnJbl6J1TA/RxCaqklKnfoWu+9t3O8aCul676zTwlinQcZWnHfNbGsAqpZOpCpP8RfL6Z1LwhqjiP/0rkVe/k7l6rMjck4aH+6AK4jS8T3PsIrGHaSUpGVJTEXxk3l11pO0+psDFOOlm6A9R+puBreInG8lwYfG0obGmEyawE0tbKyuWOgtIths8KsjLq6YIp+6yE/luKY9kZKB9JLxFGo+BN5ToK/pDL37YcuFs0pZfxfpUzO9WJfrfbqsszR5HbiMzpFYXiaZffcbWTDKxJE6rP92OYrhPeaSjDaTz/4KuIlOzdW89Rqv58l9ZdkqyCTUGqp8ubOhFHyaVEmWfJiL9vMMKY8APb6Sdkt++la+xaci2M5v8Pj7oxl+MM2phz4CR4ioZUb5eNoAofudBqJ6t52WOXMJEQPicp22a2937BsRasyxFqXu+QFkSAw10rTti8eYAU6IiKTOGwnctzJQg93+NHEDeTjyVwzGBQViyB9+1V3FU7UtSMTZNzkCsPJ2K5JGwWIIyuX6fBlTItiDJj2WEcoF2ypl79HcxgHIF6plfySdS6A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR08MB6812.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(1076003)(83380400001)(2906002)(86362001)(186003)(26005)(44832011)(33716001)(6486002)(6636002)(6506007)(38100700002)(9686003)(5660300002)(8936002)(508600001)(6512007)(66946007)(316002)(6862004)(66556008)(4326008)(66476007)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5789
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 858a0126-0d02-472c-567f-08da17af9a77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhK6Zk8Ajv8d4ZOjNCzd0WsFsf81+Hu6pqRYMOxnaSyoLs6kstHeOrsQhDsF6sSRcDasrp7CQH3S0Qy0c2iOH/xhUqcGb/Yy50gdGI7OW1VM49KI6j7JOp9N5Xzq0B6QWv3lKCleQpBn84T6GLepa3GbveO+ls8kdtjdtM2BTlOr+zns/DrgEGbkwMKPz05v3sPpqSgZS96A1YDx6+QiR4HA5du718epJiDr4NER/Mma57l6l7xSeUF+Q/nT7ZTtL8GHttVv6QpcUoxe2h1aySocFCEh7DXg67H3SKXXZbOJA8q8wZMj80U26A1alJsNEpAt7n5URYcL4r7lYc7+RXMyd1s1v+IeZKvUHPKEocg/+NmeTLkq13GvyoDuYUMyBVci+FdaIhkWO1or7vxkTZOJTGiLTQ2IQjAWI/kV3sCB7wmylpN3vFbsIlXkdUSWYspVCGPKJF33SKnfWyRKpQI/4XguGHi5IldsKheB17dVI/FwC9X4dH/W0hX9ENlcEp2fh3wuC03xmgpGthMwpdTLXrmHwyqr1pP45WAejigGY3bVn2IMoHXm1HKO+MamIcsKbUaMuYAdXSryoavgyeLs4s9fILBRvcua1Cur7bJTsOlgday3L+IXnyb4xbPkWg/0aT9Ah7/luF+1XKupzsQ/4+TOixTKTapszRvIniZoeYTrmVD5FJq1dG0j1AC3
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(36840700001)(40470700004)(46966006)(47076005)(82310400005)(70586007)(6506007)(70206006)(33716001)(36860700001)(9686003)(6862004)(4326008)(8676002)(5660300002)(40460700003)(6512007)(86362001)(26005)(186003)(336012)(508600001)(316002)(6636002)(1076003)(83380400001)(8936002)(2906002)(356005)(81166007)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:27:14.9589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44db7e11-aaa1-4c2a-c72b-08da17afa32c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6176
Cc: iommu@lists.linux-foundation.org, nd@arm.com, liviu.dudau@arm.com,
 dri-devel@lists.freedesktop.org
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

Hi Robin,

On Tue, Apr 05, 2022 at 03:11:18PM +0100, Robin Murphy wrote:
> iommu_get_domain_for_dev() is already perfectly happy to return NULL
> if the given device has no IOMMU. Drop the unnecessary check.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

LGTM, Acked-by: Brian Starkey <brian.starkey@arm.com>

I'll have to leave it to Liviu to push though.

Thanks,
-Brian

> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 0562bdaac00c..81d9f5004025 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -310,17 +310,13 @@ static int malidp_se_check_scaling(struct malidp_plane *mp,
>  
>  static u32 malidp_get_pgsize_bitmap(struct malidp_plane *mp)
>  {
> -	u32 pgsize_bitmap = 0;
> +	struct iommu_domain *mmu_dom;
>  
> -	if (iommu_present(&platform_bus_type)) {
> -		struct iommu_domain *mmu_dom =
> -			iommu_get_domain_for_dev(mp->base.dev->dev);
> +	mmu_dom = iommu_get_domain_for_dev(mp->base.dev->dev);
> +	if (mmu_dom)
> +		return mmu_dom->pgsize_bitmap;
>  
> -		if (mmu_dom)
> -			pgsize_bitmap = mmu_dom->pgsize_bitmap;
> -	}
> -
> -	return pgsize_bitmap;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.28.0.dirty
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
