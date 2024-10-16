Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D217D378
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069364; cv=fail; b=A0wTWZnvr0Ju73NU+vsPrqUHCMVJrrvs5AyUQZZrTbzTTKj7xiZaXhPUSq6U7xsk+MF2sTDddbJjNALNunbX1UTVdN5ObmxNE9xeLH88CFhcoZAEAMd06GHDxtdDW1RblntPPYGkmX9Kt5q0Xo29h04HJhWvM0nndTdlg4+bB14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069364; c=relaxed/simple;
	bh=I7wjYQK6y3bNSty7G7LS6dmhxc1DEP1HrubXIvEyYUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MolLyhDjTEJVxLlf8oua9IChZt57QvU585E+vyoCytai6ZdFNN/FxnhBoNtHYab++UmD9nb1lWUOsMUvPMnGcXmmzzU1ehPw0LYQUyM9ilscxLR7nkdY3xbnGsbzr+dWoKm0CNJlRE8wRp/MYb+sbpxPGflzcTKxbIY4/zB0W7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RNGAydd/; arc=fail smtp.client-ip=40.107.241.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RNGAydd/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAu0+BDUEM3Te9MfJVAd404Mrz15mT5belMRC+1GZ9aV5J6l6ZGYJhQLH9iWqGse6MnwWKY+bjA8UxmxHBxIcEHTJcYElx7CwVjBio4HyJV18IKxj+UUvpI9VbewZWhhCniPpBbCC0JkZRxnDE+5vJV+Go433lZptvLIye+RUrKig/usv1bGuQowIU0LpwUBAm5mfwJ/acLgjx0OzyIzn1Nv5psXZfAhJTUhnGTgMJ/fcan+E9HId3uXRq/B+qLoeG0my0Fabo7noa8WvthJ3JHBcPVb0eTEFuGvdzA97tOBJTSogODbobRzQ59SFyxnd8GLxyROaWaH6QyJS+c/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7wjYQK6y3bNSty7G7LS6dmhxc1DEP1HrubXIvEyYUs=;
 b=jBCjoEiBfXoRUCcpFpln6JyKwQPCr77/hKv41B1fqIMHYjEgCGx1IMxWg+BfBHzu4FWRIoUY0BWlGgMK5K/GZt0kbjJ74RqOJgNeGGxiL5vKbdK8s0vjjz01rVq3tBz8OgjtStgPr9WVUh7R+Nj+mhcLFSlP5diJVtE66m76G6SczvdHd74ph87ORkGzSItn3s5oIQ02Ba5iKPRy2lJVOTahPGdRTTfwI4Q2z2jznV0UghhJNF8bwDRySXm/uaOU3L/zMy+BsS7lfNVDVVY/LWc+44gJCJVMHmlZO30HwWxv6I4lQjA1mhccNtY5QJSuSnL/jnblqXcK81Nb6639Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7wjYQK6y3bNSty7G7LS6dmhxc1DEP1HrubXIvEyYUs=;
 b=RNGAydd/O2PGBH2zd3PWxSTFlducySceFQ0zvODFaTUG2wx/Dro620C+n/jkwcLuszXwnNUCChT2HGO2/E5vM/UmWgJ1GyoLp2ggA+SmUJUZyhHY4Wby3bIpMnEmYF1uKGt702H9ZhllO3eezP7u1YQvwt1SooQ+FNbG4sM5NqgBzlyh483uAV1+UjwCgksM6OmXyrS3OxRgnfr2qKe+mLSdJrNISLcN4568aZU6q5zd3Q2E5v8/ymDG5r+xgNNwWVRKWnLGtlsc3JDjW1zHOK23KCuj2HrQcTNxletzQIo1Tap1xDF+kfTRYaXPnh6mElyHec6snQr+MGO1MJS/2A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 09:02:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 09:02:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pranjal Shrivastava <praan@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joy Zou
	<joy.zou@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Thread-Topic: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Thread-Index:
 AQHbHq8wG+DwGXiFpUSir6SR2q9GZbKHdtwAgABMiICAACi+gIAABQQAgAABv4CAAAlUAIABGTJg
Date: Wed, 16 Oct 2024 09:02:39 +0000
Message-ID:
 <PAXPR04MB8459EC5B8A55E7FF10E550AC88462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com> <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
 <20241015153110.GM1825128@ziepe.ca>
 <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com> <Zw6UCLprZj6aaajY@google.com>
In-Reply-To: <Zw6UCLprZj6aaajY@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: 5f711ce8-2a57-46db-077a-08dcedc1494e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IRrJiTasMlthhL45qnjG1fTHr4fzoB7HHJCIIOo/zktf9kduZIwf76MHDRsV?=
 =?us-ascii?Q?za81bjWxzmLRL+nJMKlNeUVDLMaHymdaY0wpcXtJhYcK5yYamYa1nWS2VqMf?=
 =?us-ascii?Q?5ykGRYQLp7X72DOGzCJBmMbdlWZl67OJmhq7us2n60iGFzKI1hO/1B6eYuKy?=
 =?us-ascii?Q?Bncm01lyIwE6xlHjaS3UhcgcM+uN8eJSUkNplVFDWJuDgZP8gX9hOQySHxjs?=
 =?us-ascii?Q?cUSAls5UHWOKdUSJpio84VBAHPCuQZfty+ZLTM4g8U+DCIjA9d/gd0rc6ctX?=
 =?us-ascii?Q?qUTMnXtD1lQGY6dq275U/2O4WJJDi7Z0EvTb4a2YUho16+LnFrkuhxvKEIza?=
 =?us-ascii?Q?t20JpwffRyHuw+/oF3yI8fFw7A/0Pzk6GRVptbrnEgftBxf/Ox9FIGOuUV6H?=
 =?us-ascii?Q?kA1le27v90pH5w68QsQoVVjHb1V2XFTo8boVMmvqSiOV5fU/4x1mWdoRqezr?=
 =?us-ascii?Q?LcNSd0pNid1aVYziNduwX2HTnLvH7EAavV6yO63z5tDs62MEUNvu0HhzVG5p?=
 =?us-ascii?Q?QK9e+S3dZQdhqLW8q3xqUJUpZOswA9iA70+nfmqXtPEqe8It55nwNGWeEzxZ?=
 =?us-ascii?Q?LINI22p9E+3xTt0N4SZXB54avTsnfsQ1kYOBIvUf/LsFg+bf4BrsDjwDuzEa?=
 =?us-ascii?Q?KgyeP3GNB1LHPVonhA3uEXu3aAQh7h/i8HGmNqz2UOqXHzwg2zlDjc5HDk9u?=
 =?us-ascii?Q?9/yXUM/aMXC6bI1GA3t8KMNtM6cZPrsnZ6/PqKLm4HZjmnPZPnhnjENZbaKA?=
 =?us-ascii?Q?tka3e2sRGfON9kukGlx4Y+1wWGHmO2nJcGxEIHp4kPYjkdF30BRRsHC+npSs?=
 =?us-ascii?Q?wZGpUNzHvqeKbyqH/YRGpa/DLflyMlx49UtfE98IzFKJCvu0Lma7jafJVKsX?=
 =?us-ascii?Q?kj2kbwjW4+M3FGxwLn6NTRFRuxFa7B7dST9wLh75h0qMwVROMNi6AgBzTQof?=
 =?us-ascii?Q?x7QVnJ7zT7ji5xQ8fJPnHdBNZD9WV1WTj+n/ylsn9El0QBDB7I6vuPvuVm9o?=
 =?us-ascii?Q?dMuCyFsEecA9KvCAe6zsWYgUPZRlVzGa4DjcfELRD9nj/MSkTenb991PNopp?=
 =?us-ascii?Q?1MSLhJwOyCUJW66MBaMsvOu6BPqh9M+nmrckOAXagGw1uFpGx2f4JdNV6qGs?=
 =?us-ascii?Q?/GV1GF1gde0aJ/Keq48q9Owmb1jFnA+UD1Dtlop4BePYWUr8IiQdqocogg2v?=
 =?us-ascii?Q?Xc8/vv7kfQ8k8eJtDMuxKQZqXcWw4/2VGOtvoUhK5QwwBIKJY+TgfQihPCKX?=
 =?us-ascii?Q?E4uoWXOOlbRdOkejuKVNlhvgJ04K3TzLb8ApEtW8VjdWPM6J9HWBUH3og/o2?=
 =?us-ascii?Q?xyZnO9mO7RMsl+tPrV3rRQdK/HwAkJq9wigfeKhJZ/bJ5w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UEbYR/qIi+0M9O1E31ReMX1lfFt43NP6FI5PuNFxKT7OC6oOhQdLeEYb6ndN?=
 =?us-ascii?Q?l7CoFeCxRxRrobOLlTmcFP0LOR3thsJPNIo2rQl3vdWEnDc3F5Tu49Yox3Ll?=
 =?us-ascii?Q?RnMr7DWQ99re5vdVmDswBWbQTOfAST/NBSMrv16bJvviLhu9ff2vS6VG+0HL?=
 =?us-ascii?Q?ztlIyxmbcNfakI8JEHgD7bVlKLxtwiqLolYwT9bH7vq5qLjxcKdMaCGklnTT?=
 =?us-ascii?Q?Desq2dTGsYENsqJryly4HOnAGGXkt/zdh4pZ1pKawEWT8IqhjkX6N+Yjz7i0?=
 =?us-ascii?Q?7L5OA6FVYfQg6ab53YNmgPiYopHLxI4FIiJmxpUgzoZruhADqeuPHTyT+4R5?=
 =?us-ascii?Q?o0Be8NXyz0Jgnh9PSbMx+nGBwP5lEJzqNsQsSJLhWumVrxKfiwu+Q6FdUDt8?=
 =?us-ascii?Q?2qva/ccYkXLEn4iL/TqWTeRB/7O9P/tswISphYnDwdDvHrfUXVlwwqXuHGYh?=
 =?us-ascii?Q?ETRDNfM5q/fIh5CFAzQpzuE2ayeJeslZxSF77eU3L4DX6ZEpTBWM/vRrhSWT?=
 =?us-ascii?Q?7e0rKRWp+egKUPklYsDAUQ/HbzM3JoqNLdkZrThkpr86wn2UQHozP3fTnPWF?=
 =?us-ascii?Q?KjEIYGyBnNVkz+H+cjCECu8hW2BnxYfuC5qVjO+NZeHHlAWcWekkApxOuJg3?=
 =?us-ascii?Q?AJGDFWHmSiDolw7mDsBvzvKC8ZETZ2BCfDJo3aRO1z2+KDvlBL7bNFQKA5gq?=
 =?us-ascii?Q?sVIJg1BVSuTcE4M966HsYmbtr7chv6GTSgyKHcis3iczjHnVvQiu/0qa71sq?=
 =?us-ascii?Q?SENUKm6xAHgoKfCYZZ/LCYEJYXqYF2uCTcHdOtDsj/LOPSo2rkawHTukma9c?=
 =?us-ascii?Q?Z8CvlF8KSTigVbONcLoWlvs67WLg9linmabyls87L13JeArtrsoq5KR6ZtEC?=
 =?us-ascii?Q?DPRcPxwZs4ACUWuBqJ18BC3RnUgQhP28hBUHSHp0b6AN2qxILp65MaMLVlkv?=
 =?us-ascii?Q?4kzs+VuI3sYIzmLzbNqzlZYwbQ0mNq7bNm7c1PGuYlOIpXIgQ3fARcKhN6DH?=
 =?us-ascii?Q?oCfe1tsKmstKrKrk6wfHVs1nINHU13yKd2tAzwRWQCt9OXijFQJE0/buCOrE?=
 =?us-ascii?Q?sMR/vviF3BRm1A8Y/fEyXEm+9b/5Q0uiVeizJzybju3mIOYonCXErKmGCrnO?=
 =?us-ascii?Q?hfAaiFopPxpBOtygV8wLk/5iV04FIySxRGYjTCiKwQ1IH3SjtMHvOOcc9Ay7?=
 =?us-ascii?Q?jgIhKRp36jnjscqR079OCbcvKopKxIXQyOosB90BHgiOZ5q28m6ExTL6P7lc?=
 =?us-ascii?Q?1LWhIPPFG9BQjj8Q4lyCvxYCs3aGfrXyHBmHRhCoOXE2cZVXyw27i5iY04P3?=
 =?us-ascii?Q?Ym4Pdvf03ejDLiKtlzOPP4EQ8VVNiBbYLUHZcUNwuPFV454PYA494zEo7p3s?=
 =?us-ascii?Q?ZC5ZKX/fgWclq40C+DdUshVa1gpOLaTML24xvWpuRUQ5F9WHN4v7WQFCevWS?=
 =?us-ascii?Q?ORdhX8CqUmmpUtwI8j0lGxTqy0i0qe7imNB7FTEPaY98HWoM+k9pz/MgyF/X?=
 =?us-ascii?Q?A6JSvKzBfqBtwxGc8nlw4o6a77p8zmsVSwOZV2AnHLntTrbYiT6UnA/L4GbS?=
 =?us-ascii?Q?Ju+NXUAqCXnU7GaiTlg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f711ce8-2a57-46db-077a-08dcedc1494e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 09:02:39.4053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwhxntHkKuQtH0M4or2u/1MHKndXcS62VEvQPxFNaWg30sEWWIhFWEWPNwHjWD3p/NY274dsuAzYfHoPX7SSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786

All,

> Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for
> NXP i.MX95

Thanks for the discussion on this topic to show much information
that I not foresee.

>=20
> On Tue, Oct 15, 2024 at 04:37:25PM +0100, Robin Murphy wrote:
> > On 2024-10-15 4:31 pm, Jason Gunthorpe wrote:
> > > On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> > > > On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > > > > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava
> wrote:
> > > > >
> > > > > > Umm.. this was specific for rmr not a generic thing. I'd
> > > > > > suggest to avoid meddling with the STEs directly for acheiving
> > > > > > bypass. Playing with the iommu domain type could be neater.
> > > > > > Perhaps, modify the
> > > > > > ops->def_domain_type to return an appropriate domain?
> > > > >
> > > > > Yeah, that is the expected way, to force the def_domain_type to
> > > > > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> > > >
> > > > There is no domain, this is bypassing an arbitrary StreamID not
> > > > associated with any device.
> > >
> > > If the stream ID is going to flow traffic shouldn't it have a DT
> > > node for it? Something must be driving the DMA on this SID, and
> the
> > > kernel does need to know what that is in some way, even for basic
> > > security things like making sure VFIO doesn't get a hold of it :\
> >
> > Exactly, hence this RFC is definitely not the right approach.
>=20
> Agreed. I assumed the bypass was needed for a registered SID.

I just reply here, not reply each thread.

The SID is not a registered SID.

Considering the security things, except "iommus =3D <&smmu 0>"
being added, is there other method for this issue?

Thanks,
Peng.

>=20
> >
> > Thanks,
> > Robin.
>=20
> Thanks,
> Pranjal
