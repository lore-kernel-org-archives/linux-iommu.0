Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34EFC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A8C660FB4;
	Thu,  7 Apr 2022 08:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w7H52MH7zVdI; Thu,  7 Apr 2022 08:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 033AC60F74;
	Thu,  7 Apr 2022 08:10:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C451BC001D;
	Thu,  7 Apr 2022 08:10:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47842C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 232E240570
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFv56x_vzsNr for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:10:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EB6D400CC
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649319024; x=1680855024;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=P+nNdygdIRGXe/DwSPiAhspRxOSr/dGNwH0mpWGcZ/M=;
 b=WY0w1YlVscHKnwsJ84ZzEi7Q8h4rOLCSnLZiBNd1bMp/3Jvz+QNS58c6
 /Ysmw3L3DjrgKJiSmPK9V107TVbNpiU0xDHytkyXD+ScrQkZS84eAyU1t
 fyR/EtNG2npv0Y59eNMCO8i8ygGVdIkXCVhS3PdGdBI8+4GMYSfZUbwdV
 ikeEYWcbPoEF9UIhmERMKVlcIHzwgMuy+zgxvU+POiFGYi78NRUE14E1B
 UfL/iSHbHPnO8TMSu07DaKRpTl9Ko8O27uQyCVYnt50qEXPbuBKOPcfPl
 EgiOA5uQQYm/Dd6jy2kahQDfIAMsUBVTy20+eGkGgqucKib1pJsFYDtl9 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324422321"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="324422321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2022 01:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="524274279"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga002.jf.intel.com with ESMTP; 07 Apr 2022 01:10:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 01:10:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Apr 2022 01:10:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Apr 2022 01:10:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYWwQ3E4xDEftfKHEGkDNkGRsbQc3QYLONJfJ4ICLBG/nSrlE7Lu7V7tp55s74G1FRwWaWbqID781rPkE2X7+yhZ2fBn0/8DEcxEIL0GTYrJrn3qqueKle+9qIogZ8Q0uKvTDNN2p4ibvkQKN9qyo4OckTWAfNLhJlyp71LAiJ4HAx0coCcrKUAIMiL9zNjgQNAcdnC9x6wp01cKRz9g6BOyDt8Bs1dloJ41UIp/aBoq4hVC4cqEC/Id5ZVJuJcGxgOxO4t59IhsH2KP0pVB/QnYd5Czf2ftH2jM5kuAQJ7QB7UJkKKLCaYVvkmOHpHUqk0SPQzFCDzjGaBstKA2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPGuqF1/8PYxnrxbvzDU1bx26bK+3OeHpxYKwd1EnAQ=;
 b=h5qJeAWf87joYiF+FY/6531olcZLf4UMsykww8nSLx+/wQZ+tNHzlm7vP729CwsV6/q7ognL7pZD3VxEX8NK+PE7PBbNRHpMjaE/gOuLK7Fdxs+RZeb6Wq3N4BzCBdHpmriqukEvovcb+R+UrDfxxlIPVqfSpkEvz5a4m3Ndoy5AXvYzOqhLpw7mw/PrLoCTL5RAurZp7RUP9W5ci04zOHv1sN7LbYrMw//CNqEZYpV57mEeUwzGaNNrUb5eEjRvMLb7VU+o9LaM06n89zkewxm5XP2nCFiQZjprmliJ4peB437N/xQm2gv6NWMLwVghqtjT2/8OvsOsiVvbAySS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5723.namprd11.prod.outlook.com (2603:10b6:610:100::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 08:10:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 08:10:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Sven Peter
 <sven@svenpeter.dev>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 4/4] iommu/arm-smmu-v3: cleanup arm_smmu_dev_{enable,
 disable}_feature
Thread-Topic: [PATCH 4/4] iommu/arm-smmu-v3: cleanup arm_smmu_dev_{enable,
 disable}_feature
Thread-Index: AQHYSkh2WYzCqWP5tEeHING/mPzbu6zkGJiw
Date: Thu, 7 Apr 2022 08:10:21 +0000
Message-ID: <BN9PR11MB52767C5F13BCBCF91D53691C8CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220407062608.711392-1-hch@lst.de>
 <20220407062608.711392-5-hch@lst.de>
In-Reply-To: <20220407062608.711392-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dec08c2a-a57b-4fa8-7a10-08da186e0fa3
x-ms-traffictypediagnostic: CH0PR11MB5723:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5723C525922A8FC89C9A5A828CE69@CH0PR11MB5723.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CxifhEOfzH5uY2HXKT5LWufpkOduDVuyq0tJsVJ3swd620py/QjzNtoJCNBDaDx57d/N0O/iJ9/PdpuOzIXNViG+7zAsEjN1zFjyw0KVnGboGvG0HgsURnPlTIvMD1L5Ez19Y5Anl+A0hlBO3/IFd6QIZ8KYMKULsqcRzV3bY16VbJOt7RjBxbG7d5gQzc2tGRe/cF2OogLne6MjQ4mAyI80rrMT9FX8lYQqwBBnCezpPFtbhl4K5ePe3NQjQfcFTO4ybFNbil9i4cHgeMG3motWYhhptpT/lgentcTDElTqNQQClSfKsDaQyCXM8wvZr7fcfwYtCAvMVPShpQb4iHRseDSRcr/yljDRM0Fk7gFiLVi/PvQTiA3EB7eFfbMgK7ZkxgQTVATtxinkTnAY6Fvw0pBliLzQ7heF4DcB6OZ+XEhS7jdu8WC7scyAR/SKa62qs4zKTlp/aY2WCVlVksrEvnFoLR/WPJwR2WOqEWJwhNxmvBQ0wTPCLhn008SJrPOIcuC5Avu96/oev97ChQxBS40O00DxcHM+a2SKl5rDJlBW6eNjK0fS760xAHRYeq1gvF+aJov7oMFa6QFbIM2W3CxiSJGxoRcmX9sU5rvEhEoWlueQnDR1SPiqWMvvlq9t/JRRxL5AGo7Hu3e//gYwIjJSNycXU6b+bx2N05xCTDtAr5veeK8ELVEn7ZzS1P4u4vb0oEJ9YmZgbN9sSji9XUenhZ2aIlT1QKtsn4l4otr4YUj/Qd3KTxECyAET4+4dPgfnva8c1HiwcfFURqfT03TwnPfC7qyVSEKzDE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(64756008)(122000001)(38070700005)(83380400001)(82960400001)(66556008)(110136005)(33656002)(66446008)(76116006)(86362001)(66476007)(8676002)(38100700002)(66946007)(55016003)(52536014)(9686003)(5660300002)(2906002)(8936002)(71200400001)(6506007)(7696005)(186003)(26005)(316002)(508600001)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbW4SCzEJ+x4DML4ypFpzHqjTMEnWftv3vOaJBVJXaQw0ZJ6HZWmem1anBjL?=
 =?us-ascii?Q?UOMqSyu6RGUl6a/cDP8dYCPOu3saR7t64kzBJaGJ5zKlFnPJHWHxsGFf45nW?=
 =?us-ascii?Q?2Hp+EKrv7BY0GA4sl2xradPWpq0BACkt8glrsmsJFCTD3zyUEzZGUVn793Ij?=
 =?us-ascii?Q?y3EJ5/uKpk0CciIXtss9eWyPrDhYfIIAVmd5c/CuaxNp2OpVb9qV9ezIawEm?=
 =?us-ascii?Q?pQgxlqIpM78IVtjDCcj/QOJWcN0Fr/uef7BCzXsi3F4BwcdS2OsrGIJ48VPB?=
 =?us-ascii?Q?kQhovlUKzN4ctZJo3h5MokIhGIlF0ZU7KGKYI4X0Z+T7YM5ljTolfpx4fgz/?=
 =?us-ascii?Q?V84JgcdLBQVoA8qpDmpkczDtiKWkTngFjpq/LZGBp5jxnbuv4Hlvynu4jvus?=
 =?us-ascii?Q?3s3Bh6LGIXb11YXdrLK1pf+aNKMtonEKPsXgtibtNh1hs1ojPsdauEyigLwm?=
 =?us-ascii?Q?GiajHHYIqexObISZjFDMnYXLjc9PdqVEgafHH8FJgDJWE5ktPv0y4E4kU4eI?=
 =?us-ascii?Q?q+AKKld79U1W1GvCghrnDDbqQ6RS0D75yQD9JIePpXFkpiXhiJJMxU0zcMaB?=
 =?us-ascii?Q?oDthXmjBwuqyENI/Vxb88XwHTTEGFex8v1KdtvdetzH9fM/cAZEeLn6lkEX8?=
 =?us-ascii?Q?+tpi+UzafAOYM10Mu1AYSBG5TApNXYkPY6SF7/rZkE54Cg6zQJxJ38gzdbOV?=
 =?us-ascii?Q?/Kji6sX3uAK9ls7/onRTjVHMyrdHKuaZ98dQDE2Isn8hhLg+kP2Gq9f5exF2?=
 =?us-ascii?Q?ea+Y8me7JZUTNjU0WY7sjHhx+7PJ9L1C8odkwuVkaW0P0/6sxZv2xUhqUXBr?=
 =?us-ascii?Q?CZy9yTjeOlL2UWzl/hD5VHSHAFafL5LOJ+9pq/sLfh2vXEGxEw2TtHCiNB9A?=
 =?us-ascii?Q?17O20pz24jq3KLQ14Fkuk24KdU1i5DGymgQ9QxzFa32AV1+6bOubqz0Uy9si?=
 =?us-ascii?Q?AlaATd+NIDQmVYKV3b6ZXSf7b+EEFiOk5VaAk/OSeFK4Ba8KefYOnyFCl14J?=
 =?us-ascii?Q?uV80uZnxxDBdMx8mqcgmjC3HdqCCZtJfGLu2pTozevdVNVmU5A7nrdQVibK9?=
 =?us-ascii?Q?OsiJeNYpxLmW5q2p+FXTONrHW7KGSCmIGp4gmshE56sLXXM7jSs1gtLlmQ2n?=
 =?us-ascii?Q?M81zQmT9Kz2L32cbkvGiqcFPejw8F6rOmEEAoxhy9PDUtMb/y9//IBB1BtNi?=
 =?us-ascii?Q?u1M6wSQNluhkwL3XfQK6jqNB80cAutaIMUhbQf8quD2TUQ371+TQ4gwqCOTG?=
 =?us-ascii?Q?tAfatRO87MUPvWC+g0w/qHDEBz3SLb7qo6SVHSk0jY35nvve/fobwH9MeHb6?=
 =?us-ascii?Q?78vwtVFjSHz+0Rh+ZebrMowjzFkad1GIEcbVEVYExne/dWe1t63GHqmgICkF?=
 =?us-ascii?Q?F4AL82/i+U0bEYfGWJto/aLpBLZszfmsNjNWHh3/R7QsolUOglylkIHO4XJp?=
 =?us-ascii?Q?y0A0pxL+/Zt0nBm3mZhu6YXtwk1FuHbrE3dMJtd6BsxTNUo+HAG8RJnA9lgC?=
 =?us-ascii?Q?cMMEdoGELmYwht6HIFV4LB97zoMW3krXg8hgMOmICHjwRKrB68spOVBm+eSa?=
 =?us-ascii?Q?Fd00zLwpVo3+ZPvGTSICdABmHYx8zd7HeKzeDGR+cuEaiJkxMCDjcpZTt/6K?=
 =?us-ascii?Q?ORJWk0hSW1j2gS1rVJNvqfWV1CuuymTDJxoPI4MW/0aDmvGSK8SuQDJpWC42?=
 =?us-ascii?Q?eXRaWnAND4MWm/RI9bzIuXSSkriBdObstPgssxvwtzQd/w73QG6uBwnwrfye?=
 =?us-ascii?Q?y4GC98I4ew=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec08c2a-a57b-4fa8-7a10-08da186e0fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 08:10:21.3094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GwnbvYayaKyJ8DS7L76Y+MmhQUo0s3mEkrViBH6IN+tFmBzO9aIN3mu9Rsihupv0cAn+jshszVPHYN3eTqeBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5723
X-OriginatorOrg: intel.com
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

> From: Christoph Hellwig
> Sent: Thursday, April 7, 2022 2:26 PM
> 
> Fold the arm_smmu_dev_has_feature arm_smmu_dev_feature_enabled
> into
> the main methods.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 ++++++---------------
>  1 file changed, 15 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1ea184bbf750a6..8e201c660139ae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2760,58 +2760,27 @@ static void arm_smmu_get_resv_regions(struct
> device *dev,
>  	iommu_dma_get_resv_regions(dev, head);
>  }
> 
> -static bool arm_smmu_dev_has_feature(struct device *dev,
> -				     enum iommu_dev_features feat)
> -{
> -	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -
> -	if (!master)
> -		return false;
> -
> -	switch (feat) {
> -	case IOMMU_DEV_FEAT_IOPF:
> -		return arm_smmu_master_iopf_supported(master);
> -	case IOMMU_DEV_FEAT_SVA:
> -		return arm_smmu_master_sva_supported(master);
> -	default:
> -		return false;
> -	}
> -}
> -
> -static bool arm_smmu_dev_feature_enabled(struct device *dev,
> -					 enum iommu_dev_features feat)
> -{
> -	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -
> -	if (!master)
> -		return false;
> -
> -	switch (feat) {
> -	case IOMMU_DEV_FEAT_IOPF:
> -		return master->iopf_enabled;
> -	case IOMMU_DEV_FEAT_SVA:
> -		return arm_smmu_master_sva_enabled(master);
> -	default:
> -		return false;
> -	}
> -}
> -
>  static int arm_smmu_dev_enable_feature(struct device *dev,
>  				       enum iommu_dev_features feat)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> 
> -	if (!arm_smmu_dev_has_feature(dev, feat))
> -		return -ENODEV;
> -
> -	if (arm_smmu_dev_feature_enabled(dev, feat))
> -		return -EBUSY;
> +	if (!master)
> +		return -EINVAL;

Old logic returns -ENODEV but it's changed to -EINVAL here. Is it
intended? If yes, probably mention it in the patch description though
just a small semantics change.

> 
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> +		if (!arm_smmu_master_iopf_supported(master))
> +			return -EINVAL;
> +		if (master->iopf_enabled)
> +			return -EBUSY;
>  		master->iopf_enabled = true;
>  		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> +		if (!arm_smmu_master_sva_supported(master))
> +			return -EINVAL;
> +		if (arm_smmu_master_sva_enabled(master))
> +			return -EBUSY;
>  		return arm_smmu_master_enable_sva(master);
>  	default:
>  		return -EINVAL;
> @@ -2823,16 +2792,20 @@ static int
> arm_smmu_dev_disable_feature(struct device *dev,
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> 
> -	if (!arm_smmu_dev_feature_enabled(dev, feat))
> +	if (!master)
>  		return -EINVAL;
> 
>  	switch (feat) {
>  	case IOMMU_DEV_FEAT_IOPF:
> +		if (!master->iopf_enabled)
> +			return -EINVAL;
>  		if (master->sva_enabled)
>  			return -EBUSY;
>  		master->iopf_enabled = false;
>  		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> +		if (!arm_smmu_master_sva_enabled(master))
> +			return -EINVAL;
>  		return arm_smmu_master_disable_sva(master);
>  	default:
>  		return -EINVAL;
> --
> 2.30.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
