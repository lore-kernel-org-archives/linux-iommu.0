Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB115AA
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 03:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFdfoJYCC8863m76+kGAEM3kgRYt7RBQSP6wiaMGHHE8e8sjnwyQouNcLEyctNjzp9onmvPNcymNKDx+AVnKbjHCBqwWhbwh/G4eKbfwv07cjQzcKto4pVY7Gv76ROjOaLJ1h5+oF5Vhpvbiv0NFpgJpc3ZiwtPtYwNf1Bb7SI+rEx5+VdB/8uBPN8Bhj+ws3/2FUD9pgt5+G9f6eNxzE+GZt8X0K2omqhX7OjvOyk994jap96zCU9kJ+Q1eNjHDfF17Uj2QsaD+6X3eFXI7EFYP3odTk6+5Svc0mpru59Wnrdt7uLgBmuzQvLCSdm/oGLLMboTOoIjUn6lPx9lwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgHP0s/3wK+zSQIjTlXVHlDmupOrscd20TUSxUSuMXs=;
 b=WTxzmeLc8dwI9PjX5SnGQTAw3MUZa2wwzbd/Z7ndbFIqS17UZNNjDTAhXmH7nrjZMkpMNM0eW/HPObD+L6Pas+Zz7lOBKCfUnilxSJ0zD296WYopG/bmfb4++NWp0zrJ7N0TvUDXWpir5s/9pgmgYaW3F+dore9IBkbmzhaW9zU2HDVZmD1qthMRxs3nCZll6qTPniSHcDO5Nvzb3+G3EEQzH9YlemU7cG271zzJU6l7JB+DxKBelgMuXVswVJr6PL9grHHhYyz1GGnEYsaW45ywAa1GjPrq/Rg0NF+ZPZ2QwepPuI7ZEhA/EZx8Ou7/8eM0j9WQ7HPEuaZ/r/WU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgHP0s/3wK+zSQIjTlXVHlDmupOrscd20TUSxUSuMXs=;
 b=OucEeQAhmc6tZDhSTCII125uEDbwzcWn4vfzkHFXaUavjGAzzDVZVUHWu1T1kzUobZSr/Pd1kwFa7/y/GtB0zocGALZN7gDOe/muYsIwY8nSQOEFwENQ2cMm9/uFzkZQi0RXU2u75tsn9KuzeOqxkQlaYAc1CZSnC76idLKo0jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Wed, 13 Jul 2022 03:08:01 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 03:08:01 +0000
Message-ID: <1ac048cf-6949-c622-5b5c-5f32f5133053@amd.com>
Date: Wed, 13 Jul 2022 10:07:51 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/7] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <YrQhGYBVhsaNOgCH@8bytes.org> <5ad3770b-16a5-9148-54dc-5dcb93efcc81@amd.com>
 <YsVSb2LssZINNsOm@8bytes.org>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <YsVSb2LssZINNsOm@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b1bda7d-890c-42a3-ad9a-08da647ce523
X-MS-TrafficTypeDiagnostic: MW3PR12MB4396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cto+tIb3tq3kdvv36j0qZ0uOv2Nq7IBkoZCuCEzy2TMhzDkdFxeN0a5kM1MHXtQsDcbVEiyfHuvm+hsqxnpvOUyBvN4w37xm8JpW7GWZC/GmT0ZrXFtHGTC9v73IHap4SubhnoCFRk31QMVubGber1SJ4xe73dd1oqGS9GZn5xF+0/LqeY0b7lpooB7s5IchZoOxwEcGsOwfbn3QVDbDy6A8h9cZbPkpJGsOmNDZHch4dVQ202XM89cskpVlOJPZR0SCjivM4NBDkvpfVKHWq4eTr3Jv4888MNhcgHl78hDWTkkbHkA+MPBZ9GK1YEo0AvLHpOUIurpWsv957Dm8rHHGpCClLWcEbWFGBgzNQlw/dNoTYGjDYkZQ+0odVbha1Y3ydoj1m9OKGThDkxK1UyyGnc+f29eadFrC+QfGE8u91U2Gs/YnTWUzCQD5oJNM/+nimyzmRQKn9nmV3KphicawZ/ievtnMfwkvgXww7mTwU37nKKCzsvrYCtuIwatzh4TgYb2jmeEjnHU17/qvtZNhu3XOIh+R8rwvnVDuTBRhzSGJzhec/Pj1pn/7KuaVccOltBnTWaogO4JclyKtZ/ydJwQb1qmF9axCyrsuMw6R5ZPciFIFv6/Brx3CKkCu+Y0mAgXVIBeK/m9+OXyrX8e/H4H57o8AWLGE10yOgEW55YfbHPqaMPtDmzTLoXareC1wglhlk3l2oqscwtvv66A6cU3Uk6tRuFuNt9Nad5OmDIVbNva3jUi7b4lIHzpFBM4iZLae6ICBmB4b+U9VmTNqkSFA1dLgVgRk7spwvCZAocqIuSY3bG1oJ+R1aolw1Wg+UqTmhwZ+7LSJHXwSOAOMrFatwGFN535ZtCGzqwXdQ1MEnMFBUJD19uXGt3IB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(38100700002)(31696002)(5660300002)(8676002)(66476007)(8936002)(66946007)(86362001)(83380400001)(66556008)(6636002)(316002)(2906002)(2616005)(6506007)(478600001)(110136005)(4326008)(53546011)(31686004)(186003)(41300700001)(26005)(6512007)(36756003)(6666004)(6486002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXV3MVlNT2pNV2ZTbDZvZHB2c3dwNFJ6MzJscXZubmp6Wm5RYW1qSzZQdlZE?=
 =?utf-8?B?RTFhNXYxNlRQY3kzd21NLzFEYWpRclRmTyt2SDRCRk1lWmt1Y3M5b1BNRXdm?=
 =?utf-8?B?KzkrZWR3MWN5cGZsUlcxNXJhRHk3amlNZnR6QStUazRJT0lMMGlBU3dhVU9R?=
 =?utf-8?B?VlRHZmZITGhVYjI2bkdRZW5tOG1DQ2tTWDFjQS9sa0x3c1pjbFU1OWwra0Zt?=
 =?utf-8?B?YndLQmp6Z2d3b0ZjMnBDWXB0aDMzVEQ1bDVnei9QVkhJZFcrbFJ5Q2dnODhk?=
 =?utf-8?B?Zm92cmZRR0E5amMzL2RlNjZ5czFEY0UydUE1Z0trdFpNN3lEUnhuZ1RGZ3Nv?=
 =?utf-8?B?TmJXRzhKcGNsd1ZZSlpDR01XMTBtWUg2T2VKTFUvZVFqdnJlcUEwWk9wVU5M?=
 =?utf-8?B?UUx3OVBxT3JWUllWL2lLbW5ZdnF2czVWRXVqejFwUXoyNWJsTndIakV0MzlK?=
 =?utf-8?B?a09DY0RscTBFUzIxbEFRU0ZHUWorWVJRNkFFNHExeE1lT2F1WEtaV0p2ZkQ1?=
 =?utf-8?B?eVlSOUZmc1RuTEdadk9FRGdYY2tIM0FJa24yT1N0MkdERHdPZ1FmMGh2VGZt?=
 =?utf-8?B?Yzl1ejNhdmNMbkhNVXExL0xQdmlnRGZjT2piYXlBeXdnYXA2TDd5NHZDcnd0?=
 =?utf-8?B?UHhpbTMzVFZYaWFlK2x0ZE5xcmdpRjFwSFRoa3I1U3l3bUR3VmFYTGN5SGgr?=
 =?utf-8?B?THN3M1drR1ZmakZlMnpqUG9ZaGdSZHpsUk9YSXZhRWx5ZkRrbXkxT1dGS21p?=
 =?utf-8?B?U2Rjb255S3dnY1c1cks3aEFSKzNsUkZTN0pWWDVrWDRRVlpmTjFLR3JReFZh?=
 =?utf-8?B?Y3prU0RZQndQSkRSOVhqeEV3TUE3OC80YVdFVWRUR3A2dFJvaW1uWTgvSlVk?=
 =?utf-8?B?bmo4VnRMSTI5aFNFYlZtTk5VSUxIeFVrZ3Z5TnBSMUR0aHJQSGlQS2FzSDhP?=
 =?utf-8?B?UjJkNW5TU3hQZjErZ2tIcHVHTUplejR5RUNsOTAxRVc2UFUvblFnaFpyY256?=
 =?utf-8?B?VXZjSlZQTytJOFNTUWNjWElzUndZcDg1c0FwYVpPdUx5cU5HeUdpSysrRENP?=
 =?utf-8?B?VUlzZ3MvdTZySWR2WUdPbVA3MWJ1NDJxdUcxRWYyUzdRWjV3RzJLOG5KYkVR?=
 =?utf-8?B?UGpxT01WOTdwR0Yra1J6di95NHRibVFxN24yNHhvcHVLbURnVlNieEY5SGdP?=
 =?utf-8?B?R2Y2THZ6QlE5RWdBNVpNaHVXb2tUM3NzUWFSK1hSL2VsNWpEakJsNkJ5aFh1?=
 =?utf-8?B?bExUbUFBcmh5TmdkZHNmR1NQUncvS1Q2b3ZoVWZ4Si9RYXo3dmhmZVIwWTIz?=
 =?utf-8?B?RzNkZlBQaUFOeWtsU0VYbDZnKy90Vk5ncU9hNGR2bjlWWkFrcDRUTS9jZTlI?=
 =?utf-8?B?UzhUcXdOWndQSGJmd3I3VkgweVFEOHZ5ZS9vdVBFUXh2KzlKMmVnV3dHelc3?=
 =?utf-8?B?V0RqM3dQdDNtNHdMM1VRZ3I3SVc2VGJvVElPQjU4RDBuK0tSSHRRaWZ3OTVC?=
 =?utf-8?B?cXFHN2lwLzU1elVhaUJzOU5wR1dWVVB5QmxMSG5yOVZlRzc2SnZxME9vZjRl?=
 =?utf-8?B?Qm5Rb3Y5elZjTExsUWpDV3VyZVRTU0ZqVHZieU9tN285OWNTejJyVmI1bjZM?=
 =?utf-8?B?MTJLbEdBNUZ3SE93UnBmMDJtcWdEUW0yeGRaK1hLdDRlbjE5eEp3ZDhyOGNM?=
 =?utf-8?B?eDRLS1FZUzB3eVBiRXlDSTc4RFRqR1hTZ2lvVlIxYS8yK0NDZis3cmNtOXJw?=
 =?utf-8?B?UVYyWEJiK0haNE84VzYyZHdYQlk3cGhWNk1tMVhGeGUySjhRZW1mQlcvVExY?=
 =?utf-8?B?N2NBSmIzRUZ0QTR5RnMyeWlYTHM1RkszQXR0Nk1yRi9pdTBtQnNOREVGUHhQ?=
 =?utf-8?B?cUw1NVFJdFNEQTEvQ3Boc1dZdlBHZHdpQnArVjJwbzZnNk9tTW50T3NQb2hD?=
 =?utf-8?B?c1RwYlhxUHRuL0k1c01TU2xuL0hhRnM1bjUxek15MFVFbGZjZWtIMGpKQzFR?=
 =?utf-8?B?NlVjRWJ2UThZeHdLTTN1Mms5aUZpSzVnemNkTytoYWdjeHVmSlRTdmVhTHo3?=
 =?utf-8?B?MmZ3a0xVV0tTU1c1MFRWaWY1TnVHUGdNVDJlK0h5R2FiUGFLWXF2cWRyMWp1?=
 =?utf-8?Q?QRDoWHpaqGwYDnxKjpjPgEENz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1bda7d-890c-42a3-ad9a-08da647ce523
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:08:01.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi8QjJpcvxtA1SnqpFMIw13J6BQaRyeY2JEuKBpRaUyenRbCpoiohis8CdVvVKpcO/z6hqBMvdW7JoDiuQhx9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

(RESEND)

Joerg,

The goal of this series is to allow DMA-API to use IOMMUv2 page table with PASID=0 (instead of v1 only).
The main use-case is to support nested IO page table for vIOMMU support (work in progress).

On 7/6/2022 4:14 PM, Joerg Roedel wrote:
 > On Tue, Jun 28, 2022 at 02:35:51PM +0530, Vasant Hegde wrote:
 >> Sorry. I didn't get last statement ("device identity maps DMA requests without PASID").
 >> Can you please elaborate?
 >
 > When using v1 page-tables, each device supporting ATS/PRI/PASID needs to
 > be direct-mapped, because the v1 page-tables basically act as a stage-2
 > page table for the PASID ones.

For ATS/PRI capable devices, it is currently handled by the existing AMD IOMMU v2 APIs,
In this case, the v1 table (stage2) is setup with DTE[mode]=0, and we set up v2 table (stage1)
to bind the process address space to the gCR3 table with the specified PASID.

 > But when the non-pasid case moves to the pasid==0 page-table, then there
 > is not stage-2 anymore and a device can be used with ATS/PRI/PASID while
 > non-PASID requests are translated too, no?

When we setup IOMMU v2 table w/ PASID=0, we also set the DTE[mode]=0 to setup
v1 table (stage 2) as identity-map (see set_dte_entry()).

In this case, if the device doesn't support ATS and PRI capability, we don't set
DTE[PPR] bit and/or DTE[I] (IOTLB enable for ATS)

Also, in case of booting w/ iommu=pt (i.e. identity mapping), we fallback to using v1 page table (setting DTE[Mode]=0).

Regards,
Suravee
