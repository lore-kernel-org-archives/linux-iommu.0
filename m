Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAD8C08;
	Wed, 24 Jan 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091467; cv=fail; b=pdWcL+kxIFcCwDi+KU1ngyIyzmKrE/HhN77THr4ptG5MGXlCPC0sBD+URirGVX1NYwqYoUnFYpDIDTnKPlWSA/QTId48wcJBU9Il8c0Ll/VVZkBRRSNHB9MLPI2afJYM1XwvyPMHMtAL5B0TwSYQTxq1LOXeJaMGfj7pPBdZ6eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091467; c=relaxed/simple;
	bh=m2uDzLbni6GFEtk0kSNFNI2yPYihF4oLNBN+AdMTZ9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2pkJ8aD9+/+Y93z6T8Jmm+E22zzcmQGeKRVmBYY66oUqm+NyRfS+h/xdwJenltJyJ8lpAPM6L3SdukBuq+Ch5o8D1PUzzGERCif6D0LyGT6BDD8VM3WRxIV39wMH8eIAsgcgg2Cz3l3Sa/P+uzR5gjLWyya7P+3zHrIeQl7cO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGMZV3kv; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGMZV3kv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS/8qQNKAwWKEsjfE6WJmIij1XVzBV3CPJwu4naOGnU1hmXy+75XEp+hHZ4THNFHBeY3gMnDvhD5aqRrfYc+rGTBqA2NpuLp4J3EeaqnALM1nPgSnaTU2UgrkWCAP1io/MvzIysEWYzq2jx0Oga3ZfBnvTpUEKnHV7nVbNqlFz+TLDGzJE00VgC142pHx4BgmJQq2lwk1P0meNfoROxmHZ1bW4gFgrbO4SAjfXd5hT/ZsCgG0Jadoo9W0Ih9u1VoKiEY//7k1j3O1tH8en31YbItWmnns2ocvBNf+3+n6HvbvmjQcQ5R/7efA0ZnofD1n4+HJj1hYk7kkM+gLTJOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lSRlfM8WYkC98+Eyd/C8aTQz+biqWiZYnlbXBiwpy8=;
 b=V855nwAatsRTurxvCt772Ul9X9ea2WVqFA8kyx83EVwLtf21Fz9CWzfOfjUHVtR15Uu4WVa4BkOt3t61lhcVwih0sMsy4zKJCkFCcgCY3ujOsuwSuItWkNHrA7bQoTEkVe9AEhvnKar3Tmj7KjJeFxQE05Mj0az3ZfQH57d1yo7AbzXdxgkrUh2sJiF6AJ83EYGrHK2qWGd2f1Sbw/EtoDeaYbInQ7d2apr3O3LPmMXE48LRc9jnDZErIECylqOS6ir0TdzXj+vy0vImzi/SI+XhZqIofSzw+YOmLJYpaKHH0KaqAeXFaaID1C+lj1dKAm6QAL2JgkFy9guO+aHS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lSRlfM8WYkC98+Eyd/C8aTQz+biqWiZYnlbXBiwpy8=;
 b=LGMZV3kvlslHo+99gfxDe5ALEYmKKkyaSGkUiFLBBrFuqAKuZoXMUFXQUTfEdqyJ01rkT58uejKUNqYiIz6qnEP/K66GnrOIeQUEsu1jx0Hq5h51dlSZAUcuhTXaaW3DpQtmz5u1QfZy2ErYLNv+51qUQCo0jX2EaBtAMBsmjdiV5qxpaxLyftJnEdK+GzDDMUjaK1uRW4omQCKj9vrgEA/CXi2oOGgzkQtpltbu3t0806hcvyk22bMfRTiSGkIKui7TWqLrwPhZ/woTdFujAUNyriRDosjzk1zSqeq/VlBnfNxSOIhl+bx78AQoOVTTzhSdmJo5bvuOfMAYqoECsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Wed, 24 Jan 2024 10:17:43 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:17:43 +0000
Message-ID: <1eac3e8c-1bee-412b-9aae-a63ae1e54692@nvidia.com>
Date: Wed, 24 Jan 2024 10:17:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 jsnitsel@redhat.com, jroedel@suse.de, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0355e8-41ee-46c3-4fc9-08dc1cc5b3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Cz5bKncb6HixN/RaMoLOJFhquhvPUfH03TtR0V/jDbv+x3wNHYojzWCU8DWRa0zwyf48SWpF5RAjKKAqb4kWAiCMkktCu4teINN5zi2tHnrOG9M9xz7cB1HgVt88D4L7paZU7Q0K50yadh5Y9MKfp5Vt5bI88D2YcvLe0SyMiNRI1KQZUmFifvxMt4kR/KiaDF12Rrn4ziuRhJ8uUm/Nv1xPlhFh6/yR2KQ2BLu+1JqvFvQvu//dW6rvBcHFbbZlvhg+9N/Q1LwsyB6BwFMef+Ae7gFXipNU9N96+YftfBhyK2U4WaS4Oq4n818/M2GuEzlV1Pj2xqhyQfpgAnveclQN4BTtKLqnoWd+xsFfth2mVj8yaYW7brFQLuVw+l5K52EcoruuNmR2lZHxXPmdFyHC94etNj9+MEbkd8SQ12e2Ymjrq8EfkpMQdxxAwaKBT/d21JoFK+ffg+9ApEx+Ilv7oUGc3FsvAFvzQUhmtiStSoS7Zw2eWScFS2WGwVYF+ZJbuUWBfT1h3ASc1cJYuMenjiWzW85utSUHlcankVJ2x/2IzfQNn7IFRwNBURTK306FRAMRjRpgZWDiEHI9Dw/g4bTMlBCbZX1yODZbLYIvpAqwor1JLvo9gWNjZWjAPQx3YyGIm2DTrYwj03uEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6506007)(83380400001)(6512007)(53546011)(2616005)(6666004)(31696002)(38100700002)(86362001)(36756003)(66556008)(7416002)(478600001)(4744005)(8936002)(5660300002)(2906002)(4326008)(110136005)(6486002)(8676002)(66476007)(66946007)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG9oMXpKWmNGLyttOUVtK0lDWml6cXpRa3RVR1J4Lzk1WnRnTkRibFFkcHBF?=
 =?utf-8?B?M3N4Z3RMK3J5UHdBZGNpUWsvVmpxTzdqR1hoaTVuNVhyN0h2bFljV3gzSVhu?=
 =?utf-8?B?cWRnekY0RlB6YzJIUXpFMTJsNTBPaXR1MkRyYnlFTS80WjcxS3MzOFhmWEJR?=
 =?utf-8?B?OVcyTDVCUHhIL2xHSUVaNjR4YkNVYmtIK0I4c29Wcm1SSlAvWU9aQUhsOUUr?=
 =?utf-8?B?SXZadVllUG9PVzdmK1ozRk04QUJnS3VscjYwZS9TazRMZjJTRG95eU10TUdk?=
 =?utf-8?B?V3gzMUZXZStOZVFLWm03TUJ2ZlVGV2M1K3RBdFBDMm1LY09SRHB4RDFPQW9j?=
 =?utf-8?B?cUlFSjNFT2F5YWVLdDhvN1VidjJScWhIdG5JRFB2R0NKRTY5c3p3ajlhWVlC?=
 =?utf-8?B?UVhZR2tMelRDYkZPTUZGa1hIeDR0M2cwNEgxTFBFZ3ZVVC93TXFxcDJOY0ox?=
 =?utf-8?B?OHdwS2RHSUNVNUxDZ1B6ZU9hKy9vY1hoUExVR0hhSFZtTWROTGx2WnpWNHBp?=
 =?utf-8?B?VkRLVGdkbkx1bGJjUmk0UkxhRmZXeGVyQkZVZEdvc1B6ZTlLb2FpQWJ1MWQ0?=
 =?utf-8?B?bytnODNNR1gwSVNFN09GQVNxMFNYWjRTUVJ4V05DL0NnYXN0bnZlWHBuMGQ5?=
 =?utf-8?B?TTJRcEQxNHBEMk50Lys0ekxYVGo0SnM2MWtjYzZhajZlRWh0VkdyL3crMGVW?=
 =?utf-8?B?QS84OFhheDJFY01mZkNBaHM3YkdQWmJVR1l1YVBkeUlYZUZQK2g4RTk5dXBZ?=
 =?utf-8?B?Qm9QZUhlcVo4anRpaXA0dE1JYnc1K3hRR1NRQnBaakhHVk5kbVRRekRuelVY?=
 =?utf-8?B?QWdEWE82ZWdKNlJ0RHBXQkhsbjhRdTdIN1k5SkNTd0h3MlhoRUZ6a01SQ0xO?=
 =?utf-8?B?MmMvQkxjelBlZis5VTE4SExXUkx4S3V2bjlvcWt1UzFIeVlpWUQ3VGhZZnZT?=
 =?utf-8?B?Y25TWjJ3TTlrcjRGNEVnMUNCVzhNVjZ3NFdFaVJPcUJUQmpFVERNeTU4ZGo4?=
 =?utf-8?B?Mnh3RVpSNjBQcHpSNnZOaVlFcjBqQ1hVWkF6T3pPYnE0UU93cUVCcjdQWGV1?=
 =?utf-8?B?djR6a2Q0UEV4d3lRem9kczNOU3NOaE1CZWF2WTFVZzB4N2tUNXhOV2lVZGM2?=
 =?utf-8?B?eTNGaElWR2pzSWpJSURneXRKV25HQ2NMNmNzZE9LTXNKQ2JzWThXT1pubUlt?=
 =?utf-8?B?azExa3BmSkF5Y0Y2S2paYmdpUHUySDVodWxlN0haUVRyazNZSlNLaW5kUzdE?=
 =?utf-8?B?dzJQUWNsWXJNTHVUZHNHcXpOTjdDRVlGQXNCWklBS1prVnNWMk02NEdrcjVh?=
 =?utf-8?B?K2N6dzNnNk1aeGM4S3l0Z2pBbGk0cEFubnFPM0dZVGFMR3A0Ry8xWm5CVElS?=
 =?utf-8?B?WGpjNUM1MUFoeC9nczZickdIVElkY0c4SWV5anhGY0tSK1RTbkJQR1lDZFN1?=
 =?utf-8?B?SVBWZURoS2hJTGlRUXk2ZENwSXpUZS9CanVJTWlmOW9wd29FYzRNL2FpSHRk?=
 =?utf-8?B?eW13MFprWmNGS2pZZE9wVFhuSmUxZXpyRmhJMnZ2MWpBZ1lsR1VBbkE0VVdr?=
 =?utf-8?B?T3lneW96a2ljNWlBYy9OOUthd1VxK01GRkE2YXIzNnMxNlZtN3NieFNlOVVw?=
 =?utf-8?B?RGVWWjBVUkZZT3pHNit6R2xQNS9KeExaeVFFdCtENmZscEczSWR4eW9XUW5G?=
 =?utf-8?B?M0NmM0lhTUluUDYrY2lINVgyWUFqSHR3U0trL1RPR2ttV25DZEJrYlFEd1Nz?=
 =?utf-8?B?Y2c2UGVMeHdyMDFsVzEyNEJJdXhrR3V2T3VKRjA4cituT3BOWm4rWUtkNG5u?=
 =?utf-8?B?R1M3ZkdBdmdEcWtYSk43b2h1RFpMbERWNWZic1djVHpjSnBLVi9NSUlVUlBQ?=
 =?utf-8?B?Um8rcnJKenVsZ1Y0WlN3MVF5V2YxZmFTMkVwcFZWZjZqRDh1M0tpcXJsZmxx?=
 =?utf-8?B?YTlXekY1ZVIvdEVzaFFkVkVLbTdYYXh4MGNUMFVnbzZzR2dsSXVqQkhrd1VR?=
 =?utf-8?B?OHdxOStuNlRaSWlHSGp5VnJvUXZBRDIyUVE1dUlrVEJZYXFLaVpxMGZoSzFT?=
 =?utf-8?B?MndEMmRqSDJUN2ZXa1NVdHNmZi92NmtIUFQzcGdTVjNYZHFsK1NJU2I0UVZ1?=
 =?utf-8?B?aEZZQWhQS2w5dVYrZWJncUZBQ21TWDc0cktDRzBhaW52bzhzanhlRStaT3Z0?=
 =?utf-8?B?V0FteDZoRkt4UHdKWWxwVzBwSkFuRlBYV3VXTnlyS1hDd01OQ2N6M0NvV0p3?=
 =?utf-8?B?cDhDNzJ3S1NCY0F3d1Z3SCtkWXBBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0355e8-41ee-46c3-4fc9-08dc1cc5b3a3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:17:43.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTA4bjnSRoaUq4Hbq8GmV0yuPA4DSzs7oJKvcTWC5KFGbFJ7h+xXZ6Fw+XT7Q2HpnycKWKB331Z9moNrkWCMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301


On 24/01/2024 09:13, Diogo Ivo wrote:

...

> I did the tracing and found that the ENOENT is coming from
> sysfs_do_create_link_sd() in the following function call chain:
> 
> of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->
> iommu_init_device() -> iommu_device_link() -> sysfs_add_link_to_group() ->
> sysfs_create_link_sd() -> sysfs_do_create_link_sd()
> 
> The particular block that emits the error is
> 
> static int sysfs_do_create_link_sd()
> {
> 	...
> 
> 	if (target_kobj->sd) {
> 		target = target_kobj->sd;
> 		kernfs_get(target);
> 	}
> 
> 	if (!target)
> 		return -ENOENT;
> 
> 	...
> }


I believe that this is the same in the case that I am seeing as well.

Jon

-- 
nvpublic
