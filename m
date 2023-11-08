Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC82CA8
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5Mqmk2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeYGzeXKhsLlbU7pKgsYp3GGZBSD7J9RFOoHuGhKFM8+z/Mp7+KK//9We22ofCYMHb7RmG6qaY45BTWVTEM2riHTvEwkwUwQul/KhU4Hj/lI57sVysuULBZ7q1kheJqDW/X2itZoathUkq9MxeR3SSk+7+5AaaBcfu6bgj44hlScEfPX0W5zL7aLz1Ie2qCpzyWX3wXyWScpfuDcbG6PkOPMqgWapK8Qllya2RbAbPuRUWoR8atFuHmppIhslHnMu1gUcDQIzjY5FNemhijlmPXpgmeukcDlp6GTVNSLe4CpY72R/59cN5inNvTSR0xsgd82hJm6G5+F1f9qEGWrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtZSxiCv67g/cuCe4EXoPm6hjsOx7vfxYOo1U3Fd0m0=;
 b=mSj8gGDDBqyyCyHuM8P4qGr13/sJieJN+VrgQkryGRDNN5MiBCSQkjOzfOLvnRV4yLN9hON/N1BsnUqf2wKP1Qaj9xTgeLJUkPlssvrNFnFB0iZ/eITNeBmn1xA2+IRWUturbQsrVOsZ+vU7nRtVk7FmnsePk5LoUKBXDBLu7wd55UxjFh6q2fG7yTRGaUBtVYe+JY9rqJs8FfnVjYFduJWt34r8BLfGbKi8Ori85dXfPbsUN+yQRxEaOxyYdR7+JvdAboeWQebsoZnkh3AeK+Dxclawr5TndnHadjh7IkbvMWnYEKFwX8/LMA9gg3mbbV4KMcnEz6sS7kHzGqPmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtZSxiCv67g/cuCe4EXoPm6hjsOx7vfxYOo1U3Fd0m0=;
 b=e5Mqmk2jsoIIRHI+PVA9XPW6jcoQ2AG4pD5e0h2WRbCyuJ1APByJkXUYl2ksdlvC5TRe5Du4BpZgtmCVxQtxGIWE35Mt1LWU/cSQXlRbrYrWMZiL0wvpDlQOwTa3+Bs4uWmqOM3j8h6Xr3uT+sIwWUakV7OigdEdIOoobyoHRAUHBkqzelI7jWdaWvLYYbDYfkfcGxNtEwIC5/YOzYzLMCQtq35iF+JqOIJ456rYBl4eoBNzsJ6agrCxd8K/NoxNTu5GcML+aMXmHXS649blaHbdLg2ReCaEa054F+6oEoqaShcVWyaThDSV4La0TizsSSWmkeyTUd0gwuZRVb4rbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 13:12:58 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::2372:900d:2910:3ed5]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::2372:900d:2910:3ed5%3]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 13:12:57 +0000
Date: Wed, 8 Nov 2023 14:12:52 +0100
From: Thierry Reding <treding@nvidia.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Fix printk arg in of_iommu_get_resv_regions()
Message-ID: <ZUuJVD2PpB73Is3Z@orome.fritz.box>
References: <20231108062226.928985-1-danielmentz@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Me1ido+npTawR0gZ"
Content-Disposition: inline
In-Reply-To: <20231108062226.928985-1-danielmentz@google.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: BE1P281CA0467.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::18) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: d91dee2d-26b3-45be-c306-08dbe05c6d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hxEcFTAb0j6/S7wb1hKy1fwMBBEISB+8pr92/+77jQQCo8noVyPhD6FdPligdutroiAnUXMHpVb3SmKX0j58pc1IISqdj+RF3DG8EMyqtURzl0DrbnqoYP0C4//FzwxOY8wM9MeOv8VDE5fFNXRyuenZwaB//m7gJk5GQBh/tJu8/r5+IiYu6jp8jwC/NeYTETlDjtD03dCBoszC8HffEt8sLXtzZhaYwibOOcSExWz8qh2HKJlaiRXYNbrWLfZ1ztAcRJCkawCCOh/y5LW1Oq2o5zf+PxmWx6bgAT7nq45eCfpkWh0X2jCndptzMIruGFwYNBs2S7Ql4xGpG4xAh5fIwo5I8drD+Ntdo8YXxW7XkKjpGdaogJHiyBXA5c5Lub8fFbJhWUVhPvWFGkY0AFHNVS28uWwmMlJKsg+jFVXpI6w/z/oCMNuPwG4MStNEPJZfISjryhq0XhTYvuVD5SFrPNOcB58yOJBf+BmSfBM+5HNEDBs/dA2FlW7fkv0UZTMm1Ghfn9+d+2NOLS++Mi/cPnNmic132whe3slHEq3okMD3XnS61JgFO6TMm9JXOFooYIrpClF4N8KZaHR1ytqZFPNF6oCBcIboTkJRAtc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(478600001)(66476007)(54906003)(66946007)(66556008)(6506007)(21480400003)(6512007)(2906002)(9686003)(6916009)(44144004)(41300700001)(8936002)(8676002)(4326008)(316002)(5660300002)(6666004)(86362001)(83380400001)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tcwgo58cNNpyDzXCYRis83nie2bZ55LtNOrsbYAhyj5jzbDcFJ2YF5P/R69P?=
 =?us-ascii?Q?csAFMRZwLl0VyW5pnHssEi40z1RMKuCn4UjPrsvYFPHanZFh4TzloLLYVfUt?=
 =?us-ascii?Q?0cB65s8nTrwfCg1CsJKEdwoyiTlSzy2s7+pOWBDM2QnfGa0CW1rBUKAYmOpP?=
 =?us-ascii?Q?1i3dAvpi1oyE2s6M5JJ0lfKp0FGmyIxeEJq+/k8CEgRuWuHHx+FMTFoR9M3H?=
 =?us-ascii?Q?oiIMoVP5D16NrU/mV4jP702ebmvo1zftE+kWut9inyEuKNrLnJjvLAu7wgav?=
 =?us-ascii?Q?YTDxTI8Ub5WWnY5MNBbXIYUtKUe3GuV1+X4+DJ6drau/uhKuhSLtpfhtttwz?=
 =?us-ascii?Q?9514jIXU1pJlTzoOcsOWDlLQUqkybRXT289fyCEexdodvQUNWcZe1neaHzi7?=
 =?us-ascii?Q?3qJ0nlB2rzUQVAki5lxzwFekc4+zesBFSPsloWWcRa9eX6QdxtmC+Cw3xaLt?=
 =?us-ascii?Q?Z8pPpqhlEAAQXvbq3y0L3Hi0X2eBGmGUXSpzVpdofQC65K+aOZw5UZPPsrbw?=
 =?us-ascii?Q?kwdzEyYhWsFLPbwRuBfSLO7JJzE3/RQ1jfCNCKRxW0loe6dOaQ80xB1OOfVS?=
 =?us-ascii?Q?0djcA2GRxSS/XKf6C8NGo7CrgmvUIahVty8XwgdIy1wujLDrJPBBdU7m/l9r?=
 =?us-ascii?Q?3B0IB1NzzPEUhoPctJPlHG9M4xwwspcHM/8rOvZbCMrST///v9BpPepF31/t?=
 =?us-ascii?Q?ycKl4vASOax+/FQhI713uhgqfNrw/n1EheHGZfIkjTDGsjhDo+AyV3fw+uAu?=
 =?us-ascii?Q?qM57sH0sQHICEXAIqWTVTb7EZI02fI2Z+fH8Y0C66lpQR90emP8G9+lcIKLt?=
 =?us-ascii?Q?33PNJD71lngguLfGglbZbnqeCV7M/x4dyyjHYBtyY6rQO6F/tXNBgj8+X2u9?=
 =?us-ascii?Q?cW6GkXeImHlioaoK3BdhSH7y7x0ZRpJo+o1eiGOcM3D3jfn2ueA+0+hXSiGT?=
 =?us-ascii?Q?ZC8UN7IO4AVPWcnkJSmu/1TX7VObGPMyZqy8ZUeqikcBYbSAwcLOdfBlVixS?=
 =?us-ascii?Q?rxZ/34/wctN63HyIBuIiuWvlcgnUbvunG9MMcDhvzdCjwNo9Smyr5G+wNU9W?=
 =?us-ascii?Q?3ExATiOjo2YZest4TNJfoP4vepF6zMSwJKxepptmJqJqNV3HqOycAvs3AMro?=
 =?us-ascii?Q?XIOcp0sKBu+eliLA5r/5e8l8QX/Jsb3annhMtrdmvlYB97QayJFea0Dl6ot3?=
 =?us-ascii?Q?vbsskuQQVR0W5dFJqrurytVGpJGJExxfBK26EFCjAEub/RtCO/cTNRbUDX+4?=
 =?us-ascii?Q?m1/dKnrOYy7U59CagjWIgSX463KzlTyxwcMzUQ9OHe9Q6sdpai824KmIMQtL?=
 =?us-ascii?Q?f6TXF5uUEkL0fAo4EJBAc2eQBn/Tj71PCSbhjOMFXkYkIRgqR1WH7B/yNwuB?=
 =?us-ascii?Q?LExvF8N3dQ3gchz/kNES+yqX0ji4sIbEBE5A2gu0HTHj2384vpsmEGYi0APw?=
 =?us-ascii?Q?TPctDUeI0Sfczt1HGio8T7YCj9jIWSV5lVFPJ6NWzCotA7iRmvR/Cv1XHsaj?=
 =?us-ascii?Q?5Wr2WDN21F2yhOZ33FSxIzUvAqM987S1xB3PTJc96J9dLz6D1BKlVlqRwu+S?=
 =?us-ascii?Q?ExqfbZEg/24sZ1E9FL+cFbsxOm9lUHRYZ2laF83xmEJ7V3pXNhvj8iY95z93?=
 =?us-ascii?Q?+J/F1gzHVbrBdInvK734C3AEQGURCCHdXovChflr21fe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91dee2d-26b3-45be-c306-08dbe05c6d45
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 13:12:57.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuEvE+c2449Uk1NqGxf564pgspOSRvp2JHWsYQpKfSlO5AstSE1JP0gFofba5WSp5PSOxEdIba6oCD3Wif6HXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

--Me1ido+npTawR0gZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 10:22:26PM -0800, Daniel Mentz wrote:
> The variable phys is defined as (struct resource *) which aligns with
> the printk format specifier %pr. Taking the address of it results in a
> value of type (struct resource **) which is incompatible with the format
> specifier %pr. Therefore, remove the address of operator (&).
>=20
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/of_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ugh... I don't know why I missed that, because I thought I had tested
that path. In any case, this fix is correct, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--Me1ido+npTawR0gZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVLiVQACgkQ3SOs138+
s6Fv8RAAuNJI8Z1/X0MmJLFnLvd83l5Q3TaR4ZGVR3v6mtjlr3hg842GlFCehNuD
hqOCf2vElHLFuRZEZYhiOYaqG1wB880KIUfdElqMVfNKW66aev5aMyPuty3coFl+
niIa2QtR8P+7OdDmYPrtEfHMJdcW48Z3iYFBh3ziwDDcmv7JQw4cXPXz7PT9lmvi
xMDOp1obWkeGXazu1o2KpYR5juq/pOrd4P3Y6mLaXuKjhM5py5ViX94IF3Ddwti7
nmrWFKXfAQochCFn7lvRK6fU1qHzaMXvK/DduWmFp4pPxP6oSXCZO1eZB9Lmde5r
xVxzRNKgstzTPzAI1qSsAk6qW1Hg8Ff1Ybck7ViQICL4YGJiq5g5CQ+bsZxEc94B
ya04b0Mmdsq89l8wCiGpjWmWsUt5vWQ40AeA6BaofRuGwcAYAzK2QyrJS8iXwoMz
34UeEW+OmLFbhtseeAV1FfIR0DL6luCGiJacdyiGFoxD8f3sedHpZkSS/MlKu6Ok
3+ofENLN5uKZE0qP3W4ifoDc0EPdszcYQFKyYaZWPBmBJGjZ/OjF/Pn3NBdK7un4
emVOCusam3TXpLrhN3wGL9EXVCNcgRQf2BE/8f0IEAqiA4lOjNaITje3+CLrpFJG
IG8iIy82tu5+IK0fID+UNo8IPCnZ75NiF6pVermwmiXe3u01/Uw=
=6MdX
-----END PGP SIGNATURE-----

--Me1ido+npTawR0gZ--
