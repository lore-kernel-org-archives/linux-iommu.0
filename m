Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC63A8F0
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282289; cv=fail; b=K/ieT5bFA5pNqrsQhFySjn6wwQCvMLwRFXAK4UPErjvDnxrAZOlNcSNRcTeeZbvpUnKfs53n2fct0snPBqfJbzLV7k5E5fxoTgWurzQStp5MYl68s1CNuuCApPe9wH7OqhlYHD+XOdRJc3UzMF9LhCUHAWTZ98HKeo4eNlM7Kbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282289; c=relaxed/simple;
	bh=YDW7meI0BQqqB3Tqh+s9vNTDNe8hIjuRzoDUWoih+uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UazaG3JEtaG8/mShn/lXGlLz2Kk/HwQU0qtu81AccANJuoyneezkgkIfnDwBGcGiXN1WKq//yVDa45Ykb32ypdkYm3tLV3QHO4mmjvRE6F9LUwL4m87YOj/978zts+fnFW1VUuaEb5lMwVVVatsrrlApHeBC0QUhzxKRQ1aMFVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzTQwgCF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzTQwgCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719282288; x=1750818288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDW7meI0BQqqB3Tqh+s9vNTDNe8hIjuRzoDUWoih+uc=;
  b=WzTQwgCFNHivNr1StgZwxGZUo4stOwmfsMj3xOF2FIQMbSzIQNLAtbEa
   Ry9ILL2xdSOfVQo/awfN7Tsf/Fsds/heZVyDn61MxkYT+XZuaPok++O21
   sgiEtSYsKTRoT6hzzooPvRYW19uMufD/jMiiVlQYugNeWcMmQrG2wsU+8
   NuFI5YNRTsmTYgcw2DK4fhj9LtuocA0a9T3qfddmGhwX3RJbDu8FhpT4/
   bAws7k776DVkxZShiO0TjpJTWE/0f/Nc5uRPK3A2rjbf0+j7lfyclr04T
   C4OtFZ15bIKyElptUdcfg8ivbeEuZhj2DGsmeU6xQj6o9g018NVx0MZbk
   g==;
X-CSE-ConnectionGUID: fTz6SPjPTuGC3Ow9vovpFA==
X-CSE-MsgGUID: fa2ZAi8BQ7qgrgkVEh/W6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41697371"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="41697371"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:24:48 -0700
X-CSE-ConnectionGUID: ZxrF3CYFTE2XXnEAw3MCdQ==
X-CSE-MsgGUID: fT5KXISPTTSZMbtJY7D7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48662229"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 19:24:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:24:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:24:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 19:24:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 19:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbpQz0jcICRYBXiIr6cHYhx6VVdGrivmCkpnPBDB2Ga5PU/OqLooui+2FJJSTlDhz2lYV04S5WBWAH3xPdBs/F5nXsutzlhbsZCRKudgbafey6QVK2CczWywz2oklGVdt+UuacEMVdwxtwwOHG+npax3bWphjPHGXO6NhwNzNBw8VlH6FQnFEkoXrmKzFNUqAETJivX9Ff3KwzYptBhK86q67+TSXu7xqSCet5lqtfceQ62YHOAscZHd5Oes8N37Gggwf/fxn2vMKn1xd8BuHIVGcSIEDNv2/bM8hZDtqmwfZgUTFSI4+D/KWB/zwTgtyRT7q7Os+zI5RARK7nuY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDW7meI0BQqqB3Tqh+s9vNTDNe8hIjuRzoDUWoih+uc=;
 b=nkYqqgZ4Dt/NLXAqRHBrLOWczkeZ6Z41goGh+fPBd7G3E+4p3YbMmFILeJNzsBKKvv2/4lKTf6FeExM4u3/uIkd8NY1uqcrOTIPoQOLb9Y8hRQwQzSt1d85SfqQHF7wUnxzpLNEF1PREO6JSFuFjfl0EiVTgA+zzdBNhhoyWZSVwZTbBPGJeKheMW4i/IZ4Q0BvJGa2mM0lj63q8V25Q8qVxCZLDi0ytGrIwyyu1N33QvQIqZWrE58OYocIFlP5E+ifDgGfPc1hUElHH/RtJ7D5aIXW5/D2IpEgz9nP+ZnOHLylp4sA0uFIDFrg3drs3M4bd8LZO1/b1o3i7KudFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 02:24:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:24:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove control over Execute-Requested
 requests
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove control over Execute-Requested
 requests
Thread-Index: AQHaxeZQaw8RgNlA1U2OixIxXggz1rHXwcag
Date: Tue, 25 Jun 2024 02:24:43 +0000
Message-ID: <BN9PR11MB5276E2EA3F2E7691127C369A8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240624032351.249858-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240624032351.249858-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 46932cdc-d414-49bc-8e8d-08dc94bdf990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?EWXSk50YNNtDyJeKGBaOLSH8EGD7d6m9xPmHoeqlMEkQ2RNGJtKG3I9XHJM6?=
 =?us-ascii?Q?Gma0ycUgwwLIFpAiXlAv2tN5WdU9vOLp5hFrpUQgPPNk6V0J9C7m3qlGvzef?=
 =?us-ascii?Q?scMbmwYXwsISG+9OL31iu0MnRfMVq3vAUl4XEFTp2CtWJwxKXvZALxsfaUU1?=
 =?us-ascii?Q?YL/hfo1U0eDkoubjk65K/5uU/a4n4EJt1xKRdVcrNdMzzfTYtPSQOd26ExEK?=
 =?us-ascii?Q?1d7siW+cztg20RBVhO7W+AQrWmswE4U20hRZrQVwOI47KsT8iMRYh4Y4j0+G?=
 =?us-ascii?Q?R3Krb6sMPPVoqLe68YE/ur2sx5zEFVOwarIt6voz6TQGkrsI4b2qNsloSReY?=
 =?us-ascii?Q?SSDYd92IFsrKcuWRLqKYctNxbAhSvm9PdxZXGxtsMWgXXSH1JkEM875FHUT7?=
 =?us-ascii?Q?5L8nuAdJfYIfbClZj1ENdSV00HA2SuOLQTkHa9AQizTj5ddG28BYzZJ36olv?=
 =?us-ascii?Q?HL7IclTZxv771YQEtZi9nTQ2Bwyqo0tOJD1HaU+FJpZJpVPRnxtdHqfV3Kn1?=
 =?us-ascii?Q?aM8kUUPaoCNNlZTaVgMvlF6IqJPDvlYDEv7rvCi4ugq3hHvOQEjC8gcuGHr5?=
 =?us-ascii?Q?eNds9brfl7OtgtNKno+1HVEJfTW3i3gYDqLBA+012qXqB2uu4wsNCOLAk+38?=
 =?us-ascii?Q?ppQO4qhVGCcmQAC+63OtXkfJh6PVgCoNljs6a+Km9/ULikq+Ij5wruKK5q4X?=
 =?us-ascii?Q?MUHydZB+IOz3ITddncYozaz3wB6NDYMMhjKJv6IIuF+LYutDXuWi3BQD7TYn?=
 =?us-ascii?Q?V+qINgKQiu+JTkiV+3HcO+DiieabYEYq9QN8B1cAVFkruW9DYJb7z8B9KGoY?=
 =?us-ascii?Q?sEKTDjYeJviQnsVfu3jfxZnqm9k6BkVmjPTwslwbDj1CNNId5LpiDO66NVhh?=
 =?us-ascii?Q?/lvukqhdAgdFmQq4+AQZpRVyCIwMIfLBqrwOWfmwybEyR7JuQg71E85e7yEx?=
 =?us-ascii?Q?wELNels26AsSbV9r8eoRFSo/x1xe/CYhz7PNamd2MnqUV47GOUqdSXmqpM85?=
 =?us-ascii?Q?h4hbQwA8nNQidotkFH7v1zFk9komVZiT9iIXEVf2MGLFGDiQWuGH6C8Bid1Z?=
 =?us-ascii?Q?qHPCU9K13c181Q6WurSVgJrsbQIXQfUR6p9doOGY/fMgX3LrxtRoOwZWU4yh?=
 =?us-ascii?Q?ndcBYjpxaxGkNG/IXmIuZoSUFQ9ttixal6CbyO9FDuBvWcMfdHxTN7Koc2qB?=
 =?us-ascii?Q?1Bq2+gtZOcJN0FQ6ka26lUspcIbOSWOabdQdV8p7QVxeKVGFqXK0s2O3jtd9?=
 =?us-ascii?Q?PNnQwpKUsla9QGk+hA9+MDTd3vSRbd7eMKCVAVyR7opQ5N2VBY2Qyqwsza2T?=
 =?us-ascii?Q?mX+VlBIJmlGMsaoy4jN0Lj1PICSiP9OcJcRjs4TZOANOuNPdLAy5Aq2W3s7F?=
 =?us-ascii?Q?eCs4x1Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohor1Obha19hN3laYl2d10Gx+6ctDJzNTQXX/MykyM8btX6tncWzXIkCnjav?=
 =?us-ascii?Q?ipIj9FR8Ug8TOXdovI8hrjPJunU6EbMK1cqqtkCOrdd4cS7qFf1tuKm3Y8Dv?=
 =?us-ascii?Q?nZKBr0S4vMMkCMXQbXDO7lZjYEG6YUIB0hy2CWM43AcbuTzETthzQLQjKM2X?=
 =?us-ascii?Q?u3tR4W+fvms803/ZA3O0NGvIG0bGLKNUspk926gqNm0aOdIcPTbWLZRLix1d?=
 =?us-ascii?Q?TtCWZYGvBy/uTcJcBROiEaI6Uv4nfrD61A9BvBo/8+SjPFO9ZofGzBJ4CO5l?=
 =?us-ascii?Q?E3DVQaCjhZIYyZ0qv+y8QoQJkp9HKX33T5UYjJ13B3smsv57oFb+CnpP/lsb?=
 =?us-ascii?Q?vQwmBHsJcL02xd5WlzrgrjOG3ry7uhBTrejm6olXcgVXlywkqLYmvnK/Fxna?=
 =?us-ascii?Q?f2vJ2G7C1JjWGnqkdrrPQHnqt+wQXzOGtS/5rSgc3ullNvUnJgY/KXx1NxJz?=
 =?us-ascii?Q?YGpllGeM03xJgRhJP1UKV3H8dheSLThSDDlFblqPX0F8mnkHhhY/yJUEDCB4?=
 =?us-ascii?Q?jd72d4QheX6kBvSiqqD3tsN4uwXDq0dTlo/7j9uEga9DI6Z8wd/80zj+7zb5?=
 =?us-ascii?Q?JB0SHuTKkhBzp3qC21ie5rbRrWixHy70m0QfICjN1sG1I8lRgV+XI6NhQnNY?=
 =?us-ascii?Q?LQ5I1AmNVR/WpnOzTQdG45GIcxxj0RLVLrqjpIDUOJvNQ2Oapni3rP4kXLTR?=
 =?us-ascii?Q?005h0HQAj6Tco9Q5rCwJkDSfUMssN0xmd1HWGy3Mf3siCvnGJ8WsIyDJ3D3p?=
 =?us-ascii?Q?HnAcKnUtZEKtVHY7nV2c/dwzBEJgu2b03PRL5+gisABwNXvLc8na+yK7ZGYf?=
 =?us-ascii?Q?80LX+sc2h2VyqhO5MJIxZ+DRBPVw+xdyuIGtJax8UzwVPvD1J9NugF1KUQ4I?=
 =?us-ascii?Q?PGJybF/hCZO4lKGz3plmCw6wqlMGcxvqQMVpjWdIz33RiFeJ5KtEPoaBq2yH?=
 =?us-ascii?Q?AeUx5+SS6qMYMdpAQaf6yUNkVRB5boZk3AH8EdfE2+6Tvz53n7izrM5BcYyt?=
 =?us-ascii?Q?gITsBXj6QjGdb6m61+FLyi78NQbKqoxkp9mgN3F/FPuS+9By3PkuFtO2s7yY?=
 =?us-ascii?Q?v+DXpqwGUApVhvyQePHabblEti/TthVDVnIopQo/m5zmXfyi59oVpWVywcnP?=
 =?us-ascii?Q?tVsFcNIhYTzioKj5WYPSHL2ddHMoNCqOWpTt373w0bg1IX9TE6uX8ApHU0Th?=
 =?us-ascii?Q?3reANtuGSc2mBP7gq0HzzrPJ0WEvGVTZpq3dh2wjMQ2RjTVIAciDozPtj1ws?=
 =?us-ascii?Q?EfqIl/KTSv2JYaOBUjSfYhFNwRIIjMw+7DWscgPlO6Q6eJgCYIOi66QpM05j?=
 =?us-ascii?Q?PtXHah0shxiHbDbgSCvbwsGV74I8Bt0KAw1wFzojDR0r29YnL8W60rYQJXzm?=
 =?us-ascii?Q?YOqrFgmj4DYuCR624cPGjVdmhTe0FOue+hpzUAByGEN67VOJhd2N5tUFvbFv?=
 =?us-ascii?Q?CVGepPOhStb8b2aHaYGp5LLfsb8qWhzSOo0TOiAZ/16bH7LkdeWfGN7opwxS?=
 =?us-ascii?Q?WFBiNlVLNSKvFDD6qkk1THSqPwVFRk/C600m0eaIR1czFVFPZMVBf7Z2OKSF?=
 =?us-ascii?Q?GMQ5kY7g6XHMdRMHcYD//TKVjMSgj0LJJeepZHoW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46932cdc-d414-49bc-8e8d-08dc94bdf990
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 02:24:43.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrYtax4iAHaZ9LtdcJFi/0jBQUT1U5CqIzYKb2Bi7JLXa+IZB+7GkdvrrMwrJjhhotRkch+XA+c05DhdiJLCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, June 24, 2024 11:24 AM
>=20
> The VT-d specification has removed architectural support of the requests
> with pasid with a value of 1 for Execute-Requested (ER). And the NXE bit
> in the pasid table entry and XD bit in the first-stage paging Entries are
> deprecated accordingly.
>=20
> Remove the programming of these bits to make it consistent with the spec.
>=20
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
