From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [Resend PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU
 driver to support x2apic mode
Date: Tue, 26 Feb 2019 14:07:41 +0100
Message-ID: <20190226130741.GD32526@8bytes.org>
References: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551182840-15069-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com, Lan Tianyu <Tianyu.Lan@microsoft.com>, devel@linuxdriverproject.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2019 at 08:07:17PM +0800, lantianyu1986@gmail.com wrote:
> Lan Tianyu (3):
>   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
>      available
>   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
>   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
>     scope

Applied (patch 2 with slight subject changes
'HYPERV/IOMMU' -> 'iommu/hyper-v'), thanks.
