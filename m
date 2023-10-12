Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116628EF;
	Thu, 12 Oct 2023 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZl+Hc7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc4A/lDJWIQHVbpj5cHQ/w2IZKI/bNJYeZ9sztlOkAR6SdrnwVvz471GKRRo3WUefk44QBC1rQ4rkUS4nRECTLKX3k4e2qsXZDP9iZAf7QGGGGAuxdtYQVzoHnoCAK6JQDnah0z1LfvFseQvb4JlUaf4FbtzD4fWmE7qcM9rFKFJq41C1gY9okAglqohjKZaUjezKG7OL6vdugyQo3FKqBZzkg5XatxMnus3+Lsw2F1VdiUIFI5HDBdjjAhKrFjVXBWkzWMOLTVxpbcX7qKolFHT9H/zzoGfvwD3RW8nMajY/SiskD6tq9a9bvMJ5DdR1e7shK2Dl80ppMKSGKE2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY3UVjeDHgbC+inUtjqSRtnCfHERlRlsqR+uz3svt6o=;
 b=Kwyb+SZo32lSL2zlAuhavsmihoLzL5prW8MhGq7iTIh7vxToneMFq7vV3d3ovVR8Xd4oyl4mqjW9LLjQ5NV49iqP8euINVsejyZ9r4iASAUAMy9G0UFhYXeaV4GdOy1JjZdNBW96QhJYmBbxWL1JRtmnZM6ru5oNkZj7vZtEGbkt42GifB+bOxd0NjbGG8Ynexdzp7QJXvJ1G5uXQg3wMo32M+NRhGhxW7lP/s1ZMNNg+FtTKSowPSTUBgtS5egoAXltr105tR4c8QAXaZ24eT+jRhLii88LNa5zqpKEc3dB43NPsWVOwQo7ok9Ft7YdZD1UkYnrYF66Ci1WlpZQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY3UVjeDHgbC+inUtjqSRtnCfHERlRlsqR+uz3svt6o=;
 b=AZl+Hc7fNyixdXNOlnNRvFFRxbQeYITBw21r1IS13oWZaC3wNVz8I4Fp4VamCe1/sulqTH2Cvxv4VwhxC7bST1l6a711b55ZCZRZyiwyPzQb/25VUczUlxqsOtflBGlp6N0UGNAeA0HvgfvFBU2Yx1YkWqs23Rtue9CmA/Qf8CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Thu, 12 Oct 2023 05:26:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 05:26:37 +0000
Message-ID: <f8163afc-858e-7830-d6dc-79c6b60d7c2d@amd.com>
Date: Thu, 12 Oct 2023 10:56:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [joro-iommu:x86/amd 16/19] drivers/iommu/amd/iommu.c:829:21:
 warning: variable 'entry' set but not used
Content-Language: en-US
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <202310071103.BYatoc0b-lkp@intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <202310071103.BYatoc0b-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcdf435-62f6-4824-8ab4-08dbcae3ce59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IfESxacDOjnTyhNaYSTR2K3rCznDKh/wx6jVFKwJAoFVkydMUkcCr+8aev7vGdRe8ZP/MHVG/dpA7QS5snWLNBoV614QvKLK/uGZfEVpp8JsERDmw8KQxQRi88kV3KTX8FfCyaR4u7rjOTaE8bUGbxQuEjPjZrh5Rw+djVp+p419i/4CuGNvymXpmjNesRbIsqnB/0PmbrCyCTo+23nHl5+E2hfl+pJiMG17mkGCFtJR1GsVfFXtmhDeo1xtWxkp2B4Mc8HpOYR/L1Mj6NZx6rfuJiRL3TMIifDrJyJYT0ajhq0zsCkZQW2PKNFQgOPpXL0oEB8B3anf1NUgVYj7BZyzdBejs9CCYkxzF70WdHkoAxLZfN5twyeQOmpQfMswGmAiJRblDDl0GlL00J9y5knff+gzVpZhYMcLqmTNkkpmt53nQZjHM0PeVGV0ZqwFA+4gj5+zV29mIQ7Wc3OubMf9wIAdTKV2RoowIybm7Zz2UeXCxEczH0VsIob/eNM/FXE2j1+2F/T2Rt7/LNeTe5LNswPvJy+YKDj2dhigqWS8vbkYH6zL5cuKKi1u1aZDScqzLCooSu9mubuHZAzumVhrRZopVOwtj7Sc23FLhMjKuYLxzNLg+myl08it7K/91myLEcUY5E2FjiaRQpxvFwbv49Tf4C1iQmq8GidsEIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8936002)(4326008)(4001150100001)(8676002)(2906002)(966005)(6486002)(31686004)(44832011)(5660300002)(6666004)(478600001)(31696002)(86362001)(53546011)(6506007)(6512007)(41300700001)(36756003)(38100700002)(83380400001)(316002)(66946007)(26005)(54906003)(66476007)(66556008)(6916009)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZRWUlNemlKRE5UWHpWeE5iWTFELzVTbldUZXBhUVpTN0owMUhqVE9makZu?=
 =?utf-8?B?a0owc3dBOEpTVVFFbUJmYXFNM0gvRDE1S3R3cHZVa2tMYVRnbTIxaFVyTlVT?=
 =?utf-8?B?MHVzZVljZ1JCb3J1Ulo0ajhQektjNWtiWk1melI5TVhaMlFPdWNLc1BTY1Rz?=
 =?utf-8?B?WlowV3QzTzI3MkR0OGx5Z2d5cklOL2ZuZ2l3cGhkUDBaN2s1aVdEK2FTSUx2?=
 =?utf-8?B?QnhYdjRJeC9aei9tSjErc2lKendtOFlxM1FRc2NoZEtJYzdCai9hK285ZFhj?=
 =?utf-8?B?RXBJbU9BblVRUlRQTTYrbmZIMXdTbzdVMWVLMUQ2WFJ1QTNsNUQ5RnMxajNI?=
 =?utf-8?B?aE1qU3NEVU1WNEg3V1lMOGdzZHNDSFZnVnNuaEUrSWtDSGdya2NHSG1JVUhN?=
 =?utf-8?B?aml4WjlmT1pLQVRyMjdEaXp2OGpGMTM4VmZCdEFYMnkza0J0cG5DU1RhRkdu?=
 =?utf-8?B?RGhKZUYvRFJwRk1FbmFsL2ZEMkl1ZVRSV1kyN1kwbCswekJCWldITTl4S21X?=
 =?utf-8?B?V0Z3dUJxOVB4NnVWSFlDQTM4QTVQY2NDOHQybURJbE54ZXNIa1c2aHRqa0s0?=
 =?utf-8?B?QVRJNUdtYlBkNHFvcnBXTXlPOVdjVDlydE9RYjR0bkkydWtNaGRqVHdCbEtU?=
 =?utf-8?B?WTEvVmQzOStYT2E4SGdWamkzUHoxSmpIOHVoYWdoTDRTTGxLTytySCtZenN0?=
 =?utf-8?B?SXhKeERIbGtScG1kdkcvV2VyanZ3VjlOVStFRGRXbmVlT1QvbE9ST0VtY0h5?=
 =?utf-8?B?NldOc09RbUUzendsS2pMMkVhZXBTcVk1MGc1dVhHVWpEeTE1MWJpdjVtR2RN?=
 =?utf-8?B?QUp4MnhXVTlrSmJBc1ZVWitjejlacHJ5UEFoZW5jN01lZzJucm52eHNxZ3pt?=
 =?utf-8?B?V0pPSjVKVUp5aCtUdWgyYXNNMTRRVlQwREtMbFBvN1B6aUQrcFVhSTkxcVVG?=
 =?utf-8?B?U3dyR0JLZUEvbUNndlV2UmlUTVFCcmpLM0JxK2dUVkJaak9NTFNrUERSWlZp?=
 =?utf-8?B?aWVvcUhIelN2T2xnZ3J1MUlNa256U1ZUZjlURFZKL2pXdXRSMS85VmtvU2pD?=
 =?utf-8?B?bzV0TmVRYy9YMUpQWHZlcTgxVkJ4TTJYYjl4RTQwQ1pQT2pYM2V5cU4xcnVQ?=
 =?utf-8?B?a0FaTDZURTZvZFFsdGZoRGU1ZWptNWFvU1k0QkZCZzZHMGJDRHo0OGRMaGVR?=
 =?utf-8?B?eUFRREZhTFoyL2RObFNqaG5Wam1TL2JxRk1mYzgzMzNnRWRWMGFlVzdFcm1o?=
 =?utf-8?B?RjkrL0JyWDc1Mnl0dUdzcmFER3hVdFBPdmFEVFVSR1IySTVhV2hFOGErNVNZ?=
 =?utf-8?B?VWdZU2FMejNBbnBJZ2t1K1NRVlB5WmljTGJ1RlNkMnRCN2VlRmdXSERLKzJU?=
 =?utf-8?B?ODFkdm45M0hrNVNvczExTzc0dUVKR1dJeEtnQTFFa2dOWkZWVFRaQkFmVFFU?=
 =?utf-8?B?UTNteDgxeExCNkZRdnV5dTdocjVBNjNBL0JHNmhBQkJWaGR2eEFScW5EMnRJ?=
 =?utf-8?B?cTNlNXpVNjIvbXdwUG9aN21nbHhjQXVteVJwY2oyTkVwWmJJS3BvUE5UYmlF?=
 =?utf-8?B?S3huOUIra2dMQ1U2OC9YVGJIVWZ5MlVBejFoelVNVThXdWxucmdJOFVSMXo0?=
 =?utf-8?B?cUY3N3FrMFphcVByMFJpUXF1MlBVVVhPZEZmTmpJMVg0NUNVTEZETnBwMkFC?=
 =?utf-8?B?OFROZjNjektIUktqdWZIWjBBTnhRdWJSRGRkVzAxN21VcGNhU1ZhZnpjRnRi?=
 =?utf-8?B?cDBQbGVDcE1nK2NidHllVWhqQVhRdW9vQ25PSXFsWm4vK25vcXQ2bGMrSDdV?=
 =?utf-8?B?NGdnc0pLMnNEaTc1aUFFbERWak50cmFzZk9aSDFLcWZ6QmpST2NmWTk5Yzlz?=
 =?utf-8?B?NGFUbE91UnlaYWx4djBQS09ENUlEUnhNT0RYS3VnUDgvVjkzUkpTdTdqRFlu?=
 =?utf-8?B?RkJuN1pYVy9QNGxKcWJLc0JaRyt0YnhOUGhqSVEvVjZtUExybnpnVkFGd2Uy?=
 =?utf-8?B?eWpIZER2UnN0dWhLS25CVXQ2ZHBDN2hqMXhMWEx2OXgxWjh4dmxDU05FdUNs?=
 =?utf-8?B?YjlZYlJqOERwc0RqelZSaTAyUkhMWWxOemFLY2Y4QnRKbVFadmtkRStzSjlH?=
 =?utf-8?Q?IkdMbtGerK3683Zm5lBD4QEna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcdf435-62f6-4824-8ab4-08dbcae3ce59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:26:37.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMOg1l5+kk0IdUTlmt3NrLPOPK+PFDfB7pzZSLX7lQxCCc8NJfGK+/fNoAPvGhnSdyEsroUU+bPTzkfc9Q+1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

Hi,


On 10/7/2023 8:50 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/amd
> head:   189116d5ad54eee2bab82c5f12e837912fc0b4c4
> commit: d55b0d2e075ad32d560cdd35a2016973fda52ed6 [16/19] iommu/amd: Remove PPR support
> config: x86_64-randconfig-003-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310071103.BYatoc0b-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iommu/amd/iommu.c: In function 'iommu_poll_ppr_log':
>>> drivers/iommu/amd/iommu.c:829:21: warning: variable 'entry' set but not used [-Wunused-but-set-variable]
>      829 |                 u64 entry[2];
>          |                     ^~~~~


Commit d55b0d2e075 (iommu/next branch), removed PPR support. Hence this become
unused variable. But soon we will be adding PPR support for SVA [1]. Hence I
just added comment and left it as is (instead of removing and adding it back again).

[1]
https://lore.kernel.org/linux-iommu/20230911121046.1025732-1-vasant.hegde@amd.com/T/#u


-Vasant


> 
> 
> vim +/entry +829 drivers/iommu/amd/iommu.c
> 
> 90008ee4b811c9 arch/x86/kernel/amd_iommu.c Joerg Roedel 2008-09-09  816  
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  817  static void iommu_poll_ppr_log(struct amd_iommu *iommu)
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  818  {
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  819  	u32 head, tail;
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  820  
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  821  	if (iommu->ppr_log == NULL)
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  822  		return;
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  823  
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  824  	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  825  	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  826  
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  827  	while (head != tail) {
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  828  		volatile u64 *raw;
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01 @829  		u64 entry[2];
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  830  		int i;
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  831  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  832  		raw = (u64 *)(iommu->ppr_log + head);
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  833  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  834  		/*
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  835  		 * Hardware bug: Interrupt may arrive before the entry is
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  836  		 * written to memory. If this happens we need to wait for the
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  837  		 * entry to arrive.
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  838  		 */
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  839  		for (i = 0; i < LOOP_TIMEOUT; ++i) {
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  840  			if (PPR_REQ_TYPE(raw[0]) != 0)
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  841  				break;
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  842  			udelay(1);
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  843  		}
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  844  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  845  		/* Avoid memcpy function-call overhead */
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  846  		entry[0] = raw[0];
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  847  		entry[1] = raw[1];
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  848  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  849  		/*
> 05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  850  		 * To detect the hardware errata 733 we need to clear the
> 05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  851  		 * entry back to zero. This issue does not exist on SNP
> 05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  852  		 * enabled system. Also this buffer is not writeable on
> 05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  853  		 * SNP enabled system.
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  854  		 */
> 05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  855  		if (!amd_iommu_snp_en)
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  856  			raw[0] = raw[1] = 0UL;
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  857  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  858  		/* Update head pointer of hardware ring-buffer */
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  859  		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  860  		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  861  
> d55b0d2e075ad3 drivers/iommu/amd/iommu.c   Vasant Hegde 2023-10-06  862  		/* TODO: PPR Handler will be added when we add IOPF support */
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  863  
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  864  		/* Refresh ring-buffer information */
> eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  865  		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  866  		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  867  	}
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  868  }
> 72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  869  
> 
> :::::: The code at line 829 was first introduced by commit
> :::::: eee53537c476c947bf7faa1c916d2f5a0ae8ec93 iommu/amd: Fix deadlock in ppr-handling error path
> 
> :::::: TO: Joerg Roedel <joerg.roedel@amd.com>
> :::::: CC: Joerg Roedel <joerg.roedel@amd.com>
> 
