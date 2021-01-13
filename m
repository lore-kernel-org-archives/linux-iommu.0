Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F23C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 04:41:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82C823131
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 04:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82C823131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2CBE985B7C;
	Wed, 13 Jan 2021 04:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eYwtXKE+205A; Wed, 13 Jan 2021 04:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23D978503D;
	Wed, 13 Jan 2021 04:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA3FCC0893;
	Wed, 13 Jan 2021 04:41:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 078FFC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E5CBE203EE
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCYYRdQFTU41 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 04:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by silver.osuosl.org (Postfix) with ESMTPS id 1E8BE203C4
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:41:43 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id n10so688592pgl.10
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KvQ2yMS8fLkXK342PvW0uslM8ZlXd39fo1Po12xDqaQ=;
 b=avdfFgTkaBibOVpcEf2XR+8TzRftglYeCpXQi8+D1HMwpIOkD7NkRtIUsc8mUk0s2Z
 uB+NCl2ETqVqZu0HEWsAPxXGOJfklLqHqylL8JLnPkGURCT0Rr91r3d22C9ChX+4xOUa
 0+/zxN+7tE3QoOiYsE/ZQ/wPF/VA588kdPh0Ougg38W4Cv/AoTVa0JYnRMmr2WARDcHl
 v8fvvCq6DsKX5OdSGhN1HNKIz8q3cbU17isYsDfTtguubxnD10O9uu6ccz3Y/qgusZpl
 Cud+aVxghpfL6SrKtq34b4bAKNxgGqnLbGXPQtA6+DGdpIMhLyHHFSzJVWpdKkBqK0hF
 2NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KvQ2yMS8fLkXK342PvW0uslM8ZlXd39fo1Po12xDqaQ=;
 b=eO0iPc14tFMuWt9l7ipENHmGYCArNZUfkuR0TXVroyzXo1VuAbjBmm2K14IObBk3pJ
 YnSPectqx016joQvAfiabf79c1nPsYnUX+LXc7usYSzD6mnDg6WiAC+1miCPHMR1LY4X
 g0U1vs+yAavmzPC9VEoqx/KAKwDP3gvYK8sAF156vXFbQDdxOghHWh4YxiuoJ4Q9nU/4
 PPf8soPjwMp6IzI0FfXamh3HWE9B5VVRu/UG+7uZej+/3jFLhVS9KM7UUcLeDoZ8K/4r
 F1gHyQno5LRAN4cZBwWrUrWPV/YwZze5GoXVujbg1+mCMnfUOMiUOYHKqKZ0fwAbOlfw
 wbbw==
X-Gm-Message-State: AOAM533pzjyX4YACYRfej8EzLEBU1AHTR8dYtc2sYPf9tLpJPmKp0rpM
 eo8VgZefIdIui2WriO0Li/4=
X-Google-Smtp-Source: ABdhPJx2iI7J7lxafaYbeUXbTz84477oydmyZRD61uJyjC45YSxKcvn04KDiXDcVGjLQgp6TP7cnLg==
X-Received: by 2002:a63:e108:: with SMTP id z8mr315659pgh.363.1610512902499;
 Tue, 12 Jan 2021 20:41:42 -0800 (PST)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net.
 [99.44.17.11])
 by smtp.gmail.com with ESMTPSA id 6sm769816pfj.216.2021.01.12.20.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 20:41:41 -0800 (PST)
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To: Tomasz Figa <tfiga@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
 <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
 <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
 <c7f7941d-b8bd-f0f3-4e40-b899a77188bf@gmail.com>
 <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7fe99ad2-79a7-9c8b-65ce-ce8353e9d9bf@gmail.com>
Date: Tue, 12 Jan 2021 20:41:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
Content-Language: en-US
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 xypron.glpk@gmx.de, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Claire Chang <tientzu@chromium.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, mpe@ellerman.id.au,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 1/12/2021 8:25 PM, Tomasz Figa wrote:
> On Wed, Jan 13, 2021 at 12:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 1/12/2021 6:29 PM, Tomasz Figa wrote:
>>> Hi Florian,
>>>
>>> On Wed, Jan 13, 2021 at 3:01 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> On 1/11/21 11:48 PM, Claire Chang wrote:
>>>>> On Fri, Jan 8, 2021 at 1:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>
>>>>>> On 1/7/21 9:42 AM, Claire Chang wrote:
>>>>>>
>>>>>>>> Can you explain how ATF gets involved and to what extent it does help,
>>>>>>>> besides enforcing a secure region from the ARM CPU's perpsective? Does
>>>>>>>> the PCIe root complex not have an IOMMU but can somehow be denied access
>>>>>>>> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
>>>>>>>> still some sort of basic protection that the HW enforces, right?
>>>>>>>
>>>>>>> We need the ATF support for memory MPU (memory protection unit).
>>>>>>> Restricted DMA (with reserved-memory in dts) makes sure the predefined memory
>>>>>>> region is for PCIe DMA only, but we still need MPU to locks down PCIe access to
>>>>>>> that specific regions.
>>>>>>
>>>>>> OK so you do have a protection unit of some sort to enforce which region
>>>>>> in DRAM the PCIE bridge is allowed to access, that makes sense,
>>>>>> otherwise the restricted DMA region would only be a hint but nothing you
>>>>>> can really enforce. This is almost entirely analogous to our systems then.
>>>>>
>>>>> Here is the example of setting the MPU:
>>>>> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
>>>>>
>>>>>>
>>>>>> There may be some value in standardizing on an ARM SMCCC call then since
>>>>>> you already support two different SoC vendors.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> On Broadcom STB SoCs we have had something similar for a while however
>>>>>>>> and while we don't have an IOMMU for the PCIe bridge, we do have a a
>>>>>>>> basic protection mechanism whereby we can configure a region in DRAM to
>>>>>>>> be PCIe read/write and CPU read/write which then gets used as the PCIe
>>>>>>>> inbound region for the PCIe EP. By default the PCIe bridge is not
>>>>>>>> allowed access to DRAM so we must call into a security agent to allow
>>>>>>>> the PCIe bridge to access the designated DRAM region.
>>>>>>>>
>>>>>>>> We have done this using a private CMA area region assigned via Device
>>>>>>>> Tree, assigned with a and requiring the PCIe EP driver to use
>>>>>>>> dma_alloc_from_contiguous() in order to allocate from this device
>>>>>>>> private CMA area. The only drawback with that approach is that it
>>>>>>>> requires knowing how much memory you need up front for buffers and DMA
>>>>>>>> descriptors that the PCIe EP will need to process. The problem is that
>>>>>>>> it requires driver modifications and that does not scale over the number
>>>>>>>> of PCIe EP drivers, some we absolutely do not control, but there is no
>>>>>>>> need to bounce buffer. Your approach scales better across PCIe EP
>>>>>>>> drivers however it does require bounce buffering which could be a
>>>>>>>> performance hit.
>>>>>>>
>>>>>>> Only the streaming DMA (map/unmap) needs bounce buffering.
>>>>>>
>>>>>> True, and typically only on transmit since you don't really control
>>>>>> where the sk_buff are allocated from, right? On RX since you need to
>>>>>> hand buffer addresses to the WLAN chip prior to DMA, you can allocate
>>>>>> them from a pool that already falls within the restricted DMA region, right?
>>>>>>
>>>>>
>>>>> Right, but applying bounce buffering to RX will make it more secure.
>>>>> The device won't be able to modify the content after unmap. Just like what
>>>>> iommu_unmap does.
>>>>
>>>> Sure, however the goals of using bounce buffering equally applies to RX
>>>> and TX in that this is the only layer sitting between a stack (block,
>>>> networking, USB, etc.) and the underlying device driver that scales well
>>>> in order to massage a dma_addr_t to be within a particular physical range.
>>>>
>>>> There is however room for improvement if the drivers are willing to
>>>> change their buffer allocation strategy. When you receive Wi-Fi frames
>>>> you need to allocate buffers for the Wi-Fi device to DMA into, and that
>>>> happens ahead of the DMA transfers by the Wi-Fi device. At buffer
>>>> allocation time you could very well allocate these frames from the
>>>> restricted DMA region without having to bounce buffer them since the
>>>> host CPU is in control over where and when to DMA into.
>>>>
>>>
>>> That is, however, still a trade-off between saving that one copy and
>>> protection from the DMA tampering with the packet contents when the
>>> kernel is reading them. Notice how the copy effectively makes a
>>> snapshot of the contents, guaranteeing that the kernel has a
>>> consistent view of the packet, which is not true if the DMA could
>>> modify the buffer contents in the middle of CPU accesses.
>>
>> I would say that the window just became so much narrower for the PCIe
>> end-point to overwrite contents with the copy because it would have to
>> happen within the dma_unmap_{page,single} time and before the copy is
>> finished to the bounce buffer.
> 
> Not only. Imagine this:
> 
> a) Without bouncing:
> 
> - RX interrupt
> - Pass the packet to the network stack
> - Network stack validates the packet
> - DMA overwrites the packet
> - Network stack goes boom, because the packet changed after validation
> 
> b) With bouncing:
> 
> - RX interrupt
> - Copy the packet to a DMA-inaccessible buffer
> - Network stack validates the packet
> - Network stack is happy, because the packet is guaranteed to stay the
> same after validation

Yes that's a much safer set of operations, thanks for walking through a
practical example.
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
