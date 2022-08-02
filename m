Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03217F
	for <iommu@lists.linux.dev>; Tue,  2 Aug 2022 20:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnxC5PhPEIuqdOsbcS6HogzqGmGyON2FHr+N35+rRGS9x3Fg0eHkhP/rGM8WcgeU68EumuUz6v+kiReiI7l60Z9KojFJOH0FSi+O0FfFDMvdB4SkK+oPpiGmZVghkY6fvD8FL7G7UUGM4icej4WBQPn1uGoN5mGxjBs8CUuV2B3Oa+izYC6OggxLvs0Y7wbs6tLRElCWuc4GBG2kgf8QMArVURN8I+gN5gdBkV0AX21HH2VXnepzH6kxuG+i9wGZa7fFTVJORc4OoqCI0MgIloWyYO42IbxP4ZuivRFgn84gzTJLQtsUNc5CaBLxVJ4XeH/Q+AcoYLBY4STkU/7VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn9SXQtzh/psxoKba8moQb7PxKDOP2h0Sf7yZAzMZUg=;
 b=Y+cBkKblP83PbaUM8qJu/+m+Q85SYrGLftUmgvbhwnGGvBeQNYa9dZe/oI3AT2UAfvsROwlNPp9s0UZOrBONKi337agXktJaDb5iSuFk2sW6kc7nppDbc3eLKUG7hE2SQY7auUVXfBuXAHLAnKtlGq2WJC+VykuPpkogNyyVq28yYnDzKwXBopGSxoCL+nDaQdcGrx0Fp2h4tmrboOHhZ+faNS+s5hTpc836MCEGE6uhHU0lJUzs9YM8Ylmkw3H+DPHiA7UJQH0nVYcviBrXrYJN0LdHqAuw+PxJYu3tMO/YkA1KL4AOOHyZH5F/JGWyU647aEagFlcxO7kTKkIoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn9SXQtzh/psxoKba8moQb7PxKDOP2h0Sf7yZAzMZUg=;
 b=RgNcD7VFNM+lWsYm9Yz72Zvk4JGv/ulJ5lqfLeu48Xh3sHVuQdZTUKjGcctFWKPxwjLvS0JoPmdz5YTCY20QHg2Vrw4tTc59sATv5286BeWDOQjlOhzaEXEJV366iCg+/xGtaEGYAkseRYS0s4+ugA9sog5aBAHsRyHs1fcagWf7ZWOP+31I2zhDcfU0VreijoquDYmEE/1qgBFBWiJlrtaT9SjmqNwdrRuslS58ffaHB0/s1R3+iSLKkGa7q+7Zb0qSI+2FXJgxDdOGyyDSCJSnggJPRSo/AMsKZTpX0HSuyWR9NT5UarCE5GnzUTAaOnsFumf5Nf3BRi/t7e7vtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 2 Aug
 2022 20:04:37 +0000
Received: from CH0PR12MB5122.namprd12.prod.outlook.com
 ([fe80::ad55:c623:7eea:bc92]) by CH0PR12MB5122.namprd12.prod.outlook.com
 ([fe80::ad55:c623:7eea:bc92%9]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 20:04:37 +0000
Message-ID: <39a54565-0f33-b807-5983-e7a8e92b927a@nvidia.com>
Date: Tue, 2 Aug 2022 13:04:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: iommu@lists.linux.dev
Cc: "Vaibhav Vyas (SW)" <vavyas@nvidia.com>
From: Erik Kurzinger <ekurzinger@nvidia.com>
Subject: [PATCH] iommu/virtio: Implement viommu_{un,}map_pages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To CH0PR12MB5122.namprd12.prod.outlook.com
 (2603:10b6:610:bd::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 365753f1-2d7b-4994-9577-08da74c23a4a
X-MS-TrafficTypeDiagnostic: MW4PR12MB5627:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	noa/fo3mZOzd5HkX8BDs+96oNKqLjiY91u98Iyr5RnUieXeYLkYdHpVwRHr3Hss4yUG8L+RllW2tlcGP6end5F3iiOsQO2tAVfIjIS8xjGCa1huESc7SznQJ4eh1PK1GXQUdeZgXlq8rrKk10BjwwuHMZPQpI+MGEykgQ3/wARKZu1TQtOaUPlIwPUewE/HGeLCuuCyTiqTkvhVW/9jGDAqUbdyu3hLbK/oYByZ1INPL62DuFPIAZ+DbijbkKwBwTEkw6LQq1WkAP9aWIWi+ALKDi031tvBDJcLfcr93JUnYe6bkQ60OlBerIfRKBEISm/yKEvOiq1l+3VXrNorYD30DXbMH3CKw+ASRQj5GnXhxEVG8ZvZx3IEfr/Qg8xnXI5DueZj6rjT0BszO85ygmVt7X2pXz0hVHyh44Nig4V+ek87xUFO2cNEReLNIUanTJCJ3LGIkDQsHhovfbn37qoceaq94A7HDlMWW6mnXfkOleNBMukuzWymvBi82wFaHh+h2V9QU3EwJveHBGORDaMTlIeVYk9eA4VFUzyM1lwDpBAGiEz54VQPQmg5OFHt79pjlxcwsdW0GFtAUhV8/1fyO9MIKzXBFX78ZDheIXaHDh7Q959qCBzbUmDnDlJmInj+xpFMllg0SfASf69TX0PJlPas2C7wnABh9+Eb0fF0XKg8uPYx966iMi8/bvS/4bxBkrrhYzFw50tEc1RXeBKXY6a1XHeItpHjwONP08PCMVU94rAOD5rd3QowYRTUzfVzsODWcgIywVh/nTN6MH8mK9X3keguirS7mNrIgYFr3uWNM4psKSLz2FMqRBvC/Th+Ma6iHgQ24cDU9ziVTgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5122.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(6916009)(186003)(83380400001)(316002)(38100700002)(6506007)(2906002)(5660300002)(31686004)(6512007)(36756003)(26005)(478600001)(107886003)(66946007)(66476007)(31696002)(4326008)(8676002)(8936002)(66556008)(6486002)(86362001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckNIRlJXY2FEYlZBZUtqY2VwWTRvSUpXQmRUTnNpWWsvUDMyQXVSSy9TeEtz?=
 =?utf-8?B?enhpUTBRWTBRcWhIOUg1Y2FMeWZTQ2cxZ1V2cis2UzlPcXFUTUlIVnJvSEZ4?=
 =?utf-8?B?SlJCSTA1ZW5iUHRGRmNpSW9IcjRVTU1tSllGY3hFR0VRUVFYenM3bGwyNDhr?=
 =?utf-8?B?clVBMFFTTVVJOFlhQm9jdDZqUUgyWU9Jb2h1L3JvOTRkUkNXSlMzMmpBTTNq?=
 =?utf-8?B?Rkh5UjZhSHp4MXZCTzAzdDBCNkg0MnhBWm80ejBwZkVPTmRJRjNjdGpsdEhZ?=
 =?utf-8?B?b1hLZkdnK3dYZ0pTT1I4ODJGeXBWNDM5Ylo1NWZhaWY1Q2E5NUtLTTd5Smhh?=
 =?utf-8?B?RFAyZ2x6eUlqdDlzbndEdERHTWJNTTlabmdjeGtjYkRmYWt5MWpOMlN0cmFI?=
 =?utf-8?B?eXdtUEs3WGFnTndBaGN2SXhmeUJjRjdDLzJ0TkNrZEkxZGFhR1haKzBwemRx?=
 =?utf-8?B?bmNPVGFpNnZ1YXl0MlFFQ1FDV1greVVsd3Ywa1lPTlVWME5FeVhhbHZxUlBM?=
 =?utf-8?B?ZUlrb3lGaXdtSjFxcDIxYkh0eVZZY1NBMWY4bnZOcWFRU0M3SHR1cDlHZHQ3?=
 =?utf-8?B?c0VzMlQxWDBOMG9wd05jcForb2J6QStKMWE3RTZnNSt3R0lGaloyWjkwQmYv?=
 =?utf-8?B?NmJnS0k1UnFRalBYNkpNa05jcDdscU9qNlkwa083L3JUdUROclptRWl0dWxE?=
 =?utf-8?B?cGdIekQzWmp1d0lyMERieDkrTnZFWEZxQWNDYUh0K1VML0ZMNmFua3FnQm1H?=
 =?utf-8?B?NXZzQmVlS2M0SjIwUElVZExtVFNJR0JEci9zQlZkRFR1Wmo0OUlnbmRVQ3BW?=
 =?utf-8?B?NExBUzhTbk9yUTB4aVU4blhRKzF3R2ZuMjQ1TVhna3o1UENKaHRmaE4zN0gr?=
 =?utf-8?B?OGkzOXB3MWxsUkpWZElsYkdwTGVYKy80alFScnlnQ3pHNVB1ejZQWWlCVTFj?=
 =?utf-8?B?M3pVN1cxbTNOZitsb1NkbnlYVVZPVGY1enBRaGsvV3FSM21KMC9jYTV2Rm4x?=
 =?utf-8?B?ZlY3Rm9Gd2xtaFIxMkVkK2dkNmpQblV2blVoUjlia1BGYkNZSGJzc3F6SFUz?=
 =?utf-8?B?ZFdFbXRaL1VWcEtwaDFLeXF2Yy9lWDAyZ0hFc291OWtVTWl2ZFRlc0FCSlVV?=
 =?utf-8?B?cjNEVitJRW9YVVR3QkU4Z1RPUzRwYmZFVEZQMGJvemZCN0lFRFlIeDYzRDdQ?=
 =?utf-8?B?eWovZmYwUXVhWElNbnc5ZzZjT28xN1pQci8rcng5Q0R4eElqMlFSd3ZIdXdW?=
 =?utf-8?B?QzB4NzhVZmZ0Zm85NVNWRnNzM2tEWFZ0UHZhWFV2Ky9CWjRRWm1Nc2MyTVpi?=
 =?utf-8?B?TTMwNklZc0l1T2QrRWdURFNKRE1vMTYvbXV5VjVGL3NLRzI1dlBHMzR3UWhV?=
 =?utf-8?B?MzNNb1ZhTmZHNlJxbW11UklrbSs4ZWhSU3pVbWlkR1NoRitYMlZ4c1dBbWpx?=
 =?utf-8?B?dlBzTVljTW1rK2dZVlUxckVEdlVWWHpsSTZvZ1ZIMmFYSE1FUCtEOS9mWlBL?=
 =?utf-8?B?WFRUKzNqUG0rUUY4ZmlKSUNaRzN0Z1NkNURIanIwNExXZDQvekt2bnJJd0RJ?=
 =?utf-8?B?eHNpK0RQaFB4QWQ0bDIyQlY0VHlUZE04V3V1bTFRREJKY1B0SHUxa3VBbGRm?=
 =?utf-8?B?Q0ZiUm5Odm1oYVBQLzlnZnNndEN0SGNZSDlpZnVIYmg5SGxRTTB2Y3c5Kzkx?=
 =?utf-8?B?YittQ05qdDUrQi93MHBzLytEcy82di9vbVVCZzhQc0RVMEM4NkhRNHZoMkY3?=
 =?utf-8?B?YVB3OHlrZGplelJkNVIweWVYcXlnVVFTcTJmRWRzSjBvY2lrY1ZGYlk0Rytm?=
 =?utf-8?B?Qml2Q1JqbmRleFViWFFtUzRzbk96Vko5V1RlalBjOFh5eTJVQ3hzMlZNWC9z?=
 =?utf-8?B?YXRZU1Vrd2FBSThCZnF2T1lzR292MkE0ZmdIS2hOejl2UkZVanZLdk9Hemlt?=
 =?utf-8?B?cEgzU1FTUExLNmk5dFBzQ3g3Y2wzaE41cTVZamdBWmFWTVJMVUQ3YVVzbXpF?=
 =?utf-8?B?Ykh1THpyUlFPcW8vNkZmWkl2b0lHMmcrSytCZ1E2Yk90d3dVb0hnZkhkaXZJ?=
 =?utf-8?B?QklrWEVmSFRKZ0dXWk9LWXUwY0RQOTBQdDVsWS9JQ1dqb2x3SmJBWlRtdlZK?=
 =?utf-8?Q?le97Im61iBtP8MbBFZFtmHOlG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365753f1-2d7b-4994-9577-08da74c23a4a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5122.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 20:04:37.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3yJfYwtqfCDuNhxEQezLLPUjE+mlgpswk7+HYi53Vf1H2BhBhaQ+XvbjxGIVIrRmfQCrSvHEf0LBS9t0Q96wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Because virtio-iommu currently only implements the map and unmap iommu
domain ops, when mapping a block of memory a separate mapping will be
created for each page. Since the number of DMA mappings which may exist
on the physical IOMMU is limited (either the user's locked memory limit
for memory-backed mappings or else the 64K limit imposed by the type1
driver), this can become problematic for larger blocks of memory.

To avoid such issues, we provide implementations for the map_pages and
unmap_pages iommu domain ops. This allow us to only use a single
mapping, even for multiple-page blocks of memory. These new functions
will simply defer to the existing map and unmap functions, with the size
computed from the page size and page count.
---
  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..37f11a799f2a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -827,6 +827,18 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
  	return ret;
  }
  
+static int viommu_map_pages(struct iommu_domain *domain,
+			    unsigned long iova, phys_addr_t paddr,
+			    size_t pgsize, size_t pgcount,
+			    int prot, gfp_t gfp, size_t *mapped)
+{
+	u64 size = pgsize * pgcount;
+	int ret = viommu_map(domain, iova, paddr, size, prot, gfp);
+	if (!ret && mapped)
+		*mapped = size;
+	return ret;
+}
+
  static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
  			   size_t size, struct iommu_iotlb_gather *gather)
  {
@@ -854,6 +866,15 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
  	return ret ? 0 : unmapped;
  }
  
+static size_t viommu_unmap_pages(struct iommu_domain *domain,
+				 unsigned long iova,
+				 size_t pgsize, size_t pgcount,
+				 struct iommu_iotlb_gather *gather)
+{
+	u64 size = pgsize * pgcount;
+	return viommu_unmap(domain, iova, size, gather);
+}
+
  static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
  				       dma_addr_t iova)
  {
@@ -1019,7 +1040,9 @@ static struct iommu_ops viommu_ops = {
  	.default_domain_ops = &(const struct iommu_domain_ops) {
  		.attach_dev		= viommu_attach_dev,
  		.map			= viommu_map,
+		.map_pages		= viommu_map_pages,
  		.unmap			= viommu_unmap,
+		.unmap_pages		= viommu_unmap_pages,
  		.iova_to_phys		= viommu_iova_to_phys,
  		.iotlb_sync		= viommu_iotlb_sync,
  		.free			= viommu_domain_free,
-- 
2.37.1
