Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB56FA9
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239830; cv=fail; b=afsVy58iVAr+QxyEfaAXwhXYt7tD+yWW0AduzpPKzihaslHkaGgzbjsPXLsz+cBiVm0J5GXZPtYwjglFE8X7WiEcYkOK+RvqZ2ebbHwSvIgvNKaenNsvDyanyNmqguaADGjsvIoJn5ZZoRbm8Dr2GjNsTOc/fBRQJxZ2sPL3Bvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239830; c=relaxed/simple;
	bh=04AwV5EJI82MqONn1WD1TeTICOJcEuBy5dwKlhVmKf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m6idURQUfo0yTHiUwf9pWXLoXX5nyzfGc5g0rplkNzo9bOSZ6v1LcAuF9xfe5H0vALms+e1vi4oSNfBCR8YErILFuXlFvXwddlJXil6L2YzA/ZtYiYyFhnoe8UtxOuar6OenPpmZdrUqbrupU4Y3YtCOWjp6JS/aP2sxoMpGztE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W9oqXmH+; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W9oqXmH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgT3gk5w0B/Rue0pS/P0xoQldiwyVVfeNM8M3E2tmFlBNCp23SPkVVrs0YoM/+kQtdNNTCJxhNAqBQ1umsSPEq2AN5mmJ42oIXNYEj9WnixQKXf5VVZpnv+5TVu3GgsEiQGhEVNBzycMz3XbhvrtIBBnnVIUsh2NlDbcuN0UFBp7O2Zz30aJ2NFBXi9VEs65IQJDO6xdv+TWR1CJB0PpPxY6R/C3wuppCPJ+hM+2tDPLColY/aELvBPAevVewSLzL/2c3vpJFMc5+3JqbysD6v9Co45WkLJrxQQDMev61yu1Xa+RjJOoWhVzCR5ZfLzRwXgJGAkBM3DNb4YgpVazIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlPZE0miLiXsY+qyCxpTTNFFM3NIO7iDoU4fZ7jDEkM=;
 b=SGFpU0/bqLIkc7LiklEIdeqJP/yff0E33lD3WQKU+c57US2E8KXLeJYlploxSzIKkMBQxzu2aRJT4rGttih19puynG2xhIGWI2D8W6CRSVE/LARJsZR6vu1O0TadM+SQxgQG4dYK4JfjpL5gF/FgfFrlKbzBanM/27no8J1upeLfMkcIPBbtS0DdWTl0imFAJcaPOFdWrmssuIOSQzsWVn2C0qY8/hVZaAA42ydSdPFoWgAID2RHzROi1OuQVrOBdpBne4l2fgbmEqkP2v162T24vmMXnJxhTTK97NQS2zTzuwT/Lg+Vi9jm6CeajZEV2WcBcS03KOBhqkhTuBQ7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlPZE0miLiXsY+qyCxpTTNFFM3NIO7iDoU4fZ7jDEkM=;
 b=W9oqXmH+zzgF4ipapgb627DBcmat5vqVuTLirLK7OMv9wmTTN66aCeFD6kmdJd/+qN4T3wVt8Yq0wovA6bW/DMwbdEzerbtloCi1dIta2f2o/8Q8Mbr4Z/VH1w0eHUBmv/XY4QY5GSIAltm/kia19WiTgmOUdx5OPthmolk0Ayw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.12; Tue, 6 Feb 2024 17:17:05 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 17:17:05 +0000
Message-ID: <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
Date: Tue, 6 Feb 2024 22:46:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240202152524.GA2606743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc6d306-4152-4647-d669-08dc2737710d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cOaMsdfoyVDSTcrIHK+bR34zRwRulxh2C1CShWUW2ZfDUAioMw0oJNYBcU2tZniMg4xRDqYUVtZXoAQg8i32+mZLtD/fYNiGYipHWBHeEKmZn5K/gByDwoYDQO6osOINFl/ztAcgLdPsjoUfof6hXBzEUAGcJ9YLWd5kb9MHz1OlbZQRmY/GGihP21udEGK3E84aSRa1KI0cNiG8NzNh9xcf4HoDdSMfjU4RwfjcQx5/FXDGouN4TNrCGYQz72ok35IlMhuCndgt5jOKN3W4y3qogmbXY09ZRyVrL1Q+DQUahBc3gSlPPg6E3YUTL8hV1gkgiFDIhje1E2TRTnNK48Aao3TDU+B+1/5wRQ18v9hEMJ3TkacpnNA4GEkrDOhUm9Ydf4ytJeVQQFmZC56WvFc++CSjXDBwQuQVmTXH7Cl9s4OK8IwQJh3jNy9JQbAuczkOZzw6lBeJy5DhanqkcAP1FxoyKMbvqgT8Ez0i8/UVkFdUB718T1L+zi7FoCeGR/nJHLC25wvvFGSvyViQjmxhOw2QWZyuXR5h1JgDzbCu8CXmJRg6ZvAIBAHybreCvBxdEUHNNuCq55PokL12HH0+1bnwGJRIhoouPnF5F56t5zOVxDPpu1vK5pXhDmKQHi/ifuoIELAJCZlxQcuQ2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(6512007)(83380400001)(31696002)(86362001)(6486002)(36756003)(53546011)(2616005)(26005)(4326008)(66556008)(66476007)(8936002)(38100700002)(6916009)(66946007)(44832011)(478600001)(6666004)(316002)(2906002)(6506007)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZZNnVwaGNQdTNoMEhhbWY5WXVtbSt4YTEzYUprTjRFSUZBWDdPN21FOXUr?=
 =?utf-8?B?cnZJb3hwUmRUK016SFZaTUxVMVFUaVNobjMyVGZjakRUc0IvTWtlUWFndE5O?=
 =?utf-8?B?STVvem5yQk56WVRhRVFidlJXYXVUYWFKeGJmNkVzQ0hmTTF1dUVuZVRXd25P?=
 =?utf-8?B?WFVwa1VRQXRvQjhrdXp0aElXaUFZV1BhWFlHeGd6OXJyMnJVV3ArTUJqUkNx?=
 =?utf-8?B?VytOMzQreVJNaHRFdGszNzlMNVZPa0szekFCYjhoRDMxZGJmbU9uaisvNmVS?=
 =?utf-8?B?K3RISnZCbVh5cGpPaHZYR2Raa2IxKys1MzN4Q3NmUTNGZTBHRlo1SWs2alk2?=
 =?utf-8?B?UHVvNW5pOG85cHJzMVVoTjArRU05eDVsaXYzaksvbVhic1hnMW9hUXBLcU80?=
 =?utf-8?B?T3d0azFoczJxaFZrNjJ5MkFLWEVpYlE2Ui85S0tPN0ROdURkejViTmJrY0NE?=
 =?utf-8?B?T3VBb3ZxZHZyWlRURTJGNmxTZEwzayszTWlGY2MyRUdjTWN0Y1l6QVphQTlL?=
 =?utf-8?B?bU5XTm9XcFlnZXVmRzEyZElrdkUvWTNIbzVTTHY0Smxrbk5XeVVTdm1qclhi?=
 =?utf-8?B?VjRIVHFmanR2UkVXYlUzaTZaMWlsZW9UVFpBL2NveDJyczFqLzUxbWp4OTNk?=
 =?utf-8?B?NGJCakdXcDc0cDdYbG9PaHFRVXVSVmsxWFB1VDJCR1U2QnViTGs0cWpaQ2hj?=
 =?utf-8?B?NXVKKzdCUExZL3lIMFBpN2tyVHRhaFE2dFZaTnhFeGR2eHVpd3JHVmxlRmJ1?=
 =?utf-8?B?cDUvWExkaHZWRWNUZzJYQXlUVXgvTHpMamFEbE9pejIwdlNoaVpSOTF5VzBH?=
 =?utf-8?B?bGw2ay9vZENHa0t5cUZhVVpqaW4vZjRoeldXdWFFTEpXUGN5a2wvMWdGZ0pD?=
 =?utf-8?B?UFBBb2tiL3VJOGlMT3RVK21CSFpUMzBLVHFieHhlVXprMDl6TFJneEQyV3hi?=
 =?utf-8?B?VExPc3Jtem9KWkhHUTBZZ1ozV1NaclI0SytWWk9YT0dOamZiSitTcEFISnps?=
 =?utf-8?B?TlpGZFBnZCsvQVVhRENmaDZNTit2eUQ1a2RTZW5JUnNHeTdFclFWUGpTeFhJ?=
 =?utf-8?B?Mk4vdkkyV3ZWYmJGanpPait4L3B0SnNmT090L0FWaEFSVDVHdFBiNEJ4VmhN?=
 =?utf-8?B?ZzV5SVZzNFdLUWJsdHljblVkMVh0RnVFWkFwd2w4eGFvaFZ3UWlmcUl4ekx1?=
 =?utf-8?B?RFpOYmNFYk5aN3U5M0Ryb0hnTnUzUFc5U0hZZ1R2RytzRk5mbXJJYVhEM01h?=
 =?utf-8?B?R081Unk2cWhrMnc1bEYrRHdzb2lVbUJ5TTVHVTMrY3JnME13T0MxWmV2RVho?=
 =?utf-8?B?aytoendxRzVudi9xbk42RTdsQmp0Ry95N09POHQvbG5QNXNUdTJpMFR4T1Nz?=
 =?utf-8?B?TDV4aUZKNGhZRHFYRlJHUSsyU2RFc2YycWZ1anpMakllcWhCa0RVaDdGWlQy?=
 =?utf-8?B?QjBqOGQ2TklCM3FvVkRGV0UxVm5ubThjOTlXQ0JDdFlzL1laMSt5Nms5YzVk?=
 =?utf-8?B?S2xWK2gyUFRrV2UvUU9lWklYK01lK2locEs1cTRTT2J6ZjVMMzZENGtNNit3?=
 =?utf-8?B?WnlYVlJPRWxPK01ZRlNEZTliNElaUkZ0dmd2eU5QSkNmVjVLZnJ5eDdwRTBE?=
 =?utf-8?B?YUlVaHhWczFJUmVKYlBMeC9EdTc4TWdjTU02S3M0NGgyQnBCUkVaZ1lwVTNi?=
 =?utf-8?B?UVdSWGFYMDJMMFdYSGlIOXhzdU04NnJrQ0pQMGRndjBPWnE3T2l5TnhlSlE5?=
 =?utf-8?B?TU9vb3BmN0hPNHM1NHlSRUN6RDZWRzdYTlpKbmx4a0NSWmMxYnNSTXJsekVM?=
 =?utf-8?B?KzM2STN1NFZEWDNucVFiczRnVjQrL2xGd2xwZU5qcnUydkJpMWF6QkxPQXY2?=
 =?utf-8?B?M002a2hTQ1FUZzd4L0I0K29CRUk2WDVKSjNNb0Jmb0Z5cEFIdVpjNDg3U2xy?=
 =?utf-8?B?cEZXL2h3WjFnR1lGemtCQlVLelN4TFZPd2FuWVhSSUZqUWUyMnk4S01aYXc5?=
 =?utf-8?B?ZzZXQW02TjU3UURTaDFjWkZKczVpWi9TaExSYnFpYmU0bmFMZWQyOFhkNEM0?=
 =?utf-8?B?WFJzWCtzWkNEQkh4M0thK0lPeXZqYmFmNjY2UWVMZ0k2QkYzdVJlS2dxa0tI?=
 =?utf-8?Q?T8dKVTCAQ2269C3Q7pneDOqBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc6d306-4152-4647-d669-08dc2737710d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:17:05.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPGfSZAcMlhW0tuBUsQaXIR3asxWlXLVYWetjYnuXse4S5wJ27SVPl51tsA3VXV1VHhyRTXX9itdVuOOQKg5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

Jason,


On 2/2/2024 8:55 PM, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:
> 
>> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
>> +{
>> +	struct device *dev = dev_data->dev;
>> +	int ret = 0;
>> +
>> +	spin_lock(&dev_data->lock);
>> +
>> +	if (is_pasid_enabled(dev_data))
>> +		goto out;
>> +
>> +	if (!amd_iommu_pasid_supported()) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	/* attach_device path enables device PASID feature */
>> +	if (!dev_data->pasid_enabled) {
> 
> How many times are we testing for this? Just check if the gcr3 table
> is installed once

One time for IOMMU capability (amd_iommu_pasid_supported()) and one time for
device capability.

is_pasid_enabled() is checked twice (once without lock, so that we can avoid
lock in most cases and one inside lock to be sure no one else entered and
enabled gcr3).

> 
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
>> +
>> +out:
>> +	spin_unlock(&dev_data->lock);
>> +	return ret;
>> +}
> 
> This seems like too much, and it doesn't need to be in a function..
> 
> 1) Check directly if the gcr3 table is installed otherwise try to
> install it. That might be a usefull function

We need other checks to make sure both IOMMU and device is capable of PASID.
Hence its a separate function.


> 
> 2) Precompute the max pasids during device probe and store it in
> iommu_dev_data. Just check if PASID >= max_pasid and fail

This is not required .. as set_dev_pasid() can directly check
dev->iommu->max_pasids.

> 
>> +static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
>> +{
>> +	spin_lock(&dev_data->lock);
>> +
>> +	if (!is_gcr3_table_empty(dev_data))
>> +		goto out;
> 
> Caller already checked this

Yes. Will drop this check.

> 
>> +
>> +	if (dev_data->gcr3_info.gcr3_tbl == NULL)
>> +		goto out;
> 
> Can't happen, right?

Yes. Will drop.

> 
>> +
>> +	amd_iommu_gcr3_uninit(dev_data);
> 
> Just write it out clearly in remove dev pasid
> 
> if (is_gcr3_table_empty(dev_data))
>    amd_iommu_gcr3_uninit(dev_data);
> 

Ok.

>> +static int iommu_setup_pasid_pri(struct iommu_dev_data *dev_data)
>> +{
>> +	struct pci_dev *pdev;
>> +	int ret;
>> +
>> +	if (is_pasid_enabled(dev_data))
>> +		return 0;
>> +
>> +	ret = iommu_pasid_enable(dev_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
>> +	if (!pdev || !amd_iommu_pdev_pri_supported(pdev))
>> +		return 0;
>> +
>> +	if (!dev_data->pri_enabled)
>> +		return -EINVAL;
>> +
>> +	ret = amd_iommu_iopf_enable_device(dev_data->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
>> +{
>> +	/* Update GCR3 table and flush IOTLB */
>> +	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);
> 
> This is in the wrong place, there is only one DTE/GCR3 remove_dev is
> touching. The list iteration below is just to clean up the tracking
> list it should not touch HW. Move this up into
> amd_iommu_remove_dev_pasid.

This is used in remove_dev_pasid and sva_mn_release path.

This just clears GCR3[pasid] entry. Its not updating DTE.

> 
> And these functions related to the tracking list should be more
> general and called in more places. Just the tracking list itself
> should have a few patches to create it and situate it generically in
> the driver. Even the RID should be using the same mechanism.

That's after reworking protection domain structure. Not in this series.

> 
>> +int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
>> +			    struct device *dev, ioasid_t pasid)
>> +{
>> +	struct pdom_dev_data *pdom_dev_data;
>> +	struct protection_domain *sva_pdom = to_pdomain(domain);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	/* PASID zero is used for requests from the I/O device without PASID */
>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>> +		return ret;
>> +
>> +	/* Make sure PASID/PRI is enabled */
>> +	ret = iommu_setup_pasid_pri(dev_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Add PASID to protection domain pasid list */
>> +	pdom_dev_data = kzalloc(sizeof(*pdom_dev_data), GFP_KERNEL);
>> +	if (pdom_dev_data == NULL)
>> +		return ret;
>> +
>> +	pdom_dev_data->pasid = pasid;
>> +	pdom_dev_data->dev_data = dev_data;
>> +
>> +	/* Setup GCR3 table */
>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>> +				 iommu_virt_to_phys(domain->mm->pgd));
>> +	if (ret) {
>> +		kfree(pdom_dev_data);
>> +		return ret;
>> +	}
>> +
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> 
> This doesn't seem right? The tracking list should be loaded before any
> change is made visible to the HW, or at least under the same lock.

Ok. I can move that up and then have error handler path to remove it.

-Vasant
