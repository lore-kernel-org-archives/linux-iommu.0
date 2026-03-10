Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E73AC0D9
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148919; cv=fail; b=Lc3reK51dLdkv1NBeWjXRWp9jjAwiqM65L1m/t0ZNxmm4MMG9hGGvNHs16UBvYLYow4yy4xZ9j+fvRsQ+EZwpk1O4Pt33Ue5abk8pFPFwspXzQCGALeF6yK/CPyOg+CWstroeE0HrEbVJDbwmJGrsCSiNYlXBNTZCYcGOU+b+nY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148919; c=relaxed/simple;
	bh=hRKyC5RgGOAXxHf+TP4mSjh4vpqtC5rpeGEDE3OBixg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qh3mo5My2R+yGGtwDaMezyJB1lKX2ZJ9C+J5IdHwJxCtHZKsqxO+MvN7NXe8Kes6tSMiYulqiJWdiufMtgryWO8kbK7yVicSrPbCEEI23WuTpWDYFg9+Vokgh/MrqNkwwGUL/WnNJRf+45iD4eZ/JxOwd4VbwcbbCOa+ZFe23mc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=abKBhvIq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=abKBhvIq; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="abKBhvIq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="abKBhvIq"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KtHjTaP+5gNNx33WcKGWFZOhpu4KlNi5dryPj4ErRcs6I8UU+r0Zj/DLA8dohc4RMeyKh3Z6lR8xuq+FzADTnLO5LOPc6XAic2xb9CCjgOWZmM2dJbNjMHbNxHGJSo0JF5lw3LAJsMuZGSy6oOfk/sET+A45Sf/xkAqfksPONMKZviKTnhFeJ8b8fP3a2HCqzX4Mgl42uW1Ek7sVDfvVHFWYYtylQ/O9yK4ZIOwiPsKrxRnpuyQsmwdo+CXFZ6J4jwZqacWqNGGj9sfu38raoFL5dh6CTSWn4YFoUGLhuUMfhKZBq+s+n7ejT07tH/CKfdcY/01KI0ibxo4owYwBvw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLtObYOcVHAzAS2ky05hDQjjd3jsaqr0H8QGqGaFxE8=;
 b=TANo5BPAmeUCfvEtB0kAFvwhTjR/hH/T8K/MUDG7mrpNGJChLowuRWAG67t2ferFDo/2DzAhdf2i/FRIMa6vaBd0jarMauJAiEcdKeMXx0hXjICrQ1w5JWzmZ69xTJXIsxsec9kr1eOjY9Fo3GErnvtrUrNpz94vSZB+4CghkHIBEotiwwmS6jT0sq7msg8JYhDdyX2aA9h8eG70AQLu7GdbiL+GvyAAgOQjectzkpAh74Ro9iFvAXal8Z/alTkLcUd0qNSRxDa+rBoSw6KqJgnd7XY8azYytIlVebShuGLvkVTdl1HdPIZkSafUGob5rgeJ0HVHSN4i7NJ/+r/Lsw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLtObYOcVHAzAS2ky05hDQjjd3jsaqr0H8QGqGaFxE8=;
 b=abKBhvIqy+M5G5UoZ8cr8WJJfwg+GniB4t88CIpuR5gwAWroLsiIB7YBLaQ3AGQuZGqw4fC2gtQVb7UvuG9bFbvj/7Of/8FsLZMc4kM1Fo9bXkxeOjK/cQ62cELrhTYOklAxYwjfihrG6yX7uA1Ds7HA2LXiK2ZDFdCqgYY/p2Q=
Received: from DU2PR04CA0287.eurprd04.prod.outlook.com (2603:10a6:10:28c::22)
 by FRZPR08MB11098.eurprd08.prod.outlook.com (2603:10a6:d10:13e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 13:21:50 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::b8) by DU2PR04CA0287.outlook.office365.com
 (2603:10a6:10:28c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 13:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via
 Frontend Transport; Tue, 10 Mar 2026 13:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Odv44i63gw4PEz1h/97oCQ8YglvQvAJGTyNYhmiPu8n7Q7ikDnT9YQOYeMXODhAkBnBRgl1jMZl1N9QsKIHtdF8PoPIttA2YedbFNaJAztrrbU7VC8a9l8Ldax9cUlypIEy3cgzSk5zh+6FXYZqTxsA6h3nxwwMwQuD5eDNH6ao8/YRGwgYyYqj721vaK1GHRfF743LzV8yL8SMV+Ast70iVjaYrJQgu8Ge1tcZfmLCUNXN6Pcwl6CNAokk9QVbcIoBvr+XlbIbEs4CVbW6/NuhXO6EVsaJqVWXeWASNLlYhmxMklmp9MN8Sec/Jj/ccij9+Ze7sQE1YQQ/kF6mgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLtObYOcVHAzAS2ky05hDQjjd3jsaqr0H8QGqGaFxE8=;
 b=bdGDkfrFyQ23do5fr+87y+ir+KfU6lCL+JpsPbIFjs1Sa/Z67zDx61x6ti+NZbh/m3/8LYS/v8k032xcEGRce3Ap1KW4b4Pq2FQOmfNN5tC6vrnxxqXxqp5H2xkxv4jiYBoP7CPmkvNqeMtWyuBSmKHEAGEqLa2b/gbcts9lq6nG0YE4EMO+YmHe2JGwyTy4/C+mpM2mzCHFGI1pM2xWHsiggRzXJ8H9upiIQQN0a6DZBiiC0dMNS23z0xQ4ldIdoiQdAzvmWGHdFGO+tWn6e1W2H6uiiaK5CmLRtlbFwjrjjU+R2VmsV7nEIATBHshNyQ0SG/Ps5LhJ57Y9YD34mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLtObYOcVHAzAS2ky05hDQjjd3jsaqr0H8QGqGaFxE8=;
 b=abKBhvIqy+M5G5UoZ8cr8WJJfwg+GniB4t88CIpuR5gwAWroLsiIB7YBLaQ3AGQuZGqw4fC2gtQVb7UvuG9bFbvj/7Of/8FsLZMc4kM1Fo9bXkxeOjK/cQ62cELrhTYOklAxYwjfihrG6yX7uA1Ds7HA2LXiK2ZDFdCqgYY/p2Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11754.eurprd08.prod.outlook.com (2603:10a6:20b:743::9)
 by DU4PR08MB11791.eurprd08.prod.outlook.com (2603:10a6:10:641::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 13:20:47 +0000
Received: from AM0PR08MB11754.eurprd08.prod.outlook.com
 ([fe80::3427:f97c:862d:1850]) by AM0PR08MB11754.eurprd08.prod.outlook.com
 ([fe80::3427:f97c:862d:1850%4]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 13:20:47 +0000
Message-ID: <5141cfda-cc6b-4cd9-82e5-36cb14f9a434@arm.com>
Date: Tue, 10 Mar 2026 13:20:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] dma-mapping: Use the correct phys_to_dma() for
 DMA_RESTRICTED_POOL
To: Catalin Marinas <catalin.marinas@arm.com>,
 Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
 maz@kernel.org
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-3-smostafa@google.com> <abAXsK6XE6119g09@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <abAXsK6XE6119g09@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0060.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::9) To AM0PR08MB11754.eurprd08.prod.outlook.com
 (2603:10a6:20b:743::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB11754:EE_|DU4PR08MB11791:EE_|DU6PEPF00009529:EE_|FRZPR08MB11098:EE_
X-MS-Office365-Filtering-Correlation-Id: 176f80b0-23fb-4e2b-9046-08de7ea7fcdd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 AkmK/KslPNpp8ZIO5wtx/jBjrPXnVFKlokMAauk8CldK7PcIK/apUPSa+j8T+DoGbIYB0eYOFrSsdcBDVKZCeA5ZZUAO2pQcng0c3Z/OOtfoxsUF3OehioJU6gitlXWlDcfS8nOhZvdnIV7GEsm8rqbUfsj9Zo8iHRVmoBYsN8oQ03YIU519SZXXjszrTdxVZ6ahkqbngUTR0Vq9PatrrOxjs7KtoXQRAJFbFQl+3F0FRsR13VQrxfl5nLoJyZsELQTiDQyemxdaZWqC/OfXRDttzl9/sV7auw6GFnGiNZuafzvDTiIXa0RkqkPspocPLeoXZQJ8PKm9yPdS1iEdWuS/foPo0DIUu62ONnPlYBDK6KQ2iBG/LRuyWC4WJXFjCUci+lP7YgOVd/h6GDRCm7NsPVBPGm9z7bHILgwYrxS05NOWBM8u2iveUCkCZK3xm/gN+jSor4mg40gKdTaN9cFMIjURiv1FvX5f7UMBBi4/mlvRd09IipZyN3moStZ+brVh4YGUFK2YwayvhjQBenyOPsBEuPIBGvhm18GFqVUu55RzOk3+/d+C9+UAFd3574VC6ky1k9gEuEFL44crFdlWVaJvxqCHSU4l4JxoKdJH46NUvO/BSXIMkmIGsuVeZrAbp+HU1pWmgnxmTYij5UQ4EpBKgcF3+3b7F13K6nXwr6k1sgbl1pnfgUueqVHL6bBxsPUm2vN+dC0QKXDuXQa38NKpMgtiSemgy3j2litQhxbSFfnJD9zZM4Bpbll+
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11754.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 DGcmIxemAHIvhoAg3jgS462piGVWR1egoBNuknkr4N6R0+wJy5FAO4CY4eeW2VkLUPal8Kgw7GFR6+5FCj+jkp2HHUKOd2CSKI4dqFCFb9v4yffrYOyEKG81CgVBsk0TWkXIAccHBaYUcrnRkOqJDDnYCEVeRnyvLFAyOq2Ofo/lKMxfJXxRl3PMDx7dZhUnYcDJDYP0ORdV+Sj30pCwv0t8vACeRg40VPaBDdFPs4YFCTp6BZsTGO3ClcUhE6FyNgblpKaoPrUoNoaX8+2fVeEwPunzFlOa8pUqETaHBsdQIhHufzKDs/Lw2FRnUABg8mieLHanEpF5bmcVKpdAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11791
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d0f5400a-86d6-4a27-dbec-08de7ea7d760
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|82310400026|1800799024|36860700016|13003099007|22082099002|7053199007;
X-Microsoft-Antispam-Message-Info:
	6ZhS50+Infa+RbpBSYZe9lwv+eQLPu2eH1mULEyCe2PI31FzrQiU6HnH+IUG85/enVSrCyd6C/xtHeLYKZoB02G6ECoDTKyWzF6NUwsGFoX8ztg7uv6NVSI/DV+tLfLFVBmml4laHrAtp1ladyVTC9CPmqWFtWb9SPge3uyHNS/BvN5qcVNAOq0p5Mn/rFnTw1US2DROq2d1EHqyws8i2JXw8gGY/yJxEmGMJuRVs7J40lGUEu/hPnKqm4sGohuhDiSpGSCwosDCDxkaPjxSzKWBdCOMNakOaRbKvhNd1bA+mYSKnrK2I7BRdoy64GZ0WbS/OX73YBznaIJLzXFYNOSizXwHyeGgBglOhm3v8j/JFslQm7j3/AmkYQBdRuLnoNsyzZPMxgLctdJYgSYDOra81F2znIBqkwqihfqYs6RFSWBJovTwocdf1ObZ+/fueemKBt3OO/G2ajMp7IcZiZR0wfT3SAvXvwb1+J/1tfJtBgeCrfR55MVCXCm5/UYzLPCEw8ecYknX10b0hlcGpIuLksjaFyk7J+cJvIONQyzKQRR7oPEvQFh8HX1uJsieDhGt5CpGY4hYqEXe7vjQGiig+LygzExmrUuKtM9tzCv+SREtZmhFic7QCleEysAr8qD/W/Ko4M1ouvW0ZMIO7P6aNXDsgdxR8kYgmRYeevU8oLRHuCmIP8BJKMA4pSl4X/FUgVeedpWpY6YX75WbqROrcmUDfUzgYFkwLN0fAoVYuw2eD/V3Y28Qn6Om3JifaBvRqEL7y2NC5D3uQIb9mg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(22082099002)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nfIdEuym7Wenp2+9cc5EeRC/jNBA6XrfJq/0+bW8jqs/aefNsVbvF0PJ0v8kTidGIMYRqCZxFEVReDqundlLcAfgcpAaxpI3pTsCkG626YSEn2MvmF4GSeXEbB2aoZh1vcHxxkTu0S1vsH1aEwL+CSzUPONUHvpS2duaYdioMjicTKKm9xwvEDkVVzg9UznZ7VETyGhzEm5BR4zfuk9MKNRbClYHT4TpZPwT/g+GwQI7GwG/kOg+EaukrTSaSW6VnV+kqnkLIIkT60ZHngZteNyo8It5foXMStF7sQ97kDUso3INzfWedavktkK+ruphw+6C4CflOvnzVhPXKmwLwd2HJg9j3b7os+8moT8V4pj/GB54CK9fZJqCsndn0EKulDjzQCFPjgVcaPaKR5oHwMIvOnad/uJoRl/pScf1xv8c6lX5lV0bxWda2d1aEDpt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:21:49.9192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176f80b0-23fb-4e2b-9046-08de7ea7fcdd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11098

On 10/03/2026 13:08, Catalin Marinas wrote:
> On Thu, Mar 05, 2026 at 05:03:35PM +0000, Mostafa Saleh wrote:
>> As restricted dma pools are always decrypted, in swiotlb.c it uses
>> phys_to_dma_unencrypted() for address conversion.
>>
>> However, in DMA-direct, calls to phys_to_dma_direct() with
>> force_dma_unencrypted() returning false, will fallback to
>> phys_to_dma() which is inconsistent for memory allocated from
>> restricted dma pools.
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>   kernel/dma/direct.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 27d804f0473f..1a402bb956d9 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>>   static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>>   		phys_addr_t phys)
>>   {
>> -	if (force_dma_unencrypted(dev))
>> +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>>   		return phys_to_dma_unencrypted(dev, phys);
>>   	return phys_to_dma(dev, phys);
>>   }
> 
> I couldn't fully get my head around the DMA API but I think all the
> pools and bounce buffers are decrypted and protected guests (or realms
> for Arm CCA) should always return true for force_dma_unencrypted(). If
> that's the case, the above change wouldn't be necessary. I can see that
> arm64 only does this for CCA and not pKVM guests.

That is correct. Why would the force_dma_unencrypted() return false for
a device ?  As far as I can see, all CC guests are treating all devices
as "untrusted" for now (and there is a series available that is adding
support for "trusted devices [0]).


> 
> Device assignment is another story that requires reworking those DMA
> pools to support encrypted buffers.
> 

[0] 
https://lkml.kernel.org/r/20260303000207.1836586-1-dan.j.williams@intel.com

Suzuki
