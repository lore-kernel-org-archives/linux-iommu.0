Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA841C9EDC
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844472; cv=fail; b=rkRwaFwsTbcFXUOepDOBkIM56ImHWA1txTjHRkHZtN+KQIYBAjMrZlJh727swQW9gokhXXap57yJRdcmI/sNxA1zY4qWknxlH9rB8ZAgEm4oVLUR9QTP+yY8u0tIop6eBOPd6ISM3BevuZALlyBeHlEV5vpn08MNy1eOfNe4vWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844472; c=relaxed/simple;
	bh=3b3fbLms8pcCSav2cOERA3gaf0mn43/SRalZ6VJXiE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGEPBnluyuSZ+Q1ZdqNJYTXLxY3NLsyrBsNNwzteOJH1cZAuFkFTuACmSezrYayGxbRT8dN4euFG7FcPP0Z7AumCfkSFPPzOkqpxQPAhkK8IA306P008J3sJO0NjKb7AbyP32xNN0IJQGjqBwKV/D4dYEgKQ4YLXjl/L9Nhg/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BABtmvPP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BABtmvPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844470; x=1761380470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3b3fbLms8pcCSav2cOERA3gaf0mn43/SRalZ6VJXiE4=;
  b=BABtmvPP9vn0I5KFNJiCgadzFINIUhe65OPeLGzMJw1gDHQ1hHOlvdq1
   Oy3wutDgIIu0ulzPEuame9t7re6rQzmIq/dI0B11Th84MZdE0CJvJMXSh
   6TVcfDQsJKqBiclTwO+BidYoFEsCsX0wyeFuK4jvZP7G2dhRHbkHy6GXh
   9iSAeKW8BzMLVkStI1U8ghQmoUAkqCEWN7/Or02Lk1rveo01v+bMyk2dR
   H58R1M7oJdnweSWix/loDs1KkbNlg55Qj3EBSsiSycEuBxTQv7TpxPefO
   CCWWtIZ8sOCZPfBZVOzIzkKeoQlxLlu09xAWh9gIc3SO6PxIziOtSGghf
   w==;
X-CSE-ConnectionGUID: nzopNkRcR6OC8rnAhIY2YQ==
X-CSE-MsgGUID: VSXbXKoHRyezuKpqw/VAJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40880290"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40880290"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:21:09 -0700
X-CSE-ConnectionGUID: RYRLmRbQSjKghSNObykX8Q==
X-CSE-MsgGUID: gLx2DFatQYqxT11j81MTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111663952"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:21:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:21:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:21:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpvycM/eUv3pTMv/DrDkgpG0WLzwwWGWNm608Lp5MHWtbm5f38ZcGj+04/H5j55IfPSS97pBdzuhdkcb7D0KyZu4a6ieueRtFHF5/BxXHIj6n0nIyfXK/FKFSDgUii87uTwpH4mF6+iSR6hAcALLPrkH9b8jGyP7zsMGZHh5M8XzT1TGdHGzhQV45KFFcVnDnn18DrK/MP7gHCvS3eZJTX1RdpBZxCdlmtFoSCLSf30+h7cUApN8rUeSWs6oJybKZzYm35SS9crSNSgF046fI81uHdabcmFlU4GueMSl/5VWXCfCS/KORfJGOAdQlmdGkNc0IXZ8toWtvPwsLdXxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4unzhFwXJ9V+FQ9+M5G/fV3g4Wz2KLNSLwnfWRRWz8=;
 b=HDNX2GxcGjizhhtx4yS2uWkpDM0klm145Y/nyjyI+q/igjfS85jZ1aVtrvox4Q1tnt85D83EoaynaxAK7mhU7alaMga69WAMVLGTH13+4OfHSIkqW2DY8Pes9Iic0k+C8xbzfgTomFTozicXO4BTvWNPtGXEHnzMpQVexng26mqz7sEaBAgaEQ23Zph4LiaBRs/ABBRzHQcJIIBbRkmw8bDa1PgffXAX+m7flp551jiSoN2Jp07JmTptgkTivO5Qiinqjtdb7MjSn9NYBdCKWcBzsAPvyMN5Oikibr4AOhuH8RPErAxUQ47l70bsiEIaM0jkHeuyHeEAWzk8EwO9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:21:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:21:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V6 8/9] iommufd: file mappings for mdev
Thread-Topic: [PATCH V6 8/9] iommufd: file mappings for mdev
Thread-Index: AQHbJikRMpX/VHQ4SkW62uEGsz13m7KXIUNQ
Date: Fri, 25 Oct 2024 08:21:06 +0000
Message-ID: <BN9PR11MB52768564280584355ED2323A8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-9-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729783554-56916-9-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5085:EE_
x-ms-office365-filtering-correlation-id: dacf0ede-334b-4bc3-a43f-08dcf4cdf940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XCx1WfUCa9KAqSpUP8Ry0tob5lCBtLutAXbpiq6maxI2C07LmzQNCK72VWGX?=
 =?us-ascii?Q?zwHJMsybbLgir11CAXM4lyAfGRYn0goCFqO/olfQ58FnK0MzDbXx+C1ZlKEm?=
 =?us-ascii?Q?2F0Aw3NT3HVlQ/CQLFZcYzLYbMFdWfjecR/j5ajbAFQMRX5oMbDoJDdscdN3?=
 =?us-ascii?Q?rhknnIYC/hjO95D28h1GLUh7cKLzBOhPy8v4JO7wkbygaeJzBcPm74eW0WhO?=
 =?us-ascii?Q?uXPRAQrmMUHaCmqwZSN+czC7TqcF3zMIEyGq5qHdsH2p4uh7cTdSCrR8TIDj?=
 =?us-ascii?Q?LmRsiIria3GM4d0XdgnG4M15PQzF/9z7zSbxLxuCcfxXpQmhkLE+SuHuLejB?=
 =?us-ascii?Q?k6uYaxUX5D7jlx1ZdscvCqVTO+f5JYLAIQksIxxpImmJZ+lnFlByT8StzEh4?=
 =?us-ascii?Q?a7J1SdA7z7Q35r16MlXbZbaYLqGwcT7Pdu0lYFXU0kDAznUMgwElIJVAoDpI?=
 =?us-ascii?Q?eMnXhCzoUElg6wTCPPjJ/uQUIR9DHCnPspA2sgTtCI7PnFWFiERrBAFQHuVK?=
 =?us-ascii?Q?Xa5f7sBAnmP8osNDuBEK+f1rXjWj8YsYgKQ1N84h8ENokaxhdJJX9ZIdBtL2?=
 =?us-ascii?Q?7NF0CzQz/uzehY7/JQzi4q3tywp3ahIVdYME8kEhYoqyqKIP7V8poWAEXSRY?=
 =?us-ascii?Q?xhCxxiQpQcz9oSKQOGa/x/Ov/usecTpBzwFL47a8qjQRrfDJT9ZeG0Z3viNF?=
 =?us-ascii?Q?cbDbUoSjWt9XnMUgnSdcFEjgm7J0TbYn8PSll41gMsOcYdh+p/Ze1tVZsUUM?=
 =?us-ascii?Q?GDYGo03W/jzC6ymeW1p7fp0gXg2nltJNmvdvbfVLAg9Ta3YW7cAGBieDxcLN?=
 =?us-ascii?Q?SApwjR7m+61QXGI11hgw1NC/MnZ9XgVOuSsweYvefnv/DkSEtuagY0yUqi61?=
 =?us-ascii?Q?g8DS9kQcWunhvfafIZUB7TOnBe6KFuAs7oVVGlEXbALXngesBQT+tbVzVwFS?=
 =?us-ascii?Q?W6BeU+m83bZCJNREsHGAlY6Xg+Grxjf4ms2mqQsxau2G8w/DN2Snnx5nBmNj?=
 =?us-ascii?Q?4U713hSQg0MggskAFVgy0kIWpq9O/Y7i265DLzAJEMn7AdefyfUzyht1AcsC?=
 =?us-ascii?Q?IICkaT0ISY6z+ru16RJsJPLnWzmxLA0EPnJA0/44sAL6v9OMftio4e5uYEQR?=
 =?us-ascii?Q?8uxdfbRCPm6YODKuysDQaifqFm64dXijfl06ga3trPwKI0cESuX6Tr/EvFGz?=
 =?us-ascii?Q?3LNx25UBbXjLSpsYY6joFs7rVr8JHm06zhhTgMDa9phdci3N8nTfgUq9l9wT?=
 =?us-ascii?Q?b8zasSjKPLnHvAGXJ5zgvM5pU/jG6tV4/tio9CSwqHdV9ncL2oUsEuSt46/v?=
 =?us-ascii?Q?PWam1wAyDuHpdcxg+QjYhyyzp4L+IPGWIGTppDmhtHge6WrksyB5TWvbTsGu?=
 =?us-ascii?Q?PvlJgfk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2wuXugU+HnVLEMTBZpurs4/icAgAImrh0JvPha3khuQPcwxJK9JLccnBhah?=
 =?us-ascii?Q?NkKf1Qp7V42vs9gubZ2S2xrgaUjHH6Igj9mrQbmyS3RE9CZtvb3bSQohzZ9F?=
 =?us-ascii?Q?zqTQjBanfhrXNecmTPhR2G9+y7UZFR/0TIgARFPhDJjnvni8G4T8LQMd6i5T?=
 =?us-ascii?Q?TnmtZkGekwXbf1ENEKWFXBa95lA6/i2S8jgaEhGaOSWrKwQ2Y0JLnvz48ub7?=
 =?us-ascii?Q?OgrtEvTyJodeFThn7uoEnbh2zyESwn9pQRWkuchVDCWB1mZlv7ymsSfxHVV3?=
 =?us-ascii?Q?I7+Rpgn5Zyre+lHHcXme+T7fARGdBCvnZQM6maVWypugiaj+RMnobPwk7bGH?=
 =?us-ascii?Q?C+//V59nEvuKoB/DEpgCj3Mrp0Fg6s3OvNBlpmHdgHyWgH5hwJ1ug2Cw+xA6?=
 =?us-ascii?Q?DQL2KPt6pAVYvqssRA08uUz86GynNGdscVIocn2c2gOPootRocVfRyuypEPv?=
 =?us-ascii?Q?onOPnld+XcZhuyynyi5BnjTkfOpyyXHlf8Pb0Uiudc6egNYlVFWX7mzdMGiF?=
 =?us-ascii?Q?CJIaCjxFOjTdOX0wXPKCc078CCXiIE8uxPjCigGvrbF6Kw/PerB+vVoW5VmU?=
 =?us-ascii?Q?gppjjBaoEdZigVubhnlxSzhlUq/Xo4Vzh/1BiGvRs2Pa3F/tSKeew8iVrLNT?=
 =?us-ascii?Q?wTtmytmWvbNlToCJRTt6MAdBQvHhfTa8ioKPf+Ns1t64rMlZ4EvgeICjoEvz?=
 =?us-ascii?Q?X1yCZW7HLwvLRbjoTRliS6DEZlk3WF0GACqcCbqplZgLy+CPN47CEvCiE3Ci?=
 =?us-ascii?Q?yRd4ysOvvxRP3KLIuGTYvloTB0Pi4pcJ18lTz4n+I1HxpOQaWV2iR4Vv/agl?=
 =?us-ascii?Q?5642pS11hOOCo6ew+Ij3746aGMq2kiUMc50wPwKDvjQw6yq3n3rYwWlsIoHE?=
 =?us-ascii?Q?BebwanNSAmp65gHHZ6JlRdGP4zWvbVXqxXrQeB6EbQ0SrzPXJxhhoFDrlwPw?=
 =?us-ascii?Q?jZha1WqS7fnxBuyUlS48aY4JkLh+W6gv7zDwouBl8r9VnhyrEelzzMgkFmxT?=
 =?us-ascii?Q?8MuYXl36fVdW2R9POyb0zVDDrIuIzPsmKho0CF1hFfZ3arG7TVYfn5WKb2QI?=
 =?us-ascii?Q?YncW17ZmsHTEgK0ObZSVRfKe8qDgaE3yAwgIFZAoo5PafUC/a/8+zKA1lZ6H?=
 =?us-ascii?Q?WVuyXTe1//Y3fs7tlTgN0mHFyygi72btlPpDTagMNCFmTLTE1VOfXRMdql26?=
 =?us-ascii?Q?YHyU0ThnrGSD/zKa+3z2vfzAuIo+3CQIWdClqzUucb42AV0jM2p0nrxUX//r?=
 =?us-ascii?Q?/g79mF++WX2f0zXNGmTWvjxPHqfMDfyaqjXeJv3yWuSHBXmZ3UqEwesrcp7D?=
 =?us-ascii?Q?+CQH2d2Vgu4QXUoscfKiT+McUxtk9oMIteRaTjIXeDr7J6etpDZO56aGtdqm?=
 =?us-ascii?Q?forSqNyE+NsUHZ1E2krBsnyXQH24cxSSFnFGzUFwmq7CVRvkYKHbGiAdFpiN?=
 =?us-ascii?Q?COwhLPOVh8HcKVPW+f9qCki8/XGVLRXfvAXYy6VSqHXSi73PIaX07nOP6Jro?=
 =?us-ascii?Q?haw7WRlXOK3P62BXda6pn9T8xptU7i/Wse4xOin09upQNJ7pUe/i0HlONbJr?=
 =?us-ascii?Q?tog//yWVcU67YFp8iZNh8wymKuxrH1hWJ6ICsWD3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dacf0ede-334b-4bc3-a43f-08dcf4cdf940
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:21:06.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lF19I0QO9ZfqGVwW+GmSamEt1JdCAz/6FKUaivkaUGWR91hJTmK5PHmVRuJyebj8c65Rp5yKe+Y5QFXW1kb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Thursday, October 24, 2024 11:26 PM
>=20
> Support file mappings for mediated devices, aka mdevs.  Access is initiat=
ed
> by the vfio_pin_pages and vfio_dma_rw kernel interfaces.
>=20
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
