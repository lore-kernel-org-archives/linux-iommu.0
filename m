From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
Date: Fri, 29 Mar 2019 17:48:38 +0100
Message-ID: <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, iommu@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
> On 3/29/2019 4:29 AM, Jann Horn wrote:
> > The sparse checker attempts to ensure that all conversions between
> > fixed-endianness numbers and numbers with native endianness are explicit.
> > However, the calgary code reads and writes big-endian numbers from/to IO
> > memory using {read,write}{l,q}(), which return native-endian numbers.
> >
> > This could be addressed by putting __force casts all over the place, but
> > that would kind of defeat the point of the warning. Instead, create new
> > helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
> > native endianness.
> >
> > Most of this patch is a straightforward conversion; the following parts
> > aren't just mechanical replacement:
> >
> >   - ->tar_val is now a native-endian number instead of big-endian
> >   - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
> >     intended to do `be32_to_cpu(readl(target))` (but that has no actual
> >     effects outside of type warnings)
> >
> > This gets rid of 108 lines of sparse warnings.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > compile-tested only
> >
> >   arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++-------------
> >   1 file changed, 64 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
> > index c70720f61a34..36cd66d940fb 100644
> > --- a/arch/x86/kernel/pci-calgary_64.c
> > +++ b/arch/x86/kernel/pci-calgary_64.c
> > @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short device)
> >       return (is_calgary(device) || is_calioc2(device));
> >   }
>
>
> Can the existing api's not be used here like iowrite64be/ioread64be/ or
> similar variant in "include/asm-generic/io.h"

Oooh! I didn't realize that those exist. I'll change that and send a v2.
