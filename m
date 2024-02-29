Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA77D419;
	Thu, 29 Feb 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218266; cv=fail; b=jJ6Ke/7aHYaWXhDb+GXnSXRtR8o00BZrbiQ2epAkRr32Y4dIWXlpJKEz6kKeEo6yVu4tI6VrE9eKZQgEAqhbdE5BINMNLxM4Vy/h8uIPiSKgXB0a02nk73MAVjtAblQhd1rfiivvfWQhGUWxnNWKZsd4BX46GHinT8um4pBdOH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218266; c=relaxed/simple;
	bh=d1yq7YjN7nMCohIUXZc7x+VVCDgvPwF80vXejLhntlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rRGJnoQ/91EjKi0vF2yji+L8+lM9LmsMgrp4GaTrUnH19mCTo81mS4kcQh16Mic4p+vlJt3UcjAGcx++OQloemIqCcOqhrf+OKTV3DknSuypPJAYfVlxruHt6oi4PPOQaqWvV8ygESAUzyclazWFgrpMvwlnvN5gI41GKdfEnwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdHN2k6f; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdHN2k6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDPMFXmNsekdGqqOTGKk4TE4RTwYZiYyKFqRYFYVtgpn4G+OhmLpFpQrV7WYf1pjdLG7/nNVSQW9bTqmb+YNyxI76YibT2KbdXcPzqab5Us+Btk71mtF+rqqR3ZAQYVk2/gr8kGeLqto6sOdOHwnENqfc/Mg7wlSZteMLnfukg8C0hOOW3ybfyrCUqDqU+PaVW9iUHyE5WPcbi2lEtEP81oigwCXgO09Y6SFmhDLlOGGulOW/gTifOFv9lYPLEnBd60hgFGN5CMfOpigm+08T+YH6rUzUbak++a+OiToDgT30Z+3ENpBVdWZXzicZFZfr5sjeEhCciJfGoZQmWLtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pFg34AG9XFjb2r3PTRaRKHDOaou77TxjQL7NSq3WN8=;
 b=eAsUgdbO6DmlOEx4u7+GOD+63j4ZAqerZCTJhiOXm/l4vlktAiCbM9EitZ/+OFhrVcP85wpUajVccQ7EYTgi1zKJRTVp9njvOj+U/7qPNb7EE0rKUOxxoj+eXcadHoFXM++dlPTHnjtnhOUviEaGi3iw7Qce83xdmy3odboO6rQXUbqiY1T7gqGIw5Nngx7FX6ZY++Jzfl7nwlNwSvnUvXiTb7unIcuw8NfQx2rc1t7eJSVjoA4jFk+WGATnqtiTkWh2sRd+wkfgoW8FCYP0oIEAu3YG5N80g3VncTe1Q4ACJZImg8GMN9U5XiR12tOkKhqEpbjbgp2WvLh9wXR2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pFg34AG9XFjb2r3PTRaRKHDOaou77TxjQL7NSq3WN8=;
 b=kdHN2k6f0HwUI9tmqSO3+xNEqXvtk3jOA4yI7+GTo8QeoX0roWZ3A/K8NCrKnscJzjQvi6FinJ1wWxwnxCjdBOZD5Myc5Op7lUGxB28IBnV/EI85zUZywS509Q0IFlSDvApWXWS3ZrfP56zu+ln9oidz0vWf6nB2cGoZGZX/7B319CsQi9ZRbNvz9vjljMKmYHVCPmAfMBamaePzSZy41X++XNhagmliPId5upivlrzH4Mbph8zyZRQvSpRxP4F4D6ilpIZe/CvZzT9uFzGa7nQQATPMbaODgEfdwVOGwXOA0Gq7HOO13Ee0OmfCZxsExyfBdB6e//CSOKhrkX400g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 29 Feb
 2024 14:50:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 14:50:54 +0000
Message-ID: <02a8d225-99cd-4dfe-bf49-b002aaa045d1@nvidia.com>
Date: Thu, 29 Feb 2024 14:50:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
 regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
 <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>
 <r46zhd52g3w3kpu4jjca3vihmv5ahp3jcwge3rvg42dupxf2g4@p2u5mbdyypw3>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <r46zhd52g3w3kpu4jjca3vihmv5ahp3jcwge3rvg42dupxf2g4@p2u5mbdyypw3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b22b8eb-87c8-4916-dd83-08dc3935d4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gictqX4+DK54wyPmIdOte3ppYcYeNaIxWJMoYPec2InvbFVZ3Kf8CK+WDP38zg2Y3UA98Yhj9Sl7SPmuBjR+N4ISmZiF3gsSwXWZ4+9rlHTzH+l02qrBMzKXtv6nw8BFRDSz0+KbOjk+3kaXHQwO7roygY1akZty7SAG0uZFUjbuAYHcogh1sLHDDPSs8I55gXS0JePatsqHNB6C06VQZjz87OA2IrgHVP9Vuss9U9dJk0ehVGVaLHglgtCKStUd4YvqJSmTsKEam5ey8JzZ5pm2j/vgnCHonacnthzKybTJdqSZaXbcQ6T1CxrNfNQd4M3IADiq3/NsBpCs8cvZnYkxJCPUYBY2GM73H+8rRjWTy0uF0cJLgEdZEKqBVzRZ51Qktqr9IuxUKEXs5ujfI5hPSGW3IX4TC+XsEYCef9PfbnJiTcedOMH8rwG7buR9vPs0cCLEjDDjA/jYub9EGW1MEpeJdezjxxIpc9XOcEbtuIzfMICjUikw57eeuamjQJiTsfqVMNRdJWqb+P8sCXwmspcPmSUFEO6c2Mjvz6RVo7DDTBqpekqRvUsWi1fV0Sffu+K3uM/w5jUGq8qEO8qXXAmcdv4ACtusXTaku53/HxUz911BWYs6RD1H2ZYu/C8Jvjd2WZTpSNa4OOmz3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3hBL2xuNWlVVHNaTjZCY2JNdDNTK1E2RmFITnpTNG1jb29lV25xazFtRWQw?=
 =?utf-8?B?MnFPSnlIcFdUTHNGd0cxOWd1RjlVVjRSOHZ2dkJUb0h2aWFvcll1bVRwMCt3?=
 =?utf-8?B?RkdGYmlYQnY2SXdJelVjVG9jOWJ4QjZNNmxsNzBXdWtmSS9ZS0I0aThUeG9h?=
 =?utf-8?B?a3A4YXQxc2Rmdk5DT0p6KzN3dXYvSEJOZkk4NGQ0b2RoU0tlTFkvd21YUkJX?=
 =?utf-8?B?cVpwbXJTdTNuV3p5dmtJNzFUTmx4a2tTaUdkcWNLVUJ4YnVKS0w4c0U4aGNV?=
 =?utf-8?B?ZE1RWU9XLzFiSm9YU2JGajlMekhYWU5vaXA1UGhwRmo4MWZmRUpDTUUvWTE3?=
 =?utf-8?B?bW11dmNMVHZmaHVLZGFtZStIYms3WVg3cTluMUp6aHNzN0ZvOFg2dkJCUmZy?=
 =?utf-8?B?RzdMdjFXZTZqZTlrblpGYTRLMjhtbWgxdWFzVmU1QnZRRkpubWlWeWM1TFZp?=
 =?utf-8?B?WEtiS1dPQytsamozM21pYnI0Z3hIcUdXdFhXVFlwbisvQXk3bTlRajNYRzNQ?=
 =?utf-8?B?N0hpOC9LcytCOEJqQUdXYzg3UStjazZXMmNsRHZQTGJxMlJpOWdtT0hKdE9m?=
 =?utf-8?B?YklSdmYrYk1uczR5QkQrM2lXTFBaSldGQWY1TW9nNFg3UDNSM255NzA1QlhR?=
 =?utf-8?B?N1hITmRpdmxFemRTcS85MHdPdHJCeGVkM1kvQVVKVG1aRmhwbE93bXdnTjBN?=
 =?utf-8?B?OXlsZFlFSWpkNlhST2lwR0dISUVXems2dnc1dEFLdDh4MENIc21nMVVvd05M?=
 =?utf-8?B?S1pPNVRSeHl4RHU4b0lMWEhZSFBWUnBzb0w1UzBWc1B1bWplYUorZmNuVDFK?=
 =?utf-8?B?QVlOL1FGTHNaQkxYay9YQy9yeTNBUDNKT3VuNk9uL0NXVG5walVmVUQ3Q292?=
 =?utf-8?B?OVVqVExTRDJmS2NtbkJaMHRGcm9TQUR5eFRFcEl5SjY2WFR5azJFWE5McVlS?=
 =?utf-8?B?dEdJWFBjL2FRMjU2MXM2Q2FlWks4R2FDNUt2OXRvZitSYTlncTRQYUtwWHli?=
 =?utf-8?B?RDRrSW9POElObWJjbmt1R1d0MGRqMlFDaXdHeDNWOVROV2I3cG5DODNibldy?=
 =?utf-8?B?dWxOcDE5M0s2TmdvMmZ3eXV6RFN5REdwcXh1ckFIbGoyci84MHhyaUUvTUEw?=
 =?utf-8?B?azc4NTNQRXdIRlg4Rm5kMllxNFZKd3VjUmdQMDZxL29LcHBqZDI0dzFkR1Jm?=
 =?utf-8?B?cmtISWM0V3A2Z0cxRTJxNFY3eEJtV2ZiQzZDaWExbU5nRHNNeGFTeENJbVZ2?=
 =?utf-8?B?dnpTdHA0bnI3YmEyVTRIaUgyQVNyT09od3RxRDhDZjhzV2s0SSt5NHdub3ZO?=
 =?utf-8?B?SHcrSUFiZlpHY1pzejU3NTMvRDZyY1BKZ3E0c2wxVjkwcitqUmRJb1N0ZXBu?=
 =?utf-8?B?aXhRWDJ0RTkyVnhnb3BGdUJxV0hwTlZuZ3dIMUdGWTVacEhMaVczTUtGYjZI?=
 =?utf-8?B?dzNDVkhLRERiZTR1c1RXRDdvcDdIRUFsblRGRXMwMVZDQWswYnNwVjJwS0lu?=
 =?utf-8?B?R2hRR21WcUw3a21UNkY5enVab0RvOFJwZ29zUWZlcEVWWTBSc3FnazI4NXZX?=
 =?utf-8?B?b0l3SDZ2VVlrbGcwNjhDd2dvNnAxenViWHQvOXNLRDhSN3VjS1JoaFFZWHRY?=
 =?utf-8?B?UmlIWDE5cHI3cGk0N244by9CMnQ3STlYN1Bpa2cxL0ljVmZUSUpTTGFCdkI1?=
 =?utf-8?B?SXdmNW9jSS9TNmZYOStCMElGcVZZVWJ3ZTRGNDJVL3BEOGpDand3dWd4TDl0?=
 =?utf-8?B?ZGlJSVlWQ3ptUGRvMnFEQ3dMeWw4dVoyR2pyUU80d1QzUVY5b0FWdnpHYjVW?=
 =?utf-8?B?OWFPanBrLzZWY0drRk5wSmkvQTlDUnNmaHY2VTlHZGlhcG1IYUsyTGhDY2RZ?=
 =?utf-8?B?cGV3MUo2RnloZHJPYkh5aG5qYldZTmZZSUdGQXBkOEhFQTZzSjR4QTBiTGdn?=
 =?utf-8?B?VUd0dHptYlVCbjd0bEZDRmlsWlVwMDB3TUh0TmZhcllRcFVtUFZDb3RYU3VG?=
 =?utf-8?B?OWFRNlFibUowU3loNjRBUkdYeVdFOHByR1FhaitERUU2VFAwOFFYN3JNeSt0?=
 =?utf-8?B?YmNSMW1IMG9nRlV3cXRLSitJMXc5Si8vNnRialdvVkROWkZtVG1zMHRUWWVO?=
 =?utf-8?Q?gVBs89ZHoUp5u6Ka9/Kg349G+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b22b8eb-87c8-4916-dd83-08dc3935d4d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:50:54.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8w1NUnhFVL1am87orhjE31BCX3Drt4tSL47o1x2CytlI6PP2TbvN4li6F0hRHkgSQEIn6LTfEjBk01Bg5RS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152


On 24/01/2024 12:56, Diogo Ivo wrote:

...

>>> I did the tracing and found that the ENOENT is coming from
>>> sysfs_do_create_link_sd() in the following function call chain:
>>>
>>> of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->
>>
>> What's the call path leading up to that? If it's the one from
>> host1x_device_add() then it's expected and benign - for fiddly reasons,
>> iommu_probe_device() ends up being called too early, but will soon be run
>> again in the correct circumstances once we proceed into
>> host1x_subdev_register()->device_add(). That will have been happening for
>> years, we just never reported errors in that spot before (and frankly I'm
>> not convinced it's valuable to have added it now).
>>
>> Thanks,
>> Robin.
> 
> Yes, it is the one called from host1x_device_add(), so this
> is solved and only the patch sent above needs to be merged.


Sorry for the delay in getting back to this. I have been doing more
testing and the backtrace I see from this warning is ...

[    7.001380]  drm: iommu configuration for device failed with -ENOENT
[    7.001550] CPU: 4 PID: 263 Comm: systemd-udevd Not tainted 6.8.0-rc6-gbbe953beb8b9-dirty #2
[    7.001559] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[    7.001564] Call trace:
[    7.001568]  dump_backtrace.part.6+0x84/0xdc
[    7.001583]  show_stack+0x14/0x1c
[    7.001590]  dump_stack_lvl+0x48/0x5c
[    7.001600]  dump_stack+0x14/0x1c
[    7.001606]  of_dma_configure_id+0x218/0x400
[    7.001636]  host1x_attach_driver+0x150/0x2d0 [host1x]
[    7.001664]  host1x_driver_register_full+0x7c/0xdc [host1x]
[    7.001711]  host1x_drm_init+0x3c/0x1000 [tegra_drm]
[    7.001746]  do_one_initcall+0x58/0x1c0
[    7.001752]  do_init_module+0x54/0x1d8
[    7.001761]  load_module+0x18b8/0x18ec
[    7.001770]  init_module_from_file+0x8c/0xc8
[    7.001777]  __arm64_sys_finit_module+0x1c4/0x29c
[    7.001784]  invoke_syscall+0x40/0xf4
[    7.001792]  el0_svc_common.constprop.1+0xc4/0xec
[    7.001814]  do_el0_svc+0x18/0x20
[    7.001820]  el0_svc+0x28/0x90
[    7.001826]  el0t_64_sync_handler+0x9c/0xc0
[    7.001845]  el0t_64_sync+0x160/0x164


I could have sworn that this was coming from
host1x_memory_context_list_init() but that is not the case.

Anyway, we have a test that checks for warnings/errors and this
is causing that test to fail. Even if this particular instance
of error is benign we would still like to trap any instances
that are not. So is there something we can fix here to avoid
this?

Thanks
Jon

-- 
nvpublic
