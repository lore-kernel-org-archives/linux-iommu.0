Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792506343;
	b=3zhUy5vKE0n4AiIusrbI+lAyWYnN1tAQWu6J8RT6RFrbXmvMRfprzQ+7HHXhYP+c1uds
	 oWfgdUvi5A7lKfEy6sDSkFHXZu0Hk/muPjO+/bj7tSo5LNr446/TOyCoX75Eehe5vBKUM
	 /tR6QeeRzm6gtxnOYh6KAaE3SM+ENghah8lWA+8y1j1HiDwDgqlrFOeJi8kVWDWtXpDYX
	 Dz5L5pLHCjLtBgxVHZgZLXcpyiEVcZhMpnaRwnnGgcDESkqRy0n+9Qi4DzY5ovlFOnOxm
	 OJc2D3/wtKfobw+1hzHYAmvIy3R4TRuuKzT8TecqYSGN7skeAdAv8zYqGJBFzvOlwKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9zhAEuHgATXUH0Z/QsOjerwdAXLZZJcrPTG19HZNq+I=;
	b=eI/SNEWmFnIp+2uH1qoq679sGFGMfP9muViGeGH80Qo/NFkHAl8kHPsG8DNEb5t9Wv6e
	 rfQOHfYlunNiNDovr5cCaFWT4uNHlj/PP6naxMe/tsm4/xGJ7VD02F50/kP4fDiCI3odA
	 dLo2+zoZugCvJzqW2hHH9D0BjYpFiKyG5KY/5RUEcNa1fQ9Al84J0+09lpZRY7QMDQNn8
	 MqGCtisLjEVkyM6pEG1y4XYbRXjRiLclzi6MxYsN2zuHngu3HHCBlHY1i9nhVfeoQQbR9
	 Ky+jZ4d6DmnLsBKH9hyhM0JJSOSAjwQeKGCkncMnDCI1bd0mz12VvKGQsm5ZJPsuDow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hAPRUD72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.4
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF1606A31D
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 14:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54BF1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hAPRUD72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1tNqgBZUUQURaE4l5ZVIBTsRogU3iZMaz558FbOxRuKX/XsVG/cCUVb9h4TEw1QvzDqpp+SHO5pd3rHL+omwqZWOdOU06u2IY3udd8weK3O+l7jUYI5ALfzp/i1aGXn4Nn3HQLlX6Re26Cqef6a0Kah7rP90z31dE37ZP7usOiyK9Pg7Brdlp8EsCwW8goNbj1aBMUZ9crbFRc+tTMYVWgnJ1y5IM/UhxmOmKjt9N9Z76tDXWHBJLg4W9mOF7PJZ+mhI91s1davMG51GQCVISNgQUHyUBi4e1nOoiw5E7I9pPq316/v2PF/FQr+eSNN3u2cM4z+9BDL9MbJHPSVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zhAEuHgATXUH0Z/QsOjerwdAXLZZJcrPTG19HZNq+I=;
 b=jKemzSgGsOErxwE25x7vyIMtlw++UbBQaKKJdGNNE8GYERywFJ55DEU/Jbe/9hSQI70NcC1IvyZAno6PrVj617KOr8WyJ1rVcQB6e/wpYUSsb9jyd6Jgsn3hmr5DJjk1HI+YNB2lo14cneTlG1qfvAmdbme8+FnLi/97LhltWRuZVIQp9wJ132Gfr+WBCB2pEUQWsIZnQ+vhRtt9OEsYlSk1OqJ5pPz6nk04t6XA58VN3oA19lrnRWxy75Kr5sggbvwuY6BhbYvGb75Bls+pqu6ojBpdKOhgLrtdbRlVW4ID6Uc36NJ/Wi+5PyLuPqFvZmzyO/k2H28+sJ6FApzhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zhAEuHgATXUH0Z/QsOjerwdAXLZZJcrPTG19HZNq+I=;
 b=hAPRUD727Iozru41G6Axxd9GNPCB+DIoH0vDhpqsTvjv/AJUEWjcCgb5S/UiSOQaKTpcu6WKB3rkK015C2Uf5OCoYHgYE2gilNlC/4m5Sm4CXAQR+Ym2RiT3ZHaqvTDw3n2V1r+dR0aLTirUVgZqGwAMGO54uEHWy2MgkBTn1iWI/aPs8Gc49H3oZqzn0ZGsqgGayqSQ7lJWF8ep+B0Wf1LWcpnDTSnc7A/GpB0GUonGiS0URh6hHK+Bia2gPWar/gUdfvI8limVlctDc8/4E0GO1f6m09F6ANHgJaWCvMLQnykk6hFxLH2Zn9Bd0yaCSnKM1B1JwYoinvRyHvRGDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB9500.namprd12.prod.outlook.com
 (2603:10b6:208:596::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 14:25:39 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:25:39 +0000
Date: Tue, 20 Oct 2026 11:25:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <20261020142538.GC3008132@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <atdSrRwrphdI9ZQA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atdSrRwrphdI9ZQA@google.com>
X-ClientProxiedBy: BLAPR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:208:329::7) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bfae91-523e-4468-8220-08df2eb603be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gzUMwpXneYnTR/SsQoMFZ5+wKBrxu71Q6n5CqDAsk8fqQjPdR68K4+OPVprYGXolt/D9osxReA+KsHZe/i7bqdtjXnUeCNO4cJd1miPFzSjsoW4H9oJA2te9/SM1iJL1/AZv1kLBD5rz6xbL/WqE+EEzk5FTarrx+CG7mR+TsdRGD57+Cn+GSSa618sMhawtjXcGN3fM3iuLqB6GWLuMtzOBIxZ4tktgid4dKZpn5VcZYCXSuTpU/Og3ECjtaWlMtd/UgkLOiEWvzJlvtTi1yweWSiKMMEDX5Cy3/Awaz/ifi7K2NBKDXB/HBn/kPiqNJNYvXHeGx/wNW47+U7JAYOnm2sNXk4r4ONc3eRUml2ejE7EV6mAkZIDGqidWK3Kk5YWZDfRPdfOpkJAS76Sj+wL3kT8SenUw5DDWqNd42GBirzVcETnDWYwZNsmpB3Yg+quxr5SH7yaN1GJXNaTsZY8I2mZbrtoxaB4LZOOJnKsa7FcQN8QANPBIfv3M/GowMfrK/m0nGqks143Ca4c9jxp/jcdLpGJ2lp8pMVuaF1JBU3QJkxyLC05ELF0jpz3wkxP31LYn1pKcW3LXmEZtDCY6NTiDD5Cz7FwrP+IuF3LYzIDybS+ijTOGTdMturp8BoZSuoK7zWvwAvZcg6OermJ1K8yaPYf/A7aXgapQ3HE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EHHbbhXS2MY6gQ9FImqAPiD0n0pxLf1W+JMZM2VcSv8gm0FtQhGMwkhjcqCS?=
 =?us-ascii?Q?mw1yKRcS6qkwL78gcvDhVdoEMAVV5HHz6VqSW2hJ2Ne5d9EIcUr/uTEGokVx?=
 =?us-ascii?Q?cyZbNM0XI/0JB8kVF8QiRvRTjmT79YXlsYxalllGmo14Uo53PlpNJVvJMmwv?=
 =?us-ascii?Q?Fjy9Fqu2XrmmwRRpxiUZlE2Ty/ln76zvcd+Hq39qO3jSKKpmJP+FfQ8dG9/L?=
 =?us-ascii?Q?k1ksy7r0VFrqIsJju7h9Puyxo7YXxnRLCfKqf48FHZqFlWdrZezzfvOrRREE?=
 =?us-ascii?Q?PEhqB79Ypav1lScz5CGhvmdpjjdWmAcYqBkH9mANjASYI4vDMxgDEW3+FJ0N?=
 =?us-ascii?Q?BlXprtdPNI1zul1A1SSRdsxwulzK6jzsq6aLTthdy0DE/3cYNCpZw18WS3TC?=
 =?us-ascii?Q?Gefk93iKIWlPxfZN4o8zjz07HshpeU2mmswzDijg0mPYfBgKkSL6kzmPIk1Y?=
 =?us-ascii?Q?rth77aMtPMRR6JJssFQ3MrTKjJyooPGXjd6dz5POwtykzGkzA8xJ+ydsGoDL?=
 =?us-ascii?Q?tA10v0VDwaVFx42Zsd/WrloihlsiS7O3WQErvxOpXo4Jj1vIAhVoQS5f7STb?=
 =?us-ascii?Q?f2H9tUy5g6UVutJp8VuFJbY18s/qbb2yr6azObag2mJa09OLQW/EPRDQzvP2?=
 =?us-ascii?Q?RuBnvRAUWRO6AvGc1lbuUy7+pEDaOM4yp3cARbj9F9/FnplgieNp/54fBKh7?=
 =?us-ascii?Q?Z12XBqFHYLUHfls6reSlGZwjy+CrlQdtnSuE99FAGxM9AFfT3oxcLwxN88eW?=
 =?us-ascii?Q?RhUpDUDi5xHrliLn+WH+Il//nQnpJe4qyYbsebIM8txdGUGC4vYIQ8wI6Kad?=
 =?us-ascii?Q?unqON02EI60Wnh6c6l9DpOIa2NIgHPd6BUcDMeGK0/g2QlcwMQ+DZxxO56i1?=
 =?us-ascii?Q?ZUgb2Q/bE1K+wrSmDcunahEVlACzFYIzWpaylN2KITMpW7Cuyx1Yt/XR65yB?=
 =?us-ascii?Q?/NM3oIDjqgBJtYjJ1rFL9Ub9DdGiN2jBGTEXLjRKTiWNRrtEwIGhFSytAx0L?=
 =?us-ascii?Q?McF9/Flz2h3uFdyWqyNRgZ6nq51xlaPjb/z9d+Nwqtwykr6jc86vPyxLdaz5?=
 =?us-ascii?Q?tbxtYCRalb+eCzCco+VTvfHUq4R+SNCeaHR/CFuRLmpLwnCG2hPg3WHZI8fh?=
 =?us-ascii?Q?8Q7z30sLHnvHjZbxux+GvikkfZ8HoS/phZBbXhc3NSUkTncBGrnGtwQyn/KE?=
 =?us-ascii?Q?II2pH8Jt6e3xA8fycodXb+TRKcnR1ucLPlwL0UHgl9ngKVRwdaUYJdpQcz/w?=
 =?us-ascii?Q?vb1KQ0rhTprSBWhs7EBlBycug+QzbF4njkfVKdvtB57DoG1TeWXQT8w7qsrq?=
 =?us-ascii?Q?8pXKYiRChxne3+NtlzyLmYz0Xaond6f/Y4RhZ5EX/q9GOiCzD6Cu6S47m7tu?=
 =?us-ascii?Q?UcMpl+3GdgC1CB260OcdWKWOQdgYcEsNuwpUTETQL6s8klR+NRQlTPtukVqx?=
 =?us-ascii?Q?ZAlIgcEPxrDUQY/rXucPPlb17IhQeutxMgMQqpDzXyh24EaqF3rqaH7AeKOg?=
 =?us-ascii?Q?/On7Y9y0p1DbDfTaNNHTjBzkOCPTgCD7O27MbAxlVYSCow+di4+W0X83Zt3e?=
 =?us-ascii?Q?XSR+6rXb0tFO2AX9qKEU0eTegBjtolGDGk3Tecm6ThjF6qThpR6l99C6NLtP?=
 =?us-ascii?Q?PJ4nhat+SvHw/5j+iuspPHAaLkNewOc1OmH6P0HneWl5YVqJ3it+nH1XCk+C?=
 =?us-ascii?Q?DvwM6+cgYyu/NgtugoDOcaqctLugj81tfzTcP3HdkeEvyD/a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bfae91-523e-4468-8220-08df2eb603be
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:25:39.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tuopIUbJ7GnfgODteUpbw93u3vm8UI6nXNZWFfDh8h1+AnIBvZ61DDNc3tYfA8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

On Tue, Oct 20, 2026 at 11:38:21AM +0000, Mostafa Saleh wrote:
> > +int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> > +{
> > +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> > +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > +	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> > +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> > +	int ret;
> > +
> > +	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
> > +
> > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > +		/*
> > +		 * Both kernels run on the same hardware, so it's impossible for
> > +		 * kdump kernel to see the support for linear stream table only.
> > +		 */
> 
> STRTAB_SPLIT which influences ARM_SMMU_FEAT_2_LVL_STRTAB is a SW choice, so it is
> possible to get such mismatch if STRTAB_SPLIT of the newer kernel is larger than the
> older kernel.
> However, I agree that in that case it's better to refuse the adoption.

Yeah this is one of those sneaky ABIs I was talking about for live
update.

Presumably we will eventually have to make this fully dynamic so the
successor can process everything the HW supports.

Jason
