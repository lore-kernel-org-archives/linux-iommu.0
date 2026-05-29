Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6526B0A9
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059023; cv=fail; b=MFgVw11XC1Lvu4NJ/gqMF1zl5OQDnjYoEwsI/XO5NkfMvpEDPhDv/9bqQKzW817t+EToKKIxSOq6M6jD6mP9udQ9CfX6H653IsnYm66VTAcpy64mISZ6LCnuqmhnGjYvZtVfku2PeHA/8M2P+99kBMRlEAOm2fgT/vck5WT5/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059023; c=relaxed/simple;
	bh=uT7WHRlC5ybaPxsEqnDmreuOYov8cLxrfW0zO6hz0K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0iwj+wTgiiN2lqkfemMzORwgSIDmhlZ+FseqdtqURj+VBSCMgFofv7K4/ZpXWlbxDdNfvyI/cF7dDT5PXT/T7mf5zA4Mb4m+C+fgtUB2vp1lcLy1HKWOjy5AEEdNtcTbYIg5swevkxhSbtylH0+iugw9MMUwIQ9aHVXou0LXhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EI5NlZaL; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EI5NlZaL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8LQv9CCbnU/EHh+DpM0H7khDWSano+CW6cUuvq7c+PEcJNZOWTN7O5lUX7fyuI1aIvcW1BA5theKHP13rIrss0p/Sg4A8JEzQDXzqyDLP0X1aXnL9fxk3GYBgwKCtzOL2wvDig5gQc5bb/9BB7a3pCo9ipNFQKuVRPFYtKOXdMpchG3Sk9IF3ogPM+HAkI8Gm5IFyUy95P77MPsnfoYHHOoRuDBq2SDIDu2L5T8Q3gageDc7qGCXJVMiCJRK/GUKj2NympYvsr1TW9imCdiC+ufTqx6TmwkAGryXJZIMkyEL1c2R5YWS5QQBxlqYvcE6po23A0Ki0mLuphLPd7vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+3hKuNPK3gvpx7Xbm+6JosxKil8mbqCxSMEeOdUnoc=;
 b=tLa4tB4KbsAWyrofpHTfRsOmiOdDp2Z5DCVZg4hh2//zE9Ephl3qxF75aNJQhVmUTlZTO0YEtoNyL9dKEQ8883NUMB88NJOIqyP74keK/o0Vi90aLsKUQWhQDnZl3SOjXtnCtEk+Bwvc8vpPWaTqIC5CF/WXLPcTZyR10pbepJBvCSM8/s1zyjMNsttmzMiWdybXz8XMriPJxLsDKf3WDTaaNT1hrVX2xSqp6CMlL0BdIhqZ+xaxIuwxGRrvy5I3nEhnG59k569msidyqdG8p7K4ymdyjq4+LMHBJyWT+kosv/fU77oHc4ZxelAFL1fzKM5XGPZ78O87WKfdkEpk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+3hKuNPK3gvpx7Xbm+6JosxKil8mbqCxSMEeOdUnoc=;
 b=EI5NlZaLp69Ksp6MpEiBMIkWnzfUbJNGaoGcxwCkUgvfPQBY6g+PZjFQ+ef79r9/euCAoCwn4XIcNwuzpkHmAeCKvabOD9MLGJh7B/e0C5b1sK3X5JOGdpJaGultxxU5IviYJMyS2STnuX+Bq1BIrg8kUYL5a/BvgqFZSnMMdjXtOWg0HzzxB9qG/1f+M3t8JIUcMB+H3Ue79Dv+HfBU6POtvAsaPtA7qfbqfrObt+5bZD3MDAUeSYNnkISTGngHbp3QxZmYe5zYI6pyO/gdKjPFG9zQr0/wIRSEjmzzLas4UUjwO9BvfFWROuNjyO2i2CkKzIPMYNsPwYRQ8+cq5A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 12:50:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 12:50:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, Nathan Chen
	<nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
Subject: RE: [PATCH] iommu/tegra241-cmdqv: Skip CMD_SYNC flush during remove
Thread-Topic: [PATCH] iommu/tegra241-cmdqv: Skip CMD_SYNC flush during remove
Thread-Index: AQHc70ssAhCMx5MQSEOA/ouMwFgDuLYk5PiAgAANFDA=
Date: Fri, 29 May 2026 12:50:15 +0000
Message-ID:
 <CH3PR12MB754872279F0152B590D9E699AB162@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260529091052.317102-1-skolothumtho@nvidia.com>
 <20260529115335.GS2487554@ziepe.ca>
In-Reply-To: <20260529115335.GS2487554@ziepe.ca>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB7623:EE_
x-ms-office365-filtering-correlation-id: 30fd53ed-5a93-4029-de6d-08debd80d485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 g/R+IP/kKH6KZ7oY3AuTaL0d46G/ztlMpPH7ENbjz5GCFW20Rj9t+1MLhNO/DOr9dy9AEq4gLeZt54JiEoSjppHeFQquzW0qiB9JJYKaPr1w4l2amVoYpUw+l249lvafvgCh/NpQ1Q+BIi8sAcmANp6rNSYVOQ71XVag/1pxKPdhu/7+BaUfHBw8O6FwqcDZQhPtK7iB7i5SQ95iSCBoEBzwmhDtkJSaRWUCBfNYY2I1fYGvhdchIv7O8iJlKEkR65RrqNuEKUDz6K0MpRpbx+kjbYVUBgN4wGklOGW24pdvcaVtbXfCteiUS96AKpjzIwmKDxZOZokobzzRPHKqS/sFIx1AAjwEVlp5zdKPUsH1Rrddxh2iiHZvSmxTJgeYTpvlTkp+Bp1TKZXcbpzdd3h4y+CvTTWcsFpRbWj/A1SfOoechWRhvWjG1EbdOwtOx2LZ1Fhj2CrWitWfH87F5UPCT+hJpjzLDtnkRql50Pn/bUUiItbGft+BXvk2eZNWASOwyd5+OooxW06+TxNjP6+nJzFCtTCkIWL5Qj5Q8/oK3UeeIg9oqJ/xQ5dCpG2LEIuZy2LtTmQYj3rV478S0vtYau6qaid8fZU0Bo3iLIZyVMbPfZAz627nxglSX88ZjWeTZAAme382zgJ5QN5UbbStI0ye5Iudj7QOqjLS5agaEU4sHfBfTKd7nziCZ+OTNjua77bQ1JNH9/75t8gauhnQ82wWJlzozvG7HR94qR/Nv5Uan6nLnDpw4Dto9hg3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VgjmwgEy+oaUmUyN0OHsh/l/Qonuh2v5yiTOGMBhT/g7U0h49SH3BVic/Vx/?=
 =?us-ascii?Q?Qxot3bAwjLuJ4Y+dh/2bMKCMFOF0STjqHDLT1Mh6/jiCo7QBDL8Jhjgrn863?=
 =?us-ascii?Q?1Dh9tbNegy7WgaVl40cALAsNXK1jjNgaSKH5hONTdfIpdEDYHUFqfzXfxtE3?=
 =?us-ascii?Q?NhrZw0wigv6ut0DFFO7E/ul2+WuDNFOo4VV8QWotnOturPW1J0VyW1AT4S0N?=
 =?us-ascii?Q?e1sz2DOUmWZfvfq0juhgljtQUdyUzHtW3ci8gi497DKS6ZAV1GWtk5OIikpZ?=
 =?us-ascii?Q?uiYAwscjvNNVzThlny9ISuCAphucAkNIv0IAfDuV7KhpFb/lPXLJnmqUuHxJ?=
 =?us-ascii?Q?+ZQHsgGfDoQ3dWQy7007/scJJ6YxSlY/CHPhde90lDBXn8t/l5wLnZZxRF2O?=
 =?us-ascii?Q?ZuzuGfAWSkuz6u6qCi1fCCHcp9mHJgVOZ9GW/HsIi/c78+Vd5G7vSjM10lK0?=
 =?us-ascii?Q?iZ2Amz+8d8X4C2mmSBn1P5hpc2pfm2hYyDuaq2hJaGkqDKeGggM9ogOg/57T?=
 =?us-ascii?Q?I1U6Sr2AJokZlKXXynG1mVWhr5eKVmdiy4HKhFDo7Qi4MVlyLkF7RR/90N6d?=
 =?us-ascii?Q?CfuKL/JjhP7NchPkH7ng8PszhWO/2AA6Fh8/rl0ygP6oT2iSk2x1PVi16i78?=
 =?us-ascii?Q?VzTBTw/Bg2yjBIDCoG6wXyKMIAPITdNHfsbVf5zJxRpvOaiO/NNGXEELnE57?=
 =?us-ascii?Q?MGeE+qZ/ORUcTKdgT66o8imlMmIB+9OUDpFd0ZpuyVM5jhu5a0sidCJMjx9n?=
 =?us-ascii?Q?mD4yYwE+1uMf3d5ySMwuOIXCwmvszyMOwZtk77OfNIZW/ujUgSeQGAmSz2Rj?=
 =?us-ascii?Q?FrNbNQcZNtSwspnbJFd03QNGysIAc2ZvKq2ev1dptrqI+zrwDRpCbAgda9V2?=
 =?us-ascii?Q?HGXwP6U21FSvib8iUWnWKhUFWvlqpEukaZzhfzQ00Rvx+D5WZpW917qM3PPK?=
 =?us-ascii?Q?W07ShtqEdZQwIlZ+MbQgr/aeuNPZTeWG5G/igA0WpA0a5xHl62YfRpuWZcA9?=
 =?us-ascii?Q?64DHb2KtNcSaZCMW/yHIvZ9K/sEdviqX4EaZK8LwfZuDJv5n2/owp0CN7eGw?=
 =?us-ascii?Q?OT8A59Tl8LEurt9FPn50JQ3qQaoWMmwno4sSni458wCQAAzD4k1brKAyx7Z7?=
 =?us-ascii?Q?92vb3f+TpQy+O+o2dFWp4FJLU9NXP1R6CXquWk25QiUxgQZ2TAKeOkiZ3rln?=
 =?us-ascii?Q?tsMIBq/UXXDiTGvjT6wolqbPjuN5Xttb31V3Cvi5FRUE1TLR50287hj1eYBn?=
 =?us-ascii?Q?26VjYl5vK0/pOUB0s+QYqGyRmBvjdy/azXPEPnaG35YKbIbAGJyY9zEnmt4o?=
 =?us-ascii?Q?nc327Yk54bUzlSXG2QIA1cfYVq03WAxcz7kLJnTBe6UOA240JixAeaaz8nUa?=
 =?us-ascii?Q?38r2jhFQbUMM0EgdLLtPQiLVo6JCZGqaB3thpAZ0zEjkH98Fq0teQYXZuAv7?=
 =?us-ascii?Q?rE+NOJFZAhjbM+FMsr2c32NVgg+VLZFZ2LOuM22DepjPqZRi3ExbWrEgD+CF?=
 =?us-ascii?Q?zVLP1QHiHbD07PkW8SbqL3LLwjbmGCROdqCm+6x9GvUz7rBJCL/4tTxCviGl?=
 =?us-ascii?Q?9Slr2s6wCXCjNndOjrXw5N3MN7RBPn8LGpMnOSZN0vMYpJO/5I6pJyoooF1C?=
 =?us-ascii?Q?2cQhV84yMJoR0/o3PQO3fFcDpiZ2FQjfNNfoEY0D2956nQ/GXEJIFwSDHiZe?=
 =?us-ascii?Q?Gzn9e4/5roBdL7Sw/RNuhOMSeaJ1i97AqUhN70HSaoVzq9Odr3VcBol7RruN?=
 =?us-ascii?Q?hEUMHApa5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd53ed-5a93-4029-de6d-08debd80d485
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 12:50:15.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51k+CHd4+WN0PYJHQm7o3x+UaUyqz+0sQ5nAqzMvXt6KeUf8MVeM0QV+cthbHmrWimZ37v9be1i+mIBKrStpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: 29 May 2026 12:54
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Nicolin Chen <nicolinc@nvidia.com>;
> joro@8bytes.org; will@kernel.org; robin.murphy@arm.com; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>
> Subject: Re: [PATCH] iommu/tegra241-cmdqv: Skip CMD_SYNC flush during
> remove
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, May 29, 2026 at 10:10:52AM +0100, Shameer Kolothum wrote:
>=20
> > @@ -789,6 +794,13 @@ static void tegra241_cmdqv_remove(struct
> arm_smmu_device *smmu)
> >               container_of(smmu, struct tegra241_cmdqv, smmu);
> >       u16 idx;
> >
> > +     /*
> > +      * tegra241_cmdqv_remove() is added to devres at the very beginni=
ng.
> So,
> > +      * at this point, devres has already freed the SMMU resources tha=
t this
> > +      * path must not access to avoid a UAF.
> > +      */
> > +     cmdqv->removing =3D true;
>=20
> Please don't add random bools to avoid devm bugs. Just don't use devm,
> or maybe fix the devm ordering.. These ordering bugs are a well known
> problem with using devm :(

Ok. Let me take another look at this.

Thanks,
Shameer
