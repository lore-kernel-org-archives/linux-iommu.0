From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH V6 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Date: Thu, 28 Feb 2019 11:14:29 +0100
Message-ID: <20190228101429.GA6303@8bytes.org>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com, Lan Tianyu <Tianyu.Lan@microsoft.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 27, 2019 at 10:54:02PM +0800, lantianyu1986@gmail.com wrote:
> Lan Tianyu (3):
>   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
>      available
>   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
>   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
>     scope

Okay, replaced the patches in the iommu-tree by these patches. Please
send future fixes on-top of the hyper-v branch in the iommu tree. Also
note that I am going to exclude this branch from my next pull-request in
case more issues are found.

Regards,

	Joerg
