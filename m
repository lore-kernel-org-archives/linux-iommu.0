Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314328F6;
	Thu, 20 Apr 2023 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681975852; x=1713511852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pfe2HZfDWyGZDaQgXvRF9cp92QdgOGma1Bi3+2bZU0=;
  b=aCS9kzhULv8nPaqEfrW/8ifFSzgiKMJwcWCKg7P5DfVeJifxAtoymP/4
   MVG8YukmCAdkv1QUt6Yzo0PEL8jPzpFN+zEhiEOjjwX5b+CU+x5N3DTsF
   ZP6lUdVQD75UqUPAzS2/uLu9htapzEjQ6+K7loS4EBXjzknCDrzbZVu0t
   WNUyR6qM/9aaomKyKVdBYVXs9EjnPT+uOYGWWsQcHjVG283zOpnGXt2Z8
   5waYuJX5NlDbMbJ7kZ+9cD0NBSPiRPF8fqoCo/8ThINBc0IB+iwaQqn10
   mpvoJvH/o3eexwHpng7HkJT12Teh1fTZrh2ArmwaW0i3kX0yzN9zowlHx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431935485"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="431935485"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 00:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691799333"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="691799333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2023 00:29:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:29:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 00:29:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 00:29:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 00:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XybX1Qh97fUNv0nB6c+HH1lyVRKZZKiEeNjx0UzN5fvPv0xaRyTCyAlpGppgbp+3Dxu4oSl2DjlazL6woO7pI7DXM6BoKMgIcR+8wWYI3x1BbwL00BSrp82HCEzCMh1f++ymd2E6DwtA/mXu04IfdWcaXpWeBspAOt3Jwxw3Sxoro0EQ5ID1w09KTY2WpLgs4S6K4vcLR4Lj+5Pl0Cu0T/0VDFZG82zEuvbuRxK82FFtO9C8V8b8cP7DSdvLf1hFgHMDe2oBZJ9uAzOvx+JfZs7jc9t1EF1TUrHsfUFTaDGxBm7nScA521KBb3CWHvsVxqZkeyFn20fsa2FipdQC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pfe2HZfDWyGZDaQgXvRF9cp92QdgOGma1Bi3+2bZU0=;
 b=NL9muDs5IAfrOKlc8D3L3Pf7XnjuUk0UAERO3IJC6YLZcLMnSGbYwF7q9ZA0galpYfqDifr8hde3hjUt6qp7QnJwRJ7o9e/wG2cNqge5nuT4lTPUPfLu07OpbCYkQ9NtLSB0RnoqwzqwfN5ph2mki5/ii8/TqRtQkkLNRP7vM6kU/9S3vNL/ved1e1tDio6EPcsr0lWsnclNpm6v59xLpFwYLbQOz5CTzb6qaaB78XbWOfM8FTbjhiUoVbtSnxKR3THuqC6Y7BWyBOq3bPA3iaJJmU7yCJnx4U0i0mJeR4DrgnlAeWRhlN3H2n3r0uEr8ubTf/j6mVU/grkZq/bGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 07:29:18 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 07:29:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Thread-Topic: [PATCH v4 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Thread-Index: AQHZbUX9QKMVbrcWYEurPx/Mr3/mCq8z2QKQ
Date: Thu, 20 Apr 2023 07:29:18 +0000
Message-ID: <BL1PR11MB5271EF04E61E9F628D3A37C78C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <10-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <10-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 1bf16aa6-c622-4c8f-5363-08db4170f3af
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKcXvPykrQTSQiR/UFOeIWz42iYtUshtMxyayDdfHpCo43gfCiG6ydUR6dknLLxpqj252+JiHKv7+rczIaoDy3JqRTyK9bpploq/uoqrjzAcw5yjTZ58mUfYxpDNxDHNhOIeUCM5Hkkl+udc1W9FwtllwwVNcbRu6HEHGXqiHLBuqAs1wr3nqDQV38k86NpElUSxEErTkWJcMZc5Slpzn5vehkY2N7VHSLxOrQjN/Hm5/tDg+rJWqWW+7JxvP5e87/scZX6U+13yzJok6EPMX7KqT3yKdDSVVGxOFq6NgWOVemcMIuXB+3VfoAYFVGUludBvTOx51v/4gpMUBbAj29rEL61WEP8391bmsQzEjeOUGZ45dA+drvQ66lRWUTa2F/mya/vbjxK8xwwgHVMng2FzoTW9OjRn0uRtvSZaGbbU1LlGbo263bL4MT+TbAZq4n2xg7xxJe44Z1HGfsmE31idBM12TzM8exZvcuJW44IhISA4C2XZKMYO1KDnSbbxwKxVQPG76+OqWI36zi2FutHtTSP2TXLbl8VqAfv/LUuDmA+GpvroFMitC2iNpvC+Wea34yDgDGCgK9KCACMEUA05AOjwAchTOSkebVhJXe6GaBpNyiiSIC9ugjPvUYisPTzJk9d6KEQFFzp97OiDcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(122000001)(921005)(2906002)(4744005)(82960400001)(38070700005)(33656002)(55016003)(7696005)(478600001)(71200400001)(38100700002)(26005)(6506007)(9686003)(186003)(86362001)(5660300002)(7416002)(41300700001)(316002)(8936002)(8676002)(52536014)(110136005)(54906003)(66946007)(66446008)(66476007)(4326008)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nkELwl6MopdCJsI4sCJeUOFaxyMIUyh05zSNCdqwth0XnnIBDVTl1VcDmJE4?=
 =?us-ascii?Q?iMaP2pt3rlLzszsoFx9avkFx2eGhVRVWHIB7Wlsfy9n0KF2Tz2u4VWAJmOop?=
 =?us-ascii?Q?GsIOj9Q2a5UiEXV8JSuLYb4xXR1JPNHLtiY/mcL7P9fV0EgwFi50euba+2U5?=
 =?us-ascii?Q?MXfz6xiXeI9gAkO2/H/rfg5c/3aVXHLu8Hk8SVNWmzvGMgyv8SKaope7NCQS?=
 =?us-ascii?Q?QQlw2YCoTOTa6Q7iFNIbe8qDE+KbbWrWbx96XONDPWxnc5UOgt4M7HFhwVXR?=
 =?us-ascii?Q?ydTHLi3qqiSh+F23cm4Jb3SM0KzkfwE2MsGEKiOQZKn+xr29mFP/uUir06pN?=
 =?us-ascii?Q?KMiLe1FccCTOXKBEJsr0as4UNzIyiXXs9bbN2OmMXw45KK67pQjcm0WGHTpH?=
 =?us-ascii?Q?kCczwIlPVaR+oiMFBIUnhYr7cdLp6dNriqUgXyEKuNMFkA/5N6RMUPzYAHPC?=
 =?us-ascii?Q?SLijxMjH7K58fm92kVo5yBPZGoCIxbubZoH18ElfxPmkVdcwRbJjVaJrG4uD?=
 =?us-ascii?Q?5p89TGLO0F37/bRZuZlzffceB8YjHnoT5TRcisEQmD2X8U/fdwHnc9xm+d9/?=
 =?us-ascii?Q?Q+TSq+cmxfFqD5oMOpPsPW2HIcFWJ7Ns9PCTJfH6Zb4nAvOqu4zPyD0Y+/zG?=
 =?us-ascii?Q?Lb8KMYpyBFrte3wf+T9F+bwzpqDp2dzIIU8yVpY/9+5xbGaW1Oz61L8/g9Sj?=
 =?us-ascii?Q?bh0TYFok4at/NuwDHVkSwdtH4qlpLiWWik+nGRuHCTbs6MTNuCXoVErOuPdP?=
 =?us-ascii?Q?riM0U/1ABV0qiqwEvuFLq+cGQ8tWM/Lrlf9OdGBs7JwiTWKW+vnOrr+orIe3?=
 =?us-ascii?Q?8guXSO5qFigKOEoruPK1FvDtj+QONMCTVGITXOgKz29e13rt2nnHKec2AY/i?=
 =?us-ascii?Q?3ZuVgKlwS6gC+5cQdVEFywB/XWK3pJiilGFTuRvTZhOpE43sUnJBPYOxQstL?=
 =?us-ascii?Q?QfKMECtIxWq0oPdJMjFgl6pJgIwqvLNxzR9LA+A4BDe+ZL+55Hid9DTiRt2u?=
 =?us-ascii?Q?4ymJJhgklUxWKICG7slG8hO/Ml+zgXjdlDV0B27tcGq9lFaCQ5IZ3pHm/lqe?=
 =?us-ascii?Q?Ek9q4x0HrbNyz/rQPZMXalwOTRejoY7uB+kDWRll1XSvSmL3Oh77Gsvr5wZG?=
 =?us-ascii?Q?wt+XTVNBpZAjJOHhpLkyCGEm14HHJzL5th8BCdlDFK2+520ToclCPQRvfBOH?=
 =?us-ascii?Q?uIhO59uoY9QVlwa8LeSn7pFjXNj6i6sCJLRbZcdndEzf5/FeBp64NbiKjKaG?=
 =?us-ascii?Q?FP2lM8/tyk+7P35FU9uMmJzQJMsoR39BB0HoUxa6QAHpzC1WOTIYPiM37HrF?=
 =?us-ascii?Q?LBo59LB+K0F1ldXfOxlQH8rNPTwQkPdepbZRAY1w6PwOzTatZXQyqCwIKY8e?=
 =?us-ascii?Q?k0WSV20QAiUD7Bq6VThG3TbSRYp6jad1HokMR31fXN6bfPOeFopiXaUHg5dA?=
 =?us-ascii?Q?7yuzyeiBOUlMxZKjy40vr4NGv0+SJY7UZOz6VdOHUvFlJXzGo8Kmy8xplj1h?=
 =?us-ascii?Q?VLvasKhAvI9L328EBypuJnMh8yl8g795PMp0q6rF/+PJc12/zXfW1VF6mIrW?=
 =?us-ascii?Q?zrsSj5r0G+YWThobiIXvyqnqm1TnHw9z+lOsdUY8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf16aa6-c622-4c8f-5363-08db4170f3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 07:29:18.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mXn8Pr0zUCoWu5d7HRUk4YQvtGsM1MwZ+IqqJuDNVTbSHiOWbkY9PWhy4YYRVkjJwZdW3PuLVV7fnufUhZjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> The iommu_probe_device() path calls
> iommu_create_device_direct_mappings()
> after attaching the device.
>=20
> IOMMU_RESV_DIRECT maps need to be continually in place, so if a
> hotplugged
> device has new ranges the should have been mapped into the default
> domain
> before it is attached.
>=20
> Move the iommu_create_device_direct_mappings() call up.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
