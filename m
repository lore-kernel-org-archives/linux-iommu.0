Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EB1D3638
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640709; cv=fail; b=InYHAT6lGfiK8+y+7oecMIvxYFHwUlMcxOCCt+dgmbMHaIUHxNToLQbkpK8dVYRBIxgx0BKm/+M/xjALkl46/wqpo5x1Kn+T0f+WajzGGEJoN8FFz9niA9TOzDNy5/7PpEfMU6/ZVjK6JQvXaCC/nSnd7Ahqf54lD7o/lNy34bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640709; c=relaxed/simple;
	bh=0utlssiF2+TZxkkQN9fOaTZKnTjmpo7sHTuAWGwZHEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cViTh91rbBkcivRZ+ing87zzx76Bt9H0W4d/5SlV5O11/8SJQOAWgs/0S+3pNLyMu3G6WuIdM9eGiTsnd/L8cPkJhCAjdeJPeslva+SN3BUIVSyIDKeFp7yhkfNrCs8qkeGitbc3Zf0fRu04MdI4s6pZ1KbJLZLUvVtme8W6/fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POH+XU6u; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POH+XU6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8uU32NJ7ikon6WtYZPAfQ4eeP3jGI2PXyLzyyXm5E7Ps7uncE2+a9HLzt86EkMRwfXqWxm30DXEMNGBAGiAMmGnfqTeyVct+HTt1UipwHXZOuwhKnqvC0yzmiSx/Ot5ZxYehsoLkDJQbQXxwcBLWjCS+xABD1f5qmk1YWNfeWfXmdL3WvbHsVQDpjHQdgIpyib9UoLsnwckt4RGd8vX3KY1yjlB3BMCB04joQuWfhC0qNsycPVV78w/YcOC3NmySuLW9EiuczBziRuD2LMbFBMaJSg8mw4Jnqb8s2kCpWXpgTpJEw7LfKpNpvbg0tSaY24NFpohMMiXtR2T7qHs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNvP9reWkgp6qoNYWLWBf9DnPGkHv5bnterm6Snfp2I=;
 b=qvEWk1d2HdD7EKToe2ibHH+SHkvObHtCbx0QFdWSyiadPEpCfUD3VI/8wvw6tmEDiuy8HAbQdlJQLzreFPL/nk+cIEQ6nH55rZBe2rZ5iEqCYxesiB/oDeHTZntzJ1GP0QLDzYwLZVdpqxbidV5jT6+E2KWgW4uyrXrmCRwhUscimir2uCSyUtkaRFfR9iV3z8Ak3j9gRr6sfl3pv2pUBAkGzFyR0Gnk9W7oZfAEPKTFpMkdrFVtrkO/7ZhglnEK4PIl14XXOMmdICYhzpZ1/UDWvRW5AzMcHN+LTx8vaoZYcAz/fLBtkUFN8bn43OMs7yaQqO7/R7jjJ1KBERqRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNvP9reWkgp6qoNYWLWBf9DnPGkHv5bnterm6Snfp2I=;
 b=POH+XU6uecd0wp4ggrL+yzVwgrYyQI4GVfSuTSlrtSTP1IP0rc9fn8ttH+oqAWppAdswU7UlAUQIh11QuKL/DLaSAiTpb9zsB+8hSd4QawAocNYYGKl0OOsyw+K7sZDsPE+7j3vXQyV+BC0/aeRtDgnL0Xnhq59rlknR4+394qCkJlYt42GmT57FOIxrSkWkge2ttE7G4BS5ZEKOCeBkbir9Ud8OITJ2IBj420IUTDC2M69umPz5sSwOF2Xkkow5k5qulF5f1fAz+mMigM4PEMo5w+QcNDYw2h9SajP+8xq7XUCTlEtviEECwia4mseautx5TWQwgiSIiVD1iluI0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 16:38:19 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 16:38:19 +0000
Date: Fri, 6 Sep 2024 13:38:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B
 feature is not supported
Message-ID: <20240906163818.GK1358970@nvidia.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR20CA0048.namprd20.prod.outlook.com
 (2603:10b6:208:235::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1dd0c3-4a86-4933-e294-08dcce9250b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEmhhHb2GSRAIVmyMe1do7DXMaW3vyAl/q45zddPbBeC8b+E8yNsqiswBaeb?=
 =?us-ascii?Q?3GYPJ8Got58/tpNKPrmxwFggFKhQP8PGBH26sWFe7uwQNYFhlnz82NXVUn02?=
 =?us-ascii?Q?Bg82Fki8Ti38jF5z7gutCggU5r/bSdEBQgy6ynTpF5a2ipWaKf+VMVeU4tpY?=
 =?us-ascii?Q?CSsJwWc1HBTipS/jtpNqTgWyUwnedmdiId61VrcJa+flzfw+gEc7O5RlTSYT?=
 =?us-ascii?Q?silnF8qtoIhbkfPGVtCm52/RlMDgT63LOQ+8y7xA7ebo52FCLWP/YJpAVV9x?=
 =?us-ascii?Q?yZGoGbUapxxR699FCoLM8dC9icUu8scSy2zGfDu7AZ5zpyZhrCl3OVy5eZW8?=
 =?us-ascii?Q?2Ck7X4AMJnJqn7Zzme5T3W4V/eaqmL/B9qnH0fT4B8Hlt5wQSAGKrNWLXSP0?=
 =?us-ascii?Q?z+HVBAqQr2/QxpOxC2Ezv/5/YBpgNjjEgvBudSb/omUuqbPby08KRz+1zsMm?=
 =?us-ascii?Q?dIbutPVDfYL7aNDt0nOtW8R9j9jsz+NgUFNZvSLFL/Y+JLfRHdOyxSm60sNX?=
 =?us-ascii?Q?5MNBbyfIlpp9GEo/gjGnyloJS4n+LILFcEeMNLCHOECHywFGqDh6wP1i+zaK?=
 =?us-ascii?Q?UsFP5xvx1lG5CSF9Gv8zdHAydhku+MWZuOxrJKw5Lp/xm/Kxdjxhcq9EQGbx?=
 =?us-ascii?Q?3k4iYcu7x794J9zILCbItN1iPtIMYy46XS1Fong5BI+sxgfQYZOhHPMmg8ha?=
 =?us-ascii?Q?v8Pw/jkHKTL1p7dwst2Kgl00thThpc3/imF70TKMIYE8PArt3AxjHdh7H1Et?=
 =?us-ascii?Q?8AnDNDEeyjHRyIdEwnF/gzOlmgs9Nwkr5RBnlz8564l7NAbSKCFkogTEdXFo?=
 =?us-ascii?Q?CGVeuIGH1Ubhe5xKd9WDq2aD0OL8frIsq5nMYDralnXg2RH5uRhiiLFnpM3N?=
 =?us-ascii?Q?tssLzdGT6nEPtq+8FJPjlFSEId1Ln0N+eVW3Hn87lCzSM30inUqpdq/dI5Ve?=
 =?us-ascii?Q?w3cA2ZRzv0amq/TH62NQm59mPbsCRb6q6V8+QyQhIyXPmedfO+LBhnPyD5C+?=
 =?us-ascii?Q?BNpRt8azQyY0WGmG8yvXJqd1n3izFeVLHwHhL1+ferN6ahZ7DoAiuglkhMDE?=
 =?us-ascii?Q?v7ivQqU3sniH+HzbcqpduAt640Mv/Nzi0+5owmIofenMls6iHbc6Ycf2fAyX?=
 =?us-ascii?Q?b8ZZs8IOKuG7rpFyKjIJ7P9BZ1yUd/fig1mHYXSh4t/eAlfmWgcoBdpVbsVS?=
 =?us-ascii?Q?2BHt0fcvGyx3Bx10s/mGHMXIeXMlpM2jwX4TPjZmAF/gM03FuDbdmxvmMIuY?=
 =?us-ascii?Q?N47md8tlJitgfvCvGqq+WEscfEIfMwpl+nTZ8B9AZ+Wq85q/SJQrc8aA0sHQ?=
 =?us-ascii?Q?qnENMriglgAF+9aRicYk9E3RvbhSHM9i+q+lS1aoryX4bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkO/Ze4tsfD7vO0X3QuA24d87HHymKuHyiBu8Ah/PkTKzPhOh4nC2dXvpVHn?=
 =?us-ascii?Q?8kkqJ4EolSVvGFkKLDSJTPUhwMQ9PA88ztmBSgI5KuHzCaiRRHUvaDJLXNgZ?=
 =?us-ascii?Q?KaZOdQnBsY0yd97fAGU/0XrC/+yvncR1C48YVNAWy+P5/rO171PeTnBelfDt?=
 =?us-ascii?Q?E0G7GjyhEGgn+4vUOZUhn1YHEqDyhhqQyt18w9Q1CjSON4CN8aaDD0IqO/ms?=
 =?us-ascii?Q?+PtrVJwuWyFAqtvVl37Lj94PYMYjhoHkXqcGF7ceq053ekdQQ8CnQm9CJAO+?=
 =?us-ascii?Q?hVdURV16bQEGXdqizl9arWrS1kYdADKQXCllGKsknNR0RPRX/XAr1/wpoXfI?=
 =?us-ascii?Q?a4ZYgyzVAGjfeV8IpbkmJnaEPpNh8ZkXUnXfIyNi9V2DpmNgwStxKyjzEfIT?=
 =?us-ascii?Q?2ASc5q2yMraLb6nupCsrDIdNJx4jMyzLjjPXozSGDzd5iJ/4u13Y2gMWVRlf?=
 =?us-ascii?Q?PMlsScsHZF3dZoGoIWYxJafaxjd9xFKwkTY9xugNJMqSuTMzjEolF3hN+TS/?=
 =?us-ascii?Q?BC/5fgIs+SB/BBSDROpkRranD5aEjdR+lcO9E3sMzr5mLlau4rJajr9373qz?=
 =?us-ascii?Q?Vb9uLMmcWkbsPg8cqiZEAD94I5anTmIRAo4yoSRxcuGqb41wGmrFwS3sa99k?=
 =?us-ascii?Q?LuIJA3ZPRQgWhA77d0AuycGTbMTibUmLkgFUuwzLZqsVoolmAG8G5WHLgCil?=
 =?us-ascii?Q?FNxj0r70TKm57X3EdeXta4PwDV91Phn9r+BYflUjpzfssKTs10iKpiwQSoef?=
 =?us-ascii?Q?Sax0wjWMiZddluxl4s9+HiyP+9Afn+XaAFzBR4XWr5RBbMIsUjt4JimdhKtr?=
 =?us-ascii?Q?BJhT1wrj8PEAeZLhjYLx8QgvLThWk/OsaqtLPkAydNwZwaVZO/kyHo2elCmH?=
 =?us-ascii?Q?vxk54LaPtq1GdqvSn1FmcQM4wBbm2Ad9b28kE4VfDCagrCzKYeH55+sUg8mZ?=
 =?us-ascii?Q?rck8tmAHlriW4T4ngDfwk8SVCj8WU0lTAV69YUF50KJSb9vwcuIlqf6GLAnD?=
 =?us-ascii?Q?d3y934sSHWyZvqoq6wh6oCAkJ+ZklWxGmXAcruegkk5ZX9ZvBtJPJxBaNCTj?=
 =?us-ascii?Q?S4B9CCwztI7lkl/ty6CKvAfZAbYs9aOOG19JzeD9PZXQptzAJ77bbwFx4Op4?=
 =?us-ascii?Q?P14YPO5gezxmaOpaMQnzxa8gT547Ev6YP/2t54p/ylUS9fOHm1BpGcya3E2I?=
 =?us-ascii?Q?e2xvAPFnQ/LR0kqjEvrQvb8sE5KFDeOqTZGoxfHBmym0tMDU3bVlRfbxnltp?=
 =?us-ascii?Q?53kpFNjq05e9jLQJuAic/aPAA7LdlOV/APqJIvyaOjn52Z4UN+bYZw+cwEh8?=
 =?us-ascii?Q?ShEMWVTeFsnWtBCMKkSsbn91xkQ94xVf6RY24Hf8bB35rPcJCFcAEKdhV0Wi?=
 =?us-ascii?Q?/a0t3jLOOsOdMmtAHjDJ+c705PFmwzlqjoYCt6naff4o4PRteMVi41yItenU?=
 =?us-ascii?Q?lTL8puNT0WJUEo/OYsZwJGNn7gqZAHSfmSlOEI1TNWBS2zia0RP/sfQtGGkE?=
 =?us-ascii?Q?cMQLHZsRxZobCkcsBcrVDMCiq6Cx+Leu0S2hAB8nBHvIezKlFFOo3GG0wEKQ?=
 =?us-ascii?Q?ZG8GiPuecDHYx2SAdutlbuRITR9TMqAdq8WR+G5T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1dd0c3-4a86-4933-e294-08dcce9250b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:38:19.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOX7+qu+d+WvOsxGOeVoliIY+mJPqQycbCTF55Q9g3Cc9q0OSKwY4uHtCnfvejXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Fri, Sep 06, 2024 at 12:13:04PM +0000, Suravee Suthikulpanit wrote:
> According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
> in two 128-bit transactions or a single 256-bit transaction. 

.. if two 128-bit transaction on the read side is possible then you
need flushing! :(

For instance this:

  IOMMU         CPU
Read [0]    
              Write [0]
              Write [1]
Read [1]

Will result in the iommu seeing torn incorrect data - the Guest paging
mode may not match the page table pointer, or the VIOMMU data may
become mismatched to the host translation.

Avoiding flushing is only possible if the full 256 bits are read
atomically.

> It is recommended to update DTE using 128-bit operation followed by
> an INVALIDATE_DEVTAB_ENTYRY command when the IV=1b or V=1b.

This advice only works when going from non-valid to valid.

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
