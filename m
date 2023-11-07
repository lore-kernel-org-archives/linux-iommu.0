Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102904693
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rp5hXKdO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOdwdFm8yNKwcLXbbNGnIZc5aEPlaGWiIp7r/9S2Z3J4zjZmii3fpDIwIrERudzXJGThZM9xVlYpaqgLxCq2uCnJQ5wxN21OjNTGbT+yApKk00hm4kf4FvZVnvjriKihnZsKrhUThn2+RXgx/Z6EYjy3eewpY1Eok0C+UxaHazNHtvkR5YuAS4Z9W/WQFCvu/QjUnVf5NKnvzTNrn56/ttqZKdoU0/7HDColQr4ZcADIOqxpQX54k2fQiEvEuOBGp9Dh4CgQLYT4Tu7oMNqpID5K5MsvydAX9SxdhRkS2Pa1BsfizPy5jxXpO+FWh/Uq2fu7+cQ53GIHyMPWWpwcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K62dORI/7vsEbk49QXSQ2c6Ypzzox7FC1h2zu40CFK0=;
 b=RbZRB+dhHv+VF50TlCIvdIH8dHq0Dys4CmeqQVbuNrXYVkfqWV7t6W/I51ZZ/JZYl7Yyiu7VR3n7XFeyTRM4owX2VYGNN1oH7/MKdB3ZjcgRda7FB02gWl+S/Oyh8ZA8lji5Pf5hu1hvQAS8cw8r+1Ph/Y1+URuh6Mx2sYIgzsDxD+oWRV7o1cKEuXnrhfvi0pIoEnhDIUQ1FfBfbaJnLtlHx6Kx/4+759AYn5A9WjVuZSotf85kd64mf1+Ud/96YSk2/8IsoW6aa8cRpAA/whuuwduswPB01DVSYHQqkJObAeJkF4+KbounovbWJE/hGM/U37AMz0voGYFrW/lr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K62dORI/7vsEbk49QXSQ2c6Ypzzox7FC1h2zu40CFK0=;
 b=Rp5hXKdOHsWID+DFnC6r1kWDPCvj5USd60h55RA2Gn4mEShvzzoSY5YqsDFg+O3e/afz83wc43g1PAuQ5lWy1zSVpT/CuicmizPq6EkO3mPAKqQzOXTHcuHxV6vGbVPmehhSmFrjBCKlbQy+JgD/p8WnkL2iOX8oy3EYBnUxdLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 06:26:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:26:35 +0000
Message-ID: <4eb067ed-717b-0649-e119-fe43620d39c2@amd.com>
Date: Tue, 7 Nov 2023 11:56:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 02/12] iommu/amd: Do not override PASID entry in GCR3
 table
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-3-vasant.hegde@amd.com> <20231106175130.GR4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106175130.GR4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: a7761347-7d41-43b5-cdfc-08dbdf5a7da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DnNRIDjnsbxXbXOEQ4q2C52OWfcen63y+CJxlSUn6r3UkdwqS8SMt1bQvGhDWHOkmDHNsTB9EnQTFqR9knqPfGkOj5kGUBxDc98q5DOECEm5/iOgio2G0Ot4c6UcKkKOHEn0t8vyhq0eEEbMeYUnaKP64B+nB8wDFHBJaoNehH67RkF8jJe28ncuW3lzo1t26SDcmATX2Q5jZg1XsGY/ehXwdNwmX/SLbFljRG/5MRvblGUemQMRppvQiVHbXjR1dTrTw873gDxrlzC9wjQ/Sj2HUt7yC0Bw0PwmCBxwkWVQ01rU4pLeKJlPKM40rStaqtwUicnZ0fZ5qdPPaHoWPlQ2ma9pVmap2PRr/bFMY1zfYLmifjRdom0TmXy3iMt5zW+qhnYwYMyZGU03CO3/9h9uqEQJCWdw/4P61uaBNvXXqvWKYQndFqfjn5WJmKgZaH7ZYLQhA4Dy5UXGaRFSduURoRDNnB+1xmpkPeVGGJ1rcGaa50Eag1fc7T0u+DVLAASJlqNaRccj5gOBxC2U+N3GmYf92nt821mtx/aBT4yLDjxK6gZx8AlslEP9AFk4xqFYizjQf78Gjjr0NtQ9xuPqGI5Ij+LeFfBi2mGt0enpy4MEYZyhCZXXXV7fPMVG643QOBMJVG65Igxs9HpdJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(6506007)(6666004)(316002)(66946007)(26005)(66556008)(66476007)(6916009)(44832011)(83380400001)(6512007)(31686004)(6486002)(4326008)(8676002)(8936002)(53546011)(478600001)(5660300002)(41300700001)(38100700002)(31696002)(86362001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01Kb0NTZkNrYmRPd3l3UmR6c1g2THBQdzlnci9jcWprcXJKVm1FSXIva1dn?=
 =?utf-8?B?TkkvVEtQSWcvQVBBL0F3Qjhvc1cyQjVOeW1PcGFOUnZRNHQyOHpFZ3dKd2J0?=
 =?utf-8?B?cGF3SHgzZ2tyTGpoRDc1bGFCYW4yMFFNdFdqSkgzYWFmYVkzdG1aMWFiRW15?=
 =?utf-8?B?N3JuZGVML0xxQ2p0c3hkNEExYy9OZ1FsSGhmeHhlTGRGaU4xczhCV0w3U2J1?=
 =?utf-8?B?MnVUb2ZadXZybzRKM25lcHZlNzNHUnFSUnIyK1RhK2tvdC8zeVVxQjN6MGtK?=
 =?utf-8?B?bjRXaC9CdW83anVnZkd2Y1BRZ2g4WmpmdVlEc3kzYkJCaHowaWplNWlHcENx?=
 =?utf-8?B?RmtJMFlxOFo5MzkraUsyM0lHR0pFVXRCdTBCcTR6L2dpOEF3ZU9TK3E4NGFq?=
 =?utf-8?B?eE5Tb1IwVWxmSzNmMldMS2M0anFlbVB4UExoMEtDb2ZlcFk5K09mZHFtTVkr?=
 =?utf-8?B?OWVoNFZFNlFLTU1uSE5uczFNcU1pdkV0dW1kUkhMeGhwMUxCN0d4dlh2OU96?=
 =?utf-8?B?bVA1ZWJqYWFIeStNL2R2SXRmQ2EzWmpYRE9WM2pTU3hYNCtQcnZXYnFMRDFB?=
 =?utf-8?B?dXhJWkdkNzQzTkVBVGhhaU1VR0lOMVN3SVRUTTVFQUQrWEtyWTY5UktZY3hM?=
 =?utf-8?B?QnFURTlPZE5oL0JLcEFzVjhpSm9relVqYXJZV0JLYkVUR05Hb1NPL3NIbFo5?=
 =?utf-8?B?VWtEekZkN2xjWk5ZV0gxMWtjTHM3QThTUUNmQXVmYTNyd0RTSFF5eWU1ckpS?=
 =?utf-8?B?N1p4UWJQYVRUeGhGb0REOWlsQzZvTWpTT0NmVWV0Z094L0Y4bFNsdWx3TDI0?=
 =?utf-8?B?Y2tOTlIyLzJxZ2VlMFJBc2ZwZEhPS2lrRm8wVzZHTGF1QXVSWEhoOHFTN2FS?=
 =?utf-8?B?akVZTnN1dUVlalRoOUNhd2hGaEFlQlpYVFlhL2xvaEhkRVRZcTE5SGdDU1kw?=
 =?utf-8?B?MXpqVk11UDdLR3ZncTM3UFFaZHJuc3JGL2dPM2VTanB0MnRaVXhsUm1sZ3N2?=
 =?utf-8?B?L1N4SHExRGkvUDFEbVdIb2h4VFpDdk9OVnc2am90NkdzZnN4aEMzVFNzd2xy?=
 =?utf-8?B?N2ExckZuVUdNS3NFZ3FPTjI2V0tLcEhGRFFJTXBtWW5vaFlPN25GTVpISlkr?=
 =?utf-8?B?SEQvZnJjdXNlV3Y2ZWtUOFhKVnlyNjREeU85bmdtZzFtNGxuS1FBelAzTStI?=
 =?utf-8?B?aE5KS2IyYm4yYjBpYm5saW5KTnBjZHZKNkF4Mk1qSnRZZTA3UlFrMlZKRHFq?=
 =?utf-8?B?QUFDd0UzTTZWZTJBeTNaUXZPQ3c4WWtQU3YrWTdKZXA4MEFyRHNPLzRJUEtW?=
 =?utf-8?B?MGk2VlpUdXZBcVRmR29jQzBmVGthVDVmZHh5U2dpb2Y0bGF6R0xvd05TSDk5?=
 =?utf-8?B?cXhpSDJVT0R0Q3U3SC8wUjNGblZ0cXVTUDg4aUphLzVHdW1waXNldUdKTXcr?=
 =?utf-8?B?Umh1WjBoaW45ZDc0Y0FCZmdHdko4VUpVSmFISWFySEJlem1IS3NPNDlMbVpM?=
 =?utf-8?B?d0lIRmladWdzMXk4K2VEZzZnRE9QcEtneldvR2d5VkdCUUdJOWhSM0duM0dC?=
 =?utf-8?B?SzhZcGdvQ3RpR2FVRGtvUHplenNjRGpSaVNCMlQxTmRKR2RPVUQzWHlLVEp1?=
 =?utf-8?B?a3VIeDBwVlptazk5RmhONXJReVpsUEEybXBuRkgwWDlSUUR6VW5XWlFseFhB?=
 =?utf-8?B?TytPSTVSQld2aVgvK0R6K3lxYkhGTUxYMHgweWdIalpYUGNDQ1ltcWJrTk1T?=
 =?utf-8?B?aHd2d1FYa0ZweUlYbGkvcXBzNjl5VTd5R0NSQk8wMUpDb0N3Q21od1RPeTg1?=
 =?utf-8?B?dFE3Mk05MFN5RlhYR2lXUHVGbFZWa2tiYVBmNDBnSVNaUS95aml4ZDRuL1Zm?=
 =?utf-8?B?bEw3U25BQkJqeUtXRmZUWWM0WFk4T2xFeFgvRHA2d0VOK2VEM1NUelcvWERM?=
 =?utf-8?B?UGcwajF0aWs3WGRLamdtcWg1N1dXY0VHckp1d3JXcDVlY25YUWxJcDkzRkFR?=
 =?utf-8?B?SHd2ZUpUYXY0WDRtek93NjVPMjAwektPVmFVbmxib01XSS9yT2tQNVRrOVF2?=
 =?utf-8?B?NG9CV1pQcWVJckFQTlBBR3JlcEFyNHZveWwwWmJOZCs5RnVwUFdhR29IUDU4?=
 =?utf-8?Q?5lVFmH8GAH/Z+w5mJlkqSyK1o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7761347-7d41-43b5-cdfc-08dbdf5a7da6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:26:35.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAWMVav04hbC19xobWczNOlTJXAxJpmKS64wqSIrJnM3MmJtYkhvYQeBXfRpxuJD4nLuMxfoAEfuDn5FNH+s/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030



On 11/6/2023 11:21 PM, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 10:43:41AM +0000, Vasant Hegde wrote:
>> Return error if PASID is already exists.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Why is this an error?
> 
> ops->set_dev_pasid() should replace any current translation at any
> PASID with the requested new translation. It is not an error to call
> it while the PASID already has a translation.

My bad. I did mess up this patch when I rebased. Check should be in __set_gcr3()
 (like below):

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 691c040216e3..558e0c196172 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1879,6 +1879,9 @@ static int __set_gcr3(struct iommu_dev_data *dev_data,
 	if (pte == NULL)
 		return -ENOMEM;

+	if (*pte & GCR3_VALID)
+		return -EBUSY;
+
 	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
 	amd_iommu_dev_flush_pasid_all(dev_data, pasid);



I believe as a sane design it should first remove existing mapping (that's why
we have remove_dev_pasid() interface) before adding new mapping. That's why I
introduced this patch.

-Vasant
