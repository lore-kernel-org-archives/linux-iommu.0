Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0222F1C
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815430; cv=fail; b=jF9paPlfMjk/DC/S6+XwoXqZVWkXj8GNRQUNYsEjVcOXW35VwDtWoBG65Esy12YPtiFtvJhG6E1UADc71Xxw5AWHNXSR/WSGSdpyp7lqENoK9an7OBC0sPSxQ5Wq8JFG2vGupLJav7ABnNKLLRCgK/TUzvVzaMT4vi5o0xWYPs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815430; c=relaxed/simple;
	bh=tAFWJHMabDeGCEY9e8bLz0JQHTM8tCwsJjomEMGJ9Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4rAYIeuXf9ZK2Yea7WhmnOTAYTjXyGL1lKKZ/QVAONYjPs7c2dLXRFenEU8hmr/8JKEJe5UFx2lwAN5IAwxXjppyrVmTKHJcYD+HXVWHROeztXxamH6TNOqagaf/xb3IdDPij1o5q0klt7lY1rYqP4F1o8XBK8kbp4fzkQTrlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPAwzxCk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPAwzxCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726815428; x=1758351428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAFWJHMabDeGCEY9e8bLz0JQHTM8tCwsJjomEMGJ9Xo=;
  b=dPAwzxCkh7ADE0IPwoffTVTsUS/O1mdcRngP48eIW34JGh98/yqYFJI2
   letgA3RYG76C4IZ+1TYPpm/A3dSJf8FtyXtxt2FUoM7Px3SA8tfEX2+8R
   VxUR8x3BFvSzDjQmiIWvUHQaqqscciM68wMrJMHyMBRyYgDmM19AooiZK
   Q/1gHqaTdOfurFXK3mFQGIHCS+py5ePluDog+5ZiWxcgDcZNc4wI+TQlU
   sNF2C0ZHvSch2c/MgoGRrGNcDqdiImSsuI5XUb6NqDeZNBFHzG1JJRUj7
   yZL2swYMPUE9iwJAy59iG69IhLUlZGhkzr1oRWbysNCF5OOAFK05gybEZ
   w==;
X-CSE-ConnectionGUID: D3z3O7QNSHCWNnZektp0EQ==
X-CSE-MsgGUID: Qh+Zc5rURruyiU2JEkWI9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37186244"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="37186244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 23:57:07 -0700
X-CSE-ConnectionGUID: adeViDnyRAG/NgYrceN0IA==
X-CSE-MsgGUID: 7V8nr/xoT4+tSSP2RRY/nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="100932417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 23:57:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 23:57:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 23:57:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 23:57:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 23:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxY+ffxBJKCZpgcYe02dVcCY2izLu05CLv2UqgHini8wcys7jSEkHDcylXa4zZ8EIHDm++IP3mIN9dxcE+uamStbngou0m6W+ReXpP+WLf3vCaKLtHrm/NEH/tv44YwYOM2MsoXhNDqRNwYaORvAAGvKDZibjQjtZfmmiG3+vBSoq8dG3npLKeBUbMZlDeai87ketDKenh8mJxvPD32PM593nDYkEU+Q0+Ezu1K9EovJa+UKinF3+3I7lYZlK201dGhAsA+fW2hoS1kAXNai0JQJm4R6Rq8Lr5tPEvVczkGb0upwiYo/srtnCcGf9GJ6ukNcsA9DxkjQ6AkmdqJ8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAFWJHMabDeGCEY9e8bLz0JQHTM8tCwsJjomEMGJ9Xo=;
 b=SqtAQ/mgtC9cRct1F36oV4w9Vuyt5kBWLqeiiaF9onc8ToT0MiGsOgLbdVpSTjdv29wmP1YvK6axv55XQ4/9OTofZopZ3qr0Bi+7vXagwzfp0TFgqOATCLok12Z1aHZhI5n2zmMd+Wd6BXbSmiIy5MCcTX06fydlpSBj8W4iEofcNiZmSX6HLj/eXnc3Ky3WA/tJzdZ5bZ0Uy5lmdjyCaKFdpfXdfmjH08Cexxhj2KZVwsFBGigFLr7Xdtzx0oeX1FbFPqulWlZYMyQAkpOUc/oxtbGUcFuAAeSwze5+pti7UGC7ngjUmvRx3RocA+Yi6jZic8w17JUvk2BXSzsyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8481.namprd11.prod.outlook.com (2603:10b6:408:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 06:57:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 06:57:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joel Granados <j.granados@samsung.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Thread-Topic: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Thread-Index: AQHbBdJ0Agy2Q3e1skGIPwlQ+VX2LbJWc4UggAOr6gCABihaoA==
Date: Fri, 20 Sep 2024 06:57:04 +0000
Message-ID: <BN9PR11MB52761B4848ACE15A7A2384458C6C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
	<CGME20240914004847eucas1p23af12d7ea9f70f0de6a9a900072bdad8@eucas1p2.samsung.com>
	<BL1PR11MB5271994848066586A098327F8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240916085054.gpan37ds7ea45pgh@joelS2.panther.com>
In-Reply-To: <20240916085054.gpan37ds7ea45pgh@joelS2.panther.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8481:EE_
x-ms-office365-filtering-correlation-id: 361ad3bd-12b5-4066-0b0b-08dcd9416f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?U3T69QQTT6T6m4ecToUaYa33pFCPQFTl/UjFBwwpNEB/YfymARfknHlntM3T?=
 =?us-ascii?Q?dOYKiMK7/hU6kBdYYt/wo9T38dOjH4lbPt3H/pXa6PfII26VjOsP/aWkBesf?=
 =?us-ascii?Q?MvlQwM2rJKyrAU9f2yDZQD71xgKNYsUDQ2Vtpz6rruoym3UAWzhcgs3rABXX?=
 =?us-ascii?Q?gveFtxNfirG4YjCXMV8P6L0DxcSN12hgMTgTDQ3cevtZuNnSfpteUncOE9XL?=
 =?us-ascii?Q?uaKJi0dqz9XwU35yDS2TzVe5QqK2ByxrLEDQ7kt4G2r2vGguevdKNB1Y5DhL?=
 =?us-ascii?Q?I1HCH7HBZrz3ete21lDauvv8qo6eYUnk8ajseZ/XeH4HV+TXoetXuUEQYE3K?=
 =?us-ascii?Q?1sUqMWOWv6dtK3Nhm2cOR3oGOjbQF0fPk4qbFUrh8VxZrTKe8mV1jUKHtp/Y?=
 =?us-ascii?Q?bampDvcvVPPMQH4jPjr0tROdS+bvZde7qp1Gw9H437fYYrTUjSZ9olknOIyP?=
 =?us-ascii?Q?7w+EJJtT6A14kE2Ds/7GKIyxDFysfwReU668+M9yZuZEZFi3TiV8iQMlzzAu?=
 =?us-ascii?Q?c1GPF6p+fZkM7uE/51vIdyDRLgErj22fFFeLdKoe5l/PX2uUkClr8i7oC4Jz?=
 =?us-ascii?Q?DxOAjmvMJcGgg1mJeuiglx0cuwu117M16hQQGZRsxGXPQTcNSVRVJ+1WplHG?=
 =?us-ascii?Q?51qQY3wevHIt6cYYlBQqFtmjTqYDE6vSxoLy4ywiP21l6/tWFLy04WAERsTU?=
 =?us-ascii?Q?icNo1bgE6kh5fj7DpqDmp4xLJnP/r4mNpWIkwf2mGmdndJ5WP3qOeyxyQkPu?=
 =?us-ascii?Q?TyiMMauA6G6FabHXGfCC0jDPKZgR9zFoa/8kWd3bD39jcobICA0w5WvHYbuh?=
 =?us-ascii?Q?IIKMZJIdR9EAcsIe6vHj5spjmfawStZsRl/qwvDJq5hD9PP/21lV5+glNC6I?=
 =?us-ascii?Q?xR8OcDNdOEKfqD4N7nC50tW/XP3ZA63AP0n75Ydd3UzGzxTgg0yJ8erGLoGX?=
 =?us-ascii?Q?fyBJgO+5vj5Bq6sn6MmV2cVhFfPeF1tjihEfaeKW7KomLBymGwPl+yDmUqHt?=
 =?us-ascii?Q?NzPRNdTE5WYrB24Ax0P3ISIg+2/3pbvbayGzNBTZbO6r2OdultuiFrTh2m2J?=
 =?us-ascii?Q?UgZh6ORJIkxUYil8HuCoXxHck0yhXhFCGJ0f4rFfn3ioP9yWBgUKz+zZWP96?=
 =?us-ascii?Q?uzdj0hR66L2vSnE92aLivT7O/xnbhTy/QW2u/Kt8ixsy/CpYGJjjez5/G+fv?=
 =?us-ascii?Q?jCvVgRzJBxA0M9hiKAUiz9FCEHEvDumX2LI5Y7ya0FJZxQjB9MonAa7Ju/pq?=
 =?us-ascii?Q?qTF6k7JXP0J2LtWbnVZHHee7+wPMSUV7Dd7JBLlGoXffum0mBi31ePS+O1ss?=
 =?us-ascii?Q?GeqLNssAUkx91fwv/77NTIS8TL8G9S/VukcVjmApNE08S02UdU3PpoLzSQVC?=
 =?us-ascii?Q?l0rw8iJm6FN5KXlkTmz+7s+/j0UbIbYEwx55HiD5rqtbUS1wzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Hirl6ZD7eXJbH9IibI6bm03bImnijwdULn23dZYPNVDTeg/Y35IX1L/2M7b?=
 =?us-ascii?Q?KICrUG7fJCPx+8En4iH6k8AfjpZYgaicgmD4XxQ/UMPflg5FzEi9XgXJhR00?=
 =?us-ascii?Q?5f2eKTKZZSlISmdieIcb1p/o5PzGsoeAcTIikS2DKQEiRRrvr9ueEnfFjK2W?=
 =?us-ascii?Q?D9wAQuxVopXmof8CS7oUGcN2dRZryb/Kyw+OjjC32jPcIh4ogofg7Lst4W3N?=
 =?us-ascii?Q?9p0hDsy8OGKRNp2pJ+qf4dT7zecgyoQ1YLNWNJKfwyFtaLsZ8QNihUzg6xNL?=
 =?us-ascii?Q?H0a22Yn8S3xbY4ZWxeU/HmzbVtt9ZSlnxwAkZYkvLoRMGgkb2oYv8svbzhyS?=
 =?us-ascii?Q?qcDb4Z19xOWjw4nvryDM79A7BVzo47tEJx7aMEgCXMqiOjUsdqpK7pzeZEcj?=
 =?us-ascii?Q?gpZ7laAW0U5IErVoed02MQpg0ZRjmtb7RCxL6WOiEY8BOtHwbr+o2QE1VWit?=
 =?us-ascii?Q?AeqpF2/O4TW9nSH6LNevW/ftaiHz4jSHmGGQjKSABETZ2yibrE/dDvSLICyZ?=
 =?us-ascii?Q?LC07fLFjOG7LzIhco6/1cHEkQwtHY3/WdKf57BQ4f0A9B33bA94rrdfngLcD?=
 =?us-ascii?Q?DpB+VzVxp7Jr/iEmxouYOPRK2tJpHxj3jDxoy+yi09Tdsybazt9C+8Og3jOQ?=
 =?us-ascii?Q?PryW6A++8XUPBb6fuse8b2ZJnyToG7DSw7rLWIxatTp+RO4W3hLSHfaZxb0Q?=
 =?us-ascii?Q?lmrUtqMXVRAdlEYKwC9a8Ou3uOUznChD51wP544fbyXfzIfmznq4IbNqAfjm?=
 =?us-ascii?Q?Xc49tg9VptF2EBdAYEh2FfQ3b6S4fFxeu/o8+qdbo54/RIRGxK4vRpjUFSuC?=
 =?us-ascii?Q?wLiIjFSQ0hiojvH1K0QQDFx9hrMlNobLMRule8CMl5suglVcSc8lZVcimlCs?=
 =?us-ascii?Q?MLXHVJQJRJYtOqFDaMXsY8OGnicC3cLy001HkwD4CWb2x10s/wWF9UFyR1ce?=
 =?us-ascii?Q?ow8uK495wRYh+uBqSLXryjzs39CpXzN8ksP/HUPxQRzvcgU5m3sl2SvLNPy2?=
 =?us-ascii?Q?pY/ERDENaQDrJEqNZ40VHyK4aMIZJvB6StQgQ9c5qRvtALEGUfSnUgxyBNAb?=
 =?us-ascii?Q?eNElBYZGbfyxOx3+D5tm6B3Yyv5XqMVTfy2hG3JGf02yq4yIFD/VJ90Yv1b0?=
 =?us-ascii?Q?g+ovHsMfp87tADsbQghQo2wPsJddAs3lpK8VF3VhPXM0aY2EPH2QshUn3egi?=
 =?us-ascii?Q?V2Q1i0yDdihdO89VZLHxK4RCLcUq/m2RaRil7v3Js3Ab/gZyqrDHQsBIuSrF?=
 =?us-ascii?Q?6A6EUsyBSwbjGK90db6oltPm3CP0Hj8m7homtp02YjLgg/tJnezLbxUtmZ2M?=
 =?us-ascii?Q?Gnfah6msgBE4zIzbtHyz9CwtnqoB4MjLY6LW68yHY26YMqRReROKClPu+wxQ?=
 =?us-ascii?Q?cqy96ahtlVDnnUdxjpLpc+QTR9MmZWGowcp3YLzI2pq2Ut/f9qYO741JzLTH?=
 =?us-ascii?Q?Qmx6qa9j9bCDjb3pis4Q9KEcCR+7JHQwkXdLjSNXv3LvJOOJfUob8s0OD3zh?=
 =?us-ascii?Q?A9zCFVxKYIeq1xJNkOLTnTGDGtn1taCyfhrr/GaJqGc//ioGC+Tqkih1tVhY?=
 =?us-ascii?Q?VBd7PlVLFbPF0evvrTuD0YX8UGm5oqHZAS1fBsoe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 361ad3bd-12b5-4066-0b0b-08dcd9416f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 06:57:04.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqzm5zBHz9K6SZw7Od+/x9xdFUm0Ppa0zKf1QzUkobh8iTwHwXoHWyDGgNn5Ngju13oFeP0zp4JqjLF+zDaFaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8481
X-OriginatorOrg: intel.com

> From: Joel Granados <j.granados@samsung.com>
> Sent: Monday, September 16, 2024 4:51 PM
>=20
> On Sat, Sep 14, 2024 at 12:48:31AM +0000, Tian, Kevin wrote:
> > > From: Joel Granados via B4 Relay
> > > <devnull+j.granados.samsung.com@kernel.org>
> > >
> > > This series makes use of iommufd_hwpt_replace_device to execute
> > > non-pasid/non-svm user space IOPFs. Our main motivation is to enable
> > > user-space driver driven device verification without SVM/PASID.
> >
> > can you elaborate why IOPFs are necessary to help verify such usage?
>=20
> In retrospect "enable" might not be the best word to use here. We are not
> "enabling" user-space driver driven device verification as it is already
> enabled; you could already poke a device from user space. But the whole
> poke
> space was not available, you could not test IOPF without having an
> SVM/PASID
> capable IOMMU. Therefore a better wording would be "Our main motivation
> is to
> expand or facilitate user-space driver driven device verification by enab=
ling
> IOPF without SMV/PASID".
>=20

hmm did you actually see a IOMMU which supports IOPF only but
not SVM/PASID?=20

this series alone has its merit, e.g. postcopy migration might want
such notification. But not sure it helps solve a real problem in your side.=
..
