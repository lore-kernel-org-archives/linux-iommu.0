Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013075.outbound.protection.outlook.com [52.103.43.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CF2356BE
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724900; cv=fail; b=toEydmNG2zVPFMHBzEbOkiozd951o+p7Aa8NmkrKTS8bJ+vRdAsVicT1Sigtkw6dpFGshiIauEViyVU8qA7du3PfwPuM9tCqhFfDyG0RLUtkYXuyfyEjqiC0ot3Dm4jHXU49qFs+6bEAqX+ql81de3ivVZ04bvB06rvk8XeQzx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724900; c=relaxed/simple;
	bh=m6jacucVj6ckmZsoax1Yttsf7n9aCd5ubjlIkThQYvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPMFZH6Rf6yW9PH+dtaJlVsJNtsTcy58L2gRjKgQgIhN5aHFEpdqixyiMdIrYbCAnuC58/UakVjaVsuTueXqFCw3ay0CreXcMb0JMnd5dHHmTMPAu69CzaZjPbAY0Fgoufe2wMcrzYgkWwIsOTdB+mpOBUeYOoOoF3P9cWrifaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ASDRKlMZ; arc=fail smtp.client-ip=52.103.43.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ASDRKlMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDESQ+U2Lp+WTvJwwv35MLCUxzsZYZD8iXBI7bU7ZhLwIqkOu3ZiMFf06gaRVrxHdNoQzYFybolTmBcT9/BTpIqVwUckz9wVjFfaUGfd5w2aZblMurIKMpUNlQiDVuW0q7HuFgGMEGZKeNlrqavZi800vWqni+XQKi5eiFkvcskYqPM6L4EfuVEHcnp5gt2zJ+o2G+36qag6S4Oz+CE8ORn4j+0SVzzol8kYPDWeYSToAEArQmi4iZZPm24qP9jBRQQs6e4dYIvXvnr5SzWwyuYkaSd6ocBTAsemQHZhBBQUTUXgSXoCxyjP2obd6I+Z6rLThjZpOObb4GO3DkKg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxER4VNvdEg4hUp/2dJjUZHw5alR7vqyd7MqOPtEenw=;
 b=sO1t8onU5PP5rfQempEVLT1CvDLmPD5d6J/6Dk30s+WHY5IfcJGefH4qT8ehb5Jfa8Ie9Tc+L0nyrK8p7xKpgBvTgZNRa/jJeGy08QFHBB3rIHUfa/GcLrKwP9wH3nYzqpVTlsEbsOYN8kO49EZk2kNovSaPK98oqD0lweVL+wunbRA0Poh/G/h3TG0mv53GAAjqEaYq8r4rfQBZVsgPcNjrzOPaWT77bJOAX/bxi9Ijw1/qzRe8mrNSC7l3jCfuV0tSsRf68k0PHAmEUV1e1bwKoiKcJx+sEoyil9F0H9jNfpfBAH4oYQys8I2JpkiQT25EQXit5I+KSxHBkmNpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxER4VNvdEg4hUp/2dJjUZHw5alR7vqyd7MqOPtEenw=;
 b=ASDRKlMZqhXjp5ylbleK3VpGxUVLM0uc0FXGJZM9qRXzomHDCRU9K4CSos9Rd4HOzLEkmkGztz/IhwVs9Y4E/6OszwM7HdsBIRxPLGju9XCamBv04b3iabZ5WLiyN+PiHUOe9zAvqWC8p30EYT9m5vTyTq/T13iLbFbsCky1NWkPfp0QVp4Bsgw1tf04VLODWDR5jY5Mr/92ibx934lNcoWpD+A9TNfEOX0/V/xVkC/dU/LaUYwxv2/vL8cQRvunQD5+iPsGt3XIrqPGfy8KdVlxSJZYY1rQVRyC5+y4XM8lUg3tmvylIAku9Vld7KAx6Vj7ZA9lja0VEoNNUgAPtQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY0PR01MB5860.apcprd01.prod.exchangelabs.com
 (2603:1096:405:19::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 01:21:32 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9366.009; Wed, 3 Dec 2025
 01:21:29 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>
CC: "aik@amd.com" <aik@amd.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index: AQHcVLXNSc01tiJSkEyy4nztbW5VkLUPNiuA
Date: Wed, 3 Dec 2025 01:21:29 +0000
Message-ID:
 <SI2PR01MB439387BCF604503978CC80F3DCD9A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|TY0PR01MB5860:EE_
x-ms-office365-filtering-correlation-id: 4160dc03-f82f-4b57-f87d-08de320a4959
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYDNeOwj8cuKtJn/psVSTzN1D1nXlguEdVF3avs/h9H1POJbGt/UBqvZjbd8/+AjcwP7dZ5I2riElJI4VlXf3yD064mlYx76aSmA6v54uoO5xKtCD8fpy4Ww1QiAbajMeIHAFsMeTNif840/MQwlewQQJpdkY/0yKqSWnxMM4Azl+MlhPfSYBtVXd6HUAeLgbFDFi6SJxJaOuBbTD3eFjGzf2cj5r9FcZXsKWJY/veikbDRH/H5luoX01bMrLnQHk+Qo/YuzBRvPe4reDtSmK3gec3pXnVpnJdUGXCaJJ3a27cLdG6iQRTD2K2k6iSjTiLoGZu0XUBwM5xVAXJyAi5Ls0PKiwWHBNSRN+ivRGm0KSCEWh8j9s+x38S4BYBI0jVqfN1jekWw9hqA3aicfiaRPNBDmtlsP2vFskg/PGtq60G9xTG1XEHyTQnrQueXR8uoRXFM07GLDkxTHl1zbPvox1Lbx2LMhksWP2LN0TekelgH03DuDVV/nNecqP1dKYqXKz32HVPVOafAL7YvmKWZ9XYQXaM69JwjOi9YjkygnC7bxVkOnSBkocReg2eVZahvXokynOt4QNTMzyrhjmlzJafurIrEea3XARNcV6/9+DA72YRN7UrsFMApPVhxTpkWewhYJeM7cXKJzGs/QO9X+QyAuUxizqIi56FCM8zEBC9+243raV8drkI/9yozFRbEwFRSzb46hKdExtQcXDhN535R9o2FWyMDabed3vCOYoCEzLb/bifO8wXlIMbCMVy4knX72QchOd4MO/PSb1uw3z54A4i88XFqdLPRfiEDWMr7jCHI69YQAWiRbaqvkCnMf2zu7iP5hEw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19110799012|8062599012|8060799015|41001999006|13091999003|461199028|31061999003|15080799012|36102599003|4302099013|3412199025|440099028|10035399007|13041999003|40105399003|102099032|1602099012|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U3lHhPcWGzlvNnNA5b2cg7dIKqj8C4ZCgSvYBkreAFlVmQSVT059nE99MRH7?=
 =?us-ascii?Q?TKzwmzMfYf+IGsweIIV+WYaPCLPZmGEfoNEpsyCDMcDMES+FkhxIi3tk46zu?=
 =?us-ascii?Q?yjXw1d3JVzcSlBoh+kOCbbiY8eXHVBrzJVuuknOlvwxkOWwxIGZs7U/2qaSl?=
 =?us-ascii?Q?o8HomdwPKH28bagnAlKW+dV8II4UKNAw/13wIyBDpTWbQjgzqWAvD2rAol17?=
 =?us-ascii?Q?sneHrE377pWxoSpLTy6BHU2U/zwtmuyC2KSIE7rraMYRkXSz1ErGPdGhrjCX?=
 =?us-ascii?Q?gyOvVnWUqx5x9+S50QBk3pu0AHML2vRNDTcmqEEanOxO1nwtV7/MweN8AYjs?=
 =?us-ascii?Q?/Bt54WqVKyeUAoUrxvouWDMEgCW5GKKpnZGPFodXGF8foe+nsE2IhCM7DGHf?=
 =?us-ascii?Q?tE/hwgl9fN1JbUdBTFrXnanLPHFfgx9cXHerraH8Gp+L2rxS22sSUO2F/llD?=
 =?us-ascii?Q?Q9fnesJa9ywV/aljkTr/dtF6VNgm3eWGiCZaQrIpc7NKnS61BHeBzqkcLLrE?=
 =?us-ascii?Q?29yVgYrvsHWoVLJY01QqjYyz1Ag8CUgB1Nh5KkwM7AgUFpWc9cB16BsMcfRi?=
 =?us-ascii?Q?gBILVNyTYGQcCrZ0r5YxNhD5LJPRHY9w6v4/QMIz+Vlv6upeUzzXTOkinxkD?=
 =?us-ascii?Q?um1Dv47P8LB/0j5sfkAXQsEwwFBNZYIlatMTTpaUOs2xM2oONkiTVorIsM8R?=
 =?us-ascii?Q?/ssw3F+XMeheg5cLPvKuoZmrqWRjKHS7xHuoz0dIOCM9naz2On24hXMAmHoi?=
 =?us-ascii?Q?ALtvrV85B+F0ogKUb0XBMUV4omVglkyKuHJPLMOx+KGzc/NYdM8nSnS7RuSJ?=
 =?us-ascii?Q?FACoF90JpsbfUvbyTPAJ2+fy7Uk+gBG8JuLVQTlHTKplaTUzBPRcKJRcbeJf?=
 =?us-ascii?Q?3ypW1VfITN/RA2k3IhX101i4gy/PTFDsjpRxpN3fB/l7siEAtHYMWdq5+R2H?=
 =?us-ascii?Q?VZpLwJl6S5dNSHIBqz8lRIsK1t6WzbW/Ys48Ov9d0zg/Hg95aes/FYNaxTHy?=
 =?us-ascii?Q?seGp63qD2MF38aqnMPPgb6tocoeJuXUb7T8F53O1ucSje2TSm6knm/qATQk5?=
 =?us-ascii?Q?ts3xYanwBxE7QJHwZLbvCNsihsqRuc0gO/pbjO1sHblUWs2GEjiX37t4fTul?=
 =?us-ascii?Q?81fQeb/Rd8SwsDJW0HIPNlP5rV5EIM9Ca41Ea7wfvboomByX5D/MIv+ftR4k?=
 =?us-ascii?Q?j3C8/KmKoOqLnpn7OrrnJB6InE1pcpb4A1tjwMALvSaJ5qN+/Z2R7Nb8mceU?=
 =?us-ascii?Q?WdWcIEKdilBRwZosG7Syk2H80e876AWCJRvDOHsaCEQi+uFyByOgJdpMOxhH?=
 =?us-ascii?Q?b1Veks0jdob8O8sTacOvky3fr23yLb7+cxr65V39OKZkxMW8ykB4VRRwD8K4?=
 =?us-ascii?Q?u67B7qJR4obmuPJllSDUcqRmrlnYg+IcFgAbvo2+3S2qelae7yS3KliAZ9fz?=
 =?us-ascii?Q?1QybbHoG2ngsFLyJMNQ8O/LsGrYPmAxTPKh2CZUPV5fNeTQcBgjrsA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?maLMSe/Uk5vDscW4MYSKnkOEQou1FQ+98ralktO8rqQROWcw39Gs3jEU6eD/?=
 =?us-ascii?Q?oNVqhVk4lxP+3nSYok/Qui6tv13ozBSqcl4VtCbibHLXDD0FjOIN7LBrzjOx?=
 =?us-ascii?Q?sEPt4GTsNLvYD1PwKspPmx6ro8uYP/PHl0qLlkbzsiIystA/PKujqWpc9g0E?=
 =?us-ascii?Q?OsKaiWoYlnsxvYXyo3a0BhpLR62GsLEZhY5x96mYLaG5TYWw1rXCkic4g/X1?=
 =?us-ascii?Q?PU/F2vMEeRwvPwXsGh0+3mVAo6xRwsk2ZXO3xVlCQAJ7H857usu9OF+moDbH?=
 =?us-ascii?Q?w6HfdnlObnmMaF3klU+iQFlW/N7Qm/tgiDDKUHBRI0bRAtStOKhJ7r4FkWBu?=
 =?us-ascii?Q?emQ+2DJdDCDwzyjW1q3+iyQ1skfIR/2tW7hVUxbL5g3dNbO3QxA05VX4ozIt?=
 =?us-ascii?Q?Rh60Evafk3X4J8bmvhgsjQhrI8OdiPdPle1E9RgUXhlQMB0kRsWmRCzKsOqO?=
 =?us-ascii?Q?kCO8RBydMeTZvAf3qnA5hujrc9AlEtdAxxvYGE1UVw61AWRftMlY+Y/g6buA?=
 =?us-ascii?Q?bMB9Lc1wP/hXd2JqwqihzW1yqar/x3Lxp/ZpYrhRbJZ4zIR3HCKILoqkzoIY?=
 =?us-ascii?Q?TctB3KBShNyo4+XwGuItceoNX0kPt56cWXmnmYxVzqnhD0USAaRtcYt23X1J?=
 =?us-ascii?Q?mDfyKxmKgSrwMNKNyPgItQox0kOBszlBk0OTnG0MDZ+KhRnMHmP18HvpTggL?=
 =?us-ascii?Q?r17knUYY3hfb4s39NV+ISQqbFeMQ/IT8KTyvn4Sy7J0E3p2Yn70ysDPxGi8F?=
 =?us-ascii?Q?qoEr67vPVnMl/3kJM0btyCo2YgKcejRpX/b9MuPSPcQOffPZcL9yx6Lg/8Wh?=
 =?us-ascii?Q?cf9f3adZ4TyYfDQzl3XNr/NLisWkxgiRya09F+bfq3vheMu6ubd7LBrIEEQZ?=
 =?us-ascii?Q?u71hpJZnffJlOc5XIyN+vKFofstwcmOJnDSEvFDttEyPs0GKjZr6ui2lmsIV?=
 =?us-ascii?Q?yJeq6YmgI0q04vkT8K7fNz7RwlJdTWlmRVPanR1DlYmk8W3PFYntUdfFmXQ5?=
 =?us-ascii?Q?W6wOuNsuO71ttCjpB7cjc8XvknFzmpKvLiPB47CVE6TkKpF/ElKahBqXHZ2I?=
 =?us-ascii?Q?zrR9PW+3D8Ih2vfDy28Q4E2EAhekEJYL42MDGA/PAdV0wdVR/QJy8pWejz7p?=
 =?us-ascii?Q?7l9tB8oOHJRVZrgXmGV7ilUxIDl8uKmwVueq4ExmpPOEWqIXaTBDdYc9yUv7?=
 =?us-ascii?Q?MLpjl7TI/PE4mk7j2PQXqkJ5ZDvjgUhFCOYKx0D7XqFRYG5CFdMrLcyhFj0?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160dc03-f82f-4b57-f87d-08de320a4959
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 01:21:29.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR01MB5860

On Thursday, November 13, 2025 11:54 PM, Wei Wang wrote:
> Before requesting the IOMMU driver to map an IOVA to a physical address,
> set the IOMMU_MMIO flag in dma->prot when the physical address
> corresponds to MMIO. This allows the IOMMU driver to handle MMIO
> mappings specially.
> For example, on AMD CPUs with SME enabled, the IOMMU driver avoids
> setting the C-bit if iommu_map() is called with IOMMU_MMIO set in prot.
> This prevents issues with PCIe P2P communication when IOVA is used.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)


Gently ping.. any comments on the patch or questions about the fix?=20
(Reminder: some questions and discussions could be found at the v2 link:
https://lkml.org/lkml/2025/11/3/878 )

>=20
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index 5167bec14e36..cde7cfcfd61e
> 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -583,7 +583,7 @@ static int follow_fault_pfn(struct vm_area_struct
> *vma, struct mm_struct *mm,
>   * returned initial pfn are provided; subsequent pfns are contiguous.
>   */
>  static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> -			   unsigned long npages, int prot, unsigned long *pfn,
> +			   unsigned long npages, int *prot, unsigned long *pfn,
>  			   struct vfio_batch *batch)
>  {
>  	unsigned long pin_pages =3D min_t(unsigned long, npages, batch-
> >capacity); @@ -591,7 +591,7 @@ static long vaddr_get_pfns(struct
> mm_struct *mm, unsigned long vaddr,
>  	unsigned int flags =3D 0;
>  	long ret;
>=20
> -	if (prot & IOMMU_WRITE)
> +	if (*prot & IOMMU_WRITE)
>  		flags |=3D FOLL_WRITE;
>=20
>  	mmap_read_lock(mm);
> @@ -601,6 +601,7 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> unsigned long vaddr,
>  		*pfn =3D page_to_pfn(batch->pages[0]);
>  		batch->size =3D ret;
>  		batch->offset =3D 0;
> +		*prot &=3D ~IOMMU_MMIO;
>  		goto done;
>  	} else if (!ret) {
>  		ret =3D -EFAULT;
> @@ -615,7 +616,7 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> unsigned long vaddr,
>  		unsigned long addr_mask;
>=20
>  		ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> -				       prot & IOMMU_WRITE);
> +				       *prot & IOMMU_WRITE);
>  		if (ret =3D=3D -EAGAIN)
>  			goto retry;
>=20
> @@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> unsigned long vaddr,
>  				ret =3D -EFAULT;
>  			}
>  		}
> +		if (vma->vm_flags & VM_IO)
> +			*prot |=3D IOMMU_MMIO;
>  	}
>  done:
>  	mmap_read_unlock(mm);
> @@ -709,7 +712,7 @@ static long vfio_pin_pages_remote(struct vfio_dma
> *dma, unsigned long vaddr,
>  			cond_resched();
>=20
>  			/* Empty batch, so refill it. */
> -			ret =3D vaddr_get_pfns(mm, vaddr, npage, dma->prot,
> +			ret =3D vaddr_get_pfns(mm, vaddr, npage, &dma->prot,
>  					     &pfn, batch);
>  			if (ret < 0)
>  				goto unpin_out;
> @@ -850,7 +853,7 @@ static int vfio_pin_page_external(struct vfio_dma
> *dma, unsigned long vaddr,
>=20
>  	vfio_batch_init_single(&batch);
>=20
> -	ret =3D vaddr_get_pfns(mm, vaddr, 1, dma->prot, pfn_base, &batch);
> +	ret =3D vaddr_get_pfns(mm, vaddr, 1, &dma->prot, pfn_base, &batch);
>  	if (ret !=3D 1)
>  		goto out;
>=20
> --
> 2.51.1

