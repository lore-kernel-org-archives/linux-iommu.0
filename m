Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6038EC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 05:32:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2C322581
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 05:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2C322581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jonmasters.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A26285C63;
	Mon, 25 Jan 2021 05:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9upRcqiRZgbJ; Mon, 25 Jan 2021 05:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C724285C4F;
	Mon, 25 Jan 2021 05:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC29CC08A1;
	Mon, 25 Jan 2021 05:32:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9E1C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 05:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A04B85C63
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 05:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tH5zLZxP6x0O for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 05:32:23 +0000 (UTC)
X-Greylist: delayed 00:05:12 by SQLgrey-1.7.6
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8961985C54
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 05:32:23 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id n14so919787qvg.5
 for <iommu@lists.linux-foundation.org>; Sun, 24 Jan 2021 21:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GKTBOeeUx6wXeRV6P9Jfat4kGoUSJVEmxQdNQfrFvYE=;
 b=j695vV5wc3nWbcMyhTthhn8OdI8FeBU0NIYpfGjClWPlG3p0NydLWU3g8ZsUMYwpBb
 KW2JNRKyHSLj5NbF3zgv98LTNXR/FI39adb5P8g5Ov78xV8+1I3sJLAx/58VQjev1KK9
 XKN6U58W3kDgBuh9ixEWML+5uiYTRljv9/vcApapM+BuN0SafT8eT2cq36/M2Nhx4pOJ
 J+dP+esVrOb1dc6faQd7ITFMjpT86ScCGU+zUJalRsk7qImxfM17ctgNIbj4tyIuQypR
 1Iiztz5jbMamKVvZAj8X7V/REhVlSgRHspm0lD1mMncTqhuBLErXKvrpx0VXyNdgEZ0T
 x3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GKTBOeeUx6wXeRV6P9Jfat4kGoUSJVEmxQdNQfrFvYE=;
 b=NK5dHEFfsDVIis4fx067OzZ/s75gSkkExhYrIh0gvfXdUyCGLBTc/LmmG6PpwFMGUF
 4ZLhH5Bb7zSqo6W+/BTDGoP9CAcEpFxu+phztjRdQLChKiXDKb6s3qeh2YBo2x7fRF/q
 VKtAgIxElbYuZcnxM8ukdWhoUAMoHcvm38CfP3h1MhlGYNXurr9vt7kDTwtQYG6dXy9n
 +Fz1CUhP+4q7lHdYzcTaGB7chRyJXwPbRtYVTjGi4wgWLEqjnzZhkMhzxZIFGeZx6jP2
 2OMz1jn8lyQTtczy89BlmGmhvzmLOvXVW4ZI5x8FlQQXO1ry/99SFBKdJJbjYBLu/D6e
 +ccA==
X-Gm-Message-State: AOAM5337oMTSVrIIOiqI7LBMqP/aGzn0oVuiDdTqLb/1/fbYWHWMM/qw
 jl9sXmQCEhkl/i1xlUUFCYye7rldwGmp7UrL
X-Google-Smtp-Source: ABdhPJx6twpOFiNUXkHrytF4tAaeP9jbL+fIEfsueCOWmVBETzURbZy1jFgpbjKAN/zJfi4NlaTIRA==
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr6025332qvb.4.1611552430534;
 Sun, 24 Jan 2021 21:27:10 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org.
 [50.195.43.97])
 by smtp.gmail.com with ESMTPSA id x49sm10447908qth.95.2021.01.24.21.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 21:27:09 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To: Florian Fainelli <f.fainelli@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Claire Chang <tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <20210106185241.GA109735@localhost.localdomain>
 <CALiNf2-HDf6tFcvVgCttr-ta=88ZMH=OvB5XoryTPc6MNvwV+Q@mail.gmail.com>
 <20210107175740.GA16519@char.us.oracle.com>
 <aa5af7d1-779e-f0f6-e6ba-8040e603523f@gmail.com>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <a843a970-afec-6541-c54b-4bc2a3c4750a@jonmasters.org>
Date: Mon, 25 Jan 2021 00:26:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aa5af7d1-779e-f0f6-e6ba-8040e603523f@gmail.com>
Content-Language: en-US
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 paulus@samba.org, will@kernel.org, Christoph Hellwig <hch@lst.de>,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 Frank Rowand <frowand.list@gmail.com>, rafael.j.wysocki@intel.com,
 mingo@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, dan.j.williams@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, xypron.glpk@gmx.de,
 linuxppc-dev@lists.ozlabs.org
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

On 1/7/21 1:09 PM, Florian Fainelli wrote:
> On 1/7/21 9:57 AM, Konrad Rzeszutek Wilk wrote:
>> On Fri, Jan 08, 2021 at 01:39:18AM +0800, Claire Chang wrote:
>>> Hi Greg and Konrad,
>>>
>>> This change is intended to be non-arch specific. Any arch that lacks DMA access
>>> control and has devices not behind an IOMMU can make use of it. Could you share
>>> why you think this should be arch specific?
>>
>> The idea behind non-arch specific code is it to be generic. The devicetree
>> is specific to PowerPC, Sparc, and ARM, and not to x86 - hence it should
>> be in arch specific code.
> 
> In premise the same code could be used with an ACPI enabled system with
> an appropriate service to identify the restricted DMA regions and unlock
> them.
> 
> More than 1 architecture requiring this function (ARM and ARM64 are the
> two I can think of needing this immediately) sort of calls for making
> the code architecture agnostic since past 2, you need something that scales.
> 
> There is already code today under kernel/dma/contiguous.c that is only
> activated on a CONFIG_OF=y && CONFIG_OF_RESERVED_MEM=y system, this is
> no different.

<unrelated to these patches, which are useful for the case cited>

Just a note for history/archives that this approach would not be 
appropriate on general purpose Arm systems, such as SystemReady-ES 
edge/non-server platforms seeking to run general purpose distros. I want 
to have that in the record before someone at Arm (or NVidia, or a bunch 
of others that come to mind who have memory firewalls) gets an idea.

If you're working at an Arm vendor and come looking at this later 
thinking "wow, what a great idea!", please fix your hardware to have a 
real IOMMU/SMMU and real PCIe. You'll be pointed at this reply.

Jon.

-- 
Computer Architect
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
