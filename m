Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404721A42D
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467188; cv=fail; b=k5EtJ5pqNP7Oa1pKhnXCDsvhs3XAQ91khc6LvPyvHvYn1+rKr/Ui2S+gXchtbC8bnUjpKyfRSPeHTCwYBx99lv/Oq4gmVTocQJT23OSTKZFZsPyP30qWl6zPYbytB0OjSktT4rIw56beUSSoTJ5gH3T9yTr9fCU3bB1w5u3r7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467188; c=relaxed/simple;
	bh=fKdT77d1t5yEXM2LoGB3EjsHl8HLu7S5oA7SCeksdDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTWbHZoCrGOBH4bz8I8evWQXRaYBnxNm5Lai4Lr/jF/acQQVSmmQuw9dnyGn/clzW7vBR/ScoahkOYEVFcJn144Nt7lnr3Mn6Fqv/XSi7IJX6G7o5SoYEy9zo6Maj5rdEJwCufgjZXL8AMUUi3SYGkoM0idQdXr/7Bl76zp3lbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z30OVrXW; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z30OVrXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfd2xBxnq0XI7ti197q1wz5VG5aBYVWWKBl1L7Z9+yE603LX9rm3KejOU36V3T9qUcAeOj8m/eEP1ZDTytjABK8bWLUlohaYNIC+F/YozjKIw+DkuaXhS9ClICZ9PyceFCOTWW1M5ip567BYbH1zuEs+N661UCVZw+wPBYaVJghI24hsFGDT2DSUky5qAHB9pTVlHeTsDOBb05KkowFKGmgpMD8wSnd1XPl1jDMUSo2Y3ToYXt4/Tc0Q7e2yJyVu/wInJMoPAKVkA0uu05C3N9hpvICCvGSVQbqxmMz9QJ8f+l5LPstNFBonVKpAw0pthsNEHkwdFHkVF5UzV6xxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX72SXYd4THtPuUJES955yLGvALyUG5n+6Ipx8GtCrc=;
 b=mSS/4rp/8WF9PEb9sW++MGzeYhTA+sp7CoHBaJVq6fPNktqFUQEXGA5lDG96SN6XRYL2YnQtZ8NjGBieVUKJ96Ro4d9XjQ3JbrRhivKycLk8140x5wMnc7y1FPWP6kKkC1MKNWQlNXt3nUEM5pC9+z1Eg5OYCvKv70pdSVY3h5RfXObU1C4v5+kKSZyHpKq2aArGT7FJmj75jcbnyC5cC2tLjWJN4Bs/JXKNYcMUzJ/6xHTyPDAlTB4hKqKAzThxbDnuLrhO8nWmss6lSxkEUE+7ESrFZVosRNhovAF2A7BB1VxBOGUJzRTziD3Km/7/CdEs+vtN3JFYyDAcrPl5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX72SXYd4THtPuUJES955yLGvALyUG5n+6Ipx8GtCrc=;
 b=Z30OVrXWMxah6JnFskQgGqqG2PC+zdKMwzY3gC2nLXX592RuQ7vTFDsQeZwixIxoUhv3UFePmaaOF0U+cnr71t44n3sffJDxu8YMIxNCzge4jPDqwqk4LjKHoHyXkFW7yVgk82BR1MiM9Dy84K8m15cfOIbyZledqra/lLpBZ/WSI7RFwALh0UoF/qFv0XT4wh4LUXJRIKABHh8czIv/Bjcy1SWWbwTcjVfWnGoqUJsPZqSV0ZIZaGVRuOmi7dgmgTBf1rfcK0VdVBBvpRfI0amCO2CQrCMU7NAB/XxTAFCR+f0QUFnNtYB9QF63Ob5FseEhwcnj9bzgbVUb2E1+PA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:46:23 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 13:46:23 +0000
Date: Thu, 8 Oct 2026 21:50:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v5 3/6] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Message-ID: <asefvnqThUeyAEHZ@shlinux89>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
 <20261006-smmu-shared-sid-v5-3-169a59c671d3@nxp.com>
 <asbb+ffdovx+q6Rd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asbb+ffdovx+q6Rd@nvidia.com>
X-ClientProxiedBy: MA5PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa5cd41-b6d7-457a-e1bf-08df25428a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uX8AvAQ6JeXrrpY9y3LmIFLpawHTGmFohx+5pjpzkyq7xxuiO4acPUJnWVqnsQGFsNDaLeyWWlghBgnjges6nAg/ilT4lfccfuH8LxBrVPUk5Kt8UYVUnfdUNSB0Nhjun/npxAOtPSnAot48cD8kp5BinWAX+0Bv/iJmAM+L70wAOkkzWF3nFRTHVxm4xOCEUWA0ZAN1msP3n7GAL+gjJJkhjWrzlkCBAHVZPD5CZ133jCqcc3tQLMSDbZtdyyMTVMBo6Q83eknGokD0xXDfLac9au7eyBCdhq0RdCz+aMRy3aYEXha5aGz9YYM0Dfs4iW3AymHBMNLgrnzmzawrHwpDBKklJ8/QLTBn+8tzx09LYFYs88bZpezTupV3bSLq+vPGVKhVs5mONIoo57TUbBKvQpCG7RLEj0kuzRj8MTRBy/QtJVujpjvUxYDaqcNkjp9vhkEHsXEx44BnmnuRp7uMW0lMXFqPENpD1ufwxI+ybBqd/B0ylprKxde9OWxkrtWVieeWdeWOU+YGbPJKIY0tMbr4DA0QM3S9E7lDW6G1tz+pdqa0P68uB3UJpuQgEKEagHgfBfKVlzka03fB5+6avSEWkmE9hHtExYHN+NgznwvWEBOI1leqgrC64i7X6bubvPPQJjS/Sl4IkI8cjco4rhLcAwf06oDRRpimDQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p/vLp8I+4laxhenM4tuPyA0k0goW1mZ3tHcR8ISA0e0uoDShwGxZtrsv/F02?=
 =?us-ascii?Q?dSXp9WIGwgly7YOwMEBEg/CVMlDSHLS1bGi2ESP2UVWtv4yIHuW5tjzOqM3K?=
 =?us-ascii?Q?R+xnPk0N/xMG+zqb7T7bEZiiM2Ezn5g7YJZFotW3lvNoWNy1rayq/RIKJAwX?=
 =?us-ascii?Q?wFTTHoB2VNTRQRX5ddBMBtn+hiW7gFPe9WpaqKWgNHNAFTfVaKZmbJPhwgoq?=
 =?us-ascii?Q?rySbdFseG3kDMMwNYPHv14cBg7M3whB41IhHUwpwhvY1Phd3VbV5kX3iGYtV?=
 =?us-ascii?Q?oqCgeNugx7P/rr4jKRRnV51gCBtfmLlHjPqvvnK1434y9AJtV2wsrdv76jKn?=
 =?us-ascii?Q?nBFDa0yqHftVu47SktmBDutaDsYlqE7yFGNhavdr54sdXrMpnAoNl0njXr/l?=
 =?us-ascii?Q?7aIdry204XLxBWMcZ6FWsdXnBk504tClOWWogOZE1/MYO3Tx+bQtIO3r9BX6?=
 =?us-ascii?Q?frW1fFJyaABjyJI1jzyx15vAWrsE++bwshCGeHLBZUuIoDj2YUtLgA5FjZPJ?=
 =?us-ascii?Q?IcLHN2FFaUpHyh1qliJLshCjJFmDZx1h57h8m56Xv23K+MB2UqTDH/Ylqzlh?=
 =?us-ascii?Q?NimC6RVQgLuIeeHAE6NA51Hj14YEovfXa9u0JxdN+kEvAZg/Xfon7puconrr?=
 =?us-ascii?Q?78HA0JbpnlomIUNw1iBfjpKdKKOcNqGB5MI+B8J7KnaO0cqW84GJqnhh7jX0?=
 =?us-ascii?Q?aCTvWq2OM/oTeSSYcL9ctT8/9oQFtD3HGnMuPPKd78RK3keY0CxW0V33oIf4?=
 =?us-ascii?Q?jrypuoe39FoqWjmVlqTtGJJvdRY4HHd/wOG9hT/JS/KLDR/+4m98P9sz1jsn?=
 =?us-ascii?Q?f5WbdttB3o4HvYQwYhkqId5VP+3WcBXw/6/ahyciWT9qSv4EL9qcb7fRYp6H?=
 =?us-ascii?Q?yeqFqBro0aNukJdkKcLG1tSd9Xr6BcoJyTO/zCiZAHglmNaR4YpKOGTITQHl?=
 =?us-ascii?Q?PBz9pb6Bkv8pXfhML0czS7/GZjAske/CkWW19OrZgIvKsjUJi/1tr/n8mocs?=
 =?us-ascii?Q?sGTV5LgTZZ5W0yUmzEplh0nLIWd/pnUpE/hxaxQiGrJhbLRZoXwJiPVZhYHX?=
 =?us-ascii?Q?DFmC4Gu5NqBw1ufntmbrg6WPYoIR6gghXQgGP0wfTv+sZ55uwFWeqB5xgkex?=
 =?us-ascii?Q?R4sYUil7jyxXiYFEosIDeCpevmFgAkHPV1+dFJXTCd9pKmbFto6YN5W5czSy?=
 =?us-ascii?Q?GXl/qh3Jt5X2YDncm3DneDnfaDJpckMangt21NXsjpC/VUDtA7G09SASuYkA?=
 =?us-ascii?Q?FX1HLoMmLrBHLzTvBn6JTo/wWVi+9u7RWMFxAjBH/qcnrxI0EyBKSQ9VA1rP?=
 =?us-ascii?Q?GQNNl5LB+Lfy6Dh4Gvydxh1BUQbSrwvU14y6uFs9gicP0JEB1RS25GlU0JJX?=
 =?us-ascii?Q?+rk6agLb22Xcy+YKSlPgrG3NIXgplVDPkhOeY1tZPoBsole0CzgtsauR0kG4?=
 =?us-ascii?Q?EhgBc9hZ7lRl4MsAb26t0ONjuD1nQPbov7BPDogAAuTkBDYLlQIucHLARxP0?=
 =?us-ascii?Q?4P2g5cKV1pmFxZP0lvCtt/haA8mPfN48OxKxR0qajpqtV4EJCNAoWVLnql/H?=
 =?us-ascii?Q?iNy6HhSxkhej1pVbsS2S/RqR19anpU/O92q+Te2OPHosShXnLGJ3yOB57dRk?=
 =?us-ascii?Q?mPrRLNmTfWtXVFHGdmSKzryuynPp7IxXdjNInpIvX2VkjPQLPKrOAwaPXujh?=
 =?us-ascii?Q?wNavsgJV+3HvqlXJQiDfKkKoF7dI6/9e/aAjO2b3M8utVFWAoM2yuzy9Bn0+?=
 =?us-ascii?Q?AVbbeCCX1fHjgLaWhBx30UmDy3GBtAsUMQ8YDUtplspcgK8lph7j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa5cd41-b6d7-457a-e1bf-08df25428a6d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:46:23.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +neoVyLKSJDJocY9cedT1615qyuAfYyYJdKeYECUWLk/WdPoccHl/E7dv+pVPjWmbPqA7b6SmR7adV4Os2ZLAUzKtqNpxZmRif2mdiH+cY4VNAGegT+VcepmQACWXR3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

On Wed, Oct 07, 2026 at 04:55:37PM -0700, Nicolin Chen wrote:
>On Tue, Oct 06, 2026 at 08:19:09PM +0800, Peng Fan (OSS) wrote:
>> @@ -4110,52 +4110,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>[...]
>> -		/* Insert into SID tree */
>> -		existing = rb_find_add(&new_stream->node, &smmu->streams,
>> -				       arm_smmu_streams_cmp_node);
>> +		existing = rb_find(&sid, &smmu->streams,
>> +				   arm_smmu_streams_cmp_key);
>>  		if (existing) {
>>  			struct arm_smmu_master *existing_master =
>>  				rb_entry(existing, struct arm_smmu_stream, node)
>>  					->master;
>>  
>>  			/* Bridged PCI devices may end up with duplicated IDs */
>> -			if (existing_master == master)
>> +			if (existing_master == master) {
>> +				master->streams[i] = rb_entry(existing,
>> +					struct arm_smmu_stream, node);
>
>This can be cleaned a bit by moving the arm_smmu_find_stream()
>from PATCH-4 to this patch.
>
>>  	if (ret) {

...

>> +		}
>
>Add a helper to share with arm_smmu_remove_master():

For both comments, I will address them in V6.

Thanks
Peng

>
>static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
>{
>	struct arm_smmu_device *smmu = master->smmu;
>	int i;
>
>	lockdep_assert_held(&smmu->streams_mutex);
>
>	for (i = 0; i < master->num_streams; i++) {
>		int j;
>
>		if (!master->streams[i])
>			continue;
>		/* Skip duplicated SID pointers already freed */
>		for (j = 0; j < i; j++)
>			if (master->streams[j] == master->streams[i])
>				break;
>		if (j < i)
>			continue;
>		rb_erase(&master->streams[i]->node, &smmu->streams);
>		kfree(master->streams[i]);
>	}
>}
>
>Nicolin
>
