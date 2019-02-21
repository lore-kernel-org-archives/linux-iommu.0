From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V4 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Date: Thu, 21 Feb 2019 17:00:53 +0000
Message-ID: <DM5PR2101MB0918F78D1E8682FF545519F8D77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org
List-Id: iommu@lists.linux-foundation.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
>=20
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
>=20
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v2:
>        - Fix compile error due to x2apic_phys
>        - Fix comment indent
> Change since v1:
>        - Remove redundant extern for x2apic_phys
>=20
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
