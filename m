Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05736CE0B
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562796; cv=fail; b=sBOUTYM8GeLK1N7xCH9Ltx76hfhN1ZeTPSV1vwkCj2G/YV/goBsGe1hJqZZDLbfi6L5HV3q2/DCzeqjnv8lRsbeZLPKgNqUZ0E6HJfKkWBt9nImSz7NbGRCNo7rnK9IamodTjLfvsLdZjwfXN3RjkdCLVodlNPjtPRsB6bbWL+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562796; c=relaxed/simple;
	bh=egQq0nH0piyGS3Vv4VZDq6CUJ982A65M49gMxM9xr6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L9B7j69JpFzsLh6nN/hBZIdq1/+75mPJkfjHA6yQdwZA1v9quAVCJ0FIX7vpt+1s7kk6yH2oTy3QobOny+aMFkxTUv5pSRVrKJPGSsTZixjpnIgti8gCWf7w0SPis2WsNR1pmIcQO6MVML5tXC/5bIC1vhP2gaPOPwd/AQ6MCek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKejkFDe; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKejkFDe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbX31KBH7xa2/c/riv+1RrgfjtWnxR4Oz8idbhl5E3VgXdFK9ZXcSLLeKg6qRdicm0TlfeqDP0vLgZc0Rsgs5SQEo4pIKv8dJo5trCjELPfl9eN/1pRkW4cgqGZbKypC8moCAG9NoRXbGwLIr/epmhK5zqIpCNmfbPSLT5KiQoeoM8z0Xy2ijHZYRnjJjgWX25/3nAOGoFdIYIpzvy9R/k5lycM1owlzJennhzyvZ079Vm7sXh8708j3q9kbz7JxQ3QseHCYIoVzD2q9wabJ1UxiCmRhjRQzKxZdGqROas9SmqKnFEBnqqBZ3M2likmxfZs2W888s4Gfqklw2I1ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D+xpgZEAIBzXZTWaeKny54Hi6hP3BKgv3j19kCcmus=;
 b=DmYHJmknB7BB+fGaG3bMYu5CZ9YIImD+tYUnCIuEN34OtFGQeNSmnUyxJr4mVdkwewCaJyFoczeXvvDQsdEgW9TpHBQnboyk43HRAVSQUI2ejIUnsivLVlAOpaQtuJK+6VI89gBDaC3NOqD1ZDS6i4BMKdWqCmaQkSL5MGf49ef2Pgu0ANSV9Z4O4PqCqVQovCSxEP/TjOkmm9IsFGb33QdLh0bIaa84KrTSsPswrhctQIiqeMTJNN5fvevfqGG4MbASQNFuCkRV+FnJx3DFza3kp6uDC27PWXVNOjFJ3Nn/X69ncMGr+sfhpPXxNP3YUaANe8TCEM0Of8T7jVmCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D+xpgZEAIBzXZTWaeKny54Hi6hP3BKgv3j19kCcmus=;
 b=sKejkFDesyT0NZQbI5xO6C4VrMSmK5QBiYbpYpAQzXRoNLwQHjPK9592pEaQURhH24CON5Wl0ssu1H3Kx0zarBeTZuXQporAz0HP5BIIoyVdOah0t5FLKAa8OBZTyKdIm6zdQ4i8Hv0bRZJndNe0s0ocYPWlVH3sTIqqxXqum48=
Received: from CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::13)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 18:33:09 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::c3) by CH0P221CA0005.outlook.office365.com
 (2603:10b6:610:11c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 18:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 18:33:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Mar
 2026 12:33:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Mar
 2026 12:33:08 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 12:33:06 -0600
Message-ID: <945476d7-6e2e-b8a1-904b-09c8c87067a2@amd.com>
Date: Tue, 3 Mar 2026 10:33:06 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
 <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
 <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
 <967d515c-f098-48ff-97cb-2de34f17aa29@intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <967d515c-f098-48ff-97cb-2de34f17aa29@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 537931c7-5566-4503-7866-08de795351a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	4q2URhDWW9mbjwWDd3aN/F8v1oMEawloCpYLnmS+ZFj4BuESJ15VhB02MpqfYgdodIiBcE8RoXcOwxR35fP97H8FMWVWaOcW7xi/1W8joEgWDueqo2kSPtb2zRjkMogK8QTVTdJ6E1Bg6CCSILFAmUqvGsIhsnJbZ9xdU+B4TmM3S4aXEpvM2IhxvYKA5A8RKi/1ySzJ5p1MNaXoW6eoh0dHbfk2frI50pGudq7w/V6pM9hgimDCNfIGygk0J2/jCy5eJ8i7RMTFgh18tMuqf7uRTpDhGHG7IwCIq45ju1TqUSM/Nl9RzALXi4wS2WBzS5GRtycMzqL1PZrIgmetVSzGJW9VljEQu/rFGOQUzLtq8lR0iGFa5vvupUS7T3prWEk0pEMs45bbPU23rRuaaDL1/o+wENe8n7BdzDmvnoEaca2Kum2mbA+e9KXfWBWZYDHLs2TVkGoz/6oDGIQqIGMrYHT/IBMMGNJhrHvjA/vFTkK6/EJpy/McWiv3IDEBZIhhfb5dNqE3/znwX1vDI4BpccsPA+h0TmhOBgLaGUeILeGgdiHcQWEhN1a5A86vi2CSR/D2NfVtYmmu5wYYuiYm7PY33pIcOCZLBbU5n/3Tx+l7MYKmHQsvVM+NFNEmbdLEenDx4MhagZQx0lJs7SEJMycsFJPvSkrLHkj0gHMDZ51ZejYY3kN1BaWm9mouR4AZuVllmHeOx3sllDQJMkvzKX7nXb9wtD8UU1KXdmibCsL0uQdYooqIY+wsZ6JtsO3TXMVvue48GD9hwVvFUo4fcb2m12wh48aVOzwodegKOef2fOtZKjDh3JwKDxoRgLqeWDhiWLfvVssQh6VAKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	729TSP3q6LM8PmDy7vqNC6luvFbw1nKZEuD6MRLLWTDs027ECV2VrUjvehLgBXDcCS2DH3aBp54Y5sq+hHaaLDWrjGk6sAwlQs4/rglEa2TMJcrEgP5+7mVKx7mEdcnl9WiBUTyPCsPXpSVLkrf7i9K5HcEHKHAEQO2DlbBk4xYGpeMxHlqpxg+UVYPDh5EFcnhEVs8fHUAKYvvPBIQ0P/en9kKoGiWhNdAaF0iW+S3ySmVdgOn6V9bvBpM26uMHGwpIPVPryWN0QJd81T1YYc+D24ltvpS6sR4aSpLc8eRUXSb/PVfbnp+dF2rsfm0pDUdSIVAgvlrHqKdPdUwqIweHofEANLfcuiWRZkljvQlXcbye2Ezjh3BLo3v6hnnXkYQEjwX0CfNhiWrpQEpr0oRkLpQ0pLII0Nf/JHucRnLHs5yYBW+Kf5JQoA4+LeLs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:33:09.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537931c7-5566-4503-7866-08de795351a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204


On 2/28/26 04:14, Yi Liu wrote:
>
> On 2/26/26 06:09, Lizhi Hou wrote:
>>
>>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>>> index 07d64908a05f..523b8c65c86f 100644
>>>> --- a/drivers/iommu/iommu-sva.c
>>>> +++ b/drivers/iommu/iommu-sva.c
>>>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>> *handle)
>>>>               return;
>>>>       }
>>>>
>>>> +     mmgrab(domain->mm);
>>>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>>>       if (--domain->users == 0) {
>>>>               list_del(&domain->next);
>>>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>> *handle)
>>>>               if (list_empty(&iommu_sva_mms))
>>>>                       iommu_sva_present = false;
>>>>       }
>>>> +     mmdrop(domain->mm);
>>>>
>>>>       mutex_unlock(&iommu_sva_lock);
>>>>       kfree(handle);
>>>
>>> will moving the below hunk in front of iommu_domain_free() simpler?
>>> Only when (--domain->users == 0), shall the code check if sva_domains
>>> is empty. right?
>>
>> I am not sure if this can be moved in front of iommu_domain_free(). Will
>> iommu_domain_free() be possible to impact sva_domains?
>
> sva_domains is used to track domains associated with the same mm in the
> generic layer. iommu_domain_free() calls vendor iommu driver's free() op
> with domain type specific operations. I don't think it should impact the
> sva_domains.
>
>> iommu_domain_free() calls domain->ops->free(). Could this call back free
>> sva_domain?
>
> I think so. Check intel_mm_free_notifier() as an example.

So if this is true, after calling iommu_domain_free(), the following 
check list_empty(&iommu_mm->sva_domains) could become to true because of 
domain free. If we move the check in front (before iommu_domain_free()), 
the check could be false. That seems leading incorrect iommu_sva_present

Lizhi

>
> Regards,
> Yi Liu
>
