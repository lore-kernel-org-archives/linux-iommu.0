Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E7FBFD;
	Wed, 24 Jan 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092589; cv=fail; b=oRpJzTV1SIrSo8HisYgzW88yfZ4TwDuUR7IKCA2D69SWQFqxgnVvK+7vUjfRXqrQNokpQtWQzL2vabfV71YFrX3AIFVekcAdLnGUGvq8PJhfcGR26ckqEJVb63RZCAZbmQJySEtxUst7hA2JU7AV97tdJuMDgnd3fMisCIwNjRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092589; c=relaxed/simple;
	bh=lvrouP0heT4d/UIV1MgLZVavK0rKD0xRNW6oqT4bizg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=po7xDy1jdhbp5+IaciIHQ0mWw3p76Ksy5k8vOWauGCXfADR4cIkf/5beyvQ+85dwh40OqaHEzijL0CfDNe7iv6sQOQkx72+0nEH4M/dEgyt04AMNTep7d8xW9b2yjHgRkiptY/mwbHeEdpU6zuO8nFJyrZR5KogzyAtzY7VqMsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M//G313K; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M//G313K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns7Zg52Wtxz8xR7nA/aYDQoF2pBOMy+fSTUq5lrV/qI0ZVC6a7qrRWZHsmyH4aMuBOTLta2fsOGyFsJ53YQFKIt259Lku1eV1sSVxAFOeCFRkXUETPsp927msjsozSA8aHwQrzC7V7CqpDN2XFgMmoWwfNehHzPZ/k8vxWP/L2K+0btvW/Qyypgi25yhK4G7TbDlcBuTG206Ff1/GT0wYGsxzXV3sWnWVsqCXPglNZe+A9eGhOvXrUDikdGUxvJXJpHJ7t8oln3GOdZGYcE2vTZsRquUjDNq848/RJhKcEVX8H5TpYToCE1nYiGducnzEKoLsJXm2/mMJb9HoKIsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIj3dhuOVWCgCbMsvBvZE+wmkXaf5MK499sDpIguTFE=;
 b=ShlYknjMX7lq7pXZ0rzRPbAHIlFcZwDj0kB4ffIDUu9/hqKe/Jo3AlFJ9xzjQkx0nBKklFwp/Ffn0YnwdG2qYHgaHqeLup+pzI5W4dGRucxDxkuYmyvasct7ydgH697pJz3VB7/w9AGvVpjHIGNCYQMAbMAxTYF6rK5I7+Vt6moYmysiOyxvo5yoQ6K97q7eu7pwaOA2GunKK4M0mfxzZX+XpsYFbPVrFyJDV8JyCx+BIBwJS6Qdv6kKn1JDx7mKqN+4UrjcHNGKr6t9Y66KwSsCYrm6e2nVNBGS7cWslupAc48/FNUmujGZ7vo9i81US4vT/nMGovaqIsdzNX5lnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIj3dhuOVWCgCbMsvBvZE+wmkXaf5MK499sDpIguTFE=;
 b=M//G313KIMWWttxL9wnuofB09ec9g6glwUS2HvbsD8uTilDHwJSU+KPyJ1joS/xUafFgZ1lnsF40WNd6h3BOzYbSmXiCD3xuAd/OO5CC6bQr5M1wJatBC/ukf/UWbHJIKqEs+2D3vQx5RM8tKzLKzNoyNvmePzr4dGlr2jGA+KUTcfLq05tcARqNtpNr0OODT8kO+YQLrxjsMe2p89FWeThhSw8iO2jeKlhUShYuG7WOvfAE/I07AL0tVu3IvqjYF8AqYcT8WlSYJVxxZLWBFeHTQxKibPqahjI4Z5jQ65FC8VS690UluubllaRj8Ir6BEH5MHIDz+f0voBjWZkJ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:36:23 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:36:23 +0000
Message-ID: <a837d873-ee4c-460a-a157-6fbbda6dc09f@nvidia.com>
Date: Wed, 24 Jan 2024 10:36:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
 regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
 <b0334c5e-3a6c-4b58-b525-e72bed8899b3@nvidia.com>
 <xwvre6uqvakg7aqrnkxa3xrek4rkjoj36isiip2iphzanmmxch@gzqrwgqeljsi>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <xwvre6uqvakg7aqrnkxa3xrek4rkjoj36isiip2iphzanmmxch@gzqrwgqeljsi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7ffa6f-29c3-4c3d-959e-08dc1cc84f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6eRaqlffAj/HOHHcEAlqJvnVD0ONEFRzeFNOeuDP6VUwL+UsF7yDTnd2/d8aElM3DADnndM2ql9hTNa5Gh8J7Kc3OztG3Fgzjyo/3iQS2evpfRntB1i+YBNirubvuIUM9FpOQEhkoWInuMfUw+IhCO17IZkaB/RdpqGW4CCNSpvMn/c5yR1CnadYffCex7NikiIQ1qnzcPnEqKfrCwLWm/5f2W24AjVIV6SfI6Ollb+fRYez0O/R4hCzXgZRXD+J4ZmGVge3Yo7OlEuGGs3WvpVcqcXiIa2w6wnAFAeElcgidh2KSgcdxB658okPmiSOf4xq71dwTrrvNsfHMDrevk7rxJqnqJX1lOHd1CLGRCo9K58XeL+YOTCB8MlHqdTvD/eZz5aTyIt/KYOws4Cs8IfrQosC46J1wZL/uZJwLnb0nqndCiuFh/iqy/kGoOVNd0oaZGGi8O0rZsWEcDCBae/CZcyhZUfFhjKnBAyH424SCNk9xjsgeNzU1R9a0sn8znvPYntWUWMaTPbnm9YiQuASwjQtFd/1482abC8G10kJBJOarlCEUDPYv4OmIgTZZDt1/epXRDFZaxYI48Gnc+Ny0m2Hfv6lgMRoPSutDL58H0ugvELHGRxZaud336yu73dO3izMY0jn4/vQHelqdb51YMll8EZEaMJ1iL187qCFgWsMZHoYa5LGiOdXYafd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(53546011)(83380400001)(6666004)(2616005)(41300700001)(8676002)(36756003)(4326008)(8936002)(6916009)(316002)(5660300002)(7416002)(4744005)(2906002)(66556008)(86362001)(66946007)(66476007)(31696002)(6486002)(478600001)(31686004)(38100700002)(45980500001)(43740500002)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUZFczRuTk9PQ005SkpYcmtuNTVsN3hMb1M1Ym5lZ1o5TVRBNFVHZ1VUemRU?=
 =?utf-8?B?SDZyYXRPYnliOTB3a29ERmZjZDllTys4L2o4TFRMRVZsa2xGSDcybWFjd3I1?=
 =?utf-8?B?a0FsanVYTHhqN0FZQzRQZ3RyZEVONkRKeCttOUcrbFdKZG8vOEl1WGN5SU9o?=
 =?utf-8?B?akVaMVc2aElyTEtpMDJNQUJKeFN4SVR0YXVDV0M1UStUSUZlUTVEL0xZZ283?=
 =?utf-8?B?MG5aUklBcVNDcmZtUnliZ3ovREJSa0lTYWZ1eHQ4dlcra0pieHlBNkllcWpV?=
 =?utf-8?B?V3E1cGNYV1Q0WWhvQU5yL3hvMmdmMVNxOFpCTmpWYkpUSDlVYm03eHVyS0Jk?=
 =?utf-8?B?RFM1S0NVVzc5Rm5GaWxuakxFNVJNN1FKRTYvWFVuUzdKMXBFOHhMeENhUk1k?=
 =?utf-8?B?NDdSRERHRUZFUHpoeXl0U2NnVkw5cm9YeGV5YVlhUXRwRUNRTkR4YmRVU0Q4?=
 =?utf-8?B?T1pGT0EzYTF4RnFNbHdlVnRQWWVnS09DM3VoZCtxeUZZYTlwRFNjeVZvQnlD?=
 =?utf-8?B?Q2tLTC83WENaU0ZocG9kSC9VVWN0a3MxK2p5dlN4c0ZsNWYyVkdyNnBLM1dX?=
 =?utf-8?B?VE5tdnplTG96NmVrQXViRGNRcG1DaU9WMTdWN2xFZXNLakttbUdrOGJYVHND?=
 =?utf-8?B?WFl0WEZGaHdlRzdtanlIa3NzbVZDMWIvaXRmeElkZGp1SmNhNjN2YzZRZVdh?=
 =?utf-8?B?eE00by9hcktTRlRUVnpOd1RaYVJYOTJNc0NJaWJrMllZNGhTMTFRN05zNXJE?=
 =?utf-8?B?YjVvSDJvOWZla1g1K1g1U3o3UWFrWWNtZGNSOWpCUk8xYjR6Ulk2U2tlSXFV?=
 =?utf-8?B?WWdyekFnT0VSTGEyZFVMN1kyQUhIall5bWZjRGl5NHRSanZkdno0SzU2TEhy?=
 =?utf-8?B?cXZhZnJCc1p0cE1QTmlyWDBMdi92ekZyQmdha0hHeDhQQTlrM0xjTWZSVnJt?=
 =?utf-8?B?b0JaZWxKWTdlQjBPMEJ0R0ZHbkFZYlVnSElqZmorOVEyNDQ2YkZTdUVoMUY3?=
 =?utf-8?B?Ymxra3UwTllkUkZ0WmRaenZ3NWNIWW95dkpOdVFWUUZmUG5YSGRISzFxL3Iw?=
 =?utf-8?B?Z1F6ODRIS1FOTkpPamo2bm42NlVvM21WNEJLZnU1eUZhUnJqMFFKSmVCemJX?=
 =?utf-8?B?NCtKTDRwRTdhTy9teGdUTzRhem9jbmN0UTRpR2c4djV2OGZGSFhDVnJRblJs?=
 =?utf-8?B?YkN2ZGMzSnNWdWtjdFh1Z0NSYUNGWGFaM2kwdXRpSjh5ZHl1bDNTdm8rYk16?=
 =?utf-8?B?aE0rTnl6NzRiODJ6d005WmhVazU3YnFSdFFmemp2Tm9NekxDVTdlMVBuVy9M?=
 =?utf-8?B?MktWMDVybnQ2OVQvSGFrTFNzNmtwbDR1ZE1yMHVaV0RwMGwvMUoyU212QUh0?=
 =?utf-8?B?TDB1ZjZpckVXb2NoYzQ3dFVMbzlYU05TajFFUlhMeDFoVFRIdlU0RmtyVUo3?=
 =?utf-8?B?cTltTEVLUHZSR2FpQmFOWGhYNGRYcERvclVOZFFUWTVobVhHUlJGb2E3dEl0?=
 =?utf-8?B?ZDRiQ1FBMnJwMTdlMmNXd2tCOE9FbGJ6bjVuMC81T3RTcmtlUlhoLzFVQ2J6?=
 =?utf-8?B?NHJMZjZkQXVScmR1N2xHY25EbUxQcTZBMkFuME9pLzlDRThLRnkzY0VvR1pQ?=
 =?utf-8?B?by9BemRMRXFOUlNya3lTWkFoVGhJaFZxVEU0UitJemQvUzBHaUlsRllGcDY3?=
 =?utf-8?B?VEV6WFhrczVCb1Y4NnQ3T1RRNzJPR3NOcXE5RlB4OXhoaE9QVEFJTHFRUUZ0?=
 =?utf-8?B?QVI2aWtuUVJvN1JqMVgvU3JNR3pHN1Vma09mZm5zRTNUTVpJaEJYeUFIWVBq?=
 =?utf-8?B?RDdWdWRpazNlaHcrNGJuY3FzcVBqTFBRamNKeTlMNWxQRVZqUG5kMk4xOURp?=
 =?utf-8?B?RGRMUUxla2VYcUtYYXVvV2xKczhxOXg5YnZaOCtub0FMb2VoZ3hYeVNibVN5?=
 =?utf-8?B?bDVHandZOUZiQTJLOUpHVW02VWF1QmtpcmFKN2dyQ2hDYitPTGNSdUoyWkxo?=
 =?utf-8?B?MkNHOTNLb2NHVmMrcDhQRHBobnMrRnR2U3pWOWd4dXdmZ3V2bW1lVkppbjl5?=
 =?utf-8?B?SmNPODNyVnRLUU1IdFlEOHNXZ2VNSGJid3hVS0xDejYvRmhVR081OHo1Rmhk?=
 =?utf-8?B?WTRrZnI4STlZb2hENVp5cG1uSmRBUVV2UzUxQSt5TUNMMjd6SzVnSWlvM3dz?=
 =?utf-8?B?V2U1eE0yRjc5YUNNMzVxUWZFa0FOOXFJR3Q5b3p6OXZwMGN3dk5HUGdJUzJp?=
 =?utf-8?B?OEliSUYyaEdLVmwwSnkwQ0pIOEF3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ffa6f-29c3-4c3d-959e-08dc1cc84f4a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:36:23.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiZe7UVLrJolH3QUIawY/t1cQLwnITGsGW0Rbwnc/fAG2o1sPL1A/SsCo5nxZCYxXd80MQkkEdM8fTIyVbhtmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266


On 24/01/2024 10:30, Diogo Ivo wrote:

...

>>> Yes, this does fix the issue!
>>
>>
>> I am seeing the same error message on Tegra194 AGX Jetson. However, the
>> above does not seem to fix it. In this case it is slightly different as I am
>> not seeing the DRM allocation failure. In this case, it appears to be the
>> of_dma_configure_id() call from the host1x_memory_context_list_init()
>> function that is failing.
>>
>> Jon
> 
> Just to clarify, when you mention the same error message which one are
> you referring to? In my case only the drm allocation is fixed with the
> above patch, and I am still getting the ENOENT.


OK, got it. In my case, I only see ...

  ERR KERN host1x drm: iommu configuration for device failed with -ENOENT

Jon

-- 
nvpublic
