Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96940FD9C
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978188; cv=fail; b=slBmfddLyn2wEm+DREarc9kSi2wHr8oJw98wHm5D+l6a3ZltYWpOGimubyIwZdSqdmPYPza+PBkMjCNIY7KHUyMSgU3KsodmYfqGBoLPeMrGEu/fzN/kK9zzNd/nqyYS5SU2I+Q/j2mnnghD7gTy14w8ILJ/tM/Y7JTaxrPc0Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978188; c=relaxed/simple;
	bh=IvSYOVvujXzJsLW7IeG8ENcuC0rryrhcVTgurELHqLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRwK/k/EkL5RxK/y9J3WV5vFf208qYfP2ZKKgIdQWwCJwjyXOdh2+nhyuosO1kF7UB9EreWBPnfkdbmWTHbKXUmg4E2t9SIdZLV157jzKq6DV4v4+NIBXGdBsAAA4GifHa3uNEiFi5lsvbhgy+1AYSf2tNZddw+3kwe20YbYIio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xl17SJW0; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xl17SJW0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdvFgiHCeewYI6kAneW1Q3b6a99Qob1wsIYgzcVlECWZMVWM+gi8tc2q+dbtQmMnlggbE+RRrD/gTvOp+/kNlCi6VxMEQWT9nSfCWrtHgeiGSa8wunNr0g7wPO62rke3HeN+DhPR0+mGtABMEyAniXrwjJ6fIXzrGQKJL4N2xRvs5ewr//wDHqz47Z/cEVC83h7RR+4SI8OWIkn8mTGcEqtS2dJi5E2FfM8s83sSts4BUFLcnsScihP1gjq5+4D3vehmak04NGLDmH6096gQPg3cKcoCyBL5KtccAG9YlKm0MSmlumtBbg0oRZxFFs95Tcw/9ygOfiu8p4ig4KfBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FucE8Lpjvc9Ag8vWy2wjkijE/+WSO/Rf71woRDk3BLk=;
 b=lM/K4oJVbPHG4/rekanV4pA+YpWTywWJqELLBVlcrm/1E3JvoBhVUiPuv7fWNNl9XZOaq/wiKrdl9qmG8OI49PGG4RBmBcLQqPs4dtw7UfKY7TpWa/+cxNz3Lu7Vqp46w5TZbc2cxwMCIsPNyWQHXEX3guls6ZXd96tNG6lnGhIfC4AmGWtiTHVjxcefNYJcupm6rxZsfBi2lJAlRusLt9oZOI1lO4HTppwU3DzqKA2LFkCXClRYGtn789nS3IQig4gA8+6qSKUybyPqQZI9nyIrMYLVm3OlWwnjH4OB6o/Bdjw0dJoU0sLfxwrFIuHmu/9W8Q6I4eWM/hyfiMmZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FucE8Lpjvc9Ag8vWy2wjkijE/+WSO/Rf71woRDk3BLk=;
 b=xl17SJW0wjlCiBdrFtFLIN9p6ZNeTCGxQ+miJTXll03XVP+MriV0pG0CILsvXljTSMqw0jw/O7nKewsJO66ki0RPP5J1KVeDdUYqwIIvF5ilHL7mR00B0PglZ9YAO5/0bWIg54CzCX6IN1tZKimgWbDkHePeCYqXCWNX8HnDqG8=
Received: from BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:49:36 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::60) by BYAPR06CA0035.outlook.office365.com
 (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 06:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 06:49:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 00:49:35 -0600
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 21 Jan 2026 00:49:32 -0600
Date: Wed, 21 Jan 2026 06:49:28 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<Srikanth.Aithal@amd.com>
Subject: Re: [PATCH] iommu/amd: serialize sequence allocation under
 concurrent TLB invalidations
Message-ID: <2xm4hj576fbs3ydwxcjs732ddax6zze2mmbka3ocdmddsczqtx@ghc7uxquidrn>
References: <abcfda19c05becb988ede3a1a0ba6d87161943bf.1768899638.git.Ankit.Soni@amd.com>
 <20260120092427.00001794@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120092427.00001794@linux.microsoft.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d167f8-ebbb-496e-8f60-08de58b93df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjE2eDd6NG5tNmFRNnVJazEvcXpjeXJVZDNEY253YkpLbFZaV3ErZ0xyVXF2?=
 =?utf-8?B?VWZqbERCM0xoQnN2UXFBZVNGSVdxK1VQaHdtbEtrRFFVN003ZmRBeEJtaStM?=
 =?utf-8?B?cHFKRzU5MWY4TXJIeUNram9KZFNUNnBxUU9oTHVHRjlTbktmZnNRQXFSN25N?=
 =?utf-8?B?eUZnN1pPQWRLRWZCZXk5VUZtbzZnOW9RaHo3QnJyYU9xUWkrY3Zia1ZIcVg1?=
 =?utf-8?B?UWJnWkFvcjZpSTVJYkRFcU16Q0VoTWc4ZTdOVk5Qc201MEpXc1ErUmJvcG1h?=
 =?utf-8?B?Qmg5RjdlMDVtb2hlalNMUFd4Y29JVDVnUXl0MkJOZ1hBUXZld3RaVmd1UVJ2?=
 =?utf-8?B?RUVMZVBBYW01S212NzJkRGh4cW1rWmd4djlPNnVQQlk3c2hsWGtLMjJZWjlO?=
 =?utf-8?B?WmxBOVNRS3VOaVN4OXRWSXloVEpnbExtMkJFb0p0VnJFdHpKbHFReXlLcFZT?=
 =?utf-8?B?OU9Bd2ovVlFVTkIyelZzangrZWFJYTF0QzB2OFpPSkVaajRucVpwdUxTTlo2?=
 =?utf-8?B?N0dEYmsrKzRTV3NWVnBmTzJpVmdRazd6M1VMQTVzRHlDQkRnK2FwVVR2QjRO?=
 =?utf-8?B?ZldNSk5wSDdJVkU4YXljQWpXVUVEYWR6VzBwcG9YenJlMGFnenZBcWh0RWUv?=
 =?utf-8?B?TnBqeUFtNm52RlBuQWd4TGpTVmpVejR4ZmNvUnoxbitDZE9KTDhoa1VTN21j?=
 =?utf-8?B?VXBLaDJCbDhFTitXZU40S3B5SUN2TDBRK1NXeW9qZWNVLzhuWEVBSFdvZ1JJ?=
 =?utf-8?B?bjJ4VEg4RzNkYy9peTVQRStaOVZNeFI4Yk5lck83dWFnU0h2YXVObDNxS0ZH?=
 =?utf-8?B?WnFWQWs2MGhmajBRU05DNVV2eEgwVEhqR3dYWjg0RTN5QVVTcFJjTDdyOElC?=
 =?utf-8?B?TTF0eGhuNzh6L1BoMEdiT1V2QkRjNnc0SnZGYStnckJpU1NPYnRlc05SYXo5?=
 =?utf-8?B?WitCT282MkJuZUkyQzFLU0FJaWVTSzJZUjRnTTY0aGRpSHRDbkNML3JUdjhm?=
 =?utf-8?B?dHI1cysrUHoxNUttS0dQV0pCYllZQ0JPN2gzMFliNXpMUlRMWlF1VW43Q3Z2?=
 =?utf-8?B?QkdNZzlZcTR1emZTUWFMOWJqZEcrUVRJakx3YWpYWTFKbWVTdldHaGhyNmRU?=
 =?utf-8?B?OFcxNjVMQnczQkxNaGxMbzZHdHhMNlhVcXpKcXVPZmFBZlBIWm5nWVVhZE1I?=
 =?utf-8?B?TTBObG5wb3VwSDkrMlNzaGJsMVppOHZscmNSYWNRRVJJdGNXanQ4YWk1THBO?=
 =?utf-8?B?Y2Z4R0VYaGRlQlZqQ0RIYW9DMXN5MFRYNnZsVGk0OGlqQXBHaG15ZWpoSUlW?=
 =?utf-8?B?T3VFajBHTyttU0ZVS2t2U3hubUtNNDVZRnJhVm9zRmlWc3MzS0RPRXR6eG5D?=
 =?utf-8?B?ZnZ0bG8zSnk0VTFjNDl5bDR6d2pJSzFiMUhCR25OSE5KKzVHdUx4T3Btdk5J?=
 =?utf-8?B?OHA4b3hoUlpTa3VIUmhsQW5jeEZ2OVhBME9pRmRxUnU2L3Ixb0NseVF6blpO?=
 =?utf-8?B?MVAybFJJTkNoZ3E1dHhvUnN5SWx0TUFCZEtDdEdKTFpFQjZBeWN5dkR5NFo5?=
 =?utf-8?B?Rm5lbUFaVWdLOGMyUmVCUnh4T1dEL0VvOVcreGtvOEpVbmhXUzZlUmxqa3Z6?=
 =?utf-8?B?cXBlTXM3UXE0aStYVzd2dGFyYmdjdW95OVBUWHpLN1kzdlhHY09CcWVvMmxT?=
 =?utf-8?B?SThnMkx4WUc2RnpSZ0lKUEdGV3hVa2prYkdnckJTRDhnS3I0eDY5RE9HTENS?=
 =?utf-8?B?VXVuZ09XektzUnF4a1pOYW85MTZMTmdReHRrdWFaOGtwOCtMWlZubzAyL3Vh?=
 =?utf-8?B?UnZaWE9veGJXWWJ0MHYrS2RHem1uNU54OVBlVlQydHVxODIzZkFkSFN6S1Ez?=
 =?utf-8?B?TXcwVHlZQjAxQ0tQWFo1bXQ0K2dEc2dpNkFVSzU4OTgyV3BPUTBxeEhiRmhW?=
 =?utf-8?B?Y29ROTRvVEllaWR1b0VxbWRjZ0kvOE9DaHlzRzI2MEMvdklKTXREUklubmxL?=
 =?utf-8?B?Z2s5MnhJek0vek5zSUIzVnVkamxqWlRqeW9kV2RQN3pvQ3BUdUxiVUt0alhz?=
 =?utf-8?B?cHNndDF5ckExckJsVG8wbTdUQWM3M1NOc2xvU3FQZVQ4cC90M3ZSR3ZCZjlr?=
 =?utf-8?B?NDZ1OXlQNXUvaTQxMEhJdmVjMDZwWW9hZXVnOUN5VUU2S3pIRlUwakh2UHpK?=
 =?utf-8?B?LzV2Q3MyQ3lERW9mUE1jaTViQ1Uya3p6VW9WNzVBbFpYYTVUMDRETkkyaXVG?=
 =?utf-8?B?clV3TmhDdG9UN2U4STI4Zng4dldBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:49:36.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d167f8-ebbb-496e-8f60-08de58b93df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

On Tue, Jan 20, 2026 at 09:24:27AM -0800, Jacob Pan wrote:
> Hi Ankit,
> 
> On Tue, 20 Jan 2026 09:05:07 +0000
> Ankit Soni <Ankit.Soni@amd.com> wrote:
> 
> > With concurrent TLB invalidations, completion wait randomly gets
> > timed out because cmd_sem_val was incremented outside the IOMMU
> > spinlock, allowing CMD_COMPL_WAIT commands to be queued out of
> > sequence and breaking the ordering assumption in wait_on_sem().
> > Move the cmd_sem_val increment under iommu->lock so completion
> > sequence allocation is serialized with command queuing.
> > And remove the unnecessary return.
> > 
> > Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")
> > 
> > Tested-by: Srikanth Aithal <sraithal@amd.com>
> > Reported-by: Srikanth Aithal <sraithal@amd.com>
> > Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index d7f457338de7..593fb879b7b0 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -1422,6 +1422,12 @@ static int iommu_queue_command(struct
> > amd_iommu *iommu, struct iommu_cmd *cmd) return
> > iommu_queue_command_sync(iommu, cmd, true); }
> >  
> > +static u64 get_cmdsem_val(struct amd_iommu *iommu)
> > +{
> > +	lockdep_assert_held(&iommu->lock);
> > +	return atomic64_inc_return(&iommu->cmd_sem_val);
> Do we still need this to be atomic now that it’s protected by a
> spinlock?
> 

Hi Jacob,
Thanks for pointing this out, we can remove atomic operation here.
I will change and post v2.

-Ankit

