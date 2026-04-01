Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08537E303
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029479; cv=fail; b=uVKz6r6FQvPpW2z9CHRenQnpC/GGXoW9KfOIMSSs3wYXyaDYw25ErKxtWpTTwEQuidI540+r7UoiVI+FIdgS8olp0FvRluAwRVYIhUsRLewRpn4MvnMzyMwvJLx0pr5EOGAUQQiIsTnzYBnHffYBfWob4+27Sfd6oJgebeJCg8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029479; c=relaxed/simple;
	bh=UlHX36vpAhukCQqlRJikgG//6VupbjJ/h7JW917iBQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXDFsOrDMA+elACbEf87Yuz7t9oYxlUa91ZnVJRM3zdJQkm4BmNfTFBXTGJ6XhAI9aKuCxSWKD7DtS8HOibzMUB85QCIvTtf+yogSL5opAguRkNWQAZRlQm13wA7Ha2QMa03FTIxf79GL+8Xx+l18IB/IVdOmNiTxxWJI/c9bqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B/D05+Fh; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/D05+Fh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0P8QZlGnYIV/sddPDLVBKWV9yF5ZaH1ZS/MpsCGLCSi0oiZmFNTScfRiYX/XSflxxmMnzYlEvrzCR4Kbzao+uTr2wrjWauTyedrCSPvVuXZ0MmfM3gFyC8oA5JTDsWGaiaH5+tFVTfC4LjA3OQ35k05/o+QENM6JMDsnEkceehH8+tz8nfJFKyq3XD6jFnEiGGOOB6VeEeJo737/VvVrnlXBLrkrlnyGxQ11cMDeFcH1G01ZGWZzSS/o4aqeEO23on8mHmJBamu/xbohzTFlZCbCSLJClLLZM5lwi1rPK0FLP1lek0LmDZgS7nq4J1ewR1AB9c1WY5pb+TspKXmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAwIO+m7T0q5HNIHJwZ22GY5mhXjzvO0oVKfCdR8Vfg=;
 b=QcFoiCO/AtiBAWE5nHfyLJwYavmhas6TwMdNIT8fuDDBqc6oKC0u0zDxr7qDiEndUIeOIVJyW/osKc+ITFiz4iVQ8cI5zTf7KkSi1Ww3cf47l8SjWxr0Fka4uON1ZsvN6KRcguMCQSlaR+5RC/2OB4jyy8t2rVctYw9iHcrlAnzi25LalLfwbN+ZXqRqcmyyVZlhKZBajv1kG8u/VlxVLFntlsREgHHHUvKOCiqON26QpkQb43q4wbYd/m0B1pS58iq6B50e6fLSsNwVFBbV3tLGRF7+6NHqv5dMZ/N6hVukiVOPwfOW13RXZ7YRGjDwN9/AM+lAmzOn7rTUmvtBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAwIO+m7T0q5HNIHJwZ22GY5mhXjzvO0oVKfCdR8Vfg=;
 b=B/D05+FhkYQuyfS+uEEgkSkfMnl37/kRHz3Sun0NUhWpLYyk6jXh3bCFiRofSP/xJbncCQ8DdD6mlZ+jrpdSOZiGs9SCZ3xeFDYOlg713YHZ6lDTTXaHn0iMi+gw0K8ZKydz2Um2ygr8r7J07XBCiWfagzjUVoD4BNu9j+7TZ0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0143.namprd12.prod.outlook.com (2603:10b6:510:201::21)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Wed, 1 Apr
 2026 07:44:33 +0000
Received: from PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f]) by PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:44:32 +0000
Message-ID: <122231f6-3aa4-4f7e-a663-a182460c9436@amd.com>
Date: Wed, 1 Apr 2026 13:14:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>
Cc: dhsrivas@amd.com, iommu@lists.linux.dev, jonas@dolphinics.com,
 joro@8bytes.org, larsk@dolphinics.com, linux-kernel@vger.kernel.org,
 suravee.suthikulpanit@amd.com, torel@simula.no
References: <2f486ae6-d22b-4a30-b93c-f019feb8043c@amd.com>
 <20260331124830.53189-1-magnus@dolphinics.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260331124830.53189-1-magnus@dolphinics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0226.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::11) To PH7SPRMB0143.namprd12.prod.outlook.com
 (2603:10b6:510:201::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0143:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d00a5e-750e-4a34-80e8-08de8fc28342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QmpgD4e9OcTSxbYlTfsvbwLpiDxRGIBvhHQ+lfT4Qr5dsVcUOZHhzpu9xn77DfslaZBfqePLVKx+baZW3oHs9C7UUQrqfZn2OX11NQV3QWHr0enLGFEixeHSukhitJIFbbtIhYd9T5ePQ64iS95FaLncf/dnJqirNLOHBybgJqtQIpcAkbt967VjFaXltF18Pp6IqntcJFL+x3lfVTf9KvtiFmXsLQWrV+rPcgnr+iMtN3V9YAK8Ckmor1h2xbhMPzWwg6bi3YXKXy1eGpzFRlGF5mB6E8qaM9honR+4QJMCzF9iKOjoqkFYFo0+rNevZAuZjfoLUU6Znf+DB6B+QLW2OiV81Xm7FBL+9SUlYfSoU07vZhnRzbEKOlfms/UZvIHEGVVpfX77B38t/RZUAVrHH5p6puzGmfN02N01jwMA/NB63VBx4FBrzsPZ6vadl8JJMxztSm1c6SyRZ58j9pVhi23Mui8wVy1epJs5vHw4QOT615eexaiuIUrdCBIU7DWonr5f6cHYAOEyHDf4aLdCSdRCJ6W8j8qrHy3hCy3woexSbUY4cw+VSE01IgkPhY8Apk2/qMmayWoIFoLo6QXO4Etd0JOi5k/ZkL36fLg0ZZNcGt0mF8fLvoclGOxwvTDdw7rx5UTdyfD52KqQtWUxwjZn0G51OCN1E3RhevxvKpi3YXOAQa+1enek0PxkM5cGujj1n4YeFiqfc2dG7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2Z2RkhQdy9KdkJZSFViOTBpU2FoKy9nMXQ5dWNXQitzM0ltdzNKUTBwZkda?=
 =?utf-8?B?WHFYSzZ4QS8reTFhK2xOeWgzelQ3aWZLSFZyZVJQTkVIb09ad1FCdTlDMkJG?=
 =?utf-8?B?cm1yaWU1STlVQVI2M0liTUxPaUczZ0hrVHdWVEFjOW9sbXJwU2oyM0dBWHo0?=
 =?utf-8?B?SmIwdTVlaGNESllmNXhoSXR2dmZIRVQzQ0V2V1Q3bDZaOTEwWkx5WnV6eDdz?=
 =?utf-8?B?K2lMS2ZaNENUMGJvSElJc1F3L2FadW00ZEdOLy9vbmpITGlKdFowaDhFL1ND?=
 =?utf-8?B?MHdQYkdUbzRpdTZadDlNMmswK0JSR0JwQmVyQjAzZlNmTCtTTDZNYkROZ0dp?=
 =?utf-8?B?Tkhnc1VvN2REYkJXQjJ6VUtDTXlWZmNvSnZGbld1dzlGOVNWQ1Q2TWtOcWti?=
 =?utf-8?B?azVPcWJueHpPdHJEYU9scTRSRzVvL21DdzJwVkNiaFcvYkFtWGhUTGdlZ2tL?=
 =?utf-8?B?RnVvcFlhQ2MrYWR4VHlaZy9lTCtVU0RTcG9NT2xKWk9xRldwMDUwcDRTOVJF?=
 =?utf-8?B?dTBKQ3hnVXFITDFPUDhxMkpLUHJuQjRrZFRQZE1icDRCSDV2ajZKeXRVb0I4?=
 =?utf-8?B?N0NsN1RJVE5FRGptSmcxdVRuRkh4WW5qY2Z4WGF6ZmVmbEhXZFBycVV3ekhV?=
 =?utf-8?B?VjBiWlpsSHlZRjZFRXpOeFhoWHBqc2FwUXJWbHJXamRXVi9vSUF0V3hWQzdQ?=
 =?utf-8?B?WnM3VmJBK3RNNWd1OUl2b2Y5UGNFSlI4ZTZYblVFNTBQMUgyL2RKakJBSWVC?=
 =?utf-8?B?VFk3WVdOUEI0ZzFnOWNTS1FFZk5EM1NVT1dlU0FjbnQxaGRjZUh2QmxvcnFE?=
 =?utf-8?B?QmV3TVlMWmYrcXJqN0hUWXVrd2RuRmQ0Tm9KZUF2QzhvbjMyTXFLUFBBbUcw?=
 =?utf-8?B?UnU5aVBIQWlrL2ppaHAvV2tEYW9IKzFhV05jcHRPeVNyVzluc3FjWW1tOTk3?=
 =?utf-8?B?akJDQW5NY3BPV051aUxHTEFtZ212MEdUb0UweUxKWjdhR0RiOWlCUzRRZjNx?=
 =?utf-8?B?T1R4S1RoY29MS3lUMTRrODhTMU5Fd2Y0cWQxSzV0SDF0SmhqalhLbHovOG5K?=
 =?utf-8?B?SHR6cXJObWx6RE9tc3hBd3IzV25MUCs2Q1dDNGl2akg3RjZvSXZKYjRlWmtE?=
 =?utf-8?B?TGRYV2M3TjVpZTNaa2wydmVOM1BYZFFKQ2tLYzk4RCt3eFFRNUx6VXIzdTVR?=
 =?utf-8?B?ZW4weTUyM0l1TWI2aVl1K1dwZGIvZTE5NmNYSmI3dU5MM2NGOXk4emVWODM0?=
 =?utf-8?B?czlFVGxiUzNOSTdkTGQ4Q0NZbWlydEU0RGRPNk1ORkRuV3ZXMEppVHkrU3Mr?=
 =?utf-8?B?Z1o3ajczaHJBM1I2R3I1WGRDVnBHdWsrQmhBSlQ3L1lVekM1VzM1Z01NR3BK?=
 =?utf-8?B?eHNFbU5DNjZXbUd2VHdoVnR4OFdCZ1A3Z1lpY2psN2poQXIvTmFUZDFYT1JX?=
 =?utf-8?B?VXBqbHpaVmYyMXlsbzlucDNpTGpubmtpVHJEa1Z3b1dRa1pYek9YRnArQUxh?=
 =?utf-8?B?cEFIZDR5d1MxVVhYcmtGRHJoQWRTaTZoYWFKWjNRQ0Q1Q1FCWUNFckNROGtZ?=
 =?utf-8?B?YkJEdW5CNFlFS2czZ3dSZWpEVUhIZnlwY05zdDc2eHZua2RNTWIybTJsckFL?=
 =?utf-8?B?MDZzTmtjUVlWeXFIeDROOTZsYW1ZQm91R0VFVk4vVjBiclAxSVVTTjRPQVpm?=
 =?utf-8?B?MlM0OGN4dkEvYk92YzRVZG5mNWZ6c0pPQ29NVlFkU1ZQRlVDekVWUytoYWpa?=
 =?utf-8?B?MERuejdmWG5HeW9uMmJ1TnRLQng4SlhIWm9sT2M5Uml6V1NCejAxOVlxL3Vy?=
 =?utf-8?B?d090aVZGNDdlcFY1bmZqOTFBZkxySmlLSVh5WUl6azBIcDJCdThaUmVoa2Rh?=
 =?utf-8?B?RENOdGNFdTA3QW15dm1XMTRNUFlqVHNvcVhRc2xNQmRBV2VDaERPQ0hIeU93?=
 =?utf-8?B?YXlFOHBmM0tEMWxJZkJqcmlURjVZdm9COW1reTJWV2lkSDRJeGtRditDU0ph?=
 =?utf-8?B?M1I0bG56OEx6WmdaTUhFUkFYVnhsbFdYcHl4TVBKcU1EcFVIZCtjWS92RFI0?=
 =?utf-8?B?WVJLNUE0VjdLeUJwOUovZXdLSGNlc2p4eU92dXR6TTFoRFlOZ2s1NzQ3ZjVK?=
 =?utf-8?B?NTBqbXc4ZjVoZEJCNWVXcnlRN2Jrd1FnektrNExVYUJKVHlvZlhNUEEyQU81?=
 =?utf-8?B?MDQyVUFNR1ArOXZYZ0RuRGJ5ZnBNOCs4MmNKNlBXWVlSMGtUNVZCdmpPbWd1?=
 =?utf-8?B?a1lDLzYzZFlEOTZuYmlDRllqSzEyWWEzUHhGOFVyZHdYblZiU0lLam45VEJS?=
 =?utf-8?B?K3ZKYmsrN3hLdVF3UGd1WDVkWWJJUEZBSDJYbHk4MVNVQ3JCbThZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d00a5e-750e-4a34-80e8-08de8fc28342
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:44:32.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKrSGBpEKdO4ik4Pkc+rComtMPIUL45ez0QJZvpqauihlgEGiOUKFqgFXtLgYsCBMxifdm0XqVX6s+1LpjieCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

Hi Magnus,


On 3/31/2026 6:18 PM, Magnus Kalland wrote:
> Hi Vasant, and thank you for the review.
> 
> On Mon, Mar 30, 2026 at 04:48:23PM +0530, Vasant Hegde wrote:
>> There is a possible deadlock. Actually we can remove lock here?
> 
> 
>> path 1) alloc_irq_table() -> holds iommu_table_lock [A] -> iommu->lock [B]
>> path 2) iommu_flush_irt_and_complete -> holds iommu->lock [B] ->
>> iommu_table_lock [A]
> 
> You are correct, there is a possible deadlock. We can avoid it by grabbing
> iommu_table_lock, creating a local copy of the aliases, releasing it, then
> flushing the aliases. This way, there is no nested locking in
> iommu_flush_irt_and_complete.
> 
> We notice that the alias table is read in other paths without holding
> iommu_table_lock (amd_iommu_change_top, setup_aliases). If we can do the same,
> then that is of course another way to avoid the deadlock. What do you think?
> 
>>> +
>>> +	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
>>> +		if (pci_seg->alias_table[devid] != alias)
> 
>> This is heavy hammer. Why not use pci_for_each_dma_alias() like we do in DTE
>> flush path?
> 
> Agree this is heavy.
> 
> We cannot use pci_for_each_dma_alias. See the reply to our v1:
> https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

I went back to those reports and reviewed it again. It looks like
pci_get_domain_bus_and_slot() takes spinlock which is causing the lockdep issue.

I think V2 is good w/ some changes to get the pdev.
Instead of pci_get_domain_bus_and_slot(), we should use dev_data (like we do in
other places).



> 
> However, we have a v4 ready doing 256 loop iterations instead, since aliases
> are always on the same bus. I think that's a better approach.
> What do you think?

Its a performance sensitive code path. Also during init path, dma aliases are
set properly. I think we should go w/ pci)fir_each_dma_alias -> flush irte path.


I have added below fix on top of your v2 and did some sanity tests. So far it
looks good. I have requested Dheeraj to rerun the tests.

(https://lore.kernel.org/linux-iommu/20260205140059.11857-2-magnus@dolphinics.com/)


-Vasant


diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 050178cf388f..eb23b9e7bf03 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3118,12 +3118,10 @@ static void iommu_flush_irt_and_complete(struct
amd_iommu *iommu, u16 devid)
 {
 	int ret;
 	u64 data;
-	int domain = iommu->pci_seg->id;
-	unsigned int bus = PCI_BUS_NUM(devid);
-	unsigned int devfn = devid & 0xff;
 	unsigned long flags;
 	struct iommu_cmd cmd;
 	struct pci_dev *pdev = NULL;
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);

 	if (iommu->irtcachedis_enabled)
 		return;
@@ -3131,11 +3129,12 @@ static void iommu_flush_irt_and_complete(struct
amd_iommu *iommu, u16 devid)
 	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);

-	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
+		pdev = to_pci_dev(dev_data->dev);
+
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	if (pdev) {
 		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
-		pci_dev_put(pdev);
 	} else {
 		ret = iommu_flush_dev_irt(NULL, devid, iommu);
 	}





