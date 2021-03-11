Return-Path: <SRS0=X4VR=IJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F624C433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 05:04:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A279164FC9
	for <iommu@archiver.kernel.org>; Thu, 11 Mar 2021 05:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A279164FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48EDB83E23;
	Thu, 11 Mar 2021 05:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 42ZoRtH8dQVM; Thu, 11 Mar 2021 05:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09EA683508;
	Thu, 11 Mar 2021 05:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9918C000B;
	Thu, 11 Mar 2021 05:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 415DEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 05:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EF02605C8
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 05:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKWAc1j_m6ZN for <iommu@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 05:04:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AB4260666
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 05:04:48 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id a24so9612784plm.11
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eayOjb0KZ31qj1N8PdToC+xRVUBfCHUPI3Znks8WR0k=;
 b=IL1N7vM7p9PzFcfpvhgRRMuOzhmjBlfibWkIcOQbYlGbPOJMnLhIzjCy8LxBaJ8EGU
 KJjjEgkbLtjbaD4sqhZ1ochG6cVFghEOlubEd7dsbfPijX8lC9eVqiLaeiTO3VXqhE5j
 YprOjLc8isTrNz1yxLNXa7sz1Bhn0z1t0w+HJ0pPJUXLLao5DKoPWk0aWURYin4FB6OE
 oTFCyRJLtkVFf3JLLGhSJTXk7wLVT433snzVLTFp5sM2sqXb87myqAsWS9pqaTfVDExL
 f+ojkMFllNvYboAo4xsrXYacF/clYDZcJc779Ph0MFvl0b3brsNawqyYAhHoxSZKsU/v
 mTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eayOjb0KZ31qj1N8PdToC+xRVUBfCHUPI3Znks8WR0k=;
 b=HTzkcBBVTfxMPBJ1CaF6gYaPort4dL/IyTdsyncWumiziIaVb6QqNwAW6lCGI7l9jX
 b+rAPg8dGUdYnCTk1NF2tDLc1MaB1H8+VZ4POCEVqaQ1Qa1hKUVbXza/6WoQ7f9LKcOz
 AZYCZb1U42CIc5jJPsstUxla1SKffpl+I7z7iaredMYxX7p9stOiGRCznNggxxZ6FH7o
 8+HACygrJOIE88Czy2DjpTW3yXrYLNmHqUO8qDZnRLSpkoyPlPxGnV+KTxoXohH5JPTp
 ILwEratx3VrvPAd5NbqgYVLB9VYxImW7XMFRRCIQK7lGeKYmbfkg2x9fuAffV78KPX/G
 iITA==
X-Gm-Message-State: AOAM530fpVSAUpzO450UMcUXMRBpfdTwU3B/GOqqisolZp64aAh1lnwF
 kf1MUUFBAHE+EJqTOCEWLkQ=
X-Google-Smtp-Source: ABdhPJzomvd6XDgwv/fL+vlX+FLEQgGyCWkzPbL90UL/BQndPGhzKH0Q4L/hjqK/fMjpcf3zxKU3vg==
X-Received: by 2002:a17:90a:a403:: with SMTP id
 y3mr7078020pjp.227.1615439087609; 
 Wed, 10 Mar 2021 21:04:47 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y2sm979638pgf.7.2021.03.10.21.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Mar 2021 21:04:47 -0800 (PST)
Subject: Re: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
To: Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-14-tientzu@chromium.org>
 <20210310160747.GA29834@willie-the-truck>
 <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a5a684fe-5ed0-a12f-22ca-a8ba46124341@gmail.com>
Date: Wed, 10 Mar 2021 21:04:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
Content-Language: en-US
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Grant Likely <grant.likely@arm.com>, Paul Mackerras <paulus@samba.org>,
 Frank Rowand <frowand.list@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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



On 3/10/2021 1:40 PM, Rob Herring wrote:
> On Wed, Mar 10, 2021 at 9:08 AM Will Deacon <will@kernel.org> wrote:
>>
>> Hi Claire,
>>
>> On Tue, Feb 09, 2021 at 02:21:30PM +0800, Claire Chang wrote:
>>> Introduce the new compatible string, restricted-dma-pool, for restricted
>>> DMA. One can specify the address and length of the restricted DMA memory
>>> region by restricted-dma-pool in the reserved-memory node.
>>>
>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>> ---
>>>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> index e8d3096d922c..fc9a12c2f679 100644
>>> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>>>            used as a shared pool of DMA buffers for a set of devices. It can
>>>            be used by an operating system to instantiate the necessary pool
>>>            management subsystem if necessary.
>>> +        - restricted-dma-pool: This indicates a region of memory meant to be
>>> +          used as a pool of restricted DMA buffers for a set of devices. The
>>> +          memory region would be the only region accessible to those devices.
>>> +          When using this, the no-map and reusable properties must not be set,
>>> +          so the operating system can create a virtual mapping that will be used
>>> +          for synchronization. The main purpose for restricted DMA is to
>>> +          mitigate the lack of DMA access control on systems without an IOMMU,
>>> +          which could result in the DMA accessing the system memory at
>>> +          unexpected times and/or unexpected addresses, possibly leading to data
>>> +          leakage or corruption. The feature on its own provides a basic level
>>> +          of protection against the DMA overwriting buffer contents at
>>> +          unexpected times. However, to protect against general data leakage and
>>> +          system memory corruption, the system needs to provide way to lock down
>>> +          the memory access, e.g., MPU.
>>
>> As far as I can tell, these pools work with both static allocations (which
>> seem to match your use-case where firmware has preconfigured the DMA ranges)
>> but also with dynamic allocations where a 'size' property is present instead
>> of the 'reg' property and the kernel is responsible for allocating the
>> reservation during boot. Am I right and, if so, is that deliberate?
> 
> I believe so. I'm not keen on having size only reservations in DT.
> Yes, we allowed that already, but that's back from the days of needing
> large CMA carveouts to be reserved early in boot. I've read that the
> kernel is much better now at contiguous allocations, so do we really
> need this in DT anymore?

I would say yes, there can be a number of times where you want to semi
statically partition your physical memory and their reserved regions. Be
it to pack everything together under the same protection rules or
because you need to allocate memory from a particular address range in
say a non-uniform memory controller architecture where address windows
have different scheduling algorithms.
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
