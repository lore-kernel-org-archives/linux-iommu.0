Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051221EB5B
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084922; cv=fail; b=cfxc1PfkBsS/LSSM3nWijsA7FMBAVcrEvkkUFRKs9a7TXM7wHmnaTfk8WVeGXJSwUa4VJLQHW3h5Cd3DRiKxNmi/+ql8Zm5Zl4pI7ptXOlKO/WC0KNw3XvKdkKSLXVHpgf2okEXsY03uFFG7PRFCA3WYR2IUiE8zOWAs6gP0F3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084922; c=relaxed/simple;
	bh=m3/xrdqUbPO+sga9+TGojnbXwZG+GXvi6q+nd5mmNDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slX8IZs2VLPvq7LrBW/+5qP8hk2mXJjW86UwuD8PKYA+6RE4Cg0xyT9cvxLi9ThQ6WBEXTb8Y7DX4CUKJ1BlwitcsWPJguCwlyMjWzl/A/cEk5KdE94WMSpAgtHY6Jk1eI1NmY7Fj9PrGX6Vy917J0fprPzZ8QsTM5z/tsnU3mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwtDYsBw; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwtDYsBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6ldBceU2OAseUV6i9LL1fNiSUQIJbeS19rx8Wc9diDQgBX/WnRss+0x2ZWtQqVkFEszAe3WiVUGZypbe7HX/tyG65pNcGIAYkI7oeJmXnkER2HT1w8nEYl0NiadHhNkgWPEcgtLtI/1gSdQZDCPV3OO6gU+wPzyyJl8gSL+iodijI1ap6bwqP9bRIpLYiR8Vf0zyPF+M6wxt3y18FbFxdvEAtISMQCSCK5aApZoxdjYDObfnSUKVcYj64YZQOrft5T3sJFbr2Reo0aY/6Bho4DTmKExu7tVe1j7zuLYu2SqX8VKB+0S91h4qlFYtmN8Qpkp3DfJEic32gmH/FTCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE74aBT415Hcoluhuoe6nf7v1MqlOM+dKDsBsLkP3KM=;
 b=jWDZeF3kkV/oaqTdPZVoAbsz1ZTk74sZ2NW+yzneHQMW4rt1Mqdrhnqyk10IlzDTVtS1q0Bq6SJhEgLe+5gfTFCu9+2jW5JZBpiqZEtl8PmNcxWJceOLgmdZcw6EGUfPyIUwMTCeafCadEZ0SWWmzTduYlezNDjukKPq1Lj+oPxf4vgohVLKIlsZ7gS2slcWWfRK+HTmM/soEFumm/Xz/5XIiegyBY0/2N4Sb3E9Ryh9P0FyS9PWqvUD3QfFx3W6u0kOHv5wcbI5Djrx03SnO7/R4kaLH7FrkdZuFDY6zMVaQ9dPQPNhYZGGSVkWhoD4QtKrdN6GY4M+T9WjI2jlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE74aBT415Hcoluhuoe6nf7v1MqlOM+dKDsBsLkP3KM=;
 b=UwtDYsBwNt3kwURvtzD8ft2k2AJ1Auci4Op2Isk2mcsLDV0FueL2FL8HHHpEOK1tF/KNbWIa1VbBD9/CLBERAytaAVkVT9FZq7ohZTn6WJEIYRxm5iCJzdYi3JBR3rAwPQkW+ONyh6ODgp1H/rMtOMXkJlM68B2G7Vu41kpr+jiCobDGD1Rq7PvGaTqpwXfMl8DwSx0DsdFsbC84HjKoUVpwwzuyDtICpmYX7cybe4h+yHIMeZU86bKF4L0bNGQKRvjOqG1kM/Z5oALvGs3RJO1K62vZvJ3O1cKyh1/nWKQIQD5Ekx53aSniPzuEH1Rc0EQFVbGalxirnrLiw0FBzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 13:21:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:21:52 +0000
Date: Wed, 16 Oct 2024 10:21:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241016132151.GA4116237@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <0220fd36-2f4f-4b24-b248-824d20d0045e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0220fd36-2f4f-4b24-b248-824d20d0045e@oracle.com>
X-ClientProxiedBy: BN0PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:408:ed::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add5717-2bdc-4098-7e1f-08dcede57fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3jIxU0oI7yoUqQJsFDozhg7S/cffVNZZWMbYWK0vhvlhxgsUdGduAyytqN4B?=
 =?us-ascii?Q?OdpcPw6Nw55QshWQpciKD6SohGmItj4es8IaSbl5kZKK89PU86fO8ivGKNey?=
 =?us-ascii?Q?ibsKl/QnaTJ59bys6tz3J1azx3wczxCZGyUFBLxX33tuK6csqXjH+yR+AYyN?=
 =?us-ascii?Q?pK1wi4cOWLh4mbQTESGN/IUTxQmmt5q93iQZvZN6vcMK7vwHOG8DoEpyDLK8?=
 =?us-ascii?Q?G9ZWYBRAV3NzkY3OnRL09tL89Ck5ugaXdw6ZeatRw1jTLTq33RoYrN8/RwIG?=
 =?us-ascii?Q?DIW9L8Kuv3rk3hvv8tESej0FkyaBQCONbS3WDtfHod0q1cFzLxhguuXmelKu?=
 =?us-ascii?Q?5JwWElolnckc5CziBC5gubzwDW8gSa+ytT88LkHOV2YZwXkkeFRC5pMcNvho?=
 =?us-ascii?Q?4dqk8GwZp4c89u6WMyTcRgA/YCXGQlPkb89I1kUjjrztWfD0fGo15vOG7Fjb?=
 =?us-ascii?Q?cLEDxfyi+0H8GRMKB+we2dKFloQAiEjym6VvN7LLzJS+O1J0Fy3h7Xqt3q6f?=
 =?us-ascii?Q?8QvHD/ar8ORPwWdTZeEXHd/DIFoPdPM4SqLKRyi6IMda59CHIroMbT1imypr?=
 =?us-ascii?Q?RsNY2Um7PwkakzETr8Uv3LR9FzbyAzxZ7mV2zk83Misk8q+WuTDX6Fwe4GFz?=
 =?us-ascii?Q?XHE0wPO9kRXvQH+vPq4Q4LJ7U0dgHUlYTgnVKzS+pQw4I8BY3zJT5ZrdZt2m?=
 =?us-ascii?Q?oegktTvQeqOBsYOSccdUJU3IPd8ha1p6vek6U8g49C51Q6T66WUrJN6qtrez?=
 =?us-ascii?Q?QvVIUx5HzrbBaYPjwBdwPYC8Gr1hKSsGBPj9AWQBnXj1V28/qSkz9AmUNDTi?=
 =?us-ascii?Q?qIK4EmvrdE1d3CjJljuOVhinTQN3GTqD9E/nkKEHWQEsaugmGb+g5GWEzM/J?=
 =?us-ascii?Q?pS19glru7MfppFNq1G6rGMRPw9kUBKi31a/M1zCoFuBiMaLWUWOAXgFowMTd?=
 =?us-ascii?Q?w/CKWoajgaF4s4XQhkuo/DmUbEWOSmNUq8+FWnBYofcegr9qVBDE5gBYDypZ?=
 =?us-ascii?Q?oCe8mvqunsnZYoa2/I9D+hEIqCSnpEtZja9Q98sGuv6a5pBhnm/9iMFn3PeX?=
 =?us-ascii?Q?ljKtBAqtl7foZIKSkFcBZSPua/xfslR0mK+9yM1WIvmg8/3cJd3mngQDBR5N?=
 =?us-ascii?Q?XVoBFY1TciLCnUhAh8AcbREyfrj2MIzjsXQvOygrTqyRJ5bN44ZdGWZWKCPl?=
 =?us-ascii?Q?yaF/R2HcQ9cBffgN6vULITrf8ZP1xFH96mUR5mbgqMFYyeiyHKqj89x2/Gwx?=
 =?us-ascii?Q?YlJXAt1t7GLRYEaWHgHTjgSuw5PGee3BXgk9sdJVfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1n+N5tINitkgBjP/Cu9TPtASvcwid2tPYDgdqYAjkSgJOn2otHb/OJRdc47?=
 =?us-ascii?Q?A3J20yAbgFkoQuIpXZkdvg04CTwlB21zuKvC87PqWRrUIdM9/BXIRWSEoiot?=
 =?us-ascii?Q?iZt4Iu8ry2ahea6zyQO4qSkxgEMcMXOKEW4RAHQoPEd8PAZDNQtLC5MIGkN9?=
 =?us-ascii?Q?a7w5CHSRiEdcxAiPemRkTZ9ei1r+8FUr9NxBM9ggFBOUfDUR3SbJ9gEcBKMg?=
 =?us-ascii?Q?s0UyJ7euOIVClewS92L7M0ys3AlUxIcvBBmCP+Ri07I4Brxjya3t/PXJsEm6?=
 =?us-ascii?Q?6D8Cg9DciohHM+pA0m+RdiL1Ky567HpRGIQdoAuUmnJQu23HLlzcKpK+RNoX?=
 =?us-ascii?Q?Px5IfUnrm1TexQ6lqd3FuRgNNRTDwDyoBQ+asiDTuAcztUoVDyj4L8DdWccO?=
 =?us-ascii?Q?6Yw5/Xqf61MpTKPlvjTq8NbaIgfJQQfI8PKtXLKRiZptNlnqj/vbe94ZLSc3?=
 =?us-ascii?Q?Q0WdAhvATKHnNXFKjbjnKpfzShb4GRELjzlWw0cw7VeBqjuieUtf/n/GwVrh?=
 =?us-ascii?Q?X7bdNG5njQVHEN1ynMZ+nIkbdCofv+k+Hq71LK10CrsDuO12s9XqecaWhCYH?=
 =?us-ascii?Q?AqDmcXFtUm2lBGQu7YOOJE8Hb87G0vH+2nCRgvYSkWsoJbRhtjgswEUJTzPQ?=
 =?us-ascii?Q?+QiVp+gZUSsybaC1mMJiZTE3my7RPZ8s2hRVW5xPyZBgEW1l0zKqFqC4UWsh?=
 =?us-ascii?Q?YmH8hi2L8uMfrjIythAFXVT3vG38/NT+VVbVhmgfgI4y+zHwUvDMFXQOmOpU?=
 =?us-ascii?Q?2WsNezypIV+K0VvEOOgWg7kHIxsrNYTwaOWsYwH35zAy+gB1o6jtQe7pnT+e?=
 =?us-ascii?Q?23UBX8u1cGkIF7PHX4/HNnJrv+5P0gM/LdenasCweT6i9Ow03LBiZxXMvmqC?=
 =?us-ascii?Q?/ZYAXoRohg9oKoiJIKbsnlgY6n0HrLIU9XfPoQFgVegCDcYvG6TTHwZMSHQ8?=
 =?us-ascii?Q?zGPjeX2OUfjdYzPiPvmxsUit2oT/XNQqYpwrxZNBCJtVw//s7vZ7HbhXpmZ7?=
 =?us-ascii?Q?qeqHAHy25HoXArnU/S07EHCx1AzlTlfFBtUNQB4gRwINy/af3BpW8Gku/Xbn?=
 =?us-ascii?Q?PBxrj6TagLleSVh1iFWXeAcLVZHsgO/Nb+tS7U8eF6YfvvDaYgBA9t+jYQgv?=
 =?us-ascii?Q?NsaSXhyfFeOHt2CL4WbTAICkpIJAPDSD/og7DBbKIgXWKVj2HtBq3Lq9kZwq?=
 =?us-ascii?Q?dKjqZ8AqBaj/YQNJ9ra6ikYrYQMxHfuAhJpac/Q8CVzkK0LDV/btk6GrT5y9?=
 =?us-ascii?Q?lk9YguUod4Xf6QTxOXDV3xqy1zvkyFGB9GmwGGTs/+Ma51FXMCNb5WvJbn83?=
 =?us-ascii?Q?zXL3jBJ6h3r/wcMFDgRSObHG0RjpaEKP0tzBkWHYPPH4tEabS48H1RXsNnPB?=
 =?us-ascii?Q?PHMiI/IoKmc515qL8+MVZuzuO98V9rsTCw4Uy7NkbNp5t2BrY26/4tiHZJnx?=
 =?us-ascii?Q?MVJMw21pDmJLt8R+0JMmsApr8ZOsfhIo7b/UJFSzIeA6MFm8rcL4PIIWunYk?=
 =?us-ascii?Q?DqsjDBFBCXKQe1Vwu2K+w/vyq/bsHkbo/KxwCvYYBT0m87tqBIO3GpSdwRZ2?=
 =?us-ascii?Q?4sEsIAusEq7jVB+ld8o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add5717-2bdc-4098-7e1f-08dcede57fb3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:21:52.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilYkBYDE4I11SRJTBgr8QRAnDRCcvzuN7+YXnf7+M3nUF/ffp8d3u/3jkFgOzAm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

On Wed, Oct 16, 2024 at 09:09:40AM -0400, Steven Sistare wrote:

> > I would like to see this patch when it is applied but I can't apply
> > it..
> 
> The series is based on
>   baeb9a7d8b60 ("Merge tag 'sched-rt-2024-09-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> I will respond to all your comments soon.

Oh, don't post patches based on linux-next :\

Jason
