Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE7C2D0E1
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:04:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0025A216C4
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 15:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rcWIPxZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0025A216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 926158722E;
	Mon, 14 Sep 2020 15:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id leuH2r8ANNKm; Mon, 14 Sep 2020 15:04:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E1F6887223;
	Mon, 14 Sep 2020 15:04:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3F41C088B;
	Mon, 14 Sep 2020 15:04:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E5DC0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CB6A86930
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nuJSQdeWMV4w for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 15:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 45BC18696B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io/U18kkPk1t4n8POIgcmQESxrpMEZyO/qwLZXCYWQB78TE8mFY8xRLdtsB0861QbBxDIjeK8yRxuu86z5VVCzQmNh11RIhsbhS8MBMV5EuaW1h6GZ2vGFQF9L6mZwf20POXZjmO+HngyGhIrVavuvf0dTDheJLwkhu8Ktg8Blb/omc+OvzBfXPQ30fLr0donpy8AFjFmEjO0CiP8DsD0CygxuEvaxEB5UCXcM4yVWtj1vsXLJGn2NvWX/Ek1IQ0vjHBkpHzUWvMWr53n79KaZEJPcgpoqUcPZbi4UQHM5M4kpa1mMmO3z2iXuNOIMFAAlJJkT8v1mRzRdqJ+ewjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mAgIvc/FRAq5a6T3X6+Jarex/MhTvjvJq3+6efIDqc=;
 b=SzSekG1RLOqExNvyVqpX/8rxpmjJ01wAJlLdx2gpnHHRSD50PxgBp5EQhNhC0u9n3OZxBrKWn4roclbybXHsoj6O/7q7YjtFyS2BFKHsZXg9mHG+9so7cTTPVeruCgxBqfZo19NUTNijpwSeR5qkWtwSRi+5Hk0aQykOqPC3WPUlFWn+4v3BXn43CMUXFR27LfnmhkwNfa4IjMeqoyRk3+Ti2ZCE/nbJttjrfWIqnE+Pg4ZIwidBRF31M1RLQzws/G73QfpJVW3h+nIXbEHtv7cP3iMdcNmYQQznk32nEFy1lJa3tUn/8HL7ur03kP9gkgLd/3CLoCYP1M+QtXQpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mAgIvc/FRAq5a6T3X6+Jarex/MhTvjvJq3+6efIDqc=;
 b=rcWIPxZGjrpu4KXkpyerjhrB30fYPCDqnOHm2MTKZ3OHl86cBDCixkI+2/asJr18DiEaMf1fU2roOHiRM+McArnkwjgwG+Veo1yw5c68r2zGFQK9T8AfjEj2jUyMXNR/8eSL6Zb2clfvAo+4fdaoWzO7GtX0FhHGRqcuYexqZRY=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3273.namprd12.prod.outlook.com (2603:10b6:5:188::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19; Mon, 14 Sep 2020 14:48:56 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:48:56 +0000
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
To: Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
References: <20200913124211.6419-1-mlevitsk@redhat.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <60856c61-062b-8d92-e565-38bd00855228@amd.com>
Date: Mon, 14 Sep 2020 21:48:46 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200913124211.6419-1-mlevitsk@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: KL1PR0601CA0021.apcprd06.prod.outlook.com
 (2603:1096:802:1::31) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by
 KL1PR0601CA0021.apcprd06.prod.outlook.com (2603:1096:802:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 14:48:54 +0000
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d5fc6c0-5372-40a3-af67-08d858bd4e5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3273:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32736CB48CFA4E166711B456F3230@DM6PR12MB3273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFnf8NMDGW3aXy2YrSqiybCjn74yyWtwFFPonT2f4d79+26tlMy09IgSUI5Rf/s7+e7qqSnRCCwgKYb7+BDttCYLEL+SZSjfGVCUNtWekrZ4zuKWLQeZ6vx7Q/horRCj7QBaXU2osta+IK7Lgcv/5qvtIlJdoGwbdCuprH9JJ7sWHHHCJPxAzARYwnlp4ON65CAsyljRornjM4tZZBjXBSV6utEDR9TVlkxAJfHDpCqpuc0W46IV5QlpT+RoKUkOmODm5LR4oJejnc8/ElbEyluT2OaNbd1a0MV21qTdZRrj7TFnHeQHHjNxV2cHXVL5UocfkASP0lSm66tvl/e3/pYN3DIIE34mrHZS9n4+G5WwNowZUj5GyRnERLnLFZx2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(31696002)(6486002)(16526019)(5660300002)(186003)(26005)(478600001)(956004)(16576012)(316002)(2616005)(52116002)(44832011)(53546011)(54906003)(83380400001)(2906002)(4326008)(8676002)(6666004)(31686004)(8936002)(36756003)(86362001)(66946007)(66556008)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wuEZ2RY/us6xRzOQGw53WsrykcfFV/bHugTc1XC0nygZXAM4P6VBVWb/mro8n7C3LdcVPVCj7sk9nQA/BS9YPHXrsHz+6gzZnDqFYmAaonz47g1r+hOZQ4uCtkhuAJ4KhO8AZatNbR740DKgBTyYkmvEkZQar9yGf5MY2aj94nwUR6sUJqmsPb7au4hnP2NC671JBAcKykBz3op3Bvxlnujp9ZAqTBJXsBBV1stnISqHfhLZIXlmSknv6au8UzwO8RR5tF688jxnoadxVIb2ripa8r8+bIba7TqfIQ8A00OIOt97cj/rKmEBeepKkweLkUmn0B4XJyKIIWuSvlDgyJgAjYw9fXFfTBEzAT6DdrrvbfrqBwuBdaPmOfIvUJvo77foJcSUji8KSZD6bFtQlacWgRl6Zy5KjXijX5y7zxqMt1ecTc5L03UuoIynqXatXHvqHrX+42NAeB8ePn+ewoJQnNvv4aaBdMb4MqlVZnfo+HszkYYgVr77XjzMOjwytjydwvHD5HUqvf0gK9dTCTor/NvehlivvJRxSZwbqanejAT0LvXYj5HOBMBaJAGR064Z3iPkwavpAWK6EnU/QaDsrCIRRiIIQe1RTXxq1y2VDagmrTtcu3AcJG1fZ+GEtQCo4BhuIYF6ruaYqfC2sg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5fc6c0-5372-40a3-af67-08d858bd4e5e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 14:48:56.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIZ8/LY531MW61ePPP0jEGpF9lKyqnIkItAeWomiq0WnZzrjSynfZRBUBj8Z2yB0/e6GpMc3ct1ZQfd/PIZJGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Joao Martins <joao.m.martins@oracle.com>
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

Maxim,

On 9/13/2020 7:42 PM, Maxim Levitsky wrote:
> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> accidentally removed an assumption that modify_irte_ga always set the valid bit
> and amd_iommu_activate_guest_mode relied on that.
> 
> Side effect of this is that on my machine, VFIO based VMs with AVIC enabled
> would eventually crash and show IOMMU errors like that:
> 
> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xfffffffdf8000000 flags=0x0008]
> 
> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   drivers/iommu/amd/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 07ae8b93887e5..aff4cc1869356 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3853,6 +3853,7 @@ int amd_iommu_activate_guest_mode(void *data)
>   	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
>   	entry->hi.fields.vector            = ir_data->ga_vector;
>   	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
> +	entry->lo.fields_remap.valid = 1;
>   
>   	return modify_irte_ga(ir_data->irq_2_irte.devid,
>   			      ir_data->irq_2_irte.index, entry, ir_data);
> 

Could you please try with the following patch instead?

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
  {
         struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
         struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
+       u64 valid;

         if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
             !entry || entry->lo.fields_vapic.guest_mode)
                 return 0;

+       valid = entry->lo.fields_vapic.valid;
+
         entry->lo.val = 0;
         entry->hi.val = 0;

+       entry->lo.fields_vapic.valid       = valid;
         entry->lo.fields_vapic.guest_mode  = 1;
         entry->lo.fields_vapic.ga_log_intr = 1;
         entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
@@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
         struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
         struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
         struct irq_cfg *cfg = ir_data->cfg;
-       u64 valid = entry->lo.fields_remap.valid;
+       u64 valid;

         if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
             !entry || !entry->lo.fields_vapic.guest_mode)
                 return 0;

+       valid = entry->lo.fields_remap.valid;
+
         entry->lo.val = 0;
         entry->hi.val = 0;
--

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
