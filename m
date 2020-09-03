Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD8C433E2
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 00:36:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73835206EB
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgcnAVz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73835206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 430E286B8D;
	Thu,  3 Sep 2020 00:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UyLqZoHDI3_B; Thu,  3 Sep 2020 00:36:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7005F86B8A;
	Thu,  3 Sep 2020 00:36:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F6EEC07FF;
	Thu,  3 Sep 2020 00:36:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3329AC0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 00:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 228AB86AEE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 00:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5W8HwrMT-wtG for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 00:36:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6E7AA86AED
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 00:36:35 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id k15so610908pji.3
 for <iommu@lists.linux-foundation.org>; Wed, 02 Sep 2020 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HGMI5u4+l1Tf8c3EflpFySIPH+tLFZrWho9A072B+v0=;
 b=qgcnAVz2b4GXO/VBcwehnbBCJoiAynRLxeE3+nye4S4BoYiqiqTXyMoS3G6dTjEKQf
 284LZRFd8PY6eYGp7XuTedUOp7736rLJ/+V6O5AktcwvdCP1c39H+PPC99bdJz73T9CF
 1R9ZxkolF4OVEUqGU7omTvZ2PfnI1OB/JFANYAiIHhkJvNZl4bW6LLnpH08Gc3j5kl6o
 DSfSCPldBfiTSR6BnmyRijG0Q90cnMTDeW0Xv0E4ZAuHhneO9TtBoBhMLmuX2g3EQxy+
 6yXIdNa6tIDgHuR/6vSX1krPHhQqIWZtk8NLORXxahxAqxdwk9OJxiYrP+nQqPwDpBgY
 4RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HGMI5u4+l1Tf8c3EflpFySIPH+tLFZrWho9A072B+v0=;
 b=PJpCWYT/4dG/b3fL+JnpVWJ93o/Kv3aBpQbC3kWhjhDkv/Eu934KU3QCB6i3pY3ojn
 Cc9iFbfKSbFJvpaOGzXd4pY6Zz1XTlb/dPhIG41K6smsM9080AZfnOGVmTHFrZSk/Hy2
 7zgtmlwtknYGkiKKve8sBX8KE7wxkKpJ7ybUlGHqSYtFocH2xFD+mh6HZkeS+VrISDia
 /9eI35i1xHtjxhrffIYN5I8JASmCpg0AUCRyk2IjsMNBoQTso2b1mps+WgukpKjg4iOh
 ZMaaiN6P9NajJAgGhEwjqpxXl4qKK/Its9yha7T05E/OwaA/xicumMWoMw9Fpnr4a8tl
 QPqw==
X-Gm-Message-State: AOAM533sLKg3CxoJhClL7zAHAyuKpl08l6itd5SAe2QpSOElOPRAgAYw
 5sYjTpuQ8KvkrndyNMwcoDs=
X-Google-Smtp-Source: ABdhPJzcRRxLsfp4XqFjuW94MrfAQ6bEtGHcjZM+ap6oC7YZYhrZlOWHN8FProfCj+k0eWx0IzfuiA==
X-Received: by 2002:a17:90b:408b:: with SMTP id
 jb11mr389883pjb.164.1599093394840; 
 Wed, 02 Sep 2020 17:36:34 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q127sm740851pfb.61.2020.09.02.17.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 17:36:33 -0700 (PDT)
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Nathan Chancellor <natechancellor@gmail.com>,
 Jim Quinlan <james.quinlan@broadcom.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200902215314.GA881878@ubuntu-n2-xlarge-x86>
 <CA+-6iNzc38OAL7TGxobpODKXOD1CW-VFNU0rK9Z043QfR3MfsQ@mail.gmail.com>
 <20200902223852.GA1786990@ubuntu-n2-xlarge-x86>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6922bc0b-1849-2f2f-ec2f-fe9f0124dcfc@gmail.com>
Date: Wed, 2 Sep 2020 17:36:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200902223852.GA1786990@ubuntu-n2-xlarge-x86>
Content-Language: en-US
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 ACPI/arm64" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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



On 9/2/2020 3:38 PM, Nathan Chancellor wrote:
[snip]
>> Hello Nathan,
>>
>> Can you tell me how much memory your RPI has and if all of it is
> 
> This is the 4GB version.
> 
>> accessible by the PCIe device?  Could you also please include the DTS
>> of the PCIe node?  IIRC, the RPI firmware does some mangling of the
>> PCIe DT before Linux boots -- could you describe what is going on
>> there?
> 
> Unfortunately, I am not familiar with how to get this information. If
> you could provide some instructions for how to do so, I am more than
> happy to. I am not very knowleagable about the inner working of the Pi,
> I mainly use it as a test platform for making sure that LLVM does not
> cause problems on real devices.

Can you bring the dtc application to your Pi root filesystem, and if so, 
can you run the following:

dtc -I fs -O dtb /proc/device-tree -f > /tmp/device.dtb

or cat /sys/firmware/fdt > device.dtb

and attach the resulting file?

> 
>> Finally, can you attach the text of the full boot log?
> 
> I have attached a working and broken boot log. Thank you for the quick
> response!

Is it possible for you to rebuild your kernel with CONFIG_MMC_DEBUG by 
any chance?

I have a suspicion that this part of the DTS for the bcm2711.dtsi 
platform is at fault:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/bcm2711.dtsi#n264

and the resulting dma-ranges parsing is just not working for reasons to 
be determined.
--
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
