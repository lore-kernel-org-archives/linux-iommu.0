Return-Path: <SRS0=t+bH=3N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B9C2D0CE
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 07:17:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32A520718
	for <iommu@archiver.kernel.org>; Fri, 24 Jan 2020 07:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0myUXlwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A520718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8418088360;
	Fri, 24 Jan 2020 07:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yPm5ciDOFUV; Fri, 24 Jan 2020 07:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E75488356;
	Fri, 24 Jan 2020 07:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32258C18DD;
	Fri, 24 Jan 2020 07:17:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F256C0174
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 07:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3C5D52271C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 07:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9T4GFw1k0-Cq for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jan 2020 07:17:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by silver.osuosl.org (Postfix) with ESMTPS id DA03822091
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 07:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2J3HDVHosgoiXmykcU6KR6kYW6YkftoHe1U3FNeUyjdEYsm5QUR0ngSjm2xqhtntymZCjdSBJ7WSxKVczqD0M1vQY3MNqMSbk7+nikkOUUuI4KE47psBlXp4rQKwdknDC44xp040tQAVGmEL3SJQX9AxrHB96NJkAZm9zMyBeB91v70yeCwHCRzb/dDXU+fcJGPtdrLO6aZZlIoiGDSge56yeIgilYapoPK52xPSqprYPiUpFfP1RXWCIJtD63eg/31MfoUYVVviL3jSXYe7wydfMVVKhyvFB+Xn/LTETxp0FH7NXQyFpolEG5jaDvTN0S+WgABW0Yrc3nQ/DngCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXCiy03WiCi6K2N+t1TTvlrJMiLxF7FXK0aLQsRFCtw=;
 b=f+nTuPjZUWT+wTPR34nGSLWRpOyZMT3RpJud9DbeXDf7xtCDFnXc1DHuAjWMp8KPVrnAr5fHwqEbUfADQdTWcOa3vzOVaJlnAS5Vw24cXKgDpozZRMAKoj30/5LrkdfzQUa0/WfOgrGcLvbKzPjGXDgGEV2+EdWRH0Y8YfxAHGtfCDSjmHw9kMQO2B3I16EnLIG27MsmWKzYWCUPJYZwWYNGiuWFjDksJjMjqqzGS0JutZUfH/tsmT4P0k8Kx0SMcywZRU5WRwnFHvjrziqrHZaxfpOnidruxk+LZSxFYDI175U2H2EITBehuAN065YSyXPNEAxH+z5RNnVwkYRc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXCiy03WiCi6K2N+t1TTvlrJMiLxF7FXK0aLQsRFCtw=;
 b=0myUXlwgu1VhQvLeu30qZP8WV+CbYP050N6QCsJLRkMYuWUwOMBNrTqjA/rFjOAQS7lDMuf2uwF1yn4WLNkIdPvmU9Pb4zL94/pZzN7mU8nv5X14pernodU96MuRS3cQIU87O2o/Hc7P0yXWaAXeH+Exog9sp8s1KnVMxu2xXww=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB2651.namprd12.prod.outlook.com (20.176.118.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 24 Jan 2020 06:44:26 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302%3]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 06:44:26 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during
 init
To: Shuah Khan <skhan@linuxfoundation.org>, joro@8bytes.org
References: <20200123223214.2566-1-skhan@linuxfoundation.org>
Message-ID: <096ee758-a372-4caa-c082-e1e8cff3f033@amd.com>
Date: Fri, 24 Jan 2020 13:43:37 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200123223214.2566-1-skhan@linuxfoundation.org>
Content-Language: en-US
X-ClientProxiedBy: KL1PR0601CA0015.apcprd06.prod.outlook.com
 (2603:1096:802:1::25) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14)
MIME-Version: 1.0
Received: from [10.252.73.101] (165.204.80.7) by
 KL1PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:802:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Fri, 24 Jan 2020 06:44:24 +0000
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a0621e4-c678-4595-45c0-08d7a098da8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:|DM6PR12MB2651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26516DE9B422D57E1D6BD404F30E0@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(2906002)(36756003)(31686004)(4326008)(5660300002)(26005)(186003)(16526019)(31696002)(86362001)(81166006)(81156014)(478600001)(2616005)(44832011)(8676002)(52116002)(956004)(8936002)(6666004)(16576012)(66946007)(316002)(6486002)(66476007)(66556008)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2651;
 H:DM6PR12MB3865.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhGuklFp+Or+wbSiTNWa4IntWOjtCMxVoOugSooPv4bhzlTwJSGZIMnxru39WkZTVlielYYuz5O/wLsImgrwgD2VuQf2jQ8tWhpdRDNPKkr5vTpkxOLa42aXGTewZWiLT90MmT/LIB6JgCXVOZUOKcrR4VtvNGV6g5EYC33XDhY9aFPfmCh72Z489u0vEcZbS3o66gOohA83IdGp7X4p3RA2cZ9w3x8gNQSyO93UgUSd4tN/3Y4V97fVMA9M2gJ4cnOssKfSDYFZX4KkS4sW9Pv/kQf6ScJ4V4EPdKSfqYo725F4bJXoedRTaPs74k6mfWhK+Tdbpq5cLyrR9Vrwmmud5Gvk6F4wOPO/KZDtwKSSY1GPw9pGU16iVN3b4+ADL9XAap8aKC6oZ/zVeIK49VJiEAhXGaKW/NgqOh0hE64vUS9bLVdmYDKnn70EOAjZ
X-MS-Exchange-AntiSpam-MessageData: EMfA0iKmxOxH10E2uE/9RO10uCY4P1+7YqCxn2PFqUxfjYkm4Z0rPLPh795La0eq9sdp+gdeZ7DNNrtykQVNGvOshVNcUpi0QbPEOeb8YW8dIDc8k7H6GlE5i+HgGFTiSPRJZAxAaEj0mHeSwrYcNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0621e4-c678-4595-45c0-08d7a098da8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 06:44:26.1348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOLM+e+lqGZrKwvtQRh6tldA0/zhH7dM32z0WunhvGwhvB3Ls4oHIu60cp16ihviAl+qn2nobUpmRY3ADAhFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
Cc: iommu@lists.linux-foundation.org, "Grimm, Jon" <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 1/24/20 5:32 AM, Shuah Khan wrote:
> init_iommu_perf_ctr() clobbers the register when it checks write access
> to IOMMU perf counters and fails to restore when they are writable.
> 
> Add save and restore to fix it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> -- Fix bug in sucessful return path. Add a return instead of
>     fall through to pc_false error case
> 
>   drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 568c52317757..483f7bc379fa 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1655,27 +1655,39 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0;
> +	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
>   
>   	amd_iommu_pc_present = true;
>   
> +	/* save the value to restore, if writable */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> +		goto pc_false;
> +
>   	/* Check if the performance counters can be written to */
>   	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
>   	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2)) {
> -		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
> -		amd_iommu_pc_present = false;
> -		return;
> -	}
> +	    (val != val2))
> +		goto pc_false;
> +
> +	/* restore */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> +		goto pc_false;
>   
>   	pci_info(pdev, "IOMMU performance counters supported\n");
>   
>   	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
>   	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
>   	iommu->max_counters = (u8) ((val >> 7) & 0xf);
> +
> +	return;
> +

Good catch. Sorry, I missed this part as well :(

> +pc_false:
> +	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> +	amd_iommu_pc_present = false;
> +	return;
>   }
>   
>   static ssize_t amd_iommu_show_cap(struct device *dev,
> 

As for your question in v1:

 > I see 2 banks and 4 counters on my system. Is it sufficient to check
 > the first bank and first counter? In other words, if the first one
 > isn't writable, are all counters non-writable?

We currently assume all counters have the same write-ability. So, it should be sufficient
to just check the first one.

 > Should we read the config first and then, try to see if any of the
 > counters are writable? I have a patch that does that, I can send it
 > out for review.

Which config are you referring to? Not sure what you mean.

By the way, here is the output from booting the system with this patch (+ debug messages).

[   14.408834] pci 0000:60:00.2: AMD-Vi: IOMMU performance counters supported
[   14.416526] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
[   14.429602] pci 0000:40:00.2: AMD-Vi: IOMMU performance counters supported
[   14.437275] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
[   14.450320] pci 0000:20:00.2: AMD-Vi: IOMMU performance counters supported
[   14.457991] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1
[   14.471049] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[   14.478722] DEBUG: init_iommu_perf_ctr: amd_iommu_pc_present=0x1

Also, here is the perf amd_iommu testing.

# perf stat -e 'amd_iommu_0/cmd_processed/,\
		amd_iommu_1/cmd_processed/,\
		amd_iommu_2/cmd_processed/,\
		amd_iommu_3/cmd_processed/'

  Performance counter stats for 'system wide':

                204      amd_iommu_0/cmd_processed/
                  0      amd_iommu_1/cmd_processed/
                472      amd_iommu_2/cmd_processed/
                  2      amd_iommu_3/cmd_processed/

       10.198257728 seconds time elapsed

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
