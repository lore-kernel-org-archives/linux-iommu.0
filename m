Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1E21A44A
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410491; cv=none; b=VECky6n4xXvfaPhHv61TJ1XMDSRbchL0Xmg4DixYrK31675UzF4ZsvHz7ncKxQgZrMK+JuXd6scK8db5XwNe2Wc5NBH/NqSIymoVsQG2HFvwoxo93Lt7aetdcKCMOcpwZCiotBvyIV8x9QOu6xvzTxFqm47hFKvL+hWvCPcHJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410491; c=relaxed/simple;
	bh=f8tH5F+wtgbza7viG4IOdVZJiWD//+m8I2XaKnLqIkM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C4AeIoxg7iEMNDgYkw/PjlmfKXXBKtd+OH5Ybxc8dfWv5ffF4VqXerVD1XbTbOGYnMUo9VB9lpIL0osDsYG28JHzgBw+K/WaVFARaErneZD1Gpp0k9RmKs8DhlkiZwplpOBbEYl6M8uJ6SlmNXINZwvrvsxmxj4gZZVfMmpZVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tJDFe-0008Hp-Hr; Thu, 05 Dec 2024 15:54:46 +0100
Message-ID: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de>
Date: Thu, 5 Dec 2024 15:54:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kasan-dev@googlegroups.com, iommu@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, elver@google.com, Kees Cook <keescook@chromium.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Using KASAN to catch streaming DMA API violations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

Hello,

This is a follow-up to a discussion that took place in the Kernel Sanitizers
Office Hours (IIRC) at this year's Plumbers Event in Vienna.

I had asked about how KCSAN could detect races due to DMA[1] and Arnd
suggested that we could use KASAN to detect the CPU accessing buffers that
it doesn't have ownership of. I mentioned having implemented[2] this exact scheme
in the barebox bootloader's KASAN support and promised to type up an email
about it to help getting a similar functionality into the kernel, but first
some context:

The streaming DMA API is used to annotate ownership transfer of buffers in
memory shared between the kernel and a DMA-capable device.

The relevant kernel documentation is:

  https://www.kernel.org/doc/Documentation/DMA-API.txt
  https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt

But I'll give a quick recap. There are four key operations:

 - dma_map_single() moves a range of memory from CPU to device ownership

 - dma_sync_single_for_cpu() can be called on all or a subset of the range
   mapped by dma_map_single() to move ownership back to the CPU

 - dma_sync_single_for_device() moves back all oo a subset of the range
   mapped by dma_map_single() to the ownership of the device

 - dma_unmap_single() gives back ownership of a range of memory to the CPU

It's a bug for the CPU or the device to access a streaming DMA mapping while
it's owned by the other side. On many systems, that bug will manifest itself
as memory corruption due to loss of cache coherence.

To make it easier to spot some misuses of the API, the kernel has a
CONFIG_DMA_API_DEBUG feature, which will run sanity checks when using the API.
It can't however detect if a memory access happens to a buffer while it's
owned by other side, which is where KASAN can come in by having CONFIG_DMA_API_DEBUG
record ownership information into the KASAN shadow memory.

That way accessing a device mapped buffer before sync'ing it to the CPU is
detected like KASAN would detect a use-after-free.  When the ownership is moved
back to the CPU, the memory is unpoisoned and such an access would be allowed
again.

I had implemented this scheme[3] in the barebox bootloader and it works ok:

  BUG: KASAN: dma-mapped-to-device in eqos_send+0xdc/0x1a8
  Read of size 4 at addr 0000000040419f00

  Call trace:
  [<7fbd4980>] (unwind_backtrace+0x0/0xb0) from [<7fbd4a40>] (dump_stack+0x10/0x18)
  [<7fbd4a40>] (dump_stack+0x10/0x18) from [<7fba2360>] (kasan_report+0x11c/0x290)
  [<7fba2360>] (kasan_report+0x11c/0x290) from [<7fba1f44>] (__asan_load4+0x54/0xb8)
  [<7fba1f44>] (__asan_load4+0x54/0xb8) from [<7fb2e52c>] (eqos_send+0xdc/0x1a8)
  [<7fb2e52c>] (eqos_send+0xdc/0x1a8) from [<7fbb6544>] (eth_send+0x154/0x16c)
  [<7fbb6544>] (eth_send+0x154/0x16c) from [<7fbb7114>] (net_ip_send+0xe8/0xf8)
  [<7fbb7114>] (net_ip_send+0xe8/0xf8) from [<7fbb7d10>] (net_udp_send+0x68/0x78)


The aforementioned barebox functionality goes a step further and also used
the shadow memory information to detect repeated syncs without an ownership
change. While this is not a bug, my impression is that this is unnecessary
overhead and a diagnostic could help correct a developer's misunderstanding
of the API.

I hope to kick off a discussion about this with my mail here and perhaps even
motivate someone else to port it over or reimplement it. :D

[1]: when CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is enabled
[2]: https://lore.barebox.org/barebox/20240910114832.2984195-1-a.fatoum@pengutronix.de/
[3]: https://github.com/barebox/barebox/blob/master/drivers/dma/debug.c

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

