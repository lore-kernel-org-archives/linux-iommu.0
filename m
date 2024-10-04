Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA981ADFEE
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073247; cv=fail; b=EOgzPYqaQKz+YDJytFtp6hcUCZ8Lvi46YiZItBoAJ/yVxWgQnkgxfLS7K6VXjpAf0U84UXlfhKvt1kOeqSrRWIEhIhQ9+7nm7lWyJvSIl58KnERWMmnWBE5ZB9T7rLJb4ZLpsWGeRt6kzYbvHZ8fbPunLxLQ3esB7ouhxRrhcfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073247; c=relaxed/simple;
	bh=zSgbMIeWKZ5hwGzRtH2V++BOgf5ILDwc4NqSVsA8MuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdzeDumlomcWt5eXavpgPeb7BE3qDpFw/dVpvTE5EiLcef3FFCy4cA4joMFrDUEmxe1qE9bt7G4qrLuDDMSdfUWl2ISfH6ml8Y5oUcbx0bgh5dBl7jB4vBg77CAgyFFBev9pZ0KzkMRX+BTyHH8zDofN6DII8yFCpsimoZ5Ov20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9ZJdGiW; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9ZJdGiW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyFlAnT5iqiJ+waI0TV2chMp8wk64ttu2YfKt76ENZqWd68WwRIRsHKZKZoTyNRZnSbNjdn3b5Qp6nEM9NyinxMp+gpRq76q2baLeibJDqbuH/0Cw2VligHO77nZl9s71xfhbfD1cF4Z9eE10T+XtQyLixJi1LVrbDyk6cFAyPkdfC017HSNTZGTxQJq95NQ3A8b0KA9bKH5Z+GzwD5tk4jw/dr8Zv5Kgx1L1+xGIUYq9UdhhWUfh8O6/6ah7hBqxcmEmd45Was93lpm56JSge5YLf7EHuNDHZRhraFJUHjL1DuE2/vQKeD2rObw4Np1gzn7jk0wVtVHp7bixV9xQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDcrUEaN/13s0zI6eywTutbvS0Bqa3P4m1dEK/ogB0=;
 b=qNWEgrcui1CLhp7trum6v2iDsYqBc1lnCNSFCsMqbQ38y8SFSDzVsU2wSObdrSc+ss3x2MpSaLh7jyWVqZDzpBXqEuNp2tPpt3mRun4KNbuoyqJ+QhoubUeD5d0QB1JC59ngNOUdKuI4dAMx2JIJAYYfxgiPSfU7FgG5BjOE/AsYMNEyW7QAzoIQ2t1Uyb/xKVYIUvFBaK+ShXK8300UNAf9UR7vouTMrOf0m8+JP/SjcI46DqF4jQvsRdotaWzS9nrFVcpWVaaj1kYwC99uo8lLCbmlHiAwZ37c7BVa8K+LznGmBE+drDAUdtBEBA2BmqoUlqmzBBjYg/i570lynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDcrUEaN/13s0zI6eywTutbvS0Bqa3P4m1dEK/ogB0=;
 b=M9ZJdGiWkQCj01FBoPHBbX80gMBnNzLYQ5NzjFN/Y8SbtfWwGey285F7oP3tfp7meKbvVYa0xJ+vUvHDQbLVmUGnLQSeiYOr+B8Q5erGox31JmhqyeDdXgjvCpwsmnWRDCcDXUvuOid+LPZCTzPBDqqIEDmkPKfFy4Ulvqr3KDQ/TMjXnHuRcCThojYAbyU3C40ptSiCqfMtumVXyj6VNdWHHpzgKvsqm9/Jv8gq2m/ajmwqztG7HhKy96fdPqnzEjHSbfhfg3Pnf24b4E7h2Asm93nvYLAdyYU/FF/akmvdymyI3t77OkU4sbZt0ki/t9b+6oWwsp/k+0ej/joliw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 20:20:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 20:20:40 +0000
Date: Fri, 4 Oct 2024 17:20:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Message-ID: <20241004202039.GL1365916@nvidia.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-4-git-send-email-steven.sistare@oracle.com>
 <20241002175109.GW1365916@nvidia.com>
 <c5d6690f-e743-4a69-9b83-20d5515feb2e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d6690f-e743-4a69-9b83-20d5515feb2e@oracle.com>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 449a2482-f961-495f-d223-08dce4b20449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPIVPlYlNUec2fMSIg5iRvAVyUKkscKEPrI1cj6CukuGA6ZC5GAPEgU9khPJ?=
 =?us-ascii?Q?+R34q1URbyGPdKPkIzIly3QOFgvToV57mBZifnerKNR2/z8Cq/EiH75CN82D?=
 =?us-ascii?Q?2qcb1xv/QLgELBNfWsNl19uMn4BtCntF9s2Agl7i3s9e3VlUlSdK8IfnEiNB?=
 =?us-ascii?Q?SpOx/WQP5VLDQumoOiIh+L6f1paLpzT5B1i6qap/WXwJ0j3iTPhX8LeElhzI?=
 =?us-ascii?Q?bumB2/MtNIg6M2k1zP0H5gHKJWwsmKGhl+DMDrwhwTaVgpTTmvpJKjPQP1bk?=
 =?us-ascii?Q?YKkjfz2t6AX/+BICLsTscVvnbheRlncLoto7q1HgMwI94Cl2N9BA+a9Sqr+O?=
 =?us-ascii?Q?dBrSLUjvQPbIi2ykxYct8Jmkr5IvH0uLrMpg2zB0x/viawvLZro1blZtXM4w?=
 =?us-ascii?Q?UfJI7dbdoTMmv5Q/U3KSedRJQdSGUJDn0YVJYElAL9ORCrT2U7xbg+RdxJTJ?=
 =?us-ascii?Q?Tqb1vjtge54wpAsueJNUzrh0ipyBB5X+RbSeLJzWGA163T+RbDWsUkpRpQzn?=
 =?us-ascii?Q?FOSpxAb28z33OUvfPPoVwemPq5R5SdYo+n2QNLK4/oEGCFlrYwPfmv8Est/H?=
 =?us-ascii?Q?VA9PdkLyeejuU2MLC0xBLoHq/ZUlJSPSlInOc6th1HkIXxBB6VKmvi9tyQpR?=
 =?us-ascii?Q?MsIGwuO66KGSlZH3szmn+09RFee5NIZEZyU6+McrflH11nMKBtVfBzow4qr2?=
 =?us-ascii?Q?IdSiuAV/jKqW9WuUBreucKpEL2795PP9XlZKUWKch3rlsJeJIGh0j6AsDrvp?=
 =?us-ascii?Q?9DFWnf1YhzR1tz6y8wd9AmQPKKEgCYeTmIlEvHPk2zmYoMbJj8hVUmWb23QX?=
 =?us-ascii?Q?3z2LuJs2Db4S/cP+AF1TOE8HmNWl3yNfO95fHW5+FRZNaDM4N6dYDntiOOV9?=
 =?us-ascii?Q?U/vdzM9Ot/lwOs4xpck4IZISrrDAHgF+3SvGlz24DJvw4E96IFAZU29J1tyK?=
 =?us-ascii?Q?2/EtR+cp0j1QvBJCyLCrcDzXFtNVNMJAK5v4jUK09CapvBIYhIHW2LFp3qn3?=
 =?us-ascii?Q?TIgovE9ZDa0P7vIQgqxdvZFmzaW+S6ufTuE3POCPzRRb29a84YSIPDonnMzT?=
 =?us-ascii?Q?lg+Vwte8Xr4bCo0EtJP/IafxseY1fWYzexPM+vP1w+3RVtns+QfodrEpzB4e?=
 =?us-ascii?Q?iPbegM5jkOcB7kDHecIDZY6z1kmpN57KScIAysKufPjAhk0U1y7rzQPPIaxE?=
 =?us-ascii?Q?5t5VPHAABDxdfiVAVB6jsSQiL95szGcWmVBaO1r/1RdI0A8aiSYOO0cPWDqc?=
 =?us-ascii?Q?q+kmYArE6DeKqi6md64yYPZatiUVQjUpN4Ew6TXhmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVOk5KgHunNEqs1h3hgn2ZNsByq7lC8rDszGfDUcaqEQJEz99aG7Zwdwhz5O?=
 =?us-ascii?Q?Yp0r7hBgr7fAh9uIQ2UauLydh6YtJW4QreD0EFkq4xpUhCmanc+L6Pyf4eyQ?=
 =?us-ascii?Q?mLqfpsFKygmDBJZ/rf70J+xeLfuf/2wO6ggTRtBF0WL1RwUmecPdCuWV6wEX?=
 =?us-ascii?Q?A3Q/e8080pcf7ijZ7i+lKRM9w+WEh9xcyQVQKmY/uao3Y4JMH79+6abMLTtx?=
 =?us-ascii?Q?ztf1rH6VnXFxQVQyfjVhkszyGhDmC0ze7sMA6R5+5bdMjbK4/UlIeIqOZSDS?=
 =?us-ascii?Q?JTP7lRq8TGpMT9QvJwsXmHaAXFqPXfLV2KyNVW4OK+VSQL/KFZTDUTfIMIPP?=
 =?us-ascii?Q?x5Zfe6djUdhli7/S9aRYTj0fQgSDSajXg6jepoldoeCT4/m55BXQY+ko+kAP?=
 =?us-ascii?Q?0e1fWBo7F4TGwqgcFIIOneZfDSYoaey3uFs3lFSpWS3Poh8YhkcCza0XWaAR?=
 =?us-ascii?Q?OApA4QsrtSlryCQXR81Hp5JIi3ueMqGzGBxmB+blz9P4IYB0TZsso5t7Ups+?=
 =?us-ascii?Q?qmUad6ZA1wivcq3Sj8lnmXObgP2XlY5ZKZL5g8gXROH+T1+taAZSi9Vu4JXc?=
 =?us-ascii?Q?4+7Ajn7LjFotjznvsW2YHDlkmwpZABH3ZW4ihF/jFXi1PD2FeK7CsL2ukLHS?=
 =?us-ascii?Q?//E2B1wVQygcjqjq+FeISpucvELM0Xp3MyCh7MZn1F3HXfSm92pwRvI3zwEp?=
 =?us-ascii?Q?EW0xBJyAp1DmuKPoHMb6P3/bT4n0U48K0uGxtHBnyFduha1pfrVBYbi1Hfz8?=
 =?us-ascii?Q?/iQFHKGEK4WkclekSnXRXjBe1S0R2aLeJJobf/QEeAvICbHKGgQTQ9vORsNt?=
 =?us-ascii?Q?VpNBrRXpNOagSuJEJKa0hWd8X0XOba1svU2QlZzMcuy2+TplsztjgVoODJPE?=
 =?us-ascii?Q?dMHNK2t8CNawDxBJBTRgYRzQXvTKfqiIN+kTjTL6VOWVnXkQ4cAUAEOR2Q/n?=
 =?us-ascii?Q?+6jIpfRBdHDCGCdIxeX5xihbBg95SVxeSZRXAn+CWGkyyJpEuMgnRbvzZgTj?=
 =?us-ascii?Q?l+IksEZoSL3wWBwX7P2crTRlUPnx28/TF0ViU5l7uJUhh5MSENXJOmPx7kxH?=
 =?us-ascii?Q?hT/iqeaupcNTbVMc+ZKoRgSJNyffXdaNySVp5Z5gMkJinNfp44StwMYuL4AL?=
 =?us-ascii?Q?iDkTlGLBkMoqpTWuzH36vEB4aM/AqBz4GvCPKzfFX9+yo1Ngp99Wx94B1dmw?=
 =?us-ascii?Q?4S4gzHVstK1xDmqYZA+MnUn3Xs0Tit2S3LmWGVR2SZuIo5p6d3DhqzEfNrlI?=
 =?us-ascii?Q?7NGxd+TtucK2SrORKC0As4wB4pE3WonrNPAqoyNYSkkULJrN1S49T4aGhVqZ?=
 =?us-ascii?Q?BTBgh4ridxtfhTCBC2lW2G1C1s5turrVALiKRp2oEhFXepUvA/odOyf99ZaH?=
 =?us-ascii?Q?b5K552NQfJQi3D+ZSxgWWOIgKX6sklV+nPkytY/3+Y+Thn/YJrkPmg5O6V3S?=
 =?us-ascii?Q?jjYXd015VSmRsSoM5qUH4HSg4UUR0qqm6zIYwsvFElGB+srHzi1/UPMtvA/v?=
 =?us-ascii?Q?5OTFiLriAub9R8SxSMQX1GqdYR68Kse/HvEZ46ontGnUqooK4RFXa10qsYWx?=
 =?us-ascii?Q?RIVVVjScAMeGtaaYbg8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449a2482-f961-495f-d223-08dce4b20449
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:20:40.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IRQR7JZ693Vrg7mFbTlh15XwW5YHWwoes6FV+iMyh1dHC8ozIboMvLlMiZ7+wf7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

On Fri, Oct 04, 2024 at 03:43:32PM -0400, Steven Sistare wrote:
> On 10/2/2024 1:51 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 26, 2024 at 06:53:47AM -0700, Steve Sistare wrote:
> > 
> > > +static int charge_current(unsigned long *npinned)
> > > +{
> > > +	struct iopt_pages tmp = {
> > > +		.source_mm = current->mm,
> > > +		.source_task = current->group_leader,
> > > +		.source_user = current_user(),
> > > +	};
> > > +	unsigned int account_mode;
> > > +	int rc;
> > 
> > This seems like it needs a bit more protection, we shouldn't be
> > touching pages that are not set to current otherwise it will corrupt
> > the counts during the uncharge?
> > 
> > Maybe the whole operation should fail if any areas are not owned by
> > this process?
> 
> I don't follow.  In a typical scenario, none of the areas are owned by the
> current process when IOMMU_IOAS_CHANGE_PROCESS is called.

Oh I see, I didn't quite remember this all correctly. It is OK then,
you are taking ownership of all ares to the current process and it
does correctly de-account for any prior area owner.

> be more efficient, albeit in a less traveled error path.  I'll add it for
> symmetry.

Yeah symmetry.

Jason
