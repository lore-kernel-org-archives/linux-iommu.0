Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DA2036E7
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068806; cv=fail; b=lmRYF/oQuvrUcc2fi+CAqZR6Gx/283/Bc9pexi40ouvOcAd12tDNWPw7DnqG6jRFRbXUX46zOErXU1NRaN4p+z+SVwZ0pqPHGAYl287Hx9Q2lP3mf9PMt5G9vBRU5aU+DBqHVOOAMzu0UEwG/qVnsFUvBukcDnAYZYSGMwJTnYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068806; c=relaxed/simple;
	bh=A4N9jGtlcGyBxjU5n8M64caBHCYGpdss8mJGdKOFK40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFkUAuNtL+3/cMDJXEy6KOdCbKDjEYYfoSoWOeUxzLwNZdMyHNmMD4jYDIuqDWj1FM/fUFRKykPYRYyjtIzjrB2lvDBJarqf1bmrgeVUQb+EHyzDXxqAv/riWuZbIc9vMDAteQl5HIwmlp9HkMzM9LAGB2OyhVHLjpY21zhO9zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fh4e35+8; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fh4e35+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNbVK5YUftFfOAOGt5T9lQ69fJ1Id5tukVKXyFW45HisIYgQtqzjeh2Qb5SebU0lfz+oN4igMGt5peh03MhDv00bU3aU6Edn1Pq2ZkOJfcTpkf1VdfttQIprSZRQISucgSo0VA9wSDWqC2/nZVHVxKv3CNc9wTwZD0oZt0f4YfY0QX+9MK5CTTizI7ieq4C02XNJ7ioj+oW6JMcnj6jkcLnZGAVMPTlHC/6MnF/KdKPMNewPjOS89ZGSiKfDSASfnhh66AKXOe/g5ezvBb4tydNKgOCCNtTjgdszmOn4S/wevwZWUBCmrsQ5f6LF7gI1cKm6u9WqMq+vR0s3yvE6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4N9jGtlcGyBxjU5n8M64caBHCYGpdss8mJGdKOFK40=;
 b=DqSayucup9XEm7a61FdoVJMFkQ73WDYqTYKDmRhFJjfMO13fwagzLCJn7jdvMVOR+fuNilh+B/K2Wrm+O/wRRgPwuSqA0wpsShW7zk6ppaw4/W1hBBw+nscqJRUqdzfCqv8rjXAQxiBziL6k6kkp1nJwcGaaP5jNURgxLRayP5j0wj/0MQKhZ8Wkc2bWwjOoM9qtsOlSmpR8cMwjDMy9GnJt5cxQjMYv8ZyUj7ZSFr8dwn0816nNMPI5PubHGUd/rCW5SFDkKpc0hZb2cGoZUps5b/BftP+c9Us8/ilCrm49E+C+LEbrnVq3Zok3avAp2qQk4NI7bZmbU4yVVHZL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4N9jGtlcGyBxjU5n8M64caBHCYGpdss8mJGdKOFK40=;
 b=fh4e35+8xJSQxmm0MaFuKC9KWQN1cbHzPAnttqRIcWYIY/v0H+AGLgoIHKlobkBruiLNhQqYNmGaT2+KqwVmFNLE6J2IdPnvZeKk5Chf0fohBQDe5mgavrb+OmehRBMHhXW8NmZ1aITgIeKL6pFXh7ReusO9VBMZtymI39OZe23bmXDzgV6SQhZtHf0PokRuweJBILkgjiO1rt9UtYcnwGSzoxwGWtL+LLgnXkkt7A7zWu1iuGtbsawIRlUCuqCKweUBkxZhCtdrJ7wcs/Gp0qjHe+6BuFloTcNiYbPpRFE+e7F+Ti45An8VXmN50ypYpovHFnf6Bg7XI8ff4ZlkAA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 08:53:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 08:53:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joy Zou
	<joy.zou@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
Thread-Topic: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on
 i.MX95
Thread-Index: AQHbHq8rLo120RgQnkmAQnxom8vzEbKH5NWAgACo1SCAAAaygIAAf4EQ
Date: Wed, 16 Oct 2024 08:53:20 +0000
Message-ID:
 <PAXPR04MB8459394682B0B3342FA0383388462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <a8c42a6c-bac3-4ebc-8a29-e6c0ed4567c3@arm.com>
 <PAXPR04MB8459AB654150BED2FB5FFDE188462@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zw8Tp4RuVgCdGcc8@Asurada-Nvidia>
In-Reply-To: <Zw8Tp4RuVgCdGcc8@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8895:EE_
x-ms-office365-filtering-correlation-id: 75a47b0c-a82e-4853-f77f-08dcedbffc56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HWXAj0yghkGXkPxRKix1HzYCNyBqkc4zZzKgW1zteD6ShpK2u3IuZp6V1rev?=
 =?us-ascii?Q?lyWRE9kI4rDgVMiKGSRAl+Dt+ZSny06up8q5gEQGi3GpASrs9u6EoxtEMcsF?=
 =?us-ascii?Q?BmxW+QPUKDlDCSKBMYkB5joqHGfylrFmAHvSJrqX1XZYeAwKwDHpHrcn2frs?=
 =?us-ascii?Q?cRiOXHrsk44VanMSsVBjXI/zOh/GKto9e0Pqh4W6qGwZDYQzxehARErUAx+3?=
 =?us-ascii?Q?Qs6l5bOCpPGGFRnZRyC87W7B1QRKBIybYZ+IrCraOO2MoH3qLVSCu7oHpfiL?=
 =?us-ascii?Q?0A39r9BonxMzEa4zP6IUdyCYU9h4cRgAtfyxbd9C606iGd0RID8gZoXVZV8L?=
 =?us-ascii?Q?XhALvg+mLf/7iumYluJE5hFOT2Gpw+ZN2eFi/BwdfUZKqP8h0jJsKfwzIOCH?=
 =?us-ascii?Q?WdD7AsSr2mPdTzu672mbxFX+ScAmSct0uN1sH8XeDSjIrWyFinpvMRPFBY9q?=
 =?us-ascii?Q?VIU+x+T4lbo5K7YiLfSIHKhc/za8kKvSDP8DZfH1qRWR/R8U0s+/f4LTJRyd?=
 =?us-ascii?Q?zx7eIv/0PrQ3SwcZfR3ZK4SuHSmw9JQkr8RipgcBekf7jPaXwVAY0aMFaTiE?=
 =?us-ascii?Q?05hgkHlmI/aRnaDI+L8VM+zghuf5KyApczEYwwfvsYXAqOrkRaszceNOE+zO?=
 =?us-ascii?Q?63hvAlu8CcU+Qzmdy16WdQ8ZHULNyHj6LWnlCf6jyRKT2JdrRuPhpiW6dihj?=
 =?us-ascii?Q?7W2IWVcMc0mUsbK5MTGy401OJsjAjRsn+e2BR7QaOShbPcb4449+qzDj7bf6?=
 =?us-ascii?Q?2RAMJw+R1fwcX76hQ000CE7jgmpNngcD5Ya5iFZ0Psmgdmrl+40tNWJxlrXd?=
 =?us-ascii?Q?OVEP0ZHEbaWO6RT9sVNroHHtqCBbTryszyaLR3aLSu1FHK1Z7Jf3aU89i+dZ?=
 =?us-ascii?Q?TEIBciL05o9HU7aTP+WYLsYu92zGfVMytEgrydflH6K9DTWXhM862sQ2oRnv?=
 =?us-ascii?Q?vVaZ6OtkywEbWxs2kN8Qa7sIMrvBvpNGXpquNIF+ER89O+UWg7/dVHoIHS2j?=
 =?us-ascii?Q?XCRQ8oHCqvos1xrH2sTsnUZiQCEg4GvgfWHHeK1GM245oVC0q3+msOo3lPg5?=
 =?us-ascii?Q?eKoTpTimUQXuAWVc0qD4U+MQ8p7PQ9ms7XhPJwDvnMqp+2lAiZDoYu6y//zg?=
 =?us-ascii?Q?T/cU6rarLfkT+IVgGQz2h5M4eEVehaHIOpMu/pnlbnsaSxpKv1H0Jc6+jC6D?=
 =?us-ascii?Q?1qLUSnGSDgHMki7P/3X0VWroCGr5HvBAg7fkKuxRh58DMU7dng412QTwn4he?=
 =?us-ascii?Q?jIHBqQz41mYgnQY/ico4XyvkFz7BQfrV3EDMDTn1vy6yT26nt9ecRf7qhQOG?=
 =?us-ascii?Q?VQjplo9y+yjBUMupVsTsGMVUtIkYyhxQ2CFbOUe5K4k2rw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tpyTjJvAFyIEp6PL0lRhsRHzXQRU0sOInHtSQGwTtcH3yXos0OmNlCwhDskx?=
 =?us-ascii?Q?6b6nQIFAMM3t0ncExc3yqGnVDYcvGQcdKeWaHEMQem4a8Oyf9ItWTQ/PgFcx?=
 =?us-ascii?Q?4T+zhLr/mQDPeOhrIKXuK16gXpKpugwhYKb7HKC7kduItU71hy40AQEflMLv?=
 =?us-ascii?Q?ZZ91LG0FBpAyJUI0PknCCXCcfnrOtNWM4epqTxlwaznAQup0i4dFNcQc5K9B?=
 =?us-ascii?Q?a8ZPAZZMxKJ1cDOsZmSx/Hx6h3M9OYn0FczW2fSf5nQnwUZFQhgSdP5c2l+u?=
 =?us-ascii?Q?RtY21quKWwhiGk5bTZvlYG3enXrGweyxp9tUPrWscJdZ1pkm2eeg+/jpbF69?=
 =?us-ascii?Q?uXsr16jTa1bF8Eul0nWohziwmvTxotfkFAGy5zYtX6QXerQHJnu2JKEzyucc?=
 =?us-ascii?Q?Txjdqg3sRPw7oEW/DOcP+yHO605KeImFKm1q13BkAQaEtbg+ktG7FeCOjyhc?=
 =?us-ascii?Q?uTlrEEgfMY89Ub34BXjbbywy9Ez6DsS0hm3v+mm9Qq2zPJY3I1WT7QMeDMc1?=
 =?us-ascii?Q?mHlbcP3CHd0If/2WVyPu2B6VyKUIprbHoCXfnNhhC0yzEbjmzSdkuxLNSx74?=
 =?us-ascii?Q?RsX4QwPAn5vYcKlnSWUlXivSfk3b4U+AWOlo+fjH0CqatUNiQrsAqqi4h3Cr?=
 =?us-ascii?Q?r2zgM+iSfOxG2iEID7D4fxGDS3nQr9Ysd5+zAICh9/z3kzY2+Q6gKp/8Y6Uo?=
 =?us-ascii?Q?3rB1JSRrLB5xAW/k131SEqHgz9F59TX7tDumW5DL0YhXHbVEv2Ya66uCWPHP?=
 =?us-ascii?Q?61km3AULLRkMv4x9c/SdsqTQzehskmHmLndFWj0Bp47vRZS/HR16tXBaeqeG?=
 =?us-ascii?Q?NZXpA0OfYlvFsKRhi9q9WroPe5yZA8hzO6GQm6c2M2rGQC+/c8i8R0WBxuQC?=
 =?us-ascii?Q?r37LYLqy6+UO1IHZyQLlHW5ZOT2pqy3s8gm2PWR5GbGPW2bHyjF11GBobutD?=
 =?us-ascii?Q?ofxXto8ZIZt5qmsg7NII5Usa3AgfPBAdo8d6wTA4ePBXzLyoL683nOpCHnIt?=
 =?us-ascii?Q?5PZw5pBDIv/FP6ndYKSJy2kBjJm4pIrb9dcfUsLiNuePJGR7oZN6vQdE6yKl?=
 =?us-ascii?Q?AQGlA70wHAwMYGCMYFaw3mZy4Y+GpoWBQVT0N1XSk/Bs2xiu07pQGLFUcIa+?=
 =?us-ascii?Q?6YZ7EnqrN8WtNndBsdsDZOfqPkhIethQr+/qATzwQBQau9pfbgsdjlzJRREo?=
 =?us-ascii?Q?vEfDcUSJi+G8ysCfg/49419NjS7QtoOPDsakKdB5R7aU6gj1R8tfSt4n7F1u?=
 =?us-ascii?Q?oFGd20grytDhHd+XPU3K6hsKP1oqn3B2HjhOyFTDc68etiZHg24UF7e0CBcl?=
 =?us-ascii?Q?J5+ZqtsNg71KkUtqUYHxTkliLPQxRURQI9EIWBLYcLDQ+eELQ3pKszZ/8jNA?=
 =?us-ascii?Q?PRrrrvTIKwdblOabiyXBFBVc8qMhJpRCGGyQLOt5IsXcuhP3Q91AhP37kR8d?=
 =?us-ascii?Q?T35fwv0yPmfpL4DqQh50NYYt0DOWgiXW7LxXUbNjwIppPkUfIifLQw4pe2Yx?=
 =?us-ascii?Q?MpaV6HifG0yUmTM5/4qpNHSgbRWCyZ+1zy4N8Bsu1Ul/foGRDU6e7N4u/73O?=
 =?us-ascii?Q?nG5xPhlDJf+7S5nAU+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a47b0c-a82e-4853-f77f-08dcedbffc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 08:53:20.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTuTrTi9FDM7vwfw2ZoCnudo3aE1PDIlowoa4LB8/IcTWVlVjwUgzmAzZOvC84vG1G/sqkSruumvLCXY7jDPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

> Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid
> zero on i.MX95
>=20
> On Wed, Oct 16, 2024 at 12:56:54AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass
> streamid zero
> > > on i.MX95
> > >
> > > On 2024-10-15 4:14 am, Peng Fan (OSS) wrote:
> > > > i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent
> > > memory to
> > > > memory operations. However TBU is in the path between eDMA3
> > > and ACP,
> > > > need to bypass the default SID 0 to make eDMA3 work properly.
> > >
> > > I'm confused, why not just describe that the device owns this
> > > StreamID in the DT the normal way, i.e, "iommus =3D <&smmu 0>;"?
> >
> > Current SMMU-v3 driver not support streamID sharing, but we have
> > limited streamIDs(i.MX95 max supports 64 SIDs). However the eDMA
> > supports 64 channels, each channel may have a SID, but not
> supported
> > by current smmuv3 driver.
> >
> > We see smmu would degrade the performance in somecases, so we
> wanna to
> > give user an option to bypass SMMU for eDMA.
>=20
> If it's a system-wise global need, adding "iommu.passthrough=3Dy"
> to the bootargs string should work for all trusted devices. And

No. not system wide.

> particular group can be changed to the IDENTITY domain too upon
> cmdline setting, e.g.
> echo identity | sudo tee
> /sys/class/pci_bus/0009\:01/device/iommu_group/type

This means I still need to put iommus =3D <&smmu 0> under
the device tree node.

Thanks,
Peng.

>=20
> Thanks
> Nicolin
