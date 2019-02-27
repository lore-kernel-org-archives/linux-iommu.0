From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V6 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Date: Wed, 27 Feb 2019 17:30:27 +0000
Message-ID: <DM5PR2101MB091823BD2059EF420F4EFF4CD7740@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "davem@davemloft.net" <davem@davemloft.net>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, vkuznets <vkuznets@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: Tianyu Lan <lantianyu1986@gmail.com> Sent: Wednesday, February 27, 2019 6:54 AM
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v5:
>        - Fix comile error due to x2apic_phys
> 
> Change since v2:
>        - Fix compile error due to x2apic_phys
>        - Fix comment indent
> Change since v1:
>        - Remove redundant extern for x2apic_phys
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reconfirming my reviewed-by after the change to fix the
compile error detected by the kbuild test robot.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
