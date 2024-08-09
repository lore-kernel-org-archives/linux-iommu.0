Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7717556C
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192096; cv=fail; b=qYau2fXVqHD/ZJQLzU1wKbW9CM6JSoolq49Wtybgi76l8HL3B/QoArKwellHOnfRYgkxfBzBNvmpNoNdZa7jy3ySbWo23mE7d4ZH6JDdngoBAMRTspH8fIW0vpMNZggLfKbFxftwIboT0mzMmS+WYbEpy4dZgJcxWA+9eyrbTOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192096; c=relaxed/simple;
	bh=lcHm+F6U3GLkN/hWUsJzIDtczpMqNQh9NXOyts7TgzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ual6avNpFs8UuYMrrr6mp3sG0wheuk2Im0z3OUT2zcyw5FGtrU7IDPyyHNpvIbbS/T5rqQkOHT/IAWdfIhzP7BnM+AD0ciwNeJtz63GsZB/yPM6uLYcmdWCv5d+ECkWx+9BCC9T5fvkg9lSazlQ/C5vlYXdyCsAlKKe5VV3xTiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrYfVJG4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrYfVJG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192095; x=1754728095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lcHm+F6U3GLkN/hWUsJzIDtczpMqNQh9NXOyts7TgzY=;
  b=LrYfVJG4UBXiOeA+D9TS/7g3HXGXgur6ktBvWcvCEOGZMNAdT02arMKi
   WLP5gQ7w5tipFlEPkud4dfRz57Bd1e5Tk8VEFNhufMMLnVur+5Ux78LEj
   ynuL1I+z9RjtHKW6f5tuWnXMIbTmv+gR3AU8Pz/0ZL2ag+eR/jRTScARs
   zHzHIE5v0d1BDjIzw0a2VDdYp4e2MmbyvswkHd55/3fKjIvexshAAh/NZ
   exU1kfZle+J29z/Qw9GePryLDFD15/s8db4AO40lGownxBLRbU74TFt/S
   KXHkExvaoIb2MOsviWHpRwOJcF9zYfkTe/xNYMyrOZ6ltXR01ftFp4sHJ
   A==;
X-CSE-ConnectionGUID: 68emjmABSS+J5mCoC1Hmtw==
X-CSE-MsgGUID: 45lplpkzRO+7/iMMgpEPzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32765491"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32765491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:28:14 -0700
X-CSE-ConnectionGUID: tVUvtBcWQquiFHEEH5UTzQ==
X-CSE-MsgGUID: qoDY0x9RQxqyFU7DiuWMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="58059981"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:28:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:28:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:28:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:28:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJFEAN4U1jfu6D5F+gMi40pXj94BzfUZUF4I1brhhTS1JusyMZ+fnbswAo98kb+YBR9MqMJS2osDQesZ3dzPdI/ujy4jFv9xRGSje5zMzSttNa9s+r0n1vmHpsuJIUroIaNhFIYZfrox+e7mOC3/54X3OtKezk9/P1nn9MPwetWH5uPDEJXMELSHFWSJksuSFviL2TsYd+0v+ftjqqU1iR59IhaQLHVkw68er8ZNBIBshMudQqOwRuIjYMzROZt5FvTTSsGEiArloHzJXNExRuNu6+SEJgBX5vw9C1r6jYq+490LiVoKv69E5jw2IXPH4LbgmJ3Y5bZlFUdEnUFYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x39L9AhNuhYpbunmPbOU+YrZR0BfCPklDDkZ/TOnHf8=;
 b=djvG6CDYcFIeiydVi03ebzS/F4vHo3mZictyYScycI6DBR1FpBE7ob0W+wmbTCcmLiOkBNMjx6QiP887J0W2Iqwdl326FPD3XPI7IOjPYFBMndHWY90nIUmiKvPtlXl/oxALNL8qCGHpBZ/q/alMIGZfSY9L+lXHH2HCt1SBkO435OQrwBJo4SBW0GIZKFvYv3r6qQ705W1c9hQwCGuFDKH0joqkvXdHFrSyxW+7h0xFZK8daxYQGb1/YCdN/I3mc/EKLcWeVV7ffEEO4d+VgG6B9niJQJMEDFOa00oxTVT1j+n7DDejv9ccj/DpD15oSplQ36BpL9K55LxwQkru6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:28:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:28:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Thread-Topic: [PATCH v4 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Thread-Index: AQHa6iEqqYscXnOEsUeFtbtdCVEB3LIel0qQ
Date: Fri, 9 Aug 2024 08:28:07 +0000
Message-ID: <BN9PR11MB5276265C6C9B6B1AB7EE14788CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: 6e4d42f4-2117-4fa0-1eb8-08dcb84d322e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NxGWqusT8/PxgKDv2FhEumfdNsfD5H4Ouv++uXN3Wtw2gud+kXur3NF3/mQI?=
 =?us-ascii?Q?YwhqGCp5EXrNVw8Es2iMMscoNImvoOr8hQ+0qlDMcvM3jLCt3Zso11smFWWI?=
 =?us-ascii?Q?GaG1r5CmrSMwIOeJtEK8fBdDOcyWNeIdniGGJDyI078TtWOzJ5CzZaxxqyWz?=
 =?us-ascii?Q?1qc2O62Y85kNfSrIUSqLZaeG3yn/3pd7U7OoVwq0ebDKCPa8ghfV9v78o+cd?=
 =?us-ascii?Q?yKKN6xxD91XWWo1wB1gRkm30aMTZU1gdvW6NicAMP773VA7tn3XqYnkwyZ89?=
 =?us-ascii?Q?DczStYLm9sJzRpw6PawMar/tNw+WitH36aBgbvGhRo5jRXYMqYoh0JZ9DEEK?=
 =?us-ascii?Q?3oDtiiOvHAIovhO1Dqw1e+lfdqCbFQ7ppweRI5nT8M8lnvUhXWwiD3MrQtyt?=
 =?us-ascii?Q?s/5H8lXdY2oi1QyxE/S3K6RTA6fbNJTpHQJAQRxnRRK+2RFzbJUxnz9EcNhs?=
 =?us-ascii?Q?gpJyN5oiiCaGdPXqRijeoanFiJD9VDwO+lilGWTR5RhqLkBteRVbuzkJf8ni?=
 =?us-ascii?Q?NSvZszSJSvdRfgiQpaqQS2K6IITZSUVw3Rzf8hc4H8iICUaWBxgTtHRi/Vuj?=
 =?us-ascii?Q?YJIbV3gx+E7BvOAe7CGhODE+2jr5v37tzaU3iaa1po+kO/pw8w95tcKArXbk?=
 =?us-ascii?Q?20UVnaGlb9Q919GwbnxyeYrrPNFYKIN8i26z47Kqr7k9klSLNDJhwvTVHPMJ?=
 =?us-ascii?Q?wITA0FodiPCuep/sHuZYBhSB7KO/eWHWiYh7ABs4/DAUFHksprlDGosWtEWP?=
 =?us-ascii?Q?UhVmXWzOvqHqBIQ8GGb0Z/bqV4u8BTqNlUybXobxkHfFhJrN76GnWHrosjiG?=
 =?us-ascii?Q?36dWmaEYQEvvU1bBqXWSORFH4lm5Kv02lC1nQmSP1j4ooaSaSS73eok4mk0C?=
 =?us-ascii?Q?fw+SbMY3xZ/xLoICHzdeiJ/TI+nOnzOMVQU8Nyyj2FSfkKcuik4vSZXwk898?=
 =?us-ascii?Q?FDoGgKsy+HjQDPdY8hFz3ZOusZDt28qYIgMoELBrSAy1BcOQCgcBzcjNRQhB?=
 =?us-ascii?Q?o4ypca8Ldf2ddOPrnI6DGbVzEXSlniPHhjy8rf3lAkDrc9N3O8rN52vxwG1/?=
 =?us-ascii?Q?iQiG2fZS1y3O2CHncxofd7ix7JJ8oYnvRT0AG3Rklgj+p4SHvo1DbY0MrBkW?=
 =?us-ascii?Q?pSDGt6laKbidJjrM8KvBzo82gGeajV1HbATi6XmpMNWEwZ9Kl+8yMQk6OKpK?=
 =?us-ascii?Q?fXFdxSAm7KOqgB+NdfUlJHuOesQEF7EQj+b2Mv81+Mwb6nJ2x9HJ5KLPoxHs?=
 =?us-ascii?Q?vbd78LJaykdtvmrvzH90TdAYgGhmZD37qSfDxWy495/fj4uvzDnruTxEoaJv?=
 =?us-ascii?Q?u8L+JId/dkBvlq50AT0OJxb/pufqxfwmTHf0GAxzSK2JI0srbRq6I+FEOBS8?=
 =?us-ascii?Q?06Kftd5zLU0sR0qaSifkV1HYNDpLHLVNO4FqJpM6PnglvF0y2A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+geU1DPFk6CTfIDdl2lMWIil205neO95TDaioSbr6TtQit+Pen+mN1APrzBI?=
 =?us-ascii?Q?AVAJQswGn7urrmnyGTCtJwaQB+sdknNUuURDNDh5EEXovGbnTU5PMGrQDm+1?=
 =?us-ascii?Q?HCxtHhdffkgS6m0gL4zoCehn4guoPMHpvjX6h/hB4jSM01PInDyeoUCXKj19?=
 =?us-ascii?Q?ngbJJUdPPYyRumpZTdfSpVLBAC6+j+Hx5iFFd2b/mgdOxMWLESHkxwjPbSI7?=
 =?us-ascii?Q?jwjILaLaLUCRr94PV0xjjKDTpw+FUAO69dRy9h19D1wpSx9BawTi7mkJwnDQ?=
 =?us-ascii?Q?MsHMuH2Palc+nv0S9iSpMiRe/+6iNFsyY4ojZ07ZsOnLKsHfyWc9fi/kTKgW?=
 =?us-ascii?Q?10W5X1dUQ1Tg5GOYEEnDNNPwAgdQNozGiOC53IuVLL3SF7xBhUW+y6EjSPis?=
 =?us-ascii?Q?ofBZ/dyT8o52SYRApm+TvPOU1bs4Lj75q3twLUGlujulg/gjoVdqbiqTsHWj?=
 =?us-ascii?Q?I7VPBHl7LQb/vIzuNjzlYIpGn5WWKUBx5u8ZB4I5qb1xc8MpdkLjoh9BtDxl?=
 =?us-ascii?Q?RBzPER2eIgxcJzkzWJsRahagzgN7lEHRgribUy22lLx2Ghvh+75HVYzfWXoh?=
 =?us-ascii?Q?izU7Bh4IUMkF/YSA1VE0zCKac5xn81lnZWY4tnL9A4G4zDFxnMDOHpj0/qwS?=
 =?us-ascii?Q?x98akGNEUWAkUosrLM4HdBPGIx0z6ghtZhbBwwSu4SGCVcGHuT95qc/LKs/A?=
 =?us-ascii?Q?7ongcODvTB8lNzvMcLBA7YmZPjMfNeQW9y5uFWA5ZK/xvwlA5X1Y0rsu7T/J?=
 =?us-ascii?Q?ejVaAfKNfUSfdDazztvyYDzwXDQcjQr+q5jvYGyxVto71W52FBxPpxx78C5A?=
 =?us-ascii?Q?lNKOhILuDkSyo7PF0PbM3e737wlZC4VxaEA8CTDw8eyMo3u6SgGOHmEq75te?=
 =?us-ascii?Q?bUdwRU0FvW3DABQ4WspivIgxMlOQv98CT4dVgnfHDd8B777LDeMudqb19zVF?=
 =?us-ascii?Q?dzcWKtfZC5+cYl7Is6/FYklj4DJz8Clzq9nQNc5w4iyKpSnwwiGk3xRt/4Ua?=
 =?us-ascii?Q?EkRyBu5Rzw/TjqMS1R+brYNVgOd0Le/JyvA3vB+75Ua8JLWhONg56l6P5j09?=
 =?us-ascii?Q?WAoF30yCw+S8QcyoxazgJ+LuwCY1Qgsb+1uiQaDnz0dcU7ZdxJdziDE44b8O?=
 =?us-ascii?Q?yyqZKG0dB21hC/EDLWqsPfkyo6wP5z1AKdVN28eZMa5zWXiJeLAoy1fLhdzE?=
 =?us-ascii?Q?YUmHerkaLeUhIcubqULexvTSHRRyr5D3QK1qqHKp5IFT/+6yLVNgcO1ifE8R?=
 =?us-ascii?Q?IoP3s77d+QLdBZPRT5n/jL0kYPoie+m6Sbkm/VgOhlZE8QXa2RhMh0wvj+Ep?=
 =?us-ascii?Q?RLuEAhSQyMkHBsOAMdz5ggmd5g2BqJmjKQRgDTHc8E14iet0GZ6oUENyEhjt?=
 =?us-ascii?Q?bidcL2R/KA9MJ73Ct9IJ3lWWgVlrz42/DwMDcY11murYF7n6X/NvKwFNUYr2?=
 =?us-ascii?Q?fjmplzUExajsnvR6eHDiLbHOcU9AR2aEvzq0HL22XrnT3Zwc3kLckgGfAMJc?=
 =?us-ascii?Q?5wq3UZYLAy6EWchpLvglKfGsQM1DNwVzI+YyCKfABEvyKHIdurqRFP8upvI/?=
 =?us-ascii?Q?wS7AvXJOKkTEGmgDm3n6+xpciXrxFnJ/bxOM0XPt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d42f4-2117-4fa0-1eb8-08dcb84d322e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:28:07.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjLjUd723r3ZCccaXZFjZ45xBs9p7VTHr/Lu0AY31dSyPPRFMj2F2A96dpmtUyUHJFtpKVL7FAW7BvnoW4rJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:54 PM
>=20
> Extract common code from domain_context_mapping_one() into new
> helpers,
> making it reusable by other functions such as the upcoming identity domai=
n
> implementation. No intentional functional changes.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with a nit on naming:

> +static void copied_context_tear_down(struct intel_iommu *iommu,
> +				     struct context_entry *context,
> +				     u8 bus, u8 devfn)

tear_down_copied_conext


> +static void context_present_cache_flush(struct intel_iommu *iommu, u16
> did,
> +					u8 bus, u8 devfn)

flush_present_context_cache

