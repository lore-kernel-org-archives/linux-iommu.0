Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790F11C83
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 10:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu1ob5hcw4SeioKAveKgvGiuHFUJbZN/P790OsruZGkZYnh/7G4kgNB33PdUz4nTIPlMMihfJy71/4/t7CkykS/TfYR/XptgSu5a6f8UUU/weqtG64i4Xf20ljzYUk/owaz4bGRnXiN1OD28Hn0y1KOssRvppe9iJf3iV8wu51cixHYs6KD/NMlUVPX2OMdU8NIwNg7/rVWPPs0sHPNo3sRePhqI/H90vQMVdbQ7X/xaJERXnyJghScTZ4Ron5OhesH2kn6wTzeZWf2ITQi0HJmFqZsMk10w/mteF1qWUt3Q1Fr73rWASA1pRxbfATu9Bqj4zv0AFKpeTjK04s49eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x60NFHj40gAYavlXd1xbuAX/71CgatoVWUstuUCsuc=;
 b=gz9/dVdQc4DmvG7aF16iYslfw3cJGxbe8mINaW1YoyWZJYV5tVLoveRNaAS/D1GLad/amkXtWmuAupdkADD7MSS4ZMKFNzLrgudybyyUC0mOFk+qhKwvOlcwhse9ujTo1WsF1nJgOOmjGCypOPqRmCjGrroQTFf+AnAzc8v1sTNKIVXMVVxUJYTrKXnzGvSyt7rRpbWjr6DrwxVzFmeJQ+VWS0tkDHYyDMi7bVo8JvgTkT9dagLWcOIKaNGFN0N56fAm3eszyb3zBwkMQs8JQKwJJoWdqPtb5NqJLMHoAy4/5W83nZvSR+9wqybs0fE1U4e8Y2pU+zW89kNybFcLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x60NFHj40gAYavlXd1xbuAX/71CgatoVWUstuUCsuc=;
 b=fDLtbrVsLPJTR/OmSsP03P+Lap4h3umkow5w+2A7a/EtXKiHmbfuqolNsRRUchkHwkQ+uG7PnmQ04FAJ+8/HmFBM6u02HZFcG8y/PNfskQBj8ILNpEeIzJDnxEQxHEu6tW/nhysR/x0azxu/TZKVCGHlzhYj1p8IrIrinFrangA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 10:45:56 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 10:45:56 +0000
Message-ID: <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com>
Date: Mon, 28 Aug 2023 16:15:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable SVA
 feature
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com> <ZOYljfDOgbzVeBeX@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZOYljfDOgbzVeBeX@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b7a113-1da4-43dc-31f4-08dba7b3f577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XU96uQalibZ8RH3u4NobTzpFRhJ3GnYSzeDeEqLTitFL2HnTZ6pWgcJKBkJH0PQ9VUdZZtgqUY2KdgNQzU4VjjXMt0tGzEJY0aYa9igtHblssXqIumfDsabtCS6uOjDv54VgvAmX5O2jWAK07LPSWktWyH6784I2s+gZiQHDm4Mzo4SJahQfqa8UBiNyxC7jF0bEAA1C0JmUGvWRFzEBniuFSMqKVTt7zXW9cRjzN7lVsdznC0VGJrJ+ay6YSSQpH/9UFdKiSKi6kej09deNoL6CRd0z7DSs65Ao53QIHCf6WkisTWsRaR2WWIE1RV66Q02HxHOTM5zC+PvmtjLShWJ/MhWklFNqPD5U/HcogumLW8oalYG6DBOMfBWS3H4QUsRMZLMiJ7XXxW4ndX7lSr/V051TBKJBQWuixsFu6ZDXrTtIfstpvI5ViskF03NEkjhgC6R+wkpnrvoZ5k61aanhmmScF6Leqji7XUvmYjfLxZsh6ZVjib4PehFMadlaofFamhHO8XUQ+Yz/zeyqJNsB7dzXPRsBIh+RXwNV0i67jWshNdd/aOj//wbmx0S4kwDxdYealKyiZsupTEN02Imlha9LvvhO88jEGslz9iS8716+U1IMZMKrWLlfefYQryADyERP7XPH4ut/N2tiKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(1800799009)(186009)(478600001)(26005)(31686004)(2616005)(6486002)(53546011)(6506007)(6512007)(6666004)(31696002)(86362001)(44832011)(2906002)(316002)(38100700002)(4326008)(6916009)(8676002)(41300700001)(66476007)(8936002)(36756003)(66556008)(66946007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJQZUg5aGJkUEpvVlliQzRTWkNxcWxEZHVwNUx3RnY3YW43Uk5KUEdldXVu?=
 =?utf-8?B?SmxPMEtnME9TQ2dkUlZYMGhIdytIM3I3OWNacTErRUt6YjE0VGo2U2FmM2lC?=
 =?utf-8?B?R3JzQVlXRFhKMlFJOC9qSkVvcmQwSmJvZk5ZaThuT0JNK09TM1ZjdEJETnho?=
 =?utf-8?B?algvTjFDL0xpd1NNZ3AzbjBhV250VE04NFQ5N2lSdE9Rdm5ZcGNST2pWT1ls?=
 =?utf-8?B?UmZBN1hXWDl2eFhBRmhHcmNqRkI5QTVWc0hZWWJIY201UHhxcmNocVY5WmpR?=
 =?utf-8?B?YWNKMXNPMzBxRE1GVVRwKzNjS1JiQVMwdjl2Y01DWnpRb1ZPMWVLbWwzOU5T?=
 =?utf-8?B?VVB4TVl3UWZad0piWkhJdytHT0JVVjI1YXduY3hWLzhBcjlLcVZyMVducTR1?=
 =?utf-8?B?VjQrQUZlQURFWHdETldsUFJ0V3BQM3pqSnREdXZlWFhubzhZTEJVTjYraith?=
 =?utf-8?B?YkIwcUdlU1o1a2hHa1JTbnhFOWhWSEVab2JRZVlmdjhLaENIU1ZrOHprRUhV?=
 =?utf-8?B?NUw4REltY1N5N0NkNEdpbXo0VU1tcTNwNkh1T0srQmhJemJQUU9aMWZSYzJl?=
 =?utf-8?B?UUpITnBkeUtSWUlqdmZjTmpFQ2hPRDY3L1lpSXgrRzlEZ1NhcElzUkZhKzZy?=
 =?utf-8?B?SmdETmVKWVZmcWwrSmRETlFZN0VydkdYRWlIYnh0THpTSDNETU1qL1pLWjBR?=
 =?utf-8?B?SnpIbFYxQU9ZeEUrRzkvUEl5NXpXaStSZG9PdzhEUkkydWl4cFJsWVFrS3U1?=
 =?utf-8?B?enlVRWlkZTFLSUNmZzVxczlaTzJBbU1jQk51M1I0VDN2SmFHdTRQRi9vTWxI?=
 =?utf-8?B?UXRPU3hxZ05rckcrWWVudlZSNDM1cWlIS3JVM3ZuWXFZN1pNRm1EOEZpOWFL?=
 =?utf-8?B?UFBpVW9sL3RtMkdncTVkT21ydHR5WlFSY1cxMmEvWGZ0Y3FEYkswcHZlNFBt?=
 =?utf-8?B?RnZieldtQWpva0czclVabWUxdFNSK2UreDRYVGJWeDhpK3ZYdnc5VjJHTGdr?=
 =?utf-8?B?VWlycWRDWDVsZGd2b2lHVkV4T29nY09Xd1NqZ09NSTBoajhCOG5BbXJXdThN?=
 =?utf-8?B?Q1B0VzN4L0RKcWVQSHl2dloxSk1KWjdOaXBSYUhOdVZxbFZtcUFldXo3Rm05?=
 =?utf-8?B?MFE4enZ2WU53N21iaXp0a3hkWDRFaHhmOHZjQUtveUdKSWIzd1N2c2k4bE02?=
 =?utf-8?B?ZnpTMDJDc1hZL3hFYjhqQm1sRTRCQm0rWGFjcHVrSExxRUtWb3kzUUdTd3Zw?=
 =?utf-8?B?cjlIVENKTmgzTkhnZUNTN3paOTVOV0hlbDRZZVpGMzFKQzRqQ1NNWndHUzM1?=
 =?utf-8?B?QUI1bEJxTzU3ZFErYjRvQWNBNXo1NzBCQ3I2S014eU1YanBpU3FkVTArYzFr?=
 =?utf-8?B?aldyeU42RDFadk1zNGQyUjZ6RDFxd09lM1M2WVRQUXd5NzU5TWFKT2YwbUFv?=
 =?utf-8?B?ejJhcWovdnFTcVdEVXBmeUZPVlJzRlNLUEZRSHNPcnNFRVBQZzRTV1kvcWFk?=
 =?utf-8?B?TW1zMUhyWUU3ZHJoK1VHdnIrWG84RDJybG9xNWlwUWk1R3Vra0U4Vm1KK3Zy?=
 =?utf-8?B?RUtCbXRIUndvZmFpOE8zMzA4aEpGRnVkZHlQVVB4b1dMMHZUQkdObHIrUzhF?=
 =?utf-8?B?ZHZDRVNLc2dKd0s0SzlFQ3gzWDhUbXNnM0kxNUVacjArTUtiU1ZOY0tvMG8w?=
 =?utf-8?B?U2xINWJ1OXZTQjlKTTZBTGJXajJJM1JNckE3M0I3V0tUOEJ0RVgxNnpxaWs3?=
 =?utf-8?B?eHJsL1haZTIvNS9OQ0J5T1JDTFVFV3N5NHdJcjcvdllCSUJtTFRHUWNXWjZD?=
 =?utf-8?B?c29vL3hrbXd4TEhoRzI2aEY4Z0ttOXB3cDlpZDVzamNXaEpFSU9kWWVYUEZr?=
 =?utf-8?B?aVhlZXVDcldHS2Vqb2kzMG1NNVNMZEppbGhNYVpaZWhZVDJDZlozWjcvL2N0?=
 =?utf-8?B?b0ZSb0VaVGMzTVZVeGhyRkdOc0pIdE5vVk5HOW9OaEl4QU5kUkFkOEpHZFJU?=
 =?utf-8?B?QXRRR0lGVFEvQmtVMFRONk5HVnFwaThQSDArU3lMVWFmVUdvTUdPTWN4U1Er?=
 =?utf-8?B?RFBDTzc1YmxxSTBTaFNlTmdSaTBqbVYycjhGQ1JFbEY1UUhyM05kbnJXV21D?=
 =?utf-8?Q?XVKDKO/FsB8cNPrLXOUPUet4c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b7a113-1da4-43dc-31f4-08dba7b3f577
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 10:45:56.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zXCMuctFe3NZlSSKgjI3kTrlqYMoSZUK8NzAeLXcXkfgiBoUCvNyOuB42M99pdH9LVwAXXJRwbQlzmyrPLXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Jason,


On 8/23/2023 8:58 PM, Jason Gunthorpe wrote:
> On Wed, Aug 23, 2023 at 02:04:09PM +0000, Vasant Hegde wrote:
> 
>> +int amd_iommu_sva_enable(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +
>> +	if (!pdev || !iommu || !dev_data)
>> +		return -EINVAL;
>> +
>> +	if (!amd_iommu_sva_supported())
>> +		return -ENODEV;
>> +
>> +	if (!dev_data->pasid_enabled)
>> +		return -EINVAL;
>> +
>> +	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
>> +}
>> +
>> +int amd_iommu_sva_disable(struct device *dev)
>> +{
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +
>> +	if (!iommu || !dev_data)
>> +		return -EINVAL;
>> +
>> +	return amd_iommu_sva_gcr3_uninit(dev_data);
>> +}
> 
> I think these features are a mistake, you need to implement them for
> now but I wouldn't touch the gcr3 table, and disable should be a NOP.

We need to configure Device Table Entry when we enable/disable SVA.
Also based on base domain type we do adjust the GCR3 table.

-Vasant

> 
> gcr3 touching and enforcing should be part of generic PASID code and
> be triggered naturally when the SVA domain is attached to a PASID.
> 
> Jason
