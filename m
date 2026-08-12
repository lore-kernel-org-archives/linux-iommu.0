Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DBC2D97A6
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511994; cv=fail; b=T0qKB/rmVxcLNjYt5i7iLa+corcVa2/hOaXQe4Xp2d/rVoTNVz41EzcNcNHtvsj9L94LnyZlQxHIX1Or1MnVMSmWLa9DHefdytnQudvTeGypiPXEahDWQ/VsEwM5ICwOHwQZgH3HR4lUKg4V6RtMk027Oubd574UMpCkF581amw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511994; c=relaxed/simple;
	bh=FzUolLhZCQFl4/B89Lrq+W3oK9vKhit+GbYoNZcrbno=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hrvQRaEqN8/vkAH7IdadWuFCnIaF5O2PM9N6qagxgjXE7eRSQSR8Czf9eMi4EZn8mWaRzDByMIbyriMSg3LJJkyDmZlgc1afhRaVXLWSXcZytduQVslvkS6f5Wx7hyacLgWkQmkKyKSNFtEoBzORT6qtVU3yuPuIC6eeHFL6ipQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3TiWXCMe; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3TiWXCMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq5/krenvzlzGvL0pGc/Ta1TpGxZiTDXZq7AlTmz7stBH9Vscsv86sEeVw46/MrgjC/M8TpUItEj4HYv1FIdZJfTTCgR5B0Nm4iUc1rHgry7aOnk5zx1ZHaOsbHedhXnk15jG1+yaXD5rN2vA6BlbI3iu80VCvpBy0b1xBSJkfCCxOd6jqudA3wulnInOW5ej4x2ZqqIdGmtMrwmXTl0ZMMLokc+8dz99jUGPS7ryGyJQRGDoe0vOdthQwulugZouv1NkfKL6lI+Y/hV3TGJ+DttctakFzpk8pYr0R+RBTYRpqFczC2SfEa9m3xYP6vRH9ZwSLP9TJns5xR+OXM21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaYd49m86qGZ748lTUzdE3m7ymm2Veo+T87LvZVTTgQ=;
 b=sg5YDYrKzonuoYlBqY03Pq1hwfoxfbY70IcrIwGoggpgAR8V+pLhyoCs4SzuHK/f+5w2tEsk3uNDCrMAyen3sGxcS2bG+T760N6Gvv/7uF9hmvmyy7IZnyFVShnHmgVflipjLrdyhO9nUm6ibA3q3Jh3krdccvry9+/cpGmBMUSxxpZ8mwZ6uwKWSwVDEYin8cFBoXtOavJYtgOMvXEZm0oUzPDba6iZm9Ndra4YAmbtVzl1dJwV9Q5PuzbJjh0nmyE7VVFw0AHxEGlbyC3JiAzAO2d0ERaACc+O2BnYdPh/IXKs6ybNLimjAUOMJguSLycILpCYl7zr/MRSJ3LfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaYd49m86qGZ748lTUzdE3m7ymm2Veo+T87LvZVTTgQ=;
 b=3TiWXCMeb5z1U2JDann5iW5VfRAHHZaBvJb+NlCHvDcyyeGsMAe7sDMdekc5ecc/c1CLu0Eyht4YCFnEmGkmYN0SubC2wwUE2vyzpXscK9FxFXgvPAuVQGPkU8gDjJZ7i1BrcstKSJYfHog2huDd9+Y0RuBGKuMhSbM/wKTzT5w=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 05:19:47 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:36e:cafe::56) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 05:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Wed, 12 Aug 2026 05:19:46 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 00:19:37 -0500
Message-ID: <0450690e-1c66-4c6a-a49c-c902935a0efc@amd.com>
Date: Wed, 12 Aug 2026 10:49:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Biggers <ebiggers@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU running
 state to IOMMU interface
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-4-sarunkod@amd.com> <anpt_cMpS1-ua-jX@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <anpt_cMpS1-ua-jX@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: d0072f8f-2c69-4140-29f4-08def831534e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qYO9eEsJXOtMCExQqeg1RPfVTqLV2w3JsYVtSRLSxbhaLj1lGdlBD7MyAHuPt1ulxNv6VQYiHAafZxoJM/jNSaQd/zoyHXQLw2IF7fMekK0BuNFkt0g6uuZsi8uuqGH05rYcBg9EC/kbd+qv4MARokpkqQ/JM7faNG1BiXhUpU4My8iQT/VegyZOb070yIuCsXepqqL7knGv+lp5tJRXcSdQ6Q4nJDG6qTOXyCFoBWC2xiySdKMP3Q3HfCeh/xDfeK70vfFNioscUSlPvy4XSaLw82x4RAo87iZreR9htA5qHBSLKB48DFgZ3d+BoAP0LAm7a8pST//KHVP4ojvdYlaZ45rdsVT6U0a8blzEAucjXDRv1jpgo9Xjq/MK482i+xHk8P8qAF5mYWeK/DFKPxHbAfMI6PrNnM7tB9nItqk7E/jwB5s/munSOeclU99TF+jU2ncInNRCJ0NzNk86+lrBk9RhU/SFEz7w9HAfI1dOdDfOkW5eDthIRo/eswWIFDgr5H3bOSyy9XCJYCsgpLmsl5C2vGp+LOzAgFCVnf3x0J66/R5O2tnsI8JvvHLD5p4QB+UOXpbpa9pgQiSfjC7ua6Y+bggHV9WfkHRI8QS6z/Vy2b2nfJHu6ubONd2jkMagWcqUGf89US0pAd2dKFx8Ovclcl8uIGTtPhQzuf010Q7vjmkMUWT2sgH0q05qofgZL4asqyZ5zxLOEpJZUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rsCKgzJ9F3uFVHrpNrVo33RQlhsyhFZbYDxY/jbQU3euHpc16KYJG/vqG9kIqMaftQQcgWQjIPN4KRMH8Yy4yV9eYRXiBzdqIJo4T/RdWVFfMyIbCqfB6Nns9eonUne3yIGiCAyDgLf/M5aZnPEiu6QwWe7P8BaIZQUA5Xo5NjHdnRVzUGsbx5QY+k986WjBrZQKPX0X84zXEcBPEywYS57rbsDMZviGpYisBYbr1VKPTFkXo9vMOZFYbW0Znz7AlVfyKqTZT7t7I8kghrNIHD6D+Anb1tCwG3R7Vp4WLt6fOEp3jSOzRhlB48WUwZRhp4dfealw3pm9ceSnmnVKlve3XivmB6ZLHqtBVdfllbVT+UwBleTYqEX8zNT9833voKproepF7twUXMy6uCeDHxdz6WOksPa2IGQEtfgGDy0/ikVtmKs2OXkioJsGONlD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:19:46.7648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0072f8f-2c69-4140-29f4-08def831534e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948



On 8/11/2026 6:04 AM, Sean Christopherson wrote:
> On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
>> @@ -1008,6 +1010,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  					    enum avic_vcpu_action action)
>>  {
>>  	bool wakeup_intr = (action & AVIC_START_BLOCKING);
>> +	bool is_running = apicid >= 0;
>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>  	struct kvm_kernel_irqfd *irqfd;
>>  
>> @@ -1024,9 +1027,10 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  		void *data = irqfd->irq_bypass_data;
>>  
>>  		if (!(action & AVIC_TOGGLE_ON_OFF))
>> -			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
>> -		else if (apicid >= 0)
>> -			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
>> +			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
>> +		else if (is_running)
>> +			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr,
>> +								   is_running));
> 
> Pass is_running here is rather weird.  Given that this is the only call site
> that originates outside of the IOMMU driver, what if the exported
> amd_iommu_activate_guest_mode() is a wrapper to an internal API and hardcodes
> is_running=true?  Then the internal path via irq_set_vcpu_affinity() can pass
> an actual variable.

Yep, this makes sense, I'll create an internal function
__amd_iommu_activate_guest_mode() and keep exported
amd_iommu_activate_guest_mode() as a wrapper around it.

Thanks
Sairaj
