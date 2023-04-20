Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20F2914;
	Thu, 20 Apr 2023 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681977295; x=1713513295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=67hwVxIn97bHIFdbxsRWSBp3WZwQvGC0XvoZHsnQ+vo=;
  b=Zz5BjzUwFwopZXW4cEaKCjDy9nZpLsVrdugEVMXclyVszQLTi5UAwSxd
   0UvLGnhV0rV1MuTASpA4BdL/PCm57CP6CofGm+pQxd/YntmUSLiE/Wnk6
   EN+y2fnwMoKnAvuks7W/dLvS3rvlaqISlfFYhjKjeYUXBg7+RuZcjcJ22
   fqnmL7XkB699j+biPTHubYTCSkl7D7oexeKeldnDfzmSn6k0wMJa79Lxy
   m71dZ9b6xId66wJqeqsITkYLhpmSe0mSWtwUnnhPGlemAgcVEodYQFx6M
   hDR4Ch30FV0o/OJyKjihjjawnb9lDtZntWHJApE0sVT77JKg21FSQMAJB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="348425902"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="348425902"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="685256229"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="685256229"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2023 00:54:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:54:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:54:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:54:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+TXkJzX2jZzPetyLEkAaB8+VTPxVYXD91GKJLMz+wpDnKsFJFDmWSgmuQO6aSYCtiDw3IqlKhkHNrsJBazmCE7DpO2++wvNB4Kl60F67a6xD309WbnwP5PhO8RXEU0ZN2wLQabwoBpCl0YeXpTh8oap9yDvLI/Yw9qYBkDX82siFnhnlUlZDkCkXMhf5d3g9+wBh2CBR2D6lCBfQ4K8zQYhxEYgu/MR5iY5fstFwAtLw+4tyN6pVK/jZyXZUB1T3alJpmcKFP30ylA2pWNeBJVkK3+jADfsSNTW7AUI3DGu7OCeL6OehdzMTIao1XJRRhAv+gzYws1/HJZg6z488w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67hwVxIn97bHIFdbxsRWSBp3WZwQvGC0XvoZHsnQ+vo=;
 b=StlidiXccfglcWMcYVbvpq1ta1w7cmoAFrt1AW4gnUfqizqwOUi3NMechb+aCLjdYJFYv1Z68EMLeQTyQpAxCM7XIWabPH6pvYmQVgyEh/u55pQhc6up377PNhIb1xJ/9/czVxG4K63DN7OwikenqTGTpraDYDLTTaLbGjPuhnSh2qQWA2zsqq5hoehx4j2q5jFB6wiBGgNe6gWQCxYCZ/HbryD3lVuvaDbm3X/gnpa9/w9b/aSm16CZ/Fe26LdNTGQutJEZzMyz0kUlEamin5AkMNBTwisCP+YQPWnlztC0LxMLLw7CRig2zxDMWBaOXBpGp45WU4uzAzyIUUM61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:54:47 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:54:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 13/17] iommu: Revise iommu_group_alloc_default_domain()
Thread-Topic: [PATCH v4 13/17] iommu: Revise
 iommu_group_alloc_default_domain()
Thread-Index: AQHZbUX5X8vjv5bggEmwex5TXm4uTK8z4BtQ
Date: Thu, 20 Apr 2023 07:54:46 +0000
Message-ID: <BL1PR11MB5271636FD9EFC11E6653D23D8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <13-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <13-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: f76a38b4-4af7-47ea-d5cc-08db417482d9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXGigNKPF/5npN7ef4L3OSTAg7cYYVU5+b+V3FLuGBSiD2LbXSHrSu/CpAetkUTzmSb+0VIqPRmBqumKvuFs2Yu+vdAbuH6SWgVI2IUPCHFxhXF+t/oFYQIdTZ6QmAnDR5ywUSUXihzvRAV4Y8FnyNYNsl5XSMbY4Gom1ny/nn8Byp1pkRPwAXFGe1/9rAnohvwGiNGKYlbB/PsLkijQsO9zhODwIH2tCzGVae8ztkcNc7VhF6komrwXEIPrIr32sZPgH8fppkGQvi7H6LG9QqRYHet6ZldqIfCDtoPMCg2PRtHhnMH1/BFswB/CTSHYiVDg/jpf9FHI0ZFDLGOdHdiwht7O88lLe9uMC96UGVhIsD9nNaQH4H2MAAOqrvrhvSFjLpfUAMmrkpOKBfmh+Cbq+uBYZLt45lUwqHeLwYhtsfrYn8bVQeave6FIO8UpEFEpgYqLAGfjPRUxNRUwQnnqEYpGdYaHV1agSLDpjHrny7QJsw9Az//9vzt9DAcw8lmmdeZvdh0yxDaBlyb8nWK3K+E+iHsXXkjazzzSMHBOWLSLgHwv3IkNIqaAAOVbfP0IGSQLMVJdS3/V/3rgCEU/ePmh/1UIt/vrd3PHIekzGzf4gL8wbMYInCkcU9N7vbaKv0JkbzST7dsDFZiAew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(478600001)(71200400001)(8936002)(8676002)(316002)(82960400001)(41300700001)(66446008)(4326008)(55016003)(66946007)(66556008)(76116006)(54906003)(122000001)(110136005)(38100700002)(921005)(186003)(2906002)(4744005)(38070700005)(26005)(64756008)(6506007)(86362001)(9686003)(33656002)(5660300002)(52536014)(7696005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njw8leBvmEk5sIzdJRu2RAUmoYECxvXLc1+9CqMmsOgt0WzAXPIw5qxg4Xe0?=
 =?us-ascii?Q?SnHu3Wd9gDURL3w3BTc1OkZQPIfT+cgA5SxuHzDamFhu1dHsC6xvMqEWhfn3?=
 =?us-ascii?Q?9OsEhS1p0upTkJ/ZAm56ESV0FAcjpN+ePoeH4+BcNoBaJINxNal0JRagn3y4?=
 =?us-ascii?Q?i7iX7rPbIw+xCPYxOsUQ7gGb1LuWFGA3I8dOPDYbYpMVgjQTZP3kb6j2e7Ey?=
 =?us-ascii?Q?Is9akr6H7ZqjCWCXflyT/5ZjuPQHnoTShhFx+r2O/mJTWojYDmOz/tdJxZhF?=
 =?us-ascii?Q?i2hMhM7SoDupFg2HXlCx2aj8LmsLU87IwqDhEThvMX0NhjDYU1ir0iscstA6?=
 =?us-ascii?Q?sNhBAiHJoXxQHhO0OX6a60vBIQelmsaq/L98zAzZmnHwBhcW3uvdUodk0m+K?=
 =?us-ascii?Q?7fHdLgPy/Nk7SX5v+Xr0sGzA5NDanE4Q9JGrIcgGhUI/CXDg3i/ZOWjquFqV?=
 =?us-ascii?Q?Gl6mVQtLk68fOMTN3Z4OTfRp6xqNHtJHcW/2ZENkxaha9i7Dy0R28WnN2wwh?=
 =?us-ascii?Q?19wRXTLyxabJvchWgN0jhdZ1gFDOTkXapt9sKTnicaxATPi9crHhNmBesx4g?=
 =?us-ascii?Q?HZ/93sQRiZAdNxABPeByC7jbiS8ypijv+TEAkiPgPC8oaD+pPDpNNioY4ZWI?=
 =?us-ascii?Q?uRToDAKFTVwsCHwAt9ZB8htVNgOL67Frd62boQeoWHQlb+jcVY46Od0hOwhA?=
 =?us-ascii?Q?pjVH6fchto9TzOBiWBImEnnR76QwGUxcijepqsT6iHLhcG6GddExXL++5irB?=
 =?us-ascii?Q?DW6zmYT2sKLQm1O89DTAqn+hivLWyKETtf/2JVktELKzZ3sqkiqoiY46aVhr?=
 =?us-ascii?Q?nma2ow/chBC80wARnWbQnFjgFqRkqcv43CMCE16cgAr9nqLHUl/GjXyCS9Y+?=
 =?us-ascii?Q?1BN+e7CatEEdHFFG66wO4kscpM5cMom2BalReY1jw8zzr9A1Zh+KvX6c6FJc?=
 =?us-ascii?Q?nwImtjwbbRickdSvrpASzROMJYIAOMYftUvgPEOwoqdiq3gye0RDnY2K9aCe?=
 =?us-ascii?Q?QU6ESTEi/gfacA7Hxk8ZWmooF892xo1T7Ha9JY/kKkLEOkjo1DItyyW2fnKN?=
 =?us-ascii?Q?Oa8pV5a50nfZvptljRUd0YXLu4fm1FTav+pCLRlD3y+rMMLP34ll+FQFtuRR?=
 =?us-ascii?Q?yBC8CXvMfAyCyMf2fLvYPVp0BEi523Ch+OU2d1N7/+o4ZcN8G24qH2Ee2N3d?=
 =?us-ascii?Q?n1Ucf4HUKrTDk+vC3K5sfg4QzImH/81cm0nUWIftgMO9t/x3ANfUndobzqbu?=
 =?us-ascii?Q?CNkHy1VD4zC2jhSQjpTaXt2GosNH6qrYDlW7NsjkoOIwvg+ZC6g+Y0uqXt0X?=
 =?us-ascii?Q?UFlqVj9WPA8yPLj3USnjPohcDEdhDZgRlkUHPw2wirZgOmvfzzn+jAzYvMvn?=
 =?us-ascii?Q?kcXonUxPMaVg/fwKMOGWQA6RlUb8c7Bn/1ezhbinh0O0wmrDJJEVXUckT8GM?=
 =?us-ascii?Q?l4bapxxFnN9xJEvsRv8wPQs02xQqXSEJp8GMWQOQl4HsSTHE0WrKxNuGwn/p?=
 =?us-ascii?Q?s0iQcH+lMc8r5L4Bv6bxJXwuD2d4ViTIGsRukbUEDH7oqMSlU9K1/szdKdVz?=
 =?us-ascii?Q?mUBwjW5RajikA4T2nElQDxTBzmTe2flh+U1a3tJV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76a38b4-4af7-47ea-d5cc-08db417482d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:54:47.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dS3OBy9B/C50zdsgdQt5qkAruqI+qImTI3tgV4r387vCRdSWYYVPopTOHPIrHgO0+cwt0aIUfPRSnzevFDWpvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> Robin points out that the fallback to guessing what domains the driver
> supports should only happen if the driver doesn't return a preference fro=
m
> its ops->def_domain_type().
>=20
> Re-organize iommu_group_alloc_default_domain() so it internally uses
> iommu_def_domain_type only during the fallback and makes it clearer how
> the fallback sequence works.
>=20
> Make iommu_group_alloc_default_domain() return the domain so the
> return
> based logic is cleaner and to prepare for the next patch.
>=20
> Remove the iommu_alloc_default_domain() function as it is now trivially
> just calling iommu_group_alloc_default_domain().
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
