Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F021F4C88
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762846; cv=fail; b=aTAKp0XliXg2hnhUbtyK6PBNNiOdTSLnFAbNs54o5YATyksltapnphS/OzL5RUcczSzhnrkwaUfI120PI27jaoToOs46jpeKgRN+V6rt4RDXCnnR22r3447+ExqwCtl/t/UTWmLqz54x0qLNXZb54tvjva/Goe0+7S5dP6dZr0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762846; c=relaxed/simple;
	bh=+56AsF2MB3Hz4XrcwZu46A3gRSuFxoJq+9oh3hfdRT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DR/FwE8XV1SsFHe4wis4tJ0cJraVmyNDNLrZv5wdQW8B/jQO5xzQ/BocGRXDuYf6zxIS2PGs3p0TjznLHS5bIOW2JvoXVB1YPZqFjW+7B+t7Os5xWJyOuThoqdpMRn1dPHCAPq2Omt2/jC3iB+buTUg5GvyNiVtdEKehgvz9ZtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBiNsToZ; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBiNsToZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJMIk2OlAITPTTXoow++AW89UVcBLaB0OfFuPzZSGecPfuU6aUE4+M10PGfxMTPSsStffZPwnw9hRoveoyijjeMCD95xMzW37TstlGdTQTaNyX9FFMXw//NeT8pNkjMmPAIAStn5IDmEngFPgvlLySV91Y/BDrksP6eDPvXPp4SFKddSPkKM/21IDcYbh0BrGaN/WvhnlEo+rMf52zQEaHKaViqxBOHfBqtaF+pKtllai+jZDxBLqfiUDsbo0b3nEbkJ7ZbLyKMJBJE3wCh4gDzv7cMCBd2BakusBxns+TzE8avvNOXGKvUoBas1fzaUGnsAD8UXg2CI1QziomzkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s7R3pAS48KKmNxCzXchNnKKfrbLRvbFv7GhX/+Ich0=;
 b=wo/+Vje4L47PJhOeIrT9OpnxaJCTcTXR4bDKs2VQAXadpINFk7KbfBzEJ+JSwGJt4q2cWLRHIweU7jQ30pJpfrP/yWA0PZvYfWu+x6HrvcEs+0q3bFGIEn6r4Va282YmTfBycmwd92ntt5/H9erX1uDvauL7eS9jHN03r9BOCaswdIAR2ggTwzeALkOvECrV72ELvuAOaVoXhhhOWZ7Boqt+ntNfjG9vmNbzHJwuRyJlFSgHSuBBaJtkzgALvQSN65uuH8LFYUFLOSZOsZuBRu/+ruSk2NdrSUIFrq2/4Yc+YBaXlwflF4H4x9ga5IuT9q6Y5q/KjpqstCJN6vss0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s7R3pAS48KKmNxCzXchNnKKfrbLRvbFv7GhX/+Ich0=;
 b=JBiNsToZGMiTfjI6RrMn7PEmeMkzfnvZ7ggYmfexQuBvBLVdXqvTWO+5x9AzJBdYmx+k9nhwDSjL94gafa/W2J1zK3J7kLgfH9s5bRFUeO4j6/SZJMl24JPPOyC6HWncKlxmbyr8rFKi39cvMiZ1rKmtGPQncnRtwHoq+tX/5DH+1jmKSAMBOENpI56tiei7oOozUfV5tabAI19TgmYM8ufMxIJ25piOcxXW4NHO0PVdkeTmigjPgEtSQGGN7dwZlMfzkKpoDZ6ydvVRh6IO6ZJd8F56cXQRGl77bQhqOTa0YtXbtLFqfAJAyLGvBlQfrUCiFPlq99egmLgpsRpC3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 17:14:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:13:59 +0000
Date: Fri, 28 Feb 2025 13:13:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD shared branch
Message-ID: <20250228171357.GA39591@nvidia.com>
References: <20250228142933.GA105053@nvidia.com>
 <9ee55e38-b92d-45e1-80df-a6d08c9baccc@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee55e38-b92d-45e1-80df-a6d08c9baccc@arm.com>
X-ClientProxiedBy: BN0PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:408:ea::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a8fe36-6a93-4b6b-a4c0-08dd581b4a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxvsR5/4nLu+ILjIFMmSgWx+PvxDxTFHxa6zHbi43UL91QcWVMAzKPoVVwr6?=
 =?us-ascii?Q?EmWKZ88ysXD0uZMOL2kOjCTBO8TT+lbadSMa0l6HPJyTmtBqkwAPgCsknnMA?=
 =?us-ascii?Q?y7yQ/GtPPOPXr8S0LVEyPtu3kKiQzOibf6cEUtwCj7sqNe1SBSM2xvI7eJZU?=
 =?us-ascii?Q?3paaRpK5n+qoBfTb6HQ3sFshwlnU8S+ApAkBZhf5s0pWfzJFjILIvDyLlWPU?=
 =?us-ascii?Q?4lXp1KEz2pDx0+S1Tgbx6wJfAwRjpwx2AKhkJegIpL2kHq5hUVMdfA8XxcP/?=
 =?us-ascii?Q?+sJBZXyqlHkRcZ8/1TNfk0zcVw1iVufOkXtFaPggMgITocU261F7XzuHjCTE?=
 =?us-ascii?Q?lc6c1dqNX9rZE64NgupnAZNNdi/YEH1a/58cJI8+SocfMWh0nHasDCuXqwCh?=
 =?us-ascii?Q?VEI3j/5U2w4ag0KGIgVJ50yJMJQ6ZN/EAmj1n32kOB3qkItx9TyHchHSfpVP?=
 =?us-ascii?Q?mgCmdWWIsF31sy7Ml/14AZB3GG33b1W0RfV6KIhERaH3AyX0xQk+quwljyef?=
 =?us-ascii?Q?/zRzg3O4eE4rvy6qOPCJvnqjqYceEdjUYryxzLhCpvNPcmLjZxh8LlerrNmj?=
 =?us-ascii?Q?6cRMUwGgc6iBiOGa5hp9RgEpz4GpfDgZIN4sa73llKONJtHyT1IOP9IXqX9Z?=
 =?us-ascii?Q?6oZQuR9gks1eTxrtIedqTdBt/tc5ca0aKGqzpO4fWst/JqGll5cEaevFdqZv?=
 =?us-ascii?Q?k+iaCTIM78oEcI+KCdEm2NcdyVKvC+Ji+Pr74uo/bdXp4Agm85mgxb7ZIqq0?=
 =?us-ascii?Q?HjqpMyYNA5HvgOahQCu3wpz+4WKMz5Z7LkNDWalEjPOfRjKdlMfbX3YrDb6x?=
 =?us-ascii?Q?PDQWO0021Q8wajPeiBX5Uy1NFRsZ54p1sAE9JywoY2ctveFCRtWsI6IMfG4t?=
 =?us-ascii?Q?iR/R3ZWKkdMF7HdwvOVMK65kmnjMYQtZrCXopl+CQjxfRjxcyPhNrUSoUqVO?=
 =?us-ascii?Q?KsFo0GVI1HyxOs8S2uw8puU6qHnnPGkxKDCgsuWCcYpm8bwcDErYSpfPxBZW?=
 =?us-ascii?Q?2jRt7CoFP6IBupXdR6Rd/GvKZDVTElWZQnlmsK/IkTb0Br2yxvlxISW1cO9U?=
 =?us-ascii?Q?tlCgLv2cHuepq7j7UhbtW7Ka2H9hgY9X4Z5bIAAZiCQct7siMF2H7pFKgPzB?=
 =?us-ascii?Q?4M8b1FTaiztwHdIgQnnT5fz3pE4X4DbSQogA1r1L7UC2hJ+ou2qGDx0+LnSo?=
 =?us-ascii?Q?bx9SNJTW3+UAjMHiOmapKi0Gojie2QYCLRfvef7cD6eLEyob33S1HGOytvh8?=
 =?us-ascii?Q?ksFHTI3DIWXkLtWQUr5RwEmrBk637oBYKgHsLNdnCioVpM0O9nko4E1Q9FQm?=
 =?us-ascii?Q?chpGExbGTcUWdgCRYA8wh+BdoNsLWREXESQTjeTViGaO8D3U5kd3kLBc4Onp?=
 =?us-ascii?Q?QmLpoQSQKQflZIHH+VA0MaWpW7hx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZvHtXr++iFya/L+AXhxu3tBQRivPGy7gH/VuK4tFrn7N+VPKhmg0zg1kP71?=
 =?us-ascii?Q?wj7IfqbQm0sucdhKzdE8ArnTh0cbXAAR/wHnX4FRMXuXSTpW8pkvEuReg25m?=
 =?us-ascii?Q?pT5z76er/eHy+QgE0ZGn162swVXyCEpEv7p5kA08fYfEjuMEWfgBIB+A3Edf?=
 =?us-ascii?Q?JprEOxcyX/o9NO1OlwVvBNU1lLqi0fYLEMrvLn4eZ17NX1WqU2NhC7Tdwjpt?=
 =?us-ascii?Q?PyUOAjjITaMerIGlFHwfHjwhByJ7ITXsH+0mpGSyVUhnLqchkDeyJyApGCQN?=
 =?us-ascii?Q?tGY2BPaV+HkfCvE6wHie3Dn8pXSJClxhHb6ZjGSADzdaWkjR6N8lqYLhsgeZ?=
 =?us-ascii?Q?+m//+Hzf/c5E8fR9SFoAGjzWrKn+zDwQZWXrZcs1jHiLEUU2lpNnrlxcgCjF?=
 =?us-ascii?Q?p6TM6FSklAsDHba9V1vTy8IWgu1mJc1M23k3eKr3Vm2pkYyxZRvCoA8S/X52?=
 =?us-ascii?Q?FFyhgCjEA8u5hLD73qNUBnEvJ4QEfoZrScqegtodniAaVJldR0xVvSNaKF8o?=
 =?us-ascii?Q?4QUWnUZ53O44wyEYVdZwyfAhYrp2zWdJZa/AqCk8jb6sAKXu6IXhvjEa1jOP?=
 =?us-ascii?Q?PZp7JYIihAfOGirdneFvrcaFOTKSszIzRxq0q0h4keAbB94ykSoNqLTqU+my?=
 =?us-ascii?Q?L84+XqyaEQ1hbRPdY2XUqBt1+GLKgJ+XYBRGmGHKIb2NO/bE/MIsm00O57+h?=
 =?us-ascii?Q?2lVAieiUnzPX+Uqe/Db8m6eTxozqL+kAEFaQi/0ZCrlw/xI0KX0foOndOCe+?=
 =?us-ascii?Q?LASmuNkf0/ZpyJ/nAyP+BmFc4DWggphKifeVzRoJsJcaTn6sWXHN9Y5++zuA?=
 =?us-ascii?Q?dh/otSPHPqboonKm0YpFG1aE23ZxHidnd5YqyARQgd0PS6/Hap2z28YLsOKd?=
 =?us-ascii?Q?EzkYr446okcpUJefw1pk9sRhrFVuwT15GUVkBr1LGv+MuCv1hRRF8FZ0kU92?=
 =?us-ascii?Q?BHuJvI86KsvEFf2IZPFJhaksKcrQ1xXjZsgywjqCNOmaM1vzv+pCd9tap2Z8?=
 =?us-ascii?Q?ullRG3TiXRMuL8RsR3e+8fEvINvZu9XRwa1NqRl180tS/jMrsGquhaaWzvbV?=
 =?us-ascii?Q?BJoozQ6yBJ4rb1+A/NKNmBh3kwYKpJcLRZ9LjRMufxcL8iHPm6F0LNuljt/U?=
 =?us-ascii?Q?Di7uYhaftHQA4um7hLb8lhgMBf6LlOXm/b1a4wNEET91tXST1xbcofI7r+be?=
 =?us-ascii?Q?gHRMn7bfFDgedXGQYvW7QiCsinM5fSp7Xo2CxKvzc7fgsKcnJQ68lu4GIdGK?=
 =?us-ascii?Q?/aCfCgcwp8n77cJOH6F/MgcPjjGqHmKToxLtETnCEnA4ylYMTXL3A7ev5TyQ?=
 =?us-ascii?Q?xi55o75uVQsQKL+vuztGHBKc0I7BmQQTH1Aba4hUy/U76uVFrK1wxVycXMLR?=
 =?us-ascii?Q?Ul9+B5aqy2IeP628N8Ad47NwiTHcoZVpYNwzFE1NS0d5g/sN28BlqHeTq2mO?=
 =?us-ascii?Q?RNIrerE2H7S/j06ciYEuPOE82ozVgPtaOVLtZqhMtdgpWLC/UJ8cNf4ATFgV?=
 =?us-ascii?Q?O9CFYMHAvPaNxuga2WDnYzcxqRuJ44OwDX+8e2XYcaMpXwbH118pe/TEx7QK?=
 =?us-ascii?Q?ojC9+Rh75EiFoNL4h/I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a8fe36-6a93-4b6b-a4c0-08dd581b4a74
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:13:59.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek9Ga9DUIpDxSSybk/gCgq9gZUgryDMI7wrtHg4m1+pIAX5tZOE3Q1XqqXJWZWL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

On Fri, Feb 28, 2025 at 04:01:43PM +0000, Robin Murphy wrote:
> > Jason Gunthorpe (5):
> >        genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
> >        genirq/msi: Refactor iommu_dma_compose_msi_msg()
> >        iommu: Make iommu_dma_prepare_msi() into a generic operation
> 
> So we're just merging this anyway despite it getting no review other than my
> objection to it? Oh well...

Thomas reviewed the first two patches, Joerg acked the whole
series. Nicolin reviewed the third series. It's been on the list since
Jan 10.

It was already in my tree and pushed out *before* you started making
comments.

Patch 7 that seemed to have the most problems was dropped.

We all promised to fix your style concerns in patch 3. I thought that
discussion was agreed that would be done after since we need some new
infrastructure.There are already 3 series trying to figure that out,
so I think it is likely one of them will go along with this merge
window.

People are waiting on this work. It is fixing bugs and problems that
prevent actually rolling out years of effort here.

Jason
