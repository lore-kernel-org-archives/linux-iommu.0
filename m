Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432161ABEBC
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346326; cv=fail; b=ufR3CxSB/40QXyfZbP1zqztGcXKvKlK13gLvUxEK6JVXVIa1ElbbdDQB8eVwe73iVk7+2WjMaAvIBlLCKsa6L5Z38Mf+PKjZ8yPFJmxZhyx8/LwKhGibofd++kjwgIOvF1ff0E6p69j1Fy5J7Ps170v7AxRf8dLvj8I6YScj94M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346326; c=relaxed/simple;
	bh=WAul2ro57e/KsZ1YgFxO+Vw1EXXTO9jtRUTTWnYxVpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0gtXWqwI5NhvqmwJpvUPD3lSyZY4bSIca5aLQGl7NBAsCll/4aM0tMGr+Oj2mdh48F9pXXXs6BW8JUV2TgzjjS1XMJCKUzwYINzEuwDx+y/drXnzsOXL8n10Nhf5ahSm2xHzmxTdJycfersQuQCJFIwSXViPnIji22nFjcb+ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aIB6OnML; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIB6OnML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6pSujgfiT1kB717DcJNWW5Xn74g9haO8Jv/66xv4R19VeDhy+iPGLgzbZiffjgjB+zDQ6/FxwTxKA8UsUYB6Pq2IWnY1MScE9riNVWB7FRnmY+s+pdgHOK0Rmytgsyt6O20xvX/Nlh6c756G6q/Pcqpedme59KPG/KlC1vX4QYNJXI83Zd+0o+/QssTe6Im9+ysXjdQOWJhMUqGjbySyjOFa2z19ZANsTRi+sek37atA+1BAUFFmo++8Y0K89jPK0EUMqINxsElYoC7WcWpExGLDFWYxthbOaiYcRcRELoDgir6cjTbYHqKhgzs6TUZuZQlO69kAQv64Ux/ZUwQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B/56EcTxER6mR27bB1OIaj3ly/cnoVejVlGrsaaO9g=;
 b=ioAyhFfyJOOUweVUMAW+q9EM+r4vvaa035lPMZTUMftw0P5sm9dEB39o7vataoRAdBe0nUnXIuKBsqCiXYrsoVrzwQnCOC8478SQjKK4Ey3OyuBcBRO6A2guTQE0ybwwGj6TU3nrkOH8ovXNQ9Y7Cdrs7p7J1ONecmcluVYieEYMIncgYkxM/rvydBlbuySvGjCBvoVCQJck+hHfHPjt47MnObscP9LmhbGScNrJEF4j0kigo8+s+poafoOD3LHkpiF0oWklSDiQAlbb8yM07diMu4RyjsYyhgtdyCms8PnwtPrs0JRDhvrIspOH+JQ/9cFSvqZ1Mv6GXIOQP683ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B/56EcTxER6mR27bB1OIaj3ly/cnoVejVlGrsaaO9g=;
 b=aIB6OnMLdjntpbwq+EcpMZ3yn0MSvZsqmynQClwZUw2Z3a91nLjHx76xog4S9EryaxAKBRfljvS4lTKiOzMhXBJGseKe6bXykU94wXsW8WnAFgEu9yPUiOsM5Pl11D4dtiWtwOP5AcRHGepVFCAMUh9uzWmwgt1HeCsiigSjTIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.21; Thu, 26 Sep 2024 10:25:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:25:22 +0000
Message-ID: <3b2c5409-b9de-4769-8276-fd7c85009fa5@amd.com>
Date: Thu, 26 Sep 2024 15:55:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] iommu/amd: Pass page table type as param to
 pdom_setup_pgtable()
To: jacob.pan@linux.microsoft.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-6-vasant.hegde@amd.com>
 <20240913143945.4499e7e0@DESKTOP-0403QTC.>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240913143945.4499e7e0@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8afe21-7d8b-4323-553d-08dcde15873f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzBYVFVhWGxFMTZTeG1NVVUyWkFsNkgvc3JjclFudkhSR2hIZDZSdmY1VGdy?=
 =?utf-8?B?akhVa0NrZjd3VTh2VHpVN0VzWFNiSVArWTA0TVZFM0gyS0tyQzljUDZzOGZx?=
 =?utf-8?B?SlA5WFRXcVZKNUxNYnVZYVZaczlUa0FkUGxtWDY2MDc0TG80YllydDVRTi84?=
 =?utf-8?B?azdKR0tucFIrSUg4WkVXQUVHWnZWU0M2eFBSVEFkcUF3bEhPU1RaK1kvQzU0?=
 =?utf-8?B?WmFPSS80M2p1Qndta0Rrd1prWFpqOUZPeGc5Q1dZNTIrQ0xPbFVoOHRocE1w?=
 =?utf-8?B?dVFoeXpHSWtaTmdjdzVQZCttdjNwR29oaXB6d3ExOVlEMDVkekIrNGZsMzA4?=
 =?utf-8?B?MURZOFI3cCtyYjlkenlKTFI0aWptMEt0eVlvSDhtTzNxb2hRNnpPSkhGd3U2?=
 =?utf-8?B?QVRZbTYvNDJTT2hFK0xsQlFOUG4zNGZBM2ZyR1E1Y1I5UE5ncFlkS2Z0TG5H?=
 =?utf-8?B?RzdNQVU4TGpyMW0relFTT29sSko5ek5TdGptQXVqUjJQR0E2ZmlYT3J6c0tu?=
 =?utf-8?B?Vm1tZHlZTDhyMUVoNDNOdUU4eWxsRWR6Tm9TdzgwUm1PYkRJS3dVczZwaGZ2?=
 =?utf-8?B?bUxydG13Zk1seUpURWRPQXc4RURzTU9oZUYwcWw0U3lXMDd3Yno2bkFiNks2?=
 =?utf-8?B?bmVsQUVXWkw1NmxZVEZZSXRzdncyR1dFZmFackttbmVlWE5wOXg3Q211SnhM?=
 =?utf-8?B?d0ppSGVobXFrSHhieWVyV1RMUDR4azh1V0pISGRmeHhYM3A5TFhnTDlMQStP?=
 =?utf-8?B?OWVqdDVrK0ZiUUdKZUlxei9XNERoZG1kVlFuWlJNVDNRaDBUSDhVVXdMUys3?=
 =?utf-8?B?SkF4MXdNY1JJRElLK3NqYk9mdXJ0MFp6ZlVLSitqemZxRlg2ZWs1d1FvNHFz?=
 =?utf-8?B?cTFScldHdHRVR1FOaXQrSEhHRlpRUy9VU3F5UFRNT1pUejNmSWZHTE03eHhh?=
 =?utf-8?B?YlIwczVzUmVaemJLOGZEUW0xRG9yVFhrK09mbW9LeFFJQXZ5UzNsM0xMWGJY?=
 =?utf-8?B?V0V2YnMvaHJTSG1iV1NnK29DSXVOWjRzS3dHNlRUZXBVOURuU2RvVEE4WGFZ?=
 =?utf-8?B?bHlpc0Nqd0lFRGQ5NXIwbDUyejYxQ1hVVG9CR3BqK0tTOC9zNzZxMlRUcWVa?=
 =?utf-8?B?Ly9OUFJUMS9QcnU4NnJETEFoODdFQXZJSnVwZnM2R2F3TldSc0s0bGgxNnZw?=
 =?utf-8?B?M1hxVW9EYTZhSEhZSGtaVC9OSTFsVTBlUkYrcUdVTWFlNVdDZC9raElpZytM?=
 =?utf-8?B?MG0wbUhOYVFYZzZVazVhQWlHUUdtSXBlM05BdHluV0hVdzJ5NzQ0TDJROG81?=
 =?utf-8?B?ZGRHWnZaNWRrU3JRempWMkMrY2p0eGxlaFZpa1FMUXR0L2Z0NHNMVml2a3FE?=
 =?utf-8?B?MGkzR3ZlVWNPMTBTeDhCcHAzZHJOMTlEV2VBaThBUTFBWEZ4Tk96eGxRU3hw?=
 =?utf-8?B?UWFGWXAvMEd1UWNqQWpCdHVCZnBjZERrSnRGTmhOMGtvMWhWRXIremNSbkxK?=
 =?utf-8?B?VTFncDZjYVJMZExOUzVmUTlGZUJibmd0LzRhMkNTSVBJaDRpS2JqejJPbzFM?=
 =?utf-8?B?N1BpVUMzNWx3R3ZtZU9uUFQrd3E3TnczTnd2ZmFWNFJlSkpMK2wzWEFseHhW?=
 =?utf-8?B?ckRmcUxjakg4RElyS2w1SjdGRUkwbnBlUFBNeXpLT0hEMHBpRzNBWTNuVmVX?=
 =?utf-8?B?aVFkN1Y4TE5Ha2s0VjlhNnNvVXpGQmYwNFYreDJUODRHdWZ3Y1RoQzdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFwb3FrTGFZYVcyMGJRTlFRWmhYVVpBQUVHY0hFZGxXUWhJNWhEY3FWY3Nn?=
 =?utf-8?B?K0prTmQwUDRwdXpGcVNHaUZLQ1phdHlEWTl3b3FkNStma1VDclUyRU5YOWRG?=
 =?utf-8?B?Q3VMSTlIaDZERUFjaTJFWnEyQzMrZU1SSmtvSUJIRnBsL2RkcVpiK1lPSjk5?=
 =?utf-8?B?RXE0b0dSQXB1T0VrY2ZYVFdRYUhxbFQ4ZjFQaFVpK3BnazJWcFhkZFZOeTNs?=
 =?utf-8?B?RzZQUFVwaUM4a2M2WnA0dVpoamhjWFAyWDNNUk9qNzNTN0Q5c0ZPRlpYT2xx?=
 =?utf-8?B?bjlQRk9NK0s4UlFXYXZBbXJpbFpyTlFMWlJFczc3dUUvR2JXMEdLMmdpb2gr?=
 =?utf-8?B?SXozczNXT2g2NGVuUGtTbFJreFBxZnYxVndsVWNtWkhla0lGMDhnb3dsL3o5?=
 =?utf-8?B?bm91d0NLZ3lxZCtCbk9qTVgrWkNaWFVvazVKcFZLNGhacGV6MXpxaHNYdHg1?=
 =?utf-8?B?cVI1TmFBSmY0ZzVBb0RVb053bThhWGJFNklmM0UvcFRDYnRrTzdMbFhXbUNl?=
 =?utf-8?B?Qy8xT0Rxd2grUllNMGEzVFVxL2x0bXdPNXpDRjdtNUdBQ0NuZys5bGZZYkdn?=
 =?utf-8?B?M1lOTG9LdE1LT01OTEhTaGJCTlZPVytKY1k5YWV3ZHh1dDZ0VGgweHdUUUNx?=
 =?utf-8?B?OVg5SWtTTjBIVzZlU1J1UXhJWW9uc3RpQ3BCcHpRK0VkTmE5WWRjZ3JBc09U?=
 =?utf-8?B?N3hOdGNnK3V3K1ZzSVh1YVpkZ1Z2dGxVMFlwNksrRytOVXlJaGRpbXIrTUw0?=
 =?utf-8?B?TnkvcDVJQ25NTzc3RDlJMTdPRUVGN1c3S2tod1AwbmhYenRpd25VVGNJdkxO?=
 =?utf-8?B?WlIvb2Z6UGUrQWZPZjNUSXFLa3I5RDRERzBTRHVuQ1dlQWdTVUxyejZxTVJ1?=
 =?utf-8?B?TVRkK1YvTHV4WnBZayt0YkZLZUw3SExPamhRUm5iOXlXclhXamhvejlvVDZv?=
 =?utf-8?B?SUd4RzZqNEw1akIwOUdIRTlDYVVuWTQzeEZpemNHT1ZZczNLMVZtSElIUDdk?=
 =?utf-8?B?dnJiNWhtR2paMHZnQnZoSjMvYjlZNXJycklJcmlxRFJ3akFaNndyWHRoZDho?=
 =?utf-8?B?WWVLK0dLaUg0RFYxTzNDK1h1aXNUc0hjNDN0T3hidUsxNnJQeDlvdXcya1dy?=
 =?utf-8?B?bjdjZDU1Y1Bwc295U2dvcnBqTmF0cVRvMitkVUxqUjl0bE1SUVg3bmx3VE1u?=
 =?utf-8?B?dEt6Tmx5a1pTWDRKSlhJb3NTUGl3Wkx3WVAyWjNPU21NRnRhcWFJNFpaNUNx?=
 =?utf-8?B?VmkrZExxeXkrZUUrOExDZVBVYnR6TXp0a1N2Y2c3ejlvUzJ2TTh5cXJzNVJv?=
 =?utf-8?B?SkdQMU1IakFlK2g4ZTVteU1pT0daMzJtRVhPb2FGRmJIYzdhZnh2Qjlna1I0?=
 =?utf-8?B?R2NiNjUwdXBHTHh1NjdtQnNhUk1renJhcEJIbER0bkE1SFM5VHVhcWFjQ080?=
 =?utf-8?B?UFhlMUk0QXBWMWNZeXRlRUZTNUR5a0JTSDU2dEMyVUFNSnFjcjA2b0d0bWho?=
 =?utf-8?B?TWNSWnJZN3VRalVFZFczekhYOHU4WVlmTGJuaWRXdjFsSmVQUWVMeWV2SUtH?=
 =?utf-8?B?NmFONHQ1T3R2Y3pnRXNFbXRPZmh5cjd5MnRSSU5WZ2ErdFM1bHh2Wm1yY2RZ?=
 =?utf-8?B?Zzd0bVZ6a1ZpUy8rekJZczVuLzRDUFBiYWhYQ2ZpcngveVI2cEcvUTl0bjhV?=
 =?utf-8?B?Z2J2UTlTVUg5WDBCTE5ZbDFUSmVBUjIySVF4eGttaUVTaE1sTXpnMWhDNTR6?=
 =?utf-8?B?cHZPTmpCcklSSExDZWJZQUNpcTRTaXNZUXNMVFN2VjVDNFJ2TkZXeWZ0SHJK?=
 =?utf-8?B?c1crOTNIVTVic2xDT09KK1NHZFl4TERvMTAwaUNsVDlvVHBmWXJqaTIvZm1u?=
 =?utf-8?B?dkJVdzRxU2NldFJ3R0diWG5jbVB5KzVpOTNaWkdIUzFQaWdSNk1haGZSK0My?=
 =?utf-8?B?cmJDQnNFOHRzcDBWanQrLzhQbDhWV3E5YlkzU2VacTNLRmY1WXlzZkpIVWNH?=
 =?utf-8?B?UVFFSkhzdEw4aFZXcUYrbE1rS3RVMXRiMWc4eWlKWkhpZnJoV2o4d1pGVkcx?=
 =?utf-8?B?ems3ZHFVZkVXenNVN2dCS2ZJdWd2SXd0RU9iN0lUaTVFY09NS2R5QVUrQk9H?=
 =?utf-8?Q?Hijbp3p51RdbDO51r/f/+Ll/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8afe21-7d8b-4323-553d-08dcde15873f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:25:22.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeqLSmOuJ7AkgH9SFaLDUeTs/Uo8N3e5e5qk9Vtwt3UZjcCu59XoBBaHpNhSUEFOExp0rKtpq/KQXlhjaCBhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

Jacob,


On 9/14/2024 3:09 AM, Jacob Pan wrote:
> Hi Vasant,
> 
> On Wed, 11 Sep 2024 10:19:08 +0000
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2285,28 +2285,13 @@ struct protection_domain
>> *protection_domain_alloc(unsigned int type, int nid) }
>>  
>>  static int pdom_setup_pgtable(struct protection_domain *domain,
>> -			      unsigned int type)
>> +			      unsigned int type, int pgtable)
>>  {
>>  	struct io_pgtable_ops *pgtbl_ops;
>> -	int pgtable;
>>  
>> -	switch (type) {
>>  	/* No need to allocate io pgtable ops in passthrough mode */
>> -	case IOMMU_DOMAIN_IDENTITY:
>> +	if (!(type & __IOMMU_DOMAIN_PAGING))
>>  		return 0;
> Now that you pass in the pgtable format explicitly, I think you can
> delete 'type' parameter and move this check to do_iommu_domain_alloc().
> As you mentioned in [4/8], pdom_setup_pgtable() is factored out for
> setting up page table only.

I could have added check in do_iommu_domain_alloc(). As just kept it as is
because eventually we can just remove this check. (Once I fix SVA domain and
after having global static identity domain).

-Vasant
