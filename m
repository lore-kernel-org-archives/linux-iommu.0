Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CD134742
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236390; cv=fail; b=WaERkzIunxHeD69kISGaUFfNc/prxP3L/AlGyx5BbYElNhvX5rSp4RF7z0uoQ116CO7D2nzOKDuqmOMf3ULpFswFOcM8WshT/dcLVK9S/a9RH6DPGdJYNYj62zh+DBe2C0XN03/v++dZWsSdlOFGrq7cEig8wsGMGyCwMshcJzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236390; c=relaxed/simple;
	bh=Zc3N5+deyytpxua28xWFla2F2aF6g/LMFFwa/Gmm4gU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R653mr3ojlpTxz4VTbgMpCynDRGu8GTBnRvnM9xWMiZ8ZUVBXsWrMxFlduj8jfJgDZkNZybfNkzMYvgcgt7Ab6fLhlKmdAn5LrPHedPD7zq8ZBflYQiRS3184D2eF/TECEXleswjUcDDqOKsTvL5zOJnKDnC/C5S88Mw1d5QpjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3k28bg8; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3k28bg8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET6mGgrUsULKOF2KAjCPfpZCuzOJgFmMhzYuEIyfzZNAsoyGbW/XyvlFEeSCBlSL/TXdD89wn0jV4+P+fuXB7aBRFKYVNUYa602DRElceohStMmR5ucWTTkJ3NEbyjPR9tJovO8Zsb9M/04R0UXV2ABxXs5hzBsfafjlUNQnrWol0X16ql8pMD3yKc720qQAAIg2xlXReUcbVrlUAwMgt2KqJyhqDSwUq790rMpt2sNaOcPf/fDW+iZ/Q8X7v+kyuTZ7wtBe7MKMCa4bpKBGCaHoS1tsd/KOWv7mGmKY0dkC+1aIK+CdR4PHeqDenQd8ZiEGYfTnk7BpFKdZJQ+Rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btjZfpVD7BFrYCuuun8mX8x0wZJq1kMEsJ7q3UpNiZo=;
 b=kHiPxtR1IZE/ibfwnh5dOR1eAF/1JWwrfp2RZCzxFi/nRi5KFk0pz2AAjnwKIZpV4aqKp+TjmLFsI7pnNpcN6mxNINWPMLikM/wPA2wWQhrg0FNARdEsdKycsNFEu3QPbyk4wkPG4DAnVpJ1O8nM7jjT7qrmUM9jHivCsduRX85i/GhhA5LhAI9Sb8p47mRWibP8QwRo+lbLmK8KO+9keU5EbXRVo/v2G6wyb21ezNc60y86GTnKnS9HT0d+V7jww/8Ili69sDWK+ZXlKouCj2/72sj9vVk50kWqBRAcXjnplIES96B9lKORxTzvHZAINyDciB6EZIXZcjxtc4cKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btjZfpVD7BFrYCuuun8mX8x0wZJq1kMEsJ7q3UpNiZo=;
 b=G3k28bg8Htl8vYNePmNocBqkgfHJ7RIOPDfYwKi/+F19fRpJRrFuwgOjvxYmLIkoq0qvDRz+bsWMk3y8AWeBMhh3nK5iJFMdpC8djRFcy4UATOE2NTQLSJjGw2N7oitFp6hOAv3hsG4f6lrnnk2uZ+Ejes3F0Ccc41L5jpEZS2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Tue, 6 Feb 2024 16:19:44 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 16:19:44 +0000
Message-ID: <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
Date: Tue, 6 Feb 2024 21:49:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201214949.GT50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4fc893-eb16-4470-7ab8-08dc272f6dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N3+hDpyK47fVIUFwe1AqQRXwc/cL309nylZ8W+pvCSbKBP/0SoUvKCyoGieOs7oLTc67FZ7xLGtwhzerMAi3/Irzb3AHgSkgIvxEj6iLbHkwpDxeE8veiBfmeXFF5kBRifH0MHSJWvdmUKyDcd5lFpUCkOgD6cp8NqqONgjZRxVIPb4COBzGijFPVBk23YwIQx3GHfsb6evVS3B3fwcj/aArXVjCtQE3nkMsI0bK4CpBcde4cS/PRJRjgHo6fBYu8DQN7kKMH5aIvE8cWgW2u2XC98HUVRGdylijLSCWSQucKF1qQeXnf7LhL/+34hql2aY85vNNB+BPc5N0eqJ25DTvV4NCs7w1vXWHOKBklqSg9HVwRx46c5FlFzq4EQ2KytGQSn2LTYlUBBMwnDi4osim+IuTQFdR/wczILvrgEqsYYyI2OPzsABJRf4iSEqIxDZIKyN3cbFYpskio6DHyqtZLndLvWID7LsratE6WaZ8XORxn1YmInfSKRhT4/Oc3MwpjXB1jYyrSuB4muSyUGsmwRea/VQDDQSp0abFfh0+hq/elyPvRRxr5oVWy3HyAWzpeuMfyrSpse+FIyuj/1LvUMxcYYGeekR71SsWZe2cGYwdOdM6YGuuwB0j487KYiRU4T9mlKmFrUqvVnYvPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(26005)(36756003)(2616005)(41300700001)(66946007)(38100700002)(316002)(66556008)(6512007)(83380400001)(478600001)(6666004)(6506007)(66476007)(53546011)(6486002)(86362001)(6916009)(31696002)(5660300002)(2906002)(4326008)(8676002)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNCb1BYSTVLSlc1dlNCcktxTDNwVm5lQ0Rwek53MHNxWnRwRVJIZVJwOVRx?=
 =?utf-8?B?ZCtXVDFabHI3THRER0NDNUQ1N0FaUFpVVk5RbUhSTlZGcGt4OElwaXpRM0Rx?=
 =?utf-8?B?dm5aU1UyYllQTVZtdzZFYjU5YzN4YUhMajdBN1JxempVMkViWkR0V2F5c290?=
 =?utf-8?B?d3Z1Vlo4MDBSUmkzZTFYczg5Y0NSeEZlU2x3aFlMZXpQV3F1L0MzVXRxSWJW?=
 =?utf-8?B?ZjQrYWZ1OVNnWEQ0WU1TVUtvWlpXZER3VUF0TSt4QkhpZFBDQU5lQ2k1Ungv?=
 =?utf-8?B?Z1E3K3VFbmlLamNWRkZxR2ZIdWp6UlZ1dGFLNkhWaFExbGJnbjlNTnk2NzJ1?=
 =?utf-8?B?am9CTlBMQWdpRUdiZCtwVExkQi9yOEJtM093TXdzTlNrQkJBRU02K21nakFL?=
 =?utf-8?B?ZGY1Y0t6R1ZTWmxRaWZwNVczTlFaa3MzeHhDR2pZbCtRRm5RQVo3M0ovWm9a?=
 =?utf-8?B?Ym1wWVIxcGNIZ0dBa1BYbWwyQ205WmtUQmJFZ29hQUNyT2FnYTJQaGRkTVhN?=
 =?utf-8?B?eFRuR0VHTWl4LzNSWFFWaWZsZ0FMZjZIN1l1SXZtY2ZkZ2NiNzErS3kreHUw?=
 =?utf-8?B?NzdHR3dmaXdkbVhNNTZmU2VHUkFxMHBKNHZPNFpmT2VPM1VUSkYzaEF1UWlv?=
 =?utf-8?B?TEEzOGViRFhpNys1R1NkM0pjTVhzU1J0Z2RPSTZGaUF3OXBDRE1USHR4cklM?=
 =?utf-8?B?RGNnY3JCTGdKcWZQMm95amdxcXVRSzh0b3EzazBiMDhDNmxnVnNmQVdvakx6?=
 =?utf-8?B?MWh6YlREVjZXdTM2bHZpdHBJTXdKblNYOXhQVC9wN0xybVZiYjBoM1M4YkQ3?=
 =?utf-8?B?YzN4bzVWb1R5L2V5RDVmZ1lZV1pURCtVVDQzZnhZZ0pXNXUxMEN6UWNRSkdN?=
 =?utf-8?B?bHZnYWU5VStMZ2NQU1MyelcrWGpURG4vUlQ1NDZtMDV0TlorWFVFeUZuSGh0?=
 =?utf-8?B?UTVQeEhsVGx6dWpLQnA2TGkxdmhKbmYyVmdaOVFscTV6S3NBNlRYdVZKZlhB?=
 =?utf-8?B?NkczNWd4UnZxL1dyTkJjUmlMRWZxemlobk9TU2plY29TVkNRSnhydndxSy9X?=
 =?utf-8?B?M3d2UytCQUZtTXZXMS9pWVpWajd6NmxqZFN1VSs1RjM3TnlCUDNvNkpGYjBD?=
 =?utf-8?B?M2Z2R1ZKb3l4UndaNWpKZXowUWFCVzk0dS9hVUQ3c2szZFNaZ3dwY29IQ3NJ?=
 =?utf-8?B?ZFRHckdZOGxGRFNEYWRLbWdlRVh5RVlaRWN4MmdiVmo0UmVENWk0aUhRM3Js?=
 =?utf-8?B?bzNJdEN1YWg0NGxLL1g1azFUeUFQZnpEenovRGxVTWI2RHRVdkJlSUVTcXRt?=
 =?utf-8?B?SU5Td0RCcDJXSnEzNjhwbkdBN0RWdUZDSmtMSU4rNVEyeFpGaW43b1Zub0RZ?=
 =?utf-8?B?VmQ5Yno1c2FvNkowNnVDb0RYNElvTjkzOUxtbDRLcy95V091TUxGa3ZBNUxS?=
 =?utf-8?B?Mnc3Y0txcHBDRDVnNzZOc0dsWWxoUFdNUk9MNU1ybjRZY0RsanlXTnN5eEpH?=
 =?utf-8?B?NVA4VXpDaHU2cXNVSllha1VDOGNqNFNWZktQUDQxWWVtVFdMR2o2T21sSENR?=
 =?utf-8?B?bjVPYnBqUG5JaEFLM1g2SHpKTWR2V0RDaGhhQmp2dllrQzVyZ3hiZzExQ1N6?=
 =?utf-8?B?Smwzd3V3eDZBUHhYSTNmdkZ0LzJudHJjaHpEY1pBQkY0NzlYNmlxUHZjNnhP?=
 =?utf-8?B?eFZzSmdCUHFJd2NtdTNCVzl6cWVQNzdSQlUrOHd6L2NCT3V1dkEyVDJBajl1?=
 =?utf-8?B?TkdRaThhRFFvYzFCOHpDbXBPMFFxRHgyekw3YzRDZEdZNjI0R2o2MzZNcUtr?=
 =?utf-8?B?c3NtTmN2U0prVHpHWVZZTTJrRWJnK1VydE1ETzhkaVhNS3pkbGUzYytzREZz?=
 =?utf-8?B?cDV5RVZZeVEyZDZ2SndVVG1CZkJ0YzNlbkhZYkMzd2lqZlBUdlF1OUIvNFdK?=
 =?utf-8?B?UTN6RTRpd3pyWFpRbzhFOGNtb2xhUDV6cFRpRkU0d01OcUZzQnB6UUJ5LzlO?=
 =?utf-8?B?NGNEUkoxM3NuTVpwcWh2aDVRZUVmN1dpWXJ2eXhUeXZjelNFWVkwR2o3U2oy?=
 =?utf-8?B?SCtha01NZkFZWEN0eXBTdExxNlN5Ti9qRUIvRFlqSnBucmR0RW9aT2NZd3lB?=
 =?utf-8?Q?JuI3jL4Bq8oE2b4rcBMn7aP/e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4fc893-eb16-4470-7ab8-08dc272f6dfb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:19:44.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSRAcigOPULr8CsSyUmoOMCNPnlakaYk6Ud5F/4amfHqfgV9/vNW0oRcdWpAfK3U4mztzMlF0XKy3BopaToPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

Jason,


On 2/2/2024 3:19 AM, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:33:35AM +0000, Vasant Hegde wrote:
>> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
>> index 02d912b9f618..e1b3d579772f 100644
>> --- a/drivers/iommu/amd/ppr.c
>> +++ b/drivers/iommu/amd/ppr.c
>> @@ -295,3 +295,60 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
>>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>>  	return 0;
>>  }
>> +
>> +static int iopf_update_device(struct device *dev, bool enable)
>> +{
>> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	struct protection_domain *pdom = dev_data->domain;
>> +	int ret = 0;
>> +
>> +	if (!pdev || !pdom)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&dev_data->lock);
>> +
>> +	if (enable) {
>> +		if (dev_data->ppr)
>> +			goto out;
>> +
>> +		ret = amd_iommu_iopf_add_device(iommu, dev);
>> +		if (ret)
>> +			goto out;
>> +
>> +		dev_data->ppr = true;
>> +	} else {
>> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
>> +		dev_data->ppr = false;
>> +	}
>> +
>> +	amd_iommu_dev_update_dte(dev_data, true);
> 
> This dte change is in the wrong place. When the domain is first
> attached we know if it requires PRI or not. At that moment the DTE
> should be set properly, it should not be set wrong and then changed
> later.

We want to enable PPR support only after setting up the handler.


> 
> Remember what I said earlier there should be one DTE write on the
> attach paths.
> 
> So probably all of this should go away and be moved into set dte
> 
> (and again the whole dte setting flow needs cleaning, I think you
> should do that before trying to build more complex stuff on top)

Yeah. I want to fix few things in that path. But that's outside this series.

-Vasant
