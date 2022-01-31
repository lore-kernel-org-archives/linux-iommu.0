Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3261BC433EF
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 15:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0C56408F4;
	Mon, 31 Jan 2022 15:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rj30okA_aEOi; Mon, 31 Jan 2022 15:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AA964038E;
	Mon, 31 Jan 2022 15:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1EDC001A;
	Mon, 31 Jan 2022 15:22:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31816C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F1F0408EB
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAXOPLsTJHSu for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 15:21:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED8B44038E
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 15:21:57 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id x193so27371257oix.0
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=oVZWckNIPsWHeKbXJ2sFvACBl5okPcSAEIsKC6XhxDU=;
 b=NXQ2vh5WqJcNrwvi+uhxOeXRwL3TuQvr8zI74nXKNlbA4THVcrFQe20l84a2F3rCSl
 fb+2O3VmewcReatZ19klOskQ2upf6qljRrD6n2B9Y4PhroYWW+XOfsdsfB3MZuirxQ9t
 X+vPYa1ikH13JYbnSKqVdMeH1jmxa4D6k59/FHZubOFHJbDfNxiaB8VfMIjtaMgLtJV+
 3A2GEeuqlrodVHjFD7y9lvjUf+N31nBGTmFabP1WX1nvXw95IBSd2qgNRGX0BxRvAmns
 3J8DZp0qcC/r7rrsLbS0TgQNcR7BR3VDw0NU5D6j9PO9dXHpEDeoVqLmRligf9NcdWA6
 MSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=oVZWckNIPsWHeKbXJ2sFvACBl5okPcSAEIsKC6XhxDU=;
 b=yjGLUG0r8Z6wa3NHK3fwDcuy1Yco/tcUzpAWnSMEG08RSboSeJig6kjRUOgsbcI6HY
 CUoxLaUnXdId+PZ9at/NM3AGu2OKjqEsdi50bkS5HYaIHw5KxGjb9kjiKgh+b0/KZgx2
 FfSwMAoBymrxCJszuxK54g+HYhddqkG/KxaBrXSMlki6euKuU1D5rQvjDXZkJxafriB0
 hGyA4DFFdk4guuP9vctVhH6KRoDIU77OEBQifgIkUOYiWc22wU9iG7WoLJWCiD+YrlyO
 3KGczywaXumleWsuKkM+nG0fO8jZDzCZMVbuOGhrEH+9naMhyrTmquEJk31PkiEfJKzs
 7vhw==
X-Gm-Message-State: AOAM5304BnpbGVdDdjOm/c/8zg7bj5Z4q4Nu00JhT/3eoz/Kh1+l7HTX
 vz8LUsYtEJZgZsU5GAMoIcEAx31/w+3Q5Q==
X-Google-Smtp-Source: ABdhPJwZ2DsfGoZh9WlCulrelJMyxXaQWZM7t1bPVVjVsAMl6JMrpJ5ac6K1xcqWaqkMGtPCEBWrHw==
X-Received: by 2002:a05:6808:211f:: with SMTP id
 r31mr12780920oiw.194.1643642506160; 
 Mon, 31 Jan 2022 07:21:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d65sm9789045otb.17.2022.01.31.07.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jan 2022 07:21:44 -0800 (PST)
Message-ID: <c78df469-1a9f-5778-24d1-8f08a6bf5bcc@roeck-us.net>
Date: Mon, 31 Jan 2022 07:21:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
References: <87mtjc2lhe.ffs@tglx>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <87mtjc2lhe.ffs@tglx>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
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

On 1/31/22 03:27, Thomas Gleixner wrote:
> On Sun, Jan 30 2022 at 09:12, Guenter Roeck wrote:
>> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
>> This patch results in the following runtime warning when booting x86
>> (32 bit) nosmp images from NVME in qemu.
>>
>> [   14.825482] nvme nvme0: 1/0/0 default/read/poll queues
>> ILLOPC: ca7c6d10: 0f 0b
>> [   14.826188] ------------[ cut here ]------------
>> [   14.826307] WARNING: CPU: 0 PID: 7 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90
> 
> This complains about msi_desc->affinity being NULL.
> 
>> git bisect bad f48235900182d64537c6e8f8dc0932b57a1a0638
>> # first bad commit: [f48235900182d64537c6e8f8dc0932b57a1a0638] PCI/MSI: Simplify pci_irq_get_affinity()
> 
> Hrm. Can you please provide dmesg and /proc/interrupts from a
> kernel before that commit?
> 

Sure. Please see http://server.roeck-us.net/qemu/x86/.
The logs are generated with with v5.16.4.

Guenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
