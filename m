Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA015B99E
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968472; cv=fail; b=GdmjGchQSXCEHXcaL/Kle8wFIToN8k+z8ex0rW+1eciW6fKmITpWiI+fNdnW1I8uHGB7QYQbFQOJhg0Z6GsxVscmCf0w780mMRoLScTQMdpyu0dVSWPGYIQD+eJh7X8t3nZelPsb5wGQihoIwbiBKIRYGTZdCzKWXf/Vghn+++o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968472; c=relaxed/simple;
	bh=X4ASXKIUMdeCBLl6Xv5UEqFhfUWP/wUR+/iAz14NgX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CZuqhlGbZ/4kgEOVuvU+WgJYq9yfq8buoXHKsZCkXZ+xV35opcKMkoyUGWaweOkWBqQWqFsVAtbaAZEsuZ35E7l5fh473MM8FmVTZplTdNHmQhgUn9xkX1c8t/jJl5L6GmPDqgzsmx2db9DFHS+/pWWHFdrBVY04RlykxyCg6XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjyoSCxQ; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjyoSCxQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxnk1HAdzkD1N2h9dMTyyB9/LoFZAF8kdJiuDRaMpfivVs1zmWH8Y+wcXZxhLSL0q3Hs+QONpvwMd6g2nZuQha3C3ZEnuRNUXWybQQ+waS8gOm84RwB2WEqtjEuEXAMTaaMigLtUQSpP6V0GOeQ/BKj6sBSwVTbXatLKfVA+OguUT5sQlqLI9aEhsrViSS2KTDl636blwg6tE/Jb7LOaGjhKX7S6hYj7qdU3oeRjXCWrfpq2uJ9ZO+CdsFFGvrCo8h/HI0hiZZ9XTidNB6Ht+ZQttM9qBuS6cy32yVRxnmrHpZswuY+LTnJ1bSjD2p4CI51DgscKVrPxqBPiLX+mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUvC5CsPqIezMIGUBErksPmaWFmbqslD0ZDyHMLjZ8k=;
 b=Wrq8mfwKZy+q9VN6lMcMG3Lpq6d2iz15oet2BdiVIOnhm/UQcE6cDG/cqkMRpyqi8hNeCkZVcV0NA15XY3YsY2NxRiJVHYFm53HVA6hiozRLfV4VxiHcbrWqa/Ic0NfwjWKBx5ofVh+ATDTTxFYX6/H8anScUje/bgfT3q8qSzkKfFvI5LwOQxLqg5ihVZU0aIpzCmRDAh+d1C+/hzjjxzxYTxPbW0nF6/sjdMQ84+H56dBbQAvZGzLdYzobA3TJZ4aZeW5TGPxae4E6jUHPu743OEO3KjcDSSV4wQm1j83stEeQwCWKeI8zfsggMqBnZu6SmMESMLdtTYICromFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUvC5CsPqIezMIGUBErksPmaWFmbqslD0ZDyHMLjZ8k=;
 b=bjyoSCxQnxbXmMUXCNHrV8pidgkRBOPkoDXwDw0xb+Q6D3wHle65SefQpn1sVZzaeNbMYC88iHVl6zmsmtjdZLr+UcowBr/QOv4xsbZo9D6LK+VxxAS58FbPSSOsXXskuGGCuW3VN5C0knfwgbjHJ4QKOrrfrHWvJbefBWCsDgCQlMrd5ME9CVDc8r3QiZbwkq1puMddU6A0o9xl/PlNVQk6I2D8cHUOLiUjL75UYU+NO0xHS3WkE9lO2U+OFSJwhqBg1OFm0CMSqjRpNpnl1ljK7LLYOFXStwfsU0oVaDtJ25SSF8eninYF7TkfKiqGEfTilqMguRwL1NxPD2SQug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:21:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 14:21:08 +0000
Date: Wed, 24 Apr 2024 11:21:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <20240424142106.GP941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
 <20240424122349.GH941030@nvidia.com>
 <6e434a9e97be4abfad8c19dafe88456d@huawei.com>
 <20240424133214.GI941030@nvidia.com>
 <c318c60be2c54733ba16ae68e9c67ae0@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c318c60be2c54733ba16ae68e9c67ae0@huawei.com>
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 8002bcc3-cac3-4101-50cf-08dc6469c8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MP08rYpwD4sxL1hmuebN6ozGoEgIvtBk6dC3zJVJP+zZCTU1zuMGSJbkPz+?=
 =?us-ascii?Q?ggB0cgH6Hymv6YC6muLlddvESfU7MIhjQInqMyW7z21cL+ZDhSCwyBX3xKl9?=
 =?us-ascii?Q?f1kUPmXl4UybpBKtRUQnjKKGa0yAfGmCEcapK7ljYJGBPbUDCP6U5Il86F+o?=
 =?us-ascii?Q?xksNn7gAjraFoRXDXwRswSxY3gYQJ0Z5lxXZIKIjZr3V2UKVhx6rHY0pwOEK?=
 =?us-ascii?Q?Kab0++kI72S1gBd9HbnIQN4Vkly0OUeiAvxWbD4DddSLNwotW6lhnO6LMHEo?=
 =?us-ascii?Q?oOY+mgOrSF+K8PuNefggGitcSY9v/4GzFpvT1IAL14ZXXjAj9LMmPZ93hm/P?=
 =?us-ascii?Q?2xzg7cySvoKLPkTR30td4nUqtuH9UCSkPax775892o3ocjYd86Qd7zF+NGua?=
 =?us-ascii?Q?lYk7//jtsxtFyw31IjyFjLtwsrssyq4dy7Esqf0OOqbo9V/x5sX4QDGkO4LC?=
 =?us-ascii?Q?C8Dd82ggPn7pjDvYdXxaK7CRJmAMDLhF1MwZDPoqf+y9kZYYTlhxtT4Mj0dP?=
 =?us-ascii?Q?mqMLM7o0rdKpVSyhP6j6h2dcc32kQ1Y2IGVBBSPUMsyPIy79bVGGX59JNSj4?=
 =?us-ascii?Q?0+XaWEKSxvm2FVXCP+A+jRlMhTOvH97xOs5uzHsopEQIRjj5qsr2aAqDAHvL?=
 =?us-ascii?Q?JxnFYHKchG290kx08vQWgZeXyeZrNAuIgIrS1zongmCHsWHH96M4VhM05eET?=
 =?us-ascii?Q?ocr7vPttjMWzxfx0+JyAwp+fyAk/n22Ujyth7V4oV0dn8chAUe3jaoDt+xfU?=
 =?us-ascii?Q?hBb91aFgfrSul0N9QvNAcf19suvr1uQUW3v2ADCgF1/6ee0JM5rBl56NZZnI?=
 =?us-ascii?Q?OFlGSm82JjzOHNNzdXnTXKQ3IR4WX1KNSSE7STE5FQwSsPRjCDESBc899S0d?=
 =?us-ascii?Q?e1lNZOwG4G9N6vNiQqBQ1Fj8gYBaDpoR55CGW65Way2vUHt/cyPCJ7o0V2Z3?=
 =?us-ascii?Q?p7QO42AjQDCYvudcq0OzWBVjfVB6Te2S1jxPutRppIY4eIvanz3PGATGaxp7?=
 =?us-ascii?Q?B1AVtAi771UYHm4mmNShAIzJb1BxVw1L8XTd2p+hIsS9Ye7a+1J6UP6ptU5G?=
 =?us-ascii?Q?vHTPTanBoNiYr04NFJSr2mubZob1vY1cu16MUoUNF23ftiBBZOdoV9EQ+2oP?=
 =?us-ascii?Q?M0VDz/1fmp0E/xHPSPX8EngAo7GxbSxPueP1jBJrVApClJtukXmsDGtbWXev?=
 =?us-ascii?Q?AQ0OBJAj56GLR76Oy7uYKDFvNfX7N0cAGf158pNdYNNLwmlPzD5k9Mg+BHkx?=
 =?us-ascii?Q?aBFvKVVVE6jX6rjQfhcMASqkhIRqze3YoQ4ig+BTpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WG0XVoj5axGfh8K1YL2do61V8s4X9F2FQFSCU9vI7wKsog1yATLxeBzflUAT?=
 =?us-ascii?Q?DIcnUO4RPaRXwfRD4iOPFv06EyNmrSHbFrl3AoWbmocdOKbbyGt0ua2f96X7?=
 =?us-ascii?Q?VbZ1xL4FI+qiT6U3bH/tNXXEKW1ogeZdYg8w873s3l7CzCf0NGYYYi/250yn?=
 =?us-ascii?Q?1szziFZ8Sfftt327LZtXpy1iy7W6zrWu66sHov+3LiwtNkcGaddPH+rQiVQS?=
 =?us-ascii?Q?THKmgFOZPHf7zvJK4APnSIVokK6nbqLt3GeJ68qDrP/PnQy9IP8rP1MmbJkt?=
 =?us-ascii?Q?1pkk7wqG8QJEZ630Yk5KAaLJXNbDlHsktEiUMH/8xRzfxRoJJwLoqHDa8iUo?=
 =?us-ascii?Q?mzFWfhSdpGO/oKBT7diCr+r5lf/vW2vLnV5V8T0dlAXhRHmMI4hw0KgPfI59?=
 =?us-ascii?Q?53tqxs/h1KZkNlyG2O0iOahvhI+wp5lDt8yRruiD4jgWy0ktOCETp5RXif9K?=
 =?us-ascii?Q?kiRn4IrdWexgW9zhOiO6bhwcn5Su/sL3y+kuasIzlpsr4O38M2IAD2PiVwNZ?=
 =?us-ascii?Q?LPV+AjcqQKmQHWgen8Iu/x/egyPNtV3z+Za6oY1qDfds8YRGJ3tkGQiTE+nn?=
 =?us-ascii?Q?F2jxUoqFo3oOGsNvsrGAXt7wL+wxLGhH8UpYbIuXz2yZZ5oPliXHNqey0j03?=
 =?us-ascii?Q?fcvpvfqrCiHaI+QI6GojfS1f3jmNgvSZEwG0/XddKviW6phpCXqJg2hVbXik?=
 =?us-ascii?Q?IvO+nFwmryree7dponvmtjK+EVI364BdLPCrzyHQsFt44fN7Zfh8hi0YXu/3?=
 =?us-ascii?Q?RfbXOIGqFiPtyJFel6cXMXsutkafo9qByWD6RCG8XiTeM+AvBIu5bBJsG+9V?=
 =?us-ascii?Q?MuJ8hgm7c1pNl0SWAba9xaj1d6tW5IJBRUbRRKP7f27EfyqWlt3qrIeevDt4?=
 =?us-ascii?Q?JLZLVo2wNqv5Cl9UBZECw3GVNwbzPCdGFiU6SOOrU5NKBd30WIDbXJ7a460z?=
 =?us-ascii?Q?WdHoL9Zx0QSqtBgrFHi3KkzcBjsKlMh1FAHDJ926a+jrQF9SICM3KCVJamb5?=
 =?us-ascii?Q?0uXXzEcob5/i6A2ngZ9tPQM+UxijCjLlo+bCAtOgyypxPLG585GXI2qHWQPs?=
 =?us-ascii?Q?I2H+Nlq4F94Mv9xUrGKsAeXb76NQUGkNwlsIxVhnedY7MEtS76r8ny7GKZ6n?=
 =?us-ascii?Q?qfdNZatPOp1h7ndKGyPunCVxDRTonZ52ApWE9ikFfuOokPe9YUYxJD0o0hDI?=
 =?us-ascii?Q?2/7fzjUL6Zjj/P3aR3oWYawk8h/Jj7ZlR8XFQSXAOKqnhDaaYq/76nUJuKbR?=
 =?us-ascii?Q?b4uMxnH1D9YBjTEobTSgMiFSuhLTbxg7I46BKuMUbeJKDqO+sVuGp3UUgX8h?=
 =?us-ascii?Q?D/4xQcfHz5dGgEnHGVnNV8E4WsHMKHN5mtyvtDagNbDA5zEqf9ZdHA+TkVPR?=
 =?us-ascii?Q?yOsdqavWLtADkCKWGF5nnDq+I/fRaiNpa5IwvjeNnLTK0wxSNJAeQcdYW95R?=
 =?us-ascii?Q?WK32QMMPPE+QSYe7b3YMhFYiomOX/O1OKvKNJy4fUBreuftoQFn1YO3sBTIO?=
 =?us-ascii?Q?DqR5wdOxg+n/cYCk1Xwrx5lSSTsdRspVNX3wJN3GBfBiShG5VP58JxUawh++?=
 =?us-ascii?Q?vW3DCphU1+3M5x7BEpNuBo7qfC433mt2auqFuWFS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8002bcc3-cac3-4101-50cf-08dc6469c8c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:21:08.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5AVJG2hgxSS+GddOXhvASx8+T7Myaa2xyRC4Py2pt5q5yIPYJHSqXQhanva/7d/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580

On Wed, Apr 24, 2024 at 01:43:33PM +0000, Shameerali Kolothum Thodi wrote:
> > Right. "easially" was perhaps a bit too strong. It would have to be
> > rebased and pull back a little bit of the domain_alloc_user()
> > implementation.
> > 
> > If it is good otherwise lets consider doing this. Maybe HTTU and part
> > 2b can go together during the v6.11 cycle?
> 
> Sure. Let us target that.

Okay, soonly post a v3 on top of the latest 2b patch with the comments
addressed and lets see.

Jason
