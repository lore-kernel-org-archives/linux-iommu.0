Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05645C06
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQlAXRZN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfmzSyihbrewbMYaiA3j7rheLS/CrE1GGJVVKF/2FrYT+xXtRLxZfK1fo8wPE/O2RaPevS3sBxr3yOvujJexwfeAXqhy62sQ0+IBsYX0OMT0t8VXP/DcKQ6917nMOG77KUoxDRduGrezq9RZgntnolLjdtaQXFTbGmlaC6JDEKNNXpBLPgvfK4Sv8Fjbxu5YL+KCyLj4Ktj2K+Dmu9XAF9ud2cZHWVnOvxgamNGdm0vZjNta05Fx7154h6ZKEG6Vlht6ZGRGh8SUeq1326ln2Ko78qYBL5D35M6hp8ClVN6iw/qTKSri5eSXNqz2FeSv142V4jSsk8s2gZDHxpEHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hsLnFDztnwoyuAl7RbaT6Anz5v1JHDVzciOOQh770A=;
 b=V5rB9a/7MeJDUypJdKYeCXt4pUN7B4LNjE8jlqezQkmi4S3YsB7auYXt018UetRIK9VUvweGTa3b8Lgi3o20xLxjyykXpO5KlJ9Q0KPV2gRTP8PH7Z8YV05YPOvXjWsXwV2R/g5B4UXET5yIKysdSi4LkEgj7n4pyyWkHx3+ihF7NcO6773Fs01vzgh/F/XRB3tG8+rnJG7sNPg4VdGnvZ4QX2f1CYuF55B5Ma3YNd6Ud+XkLo8HPPvqJK2LAxqn/Rp9a7205LYQe+rfD0ilUxNNO5+daBh28HC56coJc+56jYloTjz3HnFvidyidUG8Limnd31/qq9ZRQCV6MTK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hsLnFDztnwoyuAl7RbaT6Anz5v1JHDVzciOOQh770A=;
 b=DQlAXRZNeaA/K8fHcguwTCpT7JpnsxhDTfPzSxdQOGguvn/SSHu03Yq7MYjx3WiqCGclcnh6ZRvW5Ymyz3Jmsa5qllI7Kao/uXMXu5n8MM3z95JB+/yQrv7K299PY+C1qZEJyYRJd2YoyPfqmydHvNmPb0aVokMlQhUIj6H7oTLhX5bf5ZDscHEKBBYW6J8GC2Pgpeg6rMs+LTz63zSJh29LjD3p6xKjcGGOBg6Wfo5DapzucMVAVvt+GRG4gXac57S7ywqvG/ugaGg8iXzXoZsCpXp64tgBDeq5AF08Cn2+qRFpy2Gqfo35cEsWcTEj/uSw+JX3LRAYFOz80imKAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Wed, 27 Dec
 2023 15:46:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 15:46:49 +0000
Date: Wed, 27 Dec 2023 11:46:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231227154648.GB50406@nvidia.com>
References: <20231012121616.GF3952@nvidia.com>
 <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ed3447-03e8-47a6-02ce-08dc06f309b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o51kNmdmc4mPZNvJDywPVRodCIbcnjF0wWsdWVBljglmhPgNrx3BbngSJi+iltTOJVAX/KqUMrQclv1yK1asO8zTVEVXrxlttEqJ8wX/Qor7OHtcJ6Lb/cb8QXW/GUQoHZaboEKMEJ0iffqyVVngZV1zPZnKTrPYAlIFYceXObevL7aRSbkWUOevorMbLPNUv7Wy+tfB3R2LNiw4TOYNObiElzN/lCJ0hOGAApIXtKPpYfGAj4eTfiMmrq7qboaWKuIIA7QzGCziNNWWc1czHUqRLzeOo2UZ7DShjlrUrjkMZ0nDV8P9eUZxlKXlIyRdbmbvt9RegQCyKIK0ZpEWBLpV1KIoc5DYDKBElUQUn44/0tjGI1FpabGhtorog+kO4X1FlX8XcocrZ2GStkndKwd4srZivVBzQieCUyWIqrnT3VLfmeR8BURuAmsJlom4pOJsoWVmm0ViJvbhwvdApwdNsmtDppQHrdIZ3FeMal291E2t/DLjjXLrhr//lM8chB/ijmg8+p3gq9uQvCYBrXG/K8L5Us2/I2AxllErkEdLyYDh8Xa/4rjxqzljwA9b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(2616005)(26005)(1076003)(107886003)(38100700002)(316002)(54906003)(4326008)(8936002)(8676002)(5660300002)(2906002)(478600001)(6512007)(6506007)(6916009)(66476007)(66556008)(66946007)(6486002)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbYVSTIhcTspgCE0UyBTmNm0q3+3mmeuZ231Ok5riNaMdEtCfe5ia51kTUCQ?=
 =?us-ascii?Q?qYAKT25lQdn23A3DBvz1G5GLoFIP3qXj/rTO6SArfisfg5mxcpXpgnk9fkFh?=
 =?us-ascii?Q?NGzwdUt/UkOfMmSUJTUbzsKwBuzjccUBNfxsmZoEO/i1Idx2osvezT8BdwOI?=
 =?us-ascii?Q?56w2OofViSv6wKJE3hVc0HkCMOuwoa/oBUCzvnYkzizazn56orGsmmc7AXrf?=
 =?us-ascii?Q?2h2ArjZqpaslx5CDl38DAES9ZcSD4D03TVWSlxvyV78Sz8Sgb6qu17QLq0ya?=
 =?us-ascii?Q?SfpH9ftfUmeA9ltSPzTnjWLy3K0cYCC8Ate7ShYAZFdirhPzeAqbX32+O0a4?=
 =?us-ascii?Q?eYVfusAvTPgzPCWRdE3yL0pMt1mvbe1iMt+0taUryFmb1Jj5GenMu8guJ4MW?=
 =?us-ascii?Q?OvIt3I0Fdmf4RjxLPiLrGpkq/DHhjSE4tWW6RYIXjZ6+cG51//rUIIrcxWTh?=
 =?us-ascii?Q?Gt+oA+a0Ms2XlCimCi2jAue9jG5/unWfW2lGav0H1wl6l9qjTMPrqX1qs0le?=
 =?us-ascii?Q?pETJb/sDi2S7w1QLR/rUMqMaBC8B9jyTlrJG2umBCEAzql39qkJKnO+iAmUw?=
 =?us-ascii?Q?XMZIAoeky6zqu5tKRSZKqmBgfIS+vV1GExQYNmL429PG1OmgARu1n6/rXmlv?=
 =?us-ascii?Q?8GdA1wV19rF+ocCz1n9bGI2TJyBBurxEV9unexIEePvNwg9LRfILlsY/E6pZ?=
 =?us-ascii?Q?KbS52nZwVqM7vVYxav06BHU9M+NpXUGFLpsep/CpyzRPMm1dd7C0ebz13HEF?=
 =?us-ascii?Q?HefpLJTyFP8imFihCme4XAjwIE5nhrLrlt0aM8evFAiYV9lY2xhlwVCQSomx?=
 =?us-ascii?Q?V8eKNvo6tn607vGwlGA1lBwnb2nd9EbAIKGL2p/a/3SSdOtPhMZoAIZTXJPj?=
 =?us-ascii?Q?vaUqiDNvduh0AHjO2mWn+Qq2TMYlLv29y+UyX5ZJYsFi/lph5rdQEjV7C9+1?=
 =?us-ascii?Q?lqOwTmkDUn6DzGJ0aIgldpukgxej5Vs1YDezHjQs0Ctz8AOyUBDoTJNdPuOM?=
 =?us-ascii?Q?TXdlwze/s72MFW9jqmVC0uYxkLMRBbymQXDIGsh5S71Cebtuzsf31t4IqIan?=
 =?us-ascii?Q?KfLw5HNq5TnFa+1H1jQ3Jj5lQ1tYZwKUO2GGzE2q5xkNJqhbkF31yM/PK5VM?=
 =?us-ascii?Q?E+VukelKnijnevEvvZlsF8UlgE7k0Ofz1bdAIZYONs4Zo0gE9XFpfoTCAjU0?=
 =?us-ascii?Q?wZOFMfDZmyejmc8dOiX4ilTXFfBF2suYEWA7YsT8QkatyQ5qKsS7rmu/H59P?=
 =?us-ascii?Q?1zEB42q2cWkALBUr2qrWm5qiocrVg1z2oAacRB9ApXA56aDFhY7Ss7GVr4wL?=
 =?us-ascii?Q?akIHsaYRieksMtUv6DeoAyzDbsjXYP6ksk6Deh4EUvLIUwX8QEnCXN9FpQs4?=
 =?us-ascii?Q?tDUrTRh0wOgw3pnzugq12t74lOq1ObdISR4yfUArHckxcWp26OVOEfCO58cL?=
 =?us-ascii?Q?erSsqYYZRZqBCxURxyDg1a72Tn9MmB6lEH7nubM+/NAN3Ct0tV1xN0TAqwFg?=
 =?us-ascii?Q?WIpKe0YrJ20KpwHOCF1XHLKZgh5KOfmiBxYcBhs66mBI6ozjhJBNjWI3AQ+0?=
 =?us-ascii?Q?fm7NXMe1Kh/ruh2HawQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ed3447-03e8-47a6-02ce-08dc06f309b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:46:49.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdk9Q2XK4MT07V+vml9pZmIYJcbTu2X7rkt/IlGLFChVjqBzp/+AJBlL5/A/ou1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

On Tue, Dec 19, 2023 at 09:42:27PM +0800, Michael Shavit wrote:

> +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
> +                                __le64 *cur, const __le64 *target,
> +                                __le64 *staging_entry)
> +{
> +       bool cleanup_sync_required = false;
> +       u8 entry_qwords_used_diff = 0;
> +       int i = 0;
> +
> +       entry_qwords_used_diff =
> +               writer->ops.get_used_qword_diff_indexes(cur, target);
> +       if (WARN_ON_ONCE(entry_qwords_used_diff == 0))
> +               return;

A no change update is actually API legal, eg we can set the same
domain twice in a row. It should just do nothing.

If the goal is to improve readability I'd split this into smaller
functions and have the main function look like this:

       compute_used(..)
       if (hweight8(entry_qwords_used_diff) > 1) {
             set_v_0(..);
             set(qword_start=1,qword_end=N);
	     set(qword_start=0,qword_end=1); // V=1
       } else if (hweight8(entry_qwords_used_diff) == 1) {
             set_unused(..);
	     critical = ffs(..);
             set(qword_start=critical,qword_end=critical+1);
             set(qword_start=0,qword_end=N);
       } else { // hweight8 == 0
             set(qword_start=0,qword_end=N);
       }

Then the three different programming algorithms are entirely clear in
code. Make the generic set() function skip the sync if nothing
changed.

> +       if (hweight8(entry_qwords_used_diff) > 1) {
> +               /*
> +                * If transitioning to the target entry with a single qword
> +                * write isn't possible, then we must first transition to an
> +                * intermediate entry. The intermediate entry may either be an
> +                * entry that melds bits of the target entry into the current
> +                * entry without disrupting the hardware, or a breaking entry if
> +                * a hitless transition to the target is impossible.
> +                */
> +
> +               /*
> +                * Compute a staging entry that has all the bits currently
> +                * unused by HW set to their target values, such that comitting
> +                * it to the entry table woudn't disrupt the hardware.
> +                */
> +               memcpy(staging_entry, cur, writer->entry_length);
> +               writer->ops.set_unused_bits(staging_entry, target);
> +
> +               entry_qwords_used_diff =
> +                       writer->ops.get_used_qword_diff_indexes(staging_entry,
> +                                                               target);

Put the number qwords directly in the ops struct and don't make this
an op.  Above will need N=number of qwords as well.

Regrads,
Jason
