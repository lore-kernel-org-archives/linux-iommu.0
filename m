Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECDBC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 08:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFBD560F81;
	Wed,  9 Mar 2022 08:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSXfKFnEhYCx; Wed,  9 Mar 2022 08:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B69AC60F53;
	Wed,  9 Mar 2022 08:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C42EC001D;
	Wed,  9 Mar 2022 08:32:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F205EC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 08:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0E6860F72
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 08:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3yr2_Em-mJQV for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:32:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D98F660F53
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 08:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTzXX1O7D+907DylszkHIa6OWwWZMOEfYNjf0Pq9KLv/juQutcMHums+vpBvPLLZauq02v9b6P+EuBS3lkQS8Jds9WNOPPZ3YoLWmE5PeCOeLKbKZG1rt0cvpfQix9Wtkm+Pnch4BnTU5BJKOwIaEYf1aMRLCCPBEjlMFlX2g7zRMNb0lf+qghGgjfLIVAODwCgblkXq+d5I4rqX+X0+riIDVpXkmLpBsZNWk+Vr8BtxES269+ST48MaSbhC7zoo2jcrpCjM2tP+gZOidIDmrs/KMBUqifoYfG14As6jLOvGOeckgbwi86A1O/Poi3/wOqc+7SjyViJ5VpHdOj1tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoSvVfOrWsIf3oZALK3m7DGsgNR4fmdxj8A9yrPNQuQ=;
 b=f5I9mT1KxjWKKlm0FvaPgB1TEA+y3UaffZmqWeqLUBFTlQW6CNTNwaWd4smqCKXfm2I9TAkKyyiH0sg2fE7iC69kwYO+avXbtCNdbcDvfQ58H0rUWYvVLctoSWGLIe1S2IkRYSsw0vwEu6vClIEEeBtIgejBrww6fzsdZv5el2q1Pq55CozpLQa7d79sY2RXlRLODhtq02SCDH2Jd9oMjgH241J4sDdGd0sKaI0cm0vLPeTeV+G8YlmV6z8dsgk9nAERym2EncxWWeL1V5ziLqS8Ocs16AaIAiKfbtYNbU7dFDJR8vd3SL2acBQItZcE2/JF2RVDdX/ysrf8vE7p/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoSvVfOrWsIf3oZALK3m7DGsgNR4fmdxj8A9yrPNQuQ=;
 b=gcrrjKCm6ydw7vv8AHD9VjKcF7l8+Yf64ECS1CJQK5RQHPQ6OCGgTlZNtF3MFFkud6eCd1055CT/ROnARmzAEnUvlKjtVUJIpASUOe0Kq9LpEiJvP8O+cGvcOD0K+U0rl9ZvoxgoJQr5h2lY2MIvvgVSc/FhUaLT97+zeo7YPUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 08:32:33 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::3933:c8b5:f45:f848]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::3933:c8b5:f45:f848%2]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:32:33 +0000
Message-ID: <0ac7bc78-a6db-d301-cd95-88fb69cb33f4@amd.com>
Date: Wed, 9 Mar 2022 14:02:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [bug report] iommu/amd: Improve error handling for
 amd_iommu_init_pci
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>, suravee.suthikulpanit@amd.com
References: <20220309071122.GA24681@kili>
In-Reply-To: <20220309071122.GA24681@kili>
X-ClientProxiedBy: PN2PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::33) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab9d69b5-7849-4992-66bb-08da01a75b1d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1639:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB163963248305D18415A6620C870A9@CY4PR12MB1639.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jv1ZNVidQYRcfJE8dyBTWCxqArpQDrea1sy17Z2akcA/z2pySKUXoAYzUdQkBQRa1ug+eAtPVuS7Q+SZtzY0SQFsTWo31gAenYaFTHRHgIsL+cU1iCrRnMkI1HEpcQHRe2NxClft+QzBiAk2Z6QgPl5HR6pvksVaQmEWuCA+NQz3kObZucfx9ZXnXbrxGTQbSNIZ6UrMmWq7MlTGTYJP8GsB65ki52qSqOFJLCvwVWAb0cYS1SDlMwLWL+OfThjIlTfEMTwAj1QyYpWhj2MeRAseasO9P1GSTJS4LinOb/18nmlT7CkMotS41fRxN/ahyyiU5dGG3AzJoZ4T/fx1I2PlJ4uEUwcD1mBmduycpu3xIAlM1pOp5bZOGXGUj/3WOaY+t4WOaOGrKdu5dtPWhfW67e1I/vLIkL8h1HL6KZ1vfRRqtQbe+jyTGovEhhyq1snKddly3Iy3JEKCJsaDR2QBxniVDiHuHb1bvh13RXHZa2iJx6lIAve7+RCW0jjsRyepSwilMGtOEQZDxqbJ7vgrICyNEOadkh4E14HlgsHx7/8jdc5pkylODah71OIoJjvKJVs6y/sxgVRXueQ1phwUnxwrBxxoubTNuTQ5tPP/BcSqojTizyik0qJqvAJyW2TD/2Tzlam5xpcWjc3tLz/JWqx04+h/Af0lW623E2TKMdUEzZLUSpK4fZl5Q5nmJcUjWYfVXs+qYP6RMVcjkmIYstKhDKMOGMTcqXicmT1hMUnSh/ZVmCgEMluzQXLf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(44832011)(8676002)(66556008)(66946007)(66476007)(5660300002)(2906002)(4744005)(8936002)(36756003)(38100700002)(316002)(31686004)(186003)(508600001)(6486002)(86362001)(31696002)(6636002)(6512007)(6666004)(6506007)(53546011)(2616005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c08zM0l2NC9CMjVGRVlITm1oeGl0SnUxN2ZQeGFXb0hXaUZRV2xUWncyTjRV?=
 =?utf-8?B?Mm5yWUVFUnRpeEJHempOV2xJd0pzSmVnWHIvSHNCWmE3MGp5QVBDMzRRUC85?=
 =?utf-8?B?YUgrUnBndFdEbU83eFhQR0J5ZWh4dGRRVFBCYjJRYUJkOXFqY29HM2FZdDVq?=
 =?utf-8?B?R3E5NGxiMlYwcS9GdnF1WEZucExZUytDU09WRDVLT1E5RVNhKzdKVDhpbDNs?=
 =?utf-8?B?MzVKU2NuY3gvZjNiSS9vbEVxSlkrZ2RJNTVwUWVyc1VUV24xODRoSC9JMVhO?=
 =?utf-8?B?d2lHVElTSFVsMDNuZmY1Y3hzakVnMDlWTW82eG0zRnN5eVA4R1BVQ0NaTXFL?=
 =?utf-8?B?OXVPMHgzbzBxVTBvZXR4NlVMZ1ZjYUlTQTg5UWRJTCt6c0UwWjBXcHQyR0RC?=
 =?utf-8?B?ZDNmU2Y2SXRUMDBDT002SFRvQ29zRVVCVGhWb1R2MEZXTnU0OVhRQlp2ZzZo?=
 =?utf-8?B?dkwwa2VXRHFCTitzdGFZNlMyTmVmbDErdVJKbkJzWElMNmJBRExnVWlhY2M0?=
 =?utf-8?B?QzlrVm1iRm85MUkyWDVkK0Foc0JhNk83cE80YStaZTdKYmowaUZNOE9kcWpx?=
 =?utf-8?B?WVFwU0xqbGtHRnY5eWlRd2xQUFFTM1R0M3pjRkMwY0N5bVJVemVpOHJUc3F0?=
 =?utf-8?B?U2p3cHNKNWIveDI2bWVmc2tQTzJzK1dxcmI3SlVORUVQT0FJRGFzdTdyYnlE?=
 =?utf-8?B?Mjc3QWxKZWlQSkxyZEViYS9mb3JRSFdzeWZFZjAzMFRQRjlpTms2aVFZSVVM?=
 =?utf-8?B?SVZEMVdVdkE3NEdFNmxWcHZCUnFVdEl6K25uUnJIZ3prWFNXcUowZUx6ZFMw?=
 =?utf-8?B?MFd4Q0hvSC9MOGhBSE1va1BuL29UbFIxMS9oMkVyLzZwa1FWU3dlZytyTEk0?=
 =?utf-8?B?SmZKeUpGd2ZZdy9mZ1RqVi9tYkVoTTlXM3BneC9zNlRzYXZhMjNPekl6cmJv?=
 =?utf-8?B?Z3drcmdncVlNR3h1WFJzU3pybDFWdHh2WjRRNUl6ZStlbTc3dmhNeGwvbjRC?=
 =?utf-8?B?ZVY1OVRHcFBRT0JrUGNuOVB4Nkl0TlFKc1RKQUprNHpTamU3dFJZbVE2WE8x?=
 =?utf-8?B?L3NVNFEwZHYwRkFLaTljZzAzR0xsanZyeVVSY1pSVlVreXZQL2Q3WW5mdno5?=
 =?utf-8?B?YlVtZmhsNjNHOUN3aTVucFhSSW1kY3lLSHY0cEhWdm5LdmhEa2FSQXFGVGhh?=
 =?utf-8?B?MzFNUElQcmpMeDRXOHRwMWFkdFRtVTdac3VMN2dJY0Y2UTlad0QzcWVFZHpW?=
 =?utf-8?B?TFJSclZNczdKVFRib1U3a091QjEwcExuMlZCemZVMG5HTmNGMDY1WWUvVVg1?=
 =?utf-8?B?SUpOTjNVaHpkNGZjcHpMRUJpd05XOTVLV0pwZXRTWWlwL1Iyc1ZGRi91bTZB?=
 =?utf-8?B?ckttdDNRWDVVYUZ1aEYwbTNVZE50ODY5NWxoc3lrVDhWK21pSCt3d3VXVFc3?=
 =?utf-8?B?aS9GVmNzL1BNVUlTV3J1dSs1UlhZTzZtbTRDMGRrVkJNTVIwMUcyaWN1K2w0?=
 =?utf-8?B?N0lPTFYzTEVIZU9IWG1yRUlqeVlpZWNhSDRGM09SMnBCa25PZzZGOStHMHhW?=
 =?utf-8?B?MEVWRXBiOFRIdklRUGE3WDZGSVVlTUhqVi9XV0ZXb0U5eWtGRVh5Mi9CSjlF?=
 =?utf-8?B?VzlseWJwWVNBVmE0dk8veUZWUGF3ZmwralRSc2did0dDMHBvQnpEckF0MXll?=
 =?utf-8?B?WkRGSE5vWTB0QWx5M1NWV2VSdDdnVmtGTlgwcjhhNldPWmxGYXhQTVdTK1J0?=
 =?utf-8?B?Yi9qb0x0ZmVMMkNzUW50TXlNNHlIRTVRMzliODR3YWpJYXdiNWtwSHpvK1h1?=
 =?utf-8?B?b2NDbmJKRWNESWxxUWxEaERLUlFSakdFVjdxbC9FUWxNbFpHSldubGdTVDhq?=
 =?utf-8?B?Z3M0QnF4NWVGVkxHUXpDNWFOSnZxNTE1Z3RGVy85VnFLZFp4VXdCWldHeGtT?=
 =?utf-8?B?WDg3eXpXaEJxTU1kWEE2aVliMm02R0hjNGdPRmJXN012UUNWSmpER0w2dmox?=
 =?utf-8?B?R3hSRERWWlY4YmhvWUFheTlJOHN2Rjk1NE1zOENjNWdacDhPQ3NFdXZGZ29M?=
 =?utf-8?B?L0lsYnR1WEVDajdsdXBxRzdnUXE3enh5T2puaE1OTnhQU2dXQ0NWcUJrU1BC?=
 =?utf-8?B?KzNyQ0pKN1JXVHhnRHByZCtEZURRUlFadGs0aEhhNmoxVlU1RE9UTzhYcGZZ?=
 =?utf-8?Q?ibB2M6Pf8qE1/cxLiJl4GE8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d69b5-7849-4992-66bb-08da01a75b1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:32:33.3196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2H/4PsCZUbdSRAaxHeQUznRw8yBLBPp68FtIxIgDdNrWeQqroq7N1nNs+8U6lG3gaG5ntbMnE3LaRR4DizzYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
Cc: iommu@lists.linux-foundation.org
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 3/9/2022 12:41 PM, Dan Carpenter wrote:
> Hello Suravee Suthikulpanit,

Dan,

Thanks for the bug report.

.../...

> 
>     1979                 pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
>     1980                        ret);
>     1981                 goto out;
>     1982         }
>     1983 
>     1984         init_device_table_dma();
>     1985 
>     1986         for_each_iommu(iommu)
>     1987                 iommu_flush_all_caches(iommu);
>     1988 
> --> 1989         if (!ret)
> 
> Where before we just checked for errors here.  This condition is
> impossible now.

We missed to remove this check. We will send fix patch.


-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
