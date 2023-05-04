Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF27E
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 12:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRvnkIXc8kTxytWQDwPMmzdV+dPwmkKvhJD6Ue3CacZ14HsGQ8IR+DvbmAtThrYet5pfCBr+u6fPZo7zyMPJNSrIZnGHGMf3ZOjruar778tbZt2CgfCLgF7kEUPC55k5rDx9X57sCbxRh5NJKF6VSlIPtL7HjckwYfqD5U+ulnSqRVAzLvOg2ti3MfJg/ZGWxFSFLw3S8r8FcOUxaVV6sad++xxYWljmEJ1pgq58tEBxqaaZBhZ8LxAncQv+sQAPgccONKRTebORY/KVIYHJIDRzZjhtaXnmSdk8lcxL/DWqTWv2Gq4Z4u+LOu1z6EAXwtZiMXZ3p0qi4AV/ePpBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYJoUMew1fNWNhwXswdQm3QL1GVDbhPUL1V4oh/byek=;
 b=nQmqJOeL8PLbkUS7eG3IdxFdOVaFUi2Ov74PcJqZrvKUZdrTPaMNq8U8dv+vrn6331raPUCWEzJePe44m+pYu2HehE+nCL6s6D4Qniv0ExyL8tAyc2SDMTRlR7wdNiap/VIpMr8QiE4Goxd9mxPr/YhBQXEecXZlNDbAZHGjRByjjbM1kkchrOQjkNMdyFc+oWs7hAWrxTJilqDk7M2B48+oOLuiqmbvxv4jGmbsarAzk+ecpOeFBbqkLjeJiBimxt5rF2CK0dkBJLLlQCL3jaqVvpR1X3ZYXo+dKGQqjBMcIfmsYgFhVCbKNRHgicIkkQ1D5WMdZAy2svCvZMcodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYJoUMew1fNWNhwXswdQm3QL1GVDbhPUL1V4oh/byek=;
 b=VMLh+PJwjBhnIIXZy7cCyv+q6UKhc9pAbOb9IxPJG0flvbJUDr0hf9vZOMjebzxYswQ5ItZCaJv9RaK+YSlM2RVcQWvEJXAvyYZjTaEW64QwEPw7/yFQzjeaF79GRe1xR2mvgqWAcKPT3P/ygAq6Lf9lGU7Q/wh1tGLJSZTOOYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB5026.prod.exchangelabs.com (2603:10b6:208:6b::11) by
 CY4PR01MB2710.prod.exchangelabs.com (2603:10b6:903:df::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26; Thu, 4 May 2023 12:56:48 +0000
Received: from BL0PR01MB5026.prod.exchangelabs.com
 ([fe80::9c54:529d:a20b:a26e]) by BL0PR01MB5026.prod.exchangelabs.com
 ([fe80::9c54:529d:a20b:a26e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 12:56:48 +0000
Date: Thu, 4 May 2023 05:56:43 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Cc: D Scott Phillips <scott@os.amperecomputing.com>
Subject: [PATCH] iommu/iova: Don't reset cached_node in dac deallocation
Message-ID: <ZFOri/cwNVeEIPAf@zaid-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR2P264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::17) To BL0PR01MB5026.prod.exchangelabs.com
 (2603:10b6:208:6b::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB5026:EE_|CY4PR01MB2710:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f1c432-37b3-4cdd-c143-08db4c9f05d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GKpX7QteRhHf3La+9tk2HH1f88jgYjaVVdqAxQEEPkoxoxK3zmiUGWXPfWgO7yw2kejFRzvzjDoh+XNnsQGcIPHOOmmPYHaedOEdkjtW3zvpqo02Rr1KG1pMtfyS7IWxGZiuMqEqj1YG7MQiYxNxJJEiIEXzw/fbidB+WS36PzORLiO1ZpylA/b5WDDjRON2WNF5HrEQR0xUkj7X++71dP5s0CiejLRisgqdZa+t8TvZI+XRhQ7f37zEzXQ3VpXZpKoO2/pdbEaYmdtM0mTqjXhNQbZgwc6JE4eSjRYiXglo4INGvUVfzyYEuKvwbDHfbHJBZkojbAR6V2vdbH9yUpMR/ZXqWHWo3NRYv27NIxYoiK4XLMY94ARQtQZ+uqdj8Wo8VDS/ekr1dXUFDLRRpVenDRlO/bJbGXdp/vq7Tg32tkOqFeLdsnqYyubdI04aThqwnlhm/Xn9c5YgsYDk7eZqQHaNDWljr8swit9gAncKzaaca5M3z8Dt8awdgxtO2nk3opN3KWH+855h+imkRcivriiBtL76yzviPklPw6jnVvDr59NMJ9RxfcFWaFrSohp2HPJDww0d6rUzHncPGtgOhztJOzuSj95PMV9WdDPUFgNTj/KmGlvspApai+RP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB5026.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(396003)(136003)(39850400004)(376002)(451199021)(83380400001)(52116002)(110136005)(2906002)(478600001)(5660300002)(316002)(8936002)(66946007)(66476007)(41300700001)(8676002)(66556008)(4326008)(38100700002)(86362001)(38350700002)(6486002)(6666004)(107886003)(9686003)(26005)(6506007)(6512007)(33716001)(186003)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmhHVEVkcHZHMDNMemJtRmlKT1lXVHd1a0tVOFBSc1BZa3p4R3padWlJR09B?=
 =?utf-8?B?U3crblhtMFo3RVBjcmsyT3E1Y09IZWZNYm5vTCtSbEl6WFZhRzVNMUkydnor?=
 =?utf-8?B?OVRYNzBnVkJsNThaWjdVOXEvVzRYZG1oVHkvME4wV0kzTmdDM09LQ3ZUUE9H?=
 =?utf-8?B?eGphNUVqbmtrZUFxR3k4blhTdWpnMHNpeVdEakFPOW1icjh1WVcvMjNWYXpN?=
 =?utf-8?B?TjVHNENTNHc2OUltb2Q2Y2VlWkF3akd2MnJkVERNQXNDYWowTnVkd2R2M3Bj?=
 =?utf-8?B?OWsrMXFSSUVveGMzb1I2SitSSmVwbjZmcUpwbDRKKzg3bjlpNTM3dVlZRlNt?=
 =?utf-8?B?RzJTS0Y4V1hiZUsvYjFpU3dTU1FkWnBrMWpyYlJQMEZYWnc5bGVGbFVTRFVH?=
 =?utf-8?B?OGk2SWhoalphMWJBdm00aW5yU256R3VvdlhvQ2ora1pqNXErRFdva1JXUjdh?=
 =?utf-8?B?Z1VEeWZFQkkzUjBiSEdmNmt3aCtYR0h3SHNrZXZVakVrMlVWaHMxMGYzYkRQ?=
 =?utf-8?B?bVdibzdCUTByNmF0SkVlQXVVU2xmWFVpay9RZDN2Z085RXo1NWdKTDRpNGFv?=
 =?utf-8?B?M0QyU2ZsQ2d3OEU1cVNwaTJXOUQ0cE5NbnNGQzVpaUVxTHR5blRQVjhCY0pG?=
 =?utf-8?B?di9XRjRhR2hzRmJsY0FJN1UrOHBqbWEzbWVKRDVuU281bXNRUzByTlZVT1pl?=
 =?utf-8?B?b3JidE8zcHJyazRZSE9BclpNNlNNVytxWG1qeGNDL2plWm5YWXR5M2huQUNw?=
 =?utf-8?B?Ymp3a1lHbE1FL2lqMTJoMFp5TzBma0UzdGUwVkt0MFg1SS9nWjdCdVoxRFM3?=
 =?utf-8?B?anVYdHpyMk5GSlNXdW9zQ3NJWG5Ma1g0Ylp2RWFVdVJQWGlvZEpPLzNVdys4?=
 =?utf-8?B?cXdZMWtqK1J4RmR6TGhkU3JLME5ZdXI3UkpWME8vL1MrbzBVbmJScjFYVXZ2?=
 =?utf-8?B?TkZZRVN1WHUvQXlUSTBNZXVpakVZb1pDWkVUbzdYOGpjY0RYTFlQWHZZYjVD?=
 =?utf-8?B?TkZjbEtUOGVKYXgxTkhuV2RQRGxsRlpkUVp4QzJ1NjJyK3gyOWpzME9PMzVX?=
 =?utf-8?B?MDV4RXNqWjVZZ0tSd3M3U002aGhrak10N3ZTZFQwZzVTQnQwZWZpSmV1TitW?=
 =?utf-8?B?VklkV2NiaktDNHY4dXdSVjBqYTNSSlR5bzM5MDh5WlMwS1pTRFhlQVgvVzhT?=
 =?utf-8?B?N0RaQ3BjdlJ4VVd4U01UcjZVZ051RGtCcFlIRlpXYnBTWWYrdjExeXBsdTBj?=
 =?utf-8?B?cE5tUG9MYXg0RlE0WjJKSzFsdE9FUlhmOW5lazVpNmI3V21iZEt2eGZYR0lZ?=
 =?utf-8?B?L3kyV1NmNDlYMEV6dU51ek1IeXlQcHNmVmpsQlBra05DS3cvQm5rc1FFaGNq?=
 =?utf-8?B?anYrdzVPaU42RkcwbnRKQitTSU9RV1d5ZTlLbmM2QzA5dURnOHhpR3Y2dlh1?=
 =?utf-8?B?cG1pLzlFYXRUUlZnUGp4VTRLMi9BY3o0djZWclJNdFh0OGtsVk9uWnFzVlg1?=
 =?utf-8?B?NEkxY2I0QlQ5VkRMNUhmMndJZ0p0c2RPTGFUYjJnTTBMa2NwL3pNU2dhazJs?=
 =?utf-8?B?VVdQTXloUUo1QStlMDAwTVFQaCtUQUg2aGlSUTNCVE5Hd2FPam5lbVI5QXJG?=
 =?utf-8?B?dktDdVBsZ3pDRUh0QWx3K1JvVFJ3WVJOZTRjNTVkM242dkcyRmhWRDQ0QWRp?=
 =?utf-8?B?eXJ5VG0wMmxhV3lFb1pDSFNjeWVSMTQyWHo1RFcwQUpKWit2REtETVRJT0VD?=
 =?utf-8?B?TkpaM1A0MXk0WFNRaXJreVdYbkxzVm1hWkczMUR3dHZQMFZla09qRzlxamZm?=
 =?utf-8?B?WHJSZEZ0eGNjQzVPRWdRU3ZINTQ2WGlYTXdFTFVQYy9RQUFKeU45M3V0RWtS?=
 =?utf-8?B?aE5OSkc1b0p3V3o4Ry9UYk8xQUJQSFBpNytFTTUvaFpsWkVJLzdJbUNNY1FM?=
 =?utf-8?B?VUx4clhCZ1BSZzVlMFJFUDRBL0Z0VnFUdm1oMkFzNGFhZU5YZWhzVzRlRTd5?=
 =?utf-8?B?a3llNXBCQ3UwdnRxeUpQdS9iMHRTbXpsQW5GZS9SK0U5dStjK0NZbTZTSDNS?=
 =?utf-8?B?OVMrYUY1SWdPNGQ1QkRralAyNFQvbVpwUEtIdEc1UExuY1VLOWh3WThoWSt2?=
 =?utf-8?B?dXVMaFFKWHQ4SkFzZk5Eb05RTlFpT2oxWTBrcytyTWtLUGpyYlZQd1lwNkdh?=
 =?utf-8?Q?0UeMWiPYGHSnrSqSV0bOua8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f1c432-37b3-4cdd-c143-08db4c9f05d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB5026.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 12:56:48.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1EVg2VaXhaEz0syD5vrPynupoLf2XpTO/1FWZipVSD6uNjT4bLM/hAlTJljEu0HCpeR+/5AOMoU5Cx/JATONnTOblshmom5278Lsf/JjQbxk3TcWbLWwWPqS8f8co+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2710

The iova allocator has two rbtrees for allocations that are not satisfied
by rcache. The two rbtrees track iovas for the ranges of 32bit address
space and larger address space >32bit. On deallocation, the cached_node
is updated to point to the deallocated iova.

Because the cached_node is moved to point to the recently deallocated
iova with higher address, the first-fit allocator needs to walk the
rbtree backwards skipping holes that do not fit while holding
iova_rbtree_lock, which impacts performance and can cause soft-lockups.
On deallocation, do not reset the cached_node to the freed iova for the
rbtree tracking the dac addresses and keep moving forward with new
allocations. This only affects addresses > 32bit.

This patch was tested with ‘iommu.forcedac=1’ and 20 dd read instances
of 8GB from nvme as well as kernel compilation running in parallel.
The test results obtained from /proc/lock_stat shows the following
improvements for iovad->iova_rbtree_lock:

	Wait time average: reduced by 31%
	Hold time average: reduced by 60%

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fe452ce46..d2a6cb573 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -106,7 +106,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 
	cached_iova = to_iova(iovad->cached_node);
-	if (free->pfn_lo >= cached_iova->pfn_lo)
+	if (free == cached_iova)
		iovad->cached_node = rb_next(&free->node);
 }
 
-- 
2.34.1

