Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A12AD2A
	for <iommu@lists.linux.dev>; Mon,  5 May 2025 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433507; cv=fail; b=YW2hz50SXEjIM2QiK+bMmr3I094q4EXgzBFmCkLmgOsHpdBEF2UHLsAFlrkRtINalRycDaGOSjfD+5f4RGGFq1huOPwXXBaVJ5W+AS73rZD7SXhEt4Tc/yBuhzFrITBn3N2d48OmGEXDzyFA1MHLhi6tUKApyA+5+3ihrkxjSEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433507; c=relaxed/simple;
	bh=oor5lRuLlOEyOhZuYpjhenQuHoHWlLCbzTMY2ngRTLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vB2lTfOhidjgS0qIZzeCEHB8TzVrkawzr/a8ZK2c4kDBr1j/Ee4kYJ0ZX1b7uf21RdPFcis+Xp9PItskRbLPFMZjLFL6HP9dethLsEjSObcXtVTHJ7vgxZ1XvpLqdkoQEygtzS/LfaXaKEYFGOokgnN61I+q4nZ67WkhfdmoXtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=an/30xC4; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="an/30xC4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxQYNoSJn3hbwKFyeQWz+Fi/oIGKz24U7/BzHCesDRs0gvmQhBi7ItcKArcbugSO5G9axDjhMJLx4Rw7sB/fP01CgBXcxMhEVXRMjaR9z7D3tlTv3Tuqe8RlScP7yLimvXgrnSwXOwBOyVB647sKChsOiDmPy1UWlmqF3mHSZIpm88FOtOU5hcRuhn4seTg5dcj14a44iDz583mkfM1CxgtvqJrm7KaC3FMe0MWwwNKe1ifW65Glrqb08Ekh8a4aZcooaLo6L+1Li/UapCmdJz6YcEco31A+/1wvovOzsJwp5HjPT1Uh/4PnWSvuvXF9pSJ0OIkjOS+/udUv6vD8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oor5lRuLlOEyOhZuYpjhenQuHoHWlLCbzTMY2ngRTLQ=;
 b=SyoP+7W//hsJ3aUuHUBgo43BCn4QMa5lMPHah/mjRISD2+RFPxb7kgR8QEgL/sO46hjSIMkvtCXDwXQfJyPsMupHyTEA2e3r75oEa15P1rmdGs7sP6NTxB/yVthB10THdjOFsaiqzvyOqROIp8Ib2AjF1vW8VEI1quMPbmUsH8Lh/8AYMb7URdzn4hV8cauxx9nN3fuI3o3eXXM0f4xSPaTaZ/efoTeG0GP7Q6SOK0ByA+Lw6NlLfi7VCVLWD9xupN/lg3gOU1CmJxG/Dlr1wEFL334s5hC0Q78Xh7AkMqbXGKcD4h7uxb108reuKR8xzqKIRNs5u5d/z6t6b2yVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oor5lRuLlOEyOhZuYpjhenQuHoHWlLCbzTMY2ngRTLQ=;
 b=an/30xC4k9vuvNo48HEctx0+6dIxEK6aIntj5cZ2kMDudYWArgp4eSqc0/0aGN6JAlfPktdWj2w2QioEzjRxf7bDxKN0C/JeNevydCDzkdv6eclnzqH6mWd2vYUpzWBOCr0q9ES4hNo1Luj1DATjEdTwP7aoJIrHVF26lAX8pfA=
Received: from BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 08:25:02 +0000
Received: from BN9PR12MB5340.namprd12.prod.outlook.com
 ([fe80::5e5b:9074:7674:62e]) by BN9PR12MB5340.namprd12.prod.outlook.com
 ([fe80::5e5b:9074:7674:62e%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 08:25:02 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>,
	Greg KH <gregkh@linuxfoundation.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will McVicker
	<willmcvicker@google.com>
Subject: RE: [PATCH] cdx: Fix driver_managed_dma check
Thread-Topic: [PATCH] cdx: Fix driver_managed_dma check
Thread-Index: AQHbteeDwR70EpuztEKldNkZwh9VpbPDweiA
Date: Mon, 5 May 2025 08:25:02 +0000
Message-ID:
 <BN9PR12MB53403A7217557610F489313B9D8E2@BN9PR12MB5340.namprd12.prod.outlook.com>
References: <20250425133929.646493-2-robin.murphy@arm.com>
In-Reply-To: <20250425133929.646493-2-robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=77e75334-3b69-48d2-aaae-31e329302e04;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-05-05T08:23:03Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5340:EE_|SN7PR12MB8434:EE_
x-ms-office365-filtering-correlation-id: 0af7f2ea-fa48-4298-d774-08dd8bae54fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AA9hmi8aI+nUqbMg2h7Kjyynk4ZCeYaI4d4+HlZ1LLhDAJNjXnEJyX5CwluR?=
 =?us-ascii?Q?0qR+XcjbhzxqP4Miy0Kjh3zqBD7TrEAcJmETjO3Y6tcYvFNwlRIh95T2qOW9?=
 =?us-ascii?Q?5eSuhO2QhJh+KJc8j2pZ0ZzojbwrvYZ8rTdEX1/GrPdbLx2Xu4BwkbLEik9c?=
 =?us-ascii?Q?6K1prgF71DdSv2F3OH/6/kj9zAVBMg2nRCr//AzKIxkVIsTvIxVmJ2+EcOGc?=
 =?us-ascii?Q?gdmfkiAAODG+OFE+to3US/KmXwTcw/Xgf+HE5qA0TG/dgzpSWbWYUZH34grn?=
 =?us-ascii?Q?wZPxFrXVcr5m7zhZRYQBtH39Ke/fs+kmu1HGTCKNqkiJHpD4ftZWks0QxS59?=
 =?us-ascii?Q?Pj1kOKLF1WahBbphxJDC/x1ub3VF/t0b/0CjoAYmmbcZ0bQKV1V37ONKnLss?=
 =?us-ascii?Q?FKIEygn/0qJk3Y0s1i2FrthD21dB2mOpfUt0WtYYsVOyEZjllfOUhmLcWXx2?=
 =?us-ascii?Q?nXD6BDatQcI1QlvVh7zHh1QqqQr3meR/Wp2kJg0AhlnEgVPr8hH55WfBh5re?=
 =?us-ascii?Q?k7Si3ngxgawyWJ36WyF3ABfyKcy6Il2lHHew7Brry8XZY8YxyigIsy2Uvpt2?=
 =?us-ascii?Q?zJhrJ4XoMHInpiX102Nt4/zc5wQs5rhuS07aOie+9YnAj9jRtM/kwvwAbMAk?=
 =?us-ascii?Q?5Et0TQLiBK6wBAeNm08uUIMDtWpB/KSS8ZtHPHiIxrfcjfTMTAxSa2Ynv8Ju?=
 =?us-ascii?Q?/WZ6lrVzXAJEdrTM3h3k6atPnLspNOLE5tI7rMYQ6QGJtPwWouiD0fi0X6+k?=
 =?us-ascii?Q?oqQ0GuR0JXw1LJ3eVijXf1dHxgrHaN0Vci4rSgeJ0lN33eQvHVy0yqUdp9iV?=
 =?us-ascii?Q?1NyoVOTrcCyT4Zux0tRVUlmWcUuwDCOdr578XrgZIpRCQ9Qdt1Uvnu6YK9d8?=
 =?us-ascii?Q?rjwYXKlWTGkMvtaX2LXMFRtJXdg44n7mR8wDnyTX2kdEGfssA6iBFUghwHq+?=
 =?us-ascii?Q?lFvBT2axrQEpnvz1aqI3DyXQQPqoYU6PjI/+v/2fb+3dQocfuQ90/VPIdlQ7?=
 =?us-ascii?Q?sPV5rHj3i0cu+EVx3/tFlJ1Oj28umbY4XoVntt0p755ybhCGsQZO/tSxdH6V?=
 =?us-ascii?Q?MbyBNVGZVOj+i/BA+EFbaclLeZGaGJwC/8rnlmTmHRNYC5hHejzy6pNOj1Uc?=
 =?us-ascii?Q?153PfGGCxpMCg8BWnE9mmp73dPZkeT6ecdMP2adRTjwmYC3saxvRH5lfNd8Y?=
 =?us-ascii?Q?FdxD0Gqfjq0VvG2hRlnK0DeaWbKiYMGPhDKecXQjikbB7ZoFdSTOy6JMVxe4?=
 =?us-ascii?Q?I1OQ+KkWnY1AoKxwPb484hfNkSIpJ2ISwTM6RINHueM1pjMxxE0B+vcGW20i?=
 =?us-ascii?Q?iIVuQrIRCx5AWtbhC990JYzfET/aMEGcOUXJv+cPNZjj4qElG7IVV8k7iD1Q?=
 =?us-ascii?Q?Q8EKPLwhPBL7U6aHVi0XSbJRstDT80RVtTDmLQa8GmdA4yofMDTpMiGUJtvd?=
 =?us-ascii?Q?1YQyUJ0kqVy0Ug5XJjxCbmX3i1SJFq3m4zhPF+3tuTFoILgjBFDHiYcKUbK3?=
 =?us-ascii?Q?JWudjP7oUK1p5wQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cnmdLPojwTVIMIe+rvGwumyq2Hy6Zwr90NZ0lnN/0lkzS0y5ybH1DDaeicLR?=
 =?us-ascii?Q?HPpBHDuYl6zDclUo63GS4EKIpeOuDUIx/YdZCr6Lj5J0XFiKH1rmIN/B66ov?=
 =?us-ascii?Q?VGX3irhIy8tcUbohNDxk4f0x5UObeWKaVEv84VlCM0l9XEKpVzNW0G2pG22i?=
 =?us-ascii?Q?o4ek5k4pTeeJnjUX01sV+3lSQlROMxFi7JKXVlpkKUYxU2CfVFjBmFpQUziH?=
 =?us-ascii?Q?ymCoIsTKq/0Kl2+FMODSs/f4WQ7CyOcoqsAbfn0hVcz0ubaFOiJlnDHEIJXp?=
 =?us-ascii?Q?xo9VKVWvp+pYHsqFXjl0Iz8aHgKEkkvIcIXf4qpLqk+yURMVblesfPTy4Jlg?=
 =?us-ascii?Q?DbmA751Fg9sr1ld0XDFv15G4JPCtLTXsmn4g98rbw9rvFt4L3SkcQgSqIWoK?=
 =?us-ascii?Q?6ve38NrunT2EpBRhJkkRNNYI57NK3mn9cWEaXP3RGAAYBLkpnUEUWfftr8Bj?=
 =?us-ascii?Q?O2gzQqS1KL4kNGxIA3qQLjyNbWHpda574hEwulcYcqdR11FxlmAmkxVpkqmA?=
 =?us-ascii?Q?KZrfifKFyRHQP451n17tEJwh3QImRu0pNr8JAGw3TA/QrDdCMX8jMKH3W7WC?=
 =?us-ascii?Q?MTNzb18V0w115cBxQ33ecSnz1jkOsZXCk1HaNWTRiPwLmHLRPbrZqKgBowOQ?=
 =?us-ascii?Q?+WErPPcp7QKwAtxP8Ov3m/IwVc7J8WHqzws6/w0seHJuzOhDbK24fdA8csPF?=
 =?us-ascii?Q?zFDz8N27vZRiBN5+4dUXyTO6wrxkMrCJa0AK6ykuCStDkDWdWrb+TYXFPIE7?=
 =?us-ascii?Q?j1s+Rm8gy9nkcLwYlVpxyozQnvAdlJCepYOGqf4KMOEmLiBth4LUYSbPLqiY?=
 =?us-ascii?Q?Y1fMnmdNRYxcGZmVyORorf5lSekjSi43pnck9culAiDqdohxAc1wGAs3N7OM?=
 =?us-ascii?Q?SGj3D5SkPfcGypJXKw8z0tkyLoimk2dASkGUa4gstM4PhdeszweL87IutDCr?=
 =?us-ascii?Q?2WQt+0ANPtFFxrzGxCJa9FJgoPSw5etWhnXuZDhET9rZ4nTyUjmOeF4xHFPT?=
 =?us-ascii?Q?VTjBEAKJU9Tq4icGxnQSWoYgMigRS9g5nmA7+bdKxs7ZQjGLlnYnisZt/sIu?=
 =?us-ascii?Q?dePMmosQel6ZlwWY9lJC+wZwQUDs6boZR9/SxP5rsNyEXRRn16JxjuMVMrJp?=
 =?us-ascii?Q?LwBI3+dzcNMiAHzMTxr4+OrbD0UztBh/PtGxfvO9af9M+zAKRYBBYLCdG/VB?=
 =?us-ascii?Q?NvJYTxa/mCF7QXh0mkWWxxWTbLpP+Sb6SInDMLOFwJeoixsWRAdEVCOXFy24?=
 =?us-ascii?Q?0jCMKWeIqVZur0OrC3cmeS+woJsMToXhoymopyESHMJ+gZp/RXY8pZNEK002?=
 =?us-ascii?Q?w7bVEzJXdPey3zcLih9V6/8JhkaZg83y786aQjfaEFs+XoZ/v4tmZgtPo73C?=
 =?us-ascii?Q?IEX/3YVdPqWEHndAUb1MEGfb0n3V3kl0rZYT96viQ8FE38qE3vDZ58Xv5azm?=
 =?us-ascii?Q?wxeExyt87CteNazsMmjBan5V5LRt9VablUxzXPYCDXqFdW2swPyNMNCWiNjZ?=
 =?us-ascii?Q?JGKrgaDvAo00dR+dLUmMZoemfayBZm+c5tyKs7B9Yf9VCOciQBSJxQKv24X6?=
 =?us-ascii?Q?Pv5hFImtYI3On3gciTA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af7f2ea-fa48-4298-d774-08dd8bae54fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 08:25:02.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIYVgXyTEY5rXjGPV9hqbUk15YBkwAhlX0juPiaPDxRtAaLllgc0F4U5qRVJHSbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434



> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Friday, April 25, 2025 7:09 PM
> To: joro@8bytes.org; will@kernel.org; Gupta, Nipun <Nipun.Gupta@amd.com>;
> Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Will McVicker
> <willmcvicker@google.com>
> Subject: [PATCH] cdx: Fix driver_managed_dma check
>=20
> Since it's not currently safe to take device_lock() in the IOMMU probe pa=
th, that can
> race against really_probe() setting dev->driver before attempting to bind=
. The race
> itself isn't so bad, since we're only concerned with dereferencing dev->d=
river itself
> anyway, but sadly my attempt to implement the check with minimal churn le=
ads to a
> kind of TOCTOU issue, where dev->driver becomes valid after to_cdx_driver=
(NULL)
> is already computed, and thus the check fails to work as intended.
>=20
> Will and I both hit this with the platform bus, but the pattern here is t=
he same, so fix
> it for correctness too.
>=20
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe pa=
th")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

