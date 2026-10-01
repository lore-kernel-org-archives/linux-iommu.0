Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C3515970
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858822; cv=fail; b=Q3NNA7i6rjpHCWfsjP+SCelgl04Lrjnbyvzoq9DPPDIKSMgAXA6Ro4G0wGmzVHeYrtngpEedbRmA9QLSIcIQZ88iE/v1EAWlPOSW/FJzEnHLWWE1DWR5G5/foiQ+T09kbwk28axZe1nQdykien4Yoh7aZb8960D6v7nIgbLdxUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858822; c=relaxed/simple;
	bh=tqQIKqhofmo8NvAJEqOLKiQ+dsJlDmDgGZKgSPCchPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Egy2lZalyav2i33hrZB89VrQMs+LC//UTCPl8MudEYvqmXCXD7zIOGtwSN/HBk0A0QxdTL0rjAcigkqBsWpy9Uq43t6Dk0EzfpQH11DBIq+HDLkKxMMuJX0JLBXWMXOzgZ7vbJPU5DC8rbvdoS9CLJyXr464b2bY0jlMli9FNJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ScnHpcYJ; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ScnHpcYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKYZB1Wf7n5qjqEPvVx0TY/mgq3Gzk9L+frWMfDm7WhOMOFz7tCe26rwUJkGdAdqvakG7npgM6jLt1t5pMq3AAS1OpzNQMDEvce5HZQZXokaU9OFOGGa1nazoWxot0rWrJwbCdqyu1xVJhp0xgxPSrV444sc8F3z5c9av3PRoTjRqjS+pOL+Kyz84MV+ubpHd5eVTuG0deR/lXH/DQLmcTsYg92Lc8MjitBDUDZ+xkoA1VE1lrGr8smawK6xh2wobult/DB6E1F4o1d4cMKopHLeZQ24IycHLVs34bLWr6NjzgJfgwiw9B06s1evABhlHpOTwCpFhRE7rKc3s04dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI0e5Xi3MeErOcRG45l0GwUN7kF+FkH4HDsRl74+XsI=;
 b=mNEFpEPjsOByCqCbrEYM8MefLMremqk6utzgugy0h4HXRzwKSxdPXW1f/Rej3bLQLvc6cNNDBYWNXuY90EOVFFVATWdahLnjuG7ZTcRfXCt/spb8wbchZcxP6Ok/ur2x0kJkGgdFAOjTs3xwlHflAOJIYRPNrOCEtlmmYxs1N1AP6A7tZn8tLMp53Mpkk2CDUcGaXzMK8QIS5nKkp3TxmfwFIDSTRjqtiltt8fios2UFVPX4ZljUJk5pFEhmeoySwy0a8JkKFE//lvGbqFHc6ATnuMZTATklezq2nbSEtUk6R+rs6gu3kUzwa/gCplNEzeoh3pEpEGKuO33M/99kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI0e5Xi3MeErOcRG45l0GwUN7kF+FkH4HDsRl74+XsI=;
 b=ScnHpcYJrdK6FJEJMyqlLRtD4saKOdi6vpyR5dyGyIkMnPE7MgI9Z4QElBI5Apx1qTS0/fjSVM4SM5ApFxVJs3tvf9ovVzKzvTTp6uxPaUy7B98rfJqB+rzZiDA9WvphP99nNrdPiY8aqBs1VWEUQf8k4ncH9S3UFZFzxoiXdxgRASJcZwpIWjngbonfKRH6byrW3y8HOWl6q5RJcEqguzOhzPD36NOgrB55tIDD466jg0bTswwtR8YYZRD2oKsKpIaj7ALJKlF76VTopwAIJJT5iuEatN+RPcJI9iq79oh2yc69I0BnG3FQDS04nGt1ZOugcnhM+my+FGMuLCFOAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:46:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:46:53 +0000
Date: Thu, 1 Oct 2026 20:51:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v3 1/3] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <ar5XR0l9WZ1Fnai2@shlinux89>
References: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
 <20260930-smmu-shared-sid-v3-1-8abe6c1b4c20@nxp.com>
 <ar1Q5y/xoa+Fcex7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1Q5y/xoa+Fcex7@nvidia.com>
X-ClientProxiedBy: MA5P287CA0169.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6348f4-87d8-4133-ac3a-08df1fba1193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|20046099003;
X-Microsoft-Antispam-Message-Info:
	c+FUEojFw8ezEgc9SwJ88ws7Z0Dfd8/9AZNdVknmplFaruJ6hJthx7Gxi0SWVT/VYLfAJxvhUZh7sK3oT778zxvDow6ElA7+lePljK5R3ic5e+KBjDfdv0hpvzHasHqGjK/giP4qd14ZeiVmcl4+bK/o4FbLZIw5hhqJ+EEdn/w986vzy0qTzjU7ET7AWFg8SGBfEfC81xJG6pCf/APFHbz+26X6USHHCatUFSLJViXtGDnfhd8vJFdZ9LsW6iky0LX5CoUFCPwNueBmQh7ZvaqFIzDBOkuhi7Mmuy95U5gmPsLh+K52Y9YTqqzDw5ELwAI1qhj6AesEpYEL/w4uNhwF5+EWax6PDzCBTsnH9E/I4/JW1BE8wfZpqSEGUxJumsVUILSCpjKXqIqLPJzPzRKIcSFvEq3HmJSlWlDzECOIZdo4jcSgkeF3DHlGxWDFTUyxVEe+8zq+i3XLRjsazd3k1RS6IbVFb0158tVejSaKgEFeyJHVBwv5fes+VLkJ23uHhQF/iNqYNRSBLwF8NXPa5ZwFlvfmqQatn5oSBqmC3umGz5IWH5kwVUIujsra0VcH2qwdllMourcZ18jsAcCM7cDDBjXsXxL8IjHYsObVTNadS6MeDlFvPbxAjq/of6GO6M98btSBWyhOR0RC/iDHm313ZGqjhVgG1XhxkUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5HYu4Xe3fVUSGb4mUCsATCY6kPfdrfmcIRoOwkeuv1H1LNhl8XyxBGB89SR?=
 =?us-ascii?Q?S4+fyric0B7eskNUrB84pADsaZ6DStjQDcih09kUD4JokpksBWu+ktPBd0qZ?=
 =?us-ascii?Q?aXXh+ZJj60UtYxrXn0+izm669F76OuTIfcN1lty9Re/43110z+kM6R6GwFjI?=
 =?us-ascii?Q?cMAsvUGKv6A7jdgPJEcATHXTp/yuixGTRNcDalIQsBNkglCIRx/7w6WHf49o?=
 =?us-ascii?Q?jIpBWgJx47G9f9CcGkNUVffPgfE7PLyzVh6PCbi/Hb2yk5vprU/au6Bd3vam?=
 =?us-ascii?Q?U7LJmC0FlNFQp9OmLag/cUTx+hdIF3NzY7OHrL9F4bfEROOGYaY8L5ZK8h90?=
 =?us-ascii?Q?BOAVyBWBhzTTHTbD+u6HAmBVTufVYocq7SMXfIrMp4dwzIWUu/bJ676KzfZJ?=
 =?us-ascii?Q?OtgRlyul31zd1R5g4C0998uTv5mNUdeogdzIcmumPhqX4/0sjdiF7RfFVMgQ?=
 =?us-ascii?Q?lOqR7IYPGiIH3bQaxZlwXE92XKSgsCuM73i03sWFrWpH5ZyJnULkD/5I5h7y?=
 =?us-ascii?Q?QkvMgBU/6UCQi8lj6uBa8jaQSC6N3B5CmbyJejktqY8s1bIGAgNvxMUjejbS?=
 =?us-ascii?Q?q4yrsHwoCfXXLpj+9uMl1l/mXo9NML2WPGwfsPMe3I9iuoa/JsUPA5Xg5Fzt?=
 =?us-ascii?Q?Z2bAAmCjntMyGw8znKWhRue3WMoMrqspS817Aj7s68BZu7BH4f9/Y0kM97GL?=
 =?us-ascii?Q?m/YinZRoGJFooQro9SRCF3hq2069J7cfWn2CQmi/Eiedi3G/nDg/Aj9inFH6?=
 =?us-ascii?Q?LspfAH8BSpcsi20Y/VQ6IU6P3xk4JppmmXAYSUzxAqC++s1O86MBrjxo6Hjg?=
 =?us-ascii?Q?b0hPFyayaJGNa+Rjz5IKNuKfhAvsNZwO+nD3kVAgDSyavG38F20hyZKnGpOQ?=
 =?us-ascii?Q?e2ZjE8nI5T/Y3xHs68Lpq/FElDXVsyepGp8++E/hMA+iW6QVjN49ZlOUzYNb?=
 =?us-ascii?Q?2PDHBoVuk67CGSCaEE1SwmNcMEJK+5KQua9ZM4IkiPev7mmYlY5zZH7kKVZ1?=
 =?us-ascii?Q?D7UA4eNzEYqvXU6zi6zGOiaE94duZ7Lj8V2eRM690Gw0OENTRg2mSyo9Qta+?=
 =?us-ascii?Q?RWw9dTPQN2KN5IGhtM7nqbpr4CEeR46paDHpwRH2kKcdABk01JUfci2S58ED?=
 =?us-ascii?Q?AxvC8xpGyr49x96YAZzcx5V53QrJTPNTQ1VOQ5psSo03LYBCc7SBd4dctG6G?=
 =?us-ascii?Q?d+WDpEG/G8e0VDHokvBoTGce6nrVJ1+C1OTjuLvgBtHyhjcSDBv/LIpoC7a7?=
 =?us-ascii?Q?SsSg1m8rcCulk7EU2ozAj/UX9wy8IXqXPB7s6tDhzLrVYe3Bv5k+Jv+YP0mR?=
 =?us-ascii?Q?efv3PksapUOPujS2mF2B7DxXnDp2Yu51+o8G0eEyR79tOAhnXC3CmeQduL63?=
 =?us-ascii?Q?1zIUMuBHuRDsrO/dfNUkHrwwZulqe/MLgcjr6vapbOzRbb3wi5aGO2jncERn?=
 =?us-ascii?Q?lyP/zWUZ2HZaBPGEdT148eOzo3ccj3+1fELZSm/VRrxQYDGZZE92ksvDlVOW?=
 =?us-ascii?Q?0HOZwA2Mj+URbnyLMODZSyEuIKAxEMT4XscpynoBH8CvF7rniY+EXJShZWU7?=
 =?us-ascii?Q?iVraA5Ugbj+Zr7F/tbBRLZTRdggjXyVkbxrEorrehIfu+ggXTIm7DEDiv6TB?=
 =?us-ascii?Q?TkM2TpvrJ3ULykEWv0jzoQv7uaxBtJH/u05aGox4+RsuAgjIkhGMYZ0XfVo+?=
 =?us-ascii?Q?mdwdw5YWCr4w8gIg35gaEX63vCf55eIOquWxjamtAHX9N7oGqs9kFkUBwfCy?=
 =?us-ascii?Q?dJSE0jo7Dp9XWH6s6PCz/CsoZSfq6ApGEDj1exvRk480iqL50bVZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6348f4-87d8-4133-ac3a-08df1fba1193
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:46:53.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrnk/lmYv4kOrBa6tqMb2VA5gshQLoWVoidEbv9h2Qmuk3qZf2N2P//V25uZKnSrMNJ2BG4lvYjesiT19FVDvLlhw/QivZY19ZpsGLjmn8mK5HYTu5CCkomFagbLj4Pf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

On Wed, Sep 30, 2026 at 11:11:51AM -0700, Nicolin Chen wrote:
>On Wed, Sep 30, 2026 at 07:25:01PM +0800, Peng Fan (OSS) wrote:
>> @@ -4115,7 +4128,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>  
>>  		new_stream->id = fwspec->ids[i];
>>  		new_stream->master = master;
>> +		new_stream->ste_installed = false;
>
>ste_installed is zero-ed.

Fix in V4.

>
>> @@ -4136,23 +4152,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>  		existing = rb_find_add(&new_stream->node, &smmu->streams,
....
>>  
>>  	kfree(master->streams);
>
>.. when the owner stream gets freed with the master_a, the shared
>stream would UAF:
>
>  master_b->stream[0] --> new shared stream (SID=X) {shared_masters}
>           |
>           ---------------- shared_masters_elm ----------|
>                                                         v
>                                                      {freed}
>
>This should be changed to the model that I suggested in v2:
>
>      |---------------------------------------------------------|
>      |                                                         |
>      |     |----------- shared_masters_elm --------|           |
>      v     |                                       |           |
>  master_a->stream[0] --|                           v           |
>                        |--> stream (SID=X) {shared_masters; master;}
>  master_b->stream[0] --|                           ^
>            |                                       |
>            |----------- shared_masters_elm --------|
>
>When any master is removed:
> * Delink its shared_masters_elm
> * Free the shared stream when its shared_masters is empty
>
>If shared_masters isn't empty but the owner is removed:
> * Give the ownership (stream->master pointer) to the next master

Thanks for detailed explanation. I just posted out v4, hope v4
is well following your suggestion if I not miss-understand anything.

Thanks,
Peng

>
>Nicolin
>
>
