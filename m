Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53E46557
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880967; cv=fail; b=PpH5jK1YjpkkOJHoRMrTytR9v0ZbHt8aVhcZYnKmMI+AFw0dtaHGf+bBtIxRPbk/1DE0Da3IPVSLb+bSuosUSizS34xfrKY4aUoP59oQN6ja8/BYiudbVxymv0pZrjYqbGIfRtJZdaJ9AMe1luCPMcY9E4VpaOlOPc9UiR/UiuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880967; c=relaxed/simple;
	bh=gFzCjGuRvtxZoS1kWVUmdrnyupAV8rLmz9psK75Tvek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=leM9KsGzPD0hbKgaOpriS+PeLD6Fmqttl2ctjZR+W3ArTFn4ezWqSPAaKyVwap+oP6p8KrNMOx7gYhpDhcEeh717oFKzfGRHIwz665QPEcKguOQ4I+AzuvFijoL1Y7es7QjEZnTyzOpA8Y1SmKx+KTQtH6xVatpb8bzWyK5RnuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=al2iDjkT; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="al2iDjkT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax0VQiFL72ADEfSFyV9qZ6lI6xy3ZAJFK03Ue+sjtmT/Jf2uXjzFkaux7V+2P6ZVvDgkS+mt7yt/E54gmJ5Q4cvm+qGG6Lovzke60kvfAIb5PsWxP+vbb3xBlnkXoo26tW0bhrnp9OWwvCHI126J142nc9j51KGWLSpnBjKNAeEi3dfEBQ2dtL47OCu8FVHUnGQzjzTBDKgtuaWOLCLXag/AngyIECRvFDxn8WrM+jwCnceAj2BZS5lON7FG2kiEAztdmGw0KQyb9eGIljFVxgXI7ot8qHQu63I+GLZYPZagStOXa0qNsSfMw9SsEsgaQJf/ydS4vpRIHlLyGV+ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxyAF/y42xgnr4BvwQ/lCOKAaG24jhIDF82lMTY4IzU=;
 b=JbKHMU7fgvxtmaer/Ykge9KcT/Rsp5DzTW6KI07wh5zrt+1Xo5S56Kf/SsQNP5Q3+/AuOw1uZJ5PxPIk+bEmgeY0FGiU4uLElK5F9xruJEmB7hxc/SAQziUPKiFg7ZZT+wumSXm1FoHMzS7QLZe3veNVA8K7liqEPsOnxdOsi2AxBnKBUsV1ShO/5Vyn3DfYwT4CDc/HIGWPlOxu2kszt0kCXixdJnbihh8iAxlCMT9viPKFcj4Fn08Jm35rLHftn0rRurpQ3O0hy5rWRW0VLEwbOSrnDtR+nZxb9mjMbtj1wj0CGhyt5SVc1748OKfFs1xjTnRmalApp+IAUkxJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxyAF/y42xgnr4BvwQ/lCOKAaG24jhIDF82lMTY4IzU=;
 b=al2iDjkTd17o3BA/wyRX0FE12r8pnFspRBuRlS4kgSReYcjMQNtK1UlGvQpw78vEP8qXLXOwrEhhnSD5N6d6/zuWzGAj1GYy6CQeBbBChTl4qedL8Tu90cqotftH/weMS7OCZwwI7vW3W7PljTKYKVfEEMGKtgyyQ30f1gbZBAFv7auj+CXWee7B5Py5A8x061Ng+QmLc+8XlojQImmyk5qSmnOV0UWETJxytH9DYjchI0ch/IuzZYA4EuGYOhMfTAbXydE31lePJXRYfDSm+TvYh9quR9bzuum/9KdvG724afvWNw2vhAz5HgN1o5N/clD58ZHGrPb1yC6wI9ZVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 2 Feb
 2024 13:35:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 13:35:59 +0000
Date: Fri, 2 Feb 2024 09:35:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <20240202133557.GR1455070@nvidia.com>
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
 <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
X-ClientProxiedBy: MN2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:208:fc::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a22806-fc30-4f4c-b5ed-08dc23f3e400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C+a8x0ZE3vA8wlXo7B3kEuBWZT9zUAA0PzM5YNtqZWAeUYHsnCO4F5oii/CYGqGCLzStZBv0urZrrCOjB9/PMZ0KkYVNM98fHkX9kPnnVcbpBeKTn4Jdih9doUi29251BAmaRqVJzmobWVf9NQvLbxr8gDymC/5g1tiK1T0oSe5PE/8u5CU/ymME1jnu1VrHn8plGJVgl79O3Ex1uRkLwitvoO0aY6NfFiVunRmDOgI6q0bEiF/pVAfY2HVVlD2QwwTsg2++GE7sLFtBmPccU+6Wsu+xtIvJ0D81n9wZtroD654eMhWx6fG/vhDqdMiGU60Tj/e0oCZMozQVLq/PO+mcaBgZXkHvgZ3o+/Dg3Ln7CO/Ym0uu3xtjnAncLAV7Q0ga47CX98nrb7YYeQqV83knhaE/cGlsibro0bQaKqp8MK483E9axi78FvzJiQb+UdDHvXAdooCw6iwRaVt1OV7373OaxDxC97GBHk+DvMkAIwVEDve1Uemf+1qbJ01LqTJRHnQWv0FDcpcD5RsvpnQg/QaEwwIjIj5+eN3Qk2QuFS4WipcxHhx1K72Et4LNwBp8UIPd5HtInnrFE1f5DGQykuCSselckZyaTqqvgqkjsKF2xKXggCoh1ws9DXwR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(396003)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(478600001)(5660300002)(83380400001)(6486002)(54906003)(4326008)(66476007)(36756003)(66556008)(41300700001)(316002)(33656002)(6512007)(66946007)(6506007)(8676002)(86362001)(6916009)(8936002)(107886003)(2616005)(1076003)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NlIiJ0WZIf5pWyKR4V7Ifuf97VkHQ4Mvmd4IvWfnTHLuhgJVz4xEVmwh5tMu?=
 =?us-ascii?Q?arceoJ0j3vOIlC7x1WQkNglh5tc5002eIxuMGgZrLVi1Q0Pt/e2Zlks14OpZ?=
 =?us-ascii?Q?kReLmWTyHmyY2iecy4trQV/Y3j0/EJ3+Z03VlfUDL3/Yn/k9sZ9Cns3SWqeA?=
 =?us-ascii?Q?HHHYXLJMAYVZi1KNX3NL9W574yn1nbsHy9sni+qOzfUbV3WYKrInM+F6z4WW?=
 =?us-ascii?Q?hYiSy30uJliUUrxmweR1dqJB9xNSNmxtW5oHlycN/2Q8ogL1USCk7tEqQ65y?=
 =?us-ascii?Q?m9kBvsOKH1cHHVvg1XxroRy3GZUhSUBio3oAP9i5teQ3ppDmnUZMXcQx/2G2?=
 =?us-ascii?Q?DtBh099JQpWW55QaXAZOnupkcfMT4wul1zUreRJKVpNCyFhIUbUCS0P2w+cq?=
 =?us-ascii?Q?OjLaAbaf59FtPjfi+dPA7X6OUf29/4XIipM55cZJKZB5VixVNSeL8fRF58G+?=
 =?us-ascii?Q?EqEi+jjcIENHPsftWFtSBhaZu8BiThFCp1KYBae4TBhUUL23h0fXfFGQmQWV?=
 =?us-ascii?Q?2yMyPE1uesJF3tkL5jtzT9bYV2bRLKfoBid/tu1uEGuaNP1iUr6zoa6J/Y+e?=
 =?us-ascii?Q?dzweDwdB72Zm1bogjvp9MYq7uNrNc9BoMIeZJ/Oc0g3lZ1t8Do3dTxdluAyk?=
 =?us-ascii?Q?9jcp/m3ROCqBeO0wGDrHc2PEoJxnjMOkqXNPYnslStlL+P1VsDV5kiDDlQ12?=
 =?us-ascii?Q?wlnmhI7r+gL1NdYQfs2fZizSiaLqxLRD4YRWhv5ti2Io7Fnu/MEA99Off3pM?=
 =?us-ascii?Q?eOArAEGxC/2MiZ9yhFfsCpOHqH/Bp7dUk4t9Z3bEqn6KNig9E34JrFUglymP?=
 =?us-ascii?Q?Y19Z+ULgRBWGPfSBnEmOrerW/cmZxPDc3ZFAwqccpqQDvjU7VNr4BdUVKT0e?=
 =?us-ascii?Q?TgeZlRa9WISKpyM2YqU08i1vCf7fIX/OJ96gNPO0Y/f5NT/14omYJcQaYr7x?=
 =?us-ascii?Q?iTHqQTC8A7CRBivX6GftSz35HWsyvTvSxYaZ0rGt3hnLjEgSxvh4fYcJHCDu?=
 =?us-ascii?Q?LoATYMlB2BZxxVJJ4JxDP18CV4Ir2TlEilLy9QWIoGnoPxW+uZ0ZVRkG5YiH?=
 =?us-ascii?Q?qBvLGZqJqXoIjPiiBO4DNddwMEyPRLhkbaiy/G2rXhYiXLeREW/8AbKDo9nd?=
 =?us-ascii?Q?WSkknn3pWptX3ExdcZ1XZQmhz+FMWCv1/rXkDWn2zVl2hHLHCpgsdDjNT9+2?=
 =?us-ascii?Q?3CMycDqTXP2avy1Jao1Jgdc91crbXLExyIrkzAgwbo2COLvIRVaq5iyTyNxg?=
 =?us-ascii?Q?AQpTnj0GvNJpVX9WABBjHSfVucp6zF5kwBzYtwi7hd6Ffv0rizaIdWdbXOhd?=
 =?us-ascii?Q?mtNcxsjMWoseMuuLyMe5rio+iGwT2xOOMhS91fEHvHFFgiVZSIkKbcWYipMJ?=
 =?us-ascii?Q?5K79dW4tLA/BqUE8av2PtLVksKyaiJ7Efb4QLtLBdgrJC4kbfdPR8ZhM5Ilr?=
 =?us-ascii?Q?bBQKYlMMUsKx3XCdiibVE7AdOhfya3y32CPgj9Blu2yiRBVGcHxiutpxEN9y?=
 =?us-ascii?Q?gvw2uN389DkFZXRBKGz8YzdZvMMkpL/Zc85/um5HPfCA36Ma4h+ds5IpZd3p?=
 =?us-ascii?Q?y8hpMhxzzhy9D6NUVGk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a22806-fc30-4f4c-b5ed-08dc23f3e400
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 13:35:59.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOSDoYtK+NdwcQQ6iwlwn5HQyN4CI7tG/sJbSm7XpsNLKHyanEIlGTT9eneWXV0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884

On Fri, Feb 02, 2024 at 09:33:14PM +0900, Michael Shavit wrote:
> Jason, should we consider moving arm_smmu_get_cd_ptr() further up the
> call-stack as a standalone patch to remediate this report in the
> shorter term? It won't make this static checker happy, but should at
> least resolve any true positives.

Moving is the right answer, but I suspect it is too hard for rc. Lets
leave it to my series that already exists.

Instead we can preallocate:

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -588,6 +588,11 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 {
        int ret = 0;
        struct mm_struct *mm = domain->mm;
+       struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+       /* Preallocate the required leafs outside locks */
+       if (!arm_smmu_get_cd_ptr(master, id))
+               return -ENOMEM;
 
        mutex_lock(&sva_lock);
        ret = __arm_smmu_sva_bind(dev, mm);

It won't silence Dan's warning warning but it will correct the bug for
now.

I'll send a patch

Jason
