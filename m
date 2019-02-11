From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH V3 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Date: Mon, 11 Feb 2019 16:05:23 +0800
Message-ID: <CAOLK0pwdQGeyKYYkUbZtizR5+ydf-KAp1=+z3s+LfMnjhS1Enw@mail.gmail.com>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
 <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, mchehab+samsung@kernel.org, Sasha Levin <sashal@kernel.org>, sthemmin@microsoft.com, Joerg Roedel <joro@8bytes.org>, the arch/x86 maintainers <x86@kernel.org>, michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Lan Tianyu <Tianyu.Lan@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, haiyangz@microsoft.com, Alex Williamson <alex.williamson@redhat.com>, bp@alien8.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org, devel@linuxdriverproject.org, Vitaly Kuznetsov <vkuznets@redhat.com>, davem@davemloft.net
List-Id: iommu@lists.linux-foundation.org

Hi Thomas:
          Thanks for your review.

On Mon, Feb 11, 2019 at 5:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 7 Feb 2019, lantianyu1986@gmail.com wrote:
>
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > set x2apic destination mode to physcial mode when x2apic is available
> > and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> > 8-bit APIC id.
>
> This looks good now. Can that be applied independent of the IOMMU stuff or
> should this go together. If the latter:
>
>    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> If not, I just queue if for 5.1. Let me know,
>

This patch can be applied independently. Thanks.
-- 
Best regards
Tianyu Lan
