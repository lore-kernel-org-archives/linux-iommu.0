Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201817E0
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 05:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9goHsLqPttxULUZ+96eEXNjIR/uq1O6UTOJ5e7YWyd91/539PiRRveQZittRGDNWrkubZJ57eHsjDpE0CEfAElzJLhsBo56CqpKiR9XpfguJ1X9WxDmhv89y0XJ+l39+Jw0aNPTSO9wsahkuvQ+1N6RGC0JOfCP5BHZft0PNC2Snl5mJzbxoV/5ngy/Y/g6lXkJciiDZIAtqPEkxFVvDU1AyKXYAVj0/D9y5EqeJ2+LiaUzs6pL1iLbBXeY0bfLU+x0vraE5unWWDlU7Lkk7ucTdGEq3aRp7sQY1YAtXbcpHT1FX5Xw61g4BZYxdXRs4BUOuRaioFvTHnV6KeX9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXVCKa0mOnuyUJUMMF/85f0acjWRl6KKZS5Zc2tHG/0=;
 b=PNGz/pBYfkxkyaNfo/sVeCH3GpS8una5+XdhK5vNvyQlMeqF15flw88kKe7OtJr7hoQZHhUB7xpLtvmdG7GzkZ6RDo6AVMMCG69HkrwyaAkDPCWeMj6X31BpXynluXiQG1mlpccj43U40clMG2eLJci0tSZcY28t2W023Vp8oM4Yq6aUtwpIHw7tzMC1dQP4Gt+z9AJTGcOVji3LigztXapiHO4vypoMXyO6CRogIGqQQw8R/aZCYD1CsgVF9KbUYWxHYs0KKPAbQjFSxHBB9wqNouxBol6anVdbkNy3nZNy/zkcpRKJjW0anSdShlUcBRbrafVIyYgZWhp9NnJYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXVCKa0mOnuyUJUMMF/85f0acjWRl6KKZS5Zc2tHG/0=;
 b=Hmat26SKaV5K70qcsCF6b6Xn+nE+54iu+PITcpD1/cvBsmLemofP8CULDJCLYYfPfyhfAXt4iB4rFPLRJtDEn/+BOUsQJjnlAOy5+g1dykI4TiYxl2kb9IoHPioooARmA1JvepOV3NDSe5mqQWq4X+zDR2QM3jWx6JujOlxYo1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 05:00:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 05:00:10 +0000
Message-ID: <13b8b3a8-4dc5-7e61-4e0b-f545a3679a8a@amd.com>
Date: Thu, 22 Jun 2023 10:29:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
 <ZJGQsWXkgTuj7xC1@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZJGQsWXkgTuj7xC1@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed0bfbe-0103-49cc-01a2-08db72dd8df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fcmNg7gmwHllWSF/9TWIUg3/JJL/Z3wH1RVI64kfcvSLyqXZ/Ab/Gge9Y3rB/GctSoh7f7HvMH6uTebuk8GViLG8Uasi3B6TCLjpNjK0RBS3Ul/wbBgppxHssvtYU5LId/EWk+NLLYpSCKD/ZwwsHWLrhDH3U1oQG0dQMjW6y9s6x9q+lbbCiSS4673EBwKysJmrlz5v15hWTbbM/dss3YnRN1aJDWzbvrwlPWu/5yzQdWYSnxDK3c+eyowzoA8jNFRje0CbUHIFO8aiV4hSswS8xChJqdqwTAZ3xOD33UTwOTjWTusnjfXt6aR8fBtq85VdwL2NCRwf6RKVaN6P2K9Lt4SDe1Mook3DiC9s8AzqpIjn1hGC0oL7cTzy5Lw/gQIPcK3k+soFywhP+fb1v7VhNXCkRRJiuryF2lFCyCg6UBw+0TcwvrWxyfr305pcSh46rcMVshPQYOu3atlFOBrkWmt9cZHsJJ99HK20K6BnITb7H/NxCu2JXBmXF5Ftfe/oTFlno8PSiDrO4g2cpDw2k27FslyqnaGyq112d6GH/4fLvKyY0Soqsl6qd/BLAVOG6byyPKwlCb7VblEAUNUD+dq70bk9mphK1BSnTgrbdf+yj2oB/4X9hHXnTpZTu/iwrgVCFU21wl33hdF/Sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(31686004)(36756003)(38100700002)(5660300002)(44832011)(8676002)(8936002)(41300700001)(66476007)(4326008)(86362001)(66556008)(66946007)(316002)(31696002)(6486002)(478600001)(186003)(6506007)(4744005)(6512007)(53546011)(26005)(2906002)(2616005)(110136005)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVlMNi96d1ZXSVZtQ0FEeEp2YVRaYXRocHdVaDBVMG5GK052TnBaa203bDlI?=
 =?utf-8?B?MExENDJEVmRHTzBqT01GejFleklqOFBCL0JGeG5MZUtEUWl5S3lxaTgvdWVR?=
 =?utf-8?B?VzdVN25YUER2UkVURFRDQjhrOEJuUXZWRk9MYnNEUTNsYzgyU0pMeUF3K2pS?=
 =?utf-8?B?RmdhcWlwMjY1WWY0U0Z0RVM2ekF2Tk81QWhUdlcySFdhdWczNkI4dmFMRDkv?=
 =?utf-8?B?U0J0M3VueVFiK09ZcFU0QkpPV21JcEdZUDZXK0tLdThWRm1mRkIvM3pGS0hL?=
 =?utf-8?B?MjhjckZER1gzZW5Kd2NPQUZaaytMMytIYVhqaFhNVTB2L2RJMVI2Mmx3ZXV6?=
 =?utf-8?B?NUJ5VUpqaE9jZ2VHWHd0VHFnYmg4QmtDeE9wUTNxendzYk5LZm9xSzdBNEVW?=
 =?utf-8?B?MUtzNGY0UnpoaHRFV00vdFBXTjdBUVF5cnJkSnRod2ltNVB5bzd5M0U0WnNV?=
 =?utf-8?B?dGNxTCtoMlFQZ1dWeno3ekkyQzRLZ01FTVJzZ2l6TGYvY3NMR2JCUklNaFRS?=
 =?utf-8?B?c2N3NUF0bm9nbmM1K0U3ajlQSmNRdnhsZ1RHL0pWSXNmeUN4VlA4d3ZmVzBU?=
 =?utf-8?B?VCtDQ2FZK3ZIRkQvd0duMzRaWkFUOFpEaDFkZlllV0F6OGZSdG5vR2dBMWJL?=
 =?utf-8?B?Y3JFWXZRSTJTdUkyS2JtRWwwRlpka2RnUERTRWpsMUVSRkp5L2lQM290bWli?=
 =?utf-8?B?N3cxRVVlQ3NpYzdJRWtpcUN6WUVXNnphS3lSbmVQRlFGbkhUM1lCUDFSakRu?=
 =?utf-8?B?TkNFUE1Wb3Nhbk5meHE5bmNDbmxJRWc2OWR5K1lOWmk0SDU5Qlp2aVlyOTgw?=
 =?utf-8?B?Qm9pUGZJWFAvelV6QUhiYWVrZjd0MnJGZ3hTdURPTjJzRXd6cnpyUmNBOWVk?=
 =?utf-8?B?NnQxa2k3Z0twSHFtN3R2R21XYmFWV2VwelhUZTVheU53cU9uYWEvdzBmU2Q3?=
 =?utf-8?B?OFRJTmx2MlZFbE1sZXhBMHNaQmZuRTBHUWtxSkZSR1g2a0E5V2tSeGU3UG9D?=
 =?utf-8?B?OElBbkgzZi9IRXVxK2tiT3VNNUU5OUR3TFljWjl2aHhXZG1rQVpnbzVVOG0z?=
 =?utf-8?B?MS8vNFA4cHFteXFyMlQvZnEyR3cxNWQ5U081RnFTc0R5OXVKTUZUN1QwRWNa?=
 =?utf-8?B?dTl6WTk4OGtNUXRMSjNVd0JEWmIydWsweDU0NU9vSEprdU1LK1MwVjFWSEI2?=
 =?utf-8?B?LzNXQnFiNFR3dkE0RisrTC9FVjdjdzBCMTUxYzgvbk5FNDRncEVoRGVxOVpG?=
 =?utf-8?B?c3RsQ09aNW5EVEdNS2NEOFFYTlpYTFlvMWNMZXB1aWNuVmJzNklsWnlEcUpZ?=
 =?utf-8?B?QldWaGFkRmsvaGo5K3VCcXdwQjU2OHBlcTRqNFFHL0VZbHluNElndEV2U0tQ?=
 =?utf-8?B?QTV6UlNNMzdCN3pKSDd4QlRZYjNoZ3kyMG1mcXU3UTF2eEhlSlEzb0o2OUZR?=
 =?utf-8?B?VEtqK2twZlhoeE1UWFdTMCtjYXFMaTVZdnB3ZU5DaDcvSWI2WWNmSlFheUtX?=
 =?utf-8?B?ZUNqN3RIcVFpVHJwOGtiK3l2MmFEM0dkT2J4TS9yLzdOcVQ5MjNPaVIzVFVP?=
 =?utf-8?B?SUxvTWVMWlBPSlFwYjlRc1RhNndIQXZTVStMTGpnY1JlQnROdldaTG1raWto?=
 =?utf-8?B?bk1Va2dQdzZScVlmZFhQVUVkaC95TFRZMlRwSTRWS245SDNtSU1jRkV1TjN3?=
 =?utf-8?B?WGhseDJsVldHRFJra0l5NDErM1R2T0Z1Zkx1ZG5KNGxiM0lyNlRoUXhDcHp2?=
 =?utf-8?B?K0FGUzk5Rlpwb05VSFYvdTBjdjBZenAzQ1ZjeWhnc3IyRkEwWk1XSjN3Yith?=
 =?utf-8?B?a2grSFhwekFOSDBOV1hNQXVLenMxVUtFeEtNQkRmblhRNk1xbFRlT0QxZVVQ?=
 =?utf-8?B?UGlWcDNMendUYWtMVGcxNnViU29IWTRLdkJ4Mmc2RUtwZWJTS0d3RVhrTmlV?=
 =?utf-8?B?cDdWRTVqM0R4Q0FXbXVhVEZtdGZ2ODA1WGpaSFZHL3BZTlF2cnlBNjJoYjA3?=
 =?utf-8?B?amcwaGlKMEVFbkFMV1dncnJHQTN4TitYclg4UlpxblFYYktBRTNsWHBkMlhC?=
 =?utf-8?B?VjBHWVg3a0syQUR6a0oxQnBiT2M3YlB5UGVvWmxFSmxjQis3OGlhRW5xR2pm?=
 =?utf-8?Q?GiYUL48xj/kPOLq/F+R2HJ1iI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed0bfbe-0103-49cc-01a2-08db72dd8df0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 05:00:10.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V68m70DjcMelvZEbtDDgIw3p5g7g50Vm2PRfvzySTzQR3zg7EOZ37c/IQsqL7td8AqDWRi5FYot8r+wqhjJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Hi Baolu, Jason,


On 6/20/2023 5:12 PM, Jason Gunthorpe wrote:
> On Tue, Jun 20, 2023 at 02:31:43PM +0800, Baolu Lu wrote:
>>>   err_restore:
>>>   	if (old_dom) {
>>>   		__iommu_group_set_domain_internal(
>>>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>> +		group->default_domain = old_dom;
>>>   		iommu_domain_free(dom);
>>>   		old_dom = NULL;
>>>   	}
>>
>> The err_restore branch doesn't work if old_dom is NULL. We have no means
>> to restore a group from a successful first-time attaching to NULL
>> attaching.
> 
> Yes, this is what I fixed in my alternative version

Not really. Even your version has

+err_restore_domain:
+	if (old_dom)


Only first time we will have old_dom is NULL and this functions returns error
code. iommu_probe_device()/bus_iommu_probe() handler error path properly and
frees resources. So I think this is fine.

@Jason,
  I'm fine with your version of patch as well. Are you going to send proper
patch -OR- do you want me to respin?

-Vasant
