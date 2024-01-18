Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE713ADC
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563671; cv=fail; b=PCtcgYSELumnWVGsyEyUws/4AEeoezHWdaForg4sFLmZ7CewFV9ykqS84WzBQdIiUd+3cgFYM/ZYbEPyPp06bi7mqBNsmYnamBPuckNPj1+JS2UPAy+JwRCbW6QaYGu00gAkeVR/7o2QH72zhHQ/bmeisT+Nc48+Zzfe9es75V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563671; c=relaxed/simple;
	bh=DjVIGpTG7Tc1gtlVvhvuIEYrqwe6RgKyREee6ji+cJU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=fFZV4tTY2lf9cW2N0bt1YCicXtv+KDZvnH15d0dd1hCHDjVo2xpZ05/0YkuL/akTpQdqpDPnjyUZ0R9EjWNTsx/UOuUCkW8HxXR+qAeoBZJTCIMVqi3hTRatcTn2IomwGKeMvzU5Cm5uG/PB+Q/pa6dGC2uszDxeVJpejEmI2PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSsgsU/a; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSsgsU/a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8lkEGlIthcpMWVs5mjMwb1HsuCDRMZzNTfpKy4vW/MYFHG5dLo8mkCvhxQ0R6L7TDh2EHO3hlb8Upzsc8f0wa+hsekdegoojb3IChBeMQjkOuUcD8OJKqtDUV5ekrdR44d7uhE8c+DaWskjVTiN/sFSDYDbiKSYG6e33jMH1vwb16arMOwBPWO1ITvN/4VL8AM/W7Xy2Egm2xfAd87TtpnBZXHbxVy+fTsYh6fiM2KB7iPCQ9ojh9VXh6vPtIBqTg162vl4Qzo8Qubx4yLMNEKDlR4IFZcnqTq3440cqfizr2YTfE/N24fQ9wkCwa35m3NC8Qjhgk8ReLedrfFWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG7bEzmgUvCpq71KTbegn9p3E4gFQvnEs6sysut910k=;
 b=KrHjg7cDwvU3JefeMCTLv9R/XdffijWqDTHURs0jZBCaUEGsOlc9iBv4jcPde28CCwRNMx8Mtc9X5TOZbSOWWc3GKJCJMSwylN/JKpfBbmx581KC68sva7tpQNYPNXb//nP19Z3zPYE2pohvLFZ0P/dzihCbyOtsdMn9hXkehvymcJgv+QDcAJxp/pQnw3v5/YNbr8IiXT9IUh94aVohAnxFuKO8rjBjrg4bhd03bWh2n+ZhPv2zAYpVzKp3Mx6NfYevKxBp1AuVOq5+/UBVA1TmhmvrG7RHbB4+tw8Fo9d3dmgzJeW3SDxdN/yd8eMhL2w4KQodKS9RpxTzmFjolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG7bEzmgUvCpq71KTbegn9p3E4gFQvnEs6sysut910k=;
 b=GSsgsU/aV9kSkcfhN0o//2UEZbmXR1lC6TUQLEy8hGLiimljvhOPM47noJdnifEwP0SMlDnyee9Jq8dA28oIfWHremW9YKhwgGCB7uTTDaBTHbBtSEuIHQE6MLsW3UtkxAPdgPNNKVGefcIxuhefPME9pfU4VBw6rOa/fUXR58s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 07:41:07 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7181.029; Thu, 18 Jan 2024
 07:41:07 +0000
Message-ID: <956a055c-ec8a-c425-c3f7-a3bb6c4a81c0@amd.com>
Date: Thu, 18 Jan 2024 13:10:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 00/14] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca
References: <20240118073339.6978-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ddd879-6439-45e6-ef2a-08dc17f8d4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJj8lJ5YsENylWuFP5lmRSmL8TOZ59TsMxLxNhwR+4V/1vVNT1cDSmaR6eni0ADh00dLhC2Tzdg9+CLFS+AoGjTEcjnXfGaTTlov8kyOrdmmEPIA3QLevYaQkhOTG1Yy+Pg53nOK1NkzBe8u0meSoEyyRnlFfto6ongtsQ74pKAaEVocVS/rEYwAIwhe62Dd2t1psYGqTtQcu0yZg/GkSLsHq1sw8qEDE4FN0sCsvk2k01ppJcDMJeg6L2bP588VZKtKQIm6J8fKPG9Li+bgDNscT3vf0Se4jfQXo9jvZZecc6cvPVHt37mQU0diwp0cyVmm1WqETbn/eMIIyVzyNlwc/KJPTeWAIo4Eypq02mgpi6EYZIbnL8abrBJPZLR3wvRkaZLhYvUqv0IIAudLAvIyIWfuA5JzJuSfsk/W6W8m93iVB9pb9WBDTWuSEK9DLozfOKgSwU/5y+Xrh/sLv3WPex1C/LQKuzDANveX0EkbiRKwS3S34WN5jCmvQ7A2DDLoePMoHa08FLT7t3V3B3nneZw8SXcz0b9vDcHlRxRJV9prmFKh0VXlvyrbq8AByo0xNEKkxOnDEqUvosVl+xuAjJz/g25i7vcJxdluV+QtdVnSboriTAbOFQ3eXVfBZ6t9Yilmxu224b24PTu6k+2NK58dTSPx0qH2A+tjXuBdzK8eYi20DrcjvixVGjjr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4744005)(2906002)(86362001)(31696002)(36756003)(41300700001)(83380400001)(6506007)(26005)(6666004)(53546011)(38100700002)(6512007)(2616005)(316002)(31686004)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(478600001)(6486002)(44832011)(5660300002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhqM2pLNGwzcFUwNFZwMGZCR3RwSkQ1N3UzQ3J1cU8yNHpQdEt2T3hoQTZI?=
 =?utf-8?B?ajlucmVOdlRmU2M2QzNGaWxSNFY4SERNWUNYaHhQblk4RmVhZUFBMkE5T3dh?=
 =?utf-8?B?bXp6N1BxNFZwMitmemxCeGVjcW1mWXl1OHg1VFFYemJYM05yYzdKN3JBVk9z?=
 =?utf-8?B?MVNabUdZMVRvU05wNE9wSnV0ZmlFR1JyWFNETjRkYWd5Zm5aeDBVZ1hIQU05?=
 =?utf-8?B?bTVONmJXaTNKWmhsSi94OXQ2WUpkTW52MjF5aWpzUWh1UlIrOXpFa1dVaHVp?=
 =?utf-8?B?bVZOWkcraTF3RVRzU2g0MFZkbklVQzNSN1piV2JUaElXYURnL1B2dCtucDB2?=
 =?utf-8?B?eFU1bkVSOFB0TVlKb3kyV0ZVNmdnOEtnWjZ1RXBKUmJDblZYZjRKY2k1a2Jq?=
 =?utf-8?B?SEJtcUtxV3dQRTQ4TzBBVHAxdkQ4MkpQbkhiRFUyaFdLWVBKWU00bmQ2YXVi?=
 =?utf-8?B?bG9yc3F2QlU3YW85MFJiaW9MVFlLeE5Nblg2QzhxNExuSml3WXhNOE0wTW9H?=
 =?utf-8?B?N09EeDVYR3NtcjNGbjhpeml2YlpiNlhiZWdQdjVkc0IzSjBWbWZkRXlaSkt6?=
 =?utf-8?B?eFhtWGJhQnJCT0dDT2dSWUdiNkJCZFoxY0hSWDM2VzM2LzJ4MnhrRXN6U1pR?=
 =?utf-8?B?K1E2ZWdqK0gzaFNtVlVlaHBWOGV5eWpKK000SWNXQ2RFMHZxeFhpZjVPM2Vq?=
 =?utf-8?B?VC9yRzU0amlYcys0VFZvTTArUkxaVU1FaTdvZjc3eGpSeWxDUUlaVTZReXFB?=
 =?utf-8?B?UWdnL2dUYnNzcjYraFpvQ3NFWkhtbzAyMWlUK3FSSzdNVVc3eUZxWktzQmZI?=
 =?utf-8?B?VHVFYmN2MDhnNTB4R2xRazA4a1JOcjRFb0hyT1k2VnRkWG5XNTFXUXlPOXJM?=
 =?utf-8?B?NDZ5dTJKVy8vZ0lpc1B2NDNDMkNHYWxZNDdncnpUMHpmQkx0UU5SeW96cUVy?=
 =?utf-8?B?bXJ6Q0RUbURvRGI4WFd3Tm9ReWhpdDVscWoza1BjaHNCRDQ2K3lIVzBWd3c1?=
 =?utf-8?B?eXJyOTZNcnFDdkh3M3pPenVwVmduN2gyTTA2dGd2aE5PYm1ORlJ2cktkbEUr?=
 =?utf-8?B?RElEZGNFK0JGUnVqNEJqTEp0Y29tbHRodEVGMlZkMW1yM2FNdnZUQ3NsL0dW?=
 =?utf-8?B?bHUwV3dyKzU5Y200RERzekhpMWV0b0RFWkZ5S2pJR2ZBdTQrY3poZ1g4cmcw?=
 =?utf-8?B?WTFiVFFCZ2VMY25XTmZzSzVWcTU0TzE1cktsZlg4bFcxcGMwbHBDZGM3WmM5?=
 =?utf-8?B?Zmw1S2lUR1JTQmQweUNlYWlhMGVHQ1Y2ZmxqSnlEcVBBcmo4RzhVRDYvMDZW?=
 =?utf-8?B?dkNxelpvZVpLaHZCODdEZldJTStOQmttVW9ISXpIZzIzMnpvNG9MY1YrWTIx?=
 =?utf-8?B?MDBpUUpKTHlhRXpnZUZkSzFsNU94U0dPeTlmUE1Udk5hZ3ExemJqL0Fvdi9a?=
 =?utf-8?B?MENuR09vVjJPc0dlRW92WTJpNzZSZHpXcmppd2I1UEtrR0FKUWZUMlBWekRi?=
 =?utf-8?B?TVI1dFk0Z0ppY1doMDlGYmlFcFJmdEJDazVkUkhiZ0xjSTlWMUVpOTZxeXRO?=
 =?utf-8?B?YnNmaEdnWDVheWxObWU5aXNpTEZmWlVGME4wYnNYY3gyMVpKNTVIK09RbEw1?=
 =?utf-8?B?LytKVEUybFdDdlRLK1h5cVowVi8rdmRCbGEyaE1yVUtrQzFmZ2pEcWZhVklS?=
 =?utf-8?B?Um02VU5sdFg3Nk5KWk9Bd0ptaEU4WTFUMUQ3cFBiY0R6K3pxb0NWNkFOa2tL?=
 =?utf-8?B?MmNhZk55TnJYTXM1QlU3UXRVRytmdXFxYmRSMkx4VXFaZDU2YXpWbklIYXlr?=
 =?utf-8?B?MEJPcnVWakNmZnRzOGxlTGVXaEZQMFBWM2Zzc3U0Wm0wTjRqazdYUjg5YWFj?=
 =?utf-8?B?U3k3MnJSck92Wi9VY0w2R0U3cnBQbitvU1VVdFQ4ZDZFaWJGVDlyaTh3WnRT?=
 =?utf-8?B?RGQydEdqZ2Zma1VUeW84aU5SQUMxVWpkYXZpRHZjbHgzOXR0VjNUM2EwdFJz?=
 =?utf-8?B?b25DQlZwM3BpYlNpUGV5bzhRV0FNNUNON3o3ZVBKd0hOMndEY3lYVVlYemxa?=
 =?utf-8?B?Q0NXZnV5SFNKM3RQVG96WWhJbEtEZUhnTDRvNEYxdEdTL2FFR1NoUjhRYVpI?=
 =?utf-8?Q?EdwPGPDM8XVR91Mao+WeE2V80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ddd879-6439-45e6-ef2a-08dc17f8d4ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:41:07.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbvbKOHVE0uR/LKmauOG7IMPU569gvAiwl4MFg/CxP17WDkNioK3ckj0baDLIQ++gvZxXxlEnINLO/uDevqxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227



On 1/18/2024 1:03 PM, Vasant Hegde wrote:
> This is part 4 of the 4-part series to introduce Share Virtual Address
> (SVA) support for devices, which can support PCI ATS, PASID and PRI
> capabilities. These devices are referred to as SVA-capable devices in
> this series.
> 
> It contains the following enhancements:
> 
> * Patch 1 - 3:
>   Rename, add support to enable/disable features, update DTE etc.
> 
> * Patch 4 - 10:
>   Add IOPF support
> 
> * Patch 11 - 14:
>   Introduce SVA support
> 
> 
> This patch series is based on top of SVA Part 3 v5.
>   https://lore.kernel.org/linux-iommu/20240116165335.6043-1-vasant.hegde@amd.com/T/#t
> 
> Also depends on :
>   1) Baolu's IOPF improvement
>      https://lore.kernel.org/linux-iommu/20231220012332.168188-1-baolu.lu@linux.intel.com/
> 
> This is also available at github :
>   https://github.com/AMDESE/linux/tree/iommu_sva_part4_v4_v6.7_rc8

Sorry for the typo. Correct link :
  https://github.com/AMDESE/linux/tree/iommu_sva_part4_v5_v6.7_rc8

-Vasant

