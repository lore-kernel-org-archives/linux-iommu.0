Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2949C388F9
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 03:15:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168AD20757
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 03:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168AD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85E4A868A5;
	Mon,  9 Nov 2020 03:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-XAMN4K30nZ; Mon,  9 Nov 2020 03:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7AB6F86813;
	Mon,  9 Nov 2020 03:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F65C088B;
	Mon,  9 Nov 2020 03:15:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDE1DC016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 03:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6CFF20414
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 03:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AjnJm3ngE7-G for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 03:15:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 136E820410
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 03:15:18 +0000 (UTC)
IronPort-SDR: KqBbfAOouuX9wXulEmU6DfE4uhYs5E2skgiTGbrJ+ZUH5zOimqeM06QvzSNWWQAoPWnYdjOVF+
 2CQOSWvW9Vhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="187688710"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; d="scan'208";a="187688710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2020 19:15:17 -0800
IronPort-SDR: BQ6faZthxtz9NEKFYN02lfH9pzHFOpSiZswcFpSFStqw/05RK49JnfwRcpUnepgs1gl8CKXjiw
 SD4plW6brfuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; d="scan'208";a="427854948"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2020 19:15:14 -0800
Subject: Re: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in
 tboot
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
 <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
Date: Mon, 9 Nov 2020 11:08:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
Content-Language: en-US
Cc: jroedel@suse.de, x86@kernel.org, iommu@lists.linux-foundation.org,
 ning.sun@intel.com, tboot-devel@lists.sourceforge.net,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Zhenzhong,

On 11/9/20 10:27 AM, Zhenzhong Duan wrote:
> +intel iommu maintainers,
> 
> Can anyone help review this patch? Thanks
> 
> Zhenzhong
> 
> On Wed, Nov 4, 2020 at 4:15 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>>
>> "intel_iommu=off" command line is used to disable iommu and iommu is force
>> enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
>> could be used to force disable iommu in tboot for better performance.
>>
>> By default kernel should panic if iommu init fail in tboot for security
>> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
>>
>> Fix it by return 0 in tboot_force_iommu() so that force_on is not set.
>>
>> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
>> ---
>>   arch/x86/kernel/tboot.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
>> index 992fb1415c0f..9fd4d162b331 100644
>> --- a/arch/x86/kernel/tboot.c
>> +++ b/arch/x86/kernel/tboot.c
>> @@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>>
>>   int tboot_force_iommu(void)
>>   {
>> -       if (!tboot_enabled())
>> +       if (!tboot_enabled() || intel_iommu_tboot_noforce)
>>                  return 0;
>>
>> -       if (intel_iommu_tboot_noforce)
>> -               return 1;

This was obviously wrong. It should return false, right?

It looks odd that intel_iommu_tboot_noforce is defined in Intel iommu
implementation, but is used here. How about moving it back to the iommu
driver?

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb1415c0f..420be871d9d4 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,9 +514,6 @@ int tboot_force_iommu(void)
         if (!tboot_enabled())
                 return 0;

-       if (intel_iommu_tboot_noforce)
-               return 1;
-
         if (no_iommu || swiotlb || dmar_disabled)
                 pr_warn("Forcing Intel-IOMMU to enabled\n");

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a41f9f13cc86..ba90eb4325d0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -179,7 +179,7 @@ static int rwbf_quirk;
   * (used when kernel is launched w/ TXT)
   */
  static int force_on = 0;
-int intel_iommu_tboot_noforce;
+static int intel_iommu_tboot_noforce;
  static int no_platform_optin;

  #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -4212,7 +4212,8 @@ int __init intel_iommu_init(void)
          * Intel IOMMU is required for a TXT/tboot launch or platform
          * opt in, so enforce that.
          */
-       force_on = tboot_force_iommu() || platform_optin_force_iommu();
+       force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
+                       platform_optin_force_iommu();

         if (iommu_init_mempool()) {
                 if (force_on)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fbf5b3e7707e..d956987ed032 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -798,7 +798,6 @@ extern int iommu_calculate_agaw(struct intel_iommu 
*iommu);
  extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
  extern int dmar_disabled;
  extern int intel_iommu_enabled;
-extern int intel_iommu_tboot_noforce;
  extern int intel_iommu_gfx_mapped;
  #else
  static inline int iommu_calculate_agaw(struct intel_iommu *iommu)

>> -
>>          if (no_iommu || swiotlb || dmar_disabled)
>>                  pr_warn("Forcing Intel-IOMMU to enabled\n");
>>
>> --
>> 2.25.1
>>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
