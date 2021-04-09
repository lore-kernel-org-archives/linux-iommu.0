Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21219C433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 17:06:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5EC610CF
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 17:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5EC610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85F5C83F4F;
	Fri,  9 Apr 2021 17:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrtOyCg4q73A; Fri,  9 Apr 2021 17:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E5FA83F52;
	Fri,  9 Apr 2021 17:06:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB9A2C000B;
	Fri,  9 Apr 2021 17:06:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C818EC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1A47607A5
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nda0mcPEHDdk for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 17:06:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78C40605E8
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 17:06:24 +0000 (UTC)
Received: by mail-io1-xd29.google.com with SMTP id x16so6645428iob.1
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ckuQKqYSNgY7eF5IEy/O9xqtXaRMqkkILp0uvz39yLw=;
 b=DEFRRBW7mUM0LwIC914tb1EnBOQjQOWcSoOpU0+RNeVf1rMBJ6apYAbKymvAtXEWOK
 pky1YZirx1+TImTY8pDc8zgciCwiRk76ZgOy81myto3FOf1NwLWAMpDzi3xAhk72VLg2
 TJBNtnN5ubOP44umFdm52CT7GInzWukLU4WsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ckuQKqYSNgY7eF5IEy/O9xqtXaRMqkkILp0uvz39yLw=;
 b=Zp2/trKcoBbVNXc9rseoJpqS6v054+Ypl5NaKkEpCTFjUrqP6RvitAfBzmVxLvRkdC
 O4ptfH2dNAc/IQ3G+eH7nw156ZYys375ltn+KdTh5hLy9H1tTgW6jIyjNsmbIYtOPgHb
 d1dn8uZfZN6xD8jXQR4Bi1LcIBXn7iOWB3Oxe+3NkLKXBiMCz6XWSBV3eSIRTwm7yQRY
 icPsW+tJsTC75Dvp9dAj+NiXR5kn08hq96v/76goMwq+88aoq9YENc11uq51rSYDfpkX
 2Lw0m7aqxAcYkerK4p+Hl665HDy0fhBb6Ra0GJALxpONKEvZOGKLlGuxxYCoS8SifNzg
 sFnw==
X-Gm-Message-State: AOAM532s9w6N4ZGcdZlB9Y4wthdtZLSypKrKsKU6r0vf7F3N1mrUEruy
 LKojgMU91O52iw4bKV2JMeENvcej
X-Google-Smtp-Source: ABdhPJyijYXlk1P49PEEb/iVM02dNCqi2XwX7HAn08GrYbt0mqY0L69S3e7RupJ8rCwxzY4jxxNmtQ==
X-Received: by 2002:a05:6638:381c:: with SMTP id
 i28mr15333884jav.60.1617987983281; 
 Fri, 09 Apr 2021 10:06:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id s15sm1391221ilv.13.2021.04.09.10.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 10:06:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] Revert "iommu/amd: Fix performance counter
 initialization"
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f156768c-37fd-a4e8-3959-a5bc5dae918c@linuxfoundation.org>
Date: Fri, 9 Apr 2021 11:06:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-2-suravee.suthikulpanit@amd.com>
Content-Language: en-US
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> This reverts commit 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b.
> 
> The original commit tries to address an issue, where PMC power-gating
> causing the IOMMU PMC pre-init test to fail on certain desktop/mobile
> platforms where the power-gating is normally enabled.
> 
> There have been several reports that the workaround still does not
> guarantee to work, and can add up to 100 ms (on the worst case)
> to the boot process on certain platforms such as the MSI B350M MORTAR
> with AMD Ryzen 3 2200G.
> 
> Therefore, revert this commit as a prelude to removing the pre-init
> test.
> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Note: I have revised the commit message to add more detail
>        and remove uncessary information.
> 
>   drivers/iommu/amd/init.c | 45 ++++++++++------------------------------
>   1 file changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 321f5906e6ed..648cdfd03074 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -12,7 +12,6 @@
>   #include <linux/acpi.h>
>   #include <linux/list.h>
>   #include <linux/bitmap.h>
> -#include <linux/delay.h>
>   #include <linux/slab.h>
>   #include <linux/syscore_ops.h>
>   #include <linux/interrupt.h>
> @@ -257,8 +256,6 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
>   static int amd_iommu_enable_interrupts(void);
>   static int __init iommu_go_to_state(enum iommu_init_state state);
>   static void init_device_table_dma(void);
> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value, bool is_write);
>   
>   static bool amd_iommu_pre_enabled = true;
>   
> @@ -1717,11 +1714,13 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>   	return 0;
>   }
>   
> -static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
> +static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> +				u8 fxn, u64 *value, bool is_write);
> +
> +static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
> -	int retry;
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
> +	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
> @@ -1729,39 +1728,17 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
>   	amd_iommu_pc_present = true;
>   
>   	/* save the value to restore, if writable */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
> -	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
> -		goto pc_false;
> -
> -	/*
> -	 * Disable power gating by programing the performance counter
> -	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
> -	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
> -	 * which never get incremented during this init phase.
> -	 * (Note: The event is also deprecated.)
> -	 */
> -	val = 20;
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
>   		goto pc_false;
>   
>   	/* Check if the performance counters can be written to */
> -	val = 0xabcd;
> -	for (retry = 5; retry; retry--) {
> -		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
> -		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
> -		    val2)
> -			break;
> -
> -		/* Wait about 20 msec for power gating to disable and retry. */
> -		msleep(20);
> -	}
> -
> -	/* restore */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
> -	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
> +	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> +	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> +	    (val != val2))

Probably don't need parentheses around 'val != val2'

>   		goto pc_false;
>   
> -	if (val != val2)
> +	/* restore */
> +	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
>   		goto pc_false;
>   
>   	pci_info(pdev, "IOMMU performance counters supported\n");
> 

thanks,
-- Shuah
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
