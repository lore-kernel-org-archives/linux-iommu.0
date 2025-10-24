Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012063.outbound.protection.outlook.com [52.103.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892541E260A
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315840; cv=fail; b=qfHkV/V4v5PJnen3BBOQ/6VwpUq9eEW1gMGTFG6FfHoUIO6czx8cNxfpPLOA2BnaggWFZ7hoeUOBrB+fm4yJpsyrW4rWzdLjF5PAymDlF9qae1gMoeamcz9tAXzeHYFfVpwgl/fhpBhPU0dqkM0CtJG/888+j2MuR30R6jCDY1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315840; c=relaxed/simple;
	bh=1B7Z/9LS9YZHWTkR08D+p8ImMK/aG9DYI2kZFhB325A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tfC2Pb/QwCKiD5vIgGfw7BG8Eti2duvzovlZKmw+F8iaf6ELfkDzQZszW8MmaDg0b5u/e8jlEcYTenpsqZeBGGqGPGEhzfeGSo6ZGyVLr91oFAsgBHdgPajO1uRX6hsaqsOM0HOz+Umnd6GT0dFyJ8k1b0Ex+IsRUdtySN3X6v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=l09QKyzT; arc=fail smtp.client-ip=52.103.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="l09QKyzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoxYOeMQarYareWJ97efaqEXLS+VAut5XW2tSvyRHBGC3Iy6V3X6LMvOslP/FsGWjhtGSV2LssGHka7XHuHp102zb8wgsGkcraDEtp/IHj87HaW9ZscPeoCXmoC7hRMYYowSrJC/5GZWtwXUTtihhk9MgzOlgMemPo87MAwChm/lHIDAbRIE7AR+nxmscsHjY45NUvWnN0nGbHhiJocKqUpTTo2AFEDrr4cyi8TUhsET6tN0oTyD4i8bwag1f9uwu6DYT+kg6+bnz+Hp2cKabD11b3Yabjkj4te9b2pzYTZRV3DyNrvXoJ3jomu8Ipo2JR1RCWxfrHhvNMkMQHoG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B7Z/9LS9YZHWTkR08D+p8ImMK/aG9DYI2kZFhB325A=;
 b=eZ5HjsXgBBkrj2vzyixrsGj/CgZtDChOf+U4Ax965npcPS9e0phrF1zj4DCj4IdV/REBQsQDAaGd+opa29FahvGs8k/TO1ex2uvy2w/7uTdAgDaOkoNlehUUCOr3B9EH1ZGrVpRwu854mhyfLR4ACxZDu1ebx/xa5HYOMmC2iu9FZIoVfM27WmxnguH+ZddmeRiMd/b3IGZDvztVvpAkrL1eLdGeYZp8J6UQXAq8hiw7cp5ugHD8I9LAw7HDGE+M8X3fGjiqFVku7wptKS1ZDUwyKSj7OP003gQn9GV6YuYG9VRfl+dQFBra+RuASfA3W0zER/hHQ06wfNaJDAm/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B7Z/9LS9YZHWTkR08D+p8ImMK/aG9DYI2kZFhB325A=;
 b=l09QKyzTCHfXtFfgDnXLVL1AOChx6QsFAqof2FwACvDhJIHCu1xe2CrVczo0xfA36gALhK4bJ7+nNmWRchj5WvyWmgeYX5zzcY2v37esPcltcp3j4WuIz7MxiF1WKmxgulRMlLKfiezBBa2vo12UjZuJ1bJ437CZ+nUyytrJgNSyRnKpPR5UjeXETLNXhtS/G4hWwsd/btTpy/8qCCGkt6th1cY9ksLl5OR2xAEtVzjMkpLpknXlrpD9Z7p5bp06wPJnaF0nUvjXiqPDtukLJ1LKkAuOECIHJUM7UfHSSMsoe+wBgN+8k4db1cCx+kiBgUxIWRM14tP6e0WsSrzcFA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:23:54 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:23:54 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in IOMMU
 page tables
Thread-Topic: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in
 IOMMU page tables
Thread-Index: AQHcRC/z/2IcAo5ooUGdDRtk1NmW6bTP5FMAgACWJjCAALMxgIAAIhhu
Date: Fri, 24 Oct 2025 14:23:54 +0000
Message-ID:
 <SI2PR01MB43936BE606220BBABCFA30DCDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251023160154.GM262900@nvidia.com>
 <SI2PR01MB4393D52AD53469388BED8E6CDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251024114039.GA847003@nvidia.com>
In-Reply-To: <20251024114039.GA847003@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|SEZPR01MB5488:EE_
x-ms-office365-filtering-correlation-id: da5a1a5a-e8fc-4203-4ecc-08de1308f602
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|12121999013|8060799015|8062599012|15080799012|15030799006|19110799012|9112599006|31061999003|40105399003|440099028|3412199025|102099032|3420499032;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?q7y9/6yYswJl7vRfPS0ky9EIB/3EMGYxin8m6yHENBC1XrngSwf7AaY/?=
 =?Windows-1252?Q?asfxBL9RUWWgi04gfUZrCE+0N4lAL28zKN6rC8vNEg/42dujwAWE1dWb?=
 =?Windows-1252?Q?ivKLqD4sDOsQHotMP8c0psEvommxboWhLmgjhs81VTvRSFOCGNEiOu34?=
 =?Windows-1252?Q?/sJKI+qpvBFmgFVMlBPkwa4jWTSM2mGdoxFD8DISXFCl9GX1KCj7H/vP?=
 =?Windows-1252?Q?zdPpiJfOFx900cQILWFrpKy7nheBPLfheCjg8wr83ctrj+0L7zJXrbzC?=
 =?Windows-1252?Q?CYIDGy7pXv0JmUIx9UXu7+wraMoFIp3xEYkQVRzsIVODYNE9QKTZj9CO?=
 =?Windows-1252?Q?Vng51ElzNxXjqMxaV1fyfAW40X9eGzUMoHmu/tLAxk2AKsWdAMApm4pA?=
 =?Windows-1252?Q?ZzDRsjSB+omGdjqOcxfHJ0igqsouQgcX6yXjECuPG+ixx/jxqSHC+5kI?=
 =?Windows-1252?Q?aSdyjbt881BH+MjlFjbCjtZby1IUcK5iQ6lhrp5OfIlpWj+QnmTqfATD?=
 =?Windows-1252?Q?w6g1KzezcRFDARlFNa2QVOE3iYBm5+nYw0sn3d9hq3+m+DKJ4DcD8mUa?=
 =?Windows-1252?Q?zpemJenPBLou8YhJqwmAne0/L3yTjJT4jq7Targ++uAQ8QvhfrOkWJiG?=
 =?Windows-1252?Q?XmaRoj8nGnENDG8g6h7nHdc7N/i3ZJx6bCHpc2VFB7ztSDpS1wocxMLX?=
 =?Windows-1252?Q?bv5qWKnR29xfpzmYrSG3B31X75Um+M43k5c5GtWJ8X9o2ZvHnR/eR4Vw?=
 =?Windows-1252?Q?ydHieVMR4f/RW1Jts72UsPUxdFlWrVoAjEN+6uQFUIYClwjsITtulLCn?=
 =?Windows-1252?Q?gRpLbQp5QYQT9K9yPpQI/6tqind3k3h2K1I16swtPNtAcGo95GjLTcIK?=
 =?Windows-1252?Q?2yf2QtGh0POGMQqSFs8su6/Ly7sf4glTAl3JwzQiVRs/gfmbVJ161bZV?=
 =?Windows-1252?Q?LdO0X8BkUCez9E+AyoPuswsRUG33zoDr2NWo2Rw8ynAMotWWs5AZFPyy?=
 =?Windows-1252?Q?ujDSN1X1mjqJnlOgkCcoJ8VBLHjYLFsqvnmcFed/rQHHNA7/7E853wpL?=
 =?Windows-1252?Q?WzwS+SfAYx894cERNylJKhkh/qxiSHP52Am2uLxGVKfnZgik9a8n8ueI?=
 =?Windows-1252?Q?NazIj/vI2bUJk5pSXxcdtuC41zXVuLiOPlcwklGaYnHx0Gw1cQ2QY7pb?=
 =?Windows-1252?Q?/khfzYgaB0QK/f3C2ag0NevS1Wx9rKtPnyjeSS5GcNofg4k2lJxSb65R?=
 =?Windows-1252?Q?kZwnjRE1kJmzFGRGpQ2mw+fMXhOVomo3vg89BR7sIp5BYzwxzTLF7tWV?=
 =?Windows-1252?Q?X2LEuRibpyzFo6gpBrjDPKMe7qVHMMlkCEae1+/N6ieAjkKTF1HZ5gT8?=
 =?Windows-1252?Q?i62Zrh42llcyMA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?k8KOnnsaBYw+tdmzabmnuV99rcywWnVfgdiSKs7pnSNluJShsW7VtMj4?=
 =?Windows-1252?Q?sXoyTlpGti/gyBgGCUamqfmgvg1nPFMY8oY58lA+UVRLy2As9ouGgRK6?=
 =?Windows-1252?Q?u3LcpQ6sVWyOoKpOsXfeG+2WwNq7AouiO5mBIEjMTNAmBRTFv2RHa8kt?=
 =?Windows-1252?Q?zg2UD87LfTTSygNQKUSTO/5AoRX1Mpe70Tjaa4UvaLPlCgWqmfL1v2tA?=
 =?Windows-1252?Q?c7hdxpX5X6mKwCf9ANR/mgxLtV0QDlkBpYwCSvUxqvAzvg9Ah5U3RBdP?=
 =?Windows-1252?Q?8+Sb5i43RJ0CSTNa0uAMydTHcvn2Qa2VIN4i12FASTNpTJBu374wEfpv?=
 =?Windows-1252?Q?7k/Y5HC/OlyALYhqHmI2KUJBeduEOW8LIoNW845BLr1slbjdWL8c97Ui?=
 =?Windows-1252?Q?/PcOqBipOpn1hvoqJAE0barO4/VhFwZp3KUFK3/Ea3pNw7xF6O7j/2er?=
 =?Windows-1252?Q?poXPOqw+AcGe2ShP05NXz2HrduOigX2FkdDQ5CBVoGrtJLKRVr3Xh5Ys?=
 =?Windows-1252?Q?L/4JGZ2iJscBav70FEqwZf272b7DvOWNNrslqayHIgSjjnidsWW0Z9/q?=
 =?Windows-1252?Q?lQ8Ba6TmeVnK3CzK+dqouve7CUnk2mtVGmGv+J2Sl1YkAkzR1ObwDP5+?=
 =?Windows-1252?Q?KZJyakpAZiU+Db8mFrGdAHjG8srjVh3iPY8poeCM57/iYIfwIMTKA2S5?=
 =?Windows-1252?Q?PqOfB74a1KH+zJx+vpBeIJLtpBz/M+PvPO8v1EoxEyJWKc8nIJIR8jwV?=
 =?Windows-1252?Q?Aq1YR9XhhNJKGUnEjFmqRma+4yH+t+vc/cW+XCgMLJzR61ZH07vJHYMF?=
 =?Windows-1252?Q?kipdaAy489dkoexaXNRSQd5cIfwe1sfuo2W5Yf0P4ci6SYB1VVxNpgAi?=
 =?Windows-1252?Q?qfg1mSEXFBscht4SIxplt0iTygGdSiB+PqsK0M25aZ+dS0jEjF8s4/hL?=
 =?Windows-1252?Q?qEA0nGxnW4T1kJtW3riuuKcPNohbm8eEPv+mDQeK3JxG97jQdYW2UefU?=
 =?Windows-1252?Q?FCqGCvkgd5gIRgk2Q8Y7a+XZtCFxOUCb7qpkt+KzzbkGpmFbGZd/33iW?=
 =?Windows-1252?Q?5wQ1s3QEUhbe+02LUTBILRND4hTc6D6C4If2EH/Wuzb2npu1jrGFiRn0?=
 =?Windows-1252?Q?4UgQHjFCXMIMuz+hO2GNMwTRwAtVNjEoY5t7p9ZIzEBqpNalsyA8AQA5?=
 =?Windows-1252?Q?hcErW5EHzkOlLqZcYSdPkVxrXIKni6HixhzA3/nM8jDuY1+HpFnUeo8Q?=
 =?Windows-1252?Q?UL/z1hd5dE893BKTyMlaEMDU0llHx/lrlQ6Z3DW1YQoKdCq01zY9MEwZ?=
 =?Windows-1252?Q?YTsoajzmgfcMbRrZIJRsFgm8+N4=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a1a5a-e8fc-4203-4ecc-08de1308f602
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 14:23:54.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5488

On Friday, October 24, 2025 11:40 AM, Jason Gunthorpe wrote:=0A=
> It is not a santiy check, a sanity check would fail the mapping. This=0A=
> is changing what PTE is created by trying to guess properties about=0A=
> the pfn.=0A=
=0A=
It's a check and handling for now. If, later, it becomes necessary for call=
ers=0A=
to pass an IOMMU_* flag to request the Private bit and upon the=0A=
check (via page_is_ram) failure, an error will be returned to the caller. =
=0A=
=0A=
> IOMMU driver to validate whether a user-supplied address _can_ be mapped=
=0A=
> with the Private bit (RAM is the case that "can" currently, and since the=
 driver=0A=
> can already determine whether a PFN is RAM or not, I'm not sure why it ne=
eds=0A=
> an interface for users to tell the driver).=0A=
=0A=
> As I understand AMD's architecture the hypervisor runs with all ram as=0A=
> encrypted and has to set the C bit for any dram. The MMIO is only=0A=
> protected by the RMP and does not have a C bit set.=0A=
=0A=
> So even in a TDISP world with private MMIO we still end up with=0A=
> system DRAM being treated differently than MMIO.=0A=
=0A=
Yes. In fact, the mentioned P2P broken issue also occurs on the host (this=
=0A=
is the primary case that the patch aims to address). The SME feature is use=
d=0A=
in the host/native environment (not discussing the SNP guest case), and in=
=0A=
this context the C-bit is added to the host physical address.=0A=
=0A=
> It really does seem like IOMMU_MMIO is the right direction here.=0A=
=0A=
> Again we should not be trying to guess if something is "ram" or not=0A=
> deep inside the iommu code. We have IOMMU_MMIO specifically to tell=0A=
> the iommu if it is ram or not.=0A=
=0A=
Sorry I think my main confusion here is why this is considered a =91guess=
=92 of RAM.=0A=
The function page_is_ram() clearly returns whether it is RAM, right? If so,=
=0A=
why is there a need to add an interface and require users (e.g., p2pdma,=0A=
vfio etc.) to tell the IOMMU driver that it is RAM or not?=0A=
