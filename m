Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCFC433DF
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 07:05:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13F7206DD
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 07:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U8+4N5PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13F7206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9217A88D7C;
	Fri,  3 Jul 2020 07:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J46nNyR-bgc8; Fri,  3 Jul 2020 07:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D6CA88D78;
	Fri,  3 Jul 2020 07:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6192CC0888;
	Fri,  3 Jul 2020 07:05:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 177CEC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 07:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E6C7B88D7A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 07:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Rgcv8l9uaR5 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 07:05:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 03C8D88D78
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 07:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITktqiBg6VEN7Y4L2ptOrkAz+zSXTgWT1xpgjRrvDFwbr/9WXaNaJbU1AOlqNDWELXRcCgsq2wRBP1myl9Px6atCDSOtZXfgShOq5arFVMRrU50pOjMFEfgBMXywnzvuEHWCX7q4+6aUFaFhI4cG2Cd2epmpspD/nkuIbh7qhScNoZuw4gXiYXW92QXD0jcJJ6WaLn8dXg/YXdLdn1MP+Ah636bY8aH0onlr2U+9UbmpA5HvLp4dnHkxwf98gO74I5M/Fxu5s6ecHENTngEKqto/vbrzJ5cYU7oCBjRdVLRJ3yibXdE7xM2xU9ocCvG+mMco7PyAo0Fb1xhFVXCmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOvhwJ0tjU08CkmnJStnOuVp58aGngde1HT9JmfqXvY=;
 b=gwJpm9Lle1RUc3HrgR4H4jfwfoni1oer7U/18JDgchNoyJerx71RjloUMRkLPg8nunEwFlgnGALT6kLwDB91Z9eFXcy9I2gnglGezO1iqNVG/i7vr1UVq+mnDh+W0NcIJBqATvfpJHWyNXgbiZYTxjDMUlcM6WLpg8p6rxKWEyijwrw12cNJA0eMzrQ6ajlT87n469lK2N2K5WJh4z9//CFw6Ow9UQh+zvTE3JxmzzhHmUlcjnR1eVAVaT2mHJPmEaIX679tf18wOOn3LcoGnVrqlPWLTj2Hzhe9kAL+9gn2S5SLWB+J3Qgqhx/4XLQd253klQH+7YoFafKlwERFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOvhwJ0tjU08CkmnJStnOuVp58aGngde1HT9JmfqXvY=;
 b=U8+4N5PGA3y8Vt+Dfq7DwRvwkFDIEW4rF/BINBuDHKTI9l6vZYEcazT7i6512aUFaCCZymwCPZIJYTY57BS5VkXvXNxf7gAh5PmM9P16tKo8eMseq2wIWVhGm+/tOO/nHbJ5jNKvVUBEGOxlShwWkWlJSxE8Qaoh6D35aVLxRm0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 3 Jul
 2020 05:32:33 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::180c:9e60:d3cd:e89d%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 05:32:33 +0000
Subject: Re: [PATCH v5 01/12] iommu: Change type of pasid to u32
To: Fenghua Yu <fenghua.yu@intel.com>
References: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
 <1593560682-40814-2-git-send-email-fenghua.yu@intel.com>
 <22a0f829-aa00-5de3-b1ab-3fd04af32f97@amd.com>
 <20200702191027.GE32961@romley-ivt3.sc.intel.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e6e7b41b-351a-e9e9-9570-4a19157bbd42@amd.com>
Date: Fri, 3 Jul 2020 01:32:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200702191027.GE32961@romley-ivt3.sc.intel.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.53.25) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 05:32:31 +0000
X-Originating-IP: [142.117.53.25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 502afa9f-f7b8-4a31-498b-08d81f127c5e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44295A6EFB96710078CE8FB7926A0@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J74IdE4pOkb2JfjHsJRMzg2OwsoB9pgj8OoH9Bo7a5rYCnhZ49i+0gM8d8XL7VXdoh0Dhq5TvjtP+Jl7EZSZlGkPpNuZfwq8A9rHM61EBr3j6XltZ/b/7BJrhUXAS/H92vAO+SBtZrzptrz0uJjkF78wUucD0naSinZBwHvRy8DaT/XbUcs/j2WD3ah33YxKVhVFMIbToxCx0+Q4y5CtXvxnhBdPO+LuqlP7FA3tSzQVTTV23+NTw/JYxCTIA+hRQZ/lS+TkKg7PEusblAxKbvFS60CCfH2kFwI52tPWdcGXMqVLZvEEXI+/ffUKe8UN+grqI4ChBjEukK0Z7rHOjgF/eKgg9XYCnd3wXZtBXdHkdQCW4bj9VO5uVdr8xhYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(478600001)(8936002)(956004)(2616005)(26005)(6916009)(5660300002)(16576012)(4326008)(8676002)(44832011)(86362001)(316002)(6486002)(53546011)(30864003)(31696002)(52116002)(7416002)(31686004)(2906002)(54906003)(66476007)(36756003)(66946007)(16526019)(83380400001)(186003)(66556008)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8XsK+7rTG7MYMXO+kQYs7pJkiWstaY8DXuH2SLgUM6IEaomkjg6F9sgE6qMHEfHF4RuZ7iXzG7MmkRGOQO+yCUTWj8Raxvb790TNB6c5n/FgH/JcHY0cHxzUuvwWPmSrm+AG3pGfYvNjLTJkbszCScgMXWy/khu4v8MWkX/Nj4XeLi9ToxcX/MGWDRRmY/CUlQA9+M2Mt9nC7ag10fojE2QQQ41R9Ov0l6oqHQPBPHnfTJgw3mKaLbI24XW8xI/93cfPkIQIQ9T9Kd4jQpJR6ul56TBCznu+E9jDwPI41XOPwVcbb3bkZR4x490bIZWlA4skAOXGEHrLGHhA9HEnO0SmbuUAkvsCFHBQ5xN7evDdWYQ25TNZBCtmEFq78oBsDQZRzmZRb7fAc0YvXBYmjlgNvVmblUHsvVZ23Zl88XvvWs77f/pJVsZuR8itH2lToBWysnpJ+wK+/KCatfu3BJVQOCEqMzE8/l9pP3ImVNw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502afa9f-f7b8-4a31-498b-08d81f127c5e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 05:32:33.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNITgsS3vpVyzDFMS2A/mebykWj7lOhxndkNuIVadAdsItmpA/pIKAUSZFt4ugV7zLz71v5HC8Pe6u1nOnc5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am 2020-07-02 um 3:10 p.m. schrieb Fenghua Yu:
> Hi, Felix, Thomas, Joerg and maintainers,
>
> On Tue, Jun 30, 2020 at 10:12:38PM -0400, Felix Kuehling wrote:
>> Am 2020-06-30 um 7:44 p.m. schrieb Fenghua Yu:
>> You didn't change the return types of amdgpu_pasid_alloc and
>> kfd_pasid_alloc. amdgpu_pasid_alloc returns int, because it can return
>> negative error codes. But kfd_pasid_alloc could be updated, because it
>> returns 0 for errors.
> I fixed return type as "u32" for kfd_pasid_alloc().

Thank you. The patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>



>
> The fix is minor and only limited in patch 1. So instead of sending the
> whole series, I only send the updated patch 1 here. If you want me to
> send the whole series with the fix, I can do that too.
>
> Thanks.
>
> -Fenghua
>
> From 4ff6c14bb0761dd97d803350d31f87edc4336345 Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Mon, 4 May 2020 18:00:55 +0000
> Subject: [PATCH v5.1 01/12] iommu: Change type of pasid to u32
>
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with uapi
> definitions, define PASID and its variations (e.g. max PASID) as "u32".
> "u32" is also shorter and a little more explicit than "unsigned int".
>
> No PASID type change in uapi although it defines PASID as __u64 in
> some places.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
> v5.1:
> - Change return type to u32 for kfd_pasid_alloc() (Felix)
>
> v5:
> - Reviewed by Lu Baolu
>
> v4:
> - Change PASID type from "unsigned int" to "u32" (Christoph)
>
> v2:
> - Create this new patch to define PASID as "unsigned int" consistently in
>   iommu (Thomas)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +--
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  8 ++---
>  .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h       |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  8 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.h       |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |  6 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_pasid.c        |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 20 ++++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +-
>  drivers/iommu/amd/amd_iommu.h                 | 10 +++---
>  drivers/iommu/amd/iommu.c                     | 31 ++++++++++---------
>  drivers/iommu/amd/iommu_v2.c                  | 20 ++++++------
>  drivers/iommu/intel/dmar.c                    |  7 +++--
>  drivers/iommu/intel/intel-pasid.h             | 24 +++++++-------
>  drivers/iommu/intel/iommu.c                   |  4 +--
>  drivers/iommu/intel/pasid.c                   | 31 +++++++++----------
>  drivers/iommu/intel/svm.c                     | 12 +++----
>  drivers/iommu/iommu.c                         |  2 +-
>  drivers/misc/uacce/uacce.c                    |  2 +-
>  include/linux/amd-iommu.h                     |  8 ++---
>  include/linux/intel-iommu.h                   | 12 +++----
>  include/linux/intel-svm.h                     |  2 +-
>  include/linux/iommu.h                         | 10 +++---
>  include/linux/uacce.h                         |  2 +-
>  38 files changed, 141 insertions(+), 141 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index ffe149aafc39..dfef5a7e0f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -207,11 +207,11 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
>  	})
>  
>  /* GPUVM API */
> -int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasid,
> +int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
>  					void **vm, void **process_info,
>  					struct dma_fence **ef);
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
> -					struct file *filp, unsigned int pasid,
> +					struct file *filp, u32 pasid,
>  					void **vm, void **process_info,
>  					struct dma_fence **ef);
>  void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index bf927f432506..ee531c3988d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -105,7 +105,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>  
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 744366c7ee85..4d41317b9292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -139,7 +139,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>  
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index feab4cc6e836..35917d4b50f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -96,7 +96,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>  
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c7fd0c47b254..b4b88e4da4de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -110,7 +110,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>  
> -int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
> +int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index aedf67d57449..ff2bc72e6646 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -26,7 +26,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  		uint32_t sh_mem_config,
>  		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
>  		uint32_t sh_mem_bases);
> -int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int pasid,
> +int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  		unsigned int vmid);
>  int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);
>  int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b91b5171270f..9d06366320bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -994,7 +994,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>  	return ret;
>  }
>  
> -int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasid,
> +int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
>  					  void **vm, void **process_info,
>  					  struct dma_fence **ef)
>  {
> @@ -1030,7 +1030,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned int pasi
>  }
>  
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
> -					   struct file *filp, unsigned int pasid,
> +					   struct file *filp, u32 pasid,
>  					   void **vm, void **process_info,
>  					   struct dma_fence **ef)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index fe92dcd94d4a..3f697e9010d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -43,7 +43,7 @@ static DEFINE_IDA(amdgpu_pasid_ida);
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
>  	struct dma_fence_cb cb;
> -	unsigned int pasid;
> +	u32 pasid;
>  };
>  
>  /**
> @@ -79,7 +79,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
>   */
> -void amdgpu_pasid_free(unsigned int pasid)
> +void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
>  	ida_simple_remove(&amdgpu_pasid_ida, pasid);
> @@ -105,7 +105,7 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fence,
>   * Free the pasid only after all the fences in resv are signaled.
>   */
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
> -			       unsigned int pasid)
> +			       u32 pasid)
>  {
>  	struct dma_fence *fence, **fences;
>  	struct amdgpu_pasid_cb *cb;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 8e58325bbca2..0c3b4fa1f936 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -71,9 +71,9 @@ struct amdgpu_vmid_mgr {
>  };
>  
>  int amdgpu_pasid_alloc(unsigned int bits);
> -void amdgpu_pasid_free(unsigned int pasid);
> +void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
> -			       unsigned int pasid);
> +			       u32 pasid);
>  
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d7e17e34fee1..8503cce467eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1062,7 +1062,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
> -	unsigned int pasid;
> +	u32 pasid;
>  	int handle;
>  
>  	if (!fpriv)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7417754e9141..ada2534dd8d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2783,7 +2783,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, unsigned int pasid)
> +		   int vm_context, u32 pasid)
>  {
>  	struct amdgpu_bo_param bp;
>  	struct amdgpu_bo *root;
> @@ -2954,7 +2954,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
>   * 0 for success, -errno for errors.
>   */
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   unsigned int pasid)
> +			   u32 pasid)
>  {
>  	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>  	int r;
> @@ -3252,7 +3252,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   * @pasid: PASID identifier for VM
>   * @task_info: task_info to fill.
>   */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
> +void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			 struct amdgpu_task_info *task_info)
>  {
>  	struct amdgpu_vm *vm;
> @@ -3296,7 +3296,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * Try to gracefully handle a VM fault. Return true if the fault was handled and
>   * shouldn't be reported any more.
>   */
> -bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
> +bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  			    uint64_t addr)
>  {
>  	struct amdgpu_bo *root;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index c8e68d7890bf..c2f23b071f14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -371,8 +371,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, unsigned int pasid);
> -int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, unsigned int pasid);
> +		   int vm_context, u32 pasid);
> +int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>  void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
> @@ -429,9 +429,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>  				  struct amdgpu_job *job);
>  void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>  
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
> +void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			     struct amdgpu_task_info *task_info);
> -bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
> +bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  			    uint64_t addr);
>  
>  void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba93cfe0..c2fd30045ad5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -90,7 +90,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
>  			(const struct cik_ih_ring_entry *)ih_ring_entry;
>  	uint32_t context_id = ihre->data & 0xfffffff;
>  	unsigned int vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
> -	unsigned int pasid = (ihre->ring_id & 0xffff0000) >> 16;
> +	u32 pasid = (ihre->ring_id & 0xffff0000) >> 16;
>  
>  	if (pasid == 0)
>  		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index 27bcc5b472f6..b258a3dae767 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -45,7 +45,7 @@ static void dbgdev_address_watch_disable_nodiq(struct kfd_dev *dev)
>  }
>  
>  static int dbgdev_diq_submit_ib(struct kfd_dbgdev *dbgdev,
> -				unsigned int pasid, uint64_t vmid0_address,
> +				u32 pasid, uint64_t vmid0_address,
>  				uint32_t *packet_buff, size_t size_in_bytes)
>  {
>  	struct pm4__release_mem *rm_packet;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> index a04a1fe1d0d9..f9c6df1fdc5c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> @@ -275,7 +275,7 @@ struct kfd_dbgdev {
>  };
>  
>  struct kfd_dbgmgr {
> -	unsigned int pasid;
> +	u32 pasid;
>  	struct kfd_dev *dev;
>  	struct kfd_dbgdev *dbgdev;
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9c4867abeff..9571a6e5de4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -40,7 +40,7 @@
>  #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
>  
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
> -					unsigned int pasid, unsigned int vmid);
> +				  u32 pasid, unsigned int vmid);
>  
>  static int execute_queues_cpsch(struct device_queue_manager *dqm,
>  				enum kfd_unmap_queues_filter filter,
> @@ -909,7 +909,7 @@ static int unregister_process(struct device_queue_manager *dqm,
>  }
>  
>  static int
> -set_pasid_vmid_mapping(struct device_queue_manager *dqm, unsigned int pasid,
> +set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
>  			unsigned int vmid)
>  {
>  	return dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> @@ -1925,8 +1925,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>  	kfree(dqm);
>  }
>  
> -int kfd_process_vm_fault(struct device_queue_manager *dqm,
> -			 unsigned int pasid)
> +int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid)
>  {
>  	struct kfd_process_device *pdd;
>  	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index a9583b95fcc1..ba2c2ce0c55a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -460,7 +460,7 @@ static void set_event_from_interrupt(struct kfd_process *p,
>  	}
>  }
>  
> -void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
> +void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>  				uint32_t valid_id_bits)
>  {
>  	struct kfd_event *ev = NULL;
> @@ -872,7 +872,7 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>  }
>  
>  #ifdef KFD_SUPPORT_IOMMU_V2
> -void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>  		unsigned long address, bool is_write_requested,
>  		bool is_execute_requested)
>  {
> @@ -950,7 +950,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
>  }
>  #endif /* KFD_SUPPORT_IOMMU_V2 */
>  
> -void kfd_signal_hw_exception_event(unsigned int pasid)
> +void kfd_signal_hw_exception_event(u32 pasid)
>  {
>  	/*
>  	 * Because we are called from arbitrary context (workqueue) as opposed
> @@ -971,7 +971,7 @@ void kfd_signal_hw_exception_event(unsigned int pasid)
>  	kfd_unref_process(p);
>  }
>  
> -void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>  				struct kfd_vm_fault_info *info)
>  {
>  	struct kfd_event *ev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> index c7ac6c73af86..c8fe5dbdad55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> @@ -79,7 +79,7 @@ struct kfd_event {
>  #define KFD_EVENT_TYPE_DEBUG 5
>  #define KFD_EVENT_TYPE_MEMORY 8
>  
> -extern void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
> -					uint32_t valid_id_bits);
> +extern void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
> +				       uint32_t valid_id_bits);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 7c8786b9eb0a..e8ef3886688b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -139,7 +139,7 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
>  }
>  
>  /* Callback for process shutdown invoked by the IOMMU driver */
> -static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
> +static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, u32 pasid)
>  {
>  	struct kfd_dev *dev = kfd_device_by_pci_dev(pdev);
>  	struct kfd_process *p;
> @@ -185,8 +185,8 @@ static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasid)
>  }
>  
>  /* This function called by IOMMU driver on PPR failure */
> -static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
> -		unsigned long address, u16 flags)
> +static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
> +				unsigned long address, u16 flags)
>  {
>  	struct kfd_dev *dev;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> index 33b08ff00b50..c19a2e6fd7c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> @@ -51,7 +51,7 @@ unsigned int kfd_get_pasid_limit(void)
>  	return 1U << pasid_bits;
>  }
>  
> -unsigned int kfd_pasid_alloc(void)
> +u32 kfd_pasid_alloc(void)
>  {
>  	int r;
>  
> @@ -77,7 +77,7 @@ unsigned int kfd_pasid_alloc(void)
>  	return r > 0 ? r : 0;
>  }
>  
> -void kfd_pasid_free(unsigned int pasid)
> +void kfd_pasid_free(u32 pasid)
>  {
>  	if (kfd2kgd)
>  		amdgpu_pasid_free(pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index fee60921fccf..09db037bb48f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -715,7 +715,7 @@ struct kfd_process {
>  	/* We want to receive a notification when the mm_struct is destroyed */
>  	struct mmu_notifier mmu_notifier;
>  
> -	uint16_t pasid;
> +	u32 pasid;
>  	unsigned int doorbell_index;
>  
>  	/*
> @@ -790,7 +790,7 @@ int kfd_process_create_wq(void);
>  void kfd_process_destroy_wq(void);
>  struct kfd_process *kfd_create_process(struct file *filep);
>  struct kfd_process *kfd_get_process(const struct task_struct *);
> -struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
>  void kfd_unref_process(struct kfd_process *p);
>  int kfd_process_evict_queues(struct kfd_process *p);
> @@ -831,8 +831,8 @@ int kfd_pasid_init(void);
>  void kfd_pasid_exit(void);
>  bool kfd_set_pasid_limit(unsigned int new_limit);
>  unsigned int kfd_get_pasid_limit(void);
> -unsigned int kfd_pasid_alloc(void);
> -void kfd_pasid_free(unsigned int pasid);
> +u32 kfd_pasid_alloc(void);
> +void kfd_pasid_free(u32 pasid);
>  
>  /* Doorbells */
>  size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
> @@ -917,7 +917,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
>  struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
>  					enum kfd_queue_type type);
>  void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
> -int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int pasid);
> +int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid);
>  
>  /* Process Queue Manager */
>  struct process_queue_node {
> @@ -1039,12 +1039,12 @@ int kfd_wait_on_events(struct kfd_process *p,
>  		       uint32_t num_events, void __user *data,
>  		       bool all, uint32_t user_timeout_ms,
>  		       uint32_t *wait_result);
> -void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
> +void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>  				uint32_t valid_id_bits);
>  void kfd_signal_iommu_event(struct kfd_dev *dev,
> -		unsigned int pasid, unsigned long address,
> -		bool is_write_requested, bool is_execute_requested);
> -void kfd_signal_hw_exception_event(unsigned int pasid);
> +			    u32 pasid, unsigned long address,
> +			    bool is_write_requested, bool is_execute_requested);
> +void kfd_signal_hw_exception_event(u32 pasid);
>  int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>  int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
>  int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
> @@ -1055,7 +1055,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>  		     uint64_t *event_page_offset, uint32_t *event_slot_index);
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>  
> -void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>  				struct kfd_vm_fault_info *info);
>  
>  void kfd_signal_reset_event(struct kfd_dev *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0e0c42e9f6a3..7567647e976d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1087,7 +1087,7 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>  }
>  
>  /* This increments the process->ref counter. */
> -struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid)
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>  {
>  	struct kfd_process *p, *ret_p = NULL;
>  	unsigned int temp;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index a3c238c39ef5..301de493377a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -226,7 +226,7 @@ struct kfd2kgd_calls {
>  			uint32_t sh_mem_config,	uint32_t sh_mem_ape1_base,
>  			uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases);
>  
> -	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, unsigned int pasid,
> +	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid);
>  
>  	int (*init_interrupts)(struct kgd_dev *kgd, uint32_t pipe_id);
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index f892992c8744..1fae58dd3c25 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -45,12 +45,12 @@ extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
>  extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
>  extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
>  extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
> -extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
> +extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
>  				u64 address);
> -extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
> -extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
> +extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
> +extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
>  				     unsigned long cr3);
> -extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid);
> +extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
>  extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_IRQ_REMAP
> @@ -66,7 +66,7 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  #define PPR_INVALID			0x1
>  #define PPR_FAILURE			0xf
>  
> -extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
> +extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
>  				  int status, int tag);
>  
>  static inline bool is_rd890_iommu(struct pci_dev *pdev)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 74cca1757172..8398a38af719 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -502,10 +502,11 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>  static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  {
>  	struct device *dev = iommu->iommu.dev;
> -	int type, devid, pasid, flags, tag;
> +	int type, devid, flags, tag;
>  	volatile u32 *event = __evt;
>  	int count = 0;
>  	u64 address;
> +	u32 pasid;
>  
>  retry:
>  	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
> @@ -898,7 +899,7 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
>  		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
>  }
>  
> -static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
> +static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
>  				  u64 address, bool size)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -916,7 +917,7 @@ static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
>  	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
>  }
>  
> -static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
> +static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
>  				  int qdep, u64 address, bool size)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -936,7 +937,7 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
>  	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
>  }
>  
> -static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, int pasid,
> +static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pasid,
>  			       int status, int tag, bool gn)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -2772,7 +2773,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
>  
> -static int __flush_pasid(struct protection_domain *domain, int pasid,
> +static int __flush_pasid(struct protection_domain *domain, u32 pasid,
>  			 u64 address, bool size)
>  {
>  	struct iommu_dev_data *dev_data;
> @@ -2833,13 +2834,13 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
>  	return ret;
>  }
>  
> -static int __amd_iommu_flush_page(struct protection_domain *domain, int pasid,
> +static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
>  				  u64 address)
>  {
>  	return __flush_pasid(domain, pasid, address, false);
>  }
>  
> -int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
> +int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
>  			 u64 address)
>  {
>  	struct protection_domain *domain = to_pdomain(dom);
> @@ -2854,13 +2855,13 @@ int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
>  }
>  EXPORT_SYMBOL(amd_iommu_flush_page);
>  
> -static int __amd_iommu_flush_tlb(struct protection_domain *domain, int pasid)
> +static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
>  {
>  	return __flush_pasid(domain, pasid, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
>  			     true);
>  }
>  
> -int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid)
> +int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
>  {
>  	struct protection_domain *domain = to_pdomain(dom);
>  	unsigned long flags;
> @@ -2874,7 +2875,7 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid)
>  }
>  EXPORT_SYMBOL(amd_iommu_flush_tlb);
>  
> -static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
> +static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
>  {
>  	int index;
>  	u64 *pte;
> @@ -2906,7 +2907,7 @@ static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
>  	return pte;
>  }
>  
> -static int __set_gcr3(struct protection_domain *domain, int pasid,
> +static int __set_gcr3(struct protection_domain *domain, u32 pasid,
>  		      unsigned long cr3)
>  {
>  	struct domain_pgtable pgtable;
> @@ -2925,7 +2926,7 @@ static int __set_gcr3(struct protection_domain *domain, int pasid,
>  	return __amd_iommu_flush_tlb(domain, pasid);
>  }
>  
> -static int __clear_gcr3(struct protection_domain *domain, int pasid)
> +static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
>  {
>  	struct domain_pgtable pgtable;
>  	u64 *pte;
> @@ -2943,7 +2944,7 @@ static int __clear_gcr3(struct protection_domain *domain, int pasid)
>  	return __amd_iommu_flush_tlb(domain, pasid);
>  }
>  
> -int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
> +int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
>  			      unsigned long cr3)
>  {
>  	struct protection_domain *domain = to_pdomain(dom);
> @@ -2958,7 +2959,7 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
>  
> -int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid)
> +int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
>  {
>  	struct protection_domain *domain = to_pdomain(dom);
>  	unsigned long flags;
> @@ -2972,7 +2973,7 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid)
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
>  
> -int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
> +int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
>  			   int status, int tag)
>  {
>  	struct iommu_dev_data *dev_data;
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index e4b025c5637c..a769985ff26e 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -40,7 +40,7 @@ struct pasid_state {
>  	struct mmu_notifier mn;                 /* mmu_notifier handle */
>  	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
>  	struct device_state *device_state;	/* Link to our device_state */
> -	int pasid;				/* PASID index */
> +	u32 pasid;				/* PASID index */
>  	bool invalid;				/* Used during setup and
>  						   teardown of the pasid */
>  	spinlock_t lock;			/* Protect pri_queues and
> @@ -70,7 +70,7 @@ struct fault {
>  	struct mm_struct *mm;
>  	u64 address;
>  	u16 devid;
> -	u16 pasid;
> +	u32 pasid;
>  	u16 tag;
>  	u16 finish;
>  	u16 flags;
> @@ -150,7 +150,7 @@ static void put_device_state(struct device_state *dev_state)
>  
>  /* Must be called under dev_state->lock */
>  static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state,
> -						  int pasid, bool alloc)
> +						  u32 pasid, bool alloc)
>  {
>  	struct pasid_state **root, **ptr;
>  	int level, index;
> @@ -184,7 +184,7 @@ static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state
>  
>  static int set_pasid_state(struct device_state *dev_state,
>  			   struct pasid_state *pasid_state,
> -			   int pasid)
> +			   u32 pasid)
>  {
>  	struct pasid_state **ptr;
>  	unsigned long flags;
> @@ -211,7 +211,7 @@ static int set_pasid_state(struct device_state *dev_state,
>  	return ret;
>  }
>  
> -static void clear_pasid_state(struct device_state *dev_state, int pasid)
> +static void clear_pasid_state(struct device_state *dev_state, u32 pasid)
>  {
>  	struct pasid_state **ptr;
>  	unsigned long flags;
> @@ -229,7 +229,7 @@ static void clear_pasid_state(struct device_state *dev_state, int pasid)
>  }
>  
>  static struct pasid_state *get_pasid_state(struct device_state *dev_state,
> -					   int pasid)
> +					   u32 pasid)
>  {
>  	struct pasid_state **ptr, *ret = NULL;
>  	unsigned long flags;
> @@ -594,7 +594,7 @@ static struct notifier_block ppr_nb = {
>  	.notifier_call = ppr_notifier,
>  };
>  
> -int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> +int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  			 struct task_struct *task)
>  {
>  	struct pasid_state *pasid_state;
> @@ -615,7 +615,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
>  		return -EINVAL;
>  
>  	ret = -EINVAL;
> -	if (pasid < 0 || pasid >= dev_state->max_pasids)
> +	if (pasid >= dev_state->max_pasids)
>  		goto out;
>  
>  	ret = -ENOMEM;
> @@ -679,7 +679,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
>  }
>  EXPORT_SYMBOL(amd_iommu_bind_pasid);
>  
> -void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
> +void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid)
>  {
>  	struct pasid_state *pasid_state;
>  	struct device_state *dev_state;
> @@ -695,7 +695,7 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
>  	if (dev_state == NULL)
>  		return;
>  
> -	if (pasid < 0 || pasid >= dev_state->max_pasids)
> +	if (pasid >= dev_state->max_pasids)
>  		goto out;
>  
>  	pasid_state = get_pasid_state(dev_state, pasid);
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 683b812c5c47..2b75a1561377 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1466,7 +1466,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  }
>  
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
> -			  u64 granu, int pasid)
> +			  u64 granu, u32 pasid)
>  {
>  	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
>  
> @@ -1780,7 +1780,7 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
>  }
>  
>  static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
> -		u8 fault_reason, int pasid, u16 source_id,
> +		u8 fault_reason, u32 pasid, u16 source_id,
>  		unsigned long long addr)
>  {
>  	const char *reason;
> @@ -1830,7 +1830,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  		u8 fault_reason;
>  		u16 source_id;
>  		u64 guest_addr;
> -		int type, pasid;
> +		u32 pasid;
> +		int type;
>  		u32 data;
>  		bool pasid_present;
>  
> diff --git a/drivers/iommu/intel/intel-pasid.h b/drivers/iommu/intel/intel-pasid.h
> index c5318d40e0fa..bb5137183145 100644
> --- a/drivers/iommu/intel/intel-pasid.h
> +++ b/drivers/iommu/intel/intel-pasid.h
> @@ -72,7 +72,7 @@ struct pasid_entry {
>  struct pasid_table {
>  	void			*table;		/* pasid table pointer */
>  	int			order;		/* page order of pasid table */
> -	int			max_pasid;	/* max pasid */
> +	u32			max_pasid;	/* max pasid */
>  	struct list_head	dev;		/* device list */
>  };
>  
> @@ -98,31 +98,31 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
>  	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
>  }
>  
> -extern u32 intel_pasid_max_id;
> +extern unsigned int intel_pasid_max_id;
>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
> -void intel_pasid_free_id(int pasid);
> -void *intel_pasid_lookup_id(int pasid);
> +void intel_pasid_free_id(u32 pasid);
> +void *intel_pasid_lookup_id(u32 pasid);
>  int intel_pasid_alloc_table(struct device *dev);
>  void intel_pasid_free_table(struct device *dev);
>  struct pasid_table *intel_pasid_get_table(struct device *dev);
>  int intel_pasid_get_dev_max_id(struct device *dev);
> -struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid);
> +struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid);
>  int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  				  struct device *dev, pgd_t *pgd,
> -				  int pasid, u16 did, int flags);
> +				  u32 pasid, u16 did, int flags);
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid);
> +				   struct device *dev, u32 pasid);
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid);
> +				   struct device *dev, u32 pasid);
>  int intel_pasid_setup_nested(struct intel_iommu *iommu,
> -			     struct device *dev, pgd_t *pgd, int pasid,
> +			     struct device *dev, pgd_t *pgd, u32 pasid,
>  			     struct iommu_gpasid_bind_data_vtd *pasid_data,
>  			     struct dmar_domain *domain, int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> -				 struct device *dev, int pasid,
> +				 struct device *dev, u32 pasid,
>  				 bool fault_ignore);
> -int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> -void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e98..7d2dbc327c62 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2475,7 +2475,7 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
>  static int domain_setup_first_level(struct intel_iommu *iommu,
>  				    struct dmar_domain *domain,
>  				    struct device *dev,
> -				    int pasid)
> +				    u32 pasid)
>  {
>  	int flags = PASID_FLAG_SUPERVISOR_MODE;
>  	struct dma_pte *pgd = domain->pgd;
> @@ -5155,7 +5155,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  		return -ENODEV;
>  
>  	if (domain->default_pasid <= 0) {
> -		int pasid;
> +		u32 pasid;
>  
>  		/* No private data needed for the default pasid */
>  		pasid = ioasid_alloc(NULL, PASID_MIN,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c81f0f17c6ba..d8637c020281 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -27,7 +27,7 @@
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id = PASID_MAX;
>  
> -int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
>  {
>  	unsigned long flags;
>  	u8 status_code;
> @@ -58,7 +58,7 @@ int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
>  	return ret;
>  }
>  
> -void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid)
>  {
>  	unsigned long flags;
>  	u8 status_code;
> @@ -146,7 +146,7 @@ int intel_pasid_alloc_table(struct device *dev)
>  	struct pasid_table *pasid_table;
>  	struct pasid_table_opaque data;
>  	struct page *pages;
> -	int max_pasid = 0;
> +	u32 max_pasid = 0;
>  	int ret, order;
>  	int size;
>  
> @@ -168,7 +168,7 @@ int intel_pasid_alloc_table(struct device *dev)
>  	INIT_LIST_HEAD(&pasid_table->dev);
>  
>  	if (info->pasid_supported)
> -		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
> +		max_pasid = min_t(u32, pci_max_pasids(to_pci_dev(dev)),
>  				  intel_pasid_max_id);
>  
>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> @@ -242,7 +242,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
>  	return info->pasid_table->max_pasid;
>  }
>  
> -struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
> +struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	struct pasid_table *pasid_table;
> @@ -251,8 +251,7 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
>  	int dir_index, index;
>  
>  	pasid_table = intel_pasid_get_table(dev);
> -	if (WARN_ON(!pasid_table || pasid < 0 ||
> -		    pasid >= intel_pasid_get_dev_max_id(dev)))
> +	if (WARN_ON(!pasid_table || pasid >= intel_pasid_get_dev_max_id(dev)))
>  		return NULL;
>  
>  	dir = pasid_table->table;
> @@ -305,7 +304,7 @@ static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
>  }
>  
>  static void
> -intel_pasid_clear_entry(struct device *dev, int pasid, bool fault_ignore)
> +intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
>  {
>  	struct pasid_entry *pe;
>  
> @@ -444,7 +443,7 @@ pasid_set_eafe(struct pasid_entry *pe)
>  
>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
> -				    u16 did, int pasid)
> +				    u16 did, u32 pasid)
>  {
>  	struct qi_desc desc;
>  
> @@ -473,7 +472,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
>  
>  static void
>  devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
> -			       struct device *dev, int pasid)
> +			       struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	u16 sid, qdep, pfsid;
> @@ -490,7 +489,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>  }
>  
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> -				 int pasid, bool fault_ignore)
> +				 u32 pasid, bool fault_ignore)
>  {
>  	struct pasid_entry *pte;
>  	u16 did;
> @@ -515,7 +514,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  
>  static void pasid_flush_caches(struct intel_iommu *iommu,
>  				struct pasid_entry *pte,
> -				int pasid, u16 did)
> +			       u32 pasid, u16 did)
>  {
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(pte, sizeof(*pte));
> @@ -534,7 +533,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
>   */
>  int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  				  struct device *dev, pgd_t *pgd,
> -				  int pasid, u16 did, int flags)
> +				  u32 pasid, u16 did, int flags)
>  {
>  	struct pasid_entry *pte;
>  
> @@ -607,7 +606,7 @@ static inline int iommu_skip_agaw(struct dmar_domain *domain,
>   */
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid)
> +				   struct device *dev, u32 pasid)
>  {
>  	struct pasid_entry *pte;
>  	struct dma_pte *pgd;
> @@ -665,7 +664,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   */
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid)
> +				   struct device *dev, u32 pasid)
>  {
>  	u16 did = FLPT_DEFAULT_DID;
>  	struct pasid_entry *pte;
> @@ -751,7 +750,7 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
>   * @addr_width: Address width of the first level (guest)
>   */
>  int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
> -			     pgd_t *gpgd, int pasid,
> +			     pgd_t *gpgd, u32 pasid,
>  			     struct iommu_gpasid_bind_data_vtd *pasid_data,
>  			     struct dmar_domain *domain, int addr_width)
>  {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..778089d198eb 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -23,7 +23,7 @@
>  #include "intel-pasid.h"
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
> -static void intel_svm_drain_prq(struct device *dev, int pasid);
> +static void intel_svm_drain_prq(struct device *dev, u32 pasid);
>  
>  #define PRQ_ORDER 0
>  
> @@ -371,7 +371,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	return ret;
>  }
>  
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
>  	struct intel_svm_dev *sdev;
> @@ -601,7 +601,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
>  }
>  
>  /* Caller must hold pasid_mutex */
> -static int intel_svm_unbind_mm(struct device *dev, int pasid)
> +static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>  {
>  	struct intel_svm_dev *sdev;
>  	struct intel_iommu *iommu;
> @@ -728,7 +728,7 @@ static bool is_canonical_address(u64 addr)
>   * described in VT-d spec CH7.10 to drain all page requests and page
>   * responses pending in the hardware.
>   */
> -static void intel_svm_drain_prq(struct device *dev, int pasid)
> +static void intel_svm_drain_prq(struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	struct dmar_domain *domain;
> @@ -988,10 +988,10 @@ void intel_svm_unbind(struct iommu_sva *sva)
>  	mutex_unlock(&pasid_mutex);
>  }
>  
> -int intel_svm_get_pasid(struct iommu_sva *sva)
> +u32 intel_svm_get_pasid(struct iommu_sva *sva)
>  {
>  	struct intel_svm_dev *sdev;
> -	int pasid;
> +	u32 pasid;
>  
>  	mutex_lock(&pasid_mutex);
>  	sdev = to_intel_svm_dev(sva);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d43120eb1dc5..56dbabdd7f5f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2828,7 +2828,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>  
> -int iommu_sva_get_pasid(struct iommu_sva *handle)
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
>  
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e77ca3..5cc6ebccba65 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -92,7 +92,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
>  
>  static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  {
> -	int pasid;
> +	u32 pasid;
>  	struct iommu_sva *handle;
>  
>  	if (!(uacce->flags & UACCE_DEV_SVA))
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 21e950e4ab62..450717299928 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -76,7 +76,7 @@ extern void amd_iommu_free_device(struct pci_dev *pdev);
>   *
>   * The function returns 0 on success or a negative value on error.
>   */
> -extern int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> +extern int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  				struct task_struct *task);
>  
>  /**
> @@ -88,7 +88,7 @@ extern int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
>   * When this function returns the device is no longer using the PASID
>   * and the PASID is no longer bound to its task.
>   */
> -extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid);
> +extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid);
>  
>  /**
>   * amd_iommu_set_invalid_ppr_cb() - Register a call-back for failed
> @@ -114,7 +114,7 @@ extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid);
>  #define AMD_IOMMU_INV_PRI_RSP_FAIL	2
>  
>  typedef int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev,
> -					int pasid,
> +					u32 pasid,
>  					unsigned long address,
>  					u16);
>  
> @@ -166,7 +166,7 @@ extern int amd_iommu_device_info(struct pci_dev *pdev,
>   * @cb: The call-back function
>   */
>  
> -typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid);
> +typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, u32 pasid);
>  
>  extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
>  					   amd_iommu_invalidate_ctx cb);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3e8fa1c7a1e6..643951e28dd4 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -550,7 +550,7 @@ struct dmar_domain {
>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
>  
> -	int		default_pasid;	/*
> +	u32		default_pasid;	/*
>  					 * The default pasid used for non-SVM
>  					 * traffic on mediated devices.
>  					 */
> @@ -707,7 +707,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			      u32 pasid, u16 qdep, u64 addr,
>  			      unsigned int size_order, u64 granu);
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
> -			  int pasid);
> +			  u32 pasid);
>  
>  int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>  		   unsigned int count, unsigned long options);
> @@ -735,11 +735,11 @@ extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			  struct iommu_gpasid_bind_data *data);
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid);
> +int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
>  				 void *drvdata);
>  void intel_svm_unbind(struct iommu_sva *handle);
> -int intel_svm_get_pasid(struct iommu_sva *handle);
> +u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  struct svm_dev_ops;
>  
>  struct intel_svm_dev {
> @@ -748,7 +748,7 @@ struct intel_svm_dev {
>  	struct device *dev;
>  	struct svm_dev_ops *ops;
>  	struct iommu_sva sva;
> -	int pasid;
> +	u32 pasid;
>  	int users;
>  	u16 did;
>  	u16 dev_iotlb:1;
> @@ -761,7 +761,7 @@ struct intel_svm {
>  
>  	struct intel_iommu *iommu;
>  	int flags;
> -	int pasid;
> +	u32 pasid;
>  	int gpasid; /* In case that guest PASID is different from host PASID */
>  	struct list_head devs;
>  	struct list_head list;
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index c9e7e601950d..39d368a810b8 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -11,7 +11,7 @@
>  struct device;
>  
>  struct svm_dev_ops {
> -	void (*fault_cb)(struct device *dev, int pasid, u64 address,
> +	void (*fault_cb)(struct device *dev, u32 pasid, u64 address,
>  			 void *private, int rwxp, int response);
>  };
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..9188ec5b39c5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -292,7 +292,7 @@ struct iommu_ops {
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
> -	int (*sva_get_pasid)(struct iommu_sva *handle);
> +	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>  
>  	int (*page_response)(struct device *dev,
>  			     struct iommu_fault_event *evt,
> @@ -302,7 +302,7 @@ struct iommu_ops {
>  	int (*sva_bind_gpasid)(struct iommu_domain *domain,
>  			struct device *dev, struct iommu_gpasid_bind_data *data);
>  
> -	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> +	int (*sva_unbind_gpasid)(struct device *dev, u32 pasid);
>  
>  	int (*def_domain_type)(struct device *dev);
>  
> @@ -656,7 +656,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm,
>  					void *drvdata);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
> -int iommu_sva_get_pasid(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>  
>  #else /* CONFIG_IOMMU_API */
>  
> @@ -1049,7 +1049,7 @@ static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
>  {
>  }
>  
> -static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	return IOMMU_PASID_INVALID;
>  }
> @@ -1068,7 +1068,7 @@ static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
>  }
>  
>  static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +					   struct device *dev, u32 pasid)
>  {
>  	return -ENODEV;
>  }
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 454c2f6672d7..48e319f40275 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -81,7 +81,7 @@ struct uacce_queue {
>  	struct list_head list;
>  	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
>  	enum uacce_q_state state;
> -	int pasid;
> +	u32 pasid;
>  	struct iommu_sva *handle;
>  };
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
