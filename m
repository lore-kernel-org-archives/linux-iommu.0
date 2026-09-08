Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6B1FECCD
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877527; cv=fail; b=XSNMIIjXADvslgHu77PMQ7I5Uyv9g+XI/F2/PfQrsrbOBlL5zNyubBmoqbmm4+xXHhzZiwtF0K6WS+IWRFxWWOd/CjWWbpPdAaERK0yUXHoamMdLGv30omcBz7cz2TclYC6zSbBe6kAi9TcvDAgGIyEyOI0BoDDeo9Kj+lRCY3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877527; c=relaxed/simple;
	bh=lXGzyY0zSf8mhLN3SuZgXnIYyq0piYlHnPjx4Q7B+eA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e5r3T3u9U6ijY0xV6emD1DmC9PEUE40YqVfzdEIWoMk/K9kjDawUwgF/zfxu6fM7iWdVQG1mPwM9mXUA+t5nukpGXENGjegBRa4Xn3J2I4zHofY4xOAq6PZPvlIqSXJ7tJmjP4loz/hUWpWyDkVCmrxg0EoElWgOUG+pgewu8iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c9iTDyPu; arc=fail smtp.client-ip=52.103.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c9iTDyPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ+ziJoER+39lQTUclGFCpPXfXNJaKstfmjsVfynJIjnI0jIOshTpapJaTbYzFWjs4WObvuRjIXnzCN5h3zY1rllN6Y4nWg9S0wF5njwG5QxVAieIuds0vif5ZQNKN+n25Y/CBdqR/pirMHb7aaGnGnYieEt3mNCi5CjMZs5IBWrXxSGuBEx0CBiHwwKXwAMIrV7L8hkq8xdeATmmAR095Nq4ZRTJP/N8q0RplR/c8SoiRrlgiXO7ZnjgXbRnQ4z0Zd0hdrRrvpNJbFvYyrds8HmZQnFy8KruCjudzWP/NLEydJKHJj3xPa1WzyCdJy6bjZ/isfW7/SkU36Q1/XhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqfBQ/1kIGf2OQJGA5YSgvBA25uBCnSoGvzoZcCAdGQ=;
 b=jn3WEFAPnETSBXvJX/3rSBKk98UkoFz+d/f0ySYTQnAYGcxnY+NP+/uEv9EePOoFhB/Klk2AACebHIncEqatP61mqmfNUHonP8vLdlsz4MjHZ6CG/WgDhJLLXhIipBbUgcSrmJEFooSStYNd6FPRZKOUUzUA1VzQzAnpo04kzdAwF4h4meHXEedSTttscpvQiRThA49igUe7e2kf+zkAZ/O9i45gwYZynU5TdOLeYs8Kx2ahJRtv7miEHVSYiZa1LaUlP7C1nj/KwFoBKzZrtLzmXp5yGhjoX8XUSPeTHQpeXux6iXiSCSJX1mSNIMx0aWJGGcftWa3Bfi0rwlytYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqfBQ/1kIGf2OQJGA5YSgvBA25uBCnSoGvzoZcCAdGQ=;
 b=c9iTDyPuhC/nms3RXfApcelR4xNBPxyD78Hd55jTNlrekV3KHN8L7BphuKsFWlkqt0+b/LcC7OkzNtIM4If1tPS0YU9aUvIirUyc08xFTTPJYM/AQGH2+svoi1WSUFAOkBTUjQG2Wv9fzDZwnWPatflOliJVS7u5Z5JImemCxR+ZMo4P8R90vIesCvJU81i3rhPRlIZOYZlSWu3jGFF+aynUl/VHv4BabPDG8Pjj2HzVAr/UMKnh3pZd+KxTBZRfn/ZalAWs1mGiqTvGzPI333SwDuu/0UkWPJ1/KRs0t87FkvDwuqDtr1mjXx0zs2/yrv/Kg0/50Y2ZW7mp6Th7gw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH9PR02MB12104.namprd02.prod.outlook.com (2603:10b6:610:355::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:24:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 14:24:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Mostafa Saleh <smostafa@google.com>,
	"Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
	"Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>, "Vasant.Hegde@amd.com"
	<Vasant.Hegde@amd.com>, Timo Witte <timo.witte@gmail.com>
Subject: RE: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
Thread-Topic: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
Thread-Index: AQIm1+hGQddDw3OG1Q7D/TKUOjO/e7YxizUg
Date: Tue, 8 Sep 2026 14:24:56 +0000
Message-ID:
 <SN6PR02MB41571F1762544B6157C475BFD4B12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
In-Reply-To: <20260908113232.247457-1-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH9PR02MB12104:EE_
x-ms-office365-filtering-correlation-id: a0858d92-1fe2-492f-8d44-08df0db4f4e6
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|4140399003|15080799012|25010399006|31061999003|8060799015|19110799012|41001999006|8062599012|2604032031799003|12121999013|37011999003|51005399006|24021099003|55001999006|40105399003|1602099012|10035399007|2607281247196008|102099032|440099028|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nfFzsjeohobBuAWIm4ZLi4ZJxL/adUUS8fPGWfGleuhhPm/eYM6RJXnDH3O8?=
 =?us-ascii?Q?PAjeYZNIWTvmkqWmCfQK8qveGiMDBF5zTLjr3ge6ZsKxSfCuB3aqxaIT8FJ8?=
 =?us-ascii?Q?UDMBmqOpWaeHWDBIsovIo00MiCR+R/rU1cbfrWWSccF6ewnxHuRKuh2+T1wH?=
 =?us-ascii?Q?yUTkVgfHA/8z1X9HOc+dGgwsvnUyskNrt9pDe/5HJoyRwhAggWPIr7gXOUjh?=
 =?us-ascii?Q?D/0TjzAuWttNu5lpKfdd/uefe5VVXn8LlIFQjVM7IXRE6H/F3+LekPVrzOZe?=
 =?us-ascii?Q?6JB6yBRH7YnjznFgrfZjiirsCIl7bkxOZonohH9G30TfpRbFSwPH5K9jHU3C?=
 =?us-ascii?Q?9L+KCYeyRSy3+viJaCP6b9maFjkUeuLlJ/l8NKzlKCoNxfO7GLTk/PyyjZ+4?=
 =?us-ascii?Q?hs2tnG6QZ8uNGlTI+LzLw3X65KaTGmfbrVAD7vI7im/oTl4S1xGe2vi1cqh9?=
 =?us-ascii?Q?NpSxJzuvN4cNtVVQj82IKLyuRnL53FIgz2LsLMT2S2uLa/R05TESDXW2lVqQ?=
 =?us-ascii?Q?OpJMiNvS9iQoqBMLqr3z4LQbiv4d4mScHS59Z8bN9fyEq/T+UDWknhT8vVg5?=
 =?us-ascii?Q?arW/PIl07BLubaWTb+CDbjV9P8aH/ZGojwyFAY9iSKEXY7/yDeNztig0rATH?=
 =?us-ascii?Q?ejvSo+Lf2S/8v9ZEJgXgCn1/FaYNXyDD1d9/oDPg2IxEDDv5v3NV7DMQMiC/?=
 =?us-ascii?Q?MkusPXqoeh/Q/1q6AMXQXon3pgvF5Toh5q9MP5sMN70lGL9PzLcnW4TVIxtJ?=
 =?us-ascii?Q?vKL/ymj/bDewW2kvnP9rAkDKci2Zuabir1h/ero5RD5fFaenjzgghYeT8Umd?=
 =?us-ascii?Q?vemDEADZ0IfuKkWpK1E3L2k4K/UEIM1Go4jJFmySvjnAW9LrkKNqpbQLn9jd?=
 =?us-ascii?Q?Rcw/Cr4xCt2pLLJI9H/CYEhl0DBqlfGhdRiINSkOnPpY2SupAsP6hOBfzyUP?=
 =?us-ascii?Q?/MdN3gD6vbJCaVogKZiC3qGgUiHyVjmW4u9JJly4pT/mSOwz1N6UM2Cw8b3Z?=
 =?us-ascii?Q?OQ/bp+WGeuhi2aVjaVO697nYZEvcEDLaY+vdTYblHzWYpQDkd/OQYI1tSBxS?=
 =?us-ascii?Q?8y2kFtTm2heQRvu2LG+0COjOBiM9H43eQPPser4YC93K0aAXLYMq+HvUwube?=
 =?us-ascii?Q?J4RlvOgtIFBxNJuZcou8Z7uHqO4pwNlP1hhToLeMLQQFbA2Og7MkBzUq05w2?=
 =?us-ascii?Q?xkiUaz8k3RDvjHlqD/8BWu9ddhyJ5w9rRtQ7Akvcs1YRNOUGAIxjpxmDzq4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bKDS5mVikrBI3r8WJy35WgB3wKhiu5GWjY+K988g9dAmNQ9bb0n40D8tsyYQ?=
 =?us-ascii?Q?8XmSPGfzaFdUTUMMHAz8xqhZRVYldjASGbwOLwnc3peGszXs8qaRzBDdqCmu?=
 =?us-ascii?Q?k+vUJu+RElA/nIf847OD6oQkQ92rU3dQR7zwtRY3K5e9ba2k20QgRbvuFe3K?=
 =?us-ascii?Q?a4vFbZzs7HjKTvph69LrLashbyn0n4tbxmzjmqQp0o5E6cDbGJ+cpCqZOkeS?=
 =?us-ascii?Q?HEsGrvlhNG/evs5NeIl2jKhTyqg+/ycARBKzE8T52Ie6pNRSHd8wVK9g93fr?=
 =?us-ascii?Q?cqB+FkkolFwwsk6cSEuXpQsmaNoDNCv3tOqF2cMe5ZlWgGNn26gQf+ZNnRGx?=
 =?us-ascii?Q?V/obAWQrfNwJFrERw90Yh8wbMkvhlEJIulPxre9r0f7GNxfAa7b+lssvenNw?=
 =?us-ascii?Q?IbazFkXhts0cwWlQZIqG6MHU5a8Q3scov5TeXUOaH299ZkpGxgQG1qSZ0rhF?=
 =?us-ascii?Q?5k+t0kzpvaZtTa4PXi+xmUjY8BwXFopVit2dEC1wBSkX5xSywPjleQh2tGgS?=
 =?us-ascii?Q?rAsuXtBfFKrlY0jsc7lolWED+/AmLuEZuymeSOjHEayl7hlJTnj05S4ckXSQ?=
 =?us-ascii?Q?k6hwZxLcRCGGnIOEQe1rncr9o8/fW0OF0GcqRrGM3oxN5sDcbB/h79yK8aAA?=
 =?us-ascii?Q?LPUDpUpOK+qeMamsVDZVV0vj4mXQYUaQKQt/tqUiJnjy4RyRppDnQD0x2bFy?=
 =?us-ascii?Q?hdu2LIL9mzSmnKFJ4amJtLjhWWDs2/w9twWAKVLg9IzUubpoNcqhKQB1PYXE?=
 =?us-ascii?Q?RGWWjz+grQsFKMzdQYmsRKkhpx7e1WUAgcG1I3FF3NB0E4QtnIDNVhiWj/Oz?=
 =?us-ascii?Q?ePWGx6SCWhFENlha+fIW/MxnQUSCtlrgJS7O/+N+uZV73OeFsh2SkPcnzPrE?=
 =?us-ascii?Q?Sv/68TbfM6rP2GUeTS2i1AXfkcVMcZECVSM0M7cFavshXZin3SaO8tmyIPKm?=
 =?us-ascii?Q?l+7TH9Q6zbkX10eMJxwItu2+7er0hZtq28xWV7U+P7NUSdWwWi7onMlRyNyk?=
 =?us-ascii?Q?9d0SFmGPe5Ma9kFYRo1qpnSk0syvw4+qUS9Ev4VkZx22+ik/jlHveK7xl0/c?=
 =?us-ascii?Q?a7UkBu7qUjQMGNfOtjVrmcvA4Cmw7/wncjOHsYvglHz3jk+BH1LQspgEgyd3?=
 =?us-ascii?Q?cW+Ih25Jwf19jfrwpekhvs7eaFIjqi0QZZ8i3zeN14oOV+f3aYer/0pIpZSS?=
 =?us-ascii?Q?1Fe32AoIbNVkYZunpb9456SOgJVA2C+tmfRQRd9GKceTQmgCBjis7gW1kJoO?=
 =?us-ascii?Q?Gt6POZaQgFZoPiUY8gnJJliGCHYJxKrLzw/MeXU10h8dNRz1/Rckwqo9NWDO?=
 =?us-ascii?Q?FsdjVQ2FCCnj1iLSRVDnH4QjFQqqM+7pEOG3APzgpVdrLwjfnUHF5caputik?=
 =?us-ascii?Q?RB8oPbo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0858d92-1fe2-492f-8d44-08df0db4f4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 14:24:56.3429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR02MB12104

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Tuesday, Septe=
mber 8, 2026 4:33 AM

>=20
> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") exposed an issue with force_dma_unencrypted() on
> systems using host memory encryption.
>=20
> force_dma_unencrypted() checks whether the device DMA mask can address
> the encryption bit and, if not, requires DMA allocations to use
> unencrypted memory. However, this check is not applicable when the
> device is using the IOMMU. In that case, the device DMA mask constrains
> the IOVA seen by the device, not the backing physical address, so it
> does not need to cover the C-bit.
>=20
> This currently causes dma_alloc_attrs() to set
> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
> support that attribute and rejects the allocation, causing DMA
> allocations to fail.
>=20
> Do not force DMA allocations to be unencrypted when the device is using
> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
> before and avoids incorrectly requesting CC_SHARED allocations.
>=20
> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select t=
hem via attrs")
> Reported-by: Timo Witte <timo.witte@gmail.com>
> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=3DMXVZeSdvw9UiriSagp=3D=
E+ju5RRDNghoPHLQ@mail.gmail.com

There seems to be something wrong with this link. Just viewing the
email thread in lore.kernel.org shows a [not found] error in the thread.

Michael

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/mm/mem_encrypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
