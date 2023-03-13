Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FE8F4E
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 23:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrHFBQRxi/SFF6sRP7NskZHjBwulBzXUdxZsuot1oPP+465nd3ltnLjLSoOCxFP+RTO35sC+c+JS8JwpaF7V0ltxMrFDLXjfGbGA76xV9G1UkbBLce1hzHkfU4GreDc7Y4asST/YEAXolRH4xB5Osok+ia+zPMwImU93pJJMirforxmb5DQg9O3pr5+Nhy1haZLXOqslbmAZohKCqaKdk5qNhvzzaU3nUuFtZxwA5h/179NOTYTd5N/7nuWWrOxzjrUrkSaAum/ffcSo4bdyVwJh7swDch/KJSWtPig/fN04xGNRzmOPvHahKDneu0I+cfdeODjsO76kJeFLNvouHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfIrbXpQBwBDbpEktsMBAi3g9dItTpLC6HZWCxYkIRk=;
 b=nDk21+O2H9id301Avvmx2b50NJ8R1iV1azcUpMM5RUEAOD3+WvE383ivqGDQ6QHyfhiCjy6oium2HDQyYd/ta3VNymGc/z1QzYN8Yn8lZd9nOo2m2NUVvi4c7M3yaO9bR6+KbD1X+Q7QiHB88CBx1bzLvXhpJS+HVsjmZyrwhZXfI8O6ybiVRUGi9hul1A1evLXUygM1SJ3sFTZKGRTzmtOHVlL2M1iZoNc1HyibxBJgWEIxlve7IQOjmW5L4XTsAVZPfD93hhqsvcdBDNr0hCNpnw17QS3VJjAK3XOrefmUuWBHDjJ14G6+EGYWMQI4C3uUzja+weL9eOGmysZWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfIrbXpQBwBDbpEktsMBAi3g9dItTpLC6HZWCxYkIRk=;
 b=HE4tb+7Y7zikSjk0OYn3eCp4kYzgb0RtqIcx1ODpbJaQ0w+KU9MWhsSqgXy7e9oxcrM5iSojDDTDYYTfD3wwhPd6qWIOST9n8qRbJNpbClN7DpyR0v9295k+adI9gXTBDDy8eRC+HY/EHbKHR+g8QWgOMvEWe+QEfSuVM13Msng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 23:02:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 23:02:57 +0000
Message-ID: <6c16f004-f20a-26dc-0f3e-abe0b683d764@amd.com>
Date: Mon, 13 Mar 2023 19:02:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: amdgpu failed to resume with AMD IOMMU enabled and 6.2.2-301 and
 6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39 and later resulting in a black
 screen
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Matt Fagnani
 <matt.fagnani@bell.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <4a3b225c-2ffd-e758-4de1-447375e34cad@bell.net>
 <9b688cbe-ec48-17a7-0e40-5734d58e102d@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <9b688cbe-ec48-17a7-0e40-5734d58e102d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1a4e4a-f352-471e-82b5-08db241715de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Dizyaf6Cye5+zgPdi8By5bJeUz8Zxa2HfPfsGXHK2oupOYvCpwzm8rY/xvp6+/ZWIv0p1Y66CnOguQqWlSyaD567HAHfuyw8QcRiExi974eOMYLCTQ0KXCD/ZtDJRiDUbbB3iDmmvotejXrRhWfxF26jZBPv/0GKgaJrJGVV72BDZTX4lk2ei0Q9gFZ6elK0dMsxIaeyG/bOpZ1RijJ5jye6+XvHgMFbRy1QVUKxzSATPDbxw/EgfqrcG1koYCDFmVdeq6H+5Y8lMsBCw9SvPYRdWnrQMkrOf12u2zMTdR1X66n1iHgVjeiHFncG2xRP35wJCJlPlagbpC9EiyJDhypJgWmP+gk0FJrNNdNQ1V9iZTURTU0y1SP4rtcG5StUqHwglsF+EAYjbcT4+e/Bn8F/QzBl7RpE5gVy5vKikZq+eaV36Ru0UYTeJX66juzFd32B7x1/aSc1VzPoGnkC+7ZdJSCTXCS3WCgnmSsb9rwDZm9kDsQDjESdDi+zPVngy0FCfohMNjiuzLzaEW8tfWlys6wQ34w6qTWV4YS9mgfVOkXOCE1I3SzbnnM1QCMLmBAOgqUJ4tCP8L3ZiZl5q/CioVgsF0YU5nHmA+gnQKykgYqKH1mj6AHi9Dsx0yulRavnhJTC13SpZQxilYVikDj3aPKPH4kaQZ/ypc1n0Hu7oqB0O6BUy8NlaSwU44iRh41F3ROg1qfbK3i4NlYshC4NXFQmJnb0h4JxtuP3lC65G9NX0qpuWzQpDZuqwtO55Dkrd3DS6j+BsgDeP9LeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(6666004)(83380400001)(110136005)(38100700002)(316002)(45080400002)(478600001)(54906003)(6636002)(8936002)(186003)(6512007)(8676002)(6506007)(26005)(36756003)(5660300002)(53546011)(4326008)(66946007)(66476007)(66556008)(86362001)(31696002)(41300700001)(44832011)(2616005)(30864003)(6486002)(966005)(4001150100001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0twbC9nTk04SVRXNWF3NHFsU1VDWTdDc29mejVtSkcvMjJtRjNXM3hxQlFt?=
 =?utf-8?B?ZDZxZWdjRXZhbW5EV3R5SUpmbG8zZjVlNDJBQjh5bkNzWHROcnVJUW1GVDZx?=
 =?utf-8?B?NW9TbXdUUmdMN0Zqcmo1UVFqeXpYY04wUXA2U0R0aXZ1dU1HMlJiYzBWQWVx?=
 =?utf-8?B?WDlZVGRWbllNejdmOGRKaU4xL2VGNTdrR0JOa3JsdWFqT1g5VTJFTkxrVGx6?=
 =?utf-8?B?TGw4UDBtRXk3aGQ5bHlZclNCWUhobFJiVlNYdDdKYXJJMnlSQW5qTzRrWm1S?=
 =?utf-8?B?TndHeFFpS3UraFpOQVptT2RVNTIvM2hNbjdyNFBNbzZEYVNiUnIvcVlxc3B2?=
 =?utf-8?B?VmhUcGtQYVdSeUVVcVRCUlVjZGdmSFFjZFZJdUI4SmFoYmo3YnROQ1MwSUox?=
 =?utf-8?B?T3RrOGl6eVNmWVZHRjI2eGQzdklvTnpMK0M3YmJGcE85aW9KY09GbUMwamcv?=
 =?utf-8?B?RGJnWnJPeW5rc0NVTkVjZG8zY2ViWVhuOVN4Wi9UTC8wcnloekFYZGpsRzVF?=
 =?utf-8?B?SDB3NDVva0RiazdzSXJQcnk3d1RGVHV0WDIwbWp6eHpOcHNLN0hIZk95MGZF?=
 =?utf-8?B?YjREOUl2eW1kdlM1OGVSOGRtRHpjYWpXTXdVeTJPSDBKUzV0MHBydkdOZEpl?=
 =?utf-8?B?OTRQQkhreGJWTnhVVXozeUhMdGZlYjlzUUF5VlhJYmlmOUtRZVBnaUhnbXpT?=
 =?utf-8?B?UkhZeEViQ0xCc0p1QVJzQzg4dEpMcWdOR0RzZVpsN2hCdnhiazVjUVUrT0xz?=
 =?utf-8?B?elRBVTVvLzlXK0prMm4rb09MV0krT1ZkZlFzTHllT0hMZis0NG1VTXBYTnRN?=
 =?utf-8?B?ZEhNdGRBTVZ6RTlTSHp5aytuMWpXRnVjakdCSVpiWXZvOXZRYnZDVmdTUnRu?=
 =?utf-8?B?N1ZrVmwxeXJBY0ZEcitreDFXbVRYRFZlVDFlQm5qTXkrV05ubXBpa2x6MVpw?=
 =?utf-8?B?RkZIaXBZM3UwUXNUYTVJNHdyeVlsN2FXMTE2Kzc3c2hKN1FuWHZRZVV3Wjkw?=
 =?utf-8?B?NW95S3FRL050Rm9IaE1oeGNTK1hoM0t0NGU1RTFHNEE0aW9YRnBFMCtRZHd3?=
 =?utf-8?B?c0hPTE5wSEM5ZXMrc1NyclNoTStSc08vdVJONGJuNTM5OHRTcEVVYW5ud3Bh?=
 =?utf-8?B?cTNncWUwM2dKSmNWRTF1dkVEZ3phSWNadm94enZiaTI3dXBxZ2gyNEF2RlFH?=
 =?utf-8?B?c200b1RFU3p0d0UreVJ2eFlFUG5IcjUzeEFaM3R5R3ZiZUt3anZGTnZpZFk5?=
 =?utf-8?B?aUpFZVZpbHBmTGRnSnpSQnd2RnVyb1BxcFc1VVY2R1FWMGhOY09EOUZFellv?=
 =?utf-8?B?MWFyeDJIV1dTQzlNd2RuZlliK1VzcmcydTczSVZmL3QwS3dIRG1GUU9nMnd5?=
 =?utf-8?B?LzVkd1BxNGJIMW9Ndi9sajlvRGQ3alBWWXUvNk9jeWQ0ZkpQWlJEZTJ4eTFn?=
 =?utf-8?B?NkdqSW1YOWcvOW9PL2xPY0pKOHJmYk5yTFRKUytDNnc4UmFtYUNibTkwWTho?=
 =?utf-8?B?L1F3UkVsbVplSGpxVzhXSWc0ZE9pVWZQMGpZbCswa3FNS1F1ZWU2ZXNRb1dF?=
 =?utf-8?B?TGRlTGxFOXdoVlA5WjBUdVpZR0w2QkRRZWdpVm9Qcmc2RjQ0S0d4Y2dpQzd4?=
 =?utf-8?B?Mk4vUzhHa2ZlQmNSYnk2SWFheEIvckNsK2R0WldwT2o1WXdjQ2t6UytyUlJw?=
 =?utf-8?B?TEZiNHJFSldmSjBjbm93T1FSWlZZMjRjMHZxRGRsV3g5SHBoVmYwNUVmeG9I?=
 =?utf-8?B?MUlSb3BRVHhuM0VxbU1QYU5pMnl0aEg0Y3R6Z2tRczNrSnB5eWg3T2ptSjFa?=
 =?utf-8?B?OGIzQVI1NjZoaDQ1RTVXTURFWnE1MEo3c05TeUNoaHppQnhReWVKY3FnczlD?=
 =?utf-8?B?SmJDckMrNm9YYnhxZ2VSbVcreVN3RTlNYytBZXRuaWdQaWxxVW5pUENtQ3pv?=
 =?utf-8?B?YStrdE9XVU1aNFViN2xGNko3ZndtVXoxTklZeGxUV0lSTVJXYStqQmtiRmRB?=
 =?utf-8?B?cnFreDFIandsV0E3Z2ZMQWNFejdpdmU1M2NjaU5PTU5RTGdLYU9DYWZzMU0z?=
 =?utf-8?B?aHZGQVZaRjVYYmx1eFAwWHQ3M0pVQ2pvR1FvZmtMWEtqaGVEZi9ESUdJbWhm?=
 =?utf-8?Q?K3AwR53DLqXNxSNFUeJxc2bQy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1a4e4a-f352-471e-82b5-08db241715de
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 23:02:57.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA0ORjEoa2fwLLgQHOpo9eSR0fqXQQYYP+DE/1qzzXuLsCADSisRbCqjg4slOKBFy/Pu0myKFlsWdhEHfBvkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

Am 2023-03-13 um 00:21 schrieb Vasant Hegde:
> Hi Matt,
>
> + Suravee, Felix.
>
> Thanks for reporting this issue.
>
> On 3/12/2023 12:27 AM, Matt Fagnani wrote:
>> I booted a Fedora 38 KDE Plasma installation with the 6.2.2-301 kernel on an hp
>> laptop with an AMD A10-9620P CPU, an integrated Radeon R5 GPU, and an AMD IOMMU
>> enabled. I selected Sleep in either the Application Launcher menu in Plasma
>> 5.27.2 on Wayland or sddm on Wayland. The system went to sleep. I moved the
>> mouse to wake the system. The screen remained black, but the LEDs on the side of
>> the laptop flickered indicating drive activity and the fan resumed making noise.
>> I pressed sysrq+alt+s,u,b to do an emergency sync, remount read-only, and
>> reboot. The system rebooted. The journal indicated the amdgpu failed to resume
>> due to errors including amdgpu: amdgpu_device_ip_resume failed (-6). which
>> started after the kernel failed to resume the AMD IOMMU.
> Looking into the code path, I guess whats happening is :
>    - During system boot `amd_iommu_init_device()` return error to GPU as it
> failed to enable PASID for GPU
>    - With my previous fixes, IOMMU puts device back to default domain properly.
>    - System continued to work with IOMMU default domain (without PASID/PRI
> feature for GPU).
>    - System suspend/resume
>    - Looks like in resume path, amdgpu_device_ip_resume() again calls
> amd_iommu_init_device() and IOMMU returned error for same reason (it couldn't
> enable PASID).
>    - Looks like AMD GPU tried to reset and failed.
>
> IMO this needs to be fixed in GPU driver (either handle error path -OR- fix
> original PASID enable issue using pci quirks or something).

I agree. We're not handling errors returned kgd2kfd_device_init 
correctly, which causes problems later on when we try to resume from 
suspend. I'll prepare a patch.

Regards,
   Felix


>
>
> -Vasant
>
>
>
>> Mar 09 20:27:55 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for device
>> 1002:9874
>> Mar 09 20:27:55 kernel: amdgpu 0000:00:01.0: amdgpu: amdgpu_device_ip_resume
>> failed (-6).
>> Mar 09 20:27:55 kernel: amdgpu 0000:00:01.0: PM: dpm_run_callback():
>> pci_pm_resume+0x0/0xe0 returns -6
>> Mar 09 20:27:55 kernel: amdgpu 0000:00:01.0: PM: failed to resume async: error -6
>> Mar 09 20:27:55 kernel: sd 0:0:0:0: [sda] Starting disk
>> Mar 09 20:27:55 kernel: usb 2-1.4: reset full-speed USB device number 4 using
>> ehci-pci
>> Mar 09 20:27:55 kernel: usb 2-1.3: reset full-speed USB device number 3 using
>> ehci-pci
>> Mar 09 20:27:55 kernel: psmouse serio1: synaptics: queried max coordinates: x
>> [..5648], y [..4826]
>> Mar 09 20:27:55 kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> Mar 09 20:27:55 kernel: psmouse serio1: synaptics: queried min coordinates: x
>> [1292..], y [1026..]
>> Mar 09 20:27:55 kernel: ata1.00: configured for UDMA/133
>> Mar 09 20:27:55 kernel: PM: resume devices took 2.703 seconds
>> Mar 09 20:27:55 kernel: OOM killer enabled.
>> Mar 09 20:27:55 kernel: Restarting tasks ... done.
>> Mar 09 20:27:55 kernel: random: crng reseeded on system resumption
>> Mar 09 20:27:55 kernel: thermal thermal_zone2: failed to read out thermal zone
>> (-61)
>> Mar 09 20:27:55 kernel: Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25
>> week 20 2015
>> Mar 09 20:27:55 kernel: Bluetooth: hci0: Intel Bluetooth firmware file:
>> intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
>> Mar 09 20:27:55 kernel: PM: suspend exit
>> Mar 09 20:27:55 kernel: Generic FE-GE Realtek PHY r8169-0-100:00: attached PHY
>> driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
>> Mar 09 20:27:55 kernel: r8169 0000:01:00.0 enp1s0: Link is Down
>> Mar 09 20:27:56 kernel: Bluetooth: hci0: Intel BT fw patch 0x43 completed &
>> activated
>> Mar 09 20:28:00 kernel: r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full -
>> flow control off
>> Mar 09 20:28:00 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
>> Mar 09 20:28:01 kernel: r8169 0000:01:00.0 enp1s0: Link is Down
>> Mar 09 20:28:02 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=fe80:0000:0000:0000:265c:5b24:c7aa:102b
>> DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=185 TC=0 HOPLIMIT=255
>> FLOWLBL=110208 PROTO=UDP SPT=5353 DPT=5353 LEN=145
>> Mar 09 20:28:04 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=fe80:0000:0000:0000:265c:5b24:c7aa:102b
>> DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=185 TC=0 HOPLIMIT=255
>> FLOWLBL=110208 PROTO=UDP SPT=5353 DPT=5353 LEN=145
>> Mar 09 20:28:05 kernel: r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full -
>> flow control off
>> Mar 09 20:28:06 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
>> timeout, signaled seq=49904, emitted seq=49906
>> Mar 09 20:28:06 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
>> information: process  pid 0 thread  pid 0
>> Mar 09 20:28:06 kernel: amdgpu 0000:00:01.0: amdgpu: GPU reset begin!
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: [drm:amdgpu_ib_ring_tests [amdgpu]]
>> *ERROR* IB test failed on gfx (-110).
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: amdgpu: ib ring test failed (-110).
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: [drm:amdgpu_ring_test_helper
>> [amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)
>> Mar 09 20:28:07 kernel: [drm:gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed
>> Mar 09 20:28:07 kernel: amdgpu: cp is busy, skip halt cp
>> Mar 09 20:28:07 kernel: amdgpu: rlc is busy, skip halt rlc
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: amdgpu: GPU reset succeeded, trying
>> to resume
>> Mar 09 20:28:07 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for device
>> 1002:9874
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: amdgpu: GPU reset(1) failed
>> Mar 09 20:28:07 kernel: kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>> Mar 09 20:28:07 kernel: amdgpu: sdma_bitmap: f
>> Mar 09 20:28:07 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for device
>> 1002:9874
>> Mar 09 20:28:07 kernel: kfd kfd: amdgpu: device 1002:9874 NOT added due to errors
>> Mar 09 20:28:07 kernel: amdgpu 0000:00:01.0: amdgpu: GPU reset end with ret = -6
>> Mar 09 20:28:07 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* GPU Recovery
>> Failed: -6
>> Mar 09 20:28:10 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=234 TOS=0x00 PREC=0x00 TTL=255 ID=40777 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=214
>> Mar 09 20:28:10 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=234 TOS=0x00 PREC=0x00 TTL=255 ID=40988 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=214
>> Mar 09 20:28:10 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=234 TOS=0x00 PREC=0x00 TTL=255 ID=41207 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=214
>> Mar 09 20:28:11 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=216 TOS=0x00 PREC=0x00 TTL=255 ID=41247 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=196
>> Mar 09 20:28:12 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=216 TOS=0x00 PREC=0x00 TTL=255 ID=41784 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=196
>> Mar 09 20:28:14 kernel: filter_IN_drop_DROP: IN=enp1s0 OUT= MAC=
>> SRC=192.168.2.10 DST=224.0.0.251 LEN=216 TOS=0x00 PREC=0x00 TTL=255 ID=42530 DF
>> PROTO=UDP SPT=5353 DPT=5353 LEN=196
>> Mar 09 20:28:18 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
>> timeout, signaled seq=49906, emitted seq=49908
>> Mar 09 20:28:18 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
>> information: process  pid 0 thread  pid 0
>> Mar 09 20:28:18 kernel: amdgpu 0000:00:01.0: amdgpu: GPU reset begin!
>> Mar 09 20:28:18 kernel: amdgpu 0000:00:01.0: amdgpu: IP block:gfx_v8_0 is hung!
>> Mar 09 20:28:18 kernel: amdgpu 0000:00:01.0: amdgpu: soft reset failed, will
>> fallback to full reset!
>>
>> This problem happened each of a few times with the 6.2.2-301 kernel which
>> contained patches which fixed the black screen problem when amdgpu started
>> during boot with all previous 6.2 branch kernels on this system as reported at
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2319 The problem also happened
>> with 6.2.3. I booted with amd_iommu=off on the kernel command line which was a
>> workaround for that previous problem, and the failure to resume didn't happen
>> when I put the system to sleep 5 times. The AMD IOMMU is likely involved in this
>> problem. I reported this problem at
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2454
>> https://bugzilla.redhat.com/show_bug.cgi?id=2177111 and
>> https://bugzilla.kernel.org/show_bug.cgi?id=217170 Alex Deucher wrote "Might be
>> the same root cause as #2319 (closed).
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2319 The fix for that may not
>> have covered suspend." at
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2454#note_1814352
>>
>> This problem didn't happen with 6.1.15 or earlier. Bisecting this problem might
>> be problematic because previous 6.2 kernels had the black screen problem on boot
>> with the default kernel command line parameters, and the failure to resume
>> didn't happen with amd_iommu=off. I'm attaching the kernel log for a boot when I
>> clicked Sleep in sddm, tried to resume the system, and the problem happened.
>>
>> The Fedora Rawhide build
>> kernel-6.3.0-0.rc1.20230309git6a98c9cae232.18.fc39.x86_64 has this resume
>> problem. kernel-6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39.x86_64 is the first
>> Rawhide kernel without the black screen during boot problem
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2319 and it has this failure to
>> resume problem. The previous build
>> kernel-6.3.0-0.rc0.20230223gita5c95ca18a98.4.fc39.x86_64 had the black screen
>> during boot, so I'm unsure how to test such kernels for this resume problem
>> since it's necessary to use amdgpu and have the IOMMU enabled for it to happen.
>>
>> 6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39 and later had a warning while
>> suspending involving amdgpu which wasn't shown with 6.2.2.
>>
>> Mar 10 02:21:24 kernel: ------------[ cut here ]------------
>> Mar 10 02:21:24 kernel: WARNING: CPU: 2 PID: 1393 at kernel/workqueue.c:3167
>> __flush_work.isra.0+0x270/0x280
>> Mar 10 02:21:24 kernel: Modules linked in: snd_seq_dummy snd_hrtimer
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
>> nf_reject_ipv6 nft_reject nf_log_syslog nft_log nft_ct nft_chain_nat nf_nat
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc
>> iwlmvm mac80211 uvcvideo edac_mce_amd libarc4 kvm_amd btusb btrtl snd_ctl_led
>> uvc iwlwifi btbcm snd_hda_codec_realtek ccp btintel videobuf2_vmalloc
>> videobuf2_memops snd_hda_codec_generic btmtk videobuf2_v4l2 snd_hda_codec_hdmi
>> ledtrig_audio videobuf2_common hp_wmi snd_hda_intel kvm snd_intel_dspcfg
>> bluetooth sparse_keymap platform_profile snd_intel_sdw_acpi irqbypass cfg80211
>> snd_hda_codec videodev vfat wmi_bmof fat mc pcspkr snd_hda_core snd_hwdep
>> i2c_piix4 rfkill fam15h_power k10temp snd_seq snd_seq_device snd_pcm snd_timer
>> snd soundcore i2c_scmi wireless_hotkey acpi_cpufreq joydev loop zram amdgpu
>> hid_logitech_hidpp crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>> polyval_generic i2c_algo_bit drm_ttm_helper ttm iommu_v2
>> Mar 10 02:21:24 kernel:  ghash_clmulni_intel drm_buddy r8169 sha512_ssse3
>> wdat_wdt gpu_sched sp5100_tco drm_display_helper cec video wmi hid_multitouch
>> hid_logitech_dj serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse dm_multipath
>> Mar 10 02:21:24 kernel: CPU: 2 PID: 1393 Comm: kworker/u8:10 Not tainted
>> 6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39.x86_64 #1
>> Mar 10 02:21:24 kernel: Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52
>> 12/03/2019
>> Mar 10 02:21:24 kernel: Workqueue: events_unbound async_run_entry_fn
>> Mar 10 02:21:24 kernel: RIP: 0010:__flush_work.isra.0+0x270/0x280
>> Mar 10 02:21:24 kernel: Code: 8b 04 25 80 22 03 00 48 89 44 24 40 48 8b 73 30 8b
>> 4b 28 e9 e3 fe ff ff 40 30 f6 4c 8b 3e e9 21 fe ff ff 0f 0b e9 3a ff ff ff <0f>
>> 0b e9 33 ff ff ff e8 04 d2 e3 00 0f 1f 40 00 90 90 90 90 90 90
>> Mar 10 02:21:24 kernel: RSP: 0018:ffff98a4c3de7ca8 EFLAGS: 00010246
>> Mar 10 02:21:24 kernel: RAX: 0000000000000000 RBX: ffff8d3350680340 RCX:
>> 0000000000000000
>> Mar 10 02:21:24 kernel: RDX: 0000000000000001 RSI: 0000000000000001 RDI:
>> ffff98a4c3de7cf0
>> Mar 10 02:21:24 kernel: RBP: ffff8d3350680340 R08: 745e72736d647564 R09:
>> ffff8d3386ae3c74
>> Mar 10 02:21:24 kernel: R10: 000000000000000f R11: fefefefefefefeff R12:
>> 0000000000000001
>> Mar 10 02:21:24 kernel: R13: ffff98a4c3de7ca8 R14: 0000000000000001 R15:
>> ffff8d33789e4f28
>> Mar 10 02:21:24 kernel: FS:  0000000000000000(0000) GS:ffff8d3437500000(0000)
>> knlGS:0000000000000000
>> Mar 10 02:21:24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Mar 10 02:21:24 kernel: CR2: 0000562f5c082158 CR3: 00000001459ca000 CR4:
>> 00000000001506e0
>> Mar 10 02:21:24 kernel: Call Trace:
>> Mar 10 02:21:24 kernel:  <TASK>
>> Mar 10 02:21:24 kernel:  __cancel_work_timer+0xff/0x190
>> Mar 10 02:21:24 kernel:  ? wait_for_completion+0x37/0x160
>> Mar 10 02:21:24 kernel:  ? preempt_count_add+0x6a/0xa0
>> Mar 10 02:21:24 kernel:  drm_kms_helper_poll_disable+0x1e/0x40
>> Mar 10 02:21:24 kernel:  amdgpu_device_suspend+0x9e/0x180 [amdgpu]
>> Mar 10 02:21:24 kernel:  pci_pm_suspend+0x7b/0x170
>> Mar 10 02:21:24 kernel:  ? __pfx_pci_pm_suspend+0x10/0x10
>> Mar 10 02:21:24 kernel:  dpm_run_callback+0x8c/0x1e0
>> Mar 10 02:21:24 kernel:  __device_suspend+0x10a/0x560
>> Mar 10 02:21:24 kernel:  async_suspend+0x1a/0x70
>> Mar 10 02:21:24 kernel:  async_run_entry_fn+0x30/0x130
>> Mar 10 02:21:24 kernel:  process_one_work+0x1c7/0x3d0
>> Mar 10 02:21:24 kernel:  worker_thread+0x4d/0x380
>> Mar 10 02:21:24 kernel:  ? __pfx_worker_thread+0x10/0x10
>> Mar 10 02:21:24 kernel:  kthread+0xe9/0x110
>> Mar 10 02:21:24 kernel:  ? __pfx_kthread+0x10/0x10
>> Mar 10 02:21:24 kernel:  ret_from_fork+0x2c/0x50
>> Mar 10 02:21:24 kernel:  </TASK>
>> Mar 10 02:21:24 kernel: ---[ end trace 0000000000000000 ]---
>>
>> Bert Karwatzki wrote "The suspend warning is addressed in issue #2411."
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2411 at
>> https://gitlab.freedesktop.org/drm/amd/-/issues/2454#note_1816958 I don't know
>> if this warning is related to the resume problem.
>>
>> Hardware description:
>> CPU: AMD A10-9620P
>> GPU: integrated AMD Radeon R5
>> 00:01.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI]
>> Wani [Radeon R5/R6/R7 Graphics] [1002:9874] (rev ca)
>> System Memory: 8 GB
>> Display(s): internal Elan touchscreen
>> Type of Display Connection: eDP
>>
>> System information:
>> Distro name and Version: Fedora 38
>> Kernel version: 6.2.2-301.fc38 to 6.2.3,
>> 6.3.0-0.rc0.20230227gitf3a2439f20d9.9.fc39 to
>> 6.3.0-0.rc1.20230309git6a98c9cae232.18.fc39
>> Custom kernel: N/A
>> AMD official driver version: N/A
>>
>> How to reproduce the issue:
>> 1. Boot a Fedora 38 KDE Plasma installation with 6.2.2-301.fc38 or
>> 6.2.3-300.fc38 updated to 2023-3-10 with updates-testing enabled on a laptop
>> with an AMD A10-9620P CPU, an integrated Radeon R5 GPU, and an AMD IOMMU enabled
>> 2. Select Virtual Keyboard at the bottom left of sddm if the Sleep, Restart,
>> Shut down buttons don't appear
>> 3. Select Sleep in sddm
>> 4. Resume the system by moving the mouse or pressing a key
