Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467771C2DA2
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844753; cv=fail; b=pKWYlwlMUCUYXKN6J9x3LounwejqoN8xpg/hbBXMvjbQW2IpkPLWd/LS2oahrmJgaHsRsRlHtJbN6+c8oglkbJ4+TXbeq01uAoyzviJPexJ0nRAtjXs2QIZD2+xExWZNOaiRftHmMtEJ+WEto8zgP1bAuJ6euYfXQnqg/rswvuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844753; c=relaxed/simple;
	bh=qL5ABrgG9KkkFKbJsOVKJX+6RFhZYcshcmGyBQuoyog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PWEgE7+SfUKpUQJsw5/7WNvkt3lNPU42TpCz02LSgd0D/Ylu0s6OOFZn2M2t6DCi0tZ/uS7diyJlJuVDulEqkXXzZ+al8vrrl6mPWdiUy2hKDullV5nUpsvAJt3q+bHrDHPoSMxaohNI2S9ff7NaYrMVofubBxe03KZjOZ49vgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGi8hQLS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGi8hQLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844751; x=1761380751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qL5ABrgG9KkkFKbJsOVKJX+6RFhZYcshcmGyBQuoyog=;
  b=UGi8hQLSjGfKAcKYN8AiThJQgRbT9pRYG0vbei5VYkxnYLftWUYPYCLr
   d4Z5kYQZvpO/6ckD6GC6s2zpDM+R/QA6XabydVl5P2werlQaBk0c/I+g+
   ogzD/f/DXnH434LA2yFxkouwg6eSJaWJdC5HeqzO+Vo7duxapI2a0m8Le
   vq0gvuzOI7lBT6/fvztRqc74XZeGugiytbYpR9CMEl8N2Nz95ZvJJjkab
   AwjHm+H5bUpRE0V1F1SV/fwLmeIWnNGInjOa9FjzFeos41mtwbBa9zGHS
   u6pNAwZiNeGrF0NhKwPfMHf6FPzTGkOYHzuB3xoIAOcwKkAkHdjtUF8rm
   w==;
X-CSE-ConnectionGUID: OGKzSd8hQV+5YTk/3QQdag==
X-CSE-MsgGUID: bwQpDswXSSKYWl5pringQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29623291"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29623291"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:25:50 -0700
X-CSE-ConnectionGUID: 4IDRirk6ScKA0fgrmBpc4w==
X-CSE-MsgGUID: m0SZwtlORZ6VvFWIfqdhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111689304"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:25:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:25:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjdHj1sHpIc5PZNdcQwvtyaMWuhxCgGHGndL/nzHVsnzNO+cfm1sWHQss/AiKWl/lq6iBIlKA/YTaJIRGt4l6UjGu2h0JQ3XUaCkyg6q8YRhl8SekTzje8m/+oAC8UhUfh79SmCePL/n6ZdbDLKUHrW1nQsaCOQ02Uc82Ira6TFR7OJTa29gu1OFgiD0xIkVvkVfenom2AUUwbymd6NeA8BD8nN9J5AObSkNPWNsPWTWQ4VcdBbzNCffe0hCzvJ+yl7WkLIfik7+d/YU/4eAyK9z9I9VaF8pWLRm7U1vI8ao6tybHupuGt2gmX5XDB6pUh+TsUoQdGTyYLA1er9w0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL5ABrgG9KkkFKbJsOVKJX+6RFhZYcshcmGyBQuoyog=;
 b=km+DsHSTUwbsyitmn+eAsWMJ4zJvEs/Mav33vlM66FRPTzl2U3lL3rcbofLt7IQ1fLct4PoxF2O+p4jmgod0l3PB+M8jiiNYfaTICz8ViwchFRDEPU+0b8FOUoy2zPezzqEI+PymeuKhQ+eSW4SaH19ibVicdU0zJS06xy0v8q2sCoior1M0nsGrxLAasu7+6IGWXmU13Z1vd/01qaCMmN/vpSfBXHsEav2v8M/jFoqrK/2oEN4XZLvQVOFkid/LRV8jsLzpsNi5JZ5ndaOCmC0GAGEpd7IDxtLOFviymVCl+MiqAjL4j4UxmvM2TdY37bDuT5Wq780syBShqMdfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:25:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:25:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 12/12] iommu: Create __iommu_alloc_identity_domain()
Thread-Topic: [PATCH v4 12/12] iommu: Create __iommu_alloc_identity_domain()
Thread-Index: AQHbJTjFKo052NM5GUykOITdaKr/yLKXJG7Q
Date: Fri, 25 Oct 2024 08:25:41 +0000
Message-ID: <BN9PR11MB5276969FE24DA45B32DC70748C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-13-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-13-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: 6deefc11-3ea4-470c-01c2-08dcf4ce9cdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+JyUji1GHoIUGgCS1Z7GzOW/GFjAEED/dal3qlU1b73FsNHhgkk5IjU9dIrF?=
 =?us-ascii?Q?gqd8RzsaaaUi/veidK8bWheRDr7aaj0E7JOotcmVPB/m35dsrNnkmMB9qvpz?=
 =?us-ascii?Q?KiSmOa5yYXXGCpqltanE3YVELVEVdPZ5GOlAvs/vt5daw4AE1tyocI6pvgLP?=
 =?us-ascii?Q?mdxVwjq60VYYLvidRwR+vEtHG2o5MVZRHIYDL+T7MNJKWT/QYfo5ZUNKGGfJ?=
 =?us-ascii?Q?i63yiUp2uXc2XgakMPAPder7Yf31Np2zgJLDcoPxhlZUSiRNXf+KpB2pn0K8?=
 =?us-ascii?Q?8UobcGUt2JSB6GatVbJk98Ba9qH/NxjZvaKvvz6O9K5o6kOB/K6doY7EE0N5?=
 =?us-ascii?Q?2ked+bL5hkX1x8JXm+6kZrzdxnWUqAdXh0nZM0IGj3A/VOXwty06gvTvBL8Z?=
 =?us-ascii?Q?eDQv/Z0qyg2g2+puLSZPUUDo1t0mXHC2cqi1y5dN1f7UG80/2WScY2yGKbwD?=
 =?us-ascii?Q?rC1v07mrRlCPW5Cyf0EagiqFefSLdyVIqlGkvpAbT92v+D6EaVItZ265226A?=
 =?us-ascii?Q?WY516895zTH+Ub+zMBrMa3ojMtl+cZm880pG4FyOd/dR3V3yQ43DsJ3oA7bX?=
 =?us-ascii?Q?Rll/JfXXDVXM31IoE6dV3WPOd2pmx/Kny0SnTVomrzbucI5wTPoEbqu5aDJX?=
 =?us-ascii?Q?JbL5S8HcNBqVSLhP+F5s4slMBdB+b/SAJmMq3MhJLdktmQDp/x39KR8LgLWu?=
 =?us-ascii?Q?4vnkk/K5BSgN8jM51grU4hYTPdogv6CtErbho4Wdghb4CEyRUqdo69cVdLSr?=
 =?us-ascii?Q?198cTC9jCLd/PAFbiKO3kYgQ2khd4Hg5VuKlEfJrEMCjZ0i4f79Wbhgr4UvN?=
 =?us-ascii?Q?gILAwkQ+VfV1yYNGuHd8/JzF9TWAGakIsXeYuVd1Z4S8WfaX+dGajhjB4G02?=
 =?us-ascii?Q?p3HIO6qiKY0YoKDspKbvo2tmjzirRdATFYoMmy9k5Y/nY1Xn7ivq9SQcVZ76?=
 =?us-ascii?Q?BUbVeyARXrT1/Sh42utHXB8leQI7GgHuqDRDFsyQ0BNdiHl104VNC+5joKN8?=
 =?us-ascii?Q?Hd9pbJ3cLNVus7poWB9ATJ4pTvHiH16LZkrYZ6N6z/ykZogWSRLnp1OtaCFo?=
 =?us-ascii?Q?rkmFkdpH+SU87ZBJUZfDpf+BygrxxAMrEwsBMYAbKnM/wfv70mfB0HxzcM+i?=
 =?us-ascii?Q?/lSN38eV6hpy1CxfGx6tQSJoj9k7YQCiqEaQl1XOidkjESfHLo0nHgNhubBn?=
 =?us-ascii?Q?0uUX9XN+CTavLXksP+KlUWVNN7jlEEVrpxxt8GSf+BfIZOo2t+cq5/ot5wMj?=
 =?us-ascii?Q?4QYicPv2c+c2dFFH/b7RP5Ppya8D/SJwSvZ2krR1uglwVEWH4MAiGbuiyV6V?=
 =?us-ascii?Q?QgCP8sUM9LXrl1eb9hgQfnr0VOq7dg2RFNrrhvEG6ahg0zZRDBupQV5kaD44?=
 =?us-ascii?Q?PdgUkyw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E7C8wPkhufuFrSTttJy1YcU4FqW4Y4lNwdiM/54eu1KRn0TXMAYaI3Cc5/Ix?=
 =?us-ascii?Q?pcN/RnTFJrRbCkMLa0b/nocZxqg+WeMvvtY9eCmBS8pOpl9X+BQpzjwEgwlZ?=
 =?us-ascii?Q?u7u8KSnVQoTvGvUZqrvhNSrX49+nY3l55ny0FmlKusJMRewZP6zxxMQ3F7lD?=
 =?us-ascii?Q?HxaAUbBSZ8SkQCPTDV0DvPuCzSwWqUlHJgtNzs8XdFapI/d0t55JkfSQ9KlJ?=
 =?us-ascii?Q?WzT7yF8IDzrUL/6ti2YXyb1Ym1Q7QRGcx7Jcq9CPWIjOxSMixv2w/oh1Rgvj?=
 =?us-ascii?Q?pbTNOaxr2mgJcoU25/NjLF9U6VMId+EoXl4tWr71WeZaYt71Q/OqTC7d/HKU?=
 =?us-ascii?Q?ZMXpYFexAMebRdeRR8g743E54dEs2l9lzHC0jfcvwAPYK5wvm0xv/fZyGXRa?=
 =?us-ascii?Q?yV4uCUmTL+5KmWU2HFiSgP0edHH1XNDZwrn02TSuE5Sn3wVx+gllZCu1FIXF?=
 =?us-ascii?Q?76/s1EwGzU2ONkEolwQFI067V9AjEIAOnbW0f6Pp5kg/Z/3zAUgbbS9lTlcM?=
 =?us-ascii?Q?tTx8DBUy3taYnWnOLjlF4/VXiK/g/orOK9M7V60T0IDUC7UGPPwdkOf319Np?=
 =?us-ascii?Q?XnzdoIcSAJCoe2XkuuZG2uk1XZSkXhQryR8Me+cdEHdJmpbgjqzImQMo/GdX?=
 =?us-ascii?Q?VvdTnu3dtH5jOv2Lim3iBcT2Ei20TbMoNqqoFBmIXxA9RWfNIi82V1gDQPTM?=
 =?us-ascii?Q?ZiAZOUQnkTgNKbNJmhTWUH1W5jqyJ7XzFQZe4M1X/psCcvNyWLDfmfyx1ir2?=
 =?us-ascii?Q?3VtsnhPoF/xmIENui5VB0Frddx3TobW4FsJaBLi+S8/clxbihjwsa5bTY1q9?=
 =?us-ascii?Q?9v3y5cXwO5RoIIt3SR+jk6MT5APVpPT6QIiaE1TzqOD9Cq2ny/Kj29DSYKqc?=
 =?us-ascii?Q?mvGcGcHUi59K1mFvVYTR213Hwsx6GPB4d7mnpz5iqimkXx2RrGFlKmv9rwkT?=
 =?us-ascii?Q?M3/1kDck88N6BDxOuZi5yUz7nhdSI8BOiDkryntE+CBR2e8CLH7szo/xR/sO?=
 =?us-ascii?Q?TXL7G0BPghWZGybSNP5JR4FJYtqRiWBDvLh7PjUqRAP0/mL/LYpVJ+FboSGf?=
 =?us-ascii?Q?xJcCMLIxFN6c5UZTAQsuqnUe7R3TqBHNgeJVNww8aVkvZ+pzoGmyBCxmaP5T?=
 =?us-ascii?Q?jKwKrIcZHiF9zL6fRQxfrzQrA+JmzgjoJhBZXwRJ+msXGsJAqSQiZiNJ67Kq?=
 =?us-ascii?Q?E0m+/dSQhLsHZcuUAzHlGxAVFAh+1vUlkVeyMfwcGYeCZL7wIHNObLByrGaR?=
 =?us-ascii?Q?FOR+gWTZJAWBFQIDF9t6fA7ffh6nwnQGRLaZUcpALVm4pUfErSugDMzydt5J?=
 =?us-ascii?Q?ZIyfOEAhXz5mefZMVWpNo3rb9dLRzXAf2/w3in30+STIsT3ImK6d7Nb0fGDS?=
 =?us-ascii?Q?gVwxaKRh2XT2Z3vrohVfiVcag6cdy2JZvDs+CZNEIbS9SiCCIa36zHt2IUKf?=
 =?us-ascii?Q?VDze051TPcSHX3IGn1Q7FkK6wZQ0D6f7ylZaiRAaVkXk9Lrjhhpw3aUdcy5l?=
 =?us-ascii?Q?aFNFz0HF/vHFujjR5mf+Qnb3nK1VqcXCPbkWoQKN8IFPC/L4toDDHcZbwopX?=
 =?us-ascii?Q?mvkQdK3yDLuegboagMT7URJC97j25+zTf6yBSjNH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deefc11-3ea4-470c-01c2-08dcf4ce9cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:25:41.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdEN6vVh4hG8M09B739hVm8XN5LTShGoKZdi7ZF9/zWv7Q7BOPOQcib4C/7c1vhVUoDje0pqNOjKtnXDiLAoOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Consolidate all the code to create an IDENTITY domain into one
> function. This removes the legacy __iommu_domain_alloc() path from all
> paths, and preps it for final removal.
>=20
> BLOCKED/IDENTITY/PAGING are now always allocated via a type specific
> function.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
