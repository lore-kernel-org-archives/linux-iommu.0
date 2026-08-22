Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B22C3251;
	Sat, 22 Aug 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787393884; cv=fail; b=G09HhPfoRAScIOT0kwG6Q8DKuXw9ySL8G3MrYJRUOETh6fb3brZZ6u6oBUtz5r5SrW3M+GBtkLbbwXGeyuKeqGpoC6o/QATYjljSocJUsSp4FU1w8bKo2dqjSAfNhUtowGXdO+hZ5+F5Cd7p6uwvt+Efz6b4JdCbo7GTRjcpFHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787393884; c=relaxed/simple;
	bh=g4ihib3TbbDxSndR8VQY9J34rNhOw6og/HVAqgrezTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifcdTa04hzqbQA6uIRN16NueI5RmimnntCHAOUuP2RHmmKJo8vkFkbRYMZXDj1QYZm4Y2OjAPc0+Qda5eTEJGgVeLW8rPp3nMPw2SHvirmQvtX43KPQahX8PLdJfPzCEYJIWSE2DR0QgMO05JTR0JDoW/pl1s5DtzWrzUgNVXEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5OPBjD0q; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5OPBjD0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfSYJ9L5oMWjQUcxgRenPE4rkAGSBUFqFqsQ2BC29/63JJ/7mZNkyOqXr1WkJHjNtUbkGFrFeLPqJVgHoqiPHh0FXe2t/OfpPLhsA6LMjTA70mZUHdNOQ40Qr0SDgDBYqGyX1TqPf9a4Yl+iFMksQFRW09aEmg8ItF3NBBiW7DeqxRuDymeBsc9IQjLGVeYpXxBgN7DJ3rmOzaTZG7tlQN6sGLr10o86aYbuvEl4OFyNXRm7k8e53kFFR+ujPUEsvXYV9udsHJneM6AHH4MlQfxrw4x48i6mbOkDHxxY19ZhNI+9aEp09viY/zZ0iVSr6Q+M9MXErPsdYxerK3un6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzaDa6rkKl2SUI7Pm4UptmQRI+ggm2oj5hIq2f0ajC0=;
 b=Jbcg8gFJMOoa00oXNlehlUcAwGb5g+GTHQGadrts308fmOgIRX68nXykWGRLpLx+kCcmdodBZSHpRM3UtSr+wq8Fswtx2BSBPgOU26xL+5aNKpT/OyMi1nrJ9/HgKUrr0r5yvWZOPlk3OGcWNB+xItAAGj+8ezdq7AmQi6PTmZ3n+LsxbFaAN/aBusT/vssD4sgHmryIyB+lJYfqpXxnUvmDN4r8MIq6RJVoM5Ybxb3wRNAhe44hh20nFfEbK1cyOR4j7Sae3oFf0hYNXT4gPRUu6Fs4gDEbqGMSCRMORrCG0+zqoIItsuMeB/oGuYGa4Zye5KzlljO2kDhiA/jLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzaDa6rkKl2SUI7Pm4UptmQRI+ggm2oj5hIq2f0ajC0=;
 b=5OPBjD0qywk+VpVaf4qM3tkZk/bQ1Z081u0C5JB4yVHy8pk/fMH7pxYavkgjHK5n0HkXrTTgW/pect4OFHur9wUsWhwPh7f4vtHqIq3sFJvdQWZpsmy6yMmUnVEbzOc3Caf6NDy/D9rE9pG69NRulpIxJJT6gQoi+8Ikg9GLw/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 10:17:55 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 10:17:54 +0000
Message-ID: <6a61edf7-157c-4069-a1c3-78d1138b061c@amd.com>
Date: Sat, 22 Aug 2026 15:47:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] iommu/amd: "Fix premature break in init_iommu_one()"
 causes early boot hang
To: Joerg Roedel <joro@8bytes.org>, Andreas Juch <andreas@juch.cc>
Cc: iommu@lists.linux.dev,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>
 <aok4Ko0mpC4fdGPg@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aok4Ko0mpC4fdGPg@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0245.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: bce249e6-d69c-4bfa-4e62-08df0036a14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0NQE7J8rPFdKLJBMrkrSkejRUCLtCydbUHNuAu0Ucpz0pMDEaH20dEe5AHRauytvSLwSF75woOSkBkLaOcETzh7O1tFIsZMnX3Dmy3AGTPjaaZ8JHBRX9P7DVbLIUT6uqLHDko/Eg3lYCvW3Va4XVh//R45X6t86tJ+rDuwCJhn/zsSsyyn8rqLCA0643G5lVgxMrokngkrdAQDHhskbgBXWq994Pz/4VXC00k5t7ZGH3hMEL4oRmKQbbg1GUwyTz2eCaIpl8hWLiV0YQa/2FgXVVzNbWXWjkOWwCfvKUgO2lpBnL/9P6jOyrw+dyeZKdNrH24soGEYzBq70pO0X2teWhHnMQNkmEy4v2AadKzJnpvLQGVc5qy9hdHlBJ87g1lLjBwn6oRJbJXhZEYckQY+jYrrZ71knSb9yihOJBojDvTA1UvKMBRQt1TAK+PxmnaN/IRlZFhtlTrF51sxtnPX6BCydU9sPq1hfTkoDIU5zG2wr4jEU1yCrNKm5/ARt20iod6Z4Y0dQh1MVdF1SelGZ6ZBG2+D611TqSh+SIT/Ytar9bnvW8cWcAnauh6vGj9Xkqb7tWo1/Sbg3EJRJ/sTArFyTjzXKWjBB9NnwYJ2KuPAYQBRHuqXfkoEhk6Vy7Gew9B+Q/svuhngr1lFzHNGd1cKXThHTVq579NCWKDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjhlRUVrVmY3dFNSOWtIT3plNUNqdHZMZ0MrRXQwckhDd0JnYlcyTm5uU3Vn?=
 =?utf-8?B?VnNITy9Cb3M5L00raUdpVEI4RVpUSXpJR2hvQUJnT3RHcm4xZk1iZzJGZG93?=
 =?utf-8?B?bFZESkNyM1ZBUjFZVDczZXdYOXZMeDJZQUpCT3F2b3ZFUERqVGhtUHRaWFp4?=
 =?utf-8?B?bDduK1piOXpVcktia2JiQUJzdmM5Z1Nkbk5yd0lRK0NlcFNmRnZkakF1U0lE?=
 =?utf-8?B?UGhCVndzWDVtaXRINWpRM2xWZ05LVVRvcUtXaUhBcDkrVkZWNnNhY3RnYW0y?=
 =?utf-8?B?bEF0MW4vU1orSnZMY1RhNUppdEJid1o1R1NaQ0dlaU5sNm9RTk5yMWlhOFJW?=
 =?utf-8?B?emVXTVNtVEwwd1RmVlhiTmE3ZmhRVkxsMURvS2M3Rmp3bGhHVzMyZFF3NUlo?=
 =?utf-8?B?eWxMQ2ExWWRTR2NzdnVMd2V6NUdLRUczOE4rSDFyWGZ6L1I1STI1a0lybVRk?=
 =?utf-8?B?NlBWS2N6Y0tXaENaSXRhUFJ4MmFLRXpQNi9aL2VQVUVETUsrK256TURxZis0?=
 =?utf-8?B?ZHV3ZzNvY0xLd0VDWit0VWpZRmZMdlpUaU0wQ04wNGJSZkY0MUs1VEtEaFdM?=
 =?utf-8?B?SCtzVUdRb1hPQUx6SUpoWjlZRWV3ZXZwdFc3aXZuYTlQc1RQTGpPbDhlNTN2?=
 =?utf-8?B?dHBabm8yUlhScENUS01UWlViRlNjUHBTUXZzOUFYU0laRXNNZjlPbzhyWnRu?=
 =?utf-8?B?cDNPTVQzZ3N6NGVieFlkTCt5RkE4aVJhTThvYXB1aHpDNkEyVWxCSnYwaTFr?=
 =?utf-8?B?RzhOSUl1Vm9JUmFLN0Fld2FHelhoOFlpaXNmdGN1NncyOGs2RlhrKzNueW1Y?=
 =?utf-8?B?TGp5WVVrN3c3MWlOUXJpR3VXaFVBc3RjMWJRQktHYloyazAzdGJQUUJsWWlr?=
 =?utf-8?B?d2hiWFNRZVo1YTl1NDJWZnNKVkl6SngxdVpnSFZiMmg0cWhyeXN3ZkVLMUp6?=
 =?utf-8?B?N3J6Wm9WYlFCUmZJSFd4Q0srRm5iVjBCSXVuZUVWM3dWY0ZyZHhsbktVNnRH?=
 =?utf-8?B?akZRMWxsQ3ZyOHB0dEFOSnNvVkhYR1czZHJLL3VHOERYU2RFN1BYbmt5Y2dE?=
 =?utf-8?B?SGMxbUptenNVZ2xjTmJkbndrQWN5L0RSd2FBOE1rQnlmQ2dVNElDNE5VamFD?=
 =?utf-8?B?djc5UitRUlBpV0REMTk5akgrNjRmUGgwZWdkcitBRHAwMW16aWl0VVR3OWxq?=
 =?utf-8?B?NStVYTNpam44eDY2TStDQTFCWUxXSUtydlpnT01rU3FieTF4eDArWTk1TThN?=
 =?utf-8?B?ZlFVNnRScVhjTWZobmNLTVp5TVJ3by9tSXF0ZmJyZ1Bxd05PbTBwTTZ5VDJy?=
 =?utf-8?B?YXJ4cWJZVlQ4SGx3RFcwcm1QR1dBY2RXZXZJaCtrTDA4Q0JOaTRUVXFlYU9s?=
 =?utf-8?B?YWw1eVlPcFM2UHFmR0RyOFZGaDJFTjUrdjhpWE8yVzFIV3BkYmxjNi9wR1pW?=
 =?utf-8?B?Z2lrb09FOGwwczlFRFJWL2dYUjFEZUdrZFV6bjJHdFR0VUNINko4NXhiZ3V2?=
 =?utf-8?B?NVp1SXN6VUF1dVdTUWRIQm0zbWR4Z0V6MTkvSldNZHF2SlFRQzVKZkZHZ1Rj?=
 =?utf-8?B?V0JydEJzOElxaUl6bHpJZkpkeS84cFhucUlLTlZOOGNVUEpLaVg2SEhsWld6?=
 =?utf-8?B?ZDh3R2pKbWJ2cDFUYmNCVlp2RFpUZS93TkxCOUwwOXhZdDlzcUJJRmxKSGJq?=
 =?utf-8?B?cVV4MEdJdnNFTldPYTBMdXpJQXpJNmo3L1c2eVpvZjJHTXBPOHZhTk03ajFT?=
 =?utf-8?B?UUMyOEpERW85Zm5UNHdkV0JubitaWjFLSlVCTkFXVGZlZlhOU0FFUXdNWUtv?=
 =?utf-8?B?UDRuNllmdElFQVNmOUdjUDFKeSswMVM1b2lPZkdRWXRia1FjMS80czNhWTMy?=
 =?utf-8?B?Mks3YkFBTDAxNUhmWmoxYTFxbDRUSExZYnJQSzhORWYvZ0FJMVBQMi8xM1hW?=
 =?utf-8?B?eU1Nc3dvdjlaMDQ4RWxGWEQ5ZkN1R2tiTXdxYmh4VGhkcWVTYlJwUFh2bDVK?=
 =?utf-8?B?QkIySlViOWY2T21CMy9GYUZxZitheDNKcFJWYllPSTVtZkhUYjlNVHFSc2RL?=
 =?utf-8?B?YzQwVCtaRFZpalV2L3hkQkF4NlpXTTk5YW81Uzk1OUpsaVRld0pyVEhXeHA2?=
 =?utf-8?B?cXRmTVF2dWpiRmZxR3lpNStyWHlQTFBrNmxIMldneEdiUTVlY0RDU2hlVVQx?=
 =?utf-8?B?SGJmTWVHelI4dDRibnJTRG9zK2pYZmd0VGppR3pnQm1JbEgwS3Q2M3Y2YW5w?=
 =?utf-8?B?RUZMc2tYRUtHQ1A5dXl4SXBXbkJuSXg2ZUcwbWl4THJwdGdVTUJZUFA5aGt2?=
 =?utf-8?B?T1NlbTR2b2pmcnN0Mk5IcVhncEczb2lnazUxRTBGTzgwNHVPOTZMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce249e6-d69c-4bfa-4e62-08df0036a14f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 10:17:54.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QADfc4mjvT+r/THkUcdjvMxhpoaKrBLQ+tQSqC30LvIQSytfkXxqN1Ta+bbnsURTEUnFHjUl4hWnE1YKn0Q7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516

Andreas,

On 8/22/2026 11:19 AM, Joerg Roedel wrote:
> Adding Vasant.
> 
> On Fri, Aug 21, 2026 at 11:11:07PM +0200, Andreas Juch wrote:
>> Hello,
>>
>> I noticed that one of my NixOS sytems failed to boot with kernel 6.18.40.
>> The
>> older 6.18.39 booted fine. A full git bisect of v6.18.39..v6.18.40
>> identified
>> the following commit as the first bad commit:
>>
>>   dc266f6c4e2628576ab33042b6b2a12480220026
>>   iommu/amd: Fix premature break in init_iommu_one()
>>
>> The visible symptom is a black screen immediately after systemd-boot. The
>> machine also remains unreachable over SSH and leaves no persistent journal
>> entry
>> for the failed boot. A reset or power cycle is required.

Interesting. I never imagined above fix will break some system!

I assumed below dmesg is from good boot (without above patch) and did the
analysis (code walk with below IVRS data):
  - EFR advertised by IVRS is different from actual EFR (read by IOMMU MMIO
register). Its worse because IVRS advertised few features like GT/PPR which is
not supported by IOMMU.
  - Without this patch we would have skipped early_iommu_features_init() so
global EFR is zero and then init_iommu_one_late() set the EFR properly based on
actual IOMMU capability.

Only with this log, its hard to tell where exactly system failed. My guess is
driver enabled features which are not supported (like GT/PPR) or we setup 32bit
interrupt remapping table.

I believe above patch exposed an existing bug with some other commit.


Ideally we should properly fix late_iommu_features_init() and use actual EFRs.
But for now lets fix the regression. Can you please try below fix?

-Vasant


---<---

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 69170146d442..7a5b78beb352 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1930,19 +1930,20 @@ static int __init init_iommu_one(struct amd_iommu
*iommu, struct ivhd_header *h,
 		else
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;

+		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
+			pr_warn_once("Host Address Translation is not supported.\n");
+			amd_iommu_hatdis = true;
+		}
+
 		/* XT and GAM require GA mode. */
 		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+			break;
 		} else {
 			if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 				amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		}

-		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
-			pr_warn_once("Host Address Translation is not supported.\n");
-			amd_iommu_hatdis = true;
-		}
-
 		early_iommu_features_init(iommu, h);

 		break;



>>
>> I reverted that single commit, built the kernel again and the machine
>> booted, so
>> I'm quite sure that I found the right commit.
>>
>> System information:
>>
>> ASRockRack B550D4-4L
>> BIOS P1.10 (06/28/2021)
>>
>> I'm no expert at all, but my research found that the following information
>> might
>> be relevant:
>>
>>   journalctl -W -b -k --no-pager | rg -i 'AMD-Vi|AMD IOMMU|IOMMU|IVRS|IVHD'
>>   Aug 21 22:24:17 kernel: ACPI: IVRS 0x00000000BB062000 0000D0 (v02 AMD   
>> AmdTable 00000001 AMD  00000001)
>>   Aug 21 22:24:17 kernel: ACPI: Reserving IVRS table memory at [mem
>> 0xbb062000-0xbb0620cf]
>>   Aug 21 22:24:17 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
>>   Aug 21 22:24:17 kernel: iommu: Default domain type: Translated
>>   Aug 21 22:24:17 kernel: iommu: DMA domain TLB invalidation policy: lazy
>> mode
>>   Aug 21 22:24:17 kernel: pci 0000:00:01.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:00:01.2: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:00:02.0: Adding to iommu group 1
>>   Aug 21 22:24:17 kernel: pci 0000:00:03.0: Adding to iommu group 2
>>   Aug 21 22:24:17 kernel: pci 0000:00:04.0: Adding to iommu group 3
>>   Aug 21 22:24:17 kernel: pci 0000:00:05.0: Adding to iommu group 4
>>   Aug 21 22:24:17 kernel: pci 0000:00:07.0: Adding to iommu group 5
>>   Aug 21 22:24:17 kernel: pci 0000:00:07.1: Adding to iommu group 6
>>   Aug 21 22:24:17 kernel: pci 0000:00:08.0: Adding to iommu group 7
>>   Aug 21 22:24:17 kernel: pci 0000:00:08.1: Adding to iommu group 8
>>   Aug 21 22:24:17 kernel: pci 0000:00:14.0: Adding to iommu group 9
>>   Aug 21 22:24:17 kernel: pci 0000:00:14.3: Adding to iommu group 9
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.0: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.1: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.2: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.3: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.4: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.5: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.6: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:00:18.7: Adding to iommu group 10
>>   Aug 21 22:24:17 kernel: pci 0000:02:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:02:00.1: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:02:00.2: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:01.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:02.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:03.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:04.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:08.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:20:09.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:21:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:22:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:23:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:24:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:25:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:29:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:2a:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:2b:00.0: Adding to iommu group 0
>>   Aug 21 22:24:17 kernel: pci 0000:2c:00.0: Adding to iommu group 11
>>   Aug 21 22:24:17 kernel: pci 0000:2d:00.0: Adding to iommu group 12
>>   Aug 21 22:24:17 kernel: pci 0000:2d:00.1: Adding to iommu group 13
>>   Aug 21 22:24:17 kernel: pci 0000:2d:00.3: Adding to iommu group 14
>>   Aug 21 22:24:17 kernel: pci 0000:2d:00.4: Adding to iommu group 15
>>   Aug 21 22:24:17 kernel: AMD-Vi: Extended features (0x58f77e022294881,
>> 0x0): PreF GA GA_vAPIC
>>   Aug 21 22:24:17 kernel: AMD-Vi: Interrupt remapping enabled
>>
>> And the output of the decoded IVRS table, captured by `acpidump -n IVRS -b`:
>>
>>   00000000  49 56 52 53 d0 00 00 00  02 e2 41 4d 44 20 20 00 |IVRS......AMD 
>> .|
>>   00000010  41 6d 64 54 61 62 6c 65  01 00 00 00 41 4d 44 20
>> |AmdTable....AMD |
>>   00000020  01 00 00 00 41 30 20 00  00 00 00 00 00 00 00 00 |....A0
>> .........|
>>   00000030  10 b0 48 00 02 00 40 00  00 00 50 fd 00 00 00 00
>> |..H...@...P.....|
>>   00000040  00 00 00 00 2e 8f 04 80  03 08 00 00 04 fe ff 00
>> |................|
>>   00000050  43 00 ff 00 00 a5 00 00  04 ff ff 00 00 00 00 00
>> |C...............|
>>   00000060  48 00 00 00 00 a0 00 02  48 00 00 d7 0d a0 00 01
>> |H.......H.......|
>>   00000070  48 00 00 00 0e 01 00 01  11 b0 58 00 02 00 40 00
>> |H.........X...@.|
>>   00000080  00 00 50 fd 00 00 00 00  00 00 00 00 00 02 04 00
>> |..P.............|
>>   00000090  5a 4a 29 22 ef 77 8f 05  00 00 00 00 00 00 00 00
>> |ZJ)".w..........|
>>   000000a0  03 08 00 00 04 fe ff 00  43 00 ff 00 00 a5 00 00
>> |........C.......|
>>   000000b0  04 ff ff 00 00 00 00 00  48 00 00 00 00 a0 00 02
>> |........H.......|
>>   000000c0  48 00 00 d7 0d a0 00 01  48 00 00 00 0e 01 00 01
>> |H.......H.......|
>>   000000d0
>>
>> The relevant part (after decoding with `iasl -d ivrs.dat`):
>>
>>   [090h 0144 008h]                   EFR Image : 058F77EF22294A5A
>>
>> I'll provide any required details and test patches!
>>
>> Thanks for your work, it's very appreciated!
>>
>> Andreas
>>

