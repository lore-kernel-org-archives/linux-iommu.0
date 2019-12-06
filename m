Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB687C2D0B1
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 05:59:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EE824676
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 05:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EE824676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 73845204C6;
	Fri,  6 Dec 2019 05:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvyaQ6hTquzf; Fri,  6 Dec 2019 05:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F1C1F2033B;
	Fri,  6 Dec 2019 05:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAD2EC1D7C;
	Fri,  6 Dec 2019 05:59:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C451CC077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BF94688902
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JOrF4SJFLeVS for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 05:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 684D4888EB
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 05:59:21 +0000 (UTC)
Received: from mail-pg1-f198.google.com ([209.85.215.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1id6e7-0005VS-MA
 for iommu@lists.linux-foundation.org; Fri, 06 Dec 2019 05:59:19 +0000
Received: by mail-pg1-f198.google.com with SMTP id a4so3166836pgq.23
 for <iommu@lists.linux-foundation.org>; Thu, 05 Dec 2019 21:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=+2mKgHzfaWeOqhosxhoRTKR9TD87JVY8kGwmLWgEhAc=;
 b=Iu70kGPTxqLVbM2Gn0YEnxWAehBic301sudUnnhFikdvyEjZK8nF14f6CzCA8Q9z+X
 bTdjmmi2ha14Pu/5Q5Nu0Gvpnd/S5Cffa1+W63Foc2Jv8yuhi34Z6GxLTq1aRR7GH15b
 GLylxqr0u5uDEBdn9H+ygl7pk9AF6YnM9AOW5/eiFkPX0OvWbCmW0ll8IS+JIuGEwY3C
 cEJTXL3QeHz9QGpbJMSiycqkrCmpGXCCiFz7LQEc7Pleu5XV89ypWrxHKFViLcaNxHN4
 OCnnlx1cTUNxqgNZCAVu77FL4yKSKZ+ZanOJ4whY+5PPBPbj62C0J4t7yn1594RPEje7
 O7bw==
X-Gm-Message-State: APjAAAVqiAZtQBTk5FgTsgaXTtspvywGpT9TIdb1AoUncj6Okh57x+9V
 pvs8CBgvRsnt1IpZxVR6kTZEJWTflggHEDKP2AMHDn6L1M3uBQ+R1mS27tNyXM3UpKv3bzQ7xgc
 C9D6jxW17AXQNHMLmHXPc45e2+1yFgv5uQs1DaWjC1gOENLc=
X-Received: by 2002:a17:902:fe12:: with SMTP id
 g18mr12934603plj.20.1575611958301; 
 Thu, 05 Dec 2019 21:59:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFp7Q8nML4iKGezxNzXym94RYC3uR23DeMZAj4myq3biuBjjbGqoM2K7pXjPUXX+WdR7GiKg==
X-Received: by 2002:a17:902:fe12:: with SMTP id
 g18mr12934587plj.20.1575611957951; 
 Thu, 05 Dec 2019 21:59:17 -0800 (PST)
Received: from 2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net
 (2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net.
 [2001:b011:380f:3c42:d14c:a8f0:9761:234f])
 by smtp.gmail.com with ESMTPSA id d13sm1586857pjx.21.2019.12.05.21.59.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:59:17 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
Date: Fri, 6 Dec 2019 13:59:15 +0800
Message-Id: <F7EB73FE-F902-4548-B1FD-29D78AA4A694@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
 <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
 <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
To: "Deucher, Alexander" <alexander.deucher@amd.com>
X-Mailer: Apple Mail (2.3601.0.10)
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> On Dec 5, 2019, at 00:08, Deucher, Alexander <alexander.deucher@amd.com> wrote:
> 
>> -----Original Message-----
>> From: Deucher, Alexander
>> Sent: Monday, December 2, 2019 11:37 AM
>> To: Lucas Stach <dev@lynxeye.de>; Kai-Heng Feng
>> <kai.heng.feng@canonical.com>; joro@8bytes.org; Koenig, Christian
>> (Christian.Koenig@amd.com) <Christian.Koenig@amd.com>
>> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>> systems
>> 
>>> -----Original Message-----
>>> From: Lucas Stach <dev@lynxeye.de>
>>> Sent: Sunday, December 1, 2019 7:43 AM
>>> To: Kai-Heng Feng <kai.heng.feng@canonical.com>; joro@8bytes.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>>> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
>>> systems
>>> 
>>> Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
>>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>>>> 
>>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
>>>> do the same here to avoid screen flickering on 4K monitor.
>>> 
>>> This doesn't seem like a good solution, especially if there isn't a
>>> method for the user to opt-out.  Some users might prefer having the
>>> IOMMU support to 4K display output.
>>> 
>>> But before using the big hammer of disabling or breaking one of those
>>> features, we should take a look at what's the issue here. Screen
>>> flickering caused by the IOMMU being active hints to the IOMMU not
>>> being able to sustain the translation bandwidth required by the high-
>>> bandwidth isochronous transfers caused by 4K scanout, most likely due
>>> to insufficient TLB space.
>>> 
>>> As far as I know the framebuffer memory for the display buffers is
>>> located in stolen RAM, and thus contigous in memory. I don't know the
>>> details of the GPU integration on those APUs, but maybe there even is
>>> a way to bypass the IOMMU for the stolen VRAM regions?
>>> 
>>> If there isn't and all GPU traffic passes through the IOMMU when
>>> active, we should check if the stolen RAM is mapped with hugepages on
>>> the IOMMU side. All the stolen RAM can most likely be mapped with a
>>> few hugepage mappings, which should reduce IOMMU TLB demand by a
>> large margin.
>> 
>> The is no issue when we scan out of the carve out region.  The issue occurs
>> when we scan out of regular system memory (scatter/gather).  Many newer
>> laptops have very small carve out regions (e.g., 32 MB), so we have to use
>> regular system pages to support multiple high resolution displays.  The
>> problem is, the latency gets too high at some point when the IOMMU is
>> involved.  Huge pages would probably help in this case, but I'm not sure if
>> there is any way to guarantee that we get huge pages for system memory.  I
>> guess we could use CMA or something like that.
> 
> Thomas recently sent out a patch set to add huge page support to ttm:
> https://patchwork.freedesktop.org/series/70090/
> We'd still need a way to guarantee huge pages for the display buffer.

Is there an amdgpu counterpart to let me test out?

Kai-Heng

> 
> Alex
> 
>> 
>> Alex
>> 
>>> 
>>> Regards,
>>> Lucas
>>> 
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Bug:
>>>> 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
>>>> tl
>>>> 
>>> 
>> ab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=02%7C01%
>>> 7Calexa
>>>> 
>>> 
>> nder.deucher%40amd.com%7C30540b2bf2be417c4d9508d7765bf07f%7C3dd
>>> 8961fe4
>>>> 
>>> 
>> 884e608e11a82d994e183d%7C0%7C0%7C637108010075463266&amp;sdata=1
>>> ZIZUWos
>>>> cPiB4auOY10jlGzoFeWszYMDBQG0CtrrOO8%3D&amp;reserved=0
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> v2:
>>>> - Find Stoney graphics instead of host bridge.
>>>> 
>>>> drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
>>>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/iommu/amd_iommu_init.c
>>>> b/drivers/iommu/amd_iommu_init.c index 568c52317757..139aa6fdadda
>>>> 100644
>>>> --- a/drivers/iommu/amd_iommu_init.c
>>>> +++ b/drivers/iommu/amd_iommu_init.c
>>>> @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
>>>> 	struct acpi_table_header *ivrs_base;
>>>> 	acpi_status status;
>>>> 	int i, remap_cache_sz, ret = 0;
>>>> +	u32 pci_id;
>>>> 
>>>> 	if (!amd_iommu_detected)
>>>> 		return -ENODEV;
>>>> @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
>>>> 	if (ret)
>>>> 		goto out;
>>>> 
>>>> +	/* Disable IOMMU if there's Stoney Ridge graphics */
>>>> +	for (i = 0; i < 32; i++) {
>>>> +		pci_id = read_pci_config(0, i, 0, 0);
>>>> +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
>>>> +			pr_info("Disable IOMMU on Stoney Ridge\n");
>>>> +			amd_iommu_disabled = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> 	/* Disable any previously enabled IOMMUs */
>>>> 	if (!is_kdump_kernel() || amd_iommu_disabled)
>>>> 		disable_iommus();
>>>> @@ -2711,7 +2722,7 @@ static int __init state_next(void)
>>>> 		ret = early_amd_iommu_init();
>>>> 		init_state = ret ? IOMMU_INIT_ERROR :
>>> IOMMU_ACPI_FINISHED;
>>>> 		if (init_state == IOMMU_ACPI_FINISHED &&
>>> amd_iommu_disabled) {
>>>> -			pr_info("AMD IOMMU disabled on kernel command-
>>> line\n");
>>>> +			pr_info("AMD IOMMU disabled\n");
>>>> 			init_state = IOMMU_CMDLINE_DISABLED;
>>>> 			ret = -EINVAL;
>>>> 		}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
