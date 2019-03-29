From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
Date: Fri, 29 Mar 2019 15:43:23 -0600
Message-ID: <6a41d1f8-4be6-40d6-e30d-71abf70f4468@deltatee.com>
References: <20190328225925.241998-1-jannh@google.com>
 <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
 <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
 <3275e86a-5b12-29ff-9b1f-d8eba099ae98@deltatee.com>
 <CAG48ez1e=vHZqRp7=rQCvOjJnHjQtR5wQKZ69jOAZChto7RDCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG48ez1e=vHZqRp7=rQCvOjJnHjQtR5wQKZ69jOAZChto7RDCA@mail.gmail.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, iommu@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-03-29 3:40 p.m., Jann Horn wrote:
> So what is the right thing to do in the context of
> arch/x86/kernel/pci-calgary_64.c? That code wants to perform MMIO with
> endianness conversion, and these accesses are always performed as
> MMIO. Using the non-atomic 64-bit I/O helpers for this would be kind
> of awkward, since the accesses would never actually be split...

Well, if you know you're only ever doing MMIO, you'd probably just want
to use readq() directly.

Logan
