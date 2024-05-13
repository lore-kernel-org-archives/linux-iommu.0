Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2080.outbound.protection.outlook.com [40.92.40.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE27BB13
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630736; cv=fail; b=cgsIj85oLKVfczFu6szJXQa78E8ifgSPSxDD4TXOJbvcTBBR9FbcccruAQ2puJdUII375JEHUTZzHO2XQWO59gi8o2fWA/zY+Q0wQ0RT3HQ/tqmdkXL5zF2K7TW5cpPacspcTgL8pyp/woHi+/+iaaISeZyqsfNVXpVVACHmB2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630736; c=relaxed/simple;
	bh=WFA8QzbDosjDhfXNaD8S/L2oeOpAQ/spJ5B0elA86Ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHKusFDHLXSStAxF7lG6TpxtkfkqQEyjqo1OcpTS3C1U/HDor/i5TXvCASZRq82HEFxTFnJbE2JPM9USLw+40VhSDrtHwPHjO1SHtm9yim4d/8q8YOcRFJhKhDiT4H7+SRW23/PXZS9PBKbHdtdFqxy1DQzLWuEl9z0e53Qo05I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S4xW8+Q/; arc=fail smtp.client-ip=40.92.40.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S4xW8+Q/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASIHy/Lxna9t0obTIXeuCMHj1O8sBc5IjuXfomnoaay0DhxfNeTDlINL7YA9YIv66hl5F8CapBM1biOxp+gQC3MVolUIeA7RPD3ExIOPY40Hhnq0gtDjKuKyv65UvzwhtJzM9BxseI3Jua8+KIrN1Hzns7wTQavEih4Pjfh9onHjQ1XRJEjoot1M49es6EoTlBAjaHNkPvt4Kcv/Zip2feXmHKs72Afw5XsT0JD6Wj7S1V/17nIxNlepsJ6UUjQMfUZGTqSoZqglOmYY5TVhWN4cH100GYwK1SjaX4v5Woe6rBfQwRYTvrj3Uw4Ki711QVWpff7o3qdtzdCSpRJWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12jBG8GeRw0MxBU1B8TsCob15P0mIFrddKloaOn0CXA=;
 b=TQ1o8GjmpSUMZKkGBikZwoY3uVTxXR2jHTic5j8r+C6pfFln2UAlAWmvMG3FHZ2PqYBN2lffBef6KBG3iksHOYQa9jPzmrcRUAFvMHHny0H44w1Lsqbl9+uBV3xUjbeRkOJ86GI90L9JTp/I/+RFAd6Hg9wR+BtnxTFya4Eq0nzyAqNLS6daxfTtbkusdO4KQL6FwpsqF2TcAhiCvSBSInbZrKhvBzrEpU6S1oZyVYOvZJp4smcJsNglw6hPajC3V8C7DzXhgmr68I7EiFu8O/DphbTuD01bd/TzHWuOTw/UiJ9+Ww2zfHcNzvOObBFSrstFHA+Px5sJfVx17cMZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12jBG8GeRw0MxBU1B8TsCob15P0mIFrddKloaOn0CXA=;
 b=S4xW8+Q/LVRU3HKF+t7nXsYyYFE5R5utkE80GjtdTrnFsmi5lmKAP1hiGn9CQI4zFPPURtXFdzxcpQlyOnKUkgsspcPziH+grrNA7R/Wgwgv6FQtV6VeH9yR3BMdcgYZRdSFMWqeLdxBllIrSRco2hCW8Ei4I+mWasGN3BhpPKf0vHYvDIMDitiXhYS2rva2WcrF3ckRxzcdqu8P0osBZIske1umQVhi96cALDjVErqblR3+iWy7TLZ6mP8wDCOdUMs6WW428aolSAxvLLlWU6fNg62kIcNXsED2621qLI4goR7H4YSJtzbEtnrno36zTVNHjtEXNYaQTMGFbK5IfA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9542.namprd02.prod.outlook.com (2603:10b6:930:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:05:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 20:05:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"rientjes@google.com" <rientjes@google.com>
Subject: RE: [PATCH 0/9] iommu/amd: Add AMD IOMMU emulation support for
 SEV-SNP guest kernel
Thread-Topic: [PATCH 0/9] iommu/amd: Add AMD IOMMU emulation support for
 SEV-SNP guest kernel
Thread-Index: AQHamxKg8G3tDdy39E2idvNw1Py2z7GVp95w
Date: Mon, 13 May 2024 20:05:31 +0000
Message-ID:
 <SN6PR02MB4157E795C636EBE75CC806A1D4E22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Vq07iy0/LrUcj2bJVqhmCeLlQzacMhBo]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9542:EE_
x-ms-office365-filtering-correlation-id: 9d1bc4ee-85b2-443d-7627-08dc73880b10
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|1602099003|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 9nLbprf/QGL/Rjo3T9eEwLxYcoOdUGiH2vhLa8MlEuiOkotZuc2W/vTu9C8GoCmTvuwm9k0s+3J77vwcYmic4kqWLPKsD0mE9juHlhDouJabiWX2yIxOsM3EiY0Ee9BocVhzJXgLutFuWQZJ+ljH7LNt509fmzIQvbcnpPWc9we4BG6IwrUUY03rXx+rur8uTnH5fql+WZgSV1p6sr/a//Id6zQ4JgoLH1+TJnY2LY5ZRK9olYXVCuRJ7GtpXihUJ8lBudeMisi0VRbfXhlkBqty5TSfHsLxhUoi0K22Tgb3XkcoSa+l9oON8cGYB4Cu7Ya8lCNxkFPKPCEGr4q2etgdloZTNFU+GdquZoP23+9uO1jM/GSbk4i79j9yzgiYU8SOa52uoiU7qbxKnU06UVCBr+HvQ9PTIuzavzNOhEgnnQCAyuHs0Ci3/EwGZrW+0Rm+go9+zniE6S1Kup0tE4D+UCuFyf2DBRgHcA8PF5SWMprySRaoC2uzzHAj5mpd4LihT9PBBjyi0L856tAlvmQBmjZdhGLIxff0apoWqjLk8ZXjHguQTktHw8HVfblRFGHDMJvSLqAOQKL2FWto6zpRHqnJuo2/hgjbLBR14pRpdz1PkEVPgpAltG9m2bl+yCqLPP4MtuvBi/qYyxahLL81HokjppowSVUHzbhv0yc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BnRaeGBrw04GIJBYlbHlbXPKyBw0CDFGzRB/dBGn7qx9BZ6VagTSvLcWUUGx?=
 =?us-ascii?Q?WBR6BOaT4vLA7wo6Mk2jOAEoYdzzzY+HH6j/83LqKY2ypxz2GB6uvEWOc5Q1?=
 =?us-ascii?Q?ihMLWI4BHvdxNXjLDSTJpUcx2wQNzJCRyCx2FlPYqq6E+OB7sqnj8FI5vpDT?=
 =?us-ascii?Q?ccktvCEQUQBPJhzoIqQigwq/krDto3KxP9ozWCmUq8TCmNMAnXszGFjd8aUf?=
 =?us-ascii?Q?xAr6OL8iGYnF14sDNL/c2iZlfxC0jLA3Y9cAHz15OiJ6rclUu7DQNaYcU0W9?=
 =?us-ascii?Q?Z29dQ+RoWRwZcjFqCEbWN8XOwy8dRyjHQVVtGw6/kgSYUVj6K7YKY/a1NAY6?=
 =?us-ascii?Q?M0N6JV4GW16Up3Q7TxyZc2xZ4SOVyET6kZyJfFE3mLuUXXAuWjmd+1jQGuPK?=
 =?us-ascii?Q?40rTjdT/j8kJ/2x+s4XN/GD0SuvBFjvoyuEJNwwQ/+Tj+NPXxLhaevYPnUeO?=
 =?us-ascii?Q?tcGOjoUQtqyEQy3UxL0PkD1JNOjDSSqVdZgQPNSVTRhPvb35SgqYeKXCjQ7s?=
 =?us-ascii?Q?0d8J0sQ3jUlyHI/SLpLo2JMHGJd0BDPs9jkysHJ02Djd1zZW6umGoL4nPWIK?=
 =?us-ascii?Q?/X/ZjtNT39qxn3qBG/zWynqrJ6MbBMFDY9rt5uXpr7F2b8DUgmKePmlGDVja?=
 =?us-ascii?Q?A5+ZMc6Ncl3uiFetxnnoFjKUPAgLjFQGZ9RTJ7oXjCXJkOmmHrczy7ZQu8dZ?=
 =?us-ascii?Q?6Z2lVRz8jH+XS77PnNsx5WBH7AFSUPELyPo+L11Rj0hetnzfqBTI3QSA8U4i?=
 =?us-ascii?Q?4TsshbFmhArq+OlzQODy/6AoF+pajHC2SjwRsoET13lLHom0fkqb6UCUlmRE?=
 =?us-ascii?Q?/Zf/TPP+znaYlBJ156Y+sMPnz+Hszx4nCfC3eue5QqNviJgN/M8Kta4W94Mt?=
 =?us-ascii?Q?EhIULM1HUTQmQ34nE4FaR3E4eD9zkBnF2gxIuA15tayNNADSdqd9DE9M0Gjb?=
 =?us-ascii?Q?HGIS5RTtEDJ1ovh3u7fWr8cN7YKuUYwWfsCWiz/VqNqYaD6n+AahBeyvLjd6?=
 =?us-ascii?Q?5voSxx3m0X4iHZd33PsUI4L+D82bq1LKYuq0zsVT8l/TreuNk4KdULfQFmEA?=
 =?us-ascii?Q?6m5+XW29WZq9bOFWzV3oA9vgQWQPZd1jguIdn8POkqaQJMiTaa75RUzSYVEx?=
 =?us-ascii?Q?xhbZikIJKAq7YtKi4gFv+09bo3tVYZ+J4IPhkzP4uxjsNA4TeSngS8bPcaG7?=
 =?us-ascii?Q?OtC9u1cBwX+dazSEqy0drgO/ugWFauXv+rambS6CWy0QxAOAuRyeI4nmEt4?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1bc4ee-85b2-443d-7627-08dc73880b10
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 20:05:31.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9542

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> Sent: Tuesday, =
April 30, 2024 8:24 AM
>=20
> To boot a VM w/ x2APIC ID > 255, guest interrupt remapping emulation
> is required.

Top-level question:  Is there a reason the MSI extended destination ID mech=
anism is
insufficient to avoid the need for interrupt remapping?  (see function poin=
ter
"msi_ext_dest_id").  I'm unclear on whether it is or not. If it is not suff=
icient, perhaps
you could explain why.

> For SEV guest, this can be achieved using an emulated
> AMD IOMMU.

You've used "SEV" here and in several other places.  I think you intend thi=
s to be
the more specific "SEV-SNP", and exclude SEV and SEV-ES. For avoid any conf=
usion,
I'd suggest using "SEV-SNP" throughout if that's what you mean.

Michael

>=20
> In order to support emulated AMD IOMMU in SEV guest, memory pages used
> by the guest IOMMU data structures must be in decrypted mode. Also GPAs
> for these pages must not have the memory encryption bit set.
>=20
> Testing:
>   - Booting Linux SEV guest w/ 512 vcpus w/ QEMU emulated amd-iommu with
>     qemu-system-x86_64 option: -device amd-iommu,intremap=3Don,xtsup=3Don
>     (emulated devices only for now).
>=20
> GIT repos:
> * https://github.com/AMDESE/linux-iommu/tree/iommu_next_sev-iommu-v1
>=20
> Thanks,
> Suravee
>=20
> Suravee Suthikulpanit (9):
>   iommu/amd: Introduce helper functions for managing IOMMU memory
>   iommu/amd: Convert Device Table pointer to use struct amd_iommu_mem
>   iommu/amd: Convert Command Buffer pointer to use struct amd_iommu_mem
>   iommu/amd: Convert Completion-Wait Semaphore pointer to use struct
>     amd_iommu_mem
>   iommu/amd: Convert Event Log pointer to use struct amd_iommu_mem
>   iommu/amd: Convert PPR Log pointer to use the struct amd_iommu_mem
>   iommu/amd: Remove iommu_alloc_4k_pages() helper function
>   iommu/amd: Decrypt interrupt remapping table for AMD IOMMU emulation
>     in SEV guest
>   iommu/amd: Set default domain to IDENTITY_DOMAIN when running in SEV
>     guest
>=20
>  drivers/iommu/amd/amd_iommu.h       |  31 +++++-
>  drivers/iommu/amd/amd_iommu_types.h |  28 ++++--
>  drivers/iommu/amd/init.c            | 144 +++++++++++++++-------------
>  drivers/iommu/amd/iommu.c           | 133 +++++++++++++++++++------
>  drivers/iommu/amd/ppr.c             |  22 +++--
>  5 files changed, 246 insertions(+), 112 deletions(-)
>=20
> --
> 2.34.1
>=20

