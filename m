Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198C21102
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jD1PwQJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMrVk8VCw9BGJfsm9xaLSmWZYsrBxaffuE3Gnh0bDQrQsPoJPsgrRuaEqVslN6nvgkKFZs5nMPU9V5/F5rgDkoxNx7ZW1OuhZWsBgt6fUjFhamS7b+i/MIxn8QamkhTUNLa7Gu/ZO7pwrrwF2w0n2rrTqrZFPxXhSk8FFx69rakDx5eNkVP64NCYKLIjsFKXDGORksJ4y2AVpruBDHrnb2iq2NCHxVLtvaPV+ZBsIYaAcX3l4XNWcYAzVWA0tLaoOhEOVBV/V1J4/nzWr+7gcPavj7XcKzw2QXMO8PbXBK4f3kKmfXlqXefEBbqFDRlpIjfsaNjC1wyAsYkb3Vn5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZNysGebUsEtYMISIdnFvA3I7TnFofi0YwxU49KB+cA=;
 b=TyhqQW0mjmst7pC1iaSMMRK7lX7M0u+hRJryzfpxCaG1PVNqPHGIdBTx3Wey81TylNGaAEwAfETfp5Qc7JNiA0xIUpMFVfkRoRHlo0JaYyRHt2lg3djrroFl9zBGnXL9e3G2tG3QXPiH205q4S0yDH+2tR1V+fNIfBW8uNrcDd3ty420CY0dlMLjN4gSm8JVbk8Wrp742H0gF7eZ6L5bbXuf63uzhDF3NYKY3C+Mb3YLQumLCU1Y/vRYlM8wqbJetIwNAg8/aOKsxIKPLyrZtbwoMi9cbxxJu/p5wvTHT1mLtPiJguJYk+Hg5iCtJNJwKFb0Tjkbg6KUrZglf0472A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZNysGebUsEtYMISIdnFvA3I7TnFofi0YwxU49KB+cA=;
 b=jD1PwQJAn42UUlv3hB/NfADYL1hK197dr75cXtdMEouqWK+SsQA20acnQ/1ZmdsiyuGpA3mU0sNqwNKNOjc1S/6B1GP+K3qds/gNxNEo6/dnennZnR10Zuba+4gmnzgS7T4mDJJ1LHqFZpYURwEZkKf8RvBI86mxgUZilPlQ2RQu0NMVnxtuJBS/GWGnn/rQasdi5I+xRluXgCRPXWV7qLKOpSCmMiwMa0eYwepIUoVXZ6OqlAdzmNe7mfEq0e9z5BujCPu0Sw4EMmZr1uhiJ4XHtHzZMhR3Jx28Rt/uud3hRttQiqDMcLJ0R98/5Fe5/8aG/BlOMpHgS9EHQKADzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 18:25:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:25:11 +0000
Date: Fri, 3 Nov 2023 15:25:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: Re: [PATCH v1 05/13] iommu/amd: Refactor IOMMU tlb invalidation code
Message-ID: <20231103182504.GE223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-6-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-6-vasant.hegde@amd.com>
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4f09b1-e54b-4361-ae29-08dbdc9a370b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TCWnSCphYDDpwYVnqY2Y4dNhIelI6oCwxv66xQ+bZuI8SnDfm9h2KuUk7vKNip0102cP9uu/cHGO5aNEpA5dVZGOXp+2t4ztQPexjv1/fst6mlGX6ASHibsZ8vYIGfZr074FHvkboksysfI8UDBlRgrYZVJES1qezvERiEHvdvM506FA/o1XQP5y3UdWa9r8baEfkKOQV8fFZQ6Dlp7I37KERhvZtkV11pgMqZmRq2ovqNiveROii4rBQBcjauejKm7eb51yPFm+VSKZAIG3wI2UBgntiyg+001g2fDg7LKupNqtHRfrgpD9Lpg1901wro7JGiFXSVDXJJMCXNiK53a9TVvsn1/BCJdNo7GLxEWgqP1wa7GLwqpX9G0b1PKurkmmrHPRO/Is7RUn1ZRuTvskTMbhAuJpkFVQq0kpMiP6/h0UzTJsDS5Sx9Nnin9zoCq83himmdgZvO9e03N/8XM4SN1RqI8sba9UMfR1msF2B/o3dA9vPI+i0PpSujeCGyfOntflqHMsJVpc/B9oZIbjj2hKTmfPpAu05+cJ9/12f8mbWYTOXrbN0hDd4dEh5uPyVwvoEuJPAJLqtgit5ES82913tfNCWpN9ElZ+L7Zbx1opE9pet2zFeWSPgg0v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(5660300002)(41300700001)(2906002)(4744005)(86362001)(33656002)(36756003)(316002)(6916009)(26005)(66476007)(66556008)(66946007)(2616005)(1076003)(6666004)(6486002)(6512007)(6506007)(478600001)(83380400001)(8936002)(8676002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgeJF8FpEkHQLW2CeTIPra1ZmmSgQ0cE/egzWNm0mWqrME1VK7JPM3jG20Oa?=
 =?us-ascii?Q?ugo6LvHuwTTnRPzSnZA/a8NrMm1iPaSbgQBIKlJFJlQ3f9HKzx5eQ97X/j+g?=
 =?us-ascii?Q?XHBaLItFuoK7KapouYq+VyvngLtloDoHpl3y8JV9SrNSF0IZqNeEuQ6eZzHc?=
 =?us-ascii?Q?1uy5C/ZW88Zc3lga1DjApaCRJkHnMRF2+Ni3y0ux5v0fY3mNlBv/plYUGQvD?=
 =?us-ascii?Q?WkGXZuME6dodwq+kPaha8cb282e89oDrbpkiyYM0TaPu4qO5WBB8CwaIY06q?=
 =?us-ascii?Q?PRxyJgKiC7X/2T3ddSByvNXOZRwWl84JEx0dZ6/+jdWpV5KwO/8vqRcfPcr9?=
 =?us-ascii?Q?6owFiU+w8u25jSVZsVoSR7Swiwy0MqtXpDN7ihHilKzvXuRUDKlhPjfdYjq3?=
 =?us-ascii?Q?TIsSD4p3MBUFg3EhMnE/iwrDw2bm/o9V/QRLcSMU2fhSdTziVGiylzFeVUMn?=
 =?us-ascii?Q?4SUPa9hBdnP6FVZimVSWFilIgn3oOGZVlSyYKX31yTXQRd9ogCvb4/CK+Tff?=
 =?us-ascii?Q?QuItie8uYlNMWjOC3BP4RhFk+yDTUQ9V+bdgBKFKM18pGOoflxUbX4eaogkK?=
 =?us-ascii?Q?J4X8Lq5FPb6dV9fnyGKaw9jZm3HZ6yuFc5PnzKSXMRI5K6+4avbt6nfKa230?=
 =?us-ascii?Q?dycmgzstYo4LI9pEwa4n9EO6F85wshqNqSs+54rLPFVpntkcvocOeMY7/zso?=
 =?us-ascii?Q?XaMjpQ1Si7lJXGE2Z0fEybugSUkyQsyDMa/LvlVvGwTIXsW/pOSS14VMWwjc?=
 =?us-ascii?Q?ErL/2oq7XBgwAgMk+CL1m3g4yWxiTIgcL2N06m0cSW7ouDw7ZWKr6YKX9owd?=
 =?us-ascii?Q?L3JaRP3FmGeaJVvOhgbWSUlYalEwFGrF56p1ZRoGee62A7/v85PVYhk0xwWF?=
 =?us-ascii?Q?1zzWn1+w8o12QdtXscuSjbLavuCZblWTpKEsnhhVCZ5f7I/AhLxAzQA9yWIn?=
 =?us-ascii?Q?/DaZg+hrEZuCy+nQ4q3AQ3MJyX0/vX3hT5bAzQ04dvJkRYuzm8PkmopoGVzs?=
 =?us-ascii?Q?asQCkDRgueY4q+FLxx28QxkGfg26tsgI1d3WJsWrcCe3/rbewPOZ/TiXG0px?=
 =?us-ascii?Q?mVJkbx/XmLin/ueFYAW939yjZGDKcvpjw/hP6Ud7Fs4o/Adgqsrm0KfeWz93?=
 =?us-ascii?Q?NEBmHCoztan1JYEt4xnGRXlU3WTI+TaE93yr/sMwp8vuRAduQoTrroyH2PVQ?=
 =?us-ascii?Q?2+noKucaZ8mjMvDs/Fjnnooit5oHVF9qwcNy1F345hJD5NswKcxcGrISydJa?=
 =?us-ascii?Q?KE/sw4craOKIP0+9M8nsEfJm7PmRoiTj9QPiFJAOMTEArRsrWJXliAT3FyFM?=
 =?us-ascii?Q?CzeshQRTD7lkvgltcfDkxSPe7EbrPbPY26GQkF1KphMTm3LJBI+1YamYuC0Z?=
 =?us-ascii?Q?ohiim24A/Zwzajji18PoFqcOOqC3tVNsKlK21/GNuI10OMeZ9FgMKMmp2sGl?=
 =?us-ascii?Q?7xwVk+RhEZX1C//Eljb6+rBn6+LWMF3jgMfHhbMiLqRYUXRRMgKwJRqV7yS4?=
 =?us-ascii?Q?ugEBjJyhGxcSXvdmQgpQ0EWxTHEP/N2HLmrRtLvVyxKzjqnxXBqBowU/c6ZM?=
 =?us-ascii?Q?BSRJXd5SFA7luMA+SYA+PH7Mt1dm56V8gJbS9Uez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4f09b1-e54b-4361-ae29-08dbdc9a370b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:25:11.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDIaYh6+781J/MEwn4d0Tgh2uppNry8quWuzL+X8I9zQAnQw4288g38Xz90DUx+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

On Fri, Oct 06, 2023 at 10:16:16AM +0000, Vasant Hegde wrote:
> build_inv_iommu_pages() and build_inv_iommu_pasid() pretty much
> duplicates the code. Hence enhance build_inv_iommu_pages() to
> invalidate guest pages as well. And remove build_inv_iommu_pasid().
> 
> Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
