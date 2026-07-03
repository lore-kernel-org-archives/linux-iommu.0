Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705C3009D6
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059648; cv=fail; b=jSiLJoHcRiGrGudZuSb0q8MLJ/c17yH1ebQWJlNezOMMbKf2r7LEbkC3KRr3mSucJ92rrTqVf0yZ8vJplTyryX+KBr8iKX1ng9OJsDxBnJg6UoCxPhkkaWoBJuCA2X+emq/6/zFdq/7ZiiUBkZ8AVAsi+hZ/I0O5a5gTEtNBeyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059648; c=relaxed/simple;
	bh=DncZT/ishEuS+zZvJiUiMh3FAZQI6x3Wdb4wJrwc6Bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1H0kw1+UZBx3CqNzazTO78q+/EB2dEOaN3iNkDrP5ao4rXa9MvTsqmRMopSHaBPYAM+HzBO9Jgd5iizRGtRIvm6nddIuk03Q6m76W0qXgak1i8czenwLr1fQaIlw+sz5FcH333OnT47RHLcb/X5z02dJAaek06VhE+wEVnO7YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYSoTt1+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYSoTt1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783059646; x=1814595646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DncZT/ishEuS+zZvJiUiMh3FAZQI6x3Wdb4wJrwc6Bc=;
  b=NYSoTt1+62TGPAcSlIek4czPxq7lZRhC6XB1j0CZpQKHAE6ixmeYrcS5
   CZj36EmWqhzVFuINzHToDse8IyhQQWaSNRQyayVyMXovApZNWKL1R+Zuo
   RBWs+Iews7UXockZ3E/6nqqBZ/K2towRrPzYQ2heYYLf1Hl1F9Y4kzzh2
   j4t/eXZ85Jw7Szx8Ua6+IdSz6tqXqvcHRGOfwuTYWO3y12Yr12mJ/AJa9
   BfOcmXP0+XjJT+pCy+WGUHkSyMmHUTiHi4WnUkiMktCAA4JSkINM6/0Vf
   WdYpZoa5ftgxI2YvAFZZDycLLRgll8rz1T7aNUPZTYf+7VBbwiTBl3DCC
   A==;
X-CSE-ConnectionGUID: 1aWhWzQRRgiQquKUMFmmSg==
X-CSE-MsgGUID: 0b6/jLALSO+OQ0GUa5osxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83793497"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83793497"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:20:46 -0700
X-CSE-ConnectionGUID: QOpVcKFEQwy4XEXxp0c6Nw==
X-CSE-MsgGUID: 3LA8kCtVRdaNePtSJZhaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251307597"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 23:20:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:20:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 23:20:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 23:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmrjZcOC1KPij55QTODWuhHUWASz0ajKU8vXGu2gVnqLKYvoGFx0VwmFpoK7tnk8AS/ctVCS0tYMZYVTj/OqbYhSDRd3gAZkxGJB9BE1O8GmZTLI991z/FCWvlNtBj2b2xhZb0N62F5Nj11f9JwwGmVko0JJYcxXSrA34R6yVORJN+T9pkQdZBha/duDrwQGN4xq/O7a98WT9f5tYwKz042lPh5n4yRr31AzRylkn87x0E8iEJ8VMumQfQAX9nnOa9A/iQqZIESUwBgQsKQYufSnM7JRqhgYkvhWeXhiv0680iNc7887yyJXl6c+Ju0BSr66BSRTMAmINY8WXGi4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Abde7aAelDCc2lIwHGTBfTsjFMB2SoBlZSJdccu8I=;
 b=O3zMG5LuX0QwtxeLof6ql9nnT4MWzwrEO9ntqUjjFkomHaq5WeQQTpIBEWEED3DYmfEwV9Kg3EYzXpa2geWaiF23jrfIWcpPMKqjf2tVxvNWSAVS2rZpl2+sbYFcSiI3WdSZr0O7ERq0pftGirGxkUGLHs+zMH5va3pL4QqF8ueKxfVi1CWQFh981CYUIrlxOuu7eMGb9TAIom4dv/dqEk8Zk3UdU8FuWOu4OeJxdswG8SSlBhd3dQPIZeEqlu0liAzNsZ5O3XyyJ6U8NvLnnJqXBrs2qHtGVJW6PXk6GIuODIjRuQSVjTqVecIMHZNplLsT7QvT4xAMajJm1qviuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:20:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:20:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits
 in invalidation commands
Thread-Topic: [PATCH v1 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Thread-Index: AQHdCAyZpV9/sNmrVk6iQ5Tzfj24zbZbVjZw
Date: Fri, 3 Jul 2026 06:20:37 +0000
Message-ID: <CO1PR11MB4835A412EADC0D56A8BDBBFC8CF42@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
 <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
In-Reply-To: <eb89a1c564956d9a2ba1d56bd76d57defac205aa.1782767398.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: eec088af-ab7b-40c1-fbd7-08ded8cb32c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|3023799007|56012099006|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info: PByrdTV6Q1c+akEbxlUTGLuY1yRqRtVEivgng2kIgV9rbFnZmtAEFDCT6pE55B0zy/9Xkc1koUuUTElb8N+XkrPm1/YKFZ1OmM2tWt/FBky5RXZYtsRGjKcrrV1cOAuHyvNgucrOCUfajt3Rk109rfqbaXgRWgVz/zb8hXyhLIXf/sUgE3UL25/Z3RXQAUrkbAS7AgzFWntvCngNGeoeluCT8gQ5ZRt780ENdkg/gKKMqhPEeIEGgE4abXtbSaE8CeDPGbhdGloNqpyYkDc0AioXyMfY4SLtpyrco8WS6wta7MoVu8e5Eev7lMeWOZtphO7tfllVf6UEhsvFsoWjwwEivrCneer5O1qJcRXHQhlh1juqi46NIxU+1SWKFlcegKDOWdLi6wVe5wyJ31jFHD3rHtUnRvuEjeYmAHgYYlL5BMDrAc8PZi3y/NubIGlPY054vE8BLom4QJBvWhrR6108GymJumuMx4VFA20pi85EQDrzcFnHvji5ApPXGehprRRUrzEcM9HF0atwg4imDLX+MrnYZ2kKei9lQYdI88tSj7nWhPIr4UAosEUXoc//M1OPYbc3s/A/A63AU1DlTWWzzVr+K3bCXfZi9lSJkPSofl5hrOgWzTb0zlIlcfqeArIMvRAHlNuJjyv0ld3LHgyKUmP5yIsdfiyy6qfAyU7hcm26eopQfFRgu/cYqcozvIBXjz3XQ95mpgJtlmF9mwp72yA6sDIq8FuFLdXcEzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(3023799007)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpGraXY6mMyvJeSPhPijJHDlUmssQt6VjvbGvaNl96we8wK+WBANibF8HrQu?=
 =?us-ascii?Q?iqmPiOgoiwGL9+LXdL61lPgZbLiqoRUp2GaOj/gvTTAJeBsaVAf2kvu5Mrac?=
 =?us-ascii?Q?sSdQUiTo/Ql3BJd4RIRyrEtdMPAbABDC1QZHEYXJTLV+O6IasCJZOQEpiZZg?=
 =?us-ascii?Q?C6tadv0s+iZ25iiE3OhiKN5Vw2FlAS/b5r6mgc9NVXYLwbqgyiqAfAg9kuj8?=
 =?us-ascii?Q?ygjtaRX28PCJBDdjGxkFuJQy3qWOHcm0abMtO+sBnsX/fvujT7SUPEEfsxhk?=
 =?us-ascii?Q?RX58GfhHJqg+V5hCxOR7m9wUaJiVJg8A05r6gOwSdp5vowjDsBTcZxmFuGj4?=
 =?us-ascii?Q?zrWcGAAGwDWlgMd9oJEUWZj3a04cETKjyjjvux6j68zSgbAr8iC4H4gVI1Tt?=
 =?us-ascii?Q?+QIqaHwiVDxn7qL1g2pQtCimjVy7mP+IPtPVejOp0gzepum6/vcFl78NSr5q?=
 =?us-ascii?Q?xxejfTr1kJlmy4SC98V0ryVSsIps8KAFck07EHORNGv5Thvy/eew8bIfnUGd?=
 =?us-ascii?Q?VsuQUu7Zsxc7NdQmFltcxxY3Xf7jVVOyXfc8U3oGH0oP39LA7oCUoV/GgT/W?=
 =?us-ascii?Q?pZA4Qb9HYxd/82z2NayTc1dvKopstzWkCru08xhR5ldtCS0JSzKc9f7no5YG?=
 =?us-ascii?Q?dBm4SCfug6uTEwR1xLj4lWBgHtqwVstadjxPzwX2Azc0lniWTOFD6P2+EbfN?=
 =?us-ascii?Q?jR477uJVbJT4SAFPnNsozfXVjd0TJNYp91h56Fy/wLF+554JNyvvi740qwIv?=
 =?us-ascii?Q?nufqcTEVNZZE+tGMxGGV86vKjnb9RjzNReXb///PAP9F46PbImatIwnLVzAV?=
 =?us-ascii?Q?kmXyejyJeJT/7dOgW3V2S1s4xQ0+17nbIZgOI0mxn8sCfafojtQi6W0QBWME?=
 =?us-ascii?Q?qZxMkoCWtG8n4nuM0X72VWvvwTsCsaYpM25j7RZ8wgDxyf0eB6d79hN5IcFj?=
 =?us-ascii?Q?jyLw7cYSFumHQjkd7xZJrHpoUnTGzJS3l00eGn/T8KzMByuNKWI5sxbGszmh?=
 =?us-ascii?Q?VIixEowhDWn+i0Pul4G9i2JiVjF/jsW574naezhOTlpOq1cTSVqKDVSP44++?=
 =?us-ascii?Q?L2v86WmEyIF+HK+/t0n/Bm+6KJFu3D5Dm5nlD6hYyG6cY4kyE9G0wY5WZJB0?=
 =?us-ascii?Q?Jqn/X8ctI/gAFmNNJG6+qoUS9Ffww706+Wutk2JX5YnRfLs1h8TrYS3bGbwx?=
 =?us-ascii?Q?rVRPQqEMf4Kg1dplCBvBMBnOGpaKLAqMXOmRtdO4Cr3pMTyLwG9Yy1fZgO6l?=
 =?us-ascii?Q?zkBNwcgiy6tG2BUu4pCWTVtsCVhVtUWTX4AJYy+/sDPrQf4v2cxXR5faG2nH?=
 =?us-ascii?Q?zkm3uWRgMJlhhcmdpYWXND4E+CdbREq6gUwe+9fmAmeMeAzf99L0uhZYs2oH?=
 =?us-ascii?Q?8rimgb7EbqTM+9L6/x5HjJ+TPAaZF3LN9IUeZCX65UdAkHIns9UySL72db7B?=
 =?us-ascii?Q?sJDHd7flBinvjm6YHk3dVxQBkdd/sZO+13MXw7l1/dLNngzUTyQH1WuxN5MT?=
 =?us-ascii?Q?/ILAN3suqdy0GjdrWCfVpN7EelxePBHb1OBb9ldPkmSla3jH+7slqZ0JRz3i?=
 =?us-ascii?Q?2GiXidVMyuM4wxwQT8hUk/GkEi68xNJYlATD/1vEeu9bP1EbKloGIT8dDCBw?=
 =?us-ascii?Q?JpEpJkIBYQ2j8PWJyJGvll98mqrY7yhuW4PDMUgPvUP423zEJ2akUw25+lvq?=
 =?us-ascii?Q?J8NSZNWVN4zeqcenIjUZJ6ppVuFsA4a5O5OwFXP+Cbj+Jw/k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aar+zezADFa1YBnBVZ3XBTpoSzr4QQ2UJ7moIWGILGB67sfg+VhKXe20QO6f4FtlrTiOykRE61u3SNYSgU9BEPqX/iPLn1GdZILgqr1Ki9VcGelK1eO4EXkgltKl+sw2nhZRD0/D8hX9Bc66MqgZcXxkz7dKmHM2lV3ZztoBbS5NpWhQiuFyYbkOxckw4CalsP3Cl2KAivTk8vwM0fJ9XEXwC3Qx7DX31MUqL3F2brjY6/0F3O5GLR+fIBA6w8u2m6AR0bkwEpfQGVEudacbaPUr/kpkOats9tSjoNbSKtA2/2iWr877Tu9hGZHoWYnT+5XiaQP72iRGL+cOBgIKbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec088af-ab7b-40c1-fbd7-08ded8cb32c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:20:37.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMbDcZIHHslZtu9G0KZuweRzSD14AHo5mRQhv0dULhcb8p8uRG17TtPLx+hGYtkjVWv+LiJ0h9Pm5smeMwQIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, June 30, 2026 5:16 AM
>=20
> The arm_vsmmu_cache_invalidate() op hands a guest's invalidation
> commands
> to the trusted main command queue after enforcing only the VMID or the
> SID,
> and passes the rest of the command through to the queue unchanged.
>=20
> That lets a guest set bits the host never meant to forward, in two ways. =
A
> bit can take the command out of the guest's own scope: the ATC_INV Global
> bit, for one, makes the SMMU ignore the SID and invalidate the ATC of eve=
ry
> device, not just the guest's. A reserved or undefined bit instead makes t=
he
> command malformed; per the Arm SMMUv3 specification, in its section 4.1.3
> "Command errors", a CERROR_ILL is raised, among other cases, when:
>=20
>   A valid command opcode is used and a Reserved or undefined field is
>   optionally detected as non-zero, which results in the command being
>   treated as malformed.
>=20
> Restrict each opcode to the fields that the driver supports and reject th=
e
> command with -EIO if it sets any other bit, before the command reaches th=
e
> queue. This keeps a guest scoped to its own devices and stops the host fr=
om
> forwarding any bit whose meaning it does not control.
>=20
> Some fields and whole opcodes are legal only on an SMMU that implements
> the
> matching feature, so accept them conditionally. The NUM, SCALE and TG
> range
> fields need FEAT_RANGE_INV. The ATC_INV opcode needs FEAT_ATS. Per the
> same
> specification's section 4.5 "ATS and PRI", CMD_ATC_INV is ILLEGAL when:
>=20
>   SMMU_IDR0.ATS =3D=3D 0 and this command is issued on a Non-secure or
> Secure
>   Command queue.
>=20
> The SSV and SSID substream fields require a non-zero ssid_bits, so withou=
t
> substream support setting them is not illegal but CONSTRAINED
> UNPREDICTABLE,
> which a guest should not be able to provoke.
>=20
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support
> IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> +	case CMDQ_OP_ATC_INV:
> +		/*
> +		 * Exclude the Global bit: it makes the SMMU ignore the SID
> and
> +		 * invalidate the ATC of every device, not just the guest's.
> +		 */

I suppose the Global bit in vcmdq is guaranteed by HW to be contained withi=
n
the vcmdq, then the SMMU will convert it into multiple INV cmds sent to
devices associated with the vcmdq?

> +		allowed[0] |=3D CMDQ_ATC_0_SID;
> +		allowed[1] |=3D CMDQ_ATC_1_SIZE |
> CMDQ_ATC_1_ADDR_MASK;
> +		/* SSV/SSID require substream support */
> +		if (vsmmu->smmu->ssid_bits)
> +			allowed[0] |=3D CMDQ_0_SSV | CMDQ_ATC_0_SSID;
> +		break;

the latter check of ARM_SMMU_FEAT_ATS could be moved here before
setting any allowed bits for ATC_INV.

