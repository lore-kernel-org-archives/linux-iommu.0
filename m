Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04817EA
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680506793; x=1712042793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vaqhqvOHSb0H4001vtErU4T4o1dM6dV/ISmdcD+Wjbc=;
  b=D5z+eBlUWsu1eq8FkCJi+ae8/Gqxxx4zmzgdXTJf1k4hrPsdH0Jvg889
   WYbp9/j/M0JPLN35ZEFXu6eiKTnUr+zum5aM+ag9d7MvKK8uxFIpLnM3H
   56s83nSEIZNH74mFXY0+dNkRGhdJzuKngI+AksSQs5YfmqycAUjHWxzWI
   mEMp309ijkZdIn88eD0LGhSuUd6QHBAipBjpT3zRDPKR6dxjeFzrMnYfm
   5WCh5T4St8ptORa72uNkn7YEMO/Cl0HTSW44cp6c00pTXkX1gEnrCXQOt
   +STEVtEsGuowp0WkYB52WkhFhaEynVN/KnjTsfgYgMFmCeFRgLnMaNJfH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="404584014"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="404584014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 00:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="809751662"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="809751662"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2023 00:26:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:26:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:26:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 00:26:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 00:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAJwx1PhWVFKeC9Z+1DKRxTUyRWosov4GUtXfAE2MbdPvMK0fQvPpdn2dIbakxYeRZAa66YYOCvhVHwnRWzEB6UAF3FnlwtmrvomuIarFSMtDszmGI5IQ07mYY6AzijMR585LrtQ7GuoHNGzDNcX6M5UiUfFx7CZndqLienomcM2fxf3aNZDbhx4JibkzEGNYq6H/nWFKlg7HM1gS75YvQW3XmSW5lXpWtzHfDrukQQg2eyShXI4Ur90epB7VeKMwONDRIX3V7/1XD9YHopTVQ7i6VtPX4MmAyTzS4u+Vnz5kXCqM75zMjtSgKDZp489uvKHowakcOsjcUKrmNVmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWIRQfzOkVLR0lIKH5fWUbbq3GsJi0v+PxkPXYIMvlA=;
 b=Pu/rSrQZttL9KiGWRnhJJd+RDuFoqBp4T01ulcXCYplseQ6egRtXmKA/dvuSe+yywIBbR3y0qu56ooCGaouOLIjTFnAX3JkuhiZYn83RcTmK0pcK7JjdNNXSV10dYPQ+2e+qbOYUu+cyi0PliBkyxWygwrnJk2N7yq2kyNa/kMxAg2oEyqWDgyHsivuOOoXmwRldWsKxQr18mxcwrkDlRlo/QUkB2ZNEiIWZTM48IMEJjDJ6Mlb9InLB+RxadwVLSdGYZQDqBCoLA7AYF+uquOI73agZWvJLNnTW9pCt4xp6/cG711ikVpEi4XlxVwUQxt8yL2I4JQrjPjCix6lOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:26:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ca24:b399:b445:a3de]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ca24:b399:b445:a3de%5]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 07:26:28 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP3pPrE7Z2xW067fchKDCkgr68ZIHfA
Date: Mon, 3 Apr 2023 07:26:28 +0000
Message-ID: <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
In-Reply-To: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|MW4PR11MB6981:EE_
x-ms-office365-filtering-correlation-id: e2780cf1-8798-4252-8aea-08db3414bd31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKnoHU7gOueZoDZaQh+nrDOR5uo61qwcGa4idwxtHTAE2Gsg6D2eUYkpXjtFRxRMr1bgP7yb7XJGQlZFRUDRn+DZLwsZUoI6ccBxN5f7JKX0RmEG2TeFiA9ZrCiqohatBeIxDyqzqPcj4CsPAQLRmpFThcqpaIGPHxshKy+Q9q5h30lOYp1RbkeQmURjTPcuObEbTpxrJGy95+5A7nU7lLWHUyDFB8H5yJtxGN3gc7y/oGi8pmB07YxnZPYsnI3ogfXBFoWIwxgLPHVExhzB7bAKpwQyMct5zKzXCsfp1HR4N0ThTmS7MrlezDsYqVP9UEplSAsVyF7zeh8e5iaAHHjZ2vmaZndVYAmhGtO+RXMND7FoJKNnadF+ztMLyppdJLRQHgM+iOgHOj4N1WX7L7kzDZKaGeghUXm/1oqB5ZLzM96OXEJye9SOAzNX+jlVy8u6mHHFzNUFQNv0ky4TH5zQ5Hg12+S/Y8ZVxk+WilQfQmn+W7a6rFRP9xSswSeM05UGCA8yvftjCaa763uLzpEg0OLQDUp7iWQvata3dLZQWKJFGFWtph/65XrKOEFURkaas7S3dGwKCWZHIsTcaKGWSD6x/PmmCccNxEZbODBoF58/NPXZE9/EfooILywTtKzCIZxf8OcCm4PFchTy/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(9686003)(6506007)(26005)(966005)(7696005)(83380400001)(186003)(71200400001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(8676002)(5660300002)(52536014)(41300700001)(478600001)(2906002)(110136005)(6636002)(54906003)(316002)(55016003)(33656002)(38070700005)(86362001)(122000001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9xe5c6IyKFVRo6wQRHv/hQ8L8AqN+ZD2iBddhPlnYVwZZHqCZd5OpoNwOSx?=
 =?us-ascii?Q?wJniACquYk8rg7YzDCIcxuMugO+HMo3U2bFyuZhvxWxrzg6UxOwRm5++8SVz?=
 =?us-ascii?Q?OU9/4EeHgS1n6/diSGFs6XxEOND+6A5lQXHZOLG0ChvYe/9Ur8GXUqaDty7K?=
 =?us-ascii?Q?lPmgXLZYlnxpYd5zoVmQogoCr6XzB6dR594LUxbZf2WRlZ98by5SC/gG3Wyw?=
 =?us-ascii?Q?hzAeRE60koaUzeosxthG23TskLEj3BoMdreJzdB1OwZ9PoU5nnTTkTmfA3C2?=
 =?us-ascii?Q?xmE407EkQZa5WVAJodrtBKvuCvYSQpqgB0UtWkwgN0JcvfLQzObsoqDSF6VW?=
 =?us-ascii?Q?3aiJq8jSMSlOFfpi7rWHuOBY+9JiWHbXynykmbtHewq1PP1aWqAwESrm5Ko+?=
 =?us-ascii?Q?eMPqIwzbxgRKx0A+G6ubWuZtMgBQB/2AJZ4VRefUS3vRL/NgRD7ITjwBZXrr?=
 =?us-ascii?Q?NDTjyW4g8wTTpc9qOjvoeGyM9FNGVfiM+fXl+WRxMbtwgMiYk4bnEJF7lYbf?=
 =?us-ascii?Q?YgsIuhS6pKRDsyA3bML8Fu7eMeqaBBt7G5xUb30BO1ooc87IFFo4A/gsCYdk?=
 =?us-ascii?Q?/1tq7sPjadp5rf7bZs7AxfWmqC9FMNwS4x9yEAQLr3AyQSuPolMo5DzmC5FW?=
 =?us-ascii?Q?xWhYDPmKZq99eoXESrKPGlcfoH9IlDRT2hoIeJs8OVII8pudb1JXBlnf7BLq?=
 =?us-ascii?Q?in4/vCFa7WWUOsX+uSImK+ntUPZUf5APHiabYs6wZSvajTxaSKJPJK+nMZj+?=
 =?us-ascii?Q?9v8PgcFWvbLTJ8VCWc2IEPLO0+W/DqicImgcFbjgneyGZmTviqC1k/hYGn1q?=
 =?us-ascii?Q?MrlRPSowMPHc/E8eWklBrIYWJl6Fm0kIpJjz1Nalxrq2AsQ+4FsPdVqUPkMG?=
 =?us-ascii?Q?sw3eSow9C2LkZle45qfqq19ApX9oC5zyzThZDUBavBzT0GvybP4NDiqEcJDn?=
 =?us-ascii?Q?YWyjuLzLa4917Zj7X7226BjKs4HJ3NoQ+r9dyIGh3HY0aASn7j2Q7hDVdnG6?=
 =?us-ascii?Q?Rqdi+ZZ79kNcKSHMSGvCJevtEwhaxirE6dEvel65nZ1kFYTQp1kZ9CACLcIY?=
 =?us-ascii?Q?va1+9htSwSzSblhJVbz3pqEv0T+T+okbKSuE1tu12I8bP/f8HHyJwEC9Oevs?=
 =?us-ascii?Q?YeKy+h5a5ZwSK3lN150i6nqWZFayLBgfz7idwDIeLi1vx2QH6tTLeuvC1JgR?=
 =?us-ascii?Q?1YsAE0mAKym147uMuZfu3RkKbOck7ubYKlulUzKJ0c55zH6ShQXMopxDO77G?=
 =?us-ascii?Q?dig9OXJMCBEVqusOwZbfvMSJ7/gK0S5ypyqvWGp3UVrIoe0YB6FfdO89AIkR?=
 =?us-ascii?Q?Yo8yZbdonp5RzwPuw5TNTS1gEfCTSMvFMUF7RkiBb6gk9h/6QoKXJylYnVj/?=
 =?us-ascii?Q?n5t4A4uaJ+Hng0mYFrT21o2LUP9kKcwP8uavFG/25xQNAlrWtqTEUHgR1XBj?=
 =?us-ascii?Q?5bRqNTiLRZIBsGrh/j+yT9De2oJcDE7Gc9vU8FaNCF05z8/QCZ87VI7/HIqm?=
 =?us-ascii?Q?jI2D0I4Kfgir2zgLzOskCbQyqDWlL58XTo6eH0VbpYlQkFk7bxXaYGKt/EGH?=
 =?us-ascii?Q?CaEeBJGrYqYMaWolBIeW5Idjzs8pQZW21eyBzp+y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2780cf1-8798-4252-8aea-08db3414bd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 07:26:28.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRB+UlZh5fHrnyKpfqC0f4fNSBnPWnHzHQ4x80Q33dmm/x5ZbE4PDJHEsalaH9sFya7w5VWn6rkTWA0PVLORJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com

Hi Nic,

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, April 3, 2023 8:34 AM
> Hi all,
>=20
> Per discussion in the nested SMMUv3 series[1], we have come up
> with a couple of ideas to accelerate the invalidation uAPI.
>=20
> I have drafted two solutions and would like to collect all of
> your inputs, so we shall decide which approach we would choose
> to put in the next version.
>=20
> The first version is simply to individually forward the entire
> command. This can save a few CPU cycles from packing/unpacking
> invalidation fields of the commands via a data structure, v.s.
> the structure in v1[2].
>=20
> [User Data]
> struct iommu_hwpt_invalidate_arm_smmuv3 {
> 	__u64 cmd[2];
> 	__u32 error;
> 	__u32 __reserved;
> };
>=20
> [Driver Handler]
> // This draft requires set_rid/unset_rid in the 2nd draft for
> // command sanity to report errors.
> static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
> 					   void *user_data)
> {
> 	struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info =3D user_data;
> 	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> 	struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> 	u64 cmd[CMDQ_ENT_DWORDS];
>=20
> 	if (!smmu || !smmu_domain->s2 || domain->type !=3D
> IOMMU_DOMAIN_NESTED)
> 		return;
>=20
> 	cmd[0] =3D inv_info->cmd[0];
> 	cmd[1] =3D inv_info->cmd[1];
> 	switch (cmd[0] & CMDQ_0_OP) {
> 	case CMDQ_OP_TLBI_NSNH_ALL:
> 		cmd[0] &=3D ~CMDQ_0_OP;
> 		cmd[0] |=3D CMDQ_OP_TLBI_NH_ALL;
> 		fallthrough;
> 	case CMDQ_OP_TLBI_NH_VA:
> 	case CMDQ_OP_TLBI_NH_VAA:
> 	case CMDQ_OP_TLBI_NH_ALL:
> 	case CMDQ_OP_TLBI_NH_ASID:
> 		cmd[0] &=3D ~CMDQ_TLBI_0_VMID;
> 		cmd[0] |=3D FIELD_PREP(CMDQ_TLBI_0_VMID,
> 				     smmu_domain->s2->s2_cfg.vmid);
> 		arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
> 		break;
> 	case CMDQ_OP_CFGI_CD:
> 	case CMDQ_OP_CFGI_CD_ALL:
> 		arm_smmu_sync_cd(smmu_domain,
> 				 FIELD_GET(CMDQ_CFGI_0_SSID, cmd[0]), false);
> 		break;
> 	default:
> 		return;
> 	}
> }
>=20
>=20
> The second version is a bit further to support batching, by sharing
> a kernel page via mmap().
>=20
> Firstly, I drafted a pair of new ioctls and iommu_ops callbacks to
> link vSID with pSID. This seems to be useful for Intel VT-d also.
> https://github.com/nicolinc/iommufd/commit/cbec01245edc70e5de88fbc477d8f0=
af5
> 0b3b0ed
>=20
> Then I added a new mmap interface to share kernel page(s) from the
> Driver, to allow QEMU to write all TLBI commands as a single batch.
> Then it can initiate the batch invalidation via another synchronous
> hypercall.
> https://github.com/nicolinc/iommufd/commit/ee717eb6d46b5285db1aae9172ecdf=
c7
> 0b9cd9ca
>=20
> The two TMP changes are available in this repo:
> https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-mmap-
> 04022023
> This solution certainly needs some rework before it can be posted
> in the next version for review. Yet again, I'd like to see if it
> can be a good direction for us to adopt in v2.
>=20
> The new set_rid/unset_rid ioctls and the mmap interface would be
> essential for VCMDQ support that we'd like to achieve at the end
> of this journey. So, personally I'd like to see it can be used at
> this stage, by the generic SMMUv3 (and potentially VT-d) too.

good try. Just curious if the vRID->pRID conversion is the only
conversion that is required in the cache invalidation path for
ARM SMMU?

For VT-d, except for the device-TLB invalidation, there is no RID
information in the invalidation command submitted by iommu driver.
Device-TLB invalidation would be somehow an included operation in
IOTLB invalidation if the page table is used by devices that has
enabled ATS. So guest VT-d iommu driver may not use the Device-TLB
invalidation. So vRID->pRID conversion may not happen for VT-d side.

VT-d side requires vPASID->pPASID and vDomain_id->pDomain_id conversion.
vPASID conversion may be needed later as we may disable guest PASID
support at this moment. For vDomain_id conversion, there is a gap.
Domain_id is not global today. So if there are multiple vIOMMU instance
exposed to guest, the vDomain_id would have conflict between the
invalidation commands submitted via different vIOMMU instances. Even
we may make its allocation global, I'm also curious when and how should
we build up the vDomain_id->pDomain_id relationship in kernel. Maybe a
new iommufd uapi just like the vRID set? or it may be part of the
device driver's attach_hwpt uapi (e.g. VFIO) as this relationship should
just exist when the hwpt and device are attached.

Regards,
Yi Liu

>=20
> Thanks
> Nicolin
>=20
> [1] https://lore.kernel.org/linux-iommu/ZBe3kxRXf+VbKy+m@Asurada-Nvidia/
> [2] https://lore.kernel.org/linux-
> iommu/364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nv=
id
> ia.com/
