From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [Resend PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver
 to support x2apic mode
Date: Tue, 26 Feb 2019 21:24:37 +0800
Message-ID: <CAOLK0pzrnukw8jPpO_aFT6SeXDopK1KespFPogQKBf-kjs6N9A@mail.gmail.com>
References: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com> <20190226130741.GD32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226130741.GD32526@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <sashal@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, mchehab+samsung@kernel.org, davem@davemloft.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>, michael.h.kelley@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, Lan Tianyu <Tianyu.Lan@microsoft.com>, devel@linuxdriverproject.org, iommu@lists.linux-foundation.org, linux-kernel@vger kerne
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 9:07 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Feb 26, 2019 at 08:07:17PM +0800, lantianyu1986@gmail.com wrote:
> > Lan Tianyu (3):
> >   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is
> >      available
> >   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
> >   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
> >     scope
>
> Applied (patch 2 with slight subject changes
> 'HYPERV/IOMMU' -> 'iommu/hyper-v'), thanks.

Great. Thanks.

-- 
Best regards
Tianyu Lan
