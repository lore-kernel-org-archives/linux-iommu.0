Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3F629
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 04:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670473939; x=1702009939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ANy+uMgHnamRI6yE+qhRBBbYmrVt2gn+ArhXwJqmg2I=;
  b=gQrEU/B3I4xMfV86EbAnPonYuwPTK3xv1ed3qY0T8Dhh/ptcYmnuuoLy
   5B6LXc97+UUuBP5peNNyqFEITX88m449SGg2CrtzRq27QcimwBol/S3Pp
   yScw5BMlybGtdbIq59ujpY2DviWbJ89HPc3BpluFG5GgJktYKgmBxCcN4
   F45BQYGhse/g/iwelJkgQY9BbWPG3YnXCi/bM/1NeoE55uKTJUA1lQGfq
   1XJNWj9kWLgrq2V3/kSda/HKiZzyYCCBWuDcSXPcS3VOF2tMQcnDtEsSx
   mdaUCF1UIOvP/1pL6Su93A0lp8XAPfp68MhH5ofyQsi/IcLafysiCRsXi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296764353"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296764353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="892067392"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="892067392"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2022 20:32:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 20:32:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 20:32:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 20:32:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIpRAMBPJcK+TnBLofShwcFPA+nSR6fYfuxLAu3XLKR0/Ao/Mjz5OGQICofJC4UYthcfO0maT20N8l1Epj8OViRIQEUUj5dVDFqBI+j623laZCylESfluwTYxbbVHeJrI608eEB+orePHoMmqJbt6z4C9NpOqfaP3CPYnjwO6pjTsQ1u2JELBCYQpOL1xh39YbB4zOFt9Ya3LMQ2BH5wFtvsy8nki+RO6lS/5DsdsrG60grRhOgPEAVtPr1p3keNfVtRuEzsxF+xmp/++i0ulBi5huiiPaRMUbORhLwEYIpu2DtkW2C2ZClhXGlDHvUKGFiP2i6GJsvminBTrgBpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyv/jt3JFDQieostSk6ZC/M/lYkNvZv1U6gy90yj6hs=;
 b=XWpDh5gwJsbRVjXdaO7jW0nIvXZzZS/Gh8qa3THLavucf+apZa80gGpWuQ7nOlsBcC1nWHqgdAa45BdOaZ8PpGjM0PZER9A6o+9TDyfi8fGAnN1zHXJxYHoPi90Pv5x0pYt0IQBHbEypX96K90bTeRYOSLK/V4b3bG3F/sCZ4rWjaJ52E0SRUjrs9ArxgHMthxJJA+/31165z2QByJb08XU63xK8X49K/EY1d/da96rCetctKJzST72Q/js0ttHdH+JOBZzWmEW4bterC9FQNKcRVXDqTNj9V5oMV9z7OUAXPag0ynWvOt4Y8c6VGNAqDR7NZ7A2fiGXi5xZknXMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 04:32:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 04:32:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Binbin Wu <binbin.wu@linux.intel.com>, Eric Auger <eric.auger@redhat.com>,
	"Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 2/3] iommufd: Improve a few unclear bits of code
Thread-Topic: [PATCH 2/3] iommufd: Improve a few unclear bits of code
Thread-Index: AQHZCnzNWIqA5QQu1kqjgxfcwCvVma5jZv0Q
Date: Thu, 8 Dec 2022 04:32:05 +0000
Message-ID: <BN9PR11MB52760E707D63D0754A2FF9678C1D9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <2-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <2-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6624:EE_
x-ms-office365-filtering-correlation-id: 0a163a08-6f76-44d8-f5d2-08dad8d5291a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32uRWGC1YVsoaQbmUssIma0IcexjHQ7g8KMoeWx1mKvd7dXurTYXRX8Ak3uErB1Jrq5Xa1fI16KpE3cku9hQxXgkiyeVNS7lg6d0re+R+VuZT6o/RdilzekG88gzn7DqPBxkRZVn2Wm+qeGunQZNEyVnCW5Tv3hHHeJE0gvW5xLcEH5upFmAukkzmEnO9Qlq6PzQzG91NGTr13AnGXThTrdNvOX1ES/XaItDboWo/uyavWy1+OqhA72+NVxf2Tuk5AnzEq1d0JSZr7xKwggAdX6GMUchP3bKp9SggQErqGZ7w9jQgCt+DzPhXUXPuBw7Nc4ippeHZOtsyG2aHAHGWCv1XS4tti/C3Vy9yii60mjlYCpRbNtB2Mw+lMQhE29CtnskXoBIV0G9E3kUjFVEfhDrNLJIh3jfhaMc2B+9+4Xuxfr/PVUnFVOhfFpOvfqUZo+6e6PeLRhJTm0v/xNo+IeDU7uVnZAWhUZVQ3Y35aD7KwYvtRWG+l2iBka/tcmHpCuSlGmZNSqBC8R1KCtuCWOYHyre86StRw2HHlii1M65ni3ELytIHuNC28RQU/zcGBJ1fli0yhOu6CLXCyaXJ1XisV2d1zDmAcVh0jBxWhHcbNLATNk54pcF2Dhq7yML7/5OsxITDWPnGtGMBC4ozTWux1CAtTlZdmN0NDD5z2VWCcgnldoGmqAUA6iNZcv6Mez7mcqZSxaxgg3SNaggAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(83380400001)(122000001)(38100700002)(4744005)(41300700001)(33656002)(66556008)(76116006)(55016003)(38070700005)(86362001)(66946007)(52536014)(66476007)(64756008)(8676002)(66446008)(8936002)(2906002)(5660300002)(9686003)(26005)(6506007)(316002)(7696005)(186003)(110136005)(478600001)(71200400001)(82960400001)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U21YZq67ZYAagGmVkNvRESvkNesCDkY11FIJriuRcwbIoFJuep5E+pMb/Bhd?=
 =?us-ascii?Q?6dV6ansaRFnWJq4QELTsnL2IDyXYLdoHBLGA21i1I0wMhxyRktHbK2iwoF8u?=
 =?us-ascii?Q?gikWANVnwYZ62UEMneP5YC+GVEihE8KVQyAHTVZOu6NqQzSB4mXXfRoleHJL?=
 =?us-ascii?Q?Mrt2JBe+ygDTo7uS065Uadl7NliyVpyGgVX2YvUjzDtcoyv2pdssGQ3G6G/B?=
 =?us-ascii?Q?s3cbUCsN+3H3TeIJzUfoLbfS2b/xg0vN+Rpc4OE3qk8POFqZu1lPe8vTmEdC?=
 =?us-ascii?Q?bSIARKz6XCThLX18JDM2bHl9gT6LReGt58+yO3c+1KfxQW9qzDZyNDRTy093?=
 =?us-ascii?Q?4eOBy9uWrpqku4dp5HeRpVcKBi1A8m/GSv1lnPHySeBxKZsQUCs9wQSaudbS?=
 =?us-ascii?Q?wLCQwKmZMtEbMLMudwBhf4SPGDxvXaDu75TfT7/DXwD34MBJSmgO7FVf9nMt?=
 =?us-ascii?Q?lnkCv0xpeCtLtPIaWTQ1UT3HKsia+wtGY/l3ztcrF/Pxhn6EG10xlgT4QgC7?=
 =?us-ascii?Q?tlXAC986Rg1mZje0TXnZSpK6OVsLLuOjCltJLJrsCRBbZf0sVQ0lam6nRXiR?=
 =?us-ascii?Q?PPmluZJgS7we53OO74ZSjHe9CweEvss8WZQI05SxVJTTeVk8xkrGvO1fkpUm?=
 =?us-ascii?Q?Ln+q0YTkUVGj1WzKfwLx/azEP+LtzDaiEx7RbxI3625a14WxSvx+m1/B6BkO?=
 =?us-ascii?Q?e8exoWzDaxLdCIq2mpEDkAPPRvJ6v9yjr7OxAC3G/cfv8wpZ3l8dUm1faChc?=
 =?us-ascii?Q?ovuQIM5CF/ToyNACbO5d+dxY8zdBcqV/dlLwCAXeeIyJs8S8Pe1j7AW0QQ+d?=
 =?us-ascii?Q?c/pmHAil2W9vuXFtc/rwiiNezF+eodwK20MEi3TRRre09YAJPDWN8bgJ+b6n?=
 =?us-ascii?Q?eeHFtUXQzBV7lMnAUyrD9fJXgwYvWHjmJsmZasfZ6VvACe2lKIxGM1NP3hLx?=
 =?us-ascii?Q?hTF31oAadUwoVd14k2KyiGBu5eL+hrNfp3jlDtfdokE02TWd5uMB+7J8p/iX?=
 =?us-ascii?Q?I5gMN63dcIY/+F4wMeAH8tQco7FC6lBzmwoUH1VN0jENDngL1HXbYPBwTPbB?=
 =?us-ascii?Q?NZzyIMMC58PGLaOpt56sytFfNJnO5OStgoK17jmG5lNiub5Z0MzRfRzgAm71?=
 =?us-ascii?Q?TgU8xFa22dmGG+nSZXOg0gp0fpEzKrS2s+v99bZLb6ap9Ft/dDn6mH31KOpc?=
 =?us-ascii?Q?9/tLfe0w8ju55K723f9RBrQWWyRfK+xr4uJ2BxKD2cKbhauExTahDCn22hgE?=
 =?us-ascii?Q?kDZeubnGe51v/rE5cHESI7wJIjdpg1FbGhnip3A52sKxMGRVt+b30khnJcu4?=
 =?us-ascii?Q?FkKs7lCmWEsKS5dkxxMBakpluhe2eTZiHKR0IWtGjKxTYfzC9+IFiGvqnUxn?=
 =?us-ascii?Q?ESPO8C3RKRykqIgGGHbrItcUJSiCXf9KKyTt/uljcQrvcwnH+y2Lg7fszXEM?=
 =?us-ascii?Q?dYaCFlsZpJarQnPH9VocCXp+y0IvBZmhyAKn9fa8uU3R4qn2o1czI/9dwNq2?=
 =?us-ascii?Q?LSSOQC1+/oeAGV8yFxCxVSb4n2aoUK02c5nim2v08WZLfkiyUbyUGlaj3FAB?=
 =?us-ascii?Q?cKwYepc92+Bp7zXJNNfj2am+Pr+auEDl+UMjKTrt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a163a08-6f76-44d8-f5d2-08dad8d5291a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 04:32:05.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKKmh48zNuCbMbCAPn5/bZJdrmt8fzYyLws8W4rEXTEuMsWFqOdB2meF09ZtzQ4i81T4D94JBHMxgZ2CxfUvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, December 8, 2022 4:45 AM
>=20
> Correct a few items noticed late in review:
>=20
>  - We should assert that the math in batch_clear_carry() doesn't underflo=
w
>=20
>  - user->locked should be -1 not 0 sicne we just did mmput
>=20
>  - npages should not have been recalculated, it already has that value
>=20
> No functional change.
>=20
> Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
