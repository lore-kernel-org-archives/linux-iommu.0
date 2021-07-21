Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF3C636C8
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 00:05:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B2610F7
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 00:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B2610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 228D8401B4;
	Wed, 21 Jul 2021 00:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Am6VoODnh9Ws; Wed, 21 Jul 2021 00:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D79F74011C;
	Wed, 21 Jul 2021 00:05:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B77C7C0010;
	Wed, 21 Jul 2021 00:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38FC2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 00:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1285160791
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 00:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id deakdgRIHNv0 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 00:05:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3D6E60093
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 00:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0G7lyA6KGahCwO7ZbeRVFC1I61aleEvdA+nizM/3QVPvQD6MOSPmAaQ7c0pYgX7OWPR/oGqVL1tlFIvKIzBwianJ16Qim+Pg36cbH7jGG5r9tt3lYwOICPlusLuUCY4nXMpgUT2Np2+VHq3DiNQodpvhEssl2W4QGypOHjIUt4fVCaljuh8G7YSpTNN2VyDOXFACdgEgJCGlBP/gaCaGLJcDypg1bm7e+Pp6LvlPURAV/gM6Nso7atjYlO3Tohpv0rc69ag2ZRpMxRWuLrfapyeselnNL9B1bURJdH0vX2F1NfP0v2UtKeiekLyBLx3No/To+YDk+TOrg2fy4sitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsatPFEX2jgCmC/poNW5lCwEOf5D1phiklTq9fMplaw=;
 b=mQG3v4dMxuUkG9LUoxNb+R4xJzlIASDe6QVzyU/7YM+ohS3AsFvzk5NsbEqM2LYsFLwgGBq1smsn5/AanEgErjoEOcVK5JDFqFiSDR4/bpl5hITVjhfZtBWKGWHo91Db99QQY0m/i4O9ODaBCK+MB5jY51y29wiyQr7NSbVUgTUBtFdJrDPYvyWWQYEJf9fTUw8wus1pgICHG2LSgsgZqXz1SjL/ZNC0W7tQ3O9hr6khxBidNAOZNaZ0VyjucYqfZQ75jZqJMQW1b0ketq6hSu9PRvLdxlBeSNK/50HCEyX1Yo9m7B3YHbmJLf626Ku87oPcV30ojLS2z7CS0eZuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsatPFEX2jgCmC/poNW5lCwEOf5D1phiklTq9fMplaw=;
 b=F/lEAy3AQpS8JtD2cKLD6yyePH7MctW6iKBfCfQZRbPBsMOfCtp2EqLPwkNAyLgQvJrxhJLlzlhlQY49oeYkWPULRQIH1Kr5FDZjNS87zUsGlZ+kJBbMaqwv0ovJT98ibWTbFA6opxW7vmQnRMerRP40huvHNVjo3VVTKQxOEqs=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.31; Wed, 21 Jul 2021 00:05:52 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 00:05:52 +0000
Subject: Re: [PATCH] iommu/amd: Fix I/O page fault logging ratelimit test
To: Lennert Buytenhek <buytenh@wantstofly.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
References: <YPTLl7XHOGp5NiVH@wantstofly.org>
Message-ID: <79c1cd8b-c680-b3fb-08f0-47c42290d1a4@amd.com>
Date: Tue, 20 Jul 2021 19:05:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPTLl7XHOGp5NiVH@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.188.23] (165.204.77.1) by
 SA0PR11CA0202.namprd11.prod.outlook.com (2603:10b6:806:1bc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 00:05:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 166746b0-ed8b-4ccb-48f1-08d94bdb4dcd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357DA7D62E8C9DACE1F7F4FF3E39@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYgq/3cI271EyEpOrdRSELJqT2qaAceQBqcAjMfMadoEfmPgQ9NiUkV7BBln0wP6KNnLZcoobFsHFnsWx8WKLU18V7Ak7tsWCbPqyjMy+2gp5uQvtI8fxUBWkIlzkrZhC0e8fcqGXnfq6K3ngy0wz6Ev4cRR3CE99ZEhWQoHcik4MCY7jw6JaOOQJpe9kXoK9U1/EPxTFUFN4jSDYfZR4dKWEextVlGL+PJgMyW1vsqVcK5rWpDYgXRVV5+mo6q97fEj64/wwxLNZ6G/YNeSWk1+Iew1zhEpfwxULjXTJ5pPWPr7M8PiUC6oa2QIxrRWopK8h0qhTzM3roXy8Qmg9RDPmdq8Nv5j405PZCjo3TyuK70AIh8fNF1ZHXa7RDo+Ep5+9A1WnUMUESBAh/kCvTJO6/chVtU13No2hvj+y3PG7zs2hBVAnavOti0GP5LpGu6cUjm7JJZoyxnPOE1IzR6sfZQEqNalSlh0/MqpLMKcVmzvoGCW5UgqNXrMHA11mO4G+WqS25E3CcRraoPsN3Z/bsJeuC8ZDsxynj7UCJ2WmoI9ssCwC+Td4RKw21sOM4Ddkr67vh2ANC6GCuszVUksMuS9kDQfXeSO0QXUGQf/Nntg+BEro0QjhEwx5WnSo44UMRNnDLh4ajyIecIfPT6iVqgV8JFyRfBaLnabswbehm1hs2bOjNk5y9StkYUhPiv34k5sB/IHbt05mdIxWoAsUK6PGGD4b2RkUwY/cC0vAujuFyZ0gbs8jlPRO9o9ZCgleBgLlft/Uu+g/ZlZ/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(31686004)(8936002)(26005)(52116002)(83380400001)(31696002)(2616005)(6486002)(53546011)(186003)(956004)(38350700002)(316002)(38100700002)(36756003)(16576012)(66946007)(86362001)(110136005)(66476007)(66556008)(5660300002)(2906002)(478600001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdpM0FlNnZnaGowajl4SmV3dWU4TG1XOGpoWjZ2RVgzUkVzNXMzR0pDWU1H?=
 =?utf-8?B?Tmw5bkpYaFQwNUEwK0ZiQm9MTlc0ajdOYkxWL2xoR292c2h3RmNaSmcrV2Yr?=
 =?utf-8?B?c01Yc0MxR29lTXI0TFhhWkhTZHdFMVp6V2FnMkFHS1pXQTFaRUh5SjNhU3Fl?=
 =?utf-8?B?OG9nYkNuVWZSV0ovTjZkQWEvWklsWWxCN3grKzNneFcxa0Z5MlMwMWZ5Sllk?=
 =?utf-8?B?aFo4bU9rcTkvM0dlSHpmd1IxYm9ZKzJCQVJ4a0hDaTRMZ1d1eHZsSVpGdkRC?=
 =?utf-8?B?dzBFSjE0c3AzaDNhRWpPYnQ4L3YwOFg1aTh0dzdNSS9kaTUwbGJHZ2RGbm5t?=
 =?utf-8?B?dlNOZWxTYkM2ZHR5TmR2R0NvU0RMRmptSnFrZlBFSkNMaGRqMDYxbHg1TmdD?=
 =?utf-8?B?K0tnQjRNYnQ1T1dqTGRBZitDd3prWXJ6OHlBaEhreXJEcTNmeENUWXNvcUVB?=
 =?utf-8?B?TlZySlZyai9XeVEzd3VlbnprdVE3MDg4cng5NU9jcmFtQlYxTU1yS1hHN1dz?=
 =?utf-8?B?cERQQXBCQlJrT2xYb2FkcldIazAwc2ZCQ0tRNWNHVU02ZGI5MHVidTJGOTY2?=
 =?utf-8?B?bDdnU2VXNlV1SDZwZVVtMHJnbVo4RUMwMVBpdVYwM3djYitCTVJ1L2g5N3hT?=
 =?utf-8?B?dndEM29YTXJwZjN1VG80U3l0SGl0MWRwRXhKOHRYaEc1YVBtaTFlbE1VUElB?=
 =?utf-8?B?MUxLWGZMV01tWVV5WFFqNDJGa1F3TFlkV3Z3YUJZSDB4ekExc2paemVvWkUz?=
 =?utf-8?B?MTA0cCtlVGtIbzR6dTFialh0TC9pR1k2K1BjY1FuWkRrUmxkTnBRRXpwbVk3?=
 =?utf-8?B?MEsyVXhtSFh3UFRVVCtVS2lRV3BoYUtWWEduUjZMeVAxWHVTSUtONm1mMmJV?=
 =?utf-8?B?cGNzZmZRSlBKdXZCK3NKYWlvZ3pwdFlUbERoM205YjE5TldNeGdsSFFHRnV5?=
 =?utf-8?B?YWpPUUFSNUpIVjZvMEowNTVER3l2R0tKRURpZGFhVUZrbU5yY3Vlbm9iUnZr?=
 =?utf-8?B?ZnpmMTh1cXUrTk80aWx4dGc4VlRtT3J2MXE3YURMMGl1QVUwazI5a01jZzd4?=
 =?utf-8?B?MUxlV0hnc1NxMWtqb1dHMEoxbmhLaE9maVJVMzhDMkZDSUpsTEF2MkM4bWZV?=
 =?utf-8?B?UVJ1TExaVEprcnhZSjlRRUxWY0tSWVgvc2Q0ZDg4dHZnd3ZOU1NrMTRKamxH?=
 =?utf-8?B?THowNlVlOHREYmFNY1V5aWwzalkyUitLazZVclE5dzcreHp0RzVwTkw2Y09L?=
 =?utf-8?B?QVhrVmgyZE9RREVFVmV4MXYrZVRPWWVoTi93WkhGUkRReFVaU0g2Z2tCckFp?=
 =?utf-8?B?c1dwT2dnb3NQYWVVWDFZT0tpVlJEOHRGQit1d2ZXMW5SQU1BMEg3Umw2SElx?=
 =?utf-8?B?L1llMW4zODNmeGtvYTV4R0h0WXgvY094eUF2K3V1SCtRZnRiRmI3VWt6V3NU?=
 =?utf-8?B?NkllbEZMSGlWSTFjbWhld0YwWjZqOHpwTFloYWxjODU0dVhybTJpN0ViaEtG?=
 =?utf-8?B?a2k5WFpSVkQ0akRHNWF2aTl0WHJYcDN2dFd0amFLTlJMNmt0U3I5Q2hQK1Bz?=
 =?utf-8?B?OUg4TTl2SUtWRnhBUTdvYnZzTEF3cmN5b204UjhUV1cwTGwzQlBuU2J6U3Bw?=
 =?utf-8?B?QXg1STNVTUQvZjA3RHltNS9PSlZVbkxlWDk2bzlPWnl5T0tXNXg3eDdtZ2c1?=
 =?utf-8?B?MmM2TjU2Wm1HemxZLyt2WGJwSFdlVE1CVE5ZRnJpVmxYZ0tQLzZ1a3prektp?=
 =?utf-8?Q?jbPT8nGACY8NfnX60AQxU2uRUfc4/cinEsvqbCV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166746b0-ed8b-4ccb-48f1-08d94bdb4dcd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 00:05:52.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FVysFnm4pW1nKEf1Q8W/3VBalk5gQeDIdALX93zCst1pbyinsMN0f2ZfgDTSvPrY39fLnyLWH+NW2cZxOahDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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

Hi Lennert,

On 7/18/2021 7:47 PM, Lennert Buytenhek wrote:
> On an AMD system, I/O page faults are usually logged like this:
> ....
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 811a49a95d04..7ae426b092f2 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -483,7 +483,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   	if (dev_data && __ratelimit(&dev_data->rs)) {
>   		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
>   			domain_id, address, flags);
> -	} else if (printk_ratelimit()) {
> +	} else if (!dev_data && printk_ratelimit()) {

This seems a bit confusing. Also, according to the following comment in include/linux/printk.h:

/*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
  * with all other unrelated printk_ratelimit() callsites.  Instead use
  * printk_ratelimited() or plain old __ratelimit().
  */

We probably should move away from using printk_ratelimit() here.
What about the following change instead?

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..8eb5d3519743 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -480,11 +480,12 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
         if (pdev)
                 dev_data = dev_iommu_priv_get(&pdev->dev);

-       if (dev_data && __ratelimit(&dev_data->rs)) {
-               pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-                       domain_id, address, flags);
-       } else if (printk_ratelimit()) {
-               pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+       if (dev_data) {
+               if (__ratelimit(&dev_data->rs))
+                       pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
+                               domain_id, address, flags);
+       } else {
+               pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
                         PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
                         domain_id, address, flags);
         }

Note also that there might be other places in this file that would need similar modification as well.

Thanks,
Suravee

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
