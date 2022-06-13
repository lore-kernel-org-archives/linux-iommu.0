Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C73C433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 14:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 952EC40120;
	Mon, 13 Jun 2022 14:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lI2g-4G33SXJ; Mon, 13 Jun 2022 14:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D65C400E9;
	Mon, 13 Jun 2022 14:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48EC6C0039;
	Mon, 13 Jun 2022 14:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97E1FC002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78A82415CB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6h3Ejvco3pAt for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:40:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::616])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72B87410A8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 14:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwyxSbwg04U6oxxFz2t8LUfIXwLDyOndQAgPKTdE716uaJFJvL2tjMJMPjrR1X7RWtqz7lUwf4FceqJdaJjDaTrnLTmbDuBgLdLBh2xf0OebbqnS1zljXiTeFI0BQ03WstLE13Cg7WzGkOoSk6KDKNEbIumm7WAW7ouAlYenodSQmdL77K2gB2w3wL/JSsjfMFSoOCw4cyzY4aKDLJT8tGlL0Gsszmx49ILYy7KxiuoqmZLkxTbmEg/fbxy+E7Xd12Owj7lQEc9fG3BuCB7jGFp2567wEvJcMW4euMHigLFLv0t1yyrAjfzMoyGJWy7j7IrW2OpzbhhlZ7fSvMQOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc73QDlTuXxkcROGXBlGqhYELUPoibn+KHBzOWDiJ9g=;
 b=eGOMYBqMuhojpeJj3DaKmrDIZlo3b1Q8Qs59KmRiu6vGcdCEv2OCVxfNyIKH5XDP9D3kXhru3WjWNbqoVCGsNkGfm7Lnjepkp+4NTK90seqaIZnQVusKRtClq1W4pbVXbvyfm8if/kBXSxL26T0pOoJXWiREIHLhbiNF5x7Ed9ErmrxxYRtfEArQ5wBLKfKLGkCD75TulGlqAG1FySw4IjPRC4E+5xvEobjNplVCeVovo7WpY0lq6CS/SfAoBlFnRMKFyOHl8cZsnCbe6z0oUP5EQzpo4T5ywPD6Jh+5Qi5Eu4PnepnQmWMZ4ceFss7hVplIckcQ5PoJ3NuDKkCNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc73QDlTuXxkcROGXBlGqhYELUPoibn+KHBzOWDiJ9g=;
 b=Y0SNn7SuhFnzMTmdhpKbHzMs8UX8AWVxgEm3r6rsWMtl2/PhXuPZMWPOyoQdT/mYf8ZMKCR+fC3H9YS+VuTtkN3Nf7lOs/TXtqFB8AWX0Z87z81H/Dj1X7VVlf4OVGwz9jbcTTlcSIYpKqwX/+kmTEWhvxQf/6NofqQJVNYlBLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.17; Mon, 13 Jun 2022 14:40:34 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::14b:372d:338c:a594%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 14:40:34 +0000
Message-ID: <1729802c-5e00-0117-6086-f3987223bf85@amd.com>
Date: Mon, 13 Jun 2022 21:40:25 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] iommu/amd: Introduce function to check SEV-SNP support
Content-Language: en-US
To: iommu@lists.linux-foundation.org
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
 <20220613012502.109918-4-suravee.suthikulpanit@amd.com>
In-Reply-To: <20220613012502.109918-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b6ce3d6-5623-4529-cc3e-08da4d4aac36
X-MS-TrafficTypeDiagnostic: DM6PR12MB3371:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3371D920D387E051C0B86A5DF3AB9@DM6PR12MB3371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLmAS+2tpFdEjbF9bAnckGUbjs0ROL9DWESYQpuXxxcPmiV4/X7yefwtFhhK8wbZ9+Dg9IC35nDMkvHktXwy1bkjlAPsm3qeI4LzQeK+B20FJhBgcqfu2C0mw48xty5Wh9O9roNNaqNLZDUiK00bV0RvlSC69HQd+FDUvdCS/N1jBldnkamR2oJFCugOyJ/i89tQ9r5z0FbzKifO+KRcUiLRgnpZJJBF4B0b3Bm7MN/2Mf9yzcVf6AwAMml9AB73GnAHgapQKmv8JjYemEl1KsjoNw28AKPBc3xqeeyEhklr9yahR2yAkQXb3B1Czy3uFIIcN98Avt5hgdaYGBlqZUPAzFOWBBHYSeVvxkNZjOQz3TJX+2AQkyI06YHXLoetWRHDtKEdTozdFV5ZUQ6Mb8K67jcV6CmBzBUloG3rm0HVNvVjam5jNH7Y8c2P4kE4fR4YzmItRmMbKh+5rf0XxZQpigidJQIeMk2TZTdIwseCZDxnb1BsjoZX+P6pVnDHgaU2j89YekRJTzbNtvwbemUdGHZ1pBRkTybMt+2heHA2bbTvM48eAtjZX0gNXBrtuTDwgsNBnDhV7LyV/QS6zeczos6915JIKhiEMDOPaFx7JDLPwqMDWaMCn4AHd/WgvsT17MW4dSxl+/xOKmMuaG7U3wr43aYcPiD4bjOfhr6dTH1Wx4VCg9Aiwml7pggrjmhthdUXnrgzuafZVqapBAOrN/G6lu2EAF+SFeriGHXvi5YlXRM15jGtiP9WWcxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(8936002)(5660300002)(6486002)(6512007)(26005)(86362001)(53546011)(186003)(31696002)(2616005)(2906002)(83380400001)(6666004)(6506007)(54906003)(38100700002)(6916009)(36756003)(4326008)(8676002)(316002)(31686004)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVhWMkN4a3ZNQkxXZTlEblVLczJzNWxwbjN3L2NjcHdLcWREUU9uNWZxRGE0?=
 =?utf-8?B?bkJpVGtWdDdETXBxdWU5M1locVJrWTR6dWRKZnY3Sk9DK3ZKNjQxVnNEL2ZT?=
 =?utf-8?B?ekluV1l4czBJUXc2TjBrTHZuTUJBeXg4ZWg2cEtjazlEb3FTMWFIdG1WQUdV?=
 =?utf-8?B?Z1l3anc4VWVGL3NrVkRvTHIrSkxKOFVZTUtCdFNUS05Mb1BRdjBUcVR5M0lv?=
 =?utf-8?B?azFMZXFvaWdzQVIwSmVCWXFQYkRFZU1xK2tsQVZnWnd1cDQyRDBDSVN5M1dj?=
 =?utf-8?B?MHgyenVIaUJGM2c1alUzeGpDbFJUUDVlTjhzMUphVzdaamFEZFE4U1d6OTl6?=
 =?utf-8?B?bzhBMG9valFwWVRseVo3UnFFTWM4dnFraEZmZmppYU4rTnFDdldvdk02NjBs?=
 =?utf-8?B?bDMxZUhzM08vU3hrNW5rSXdlTThGeEM4MzBRaUZMY01SQ21xMU14YmgvcHRB?=
 =?utf-8?B?Z2RReXBSYnFVKzhneGlqN3ZNVHQwNmhYRTlCMzdaeURleTRXVEltNldyU2Fv?=
 =?utf-8?B?UWlQSnVhUzR2Z0V0ckcvYlNheHBsdS9JS0h3RTM3M1ZLZ29POThuN1M4S25m?=
 =?utf-8?B?U1hCc1V3THBLaUl3MlVucWw3Y2gzTzRNOFlNWUdPa290TW1hdk1nTHR4VnY1?=
 =?utf-8?B?MFh4SlpReEtlM3hpWTlHVVlTMktlaXUvTmRJOENFZmtHa1lJVFU3dm5VMWs2?=
 =?utf-8?B?a2cveC90UVFJMVFPaFVpWW41K1k2bndnSnpWaW4yOTU4a0NZWW0zVitzRTZM?=
 =?utf-8?B?QTVldkVlbVJza3UzNytpRXg3YzMwNWJGVUVBampNM0hvOTR5K3c3djFPVDdo?=
 =?utf-8?B?YjMzOWVNeCs1eUhqWFk0R0NBczZWWnRDMTA4a0YyMVJHNGJEZ1FnejJvd2t1?=
 =?utf-8?B?Z2dGQnJHd3NQdDA0WU5WOXlSTUJwalo5clFzOXlWZHBYMDhQK295aXdSMjJk?=
 =?utf-8?B?eG1lZzF6UFBya3doMHFwNzlJeGNxb0o5Uk5Kd2NySWRVV3UvU0JFUlFYSkJN?=
 =?utf-8?B?QVhrYUNNVzE3cjlpQnlDQjlYU1VKalZyZmpVVklMeTdGRjFvYktuVFNiNkQy?=
 =?utf-8?B?VzVPZWdEWGVtZ2hQbm80NFV0OHhOREgraDFVc3BCaTRXUHJYcmRyMDJpVXMz?=
 =?utf-8?B?bWJURWxITXJ6NmE3amI3NURON1BiOWZQSzVQRnFsQmRkTTlQaHRlTTVoamJp?=
 =?utf-8?B?TU9JZHp5VXJJcmhJczJWZkk2NFZrR053aWE2QlZzUkxQZnFEQktaN1ZBUWh1?=
 =?utf-8?B?Q0VrRE1nWFFJVWJNUmRtU3NPTXRoNklEazNUbDFyRU8rSFpJRHNsaWFrb2Ew?=
 =?utf-8?B?R2hwY01IZHlUbmpTQkFleWY2U1hTZHZ3dXNTVDYvbnI2czUrZk5OY3MvYTVN?=
 =?utf-8?B?Q0lWM1I1UnYwalBHMUhvTWNjRjVIR0FMaFJtdjRkM2xJL0ZjV3hubXJWa1pP?=
 =?utf-8?B?K0RESlZwR2tnMWc1OGU4T3dYUng0ejU4aWV2TWlxa1FiMWg2ckFQR3AySzdP?=
 =?utf-8?B?amhqdDFWK1U0VTFkcDZDamRNRjY1bFQ1YTJRc0tHUGJpNGovdVZZRzMrWWhh?=
 =?utf-8?B?MUxhWUIvdFhFQTJRWG5BVGh4QUVmUEYrUjl4Ukd5WnkwWmtrR0pJVExrMUt6?=
 =?utf-8?B?aC9nY3k4Vk45TDRKbW5iQzZwRHAwd0RleVFRUythMCtIZkRDSXUrOGpWVklF?=
 =?utf-8?B?VWlZdGlkOHlFR2JTQllVQ1BtdlhqcGJyMytxVjVtWjBGcGtGemUyWklXTGFL?=
 =?utf-8?B?THNncExqTnloejczZHM0MHNFTlFjK2tjOTV1WSs5cWZna2pEb0wvNkFsSVBM?=
 =?utf-8?B?SXhTdXhXYW1DdVllWWQ3RERsZXFHdzhBMzdvK2c2Q2FzeEJkMjd0QmkvUlJw?=
 =?utf-8?B?L1lEMGsrRXpCNm5ZdWhxVnc5dFZVRGJoakJsdzZOUTUxeS91K0tPUHdQcDlz?=
 =?utf-8?B?ZVovNFREN3ZuQkViQVlaM2VnSzZOMUEvenZnVHIrL1ZVQ21NUEtsR0JtZk9y?=
 =?utf-8?B?NXFFRU9LRXlST1FwRHEyQVE0QXpKSUxVRXorTHpaQnY4bVpOSFNLR2hUTXMr?=
 =?utf-8?B?L3JhYkNneG12dE9uRmU2SFFxVVp0bkdUOXg3NksySUNlME1oQ2xDRmxENXNC?=
 =?utf-8?B?Yk44TnFCNUEyTXpETFpjOGl6U1JsRlBUaXkyK0FxYW1lYm8yQzJBWWJwU3dG?=
 =?utf-8?B?OG9lZG8vd3FRQ1FCOVVqWlNlV21yTGtRM284RVo3K2dMNStkSHhwZHgyMkYx?=
 =?utf-8?B?MG82c3BNYkUwWkg0WWNkZ3hHUEd3SWpDUGh2ZVA1V2kzOEo0ZThIOTZwRjZz?=
 =?utf-8?B?NmdmeVp1V2dpVkVyOE9kSmtWdDNzTkJlL2RPY3U1N2l6WUJWWnB5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6ce3d6-5623-4529-cc3e-08da4d4aac36
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:40:34.1682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwIEVgmImskxEjiDzLYQB1xvc8wKUsKGrQzLImgGd6sFMgKNb3K3OSlWjo+qnDgLSYdY/yR6/v2sg0Z/4k+oCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
Cc: ashish.kalra@amd.com, Brijesh Singh <brijesh.singh@amd.com>,
 vasant.hegde@amd.com, Ashish Kalra <Vashish.kalra@amd.com>,
 robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 6/13/2022 8:24 AM, Suravee Suthikulpanit wrote:
> @@ -3543,3 +3537,30 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
>   
>   	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
>   }
> +
> +bool iommu_sev_snp_supported(void)
> +{
> +	/*
> +	 * The SEV-SNP support requires that IOMMU must be enabled, and is
> +	 * not configured in the passthrough mode.
> +	 */
> +	if (no_iommu || iommu_default_passthrough()) {
> +		pr_err("SEV-SNP: IOMMU is either disabled or configured in passthrough mode.\n");
> +		return false;
> +	}
> +
> +	amd_iommu_snp_en = amd_iommu_snp_sup;
> +	if (amd_iommu_snp_en)
> +		pr_info("SNP enabled\n");
> +
> +	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
> +	if ((amd_iommu_pgtable != AMD_IOMMU_V1) &&
> +	     amd_iommu_snp_en) {
> +		pr_info("Force to using AMD IOMMU v1 page table due to SNP\n");
> +		amd_iommu_pgtable = AMD_IOMMU_V1;
> +		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
> +	}
> +
> +	return amd_iommu_snp_en;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sev_snp_supported);

I need to guard this function w/ #ifdef CONFIG_AMD_MEM_ENCRYPT to prevent build error when CONFIG_AMD_MEM_ENCRYPT=n.
I will send out v2 to fix this.

Best Regards,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
