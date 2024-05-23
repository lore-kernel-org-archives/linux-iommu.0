Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C513C669
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447442; cv=fail; b=Gj27RA66LJmoF2e4Q1x382WPklxRoM+1e397VEGh0SM4N3NydFxioC+PXvmjCLbIcIEnWf07j+rYImMhljue+M5LBGpz3g8MmhUrwfUQoc3qkfiyIvoGMsIPE9qMJr50yoBI3L1hwXFp/zA27ZZttTIvKDxDOUxcdBkc789oWo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447442; c=relaxed/simple;
	bh=Nv8FLzSoMl5o9sUMMc5EZKBC9D7EG269Cu2Ipr5B43s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gESKxnIw2xnpmAC2GUULlFJHS4V71HkGwiuSzSb7k4HeVP1jwGt00XbUQN+4f9UexYhooJTz277Z6mAsBARTS7jXBEl2m+ppi6hw0FmuA0L9VkwFKv/4UCsfWMQC9apsJyYs9BuVK746idxM/SsnxqF9oZ2yGPmz55AGc93ZKP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2axpb8a; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2axpb8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716447440; x=1747983440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nv8FLzSoMl5o9sUMMc5EZKBC9D7EG269Cu2Ipr5B43s=;
  b=m2axpb8a52ePkPUMm7eDy8mgTGQpSoooSsbHR5bjDDHPQwxaNy8Rk61/
   gNpfA5fFUqbw+wEAxLk+rwICm+VAf0ZcaDqqNOkKCXqvacGPjBRzMa+lT
   LtD9a8GUPFZbPSQSc1yqoa4ikhvFDQlJ2MxxdKeAXd3danzGY7igEZiMs
   t0i8DFZ1SX95YD33VDGcDpHZCS4+k4/yrt1AITfWRB8PHJHxXGh9ZWvdW
   F31yAXcCQKV6oN2SvqY7NPA9JQkJMuZQHGObw4f4O1xqZFth3GsXqjJHx
   VY1sEKKn89FMhukJnimb5SugK8hdM23VVTU/bGPgjOoJau1zy1pqPxW4r
   g==;
X-CSE-ConnectionGUID: FFSwIwGKQEyG146sFqrwhA==
X-CSE-MsgGUID: MR8fTOvfTqijQ/NEHgYbUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23874673"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23874673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:57:19 -0700
X-CSE-ConnectionGUID: l/Qgi8YfTviele30EE1BPQ==
X-CSE-MsgGUID: ogikm408QuSVDtjyO3fLhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38146656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 23:57:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 23:57:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 23:57:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 23:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By4Iw0j6h+u2WHuH7D8jDWfNsnA+KBke9nJFE3lrw+S3fYGD1Bftwh6rT2AKurUruX11CtnKKW66lufMmtztC09APamfK4BDlOkWq/XcdcUmY0rim+ZYeeYg05S9vsgG5X0gNUQ1xYgOKF+gXRfVvu6Xypq0V7iaHZUorHr/8kdoRShXUo3lITyrj9By6vhFlUc6wa27gEhjMnxlTJfi27KMvMjQyTH2Qa39s0aSD/xiSo8nU+1HzfZlJ+es/RdS43nT87dNXDVxDjean8EjUnw+fvJHgSemAsHBnzkmqQ1vES1gNsakHlPtnmaNJdAtk9Z2E2Zs7CZ7JH2tXfMUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqDvSrk+E7gwaEpnIoKA+0bBoJiMzaANi6G6hr1TF6g=;
 b=fE4qh7TABnQt+BQy4aveAp1Ln3Qc3V3a+3G/O8oEaw8tnHuZOOmct+AkIFBJUr68PC+OMr3qImfYOMYUV9ZQI8aSIpSQHIqoHEuxegM6ULdB39OWQj0ZeQX0wpGcIp7VJQrbYvPbjW3InuKNPU5H5qSzhL3RWlCjmO/gdERjvSQ2b9f4xiahzvLUGAEW6L4yNmRDVZtWuRjVMpp6wlOyng9wO+G6XRGNCzxjWtMyGOctd9/RedN4kStdFQgMmxj27wjZRUqOLFymeHby4vy4B6dfb2WIzjzctFKCy6xC++8EsMSoE8H9A34Q7z3tLznQ29z64ZVBdjZ+7v3M4RhUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 06:57:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:57:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Topic: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Thread-Index: AQHajVVtTIyOrzFsYEOvw2C4tndA2rGT4ByAgBDBXkA=
Date: Thu, 23 May 2024 06:57:15 +0000
Message-ID: <BN9PR11MB527668B2398FE65771A429D08CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
 <ZkDZ/YO0jqZOlRtA@nvidia.com>
In-Reply-To: <ZkDZ/YO0jqZOlRtA@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6991:EE_
x-ms-office365-filtering-correlation-id: b61c6c3a-cb46-45c0-98f1-08dc7af59496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?kVlXvnS5uneAR4rHcBfK1fDQv1Z21Mj4TjMpoBXsNXHQZ4CaNeBYdAjhuUgJ?=
 =?us-ascii?Q?wBNDSZZtse2PHg8A2wEt+2KSZEUq4W0vv0zU/KUTg8Uf0arnS9fv+UQwlgEw?=
 =?us-ascii?Q?jg5KtUycS6Ws3hcUYlgw1POCwge3hT4bdEYdYrEAWWx/mbVN7uKCxxscsG5K?=
 =?us-ascii?Q?Md1//X+jqz5Q4oUWqt/SN49b03M5I4rPLUPHmr8dhuk4ewaqaNmCoCxT6phk?=
 =?us-ascii?Q?cbdNd6wxG/7cAMd/JI0Bmi97XY/UScUvh2luubrN5OLVv6FiIUHFyJ2Cf4D6?=
 =?us-ascii?Q?pI5lVkekGuuHoVSMK04gC2NaBn/M6aXXAySTTDt1Ba9yhtMe31s9uVSsg4K0?=
 =?us-ascii?Q?MQyQ1hHerk4u207xI/LaF8FAIr8le8gdVjlx+D71yj/brq00y2Uf0bK0ikMW?=
 =?us-ascii?Q?rNmNJzLY0ivigfi0iWhBjkuN/onLrl8bcCp774xMYGpA5iuc1AvBPbFVxpZx?=
 =?us-ascii?Q?vnFMbWIves3GvHkO+C0dF3w0itFGq1lVqgyee8ZnC/QCz+u7PnUaOsfpRfVm?=
 =?us-ascii?Q?HyB36o2BoSd66CJAQakpoqJ8CyEZPfyHgoRNU/l/45q5U7kHKFuzZGycigqC?=
 =?us-ascii?Q?CkGZI/8q4O3z+ioSuKHIFmhqIzO/dYwQhXD7V8UrTcdrh4Lt/1UqXMosWr78?=
 =?us-ascii?Q?XeeQ8YTtfImtoEGkGttNSNDQmYvrJDVvIVPsP+pVx0rhzz2ddn7Gu0XDAH9Z?=
 =?us-ascii?Q?Y2iY0KIy0raZZczaxh1NEmVfrIC4nN7A/1nbrlY/GAJTCtBTeFWpkhD+3aN4?=
 =?us-ascii?Q?Z6fdBADYGQZdDtbn08/wlFjh98lJNRXMkagYk6foMoNoaChwG64joSuW0rH1?=
 =?us-ascii?Q?QWVylt7q06UKefcj2V8aXbD3mQTYiWJNX+3p7urf2ilQG/NuHaYXQlMNfz/w?=
 =?us-ascii?Q?hUSIo4OAXNi6uuKFgAyNMizkT2CB5jAgEiEX32pUBoamm5NUDySxaI3erRep?=
 =?us-ascii?Q?ZpxDVGr+2GfwQUYNNg9OtM1qUpkwyaEeh56Ylb6Po6ZziMjUkKndxtYdYlSk?=
 =?us-ascii?Q?hVvsixosimCap+7ZPWnCoail38isdrvqLAjSm9BnsW9Mlig2aSHS58SXYpwO?=
 =?us-ascii?Q?qwqUle+m5G1R3QvFC0dWFGgcOE2ZyhoLeGzMzqSPOD3xRXbsDn9B2VVN4P8r?=
 =?us-ascii?Q?SGjz9SbANMTrSpWNIaCTv9UT6iLfvHVfLoGmqSyB5BEC07pi6lHL9TE1LjUC?=
 =?us-ascii?Q?Smk8aGuJunj3tmDKL5ztuu9KnQ9S4eEYKHm+ssuUK3fDCiar4xyxYezy+qAH?=
 =?us-ascii?Q?f4hZNg4CS10SK7BSAHbQfIpajcYzA10KA1CuzAetNsqzbbF+EYEKvKxMjgyt?=
 =?us-ascii?Q?rnRn8j6ZAtZetMx8nTKwpFqxbCXL/MLeA8Xl2DWwXzNrsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3tB77eh7LmpNRBaC7Z6Z9X1SW016EyQMgwQXrrquJr3TrCpNJr8nNiEu8zG7?=
 =?us-ascii?Q?q/PP5hH0+NVV+G6VuNqtUwTsETkto3G9G3f0RPdWPIE0dz0HqQmqs85BR7M/?=
 =?us-ascii?Q?Il9FIqLB4LkLcbZc1kKqG92GigPGecxicIQuO3jbb/kNOdpoQeb2GGQ0XBpk?=
 =?us-ascii?Q?+YDb6wumfSjPreUiyYX1TKJMEuFCwn80/r0eVlgGa7PyZORMUzkZig8dry9L?=
 =?us-ascii?Q?CeaVyQubyf5v6R0P8nt5YGCdwyG0/YX4DT4uSoLHbKsnwFnIGqPym1NdiskV?=
 =?us-ascii?Q?DjEVz4dFrxjrOBRwqqYo8m5IJoLQvgiGOMo8ddqbiRpHUghog4gWXE+KLeW3?=
 =?us-ascii?Q?vog/ik/hfB8bmYX4vFqtAJJi0AdTjIm4+m/CvKRzm+mRyGvKlkm9mSCHOIKF?=
 =?us-ascii?Q?DuQNTsfSbe0G9NZgO0pIDcqCwATA8HZ5nmOYg4FL9qtcxJHV8xrGfqAI5ZZ2?=
 =?us-ascii?Q?amK67/x8/z+2Kpxe4Mw3cArCdcD/BbjzLyh3sg/fCaTYDHV4+3Pj433RQt3C?=
 =?us-ascii?Q?NLw16mrOUWAFrVIu6omsYlYhwDMOU0M6fX2w5b1Z03NIuhV+NhWdryJJqKyD?=
 =?us-ascii?Q?+66zT+CI/FKOku23MRzBU6BjKgdBqzrlOxS7EebgPqPtIJ5alDXgeX+hLGwj?=
 =?us-ascii?Q?cX4knoKi4lvbpdCVOrWxB/skpof36ziTPemSQA6itdGHKnwxjnNr60G6Bkqa?=
 =?us-ascii?Q?lB5vSZTANYe0sjIclX94Q/0rLsAQH7IIzJ4/HKOUYatsGSixVDRIRDPCKbG1?=
 =?us-ascii?Q?o4sxbLR5YmR/Opiw4ew3l5oGo4so+2sFLjfqUE3lZ1HYUZHK0aDaryBIWck1?=
 =?us-ascii?Q?PqwP7boFOqkdakg5LjCs7TnevjQ022Tk4REJm5yfPmvmlzgc2sMACSAuww7u?=
 =?us-ascii?Q?G5AmvY5SwVGMvzugy3qaNJ0ySjdiBzZk92vx0YJ8orsPduPzcKrUDLYccOtD?=
 =?us-ascii?Q?rK3ZyCw0Ua7PiqYKWvz9trZ1MRXgy6scHVcejjjEkmjjNM7ByZRczU2QDO7b?=
 =?us-ascii?Q?vVRX6pgjPmfTrWCJZTX0JQgWbsQsDHU0UDWWoQW5islgRARXJqEiacUXsnyg?=
 =?us-ascii?Q?StrtOQGIamRCrfF8dqJkK3Av8kMyhrIluDpV0XGKRKivGsZp/k7wL/r2lkDs?=
 =?us-ascii?Q?tIxVypi2d+Ka7MJp9a9mw0Kq9OrZ4KQKQwL/NIwlLWzQq190gdnDhlPAx49r?=
 =?us-ascii?Q?Hck5u/19S3cwE80K0HDEjmkdt8tad09oeRtMg54eDT/8p+MPXmiYeeyZgays?=
 =?us-ascii?Q?Z93hifv7Rw9ut4Qyp9ns6U8G3L+jfaFO6gbXYReTpeEm6AYyMIPahQYtW61v?=
 =?us-ascii?Q?KmArT7D/+pbwZEbyzgspaxKI3iawQlc11896DSRUjza8JLLPhB/LFc3UoMr/?=
 =?us-ascii?Q?dfnv1WpriCfszbTy8P3ebAP0bNpx5OfzuzaZD6UX6jPLYPW0SMQPuj+IuRdk?=
 =?us-ascii?Q?VPaPGtpOxh9LnocqcC64FTJvV5ebIPAa6WT7tUcBU+COz5KRHsEFxLSIZAgS?=
 =?us-ascii?Q?+bilAGmlkUWWHnYYQ/uaPSwjNKZuWeB8tMqnixmbzzcbzG7AThTXJlfx/EhH?=
 =?us-ascii?Q?3eAz6uSzxsuQK7wJHybOTMHyffLa/aO9PSTOvefA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b61c6c3a-cb46-45c0-98f1-08dc7af59496
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:57:15.7786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5A/F9/X8VsoS6AczaSXoj2nfk8H2713x+kJPjdUdtyMZqBtFyKtzuHcY8UwQNnrcX7GMtZ/DZDytUGCM+ebZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Sunday, May 12, 2024 11:02 PM
>=20
> On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:
>=20
> > +/**
> > + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> > + * @size: sizeof(struct iommu_vqueue_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: viommu ID to associate the virtual queue with
> > + * @out_vqueue_id: The ID of the new virtual queue
> > + * @data_type: One of enum iommu_vqueue_data_type
> > + * @data_len: Length of the type specific data
> > + * @data_uptr: User pointer to the type specific data
> > + *
> > + * Allocate an virtual queue object for driver-specific HW-accelerated
> queue
> > + */
> > +
> > +struct iommu_vqueue_alloc {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 viommu_id;
> > +	__u32 out_vqueue_id;
> > +	__u32 data_type;
> > +	__u32 data_len;
> > +	__aligned_u64 data_uptr;
>=20
> Some of the iommus will want an IPA here not a user pointer. I think
> it is fine API wise, we'd just add a flag to indicate data_uptr is an
> IPA.
>=20

Presumably each driver will create its own type data which can
include any IPA field as vcmdq_base in this patch?

