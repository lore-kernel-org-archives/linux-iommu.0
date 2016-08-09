From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 02/11] genirq/msi: msi_compose wrapper
Date: Tue, 9 Aug 2016 11:19:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1608091117250.5388@nanos>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com> <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, yehuday@marvell.com, Manish.Jaggi@caviumnetworks.com, robert.richter@caviumnetworks.com, dennis.chen@arm.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 2 Aug 2016, Eric Auger wrote:

> Currently the MSI message is composed by directly calling
> irq_chip_compose_msi_msg and erased by setting the memory to zero.
> 
> On some platforms, we will need to complexify this composition to
> properly handle MSI emission through IOMMU. Also we will need to track
> when the MSI message is erased.

I just can't find how you do that. After applying the series the

> +	if (erase)
> +		memset(msg, 0, sizeof(*msg));

branch is still just a memset(). The wrapper is fine for the compose side, but
having the extra argument just to wrap the memset() for no gain is silly.

Thanks,

	tglx
