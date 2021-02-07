Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5196C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 17:18:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B4164DD6
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 17:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B4164DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elloe.vision
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 49ED720468;
	Sun,  7 Feb 2021 17:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h7JB8n+ah4mL; Sun,  7 Feb 2021 17:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 024052040C;
	Sun,  7 Feb 2021 17:18:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9731C0891;
	Sun,  7 Feb 2021 17:18:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42F7FC013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 17:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 362FF20468
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 17:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SIS07HQYsgcV for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 17:18:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from iam.tj (yes.iam.tj [109.74.197.121])
 by silver.osuosl.org (Postfix) with ESMTPS id 0CE1D2040C
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 17:18:27 +0000 (UTC)
Received: from [IPv6:2a02:8011:2007:0:4e8f:8e4c:119:9fc0] (unknown
 [IPv6:2a02:8011:2007:0:4e8f:8e4c:119:9fc0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by iam.tj (Postfix) with ESMTPSA id B83F8340F6;
 Sun,  7 Feb 2021 17:18:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=elloe.vision; s=2019;
 t=1612718304; bh=u7HdxutiPNdo/lJoPH7zdPYNiJzP3tzNBtvacn+YfGM=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=qlstQaKoOWhDaRpLY1Y5QzCGlMx51c7774Zj6iI44AwYo9JlpP+b9Js9+pmHqTQwJ
 HItb09X9eOsAthHp3Ti21geLr+zl713JYTlm52wfYfyEtwFE65oEm39CWtW6EeUKmY
 zQge0SJx7uxHJNuLCQQnfPVbKKCgmYa66UPGcnA9UotWMFDuA6pPSCmvDkRFC04xgo
 JU6LHxH/MTV9+1+LgXWeCFH8C6LT8VEX0nT5gsLqguTONuDkBQYnqHS0yJg0H0lDCU
 5GeCyCycQU52Myc1LDvtn1XStfFoebEEED5KF+br/brl4g+x2foGPifkXzxNdaGqWG
 7wotktZDBnsGA==
Subject: Re: AMD-Vi: Unable to read/write to IOMMU perf counter
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux-foundation.org
References: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
 <9ebcadaa-301d-2b59-04ae-be9a243c7ac0@amd.com>
 <00a54bdc-6495-d43f-744c-0df269e5d3d6@elloe.vision>
 <e868f04e-7754-310d-aafe-b8ad926359d7@amd.com>
From: "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Organization: Elloe CIC
Message-ID: <a64f18be-7bf9-f355-0960-6322c1f8e3f8@elloe.vision>
Date: Sun, 7 Feb 2021 17:18:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e868f04e-7754-310d-aafe-b8ad926359d7@amd.com>
Content-Language: en-GB
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

On 06/02/2021 04:02, Suravee Suthikulpanit wrote:
> Tj,
> 
> I have posted RFCv3 in the BZ
> https://bugzilla.kernel.org/show_bug.cgi?id=201753.
> 
> RFCv3 patch adds the logic to retry checking after 20msec wait for each
> retry loop since I have founded that certain platform takes about 10msec
> for the power gating to disable.

Added on top of commit 825b5991a46e.

kernel: Linux version 5.11.0-rc6+ (tj@elloe000) (gcc (Ubuntu
9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #18
SMP PREEMPT Sun Feb 7 15:58:14 GMT 2021
kernel: Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc6+
root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
systemd.unified_cgroup_hierarchy=1 nosplash
...
kernel: DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
...
kernel: AMD-Vi: ivrs, add hid:PNPD0040, uid:, rdevid:152
...
kernel: Freeing initrd memory: 37592K
kernel: pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
kernel: pci 0000:00:00.2: can't derive routing for PCI INT A
kernel: pci 0000:00:00.2: PCI INT A: not connected
...
kernel: pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
kernel: pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
kernel:  PPR NX GT IA GA PC GA_vAPIC
kernel: AMD-Vi: Interrupt remapping enabled
kernel: AMD-Vi: Virtual APIC enabled
kernel: AMD-Vi: Lazy IO/TLB flushing enabled
...

Looks to have solved the:

kernel: AMD-Vi: Unable to read/write to IOMMU perf counter.

Would this be in any way related to the following from the same device:

kernel: pci 0000:00:00.2: can't derive routing for PCI INT A
kernel: pci 0000:00:00.2: PCI INT A: not connected


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
