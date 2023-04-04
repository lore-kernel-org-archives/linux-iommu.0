Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EF7E;
	Tue,  4 Apr 2023 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680599869; x=1712135869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2lvrRKIEEiHJDzpa7k5LabJ6xhXwgLn92yQQdtCLUE=;
  b=hfd82r3GlpaPXL0/vd40vIRVtN7vRDi/d3/4dTEibcfB24x7gU9JYDN9
   WaQ9AcHTroHWlaRE/+PaxRinxka0djSfDIW/0GjXZXDd2T3ER0CdoJhnd
   pnQz+FbELsN53T71FrKvXpJp0T3VxopPA+Fya7G/wY+UHGuISXoyGwItf
   JHJhP2C9MxlYCh3zZSQaPWFaI8hnvbYEdEQu2ZaOJFhLK5jgD33JPQwQh
   QeP6JR77S3ZLrrMseJArx74ITgHuXVyczGt/AqNSYwox7Cf4lfqucZ1By
   vydzCiNQZGXt8wFoIfoVNG9reRi3TkBmtY0/y8zmTYptgt2eR2JdbFzHC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407190486"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="407190486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932379619"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="932379619"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 04 Apr 2023 02:17:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:17:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:17:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:17:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4hVVtx3GUuw6Dbm1PkXpjhSptg6ibjmnb7DD64Km8n8xQ9xqSAxB4jODO4PBH9ZB7H0kefocOt7QFOyJygLpmeBJv19lWJW5eVXDhZxv2NaOyXeACVaBqclLzG+ywNfmGd4FRHZvTjMENZehrgmaOeeakOVDQBEmoRkXHhQaJ7q0u6KYCHKfKSmETHcQaeIqE8xiwNn1ibxTPIbp+hLSxTV4I8LxHBZd0LcwsZ0MYDj9XLuu0yk1wCdp2Hv3VR+6Q5qKd+NTxA2vsZGbkjM/SafRfFgSJi3arMtT8s0WhNQe7FGZYEhLd/egvG5684fp2S+8tdsc9K1fpRyjNQ3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2lvrRKIEEiHJDzpa7k5LabJ6xhXwgLn92yQQdtCLUE=;
 b=mWqqaz98DBcRuJXQZnHb4/W73984G030AaFaDK58xr4cPb9hSFaVAG4QGvVV74qxKXxVASsBOyuJHiQhT0rkuc7qPtPqnUz6o3czsfzygZu1c5pkVQ4swqs6mlnuFM+8Nq2nSxAQhsVoU+cpwzWp9NGQXelJh80QKu/Adjd2VsVEiH91rGzTEgQl07oSrh4YUu2Tw63y+7DQ41RIZV4Wo7RKmew+i0v8PUK5C93u5Gfarwcb7dpJMi5i9pEfIqBJZOkxBzaMmlzqXth/Wg/E87HFSiAO4IgPYWBhhWrCxtJXN0xwc0/IODvZtoBPnrUISrrp+He9DWAA/uS0OI2GDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 09:17:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:17:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Thread-Topic: [PATCH v2 07/14] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Thread-Index: AQHZYpfuhZADNMkRsEmrsIhXtKwSp68a515Q
Date: Tue, 4 Apr 2023 09:17:44 +0000
Message-ID: <BN9PR11MB52764023C069E2A8EE1E578D8C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <7-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4913:EE_
x-ms-office365-filtering-correlation-id: abebbb74-e5e2-40f9-804c-08db34ed72ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYCOmxY7ge4jeZM4VuOctJRw/zHfuuAxzzEQT1ufycsFwFEJqfblGQjoD+qw4zoC6ZLO3UqAlCSxs3iYflzuL/E/6zxQh7x3dmO4iGbqU7p/efWY7tZ6FsleiY4fPQmr1ELrG4obPcpM8IwIJ2hfRuM801dKEU06N3HGLdsle451hFodDy0KWki0YV7NopHcKzjvE/V0tqkE1X1YgEFSLIuljGaSXbj+RI8bXjzkf8Wio4MJg3D2qBx9rG7EPoVOXQdvZ7g+n9iSe2oS+PcyqVxV+vINrPhcJJgiZ5hmvapn57x7VX0d1Dr1EBPKIAyS07DnktxVrsIR82NDZGtChr5YrlYFcZDul2ieSmG1UGJwOxRBm2Y8z6CsOdLfgegVUAeaZ42ZRZwk1CTPRJLMTPRkB4PpjT7JVTbllVN5BjlOqhwbHycbp8XYSO7pqQap4PBcDKggVx45eM2xH2XGcbcd9X6aj9AnpOIQHSYJY06ft9h48uh8TVTYKfO2FqiK+U6J8ZOzkH4iweFLa33kCg87gKTZHmggIwibcCKJ5PoCPUkGGvjOoLOnMbkBvP3ufCMnE4j8OP6h3zD832DWYFHyupGIYlZoe/TBpkyP9cQ28mpSCSfFggzjPKlZVqzXdPA7Y5KBmqC/NOkC4W296g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(26005)(6506007)(9686003)(186003)(33656002)(558084003)(478600001)(110136005)(54906003)(316002)(71200400001)(7696005)(5660300002)(7416002)(8936002)(2906002)(38070700005)(82960400001)(921005)(8676002)(66946007)(76116006)(86362001)(66476007)(4326008)(66556008)(66446008)(38100700002)(64756008)(52536014)(41300700001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oSMr+Y9AVrPL710BOa+OZv72tS8wb2+oLBNoSB8ka0c37EK1KRT9GQ977gW?=
 =?us-ascii?Q?NmBl8LbVDFaClJBK3t/yywIVYJ001d3uK/U/lLR9w3wuSszL68RlnzIu20UQ?=
 =?us-ascii?Q?6mPDFkvpN8WtakE8/zlylHT2GNQqEAh+UN0LR+w4bSOAAxSLCF3XTsYqNgjd?=
 =?us-ascii?Q?fv5hGKEmASTfomxBS9A+9PulvNjgXr+m2+HMPfbozSD2y0/jEHgpYuMJDY2l?=
 =?us-ascii?Q?lK9B9U5mcgibILJyaMhPUxoPU6BEWPKEB1O6+H3jsopvKe5/Dkjr3HlbB6lW?=
 =?us-ascii?Q?g1dgqrHrPuyeYDM556xBuOzcxnrBvn2EKh+xFpzg5p8MAyivXm15mPUIMud/?=
 =?us-ascii?Q?CNQ0wckAMP8qxn3cpEmzEzLcmSGk2XmjPIsGhTo4nrPkc5QspadPIlZ38t9J?=
 =?us-ascii?Q?N/y1UBa7DGSpElINMV1OqCGWBFdagNgLXdpCIgltYYPfxHuAzzbUh4eehJzi?=
 =?us-ascii?Q?862skiRVY0FNAp7yaz93Q2xcU+8MWtuXYy7xqPIZtqOUwXwZcBZLeai7qaff?=
 =?us-ascii?Q?DDb3jbYxo04S6mGbEDZnI4CZJyJ2aPQ0cxBIvnkirYfGgGCYX9QjSU9dgr0v?=
 =?us-ascii?Q?XUHd4FO5IEohsY3wUysSU0vgxIpQ3Teuw2yeoRcT3K0AbrHaLAQikbHZOtnZ?=
 =?us-ascii?Q?g+TITL2YtVunOeTqU58bH8j4VxfTY8jCxjjIlqn9weNvxyHAoqUqBhnV054j?=
 =?us-ascii?Q?asfxpOiqPhas4yF6jqXCX35X2eBi2A7K1gPODLySsi/wcfdqTHYy3wiaenzC?=
 =?us-ascii?Q?8km3Q3BznpjkPzkeeJ76/UqIUPCZO/5fYgusaZc6l1ESsLt8FrjllV78DM3T?=
 =?us-ascii?Q?7WYE2YD9b6L4QDkr3wCz7fUf1/0cCzd/eUWtxb3Zqlz6F6W4+37nzG9jdDfC?=
 =?us-ascii?Q?OZU7O+eB2TKznri1/4zTHDuqZ6BwV6RtdlBtXhK2pbsbIsr643eIucJlWyFl?=
 =?us-ascii?Q?KQCAUBZ+jzntHqCdJik86539tl6aJH5388wbbx8sLmClAQIOHxPq8SLSasa5?=
 =?us-ascii?Q?nxfs3j6TG3hKyuUwO21VWkuyjieHyWjBVEmE++Dt/QLiu5xuRu5a19pKBMGa?=
 =?us-ascii?Q?vYKFvw2xgLsieBQVw84fBlXnwUQ8decJBRAN5ieLFJ+qe+NkblOOnaItJhcP?=
 =?us-ascii?Q?OD7oRsFfO5AlUhUPPEsULZMgY4NbU9oHFlDXh9ydT5MLKlIPNC1yyhlKqy12?=
 =?us-ascii?Q?hU5eKdxXFOx6jlvFnWIVgQhHawIwNu0kAffdoBx4P4Ecy6vI8xF/ZvnKlDpf?=
 =?us-ascii?Q?NFP+8jvM0yBB7pqqHlknNqdqrnh/+6kZBoaOS7lEgfY7GWd2l6axk2AoXLo1?=
 =?us-ascii?Q?ULdAX9HnlZxhElY0OYHJLm7lgOJ7cmwNqvM24VXzQiVhN9+l2rw2FP2KuSJ4?=
 =?us-ascii?Q?iBmB5EqVlUgiwGVDeYD23TxUzCn9PWi4UJqFqX5b7I0KdCaa0gXSHdW3+afP?=
 =?us-ascii?Q?Xo5ebRyCIMRjUzd7L2TkAL8vy4P7MM7aMS+jiWNxVJq2gtjC5dVyp6kjpDuO?=
 =?us-ascii?Q?1NvUAiK6bvii/a7TQJkSgdY7x1y3X50/9T0w53yaq8K3I1rUShmbcVZzFDLi?=
 =?us-ascii?Q?iqBG58FRpbSszAwQ0/CKlhMC5KixBXaHStekCRCL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abebbb74-e5e2-40f9-804c-08db34ed72ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:17:44.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2b+X2f50apBFjY3Dd7l1E0bSEfIb3RO4Z0w0u2Qnad5EBS6gBetM3BkLNRV0S/WdJRGipl9q9SA523Wl16weLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 30, 2023 7:41 AM
>=20
> It should always attach to the current group->domain, so don't take in a
> domain parameter. Use the __iommu_device_set_domain() common code to
> handle the attach.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
