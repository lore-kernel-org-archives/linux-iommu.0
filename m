Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B51A23A2
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257103; cv=fail; b=hVARPZ8uzrPUQJBk5FaKVsRsVeufgJNMTLX5ztnSncw101kSftzw78JvPTV+f/nVtdFMkAUKx6zBo9BIlpd9coBitpr1KYtChWW0ANfIOol4onOZAukfpHFOKrlcEco7rnodWOk8L7TcUtoabIap6+aUfW+sLxBzTVvIsXmW7sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257103; c=relaxed/simple;
	bh=E8wSNf4oqf7a7+J7LF5+Pel1M35dEhWWvol3lKkXAro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8IKWPS3ZYgMfCCNsCJWUp1eb4Is7l7/zJmdwshzbnmOBrOslmIxS6FlntD++212pstKHPDGnwlCFJee/5R+25II172ooX1JfcQkyhf2TNeuHu5n5XYQ55jC3W/2pldaga9UTmVoPvv0/1VLQmFq+hV8lqXHRyMhXP2Ky6qSqcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/TR2+w7; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/TR2+w7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f43Xgokun+5ezE5nC8DOoQ3xb2KmU56tXnPR+pmAY706ZY/irtr4KZn9IUMVvLk5B9NUN/jSdTuYfO6pZfJNsrfWAkDMM78o++dhf5hqNc3WsNb7lMI8oq5PDv3Dy6S02lQI5cBV77dfkjKtRRUhdl0ry9KzhCREOa6lBDPqyuIdqLSBW7Ai7ntaHoVoUoJTVok8E6Jd9VGfpJUHD/1j62DN33cUGJsN6cc2V2tCKk4U4laJ7nDWvZoTJSwEePrvDuz7gDhpFSWtzYZ1G3ntE+Qd9zZqQI/1CPl0mLBHPPrqHUSK1cdfon8R2MzUZiNm15UcNKQqlovpvHPTm4BvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8wSNf4oqf7a7+J7LF5+Pel1M35dEhWWvol3lKkXAro=;
 b=xfFw3THA8kcbPFZ2AFP0IhTPJsQFn8UvpACChxTetSqIiUpkWMpxIE/HsNQb9wMRyEqik6wtoqzGTYLL54ADN2XLmhDPBAR4bZ+UjBcxFbpa61qLfqVEAXJn8CKbY5DU3sGAjH40H7+ilnSPW7Dao+QtIFQ6ggUBcwtJtNGeH8MEw/O96sf1LHKFh5QtgrlEC7CgFvfu2W4l/hYMxOVBVBin6hGPKpnNFyXpnUjD9htNvWtFJ1GFZVx+EptI5zutjpE+mrb2A4xWJzfL3xqpPwZr9t9N82mpz6Bo9MmA5uIt9FFc+zUIUAYGdF3hRyjVqPAIMscGj3+fDPFJ/ss2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8wSNf4oqf7a7+J7LF5+Pel1M35dEhWWvol3lKkXAro=;
 b=J/TR2+w7/IbwyDarfAo56nAdHI0DmEZMJPFJdGC/5JOzkpWRYobbTRFBcD8q3kzi4Ipxy3Ww4oKpImPKl86CeQpJHaYY9UPc0scPmOXC1reACfjA3AaYidi375BIiVdktpbLL13PFkFYZeq9/xhO4FDUz4hBXQw1hbMqgw9OFAsxMH7f6WGVC6tNfp9B2XladtPEERS6QYOx5upNdRZJ2BAhSmoXlgqR7ohms5GT5+X+ols9q8/GbRBboWgjbqg2bdsEKMd2vBryDcn9jsX6C1G8WmQfDxM+Dc/JQaohDtzhOEO+pkKBqiXz/SiMNf1nwnqWLrIqMuvLKiNkeCZnZw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 10:31:37 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::ae1b:d89a:dfb6:37c2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::ae1b:d89a:dfb6:37c2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:31:36 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Set domain->iommufd_hwpt in all hwpt->domain
 allocators
Thread-Topic: [PATCH] iommufd: Set domain->iommufd_hwpt in all hwpt->domain
 allocators
Thread-Index: AQHbjhRKYYA1hsvnkUKaWgEapVufirNlcWuAgAB3VPQ=
Date: Thu, 6 Mar 2025 10:31:36 +0000
Message-ID:
 <SA1PR12MB71999DB4E14F3A2F4650D964B0CA2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20250305211800.229465-1-nicolinc@nvidia.com>
 <BN9PR11MB52766B3F3ED1F7F14EA3B7B48CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To:
 <BN9PR11MB52766B3F3ED1F7F14EA3B7B48CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CY8PR12MB7609:EE_
x-ms-office365-filtering-correlation-id: da38f520-d5e7-4211-1da6-08dd5c9a12be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3lHbY6JdmB83hOB3C6njErp5G0jrNKWoCYhXKYOldlBgEicWBr7jtDrTH0?=
 =?iso-8859-1?Q?QpyEEfleaX515dlQnCCKwTCXhjyBT+qKq6WH6m8EoAAZrcD51MaVCLyHby?=
 =?iso-8859-1?Q?LhUMrJ/W509DygEgUf22ih5FHF254K9kjTsipF6tsPqFNYTJMTJWKsNaVZ?=
 =?iso-8859-1?Q?I8gW5cmmyBLIDb7cAlFPdNyG2suui96+8WeO+7r1DbnsVgD8fv1xW8W+d8?=
 =?iso-8859-1?Q?0UGPH+eAIaxWREwwQupzWfK18gm1Tk7xv5PXMZdl2GJvv5LgnV+fFnrAJ1?=
 =?iso-8859-1?Q?yZAOSAuK7bLvidfygg7L5bKjPq9Pc/4kLFz1AWCfYgQw/lSl9zCV/f0lqV?=
 =?iso-8859-1?Q?IH35jLkc6V4029j31rcxydzhfkW171HMaSkqXoaEq9Tq+zrYV38VOGt/Kh?=
 =?iso-8859-1?Q?IE0YkfYd252PLsVXYIK6XWxS6hi3B6ks2yuAScMYDRpk9IoOBEAkCW4b3i?=
 =?iso-8859-1?Q?Za9l5UrIAFBJB67dlgA3qv7sG6GekRZBzPlPCgkJdeCsJV60vRSpPxB37q?=
 =?iso-8859-1?Q?JDxXSSQaWsr/G4cQesnWRpzgmVHUKAvoAXL6ej9voQtXXDtxN69LAYAyBe?=
 =?iso-8859-1?Q?H8U5U+3EcyIy6UR3nG0x+8l6RNdgvOEVrqhJA2ZfolyusuyXMqHqMnCmAW?=
 =?iso-8859-1?Q?9F9VXFBzw4O/jQ9yOYvJ5T5/Zt2ke4fKNJMaZW7AD7RtqdzVrHKylIxuna?=
 =?iso-8859-1?Q?TSCXPCn/SZvJ4HXMXcJNUqb+i1XRpZ5brekgN50MPlL+4+JFO1BQVkS6yA?=
 =?iso-8859-1?Q?AO2ZBQAeTY3nUacv7gftcbjYuPj7RqF9fyQrZIFOvCFozCPAjkRM55VYPN?=
 =?iso-8859-1?Q?pbycRI1jCNLb3S9gX14+KRV3RTag70KYP0z5k5dg4u5XQ5fMXlIg8XlmGD?=
 =?iso-8859-1?Q?qz+RvUswB3GSnBeFdmgXopbb3MSFqmTOXR5q4682TUNkRPXK1OgL7g24X9?=
 =?iso-8859-1?Q?thYPXYvXrtAA+QAj8ZC4MYyIUUg0ZgrAuO+peO5EfqA27L5KzEZ/0ndVZu?=
 =?iso-8859-1?Q?/qdLxT1HDPdC4pBIwTLxip+aRjLLeSgEog8/c2iK/WJ2Ft9TPd2GoO44kD?=
 =?iso-8859-1?Q?2xrCUN9FRWeuq2WnvSe7+ixsNoOgwIqA9rabjs67F5Jg7Zfs3ipLiOYqMA?=
 =?iso-8859-1?Q?eA///e12o7y3hJaE19Ct3P5vW2zNfuHpoGYy6vQG6uCbtYq2IXPEFCeYAa?=
 =?iso-8859-1?Q?yqGGTlPWxlf3J410Zf5hgW1ikw3W6sDW+aw4h48qKHjpr8u3I/bCgPFZlq?=
 =?iso-8859-1?Q?L1sG15gvUUgoqifmmZ+1C5PgRa1O1SyHNhCcSwOvczPZR6PiW5yMih9fLN?=
 =?iso-8859-1?Q?bYl2cQZu5g9/COJ5GEPmtIgYZX25TXjN1xG2tY8apOJbp2s64hN8xF3NgD?=
 =?iso-8859-1?Q?PSZ+B4fdkl+aAXm7TdBz1Oqd6MJvW4HJELowHA7+rtHnjYL0j/JEFYNuN9?=
 =?iso-8859-1?Q?++BvT/tkFtdWwsBztuWHWEJWcUUeWbv8PGG6iA4XICXhH917jDc2YF+fKq?=
 =?iso-8859-1?Q?AKVMLJMRI/ufid6xVc9zQL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VXq5jq3Fo4GtOXzhUQXTBjcjHpjqi2TvM/5rFWTxhdRluU9oPSITPNDN8M?=
 =?iso-8859-1?Q?aa3sR4minPiazPlQmD3+WfZ7zBOYUVuSf42TTPfzPldbx+EArIfOmHuTKA?=
 =?iso-8859-1?Q?YasCjNw4pKWlSy4Zulf6IUaz7/PR9rJn266WXTlL8L1xVfQCNMVcTOzXYG?=
 =?iso-8859-1?Q?gh4B4sfHwCLfuFtR370dYICArQlGRy4jm6em4tJz+HTwsX/u86WMHvyEEw?=
 =?iso-8859-1?Q?j0r+Bc9IAYtsDfuVoQ/0ebBejSYvmoViQJrvkXudFyc5YdGwOs8XkgT79w?=
 =?iso-8859-1?Q?A8SJJdaapqFqKixjpKAivleAciVeCoXVWdrO8BR1Yx2Mp9nxVCQGor2cnU?=
 =?iso-8859-1?Q?Nx20Z+wR2WiuRgQurpyBLY9/Q4mSbMFUQAjd3kQPGaCq/OsGQW+1nR1Epk?=
 =?iso-8859-1?Q?PzpTTRKiyyxeiVqkfhBz14mxsJskUjKNBpUfpGUsgZTLTX8yQ1BRDJknjq?=
 =?iso-8859-1?Q?MiG827tiZiD+aG8OI2KGWM/tGpSBKG2N8IIl/KYQYFyOly//69r69+ohzn?=
 =?iso-8859-1?Q?KZmnQPz+m0h5MFf5vClTovMDmQXc37M535RE+TUf9gwwcvwoxOnViLgs5t?=
 =?iso-8859-1?Q?t4Gkj6DGqWSUfLpcpKp0eG7KbbtUkE698eG6A4cdCqill09cYP1pX5NaZK?=
 =?iso-8859-1?Q?j82Q5JT2yI5WMiJhU9rn7BxMT+iNk5ASejzVFGbx1+XpLFPPeDcBQzHjrH?=
 =?iso-8859-1?Q?D2I4ZGfsj1/Iago4vZ4MqKFc3GKgNH1zcHdBNvWTfs6f50TKX5o/jbKu2F?=
 =?iso-8859-1?Q?0pNw+mFJv/oHlR4yxDGCimzVZ+dne+defnUMlwpsefro48TOzxuQaZXv/X?=
 =?iso-8859-1?Q?NMbW8M5OigDe/Xx7rb+3/YhJZ66+HboRZiAu3CP5bv1+4c6F5BgA5nV8FD?=
 =?iso-8859-1?Q?aW/vcnNPesAqSJWkJO470mG8kQEfi0bMge+xccr04/w4DAEW/Os/dNqr1p?=
 =?iso-8859-1?Q?6xCmfOXltQXxlhFV5hJgACSd3FuTiAFdIJlZFjwM78DwRZe0n2nVV24rtp?=
 =?iso-8859-1?Q?vJ2vSNvU1MUxZG5vehKvqqhEeYZOMYdmD60r0BAM3M5uog990YPr4I/3tU?=
 =?iso-8859-1?Q?brftq/FJvzpcYXOMKEC/VHiCZFWD4b3+0g2wNmJs6DHv0/BOuZTJb2GGv8?=
 =?iso-8859-1?Q?IjmvCMFFrl69Bx7Ruzpqz7yin/prwZCcPFTYQzQKAD3F2jkE06BcAcwReV?=
 =?iso-8859-1?Q?8LpUNa66pv0eY2sSs3mydXf2JkspOH5giAN3SNhqXeluIHSGT//+H0POEv?=
 =?iso-8859-1?Q?C6dh5SRrcszeF7JAEiY+F6w5qeDxPiFYIIfMp33u+cdRQjijc4etCVLu7T?=
 =?iso-8859-1?Q?58f0hXcv/wT8UWePp66OGr/juMBb+jvnf5jve7Ws/K2MthbZ/USQfU3wfY?=
 =?iso-8859-1?Q?Bl0vkOCNQy1Be4OqJg5p7kkVVvwZt3TnHdRF3H/6TPUCJh2T0JTuilH4UV?=
 =?iso-8859-1?Q?a40+81XlM+WCBsoZ0kqaflyJlOCwmm7WgbCWy4BzG9Sj0Rh8TCBMUkf0zC?=
 =?iso-8859-1?Q?BsfIOnBSDQ3+fOGxwKZ8bl8pefwBIYoL5iw8qHY8fdfjLq2Ih664B6OJ5j?=
 =?iso-8859-1?Q?Ar6D3ECNanj343gt6pNBZj2CtM4YiTVZEghxekSDQd2UJAA6dp62KAJ5O5?=
 =?iso-8859-1?Q?8+r11x7zoPE0o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da38f520-d5e7-4211-1da6-08dd5c9a12be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:31:36.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Hl6lJcIkYddZINS2mfJKUXiP/cla8faDr5+hBme/A7+u+ASMl7/ZHq/FkSwi8T1oY/KFbRqbQBluKdfdgvmpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609

>> Since iommufd_sw_msi() requires to access the domain->iommufd_hwpt, it=
=0A=
>> is=0A=
>> better to set that explicitly prior to calling iommu_domain_set_sw_msi()=
.=0A=
>>=0A=
>> Fixes: 748706d7ca06 ("iommu: Turn fault_data to iommufd private pointer"=
)=0A=
>> Reported-by: Ankit Agrawal <ankita@nvidia.com>=0A=
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>=0A=
>=0A=
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>=0A=
=0A=
Tested-by: Ankit Agrawal <ankita@nvidia.com>=
