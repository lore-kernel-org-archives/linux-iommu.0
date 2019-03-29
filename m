From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
Date: Fri, 29 Mar 2019 15:32:07 -0600
Message-ID: <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
References: <20190328225925.241998-1-jannh@google.com>
 <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
 <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>, Mukesh Ojha <mojha@codeaurora.org>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, iommu@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-03-29 3:19 p.m., Jann Horn wrote:
>>> Can the existing api's not be used here like iowrite64be/ioread64be/ or
>>> similar variant in "include/asm-generic/io.h"
>>
>> Oooh! I didn't realize that those exist. I'll change that and send a v2.
Yes, they are very new! It took me a while to get those patches in as it
is a bit more complicated than it seems.

> Actually, that doesn't work at the moment on x86-64:
> 
> include/asm-generic/io.h only defines these things if
> CONFIG_GENERIC_IOMAP isn't defined; and X86 unconditionally defines
> it. With CONFIG_GENERIC_IOMAP set, these functions are provided by
> include/asm-generic/iomap.h.

For CONFIG_GENERIC_IOMAP, lib/iomap.c provides _lo_hi and _hi_lo
implementations seeing the pio regions must be emulated with 32bit
operations and we have to define the order.

> The definitions for these are in lib/iomap.c, except that there are no
> definitions for ioread64be() and iowrite64be(); if you try to use
> them, you get linker errors.

Some platforms implement these but most do not. If I recall correctly
only powerpc does.

If you want to use 64 bit operations in a portable fashion, you should
include "linux/io-64-nonatomic-hi-lo.h" or
"linux/io-64-nonatomic-lo-hi.h", depending on weather you want the lower
bits or the higher bits to be written or read first in cases where an
atomic operation is not available.

Logan
