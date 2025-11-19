Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265C7082F
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511684; cv=fail; b=lCJsr4C9OquxwrGWgOYLkSxpwkRSMFWCyh/TznDlsW58coLXdilw5Vga10n6mjDj7q4E7uaC/B+bLDkMHSfK0zfaoiJhqi8P8C4pWhjmzypzCdBjTDysvpdioJczapZ3j5Rob0UalPlqevGvpuchB+XjzogIHZOeG3u1nwlKcAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511684; c=relaxed/simple;
	bh=cOdp4gomBzJ337Bqn9AUjOqqefWwHXnn+jMlTQo2tyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=frAqqwCuXeG8jWsssW7V2Jyr9DDOmY1jcwzCnhdrOFseqKLWjb+PqRHt2TjL2v6YTuqN/Pkw+sysRcdLINsAGJZNSASTmFFD4zYzS/PZyWNEOf+mEjcX/P4vxoTE0CX9yzVLIJZZL6mn1OSHgNDfbGRTCKDuhxvPN4GLbNnrsNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cauru4nI; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cauru4nI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyGauJpTETRr840M8bD53+MfcAuUPOBhSdAV6haBow8XYoBitn0+LBXdtFATK8aLSoPr+M8hcYWOc/+2Pt1Ub0/HeJ+qVDCbKxhlOqrA/sFzxu2YraSdtgZ8QEI7ujO+nNRo7snCRW3HmjqdAeGrNwEmNaIXmN66KwzpzUF9KSCXmW0ArTEx11kkKe+REsoGttJSOhsYVR9H8HIstpNkCqzlRh2AmIdz6kb9UL5Nra/eswYmBRFj8XYPpmErvvP39UaH6edej+dpY29oHzxJXHrbw486UFXvNF4+/jHNXrztDzzkzcEZEsrY7Nem3pj3cPbcnTAruxgyOf0LAsPzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ0GxoPp+GWv/csruBYlitikqCj280AuprGs5pVqNSI=;
 b=VyBO9F3tudHDCBa89RWfdpoUlu3Gy5V02cKLJCwZ1X9ovUOJWmJ81eEFntjivqf2Fjy7V0qzmZCslOoP+0VY18mpYpHO8ZQI9vv/HbPWyaC0/8PDzsxQTX9gCVOXF6cyci89jDC24wikjPidCcC0fNXHjUsREM8afXzVHdozlb83Upy5vjmhT0GHDX9AqGiHVj6e2oMWyJZX9bgjMus1QzJlZiXcH9DZkT31ev2AW00Vlsz1BAeDnMvDcGhOmyCMRewzVpP3mBKdgY/yyheQupIV+8yWIHNHvCaW6wwn68WWXqUm+qUosWzD8nOjyLwRaa3RVnITq8VoAWO8uFGnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ0GxoPp+GWv/csruBYlitikqCj280AuprGs5pVqNSI=;
 b=Cauru4nIZuUzf8pwpKw6dMvGNSlxB5S0eYSjMcdtcyKLCNiWPXBlcm4aFJrkabVxZraesoQBe3WU6hXvPPHrzDbtl6jE29EEtUGEPSfotUp9hWYmGSQo8/iyDso0pbTVo+GT5mgZfUApz86ja0m4IDfCqB+g3nIsbEYTP0PLZSMQGjb3tmRP9q6YrvvVy4P6DVdzjqMAgKJ2jXC3rMVk+mESUCgkPLIHqB4V8+oGUQeLURu7EA64am42tvcV3804BV1jjOlLLpSakCZJ0xnKHtVNulZJ+q6gwwEm73SDbsLqIJNXzfTO7fcgyYK6QxkZkQ9+4B1GnrzNdVUc5yubhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 00:21:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:21:20 +0000
Date: Tue, 18 Nov 2025 20:21:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251119002119.GK120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
 <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
 <aRZNw3OFePohDLTI@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZNw3OFePohDLTI@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:208:2be::10) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ca4db4-457a-4e1d-db13-08de2701900f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPDzIlFJABkyJRkiSrSYZk2lv1pKxF0eSJMpU1Iun3asD8KoFsHhC8VN7Lz+?=
 =?us-ascii?Q?5Bn1j6KydSMAO85XTesHJZQNLNjLqkObHEEeP4f75Cl/fa/7ncW8FaloRbBz?=
 =?us-ascii?Q?SXTFYAJkKETQ8wNVuiN+uur1p552GicY86vdTFrx/ijbbQ0Z4UuLg8GRq5wh?=
 =?us-ascii?Q?X7aEndG8GPsLuyPVx87CJntmvMWczVCePXPMpNOMRIyUP1ZEMZzv4JcnLysF?=
 =?us-ascii?Q?4p95qiEu5iW7136Ig0aeMhfsvOqnANd1k+lR7GaFnTz4XezsBaEs65hXsLfo?=
 =?us-ascii?Q?wxtC25ukdrJV5MKiPUL+rhxxhSBPHzeW7MjvjRZN+NQrtbYjvAFFONULzCVU?=
 =?us-ascii?Q?g6WYlV1Nv+tcIB1REVTnjP1o+hiXMMW4yv/HgcNYDy1TOlz9UCh9A5UY25+U?=
 =?us-ascii?Q?T8pDGEOQ8Qtj09WooLSEN2755GjbnB5b0dAvx7os+NsnpFSC+OiU4RG6MhBQ?=
 =?us-ascii?Q?YRmyGSdglIVD+fkDWDPAYQZll8W50xfli5JxZNDNld37RdiLwkf0EU5w8qUw?=
 =?us-ascii?Q?KZqvf33ocDWOGWJJoKRKGk65uyhtz+Hv1hyAamIzNXd333jJd01pUoEG0YE+?=
 =?us-ascii?Q?y4YgdPXP13IN+p0yZBYWJF1B6yO0bxM8LrYgRXE50MmW2faQWSN5PCrC+qzm?=
 =?us-ascii?Q?yymYcF/6JTkAKA1iv6ahs5+v6HkSiLtuq0oN/fdTqG+pBITM1P8s3paN5iH8?=
 =?us-ascii?Q?8R7GzWxARuj3be5vKZzoglDEyQtVsH4+UsqMBVPqVAcVgu4M91azxXbMKIvR?=
 =?us-ascii?Q?PxSzC9qe22Lb+77Jbvq9W3RxTvlKG9L9+6+uSRE2N7nEvWOw30Me/gUMSxm9?=
 =?us-ascii?Q?jyo69mDAEm/yf1jSm7RI2z/HUSwZW9trDK5WrFHoxYAJUIzYb93n84kGW5yj?=
 =?us-ascii?Q?CTz5hkfRcCDKSsivB6kMeoH9SCKLnIc1BNAQR3TC6Jv4luEbPxae4i45ONQM?=
 =?us-ascii?Q?/6lEhsvEAx8hUrXJkKFQ5dv/ATo0KOHBBJ7ccdmzc49pQsuzjJ/alOv8S2P5?=
 =?us-ascii?Q?UfdZggXkaeL9bT/usyyTP67b9vQapZU+8sYXderZXmxYEQ4EocL6kRJ/Brxs?=
 =?us-ascii?Q?Ygc8TkchgjlmXRzgnAwczMlPITJ6seDWz7SZ1XvoHeNz5A3mVKBvAVA/3hWK?=
 =?us-ascii?Q?+TQrJDJwUOgMUeSHt2c7eEGWlqJtND/Z4hPbohRDUhaHi7hruzI0D5IAfLAP?=
 =?us-ascii?Q?b2Yb8GFsnzPBQvZWe9jeKhhg5mGCdSOViSkwZDPY0Exf9nX0gCtYSK/WqzBm?=
 =?us-ascii?Q?tzGo8e3e6B8s+IIeckV66Rg2PLpzzVLs1FPzBcDgpaOecr5AQ/cQWZG/XolS?=
 =?us-ascii?Q?HaHojJOHx3EnJsMifOXhDutQByw5ssm3EM9aUlWMe/Qz44FfKlMw6ZZ9bF4j?=
 =?us-ascii?Q?7/r3kLgaXKlLIa+hxTnev8YOzNCL1gsAmXRZaploRzVhxFaOMsRiO8TeLPt7?=
 =?us-ascii?Q?bw25AL9rzt5QPyiSzjw25O+DDlZA6xCM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8kUy8lGmWw2HtPKh4PhVzSWnaFgEj+qHF9faRMkbJdxqI/vCBjTD/ZRg+N7?=
 =?us-ascii?Q?P//7RALOWH6n8OdibakNLlKQM1tVeMcBkF+1gOWnWLLB69W40ftIZCna3N0c?=
 =?us-ascii?Q?j4zWxBKeWdr95h2CROm2c84f3prikQdmeen/sBKN7SozinTqkFgRzi4aj1a8?=
 =?us-ascii?Q?51StzWwc7PZ1dpBpgyy6b2f8YcB/FVUAxuHHgHVep4vrSs3x151lKTlnn/Ci?=
 =?us-ascii?Q?P8Bld5jHWOM8ktkpM+xsFBROsvJ8yTqdtKc/u+g4Jn9AkKQJEWl0iTmgUix0?=
 =?us-ascii?Q?JbVpAOxUR85OmODw/Yj822HKziYgXYkW/CJdM4zfL2apgwFt+bkY3mjRDSqu?=
 =?us-ascii?Q?2DEFBQMtNim6iKvdBLlmwih+E3pn0sJ3GNdwIkLRH23a845QwuWq0r/6KNZG?=
 =?us-ascii?Q?GfsqL9p4c+YQEY2T+uT5DcZ+siIRbSJt85NWaUxNorTbLF40HObeQt+vagrT?=
 =?us-ascii?Q?b3UeZYfcrdJxx4BRCgP2/k9Yro0goX/hq2C6Ue9UEfiZMsGP37VWXnT+8lhk?=
 =?us-ascii?Q?aRu0gcHoqR/giW835A6DE+TKI5dIDjwuO9/jg0gERKvz5qU24PvKjrQx7fzc?=
 =?us-ascii?Q?cqS3mdwa/MrbrSxXEGsUive1RbjAx+AZQPfXiGsADrIAhJ0Tbi4FCWqI5Cbl?=
 =?us-ascii?Q?6DoiGpqDDPYRasXIYjh+V+ERoAf1QFgZ/mOS1gkbKsfASE60xW3mlQjlMlqP?=
 =?us-ascii?Q?KQyQBKBL+q1stj95b1IWKo6UVWvLU2PdnyQJvEASEowXBIV83Geeis4iHj3F?=
 =?us-ascii?Q?OzBqB0iYLobZMgT3uIVHKIfI7NGidwrOsMqb9/yF6cphuRmi/5jWUXjlbbv7?=
 =?us-ascii?Q?2JdtOw69GaMUc2wg4009sH4e07uRE5rsMRuYKhYQ7Tya0G4gAPhtK1LK2y3g?=
 =?us-ascii?Q?IhLWGUAZ9DP2LsPOFB0fBfxASTfM0yi0BP+RxRrXVprO55WcgaWrckZDIaGZ?=
 =?us-ascii?Q?4e5RXxjENauKPhyFF7ZXRj+85zZ+JEnSzWKuRAx08wylt7yeswJgembfNo1X?=
 =?us-ascii?Q?Jjof3efiUE8W3XdZ7k9fUxJrybBwwWxfczzTCjyyaN189HkXJMkaupfvardF?=
 =?us-ascii?Q?XUYREHMMEAFvpCnirb1cYXYr8zRo3qYmrm1x4T9BNp+XOnBxUsIr6WpWKlm4?=
 =?us-ascii?Q?4NUdXQ8nTn/npNcIhQSebMr1kJGVzrd/pSXL8Et5MdanRbWnvzwM18GkurVa?=
 =?us-ascii?Q?0mKnNEW2LA6i62Kv22V9oVj3riEMDWyGAsqs4d1cstfkBllBSPSnDoCFtNwn?=
 =?us-ascii?Q?U8s5kvP2vwhR7VaszSiK9IYegCiko6WfAyHZZ+vKHsuN9hqh+wg5pSsKotU5?=
 =?us-ascii?Q?H9awxohF3StWOfFomDuF7PzkbDO32/306FXHLvShv5D9MM3QjF7nBqbEBw3q?=
 =?us-ascii?Q?g8npSGYOfBdHmjbtjy9Tm1QrtZPR/hsOzHbmR5bAtyhI09IVdsO1uV3Ge4f7?=
 =?us-ascii?Q?L40EQsVqwL20QCLFt48HXVOltAMlA7NCShAveTg1ei/8G5LzdUoG7UFpEMyH?=
 =?us-ascii?Q?n64eQ5+MvfPwwXZSoAUDJmgRxj5IIcNFqIYzRS2dC0yFWO484pIwubjZgL+X?=
 =?us-ascii?Q?jUuHj3wXlN0P99iSY3o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca4db4-457a-4e1d-db13-08de2701900f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:21:19.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPvL5ocYNvZh8XFSgIrcOlUBGkf9c3KNMJ1uzFXte89Bo6AVpL7p9/PJzbmIADGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588

On Thu, Nov 13, 2025 at 01:29:39PM -0800, Nicolin Chen wrote:
> On Thu, Nov 13, 2025 at 01:19:16PM -0800, Nicolin Chen wrote:
> > On Wed, Nov 12, 2025 at 06:25:05PM +0000, Suravee Suthikulpanit wrote:
> > >  	else {
> > > @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
> > >  						       &pt_info);
> > >  			}
> > >  
> > > -			new.data[0] |= __sme_set(pt_info.host_pt_root) |
> > > -				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
> > > -					       << DEV_ENTRY_MODE_SHIFT;
> > > +			pt_info.host_pt_root = __sme_set(pt_info.host_pt_root);
> > >  		}
> > >  	}
> > 
> > And this __IOMMU_DOMAIN_PAGING path seems to be used by v1 only.
> > So, it could be squashed into amd_iommu_set_dte_v1(). This could
> > tidy set_dte_entry() further.
> 
> Having looked at PATCH-14, I realized that amd_iommu_set_dte_v1()
> is shared with the nesting pathway.
> 
> So perhaps:
> 	else if (domain->domain.type & __IOMMU_DOMAIN_PAGING &&
> 		 domain->pd_mode == PD_MODE_V1) {
> 		struct pt_iommu_amdv1_hw_info pt_info;
> 
> 		....; // <--move here
> 		amd_iommu_set_dte_v1(dev_data, domain, domid, &pt_info, &new)
> 	} else

Even so it should be called from the set functions and the set
functions should sort it out, if another helper is needed to share
with nesting then fine, but you might also just have nesting call the
set_dte_v1 to start and then modify in the gcr3 table..

Jason
