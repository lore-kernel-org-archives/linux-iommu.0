Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86E622
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692067719; x=1723603719;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=eyt0Px11/TCFPBKVASgo03W7YMSqen8O6TEmYhYxbZw=;
  b=CJQkAoV/pn8v7jbEnpRSJYIHswmEKia25SYQyNTJ8tJuJLfDZFKL/zLI
   gJB5qStHNHU5eQwa5qfk6VLjOBUV+PS9/Pio9QVCjXeyQGC41aOUW+yLv
   Ia14KMfrLbdet+zCoERUFYw3m74KE6PMbzwyPM9NKy9dSM5rTDgaZ1RKB
   667B1Q81iE3MMLXxqyXWStYDcLTIZAWizZpcQIBbMPKCPYQu0MSOHiZqT
   5cJ9TvjMvewq58y5DfqNuWfFtuBaOgYki6TjwrzdX9QC26+b3cD2ZM0cF
   NJtI0Epbr98Ueqgaixzi0hQpVGPcmHdMGk3tlPb76yBF7n59Aj8RuOU8o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369659874"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369659874"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 19:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847888977"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="847888977"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2023 19:48:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 19:48:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 19:48:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 19:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOSo6+RvBm7ePJPJaO7uWhV0Tk9P8M8/hHl2NZ64ur5/8Pl0f+n+S0hwleeA4l9ZJ/K3x4mmElOU6XebS1fMco7ZU7sp4I7ZMJ2K/Z7/i8qADY3RA0UFMQe+2boMsJSmZ438VBfiDTWm4YIt3ystIg/7aDPH2pWeDOi/7ZP44gcgbnPOXpqCvU/yrVOJsXrxNCr9rijcWCj3L7VD9Mjoif82wU1d2+hYDz9lwFhrdnFPRi3eMsi7ZT6iaeDWQ23kV32g53AZGrHWyE+T9uuffYp5b4zCOer0XMvz2RN5I3g55LC1m1n26DMI3KIeyte4Cma/1Ku+BRaumbLtkt/Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyt0Px11/TCFPBKVASgo03W7YMSqen8O6TEmYhYxbZw=;
 b=AkipX7vQaMGEYe/LfMPegrQJEBWZgHfweHySaFJP8b2nBUYdNHsQH0tewZpM/hPb0GEe4T0EbkgK55Qplb8GFLpHcIekDM1y58EoiYgzu8zIgiqohG9g6Mdx49HCrQE2EeFYbTs4oMZQNqpPBDFKlZtjGCbLVL9AlgOkh9ZW558/mR22YrIRVTNbDCnXCXIUNnu+gqbnyETX79fR1DLypBu/7P8sEMS2vrDDG2dt2o5i42+hZGAxtjvML+NGrBqYRHp4CC3FJ4O50yWBKoPrX7FwFKpprq/geRwwP9ZpDzSELKcT/Pgt7AY5tm3w/cu008mx9oFosIlBkLC21U7/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 02:48:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 02:48:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH] iommufd: Remove iommufd_ref_to_users()
Thread-Topic: [PATCH] iommufd: Remove iommufd_ref_to_users()
Thread-Index: AQHZzwaInQZ5Fg3k4kaRkOdvopZ2fK/qp7EA
Date: Tue, 15 Aug 2023 02:48:29 +0000
Message-ID: <BN9PR11MB5276FB607ED793D6D9F4C30B8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-abb31bedd888+c1-iommufd_ref_to_users_jgg@nvidia.com>
In-Reply-To: <0-v1-abb31bedd888+c1-iommufd_ref_to_users_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8016:EE_
x-ms-office365-filtering-correlation-id: 6734d12c-5041-4f14-2167-08db9d3a1b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eytDe3107jXKUAIoMdPvZdsnE6qWIOmkYFBYmxYR+FYihmqEo+TTeHsvNkzIo0dQyILyXLTH+ohSfCIse18qLtQg/VFgCgY2yzOxlb82WmB5eiOxD0jJgEyEyPj2/ElmAjqsoSis+Jf//mJxMOFVzyIkv4rZtH+LskwJ225g4SKslGXSMsGfx32Z6eCTYdTIFUTN6wgFXWGwA4HYxAgzODw7qPCVzg5gerFuYB69lNmM8GvgiYI7+cDYb9YGptGmT4uYY//R6yR9o6DhcYbjz+skV5reT18FjPB6rAC4SzEQ8X602l5NyzbpekgMETkG3BfRa743Q1tM17fMkFv+Xm6HeXUC3l0ML8e4p7e3/TSMkKG7BjXMC08P5H/zePE1r1OXUvKzCyu2CtuOrUxFmjqLIN9lZp2/PAkwA37V4gL6xm5VrZqNFoUnAeG/RhDurC99jaGTL7yCUL0Wnp/Dd1EqROXmGjAx3QQM+xfNAmGy13JZxhfYKmQnSRILKawBjSbvlKcyfwHGVzFJRcEdlPlO7HlM2rlQGDhGhhEM/qMTiRoj/VMSk7Im1DNrmjs/OrOBbKHO8xNJtNR4fgjRQ73UvUTPF+mPFoq49xx/U7PeFWZE8UvsYm8Jgr4NAV5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799006)(186006)(451199021)(55016003)(82960400001)(478600001)(122000001)(8676002)(71200400001)(8936002)(64756008)(110136005)(41300700001)(316002)(66446008)(38070700005)(38100700002)(66476007)(66946007)(76116006)(66556008)(83380400001)(9686003)(6506007)(7696005)(26005)(86362001)(2906002)(4744005)(52536014)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X+4VRzXd0/71SyEKqf4R+FrsLUunA7NZlhx1IswSKRhjF/LvXP22/itKsx0O?=
 =?us-ascii?Q?RqMksQHiXEHccBxsJC2DhOy8qfVHQZZRSzwHtnL1kv+HHzOV+fliEzoyrFib?=
 =?us-ascii?Q?fyxvbDwaUHYMtsBiTxlNta6z+MXBAwFeeJUdMTofnWs41MQnjN+BbwU/zPJq?=
 =?us-ascii?Q?rPb46CpJe1FrJkslGBCJKB7J7I9baLHINbTDrToNHXe6rkHUV7rElHiSfN6+?=
 =?us-ascii?Q?HqBXIY7OK/bZ19ruHbfBFalK2kQ50BIRSHPj38R93rlXbk6kxXagVqkZuutU?=
 =?us-ascii?Q?bGD35IwPfMMhsrFJ0i1MM5pB9+hx95r43ZGxaUPkGFAvz/8UcK462kxAb47H?=
 =?us-ascii?Q?tYPjyWo/2UVuLZGdj2GgzvqhEsUH31YQX/zcnL0ALgDWnixzSP+U7YpEZFgD?=
 =?us-ascii?Q?dYdjxh6RPgDIdxLLJPKA65katt9ln0w2CtNfXfhJx7iYff27Tu63kkWDdvhw?=
 =?us-ascii?Q?+XRjcs0PTA2wGgNYg7tr2yZDoc/aGWkt6zQfcEgUAc6dIV6vKO8pbZI3CNw8?=
 =?us-ascii?Q?qDFvWQRvQQ4b2kPUlsVNxxgGUIpAU2lp1/1A0R1/1VApiIsA1VPDv+XI86QY?=
 =?us-ascii?Q?VcrqIby3xJ90ihz8LK3gmbhcSk13oBRZ29aepwOzk8nMMaeesCL14I3FkQsO?=
 =?us-ascii?Q?80fmK50fnIJRCHxz7BeZeriazTNYOkbUNv/h8p13dWqz+3EdNwcI5QrguiQi?=
 =?us-ascii?Q?X5NyyLX+VGJUmd0iicBepc/4B7An5PMGQm7j0PuG5UjuxWITtUX240yRMeqU?=
 =?us-ascii?Q?rDoVZvT+3OhP98tAsBw61bHjc3dwIDYwozHE7nB5v5nIg3UAjZpeRMjE+gNr?=
 =?us-ascii?Q?bT1GDTn9W0m3aG0N3L14X86qQEu5I+rc8XYlmvp+walRxRkmMJfNQ8TNDAp7?=
 =?us-ascii?Q?6XZKL/xYmnupZ20jimesLYUrA5jSRsYtw4CjcZbcpcLzO6J4ln4Lcx/K+ej7?=
 =?us-ascii?Q?F1MF+DAJbRSQOClpA8vzhTzuMHh6Ebk94pmHkyASIF75rbkNYhmWVlVwIgXW?=
 =?us-ascii?Q?Wfc5p6RYOhBHiY646/EobR4QRV+cmbxeB6j0KB09sW9+Py2mKHIpcENbu8YR?=
 =?us-ascii?Q?qL8YRMrBlNnB1w6oiYswscJ1+k2yiJucez/6FBTA4Ofg9fjJEnW9Tet50iHy?=
 =?us-ascii?Q?4l1gBaCzi66oFGc+zK1BArRZOWvj9J3eaO6x4igeeYPAgkW7n4TIh35geWo3?=
 =?us-ascii?Q?tcqnhdowPGoWwLJDwJbV+QyKj4YZ6sQeD9KaQ+UENRXasazFM4jPlE71l4oc?=
 =?us-ascii?Q?xE26iq5Opcpr7orVIsrrGz2PxjOxgjJ9cg8Y0enMpd8urWfwEnLaE/Q2W90S?=
 =?us-ascii?Q?egSUQDhwKO3lasDDEh03RCsBvmh5eKNHF/CgAG6eQ7dwSIVGe31vQSiNByT/?=
 =?us-ascii?Q?u6/gUFxsqya1mrI4kaVb4tAkdVQIK/B7g7oU1TCwrb78GhFsqa4xP1a11F/K?=
 =?us-ascii?Q?BZ0dU0MfPOba5gx/91J2UOysoRTJf5aRbylhQtyrS6MJtd/zgX1WF2dJb0+l?=
 =?us-ascii?Q?+7drgA7fQwAHF3gluCkLfVNJK+zKtEv7LCPcM1ovy/7uAXlzyT14Nh4tyA7G?=
 =?us-ascii?Q?d/fVwOMN1oxYXmEqy5MDHdyks75UsJ/roXVEYms9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6734d12c-5041-4f14-2167-08db9d3a1b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 02:48:29.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72JQjkg9js8hvCgCfEIM0R4eDJjNqGoSrytGiQy0BYbU7q3ZE/0EiwA01xdpWLkd4L4iwljxzr/dlYhx+Eb3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 15, 2023 7:25 AM
>=20
> This no longer has any callers, remove the function
>=20
> Kevin noticed that after commit 99f98a7c0d69 ("iommufd:
> IOMMUFD_DESTROY
> should not increase the refcount") there was only one other user and it
> turns out the rework in commit 9227da7816dd ("iommufd: Add
> iommufd_access_change_ioas(_id) helpers") got rid of the last one.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
