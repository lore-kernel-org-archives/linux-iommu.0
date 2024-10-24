Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472233EA
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789417; cv=fail; b=MS+DzeQqKD1WtnAqkpfI6hxtGaRcglE9KlNRtfrV9TxXw1f7Xyj1946Kw7Vmw4dpFwSmiRVyilTFZatnSlBmBDM6f1ZoWzgRwqg3rI9ywxPydrFIPUO/Ce7lLt9lNL9O5vYSvxGC0Avikx0H5MNemzPks2MThuhq8VctYitu42U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789417; c=relaxed/simple;
	bh=vFQATFo5a1BytHfyx7JJ0zcf0X4bQ6Wrd+XTT87G96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwKtiO57FtqrMlLJokfh0eI/RQYOPFVvIRSrVaA1/IovquoZ+/1BU5TP5O2jYfygBKD8ONvrRhbF0nycej2gaoMpBD2nUqvyJ7zxsG7BsuDJm2CSXzbqfEYRKcYUa7HAGUdvJDy5aNFr/iNr6I4sbDGUdBM+C5zvPw94Xmv7spk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+8XPtns; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+8XPtns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOQG6DzmEqJRxvLpTE1IPA0CuaMMcVOPcGW+wDiqvuSkcxZbmvR1spfP8HGRZTivz+hPu4Ch5WPJRSRNQlQJhPD3gqFVxACY0ua7BVlFj+P1bn4S0TluRZC1gUYZ7ikDKvAvOa629bc3R+7hYsxfPEOMjYJEk6LDeR7Gg5fXUFuCAIN6bPTMAxld+C8e1hKOs1GVyLTNJzgF3ekp2RcYTuPU4klWuyCG9PdFq2//y+Ix7vJysHYvlrOp6aIwcIpcmOpehmwDvXCZueaCfX2moRw4sTGM5cXdNcevG9q9pWdXmcFCrclmL7pZhiLXzFnX9jEgwJP8V23CEfdOs72H1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHYa5F7e7NtaX1X8TnKanSeKIyRt63HwRb4fvSUKFHc=;
 b=A4OowdhMYqSctl06RiZFQGzhDLN/rbq2VNw8F8uk4LYxIHFa8/xDeisbpAROdiloC31vzhwa+i1qpvwO3Oe6/1AW1lMp0MFlfjDVyt49IpLpcI89GqLAF+EO/dndgn3D3jpmh9FlWnS83V9+5lgdePBFoijXrCJ5532JkpvfwpUphpqLRNskwabGoNIAFhDgvxe9oEe9VjCVpMaPUFP/ADSKk4FS1tPBoZ4HaKhYcZzfXZhy6XalLMg3G8RNPvQEMVgbFbXnKP3yhnw59N618YRGtDrWTRp3e1HFG4SL4vCqEj8KkBHxns6+Znf/kiWLaLnMUo8vDh7beAzIQDhnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHYa5F7e7NtaX1X8TnKanSeKIyRt63HwRb4fvSUKFHc=;
 b=j+8XPtnsozc8/QsCBqFSguB//90cpNjpxHAUs/IUGt9sOMBMsySQdkYdJREHwM9Efy9IJhWSXVKZGZDN/DFpWQaS59k/vvO25E2FXE8d3ovU4bu+Xu5tyYHiMfMMhp+FsVErkj3YDMAWQ1ihDt0O3W/qO5/iUegmIc3M2kg1Td01Xv6+v/XLJz7oQXCWi7JNM5xuC4vXOhf9hquVsuqh58bsRhIxNSjy2yun7qJ5b/7DygUvlfEL1bAvMf7IQdaBSboah+c6ftc+FY4p9NERvRagJ6YZn9nRyDEHuRS2M6pb5gNAVBEDjBgUN4XgHoog8PskafvIl88OHOZUuKqd3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:03:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 17:03:31 +0000
Date: Thu, 24 Oct 2024 14:03:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241024170329.GC6956@nvidia.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
 <Zxp9kHerb-ln4ioO@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxp9kHerb-ln4ioO@google.com>
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a4b9c2-3d74-4028-6dd7-08dcf44dc951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IljzvndNM49n+BVbt1mxXPq/jimj+bEdM3IqleKBJBWmNZo0QBrh5Qa9hmVn?=
 =?us-ascii?Q?dN+ofjoiPN0jZx9l+RDbi3FqqoJ02aYexbQQ0sdgvlIqimLAjmL7Sg1BZdyQ?=
 =?us-ascii?Q?+QMF/06lOPg7U26g0rtlGdZwJxRdtJTCj0l+EQG1P11NUTFnlSVHVu3TQEvR?=
 =?us-ascii?Q?JDDDKfLzdEyfCaiBeMnTXuZrew8gaMzQSTDELJUd0D+Kovt8DEgXXcMo3Cof?=
 =?us-ascii?Q?19qATY0PJKcnr+IbxaRBFk6j/oX4iQGkTqhgzJPOr5JWiDHY+TXi/BOHTSFI?=
 =?us-ascii?Q?VzU9YSRtf6ECcF/2yvS1a1ZKX2bM8Gi+5C/NzR8js7ebh40c1Nr21gEdoB35?=
 =?us-ascii?Q?tLYGdTsi/XyYPXP4LBtP0MoV8ODtWGrBeSHp2WygwzxpY398bMwLkFNZ+mea?=
 =?us-ascii?Q?yUdkFk/Gx8JTtDt9VItya3qfEbXyF/PzVDIZD2Q9A36OSwDtgXuOmXhe1Iv8?=
 =?us-ascii?Q?EZPFgJuSxJllmSfXrvkvMC4axqbE7yLs/tZyktZWKKkoN+hnLhovwcL5YL3a?=
 =?us-ascii?Q?DfpyDyWLFTl57CHtBcHY8xky8V2KSdR5f0AglxUvVV2d4p5g79qKI45Ki2rH?=
 =?us-ascii?Q?duYcWDq3U5NGexX6qNalEL1t7ZVvMNisH19pvUBcQoWoF3Hcw++nebrD4Qrv?=
 =?us-ascii?Q?conBPofSuNXCtKjrHfTOiRIqgrivZgqTson7ZqFiiprx2Jf8rWKCS5qodl0M?=
 =?us-ascii?Q?LEPzily3WgIqg4MVAdm3nSpHgkMLviEyH+pC+cUr4m+Os+2E8zaoCbrALkhU?=
 =?us-ascii?Q?0nz4TBh78xzLcVHUw8WRI6/ss1O6/cP4EIGZ9LjU0P3xJyJ9lK/7eLD25TA1?=
 =?us-ascii?Q?u3HlGdb11EiqO/JQsUJ6kb/p0WF76MC6rwKZVdRHLisOb3uODQv/V/fBe/xI?=
 =?us-ascii?Q?BpqlvAaePjCriO+f2xKjlJXL1nd6CWBKdlDDMcnCTkJa5VqMX3sh7EthaBZX?=
 =?us-ascii?Q?6n5RdpfGu9q620KSlf/Isa/FFey84sWGDSnyUznAtVFXAG6GJ0HxCYJT3wc6?=
 =?us-ascii?Q?PJtezaRVXUfF7nsUpLLorKWsgiRAcrC9TJWYOQVevpIiuTSq3vb3h+WRjA17?=
 =?us-ascii?Q?2prpg9u7+mBmbJqsp6XVEfISC4NDkKf5/GkspqGoAg6fjbKXPO2Dms/SiAfY?=
 =?us-ascii?Q?GJQmIsPaCzhMxjt84Z5MPZ9nfKT554Bx0UP+YN5rBBE9aIAAgUF5r0zPgRpJ?=
 =?us-ascii?Q?6pe+/Goi5lfNfMD5fMt3sTy2UUZa8VuPbljxH2hVL7nwLOdspOknA/56uKQw?=
 =?us-ascii?Q?uIWIoX2Y2Cb5MiVUo5/MkeuOLw9ZSm1zIPrEQRJ7h2oCCOBsFfGWxx2/ttid?=
 =?us-ascii?Q?IJYVgsuyp4AHNuhZN7ktcJDh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7VqGuHxNF1x/xdwy7gx5lNgT8mDKt6vQdBKl30fpgg01sJXws/0qxTKW/An?=
 =?us-ascii?Q?CtIdWrNWmBXgaknbM6lXTdb1/lTqClDm2DsLWADKyY03eiknB7YWl4DQNFkU?=
 =?us-ascii?Q?QNARwepcTbR7yQ25tCLCmloaTHHScswZr6MxKMQTZir4fD5GNY0lCFOXNKAH?=
 =?us-ascii?Q?f/R+rqf5MsJ55htozRtFgEBvAgAlrqVjMIxTrxWjCoC9REDk2V0rU12L19Xs?=
 =?us-ascii?Q?MlOAvSov2HPm6wZP19v60GUrd+++g0iqiLTevUBT2wX4e2VoGgpFD4YDM90X?=
 =?us-ascii?Q?7vuAh9mmz1WTTpjusOeiy0d/AbY4NbIV/GaUUAQMh+iZvAFTxUgLS3+4p9e9?=
 =?us-ascii?Q?RDeJGUOZLCZntjX0/4eMck2TyO7DLxGvsqZp+rN00r4gycwxSutplc8hfJcV?=
 =?us-ascii?Q?zaRVX3vbN8rDZ4kthJOQJbVCquPtY6hcF2gEyl45vR+Z20L3FEMrYxuitIQh?=
 =?us-ascii?Q?5oq9GwkiNqh8s2L7vYhSoxgrtWL7aweQKv8/vsoTw1ovzPN7O3umsM/l2wcn?=
 =?us-ascii?Q?e9XqNKENDFRmq6WtDzEg/gQUOQzscFKX+CFn3zbKXI3B3RotJsDC5q/lj8yV?=
 =?us-ascii?Q?mDe2h6CY6TWMwR4cKZ6ofPDFZ+JMJMtaTUqMyFn7LlM196ORcgdT9aG40J22?=
 =?us-ascii?Q?LT8YOE9/eH0benB3lHo/ml2x0KbCyKpfxMzUJdwYFmj8NUnbHpSI5pkPZk0w?=
 =?us-ascii?Q?UbeQsdIwkZN3Pbkx2giZ2gQsGsKP6uwhkFLueOoXnVXIZjDGDkH0wgTmhI+X?=
 =?us-ascii?Q?JxyC6fw8oyGf6JAtjF69dw2gMuvHIaW0VyY8OznPXFPJEywLG0HOO/+Ogz3r?=
 =?us-ascii?Q?tS/hBF3fwTkhEpim8SzZSv3lQ3R6sP9wOD1+XmtJSfomQRd+Rf/pl/P1/Znz?=
 =?us-ascii?Q?dSWb/traYXjY5Fb/Aj0VJu087FNKPiwVpWWirb01j77TYYF9Qy846G3GUnBB?=
 =?us-ascii?Q?jNoEf//juutMp6eNpqqa0xjTekUAmmAGWyw4RtxMXKtZLuvo1F/sW7UeM4eq?=
 =?us-ascii?Q?W0Nk3Pu/jt/aIakKu1EYBW7yX/5P9wcps7XOFSganeja+t6tn1/IDazOiBwB?=
 =?us-ascii?Q?3zIo2Y7LSUrpAhZdZ6w01MEV/xOv+MPPgswg/aCPdoh2yEqRtLT3tQhGc+hD?=
 =?us-ascii?Q?E7I7NaT8+k8kJ2nNK0YpaQdH183HUOFTIdgWVP+BG0oLNR8xczjVnDhGDAHD?=
 =?us-ascii?Q?p1j95ajLTCio5UQC+uB6Uf+dKDIhG+KuFblAVxU/O1a4uaQE2H76BNQOu/UT?=
 =?us-ascii?Q?EFuNf4J9t8ERcBg3n/CLRpSliQaeTObzsiUYpwHzzIXWuD0C7il9al0QVhiV?=
 =?us-ascii?Q?QX4Z8Kd5+OEVwe1BQzWhP3S4JcylqZvi2k9L7fvF1IxDPQAFIdsPbzQ9ou2g?=
 =?us-ascii?Q?u4F9eTGuxebKjCn0t1whOrJbUZ3ugqQGANvYqnTaFVsemPTnnmgNbf3yt1+5?=
 =?us-ascii?Q?It+xoAdq0SecP2IsxLQuM2UyziA3HhQHMqg1MBmgH0IPpUBNa2Fr6IJNfmpQ?=
 =?us-ascii?Q?ze8ze2BZJF+Er9f/mxtq1WImhvviaJ8stHUTVZdEPQiiIz0Om4qL/Lc8CRaR?=
 =?us-ascii?Q?WxPYPF0uv+UODQLsrgHQ+In4Ic1cjQXcCYE/GiCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a4b9c2-3d74-4028-6dd7-08dcf44dc951
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:03:30.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bcETKP/lE92U9Y0XfHpvUEmu3t27AGOtDwDHHWrKkwi/yll4wrbevr+fF1nUQ44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

On Thu, Oct 24, 2024 at 05:02:08PM +0000, Pranjal Shrivastava wrote:
> 	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> 	bool                       stall;                /*    88     1 */
> 	bool                       ssid_valid;           /*    89     1 */
> 	bool                       privileged;           /*    90     1 */
> 	bool                       instruction;          /*    91     1 */
> 	bool                       s2;                   /*    92     1 */
> 	bool                       read;                 /*    93     1 */
> 	bool                       ttrnw;                /*    94     1 */
> 	bool                       ttrnw_valid;          /*    95     1 */

Linus has had negative things to say about lists of bools in
structs. Use a bitfield?

Jason
