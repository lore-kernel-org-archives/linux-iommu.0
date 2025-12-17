Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B31E1C11
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931039; cv=fail; b=Ip9Gq6ZqMGqMPV3T0nLFRdt6Ss1U8PQMTfN4BzfAozIxSD3A2DURN3+UDhRIAjD9SY6tkw5Sox/1m824xfLUp5feOtjU+mFIE2ZYtva+k9fgjpz9l8lK2zbPmE1Ki0jixVhqW7KcLQlkHdJUjPc9uR14M8eBXWd+Iea/uEWUKZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931039; c=relaxed/simple;
	bh=YcncJHDR7gl+HdiNewpM2ezz/4IkM2a+sFKbrv5NJHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gQl/jhYKWI+2dHLnlaiXXGWFXYjsaEH4jRE2VnHInZLqh6vQGAJCmnbsQKd9hW61zr7BcnPXPsyu4EIYLnFH+/Dc0vBSGpCRT1tvHDH0LnvJfxkgFba0hRwqcclDgkZSV6tcU9+4RPa9Y5YBl2TqkLIXcQvx2dHLcinf8LbtN4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjmrOY8d; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjmrOY8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OX9Wi3B6a4Durh1dw7jYne644RmHJCWbmtxbu245G7Xobo3fwPQsFC4sWnndFGxtL/E2ujgDyvxdD+Xi3rUuFIetaD3mceM9NIjvlY4I4PEcotyvPu00Tz+MDxsbcyBOYq2cKDAAoubS7z2mTuNiAJXdPs8yYUf4E97f/3llBs25hjACn8w9Vy0FLjyEv2EFC9aSbLSX1Krv5RGdRos/u4haP6Ji1fF7L35S3IV9TH9103HM2ifI8NC1aHuGx3rTJ0r0swSLPRFPgnJZ3bhFE7GaKzMf1fQR7tHecAztl09Rg7W2vM0nhK7DEk2b9BQ1x2w9tLGEutNiryVPe8FxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca6HnnI0FDrwGK55/E6KgMx9b6IEJdHjps9IJKBf2pA=;
 b=aVCcG/jJbzU6MBloyySsdsGDABDdjr3zmg0tJRp8QR803GMUhMTikjSCba6+29S9H7R0sHVcfDkJvt/mUGwe0IQDHEoiz/TFc5kUR2eXt/3JSCk1uvhgfSaAbyhqMkwD7wh3FicMvZo3sJjF65gkMTigmnX9y2AdM0Pduzc8zEmwgmIj+DmGI2rRuuXRv9U0ioSndKMlcbnWdATFUq1Dwh0HqOXGsIHE2m212UgO/Ys+kmUT/uDhT5zROpwkqhOQwfJBYRlsh9a3cEdsmgh5u32KLihw6RMqmx2Mx3Cka2H6dAiHZYrXLNxGScN9g+4MC3diRWYpa8C+5m2/T4H8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca6HnnI0FDrwGK55/E6KgMx9b6IEJdHjps9IJKBf2pA=;
 b=VjmrOY8drVk9MM4py5HcG1ybqYTZm75lq61p14JhiyScar5o86gcvMUk3ZNbIzWj4yxaf4lPm5KeUlivo8AlrIiiTzEwfTA2onvDYYYI0IXsfBxhTplUc39oN8feJKVi7lFjoOtD0COA4OwTGKCAYeNU8bSqxAiBkiK2z9udpoAzxOJlAhv0NSFjj/FL0kP/gavEM6Ck4wsSZotpsCddL+n8apac6GRXtBDPBBZ76hM0s9WidwBM6nWD8++kE6+GKQCHUbLWpX956PFtIjIds/nM3xpeYBA/fE2DGwc6Y5Qn2rj4du8VV7PF74DMoewkVkuJBxrHb2fKZeo68slfBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 00:23:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 00:23:53 +0000
Date: Tue, 16 Dec 2025 20:23:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE
 update sequence
Message-ID: <20251217002352.GJ6079@nvidia.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
 <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
 <aT87A1ur4htPjM5T@google.com>
 <20251216000952.GA6079@nvidia.com>
 <aUHkGCEeu7L5uCMR@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUHkGCEeu7L5uCMR@google.com>
X-ClientProxiedBy: MN2PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 0decce72-57df-4534-0d9d-08de3d028efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3+ysm90h28SReE5YngPSltLT0TYjJNUoK+lncQqXqtraVUp4MM1eEqxnvY3?=
 =?us-ascii?Q?bNHeWKrXrvjULgzYEl0bwjFro2YOZEPjUIxLIJnKjCvUmQzEzjkMo/dT9gF8?=
 =?us-ascii?Q?FOiMDnG7U7VietNnWQvgj6t2/vr8pnaJNy1vHOG9blVuGlexJIMGmOu1w4sj?=
 =?us-ascii?Q?nbIfQLfL3KB/pZYKDp7vP23A1HOZO90mEEmYW8qFTgGhxR+8zflqnVII8rKJ?=
 =?us-ascii?Q?zugxzqdyez21ZcGC8tcZuEWvIzdR6v4biQIsX3jo8eFR4Sx+ArBimY604Jek?=
 =?us-ascii?Q?21i0QhiA9syjNJg8Wj89nTttoMt6rpYfsE2C03V2JCvz5v2W7B/ml9QewHnm?=
 =?us-ascii?Q?GZqjL05IIVka3x7L5PpK46dCdbU48nBYqcjS9fQCYCaUKBnDcWrnoztY3EEP?=
 =?us-ascii?Q?Kt+wJUhBqR5grP0fnrEGy7mFGhhbD1qjf7aBzMWvYOJcrN6rIvcBhGlgpgqa?=
 =?us-ascii?Q?exl2NxH2BCueEHiAg/J+pPzpqfkkKY/2oNYPVsYuz2P0DjTz0yoLDegwuwGc?=
 =?us-ascii?Q?qvw2G7MlzVBOiY479JBOri21mGmhckFd65kzZ/wmrA/JQ3gk0w955c/Ffzq9?=
 =?us-ascii?Q?/C8YRzm33B3YAdABQCVgGVtm5PffPv71Pqomq3XNgdE3d8W3H37BJex5bk6w?=
 =?us-ascii?Q?qwOhq9PLzia3omBozzzLjRpC+hpe1n5CJUMcvu67HGhDGqgzZ7X1U2lJcroS?=
 =?us-ascii?Q?hBpQN5nHwBu9p7BY5XxQqZfeJUd8cPX8jv8SyJ7ZU4O2uqmNFEq9GOL3gTkv?=
 =?us-ascii?Q?+ds2cle0JoLC8wzt7bObxENqWgVtNzyUaezI9nPabyGE5DxU9G2NzM79Okf3?=
 =?us-ascii?Q?J7L6iviUq5qmigm86epoDDznVObD6mlj3lVHMFZNCvdREqI3rwadl/kHqEKi?=
 =?us-ascii?Q?GYnnuIMNt8vorRt/7NwfoLamwmct3Va+ISwZKBAzaebGHCHILGWAtxaPbpjI?=
 =?us-ascii?Q?hPQdV0ASzMmEBxUcDGNJFC9c1s4OrmRMqlDgo/ydsof3cj69KZh0RaBQlCBM?=
 =?us-ascii?Q?a49QrUpZWh/L6hT2ZGdeCP+tGko2EjQJWmvkcTWez2S39xCbOruGNgJEzTrL?=
 =?us-ascii?Q?d3Vbp+qWsYXw97qQB9+DxYK/gHWdzRNLriPOn8hvOhsHW6MfuIyRlgNTOrms?=
 =?us-ascii?Q?jVSb1w6SttrQYRmwdWG3Y2hfyVx76pVfSIN6DKQb4FRIfCLg+UTaz/0o/fwV?=
 =?us-ascii?Q?aBPRIh+Z0qdLNJIVBvVbGJqYKEpqT2rf67vy1k0PSBtYgrAAHiwMKoFnezma?=
 =?us-ascii?Q?2zcE8EzkCa/Tf8FISbztfqPdR7oJlpSPWN8dieZAGaXApjj1mr5GMFtcZM9O?=
 =?us-ascii?Q?H/9ep+MWGAZfpWlPe+srR/Ji/dOccWeKuG12b2zSWT73IpuvC0f/n0Ep/kar?=
 =?us-ascii?Q?6ZzTpcnbfrRTkKQ/H/vEBFQhwzA2LGShswhLCxb3KfRBtMPGrCzxsB4UTnXB?=
 =?us-ascii?Q?e9V+PW7XpS1bBrp1ceLyplrg85qjiUy7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1o05GmuTlDBgjrR1sCuLz0ceICBZ3OsDBm/sBlbrJobsYeuqIknVv+jUKbZ+?=
 =?us-ascii?Q?C9Qxo1R1fmGKAd8ZhHUUxIAeDJQUUl7vlcQxV3bzKlYf5/A87L52zaQphTNc?=
 =?us-ascii?Q?+UUJJ2jecgc2Lhd4htLVy35WhZ7YmYqfBmQCEwE+mQXZFTE5duo7gha80k40?=
 =?us-ascii?Q?INgXHQahkqRy0KP4cKhxgWtoci8OpF6asNSpWzW0jbKAQYkeVODvNFF1jZEF?=
 =?us-ascii?Q?Vw1R3iXg/cphZ8u5ZF9hNQRc0bSFzGyPaUf9lJaXRq1hwXyxS4O8rRnB6gn3?=
 =?us-ascii?Q?G/a98YyXIP5UtrUfN0mVBh1gTU2Aqhalo1YtdDlEWTduiSkW7xiGqxKlH5Mp?=
 =?us-ascii?Q?CdE6FOObW3UGQ7rHqBX6gmC/axQS4V8onzO8gt256WcL76TzfR80yE0DvdlW?=
 =?us-ascii?Q?DiAtNAAsXduO9zOVvnY+JYvrJOWhxMfST0pQ6SQTonw2Q/Xa/Ldzt+odHa62?=
 =?us-ascii?Q?joYaXrNxY3HDPV3eM7I1TgBXNUDOL17RfLOnC0lmPh3ZELOwUX1yfga+aaVt?=
 =?us-ascii?Q?Nhv1FSIAX9pRV3/ctCvDDApletHoalYnkZuxDFsdkW+jOWYhThC9cXzdR5EX?=
 =?us-ascii?Q?Ly/25lZt+3miblbyLSZQBaNb+Wc43gq1GZtk9LkXh0IQzbZ06Lb91LgSMGrT?=
 =?us-ascii?Q?5aQmlAPQkZiGBoATXMltQ/V43MBpw+w4bJsl9Q4k5vEaClkHIT+sWLk4pLlc?=
 =?us-ascii?Q?FOITDimhznNaSFTOGWZtI4yl/qjN47agJVou9V6jbute8XlHh2tmn9UBPMfT?=
 =?us-ascii?Q?NrXQ9hvArO+JwMHThZ56sexauhyn6P2WTGgnmXJQKeU5HVsoup651yUkZruN?=
 =?us-ascii?Q?nIpa0O5WoCBFF2wL0Vuub6pv8BbZ21m2vHU5cuE2WpjIiLETbSuQNEdC0+Wx?=
 =?us-ascii?Q?Lt3IbXxFZc/kEncCOFOELQGFG/Itoayb5XPZSzpy1tY8KVa7GM+fk+3UHsBB?=
 =?us-ascii?Q?MSHf5f6v9kKHLxuDx+9wb4g0LOevr6U30M8mT3Z/4x/9DCUYgj64TmC54OPA?=
 =?us-ascii?Q?TPk3ADbAvB/VolrcVHM62FVTqXk7QpuaIJgn81NSnWonrAO8YyKenT2UB2TG?=
 =?us-ascii?Q?bZYLN6ql6en227V8DSROZ1jdEz8Zzr6mcVZyv5N18FCh5xfQoBOm+q3pQNv9?=
 =?us-ascii?Q?Cnaul17cgVSdTnd3Acrirlf4Jvmh9w6ATqDQVQHlS3C000h30JyvefnBh1KF?=
 =?us-ascii?Q?xN2Ue+eoOEmSMrY+PPmiJIsAxb5FWPS+x+W++sp56GBO9Sd8Ww2pZJJg6xf0?=
 =?us-ascii?Q?dLk8ndKo/FAtsgkDu7uF9UQPofLQUKoi0D/JdJQjwDAExyibEItGfNDz7vd2?=
 =?us-ascii?Q?YW1hyJd50pwnThaQze9osaP58fiEqhqf0mwQuk5u6n0MgTdN5/sm8cx8hBcs?=
 =?us-ascii?Q?pTJr8YPiddQSQHcQ+tVqkbnTb5CeNEBGWccfZZnp5hefOKd3t3r70kvPqwal?=
 =?us-ascii?Q?2NhmyKh6LSZOEiZN+Y6naJxJmfVFqI7jjrOBAYTnQN1uk64f9iOuGUjroINP?=
 =?us-ascii?Q?e92s3ZTm0Bvq+q4OLk8mR4yN1XnXwhyoMp8tF8TuarPKZC4nvu2dKJF89fn7?=
 =?us-ascii?Q?D/feRSkZ3m9+gATN2eg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0decce72-57df-4534-0d9d-08de3d028efc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 00:23:53.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5qvOCcSi5UXzZaQ9jxWD7kFpMAKhydThaI2BFHgDplnk3Xz7AcbGyYFl/YJYYYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

On Tue, Dec 16, 2025 at 10:58:33PM +0000, Mostafa Saleh wrote:
>  	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
> -		/*
> -		 * Ignored is only used for bits that are used by both entries,
> -		 * otherwise it is sequenced according to the unused entry.
> -		 */
> -		ignored[i] &= target_used[i] & cur_used[i];
> -

It is not functionally the same thing without this..

> And we only clear the bits from cur_used, there is no need to for the
> other mask ignored (ignored[i] &= target_used[i] & cur_used[i])
> - If an ignored bit is not in cur_used it will not impact
>   "cur_used[i] &= ~ignored[i]" as it must be already zero
> - If an ignored bit is not in target_used, it doesn't really matter,
>   we can ignore it anyway, as it is safe to do so.

That was an earlier version, it was switched away to this so as to be
less of a change though the reasoning is sound.

Jason
