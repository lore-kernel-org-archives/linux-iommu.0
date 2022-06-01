Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4243C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 09:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76E2860D67;
	Wed,  1 Jun 2022 09:06:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YKurHmskqEB; Wed,  1 Jun 2022 09:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4AF8160B17;
	Wed,  1 Jun 2022 09:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15CB0C0039;
	Wed,  1 Jun 2022 09:06:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09D4BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD64F4170B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgJqMg38gzhp for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 09:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E65434010C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654074361; x=1685610361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rN83y5xBBi95ajAlgbNKOlQi7kU3UVbwnrb+pPCUC2U=;
 b=L02PbEA6CDXuw7b1pIsVcqgpOP8Cjru9TYq2WvU9xUXTr77ogfCLk4m7
 BI3e7LeGXyEuitt3Rouk/ULEU5Blr8mvOEbb28qR5HZyQc0OV+k5ZqXAD
 WSVcW/9smVLRL45ibPuMdRTeHEQaY/WWEHJdnHWoLF8UTXZ3ByV8hgvi7
 cXi1D1U2HmCl5JQXhU9iVrzRQGwXiqS/gd9Vwhpldzsnzj/jkRFZS9Pxt
 gcrIMKRjyuFoSSROt4qIlTgr6Q/mXQi4+0eKu7n24EJ2gFiBvEs8Sh4r0
 Iw9qUv1GoNAwOtYoG1zP3Hy/Z2zDhEzeJHfqyLcDJOK5aE+V9YWJK0SsH Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="256002910"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="256002910"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 02:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="667335271"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2022 02:06:01 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 02:06:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 02:06:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 02:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKdmPmx0RZChsMm4IYzszgNUDQgnKvu0D9KJTy7O2dmuJmjmLftAnCkH0mU6UVfUwo5hvv3xDfp/jjaiwGISdi62f6LyhWph5AJTpDK2qumMpCN+dzHBF2v/I/cJf2Co2lLUAZWxAclFzDl8gLg4q3yPIAUeAQ/rS3Chxp8Dg3GoRSaADGFbfMFDkk/4tpe6KUbbOHvjPLjIGvnnEgd+Ic922Y3IYulVMXrJus08XelQHh+IAOg+bCjWkyNXgLAW985AQViyN2PAcWKm6CilDyXQzAoAhDkB/Mhlp3ELtZzQ92kWdP4MoXFYUNezVnfcSE/EKhypUAKY5RXVYd1hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vojDloLD9lbvW0XOSFXyvETo7Zj1YA6WpdtTlTnuQk4=;
 b=I8hPxfDklHaDimiY6Lt/CXIF9H1NY1tfWuMYQhp+wtBg3pBZepgsdWYR9G0dxZm+B0CG2wSzR0wd7u6RosqDfR8qyr7dpxSKJAewt3i6b1tBA/Uylh2LQzYrPqJPzmH5XtqmPLWTZOEmmfmeBUV2RXLB66Oaunm9xZvL5Jq06u+3Y47v6kGNF5adfA1ETNYPaaCsxhfI/UlqdowPIkZVNmauDAx8rcMxFP1ha5M+trNY31nXt7eZwMpiGtsqCpn2mAaRIwEoWDQKNpzI4ONX8zAhUxvRwuBELQ2Wx33nErZdPXZmahD5u78cuEA6jl9YuwBbJKBBjx1ufH4vZol7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1906.namprd11.prod.outlook.com (2603:10b6:404:104::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Wed, 1 Jun
 2022 09:05:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 09:05:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Raj, 
 Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 05/12] iommu/vt-d: Unncessary spinlock for root table
 alloc and free
Thread-Topic: [PATCH 05/12] iommu/vt-d: Unncessary spinlock for root table
 alloc and free
Thread-Index: AQHYcZPPqws0X/Y6fEqfaLcMyO/Xsa06R9yg
Date: Wed, 1 Jun 2022 09:05:57 +0000
Message-ID: <BN9PR11MB5276A6983A18E4D0539133678CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-6-baolu.lu@linux.intel.com>
In-Reply-To: <20220527063019.3112905-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e37138bf-1c4c-4377-4a1b-08da43adf0e4
x-ms-traffictypediagnostic: BN6PR11MB1906:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1906859CCEDC7200D4F1C5468CDF9@BN6PR11MB1906.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTgkNxbUIwLxXO7z9kBYk96jE6/XvzEvUsOcJMRfSccaGqxil6501UbjDE68SC3DDkgCJWXP1G30PvFO/ZF2TDpSGHkt4qlHMo5G55nXWrufHuMCDIquNXovfFKkeHIIybWuU+oTNCSoBAVrsOxEP66rN7CWwDfNjaFUFga3yW82CMF5GOvjQQ7outDm4TUMhVA0QYze3fbP7lRESpQmvk3yNj1xKyw3wTEINcTaVE4O3RBPUySw1gulh2QyLPpNGKWKfKyvnESZQTpbgTxKusI6Af5GyFxQw2qwJubqaBH2mRxddfjZpKkWbwJ9t1M4L2Qjmx59e4Vd/8YllObcL7FzAYZSqXvnLtiOdni0bPLZIVjs/3rtwjm9rvVbgk99VlPYvAt2Yak/I6qv+APRaOejdbkomevqguVMpWbFs7JIa9fOBcUpioy++ugNbCedlbsYawCrEq7sVTVOiKAiWqFN43QSxQyl2VuiZ/cqhtk9+qGX0Atm5/ecAvThCoMchBRm40B4nZ/yciCgh+jpqhud1ooEeV8xSTIYw6+AP40fNyK6wBvCHj74GytpGMLVa8d+3dQ07sC1osI5CQpTcv5eY5XKjrbFa34jlf7CqWt98JDYvWqJ+/8jOwXKN8QD1eEveJLSxbqKHtc5t75ureTTYZ2qpimud9U1DKYwcz2sutpW1l+WT33KVHEcdka9aqPQNtnoDx2qPNW7FpaZtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8676002)(38070700005)(508600001)(66556008)(26005)(7696005)(86362001)(4326008)(76116006)(6506007)(9686003)(316002)(5660300002)(71200400001)(64756008)(83380400001)(66446008)(33656002)(122000001)(52536014)(54906003)(110136005)(66476007)(186003)(2906002)(8936002)(38100700002)(66946007)(55016003)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8J5TgwayJuy4LdZtR7a6D4kuNt7xreMRO8I4Cv6OYT4qrt1EBaBcNJt5mp9r?=
 =?us-ascii?Q?fXhOVbVDCSamYVaQVvk5paaeWHkFelXyM7qw3IKpyRWir22pPgMqR+tgZEaE?=
 =?us-ascii?Q?UxU2L4ZhnRb7Ru/XZxbYHx7TMM5SNtEcLfXNDllKW1HjXbkmFRYeTVtOtAw4?=
 =?us-ascii?Q?nyh0Oygfo8W/daymhoBqOuLms/Dmb7Wey6vtlu9feZhgbYa/4gkIC4WzV+qO?=
 =?us-ascii?Q?/NzGJ2W+NnQcZvTLGO8nmje6VBIRYiUHJt+VvdTzJD28jGUGLGgdaqQTPx8h?=
 =?us-ascii?Q?00Uyh5YKUGNy2nFV32jfshiFS2LZDSRUCofFSK7EtpV9TAVBR0yBSrYLDT1u?=
 =?us-ascii?Q?1hZ6JVZJojhkryi2Kk5x+UKJUNpmi8Wi6/68WF32IBLJ3xm3W/xVlpzd2oqb?=
 =?us-ascii?Q?7YsjIxPW5foavVPR+WpknhxWbfBJhCqfRlAS1eW3Q5IQbLHvYBBY5smbDjiF?=
 =?us-ascii?Q?pWQqv8mK1pm69ZY+mT7mnhr5Gn9DHLzmsB6IhNNjOwrS44CK/IUu0j+LSIhU?=
 =?us-ascii?Q?UEvI79jR/i1NlWZS/cc9/YuuHIEHLuhigObGXXgxeJ3rl+zUBRSIjNlxEX5i?=
 =?us-ascii?Q?qqqh7k6cwS/o0DNaqr3ay9l3Cg1Ky4riLct3K5mPc56NZmuj9a4yX47hUtzK?=
 =?us-ascii?Q?EKQfjlkm9Jd4Xb8xZlvx0eHqmELtZnRlKKKpnh2ZIz1tZPAy/i/zffWdlv9k?=
 =?us-ascii?Q?VzEt3J0ZXox5GZfyG89EU358CKNYjeDN9XhQFGGBEmHNAbcziK/tH5AwnqKR?=
 =?us-ascii?Q?fQ9f3XDiYLEBcrl8rHb5LPWpP02dpzgoqdCCRwWzjGJ/TLQr8FIawLgpWAVg?=
 =?us-ascii?Q?qPoyDtnuQExmVq/kmLuRIfboLqajBE1lq+sbsO+5BoHnO9JOVFVR7MHUdOaN?=
 =?us-ascii?Q?fYYgqNnqqgkP8KW2E9IPp7unYz9ad/PHqOX/JTnLgTCpPQGuivUOPvsIY84m?=
 =?us-ascii?Q?jawJ7D87bPSRCwYRMHJa+Fryc3A4+Krz7aXw4i4PF6wp1DzPEIMoq4J+YeuQ?=
 =?us-ascii?Q?D/qPmgxLN3MxSH77XH5PNIF8xL0j521ElEgJfcpZg31J8f8NLX90aio56tPx?=
 =?us-ascii?Q?+ElU9Sg+21y02LTDlSibtAk3RqZ/xYFtdfNswfGawQS6PlIQIppjJ9gGZ9fO?=
 =?us-ascii?Q?G4NUu8ECH6nYLegxi9bTBEkCvy7bkYEcHNS3rfdEoDi+uTxNA8yGeueDHen9?=
 =?us-ascii?Q?bh5/PwYd3I4Dy39xqMJyw/nmuuOr7+3fsmG34wTUu2RuSUXcUMIHWvK9uID1?=
 =?us-ascii?Q?iW2bEjsjV4JU0n6KzynTAesOtXBjCZXuVtNvjyCflk7zLLKP6XWsKh2zHBIr?=
 =?us-ascii?Q?1pcb77s18y6DjwkXhT9z3OIe2vD+XmSbBabLSjtXKVMOQQEXxS2Gmwvjn+vx?=
 =?us-ascii?Q?5pwIdjWhPGP+JXec5SbwOo9lBA9VlVF49VsLb2q2qDNrcpLidqfSJ5u9LloZ?=
 =?us-ascii?Q?mEQeaPZ6QF5ebsFuMdzzgoCYAx+exrEDK06WESnT7oldrSPuqopgVrmSIe2u?=
 =?us-ascii?Q?V2GYw+tHE968G231DfczY2tuxmtAR052HgKy3gH7nmsHNAdWeX2GB26Iq8PA?=
 =?us-ascii?Q?OXhVaMmo4bP3vGzYuMHnl6alFqXChcFZ86jtrCS8JbQrM3uM4dAVW09/sq7w?=
 =?us-ascii?Q?O/GrtbV6FNbT3X/NWaCDjlk50Gz2l/28cLUllYaU+/m9bUHh4nH+AcqqOyHB?=
 =?us-ascii?Q?63zZUa6WtDRtLrCNHGaQl5o9mDzB7tsTFQ5tyTenrREutgq6FLOZmvIETmng?=
 =?us-ascii?Q?L1ST4+aZ1g=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37138bf-1c4c-4377-4a1b-08da43adf0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 09:05:57.5930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTwUHxEs6vklpSzg+CzaGhvIiZdBKsPwHh2TUzrQL7/c4i2mBt5vQN/9cOq1V4CIybtKaGTc6LlokRkkHqVSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1906
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, May 27, 2022 2:30 PM
> 
> The IOMMU root table is allocated and freed in the IOMMU initialization
> code in static boot or hot-plug paths. There's no need for a spinlock.

s/hot-plug/hot-remove/

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index bbdd3417a1b1..2d5f02b85de8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -809,14 +809,12 @@ static int device_context_mapped(struct
> intel_iommu *iommu, u8 bus, u8 devfn)
> 
>  static void free_context_table(struct intel_iommu *iommu)
>  {
> -	int i;
> -	unsigned long flags;
>  	struct context_entry *context;
> +	int i;
> +
> +	if (!iommu->root_entry)
> +		return;
> 
> -	spin_lock_irqsave(&iommu->lock, flags);
> -	if (!iommu->root_entry) {
> -		goto out;
> -	}
>  	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>  		context = iommu_context_addr(iommu, i, 0, 0);
>  		if (context)
> @@ -828,12 +826,10 @@ static void free_context_table(struct intel_iommu
> *iommu)
>  		context = iommu_context_addr(iommu, i, 0x80, 0);
>  		if (context)
>  			free_pgtable_page(context);
> -
>  	}
> +
>  	free_pgtable_page(iommu->root_entry);
>  	iommu->root_entry = NULL;
> -out:
> -	spin_unlock_irqrestore(&iommu->lock, flags);
>  }
> 
>  #ifdef CONFIG_DMAR_DEBUG
> @@ -1232,7 +1228,6 @@ static void domain_unmap(struct dmar_domain
> *domain, unsigned long start_pfn,
>  static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>  {
>  	struct root_entry *root;
> -	unsigned long flags;
> 
>  	root = (struct root_entry *)alloc_pgtable_page(iommu->node);
>  	if (!root) {
> @@ -1242,10 +1237,7 @@ static int iommu_alloc_root_entry(struct
> intel_iommu *iommu)
>  	}
> 
>  	__iommu_flush_cache(iommu, root, ROOT_SIZE);
> -
> -	spin_lock_irqsave(&iommu->lock, flags);
>  	iommu->root_entry = root;
> -	spin_unlock_irqrestore(&iommu->lock, flags);
> 
>  	return 0;
>  }
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
