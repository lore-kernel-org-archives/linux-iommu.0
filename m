Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2016.outbound.protection.outlook.com [40.92.45.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D6181BA6
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722504; cv=fail; b=a/ZhRTAFXtyQMgrzFX+8oN3Yzg8nebNTcjIs/9XyAxo9dFl7MEeF4HjTWICBE31dpRnAiPJlTmnN6eAnp9BIf+ua1CkaDZsfplfcGZpmBuXGqOv/MZzajJiNXxkkDzbMYyRUIP3F4euWtDZD1i87d4N/xPeyaQYkQXV6Uwv7qJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722504; c=relaxed/simple;
	bh=khyZJimhRe/6i2VXus1jLFx8LuzeWYeJSczy3NkzDJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQFtkAviiyss3tev3GMfXUgyYR64l9wVYVurPraSvjHzmQvTDmywqMLvCTPlDniAAnszXmFO6MEFIng8xbPDFqLMY1+VpARTXIqGIslUlWeUV2WJ1Q5DpGVKijCSdyXvwUW9ERTK8cI+sKkl7CqJoJCZ7HyphFXirYrzInjcsyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gJAxq6lY; arc=fail smtp.client-ip=40.92.45.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gJAxq6lY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDMkGljFLDCZu1t3hpe+svFrDbRkKSwfMKGtGprC9l6j9Ya3GF9AoWBFbpg627vfn/4OKCQcusU4T4oTmb25w9RiMkKfVW1GeBn0Hpb9lrlXOfJMvnEkxAu4NTo5StN0BgyeYu7FJK6n4HZuekkAmvWIh10fpehCRP3pRh2fAe08VzpYUbIWXLvVxF/dzP3B9MwXmCGo1vdPNI/pqkoQryYxBBZx+BIVDq9YOsrPqB6zNRK0eIqkMazD2mtOj81T4U5QKDl+qIeT47fe12HDqqNFak1Ouf4924iTmKA5gNK5tW3Y/Msqx2HWsjXC7LYZzCjgAvzVVl2iqJWXDPtdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KacOlsD1THBAX39sIHIiG5ObTJj9X39KDG4UUitcPgk=;
 b=TdQzPNwweiDlYXq2qiWuQiqhtv4cITLkpW6Q+y7X1/hd65BbZUVdxIb5vNgG6rt1VJRO2/U4bv1lRTO3JWYiZ6fRkTf6FEhllxEc4YtNQQbvihh/XjfnSBW2e8mXECcVaGTmeCc/qeLmPqJXPXsQzcbGN4SdMz0w04tC8RAuJc+gyZ9W/rW/ZiOQncwf9gN3BaaYLjKKaSrkpW2sLir4CcPsv7OH3FbWcXQzo/TrQfjRh6okIarh9zGWGYwaqqPpGebeQ8G8vWATfcCethmBGNjBr/F7tnSkJzvvIG1WpMfz5A+W0NQyKUZcUu7nHfU6664gBn7xjuIcvQCdZBEwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KacOlsD1THBAX39sIHIiG5ObTJj9X39KDG4UUitcPgk=;
 b=gJAxq6lYnMV9Jh1ukqG1Cks6g6LaIIQkaahMY8tmEUzkVwkDnHR1P1Ivhj1JkbdjlTj/dtv9EKedGAsSCuUXATf6A4qYPh3Bgo6lAl5lK3fRxKocStvZllaz2tukGNxM6+0r6JuxUa1kn/0KNXp4jDxB/NTPsYiZp1CmME/5aN+2GAUO8M+1RvgGFV/KSzGR9TDNgv5Jy91kZ87QopMJNoj2HiZHoExnSWffx2WKslcuqlqwdvpEzOZKEs+yGch4+XyJ1SENj+6Ys/Zsp8wnWjTnVr34dGM858XWVePB9g5Sseb01eG3upmnjkLyzHjL5clbu9yPnXzXazcYygjryQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7244.namprd02.prod.outlook.com (2603:10b6:806:ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 21:34:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 21:34:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
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
Thread-Index: AQHamxKg8G3tDdy39E2idvNw1Py2z7GVp95wgAGEcQCAACJyQA==
Date: Tue, 14 May 2024 21:34:59 +0000
Message-ID:
 <SN6PR02MB4157B333B126909197590DE0D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <SN6PR02MB4157E795C636EBE75CC806A1D4E22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <24a4eb65-5e1b-44f9-a8ae-71f5f8f26ceb@amd.com>
In-Reply-To: <24a4eb65-5e1b-44f9-a8ae-71f5f8f26ceb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ENJsy41p8Jcx9TU8k9MHkmSl7RKkklEJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7244:EE_
x-ms-office365-filtering-correlation-id: a37f4312-c52f-4def-ae7f-08dc745db4a6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 UFFWo04OuN/mOmF5U34QmOHuREGhkZcs0wrqsl2jlOhD+gV8jox1zOWXTHMAKCcd14ftgTlWKqYK874f10j6kQrhKnwxxJVfcYYNsE7Kz/H5pzs7KNKnJ2fKTsDdzkfxxKnNjcBNdj92wwuHMZKByWoyDBE0cWGIiwB+KmveEMvbta7O9yN7pZgZ0MPJ46cfVAfHyUZBPC6myQCpNr2qVVAYrV1+ubfHZfg+nBljalYr+N02Kr0eh7DaDAh5yCrA9a7Ec2DAkN9+dK/JiWvAk1W+BLTpwdifiD+hiJKXNcsob/k3hieGM3y4TKYG+xGqM9FupdHDOTt2CxPIfwN1AKcEcOaapy4esGD0f4PjsRDTB/9twoORQ7sl7R3kQlRQjT1puC/UP/heTN2cLchxzuB0r1dv22Ag66WTLIyuYD2iR+XkLp2tQJa4Y+lw0FlsK0j3P9xZLgWgs9SrG811BDbDmM+eZ1C9sbDaIaBuC2lfoN7X5FtCFv/8Hle2Bufiw5eQ3SgT5ViA4JIgjIW21cmhijTiFhKECpY0F0cOGtb29vo+zPWoUrrjGFZGKdNO
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1Og1Xak9byLLyrNEcFw/R99dkqJmM6Os+jCZv04L9EAnrTgnWquOExik7ZeJ?=
 =?us-ascii?Q?LRkmd3cJ0x9Md7IFDh/OdfL7FS4tZI908PK3EgTqtqwdx/C560NyGW7kBOxH?=
 =?us-ascii?Q?UwOr5dj2+aqDs6cox/6BB9LYU3uiPm1ctB6AA6LmMjRXaDU9b2F6UCIY2caI?=
 =?us-ascii?Q?IMBC9E5D8ICEJklj55jDhEbhhBw/cDozPcULCOjkgYDAPRUkfLRqy9rieQ6g?=
 =?us-ascii?Q?JxAKYJGpyvi8ykNg+6koH/Xk/030v3KPUyrFpTtqM+umpYZEYJJLkhw2YiKR?=
 =?us-ascii?Q?rdvM3F2sd8SzKDGZcKfOehTCcfial7arLkGUG9VbSjBdfEoJHHVB8zJkcSpH?=
 =?us-ascii?Q?ZzslzFLpCkjxhrFsxHJXOMQdlyoVo0lFdKHsn+D12cn9pF8kuymUZrrFdr7e?=
 =?us-ascii?Q?iGMGi4OFo75VfDIqH6IL/ofU8h3+OkxbExEPzhmVTLgEF5xJDt7a76l05zwj?=
 =?us-ascii?Q?rA5p4BbX+2r+vSTB6BS3GJteVxNyIZxJK85nkd5vjaOAt2H+bJYGNhTW6haV?=
 =?us-ascii?Q?0Sca6k078VdWbmbWsNIgIpItAyEvF2v/+4n/WHpahbO1zdOmNWG9KR13UcYG?=
 =?us-ascii?Q?Z5NLIZpGlAjihHhcRiYzBwutWaS37tId2dCHGez6wcerNDsy1cXiRIPw8YxS?=
 =?us-ascii?Q?sg5v1Dgw/8RqIQwOz0MIO0t2ScIKk+f7S60GPdBw+sjfW2aGHsDyWKwoff83?=
 =?us-ascii?Q?XMVmg0MtWMq7NmiSWHtseGn5AfQ6gUshuhU2DQJtDk2qTQbRUJO4tRNuYggw?=
 =?us-ascii?Q?G4Au8oK6PsZX1Zw8gtriqe90MBAJmcXDZtrKAVy7y+pkdthnghP9eQCaLjSz?=
 =?us-ascii?Q?2g26Uh7j78+UdonBfgts0hPNEESXguATV5J/6qL6nmVDeZmXCEE94cTt94YG?=
 =?us-ascii?Q?jq+urO5mvIbu+ImiH8OMvq3N0/V0olrlbOQZUSmF0VUVcXvR9yRZ++xLVvs7?=
 =?us-ascii?Q?Kake3Lf4LwYHgYEpiTT7rGfTsHlw89KjELu6L9IrZSF01ZvbfM8cGLmq257S?=
 =?us-ascii?Q?g2FOVmHyJxv9eWWMqpMK4Hhp0njAWJn0MU0byTns5tnqh8Zk/+AD8MhhbO06?=
 =?us-ascii?Q?ueRkQ2RXFpaJ6d+qpNkU4fBqLmIpaLk1PPizu5mmRPtmiMezL2fQ4wtPIOq4?=
 =?us-ascii?Q?uyftiMrPQqkUeVhYCSNX0iIRjJ3OgbRD11ZUIfBVda9kXWo1/rFugPy62/ZV?=
 =?us-ascii?Q?uswp2Uunm1Lp6AjDHdpDl4lMkPgpdgbNnpMYLDFAEsB00tt16kbt+u9n6bs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f4312-c52f-4def-ae7f-08dc745db4a6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 21:34:59.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7244

From: Suthikulpanit, Suravee <suravee.suthikulpanit@amd.com> Sent: Tuesday,=
 May 14, 2024 12:02 PM
>=20
> On 5/14/2024 3:05 AM, Michael Kelley wrote:
> > From: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>  Sent: Tuesd=
ay, April
> 30, 2024 8:24 AM
> >> To boot a VM w/ x2APIC ID > 255, guest interrupt remapping emulation
> >> is required.
> >
> > Top-level question:  Is there a reason the MSI extended destination ID =
mechanism is
> > insufficient to avoid the need for interrupt remapping?  (see function =
pointer
> > "msi_ext_dest_id").  I'm unclear on whether it is or not. If it is not =
sufficient, perhaps
> > you could explain why.
>=20
> In case of running a Linux VM w/ QEMU/KVM as hypervisor, the
> qemu-system-x86_64 option kvm-msi-ext-dest-id=3Don would allow booting th=
e
> VM w/ x2APIC ID > 255. However, for other hypervisor, it might not
> support this feature.

Two observations:
1) KVM, Hyper-V, and Xen all have support for MSI extended destination ID.
Is it reasonable to make it a requirement that any hypervisor supporting
SEV/SEV-ES/SEV-SNP guests must also support MSI extended destination ID
if the guest is to run with more than 255 vCPUs?  With that requirement,
you don't need any interrupt remapping or IOMMU emulation.

2) It would help to be more explicit about the basic premise of this patch
set.  I *think* the idea is that KVM/QEMU already supports an emulated
AMD IOMMU in a normal VM.  That emulation depends on QEMU having
access to data structures in guest memory (just like a physical AMD IOMMU
would).  But with SEV/SEV-ES/SEV-SNP, guest memory is encrypted and
QEMU doesn't have the access.  So this patch set changes the IOMMU
related data structures to be allocated in decrypted guest memory.  Of
course, as Jason has pointed out, this would seem to open the guest to
security risks from a compromised hypervisor/VMM, negating what
SEV* is trying to provide as guest confidentiality.

My #1 above might be a lot less risky from a security perspective.

>=20
> >> For SEV guest, this can be achieved using an emulated
> >> AMD IOMMU.
> > You've used "SEV" here and in several other places.  I think you intend=
 this to be
> > the more specific "SEV-SNP", and exclude SEV and SEV-ES. For avoid any =
confusion,
> > I'd suggest using "SEV-SNP" throughout if that's what you mean.
>=20
> Actually, The CC_ATTR_GUEST_MEM_ENCRYPT attribute is true for all SEV
> guests, so this will enable IOMMU emulation for all SEV guests.
>=20

If that's the case, I'd suggest updating the Subject: line of this cover le=
tter
to not be specific to SEV-SNP, and to call out in the text that's your inte=
nt
for the patch set to work for all SEV* flavors.  Also, the commit messages
throughout the patch set sometimes reference "SNP" and sometimes "SEV".
That's confusing if your intent is applicability to all SEV* flavors.

Michael
