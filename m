Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95274C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 18:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 370DC40476;
	Thu, 26 May 2022 18:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PtjSiy60VGLr; Thu, 26 May 2022 18:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2314140150;
	Thu, 26 May 2022 18:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFDA0C0039;
	Thu, 26 May 2022 18:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF54CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 18:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9389E40476
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 18:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y8gIy-i2cvi8 for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 18:43:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EFA840150
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 18:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4mQizjsAl+moeJ88aNKUvH7usitH82Tel8wGoJR7v1Ce2E7dmbdiTuylLhLBjNxVIKt0imaEtk5QEbTSJsKPUmdplT9QtaEnFAFEB6+peoUb+SBlKDkqBnfXPVhh4WFCqICzrCgwuAIzi3oeuLN+czUTtLkH3XY+zGvli+dunVJdSq64PGplI9z/tM6WrBcUOe5ozzPN3WKoWD1VTu0hEMlNiwAkeqXaL9b14x8Kp4VQtU4CdEQb7md7vfozSy4LRtes0YAAbzH89S+cEDX8sjJapBrHAsNHGJcgiKesedhpcb03FWFEA4c8hwNRNYKuq7aLYf0F/Xe9g0rloFQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZJUbdOzt9vjIbHWJjpWnO/2y32Mi1Lq93ApYcdiufE=;
 b=I/dcx15h+Yh1b8O8tFLMAP2VluzFo4fbRsibYEun0MVeJl+p2JmcsYV7NIWfjQ+QPbXZjnDDXv8KjrFPUqaA/YJkQMbUqntYGeIxQ00b3vjsdZL2UYOxZE+XxBlwBTNFr0pkdKzbv6A3ZE5qibnBPaXPQfKyordNGityCj7V88SYDPt5tz1jfZrKJQK6O0JSCKr1z8lShuGM9ySJ70MP1AKyxkELYiCdw72wgNu9Md5ZOl4k+rynICrCzWi9+DasSLU91VAkpBdm650gqElMOtKQpOvFkAgwS+3+ZXg9igm5TLBYw6zOna6fAhh8ckxyqE3BKrrCUVDXAkSP7FXSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZJUbdOzt9vjIbHWJjpWnO/2y32Mi1Lq93ApYcdiufE=;
 b=YXgcrCnRTsrWqnyPRdmRgujEuIsN8kTLgxuw5Robf2HLXNC2jk0KnEsKrFgA7/c3HEzgz5lArcNqIzudh15DQTDMQKlvLMMIZZjTjlbsu3NQrpitor4Qo8uZoPXLmTcIoBm9ps05XUrSJQul32QuboDvb9BSNJeao8uhaOPX8c4=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BY5PR21MB1459.namprd21.prod.outlook.com (2603:10b6:a03:232::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.6; Thu, 26 May
 2022 18:43:47 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::b4e0:efdb:daf9:ba4e]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::b4e0:efdb:daf9:ba4e%5]) with mapi id 15.20.5314.006; Thu, 26 May 2022
 18:43:47 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "hch@infradead.org" <hch@infradead.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [RFC PATCH V3 2/2] net: netvsc: Allocate per-device swiotlb
 bounce buffer for netvsc
Thread-Topic: [RFC PATCH V3 2/2] net: netvsc: Allocate per-device swiotlb
 bounce buffer for netvsc
Thread-Index: AQHYcPhTFgvyOX9730i1pET/mIHWX60xfloA
Date: Thu, 26 May 2022 18:43:47 +0000
Message-ID: <BYAPR21MB12706372826A3ABAEF42E716BFD99@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <20220526120113.971512-1-ltykernel@gmail.com>
 <20220526120113.971512-3-ltykernel@gmail.com>
In-Reply-To: <20220526120113.971512-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6f7409cc-6851-490c-9045-caf57b4abfcf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-26T18:41:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bafcdd98-e920-455c-2dde-08da3f47ab16
x-ms-traffictypediagnostic: BY5PR21MB1459:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1459CDFC98DFFC97ABD49A94BFD99@BY5PR21MB1459.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lEXgbmKstaVe0zDImGBSnsCE2DNJ8YVVOwK/40dR0k5rkV0y5Hy7l64xftEqQK8LAVe046YR6eq74zuiIGiDF5FG+wVTWkSijWDKtp6cVT22Qfe9lGhe8EMUK8eUBshRJGadrXJ/usLFqHwt22vqzeTWOw+1t0/aCGdO/cmUuVTqoy6JUudzlgrVLbSM1qhzuVejCihqXw7MSf7WJEXcpV/nLHnm+umZMiBDuol5tMqfdBRvCLxd4qLC3icQVtN5rekMhA1nS4KM2wpxG8F7djjVtrU9BXJ7i2haZPks4j6rK6spxF47OBnntlCcagFp1UtN5uXzsDbwBC2VAEQXocMwPamDAC6ewojNaX4mB9h7fyLCoGUbv28c2Z1D/zeLUU0fKsPQl5pnqr1jI+bWhPkefFVU8HBNAGV4fWBipO97gXd+6Kp7azKMRIQ1SK6nrNL9viH186RL9UodhtDKPjkOBPtdDOgb1rkHLnYA67bxp3ZzpeLA1UVHAx9OHlRy4fTrXTEr0IoHeI1eLdWJQjSfreJkWWNDkOVuRO0uuTxZf5gOUy40si/0Px/edhbRZK7dBZWHgfUXHLZKySlO+dZ64J2NFHjU1HQDWHl7b1IMSYsvdXxDfra9RhuJChPRVBykq/0kff1qy3xHb48LXGiA42EZYWS4yEQgunCQO2cxibjzcfKS7EmykFrkTKQ3hmlkt6wtIzrlhJ14sSQhG6Iqu6+jl3p/z7mXJpDsfKgzHiDzbRd7VvLI2oMTgL5nGQJtBWyfCsYTgRWXjTHmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR21MB1270.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(38100700002)(2906002)(5660300002)(921005)(82960400001)(82950400001)(122000001)(52536014)(8936002)(4744005)(7696005)(6506007)(508600001)(54906003)(7416002)(110136005)(55016003)(6636002)(76116006)(86362001)(8990500004)(316002)(9686003)(4326008)(26005)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(33656002)(38070700005)(71200400001)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ni6cA3TfwxYgEn00f7d+KVVSaskz78zk0vHA6cS6ca6F8WKPsMrUbmSxw7Vd?=
 =?us-ascii?Q?ww1USAieESqH4iUZzicSW8dobKZECP2+ue+qKhYFJ9M/u1y9bLhOuwoDVq1Q?=
 =?us-ascii?Q?LH69xEs7N6GLVUPbBN/nTlqG4Ek3aRYfzSdXvc09WRv7UjQMCltBXxW88SwR?=
 =?us-ascii?Q?iEN4Tr9CqTq31WqGy34IvTVioWnsBmyIZ6LuTgbaYJmLGJlCBlj/LcjxvGzn?=
 =?us-ascii?Q?gNvBorwATwm7K4UDWAdBjT3W79G/oHYVGq7B25XHFlwrZWvb9llt7KD3ORML?=
 =?us-ascii?Q?3BY9FeKOeMJ25qvneNLhPkLqeb1PmzEwiwI6UjjV+9KtigDQGYHQiV8YuDf0?=
 =?us-ascii?Q?hAZRPVxX4X7+6WPDcXY1nek4ckDSxvMTxdhAwFXeoquQEZilu711vT6dgCZR?=
 =?us-ascii?Q?E7o1Z/euYs32maMIW9KDsWFouyhkHGf/hJdcaJ5gFttjofGn+QNW5f2L6lUt?=
 =?us-ascii?Q?jINYBEt/zVkqY8FTn0qY1RwSNd3YnEKKfVbiRnv/A8r+ng7btWYGziz4MdiN?=
 =?us-ascii?Q?UOfHTbaw3APJD2Fzs247EyVlRYgrLi3urR/rtawBH0ICMnZkefzzzixUhFIy?=
 =?us-ascii?Q?1JJlz3TjQMyefjv47dQXyNJUpI0DRI2i5zceIQwxdZVZMUfjr/4Iq9Au8Yn9?=
 =?us-ascii?Q?ySsyKmeuoY2muCTa4KtkpyyVoOtevbNYFGH/Jp5CJpM3IHFdHAAF6JNpJm9L?=
 =?us-ascii?Q?Ch6WuGeZbNavJ/4A7FnZ75jQ2C+nDLwWS9g2SdWRyWTE1ZEiZ9JWwJ1CF6V/?=
 =?us-ascii?Q?olzN0fdvgOrJhEEacKbKmm8K5Ko9UDLpiEp5/48zFt7i/De+GhAEVJuT9WF6?=
 =?us-ascii?Q?OsVqUOtN0knqmBgnZpLSUkY0/TSmh9oLUXvNnqJn8W3tcEuMWHkAci+aVvii?=
 =?us-ascii?Q?ccnTA7Xo2RiYNncQWZFw88w4wTVeHwUM82PINWJ83OfUVYuyoNQC16V7PFby?=
 =?us-ascii?Q?IVXScuZ9AISnSaC1B9mLZ7Ptb/J0Zfk0FEhQjVx5/6b2PlgdX7GNf6cKQ5wF?=
 =?us-ascii?Q?k+kbBnvicogCShrC17ZaT1mTvUI8T13hlVFuDZeipk3L6x1u5SgNbj1dCej3?=
 =?us-ascii?Q?hSfoxFADzRTGiWNAi3HUbcPmTRD1whSO9J3QU6RVCrJZa/Su14uvYc9lsguK?=
 =?us-ascii?Q?WxP6t4EvsxWfcsqY7ghi14r9ulPmO3nB0vBpSf0xzlIVd2nk8Q9VoKvpOpb+?=
 =?us-ascii?Q?KN9Ou9EG0o6GSj5e0JvCAT9CK6LSoRQbKKZmLMSLe6f7dCXr2Vg2dDiTtmZI?=
 =?us-ascii?Q?IzOnn3adCEDLgTdwMsiEjkhf70iSEYNz4IB7l973sm1EW/HESi4wHCbuMfHF?=
 =?us-ascii?Q?yKssj0D4fx+GsN6pHOVUCrsdQsIlXOxLD0HG1ingb4EN8BZBVkFvphcAzvfA?=
 =?us-ascii?Q?YKEDZFtPyFa6Ru/v4CJFbwFV+ExxsAl3zSRcrxt7ZWrte3vcW3JXBF1se65W?=
 =?us-ascii?Q?SDMZhVGMTI2+n9Cz24LfDez9fEDZYd+0G0rtx0kOhdZIOO14hQKOlqBgWIT5?=
 =?us-ascii?Q?jtIryuU33VBi0SXtgzjW/ZpEsY3l1Iw1TG1V35WtBZdE/PA3hDMhn4THndUL?=
 =?us-ascii?Q?qdOO+BsffL8d4sBSULt+tbERivVm2mTsg68xA/z4Tt0uJUGr3xl7sN8KzyxR?=
 =?us-ascii?Q?itBN66Tvxq61eTrXJ4OVzNy71icMSvxhhYaMGazl1lHUTdcmkyOfB6VD5Jvg?=
 =?us-ascii?Q?xQ/xUjEd+SBti2PglQNfLkWbU82swxv5jGz4hUOE45Oh1mEb97A04v09FQek?=
 =?us-ascii?Q?GGSzHpPYbA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafcdd98-e920-455c-2dde-08da3f47ab16
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 18:43:47.1619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QheGt/E8Sf4MlKLQZLHpkOCMe7Yjcw2MvS4ng+oxKGHNJvaMkANpFACw8ahFDvZEtIX5J4Rw883RFNDblXGkOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1459
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov" <kirill.shutemov@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andi.kleen@intel.com" <andi.kleen@intel.com>, vkuznets <vkuznets@redhat.com>,
 "hch@lst.de" <hch@lst.de>
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
From: Dexuan Cui via iommu <iommu@lists.linux-foundation.org>
Reply-To: Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, May 26, 2022 5:01 AM
> ...
> @@ -119,6 +124,10 @@ static void netvsc_subchan_work(struct work_struct
> *w)
>  			nvdev->max_chn = 1;
>  			nvdev->num_chn = 1;
>  		}
> +
> +		/* Allocate boucne buffer.*/
> +		swiotlb_device_allocate(&hdev->device, nvdev->num_chn,
> +				10 * IO_TLB_BLOCK_UNIT);
>  	}

Looks like swiotlb_device_allocate() is not called if the netvsc device
has only 1 primary channel and no sub-schannel, e.g. in the case of
single-vCPU VM?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
