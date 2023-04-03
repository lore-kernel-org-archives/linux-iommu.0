Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992417EA
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680508821; x=1712044821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Ax3ryACwTjX+iMAoy1SA7YB3jxHKzUIU71OQQQ7f10=;
  b=aLT/NCA3PcoSX20heyL18F67qIzGSf+drUGlLevbMhwkau6g4ACzOalY
   YqldQPv2dmNHw5KvLTQMQDk7cJjPo8O9OAEccJK8vW+RFRG7H41LylgpL
   6xg0qPaH150rvC6U39HPAJmn8c7alRBSF758KkEkmtFGKmC5ArF8Uhe+Q
   6IbELzBjLcHjPxhThg8gmPc607yqufyKQTp0kf7xI3OWthL9i4SDyOnyD
   LxbQfN9cJMX3vY4rjvWj+AxWRNl8Snr9wY0wclJZoV2jz7gD44E6aUWGi
   F538BK48gkMCYX8AqnXi6WnibaSfxpK/GFjyK48gcyd7PfZQ413B5f8kC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="343530672"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="343530672"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 01:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="931922543"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="931922543"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2023 01:00:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 01:00:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 01:00:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 01:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5mRRSTtD/plYTNS5uEIvv+HYMtJdpncFxwBTC+8LEN1/PYXOdd0k3g6W5a1ANLkB2thjqsUZwF6N8HVRlrCqXMg+lZDbKD9ZhW1A09P87mo/WOG+r6kDE14Qcq/0MFqaaCp72AkhAniLBQt8Ci45CvM8hPZWFW2z52c5/6j72CtS6npoy4EZurNoz/d9kRs3XOwKk180b7k2qhF8secCOJfOi8HaPpFOgoTqe3r4pCzNPn1j23L806ojTmf82hxdince1lP8FCmJyxDPRqpS07CcXYBHuonh90ribR3tsz3o6J7F3+wxm98oZzqwkQA1yARQOK2eMVU71El+lS5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ax3ryACwTjX+iMAoy1SA7YB3jxHKzUIU71OQQQ7f10=;
 b=XkbukpyH8i0QLeuovIvHFA+JxVBjxnhJOrl5NJXU6qBOMhhaVIEvWncwgYdvWlTk7Trq/6sxv2dvegY1/V+FIMjfBVMRSy1v5dhCE/afZyIzEbZVd6svgHC8aCnT/tM+uU3rq5T3A82i8QaBy5CqJrlZucvOQyeFMWrdgce+uufdd6s7nBkTYg0cx9d1o4DSYsP4b370DFudaSii6Q7lYOwB/OcZ5R7NhxWmZuoX58auCpdma/9lniaZmcyv/OrOorCfHjEhYwWogfwyAJSup05DdVQ+cjPpU41IBqdjsMHa9/MOTvUZk/QUoWuDPTkFtSZr8aNUuVkzUuNJzUK3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:00:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:00:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Cache Invalidation Solution for Nested IOMMU
Thread-Topic: Cache Invalidation Solution for Nested IOMMU
Thread-Index: AQHZZcP3mH7GyOXUf0KLGMUJbSmHMq8ZN1MQ
Date: Mon, 3 Apr 2023 08:00:12 +0000
Message-ID: <BN9PR11MB5276B2F0CA8D14C0C07CB5EF8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
In-Reply-To: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: e7e1ae25-9c63-42d1-404e-08db341973bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljTwL5dHeACNMKCEgfv4KVVkGGJaxfNdANuAgv7C8AvGifsA3lYtKYDs6bvsrVtTu2iKGu1/1gzrzUnaIbM6Wl3Dk3CvScFlX8xtTMCJT12OWGdpM2outHDqzKnbFifosy8sB2nrLNFlEIy6ye8BolZTBr2xW6A9t7nepdT8iGq+EJ/riclUoJJtwhzbxucIMf/PidgKHjCcJYum3WoRl6vYk751v8S1Fp6uWlJ0IvYNnR6VCB8aS08GEkVGCy3IurFKV9t9t3ur7ECTSOS6Jzi271qeSkxdWmW3GOZIps7ceOLQWMfEwjfxU7XqADFc5N9lLM8R7aaFsF7BINlLdgID3vqxexSk+MCGa6ECnRPx0MBjzcn8rvm+Nrit7c6xmcbnCZYfq/DKNHCEjRK/IMZe4j1Vlq7/qSvzRdNnUW9QlBzeZYhwmlxdwmiWCDHcYTRXhTMVjKfDEmPh7OFMwqUw+Rh7W6VkisCsiaj9s/oazC2PUspflDv9ak7jcfSukbAtWGF6PXP6Qto8JCwFKa2xYXFufdr5tNGkdFVdtCOC2QN7/WAgINxrulTwa06E5edali8+XEDw+mESCzvdMvCB1Z3pK2cc4VbcXm3F5nzD6CYaoQJJAozrHx/M+9yb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(86362001)(38070700005)(2906002)(33656002)(55016003)(7696005)(71200400001)(186003)(9686003)(6506007)(26005)(4326008)(76116006)(8676002)(66946007)(66476007)(66556008)(66446008)(64756008)(41300700001)(122000001)(82960400001)(5660300002)(38100700002)(110136005)(316002)(54906003)(478600001)(4744005)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?byNsjBrKS7E0WrPzQ/Q+N1zsctHg8HI+MF9us2RnFbrvKhyfTSMP1FLH8HMn?=
 =?us-ascii?Q?Oy84nWoEVJt2GDzA1FUC/l62U4b73+9glnWBkTj6EMws5wv+EVgnRxJd/Ijp?=
 =?us-ascii?Q?mZRUR+hKhVvMlvWF9dXyNwYexbXGZcqns/g6u4QIL3R+Q2JB/sX8W/04f+WE?=
 =?us-ascii?Q?g8ThNhl963pjjHQj5vRBQBC4dEjLp/FfB9REoZvOnZQf/1NMWY3gvw8MhQsR?=
 =?us-ascii?Q?Y2bf3M1uwIUX+ZV9sqtJFxdeEIWN+/W8zwhD3qv+XuI5zAgilgwiAzomsE2f?=
 =?us-ascii?Q?9RsIrL3V4XTyTKxLVLIDPoHlY5X8pvYa0zXwaYorf/KgHdEvpLshNPmvFo5x?=
 =?us-ascii?Q?HiAKSICEkHrJYF2ogdk/ql58LmTl6OHotmLDQeL14q50Jx5kdckKaajnHELv?=
 =?us-ascii?Q?UjrjguB5Xz/zzPWnPj5OdxOER3YtWXdr+5KfNbWLYhzRmLYWsBWdBnDn5wRS?=
 =?us-ascii?Q?aL5uUsr6F2rqjy5FCzoFCgbZ04W+KMSo6xHMLG1iYITUve+k+U0upY8Y+4dc?=
 =?us-ascii?Q?KrO9p3ZkUG3cM/bNt5tnaDeDPM4ej9NL7IlJeCtO/PpjuV9wvknanEsUyfju?=
 =?us-ascii?Q?ssb8Ne6uzmOcKc72HOTGgMaE+MKfgpLnV5AfQV/qd0XNmoUDsHgzCpOVZ5mm?=
 =?us-ascii?Q?M0ofA2ilPCM6H/yHX5wCLuAH1KDDO/1HRXJvoqRMmNe1vlZmqoDS2pc+i8eW?=
 =?us-ascii?Q?+12mPlEbrDDnA6oOEGNPcl8cztc2mC6y6wS8c+37dGQlwJYRfulgTZoTksJs?=
 =?us-ascii?Q?iYFXjBfCPTGeQmK9GMWMuoIpE0k/goobAgs5i3ZNe9JvbAvtZDQem1j8vISi?=
 =?us-ascii?Q?HoydN0uz8UJmHC7l12NHKBZgoddmNqjlNefSV8udsFtzWdjK33trEjALSMOj?=
 =?us-ascii?Q?inAH5rgN8x1L/QlwMdIjUd3eicwiH/0TtXeb/SySFuoXmK/jc85v6qx4vNT+?=
 =?us-ascii?Q?tc61C7v6fi7PpOjR5v6ITOzGXfEZ5SLDqXZH7ZlqgIZ+zGcWoiEV1Y8fBVdi?=
 =?us-ascii?Q?3MMr9ZZK2wEzrgKiXPQH4M5rkWjS9H3zK28p7/T57ROjllwQa6PFPZ8qhq0c?=
 =?us-ascii?Q?xDNIN5Rh/GNDyFnBA7Uo1mwU/VDL4JmDLc46K9zavMuSVR8VPyQiuFJ7TjJC?=
 =?us-ascii?Q?MoZFZwGvffmczFGtp5hmlFJBpDbp95sNmTbGeEqCDm3I28oYKzOU8afUa98S?=
 =?us-ascii?Q?PV+r5ScICjkSBrr8Aj2g2yhLApPhvyHrDhy9O8sg0NSYT6KtOdP9CooVuZNa?=
 =?us-ascii?Q?V3zt8dUqVZfgpb0mfKt6c8J6lSoIkzASREOiQ/GmlU753fhx7176q+GmtCR2?=
 =?us-ascii?Q?cwSeeHer/ZEEMOuDSpS9V37myj3Fqcp6VKmd1ffO918wG338IMpPkaZhAmcf?=
 =?us-ascii?Q?wamxOCb59QloEYGG2pJYGWMj8aH4u5uy9+Mtugm/61V1grtm2izM15SO4bfL?=
 =?us-ascii?Q?WFM8bzJkWdQBLHTC9acAiHS+G+VpYoOx25IoNcgjGKaNBz0vEdbTAVCjWYWQ?=
 =?us-ascii?Q?edXW0fR1fgKYkZMNJeMCQMhJakCGJA9amYSCT+ollidHQimuZJeZDsHxpjU1?=
 =?us-ascii?Q?9ceqsURDB8ezdpZZlrtQQkSIq9ELW/MEXRiOCbkX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e1ae25-9c63-42d1-404e-08db341973bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 08:00:12.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vz6fWYvD33hMtH3Hhvyc7dN9MLfS4LY5wgwogNemEZEV2VfXynNoGrE5Z4+ExLXwYpeFMwndsMwSZ5so5bF26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, April 3, 2023 8:34 AM
>=20
> The new set_rid/unset_rid ioctls and the mmap interface would be
> essential for VCMDQ support that we'd like to achieve at the end
> of this journey. So, personally I'd like to see it can be used at
> this stage, by the generic SMMUv3 (and potentially VT-d) too.
>=20

We talked earlier that there could be multiple VCMDQ's when the
guest is assigned multiple devices behind different SMMU's. How
does the mmap interface per iommufd work in that scenario?

and looks this is different from the requirement of having a
software short path in kernel to reduce the invalidation overhead
for emulated vIOMMUs. In this case the invalidation queue is
in guest memory then instead we want a registration cmd here.
