From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Date: Thu, 31 Jan 2019 20:02:51 +0800
Message-ID: <CAOLK0py-5AmLwEtLveFAKnM_=hnjsCL18vdAk0n6_NPPyB20bA@mail.gmail.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
 <20190131115756.GA19969@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190131115756.GA19969@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, sthemmin@microsoft.com, akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, davem@davemloft.net, devel@linuxdriverproject.org, Joerg Roedel <joro@8bytes.org>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, nicolas.ferre@microchip.com, michael.h.kelley@microsoft.com, vkuznets@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>, mchehab+samsung@kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, haiyangz@microsoft.com
List-Id: iommu@lists.linux-foundation.org

Hi Greg:
             Thanks for your review.

On Thu, Jan 31, 2019 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > set x2apic destination mode to physcial mode when x2apic is available
> > and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> > 8-bit APIC id.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index e81a2db..9d62f33 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -36,6 +36,8 @@
> >  struct ms_hyperv_info ms_hyperv;
> >  EXPORT_SYMBOL_GPL(ms_hyperv);
> >
> > +extern int x2apic_phys;
>
> Shouldn't this be in a .h file somewhere instead?

You are right. I should use <asm/apic.h> here. Thanks.

> thanks,
>
> greg k-h



-- 
Best regards
Tianyu Lan
